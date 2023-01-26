/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{njk,md,js}", "./src/**/*.svg",],
  theme: {
    fontFamily: {
      sans: ['"Lato"', 'sans-serif'],
      header: ['Oswald', 'sans-serif']
    },
    extend: {}
  },
  variants: {
    extend: {
      backgroundColor: ['group-invalid'],
      borderColor: ['group-invalid']
    }
  },
  plugins: [],
}
