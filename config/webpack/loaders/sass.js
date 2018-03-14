const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const { env } = require('../configuration.js')

module.exports = {
  test: /\.(scss|sass|css)$/i,
  use: [
    MiniCssExtractPlugin.loader,
    "css-loader"
  ]
}
