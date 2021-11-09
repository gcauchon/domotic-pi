module.exports = {
  purge: [
    "./js/**/*.js",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    container: {
      padding: {
        default: '1rem',
        sm: '2rem',
        lg: '3rem',
        xl: '5rem'
      }
    },
    fontFamily: {
      sans: ['Raleway', 'Roboto', 'sans-serif'],
    }
  },
  variants: {},
  plugins: [],
}
