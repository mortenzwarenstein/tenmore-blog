module.exports = function(eleventyConfig) {

    eleventyConfig.addPassthroughCopy('src/assets/');
    eleventyConfig.addPassthroughCopy('src/styles/!(tailwind)*.css');
    eleventyConfig.addPassthroughCopy('src/scripts/');

    eleventyConfig.setBrowserSyncConfig({
		files: ['./_site/styles/*.css', './_site/scripts/**/*.js', ]
	});

    return {
        dir: {
            input: 'src',
            includes: '_includes',
            output: '_site'
        },
        templateFormats: ['md', 'html', 'njk'],
        markdownTemplateEngine: 'njk',
        htmlTemplateEngine: 'njk',
        dataTemplateEngine: 'njk'
    }
}