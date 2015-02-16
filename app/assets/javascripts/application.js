//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require turbolinks
//= require bootstrap
//= require wysihtml5x
//= require_tree .

jQuery(".best_in_place").best_in_place();


/**
 * Very simple basic rule set
 *
 * Allows
 *    <i>, <em>, <b>, <strong>, <p>, <div>, <a href="http://foo"></a>, <br>, <span>, <ol>, <ul>, <li>
 *
 * For a proper documentation of the format check advanced.js
 */
var wysihtml5ParserRules = {
    tags: {
        strong: {},
        b:      {},
        i:      {},
        em:     {},
        br:     {},
        p:      {},
        div:    {},
        span:   {},
        ul:     {},
        ol:     {},
        li:     {},
        a:      {
            set_attributes: {
                target: "_blank",
                rel:    "nofollow"
            },
            check_attributes: {
                href:   "url" // important to avoid XSS
            }
        }
    }
};