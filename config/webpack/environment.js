const { environment } = require('@rails/webpacker')

// Bootstrap 3 has a dependency over jQuery:
const webpack = require('webpack')

// environment.plugins.prepend('Provide',
//     new webpack.ProvidePlugin({
//         $: 'jquery',
//         jQuery: 'jquery',
//         Popper: ['popper.js', 'default']
//     })
// )

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))

// environment.plugins.prepend('env',
//     new webpack.DefinePlugin({
//         'NODE_ENV': JSON.stringify(process.env.NODE_ENV)
//     })
// )


module.exports = environment


// const { environment } = require('@rails/webpacker')
// const { webpack } = require('webpack')
//
// environment.plugins.append("provide", new webpack.ProvidePlugin({
//     $: 'jquery',
//     jQuery: 'jquery',
//     Popper: ['popper.js', 'default']
// }))
//
// module.exports = environment
