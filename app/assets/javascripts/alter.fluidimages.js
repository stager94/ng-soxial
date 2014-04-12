(function($){
	$.fn.plugin = function(reload) {

		var run = function(block) {
			var block_width = $(block).width();
			var images = $('img', block);
			var images_count = images.length;
			var max_height = $(block).attr("data-max-height");
			var large_min_row_height = 90;
			if (images_count > 0) {
				if (images_count >= 3) {
					var large_min_row_height = 90;
				}
				var medium_min_row_height = 90;
				var small_min_row_height = 90;
				var min_row_height = large_min_row_height;

				$(images).not("[data-loaded=true]").fadeOut(0);
				reset_styles(block);

				if (block_width < 460) {
					min_row_height = medium_min_row_height;	
				}
				if (block_width < 360) {
					min_row_height = small_min_row_height;
				}

				var rows = 0;
				while($("img[data-row=-1]", block).length > 0 && images_count > 1) {
					rows += 1;
					var t = true;
					var i = 0;
					var temp_height = $("img[data-row=-1]:first", block).parent('a').attr("data-height");
					var widths_sum = 0;
					var length = $("img[data-row=-1]", block).length;

					while (t == true && i < length) {
						var image = $("img[data-row=-1]", block)[0];
						var image_height = $(image).parent('a').attr("data-height");
						var image_width = $(image).parent('a').attr("data-width");
						var dimension = temp_height / image_height;
						var n_width = image_width * dimension;
						widths_sum += n_width;
						var global_dimension = block_width / widths_sum;
						var n_height = temp_height * global_dimension;
						if (n_height < min_row_height) {
							widths_sum -= n_width;
							t = false;
							if (widths_sum == 0) {
								$("img[data-row=-1]:first", block).attr("data-row", rows);
							}
						} else {
							$(image).attr({"data-row": rows});
						}
						i++;
					}
					var height = block_width / widths_sum * temp_height;
					$("img[data-row=" + rows + "]", block).each(function(index, image){
						var dimension = temp_height / $(image).parent('a').attr("data-height");
						var n_width = $(image).parent('a').attr("data-width") * dimension / widths_sum * 100;
						$(image).css({"min-height": height, "width": "100%"}).parent().css({"width": n_width+"%"});
					});
				}
				if ($("img[data-row=-1]", block).length > 0 && images_count == 1) {
					var image = $("img[data-row=-1]:first", block);
					var image_width = image.parent('a').attr("data-width");
					var image_height = image.parent('a').attr("data-height");
					console.log(image_width, image_height);
					if (image_width / image_height > 1.4) {
						image.css({"width": "100%"}).parent().css({"width": "100%"});;
					} else {
						image.addClass("alone");	
					}
				}

				$(block).css({"position": "initial", "display": "table", "overflow": "initial"});
				$(images).not("[data-loaded=true]").fadeTo("normal", 1).attr({"data-loaded": "true"});
				$(block).attr("data-fluid", true);
			}
		}

		var reset_styles = function(block) {
			$("img", block).css({"width": "", "height": "", "display": "initial"}).attr({"data-row": "-1"}).parent().attr({"style": ""});
			$(block).css({"position": "absolute", "max-height": 1, "display": "block", "overflow": "hidden"});
		}

		this.each(function(){
			if (reload == true) {
				console.log('1', $(this));
				run(this);
			} else {
				console.log('2', $(this).not("[data-fluid=true]"));
				run($(this).not("[data-fluid=true]"));
			}
		});
	}
})(jQuery);