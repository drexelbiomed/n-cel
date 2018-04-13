var gulp        = require('gulp');
var sass        = require('gulp-sass');
var browserSync = require('browser-sync').create();

gulp.task('browserSync', function() {
    browserSync.init({
      proxy: {
        target: "http://localhost:4567"
      }
    })
  });

gulp.task('watch', ['browserSync', 'sass'], function() {
  gulp.watch('/Users/Dave/src/_shared/source/assets/stylesheets/*.css.scss', ['sass']);

  });

gulp.task('sass', function(){
  return gulp.src(['/Users/Dave/src/_shared/source/assets/stylesheets/modern.css.scss', '/Users/Dave/src/_shared/source/assets/stylesheets/legacy.css.scss'])
    .pipe(sass())
    .pipe(gulp.dest('.tmp'))
    .pipe(browserSync.reload({
      stream: true
      }))
  });

gulp.task('hello', function() {
  console.log("hello mello")
});