const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const Webpack = require('webpack');
const path = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');

module.exports = function(args) {

  //Output to IntelliJ's output directory in dev mode so changes are instantly detected by Spring
  const outputDir = 'out/production/resources/static/dist';

  return {
    plugins: [
      new ManifestPlugin({
        //We only want "entry point" assets in the manifest
        filter: (file) => file.isInitial
      }),
      new CleanWebpackPlugin([outputDir + '/*']),
      new MiniCssExtractPlugin({chunkFilename: '[name]-[contenthash].css'}),
      new VueLoaderPlugin(),
      new Webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery'
      })
    ],
    entry: './src/main/frontend/main.js',
    output: {
      filename: '[name].js',
      path: __dirname + '/' + outputDir,
      //Fix Vue sourcemap filenames: https://github.com/vuejs/vue-cli/issues/2978#issuecomment-441426094
      devtoolFallbackModuleFilenameTemplate: 'webpack:///[resource-path]?[hash]',
    },
    resolve: {
      alias: {
        'core': path.resolve(__dirname, 'src/main/frontend'),
        'vue$': 'vue/dist/vue.esm.js' //Include Vue runtime compiler
      }
    },
    optimization: {
      runtimeChunk: 'single',
      splitChunks: {
        chunks: 'all',
        cacheGroups: {
          styles: {
            name: 'styles',
            test: /\.(css|scss)$/,
            chunks: 'all',
            enforce: true
          }
        }
      },
      minimizer: [
        new UglifyJsPlugin({
          cache: true,
          parallel: true,
          sourceMap: true // set to true if you want JS source maps
        }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    module: {
      rules: [
        {
          //JS
          test: /\.js$/,
          exclude: /node_modules/,
          use: [
            {
              loader: 'babel-loader'
            }
          ]
        },
        {
          //Vue
          test: /\.vue$/,
          use: [
            {
              loader: 'vue-loader',
              options: {
                productionMode: false
              }
            }
          ]
        },
        {
          //JS/Vue linting preloader
          enforce: 'pre',
          test: /\.(js|vue)$/,
          use: [
            {
              loader: 'eslint-loader',
              options: {
                emitWarning: true
              }
            }
          ],
          exclude: /node_modules/
        },
        {
          //SASS
          test: /\.scss$/,
          use: [
            {
              loader: MiniCssExtractPlugin.loader
            },
            {
              loader: 'css-loader'
            },
            {
              //rewrites urls to be relative to main scss file instead of partial
              loader: 'resolve-url-loader',
              options: {
                sourceMap: true,
                engine: 'rework' //https://github.com/bholloway/resolve-url-loader/issues/107
              }
            },
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true, //Required by resolve-url-loader
                sourceMapContents: false
              }
            }
          ]
        },
        {
          //CSS
          test: /\.css$/,
          use: [
            {
              loader: MiniCssExtractPlugin.loader
            },
            {
              loader: 'css-loader'
            },
          ]
        },
        {
          //Images
          test: /\.(png|svg|jpg|gif)$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                name: 'img/[name]-[contenthash].[ext]'
              }
            }
          ]
        },
        {
          //Fonts
          test: /\.(woff|woff2|eot|ttf|otf)$/,
          use: [
            {
              loader: 'file-loader',
              options: {
                name: 'fonts/[name]-[contenthash].[ext]'
              }
            }
          ]
        }
      ]
    }
  }
};