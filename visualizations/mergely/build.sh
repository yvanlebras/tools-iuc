git clone https://github.com/wickedest/Mergely
cd Mergely
npm install bower
BOWER=node_modules/.bin/bower
${BOWER} install

cat bower_components/mergely/lib/codemirror.css bower_components/mergely/lib/mergely.css > ../static/app.deps.css

cp bower_components/jquery/dist/jquery.min.js ../static
cp bower_components/mergely/lib/codemirror.js ../static
cp bower_components/mergely/lib/mergely.js ../static
cd ../
rm -r Mergely

