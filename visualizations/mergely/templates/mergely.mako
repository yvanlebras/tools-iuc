<%
    default_title = "Diff of '" + hda.name + "'"
    info = hda.name
    if hda.info:
        info += ' : ' + hda.info

    # Use root for resource loading.
    root = h.url_for( '/' )
    app_root    = root + "plugins/visualizations/mergely/static/"

%>
## ----------------------------------------------------------------------------

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1, IE=edge">
<meta name="description" content="Merge and Diff your documents with diff online and share" />
<meta name="keywords" content="diff,merge,compare,jsdiff,comparison,difference,file,text,unix,patch,algorithm,saas,longest common subsequence" />
<meta name="author" content="Jamie Peabody" />

<title>${title or default_title} | ${visualization_display_name}</title>

${h.javascript_link( app_root + 'mergely.deps.min.js' )}
${h.stylesheet_link( app_root + 'app.deps.css' )}


</head>

## ----------------------------------------------------------------------------
<body style="width: 100%;">
	<div id="mergely-resizer" style="height: 450px;">
		<div id="compare">
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function () {
			$('#compare').mergely({
				width: 'auto',
				height: 'auto', // containing div must be given a height
				cmsettings: { readOnly: false },
			});
			var lhs_url = 'lhs.txt';
			var rhs_url = 'rhs.txt'
			$.ajax({
				type: 'GET', async: true, dataType: 'text',
				url: lhs_url,
				success: function (response) {
					$('#path-lhs').text(lhs_url);
					$('#compare').mergely('lhs', response);
				}
			});
			$.ajax({
				type: 'GET', async: true, dataType: 'text',
				url: rhs_url,
				success: function (response) {
					$('#path-rhs').text(rhs_url);
					$('#compare').mergely('rhs', response);
				}
			});

			function checkFileList(files) {
				if (typeof window.FileReader !== 'function')
					error_msg("The file API isn't supported on this browser yet.");

				if (files.length>0) readFile(files[0], "lhs");
				if (files.length>1) readFile(files[1], "rhs");
			}

			function readFile(file, side) {
				var reader = new FileReader();
				reader.onload = function file_onload() {
					// document.getElementById('td1').innerHTML = ..
					$('#path-'+side).text(file.name);
					$('#compare').mergely(side, reader.result);
				}
				reader.readAsBinaryString(file);
			}
		});
	</script>
</body>
</html>
