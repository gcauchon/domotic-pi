module.exports = {
  content: ['./js/**/*.js', '../lib/*_web.ex', '../lib/*_web/**/*.{ex,eex,heex}'],
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
