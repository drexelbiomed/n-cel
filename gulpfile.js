var gulp        = require('gulp');
var sass        = require('gulp-sass');
var browserSync = require('browser-sync').create();
var assets      = "/Users/Dave/src/_shared/source/assets/"
var css         = assets + "stylesheets/"


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
