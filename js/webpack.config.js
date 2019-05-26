const path = require('path');

module.exports = {
    entry: './src/index.js',
    output: {
        filename: 'ppstats.js',
        path: path.resolve(__dirname, 'dist'),
    },
    mode: 'production',
    devServer: {
        contentBase: './dist'
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                      presets: ['@babel/preset-env']
                    }
                }
            }
        ]
    }
};
