const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

const buildDir = path.resolve(__dirname, './build')

module.exports = {
  entry: './index.ts',
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
    ],
  },
  resolve: {
    extensions: [ '.tsx', '.ts', '.js' ],
  },
  output: {
    filename: 'bundle.js',
    publicPath: '/',
    path: buildDir,
  },
  devServer: {
    contentBase: buildDir,
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./index.html",
      inject: false,
    }),
  ],
}
