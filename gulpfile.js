var gulp        = require('gulp');
var paths       = {
  src: '/Users/Dave/src/_shared/source/assets/**/*',
  srcCSS: '/Users/Dave/src/_shared/source/assets/**/*.css',
  srcJS: '/Users/Dave/src/_shared/source/assets/**/*.js',

  tmp: '.tmp',
  tmpCSS: '.tmp/**/*.css',
  tmpJS: '.tmp/**/*.js',

  build: 'build',
  buildCSS: 'build/**/*.css',
  buildJS: 'build/**/*.js'
};

var sass        = require('gulp-sass');
var browserSync = require('browser-sync').create();


gulp.task('browserSync', function() {
    browserSync.init({
      proxy: {
        target: "localhost:4567"
      },
      reloadDelay: 2000,
      open: false
    })
  });

gulp.task('watch', ['browserSync', 'hello'], function() {
  gulp.watch();

  });

// gulp.task('sass', function(){
//   return gulp.src([css + 'modern.scss', css + 'legacy.scss'])
//     .pipe(sass())
//     .pipe(gulp.dest('.tmp/assets/stylesheets'))
//     .pipe(browserSync.reload({
//       stream: true
//       }))
//   });

gulp.task('hello', function() {
  console.log("hello mello")
});
