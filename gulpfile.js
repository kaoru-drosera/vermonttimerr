const gulp = require("gulp");

/* sass */
const sass = require("gulp-sass");
const plumber = require("gulp-plumber");
const notify = require("gulp-notify");
const sassGlob = require("gulp-sass-glob");
const mmq = require("gulp-merge-media-queries");
const gulpStylelint = require("gulp-stylelint");
const postcss = require("gulp-postcss");
const autoprefixer = require("autoprefixer");
const cssdeclsort = require("css-declaration-sorter");

/* browser-sync */
const browserSync = require("browser-sync");

/* imagemin */
const imagemin = require("gulp-imagemin");
const imageminPngquant = require("imagemin-pngquant");
const imageminMozjpeg = require("imagemin-mozjpeg");
const imageminOption = [
	imageminPngquant({ quality: [0.65, 0.8] }),
	imageminMozjpeg({ quality: 85 }),
	imagemin.gifsicle({
		interlaced: false,
		optimizationLevel: 1,
		colors: 256
	}),
	imagemin.mozjpeg(),
	imagemin.optipng(),
	imagemin.svgo()
];

gulp.task("sass", function() {
	return gulp
		.src("./sass/**/*.scss")
		.pipe(plumber({ errorHandler: notify.onError("Error: <%= error.message %>") }))
		.pipe(sassGlob())
		.pipe(sass({ outputStyle: "expanded" }))
		.pipe(postcss([autoprefixer()]))
		.pipe(postcss([cssdeclsort({ order: "alphabetical" })]))
		.pipe(mmq())
		.pipe(gulpStylelint())
		.pipe(gulp.dest("./css"));
});

gulp.task("watch", function(done) {
	gulp.watch("./sass/**/*.scss", gulp.task("sass"));
	gulp.watch("./sass/**/*.scss", gulp.task("bs-reload"));
	gulp.watch("./js/*.js", gulp.task("bs-reload"));
	gulp.watch("./*.html", gulp.task("bs-reload"));
});

gulp.task("browser-sync", function(done) {
	browserSync.init({
		server: {
			baseDir: "./",
			index: "index.html"
		}
	});
	done();
});

gulp.task("bs-reload", function(done) {
	browserSync.reload();
	done();
});

gulp.task("imagemin", function() {
	return gulp
		.src("./img/**/*")
		.pipe(imagemin(imageminOption))
		.pipe(gulp.dest("./img"));
});

gulp.task("default", gulp.series(gulp.parallel("browser-sync", "watch")));





// var gulp = require('gulp');
// var sass = require('gulp-sass'); //Sass???????????????
// var plumber = require('gulp-plumber'); //????????????????????????????????????
// var notify = require('gulp-notify'); //???????????????????????????????????????????????????
// var sassGlob = require('gulp-sass-glob'); //@import???????????????????????????
// var browserSync = require('browser-sync'); //??????????????????
// var postcss = require('gulp-postcss'); //autoprefixer????????????
// var autoprefixer = require('autoprefixer'); //???????????????????????????????????????
// var cssdeclsort = require('css-declaration-sorter'); //css????????????
// var imagemin = require('gulp-imagemin');
// var pngquant = require('imagemin-pngquant');
// var mozjpeg = require('imagemin-mozjpeg');
// var ejs = require("gulp-ejs");
// var rename = require("gulp-rename"); //.ejs?????????????????????
//
// // scss??????????????????
// gulp.task('sass', function() {
//   return gulp
//     .src('./src/scss/**/*.scss')
//     .pipe(plumber({
//       errorHandler: notify.onError("Error: <%= error.message %>")
//     })) //?????????????????????
//     .pipe(sassGlob()) //import?????????????????????????????????
//     .pipe(sass({
//       outputStyle: 'expanded' //expanded, nested, campact, compressed????????????
//     }))
//     .pipe(postcss([autoprefixer({
//       // ???IE???11?????????Android???4.4??????
//       // ??????????????????2???????????????????????????????????????????????????????????????????????????
//       "overrideBrowserslist": ["last 2 versions", "ie >= 11", "Android >= 4"],
//       cascade: false
//     })]))
//     .pipe(postcss([cssdeclsort({
//       order: 'alphabetically'
//     })])) //????????????????????????????????????(????????????????????????)
//     .pipe(gulp.dest('./src/css')); //??????????????????????????????
// });
//
// // ????????????????????????
// gulp.task('browser-sync', function(done) {
//   browserSync.init({
//
//     //??????????????????
//     server: {
//       baseDir: "./",
//       index: "index.html"
//     }
//   });
//   done();
// });
//
// gulp.task('bs-reload', function(done) {
//   browserSync.reload();
//   done();
// });
//
// gulp.task("ejs", (done) => {
//   gulp
//     .src(["ejs/**/*.ejs", "!" + "ejs/**/_*.ejs"])
//     .pipe(plumber({
//       errorHandler: notify.onError("Error: <%= error.message %>")
//     })) //?????????????????????
//     .pipe(rename({
//       extname: ".html"
//     })) //????????????html???
//     .pipe(gulp.dest("./")); //?????????
//   done();
// });
//
// // ??????
// gulp.task('watch', function(done) {
//   gulp.watch('./src/scss/**/*.scss', gulp.task('sass')); //sass?????????????????????gulp sass?????????
//   gulp.watch('./src/scss/**/*.scss', gulp.task('bs-reload')); //sass?????????????????????bs-reload?????????
//   gulp.watch('./src/js/*.js', gulp.task('bs-reload')); //js?????????????????????bs-relaod?????????
//   gulp.watch('./ejs/**/*.ejs', gulp.task('ejs')); //ejs?????????????????????gulp-ejs?????????
//   gulp.watch('./ejs/**/*.ejs', gulp.task('bs-reload')); //ejs?????????????????????bs-reload?????????
// });
//
// // default
// gulp.task('default', gulp.series(gulp.parallel('browser-sync', 'watch')));
//
// //??????????????????
// var imageminOption = [
//   pngquant({
//     quality: [70 - 85],
//   }),
//   mozjpeg({
//     quality: 85
//   }),
//   imagemin.gifsicle({
//     interlaced: false,
//     optimizationLevel: 1,
//     colors: 256
//   }),
//   imagemin.mozjpeg(),
//   imagemin.optipng(),
//   imagemin.svgo()
// ];
// // ???????????????
// // $ gulp imagemin???./src/img/base/????????????????????????????????????./src/img/???????????????
// // .gif???????????????????????????????????????
// gulp.task('imagemin', function() {
//   return gulp
//     .src('./src/img/base/*.{png,jpg,gif,svg}')
//     .pipe(imagemin(imageminOption))
//     .pipe(gulp.dest('./src/img'));
// });
