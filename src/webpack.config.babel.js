var webpack = require('webpack');

module.exports = {
    entry: './app/index',
    output: {
        path: __dirname + '/public',
        filename: 'bundle.js'
    },
    plugins: [
        new webpack.ProvidePlugin({
            riot: 'riot'
        })
    ],
    module: {
        rules: [
            {
                test: /\.tag$/,
                exclude: /node_modules/,
                loader: 'riotjs-loader', // riot-tag-loader
                query: {
                    type: 'none'
                }
            },
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel-loader'
            }
        ]
    },
    devServer: {
        contentBase: './public'
    }
};
