git clone https://github.com/wickedest/Mergely
cd Mergely
npm install bower uglify-js
BOWER=node_modules/.bin/bower
${BOWER} install

cat bower_components/mergely/lib/codemirror.css bower_components/mergely/lib/mergely.css > ../static/app.deps.css
echo 'var UglifyJS = require("uglify-js"); var result = UglifyJS.minify([ "bower_components/jquery/dist/jquery.min.js", "bower_components/mergely/lib/codemirror.js", "bower_components/mergely/lib/mergely.js"]); console.log(result.code);' | node > ../static/mergely.deps.min.js
cd ../
rm -r Mergely

