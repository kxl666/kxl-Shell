<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="generator" content="VNote">

    <title>8.yum源配置</title>
    <link rel="icon" href="https://github.com/tamlok/vnote/raw/master/src/resources/icons/vnote.ico">

    <style type="text/css">
    /* STYLE_GLOBAL_PLACE_HOLDER */
    </style>

    <style type="text/css">
    *,
*::before,
*::after {
  box-sizing: border-box;
}

.container-fluid {
    width: 100%;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

.col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto {
    position: relative;
    width: 100%;
    min-height: 1px;
    padding-right: 15px;
    padding-left: 15px;
}

.col-12 {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
    max-width: 100%;
}

@media (min-width: 768px) {
    .col-md-3 {
        -webkit-box-flex: 0;
        -ms-flex: 0 0 25%;
        flex: 0 0 25%;
        max-width: 25%;
    }
}

@media (min-width: 768px) {
    .col-md-9 {
        -webkit-box-flex: 0;
        -ms-flex: 0 0 75%;
        flex: 0 0 75%;
        max-width: 75%;
    }
}

@media (min-width: 1200px) {
    .col-xl-2 {
        -webkit-box-flex: 0;
        -ms-flex: 0 0 16.666667%;
        flex: 0 0 16.666667%;
        max-width: 16.666667%;
    }
}

@media (min-width: 1200px) {
    .col-xl-10 {
        -webkit-box-flex: 0;
        -ms-flex: 0 0 83.333333%;
        flex: 0 0 83.333333%;
        max-width: 83.333333%;
    }
}

@media (min-width: 768px) {
    .pt-md-3, .py-md-3 {
        padding-top: 1rem!important;
    }
}

@media (min-width: 768px) {
    .pb-md-3, .py-md-3 {
        padding-bottom: 1rem!important;
    }
}

@media (min-width: 768px) {
    .pl-md-5, .px-md-5 {
        padding-left: 3rem!important;
    }
}

.d-none {
    display: none!important;
}

@media (min-width: 1200px) {
    .d-xl-block {
        display: block!important;
    }
}

@media (min-width: 768px) {
    .d-md-block {
        display: block!important;
    }
}

.bd-content {
    -webkit-box-ordinal-group: 1;
    -ms-flex-order: 0;
    order: 0;
}

.bd-toc {
    position: -webkit-sticky;
    position: sticky;
    top: 4rem;
    height: calc(100vh - 10rem);
    overflow-y: auto;
}

.bd-toc {
    -webkit-box-ordinal-group: 2;
    -ms-flex-order: 1;
    order: 1;
    padding-top: 1.5rem;
    padding-bottom: 1.5rem;
    font-size: .875rem;
}

.section-nav {
    padding-left: 0;
}

.section-nav ul {
    font-size: .875rem;
    list-style-type: none;
}

.section-nav li {
    font-size: .875rem;
}

.section-nav a {
    color: inherit !important;
}

.row {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}

@media (min-width: 1200px) {
    .flex-xl-nowrap {
        flex-wrap: nowrap !important;
    }
}

#floating-button {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 50%;
    background: #00897B;
    position: fixed;
    top: .5rem;
    right: .5rem;
    cursor: pointer;
    box-shadow: 0px 2px 5px #666;
}

#floating-button .more {
    color: #F5F5F5;
    position: absolute;
    top: 0;
    display: block;
    bottom: 0;
    left: 0;
    right: 0;
    text-align: center;
    padding: 0;
    margin: 0;
    line-height: 2.5rem;
    font-size: 2rem;
    font-family: 'monospace';
    font-weight: 300;
}

.hide-none {
    display: none !important;
}

.col-expand {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 100% !important;
    flex: 0 0 100% !important;
    max-width: 100% !important;
    padding-right: 3rem !important;
}

.outline-bold {
    font-weight: bolder !important;
}

@media print {
    #floating-button {
        display: none !important;
    }
}

    @keyframes flash { 
  0% { color: rgb(128, 203, 196); }
  10% { color: rgb(0, 137, 123); }
  40% { color: rgb(0, 137, 123); }
  50% { color: rgb(128, 203, 196); }
  60% { color: rgb(0, 137, 123); }
  90% { color: rgb(0, 137, 123); }
}
.highlighted-anchor { animation: flash 1s; }
div.mark-rect { background: transparent; border: 5px solid rgb(87, 104, 196); border-radius: 2px; position: absolute; }
#vnote-footer { width: 100%; text-align: center; opacity: 0.2; margin-top: 3rem; }
#vnote-footer p { font-size: 0.8rem; }
#vnote-footer a { color: inherit !important; }
x-eqs { display: flex; flex-direction: row; align-content: space-between; align-items: center; }
x-eqs > x-eqn { width: 100%; margin-left: 3rem; }
x-eqs > span { text-align: right; }
.view-image, .view-svg { transition: 0.3s; }
.modal-box { display: none; position: fixed; z-index: 1000; padding-top: 50px; left: 0px; top: 0px; width: 100%; height: 100%; overflow: hidden; background-color: rgba(68, 68, 68, 0.952941); }
.modal-content { margin: auto; display: block; width: auto; height: auto; cursor: move; }
.modal-content { animation-name: zoom; animation-duration: 0.6s; }
@-webkit-keyframes zoom { 
  0% { transform: scale(0); }
  100% { transform: scale(1); }
}
@keyframes zoom { 
  0% { transform: scale(0); }
  100% { transform: scale(1); }
}
span.modal-close { position: absolute; z-index: 1000; top: 15px; right: 35px; color: rgb(218, 218, 218); font-size: 40px; font-weight: bold; transition: 0.3s; }
span.modal-close:hover, span.modal-close:focus { color: rgb(238, 238, 238); text-decoration: none; cursor: pointer; }
@media print {
  pre, pre code, td.hljs-ln-code { white-space: pre-wrap !important; word-break: break-all !important; }
  code, a { word-break: break-all !important; }
  div.flowchart-diagram, div.mermaid-diagram, div.plantuml-diagram { overflow: hidden !important; }
  img { max-width: 100% !important; height: auto !important; }
  #vnote-footer { display: none !important; }
}
.alert { position: relative; padding: 0.75rem 1.25rem; margin-bottom: 1rem; border: 1px solid transparent; border-radius: 0.25rem; }
.alert-primary { color: rgb(0, 64, 133); background-color: rgb(204, 229, 255); border-color: rgb(184, 218, 255); }
.alert-secondary { color: rgb(56, 61, 65); background-color: rgb(226, 227, 229); border-color: rgb(214, 216, 219); }
.alert-success { color: rgb(21, 87, 36); background-color: rgb(212, 237, 218); border-color: rgb(195, 230, 203); }
.alert-info { color: rgb(12, 84, 96); background-color: rgb(209, 236, 241); border-color: rgb(190, 229, 235); }
.alert-warning { color: rgb(133, 100, 4); background-color: rgb(255, 243, 205); border-color: rgb(255, 238, 186); }
.alert-danger { color: rgb(114, 28, 36); background-color: rgb(248, 215, 218); border-color: rgb(245, 198, 203); }
.alert-light { color: rgb(129, 129, 130); background-color: rgb(254, 254, 254); border-color: rgb(253, 253, 254); }
.alert-dark { color: rgb(27, 30, 33); background-color: rgb(214, 216, 217); border-color: rgb(198, 200, 202); }
.vnote-anchor { font-weight: 400; color: rgba(0, 123, 255, 0.498039); transition: color 0.16s linear; padding-left: 0.375em; -webkit-font-smoothing: antialiased; text-decoration: none; opacity: 0; }
.vnote-anchor:hover { color: rgb(0, 123, 255); text-decoration: none; opacity: 1; }
.vnote-anchor::after { content: attr(data-anchor-icon); }
.vnote-btn { position: relative; display: inline-block; padding: 6px 12px; font-size: 13px; font-weight: 700; line-height: 20px; white-space: nowrap; vertical-align: middle; cursor: pointer; border: none; user-select: none; -webkit-appearance: none; }
.vnote-copy-clipboard-btn { transition: opacity 0.3s ease-in-out; opacity: 0; padding: 2px 6px; position: absolute; top: 5px; right: 5px; }
pre:hover .vnote-copy-clipboard-btn { opacity: 1; }
pre.vnote-snippet { position: relative; }
body { margin: 0px auto; font-family: "Segoe UI", Helvetica, sans-serif, Tahoma, Arial, Geneva, Georgia, Palatino, "Times New Roman", "Hiragino Sans GB", 冬青黑体, "Microsoft YaHei", 微软雅黑, "Microsoft YaHei UI", "WenQuanYi Micro Hei", 文泉驿雅黑, Dengxian, 等线体, STXihei, 华文细黑, "Liberation Sans", "Droid Sans", NSimSun, 新宋体, SimSun, 宋体; color: rgb(34, 34, 34); line-height: 1.5; padding: 15px; background: rgb(238, 238, 238); font-size: 16px; }
h1, h2, h3, h4, h5, h6 { color: rgb(34, 34, 34); font-weight: bold; margin-top: 20px; margin-bottom: 10px; padding: 0px; }
p { padding: 0px; margin-top: 16px; margin-bottom: 16px; }
h1 { font-size: 26px; }
h2 { font-size: 24px; }
h3 { font-size: 22px; }
h4 { font-size: 20px; }
h5 { font-size: 19px; }
h6 { font-size: 18px; }
a { color: rgb(0, 153, 255); margin: 0px; padding: 0px; vertical-align: baseline; text-decoration: none; word-break: break-word; }
a:hover { text-decoration: underline; color: rgb(255, 102, 0); }
a:visited { color: purple; }
ul, ol { padding: 0px 0px 0px 24px; }
li { line-height: 24px; }
li ul, li ol { margin-left: 16px; }
p, ul, ol { font-size: 16px; line-height: 24px; }
pre { display: block; overflow-y: hidden; overflow-x: auto; tab-size: 4; }
code { font-family: Consolas, Monaco, monospace, Courier; color: rgb(142, 36, 170); word-break: break-word; }
pre code { display: block; overflow-x: auto; padding: 0.5em; color: rgb(34, 34, 34); background-color: rgb(224, 224, 224); border-left: 0.5em solid rgb(0, 137, 123); line-height: 1.5; font-family: Consolas, Monaco, monospace, Courier; white-space: pre; tab-size: 4; }
pre code.markdown-metadata { border-left: 0.5em solid rgb(128, 203, 196); }
aside { display: block; float: right; width: 390px; }
blockquote { color: rgb(102, 102, 102); border-left: 0.5em solid rgb(122, 122, 122); padding: 0px 1em; margin-left: 0px; }
blockquote p { color: rgb(102, 102, 102); }
hr { display: block; text-align: left; margin: 1em 0px; border: none; height: 2px; background: rgb(153, 153, 153); }
table { padding: 0px; margin: 1rem 0.5rem; border-collapse: collapse; }
table tr { border-top: 2px solid rgb(204, 204, 204); background-color: white; margin: 0px; padding: 0px; }
table tr:nth-child(2n) { background-color: rgb(248, 248, 248); }
table tr th { font-weight: bold; border: 2px solid rgb(204, 204, 204); margin: 0px; padding: 6px 13px; }
table tr td { border: 2px solid rgb(204, 204, 204); margin: 0px; padding: 6px 13px; }
table tr th :first-child, table tr td :first-child { margin-top: 0px; }
table tr th :last-child, table tr td :last-child { margin-bottom: 0px; }
div.mermaid-diagram { margin: 16px 0px; overflow-y: hidden; }
div.flowchart-diagram { padding: 0px 5px; margin: 16px 0px; width: fit-content; overflow: hidden; }
div.wavedrom-diagram { padding: 0px 5px; margin: 16px 0px; width: fit-content; overflow: hidden; }
div.plantuml-diagram { padding: 5px 5px 0px; margin: 16px 0px; width: fit-content; overflow: hidden; }
.img-package { text-align: center; }
img.img-center { display: block; margin-left: auto; margin-right: auto; }
span.img-caption { min-width: 20%; max-width: 80%; display: inline-block; padding: 10px; margin: 0px auto; border-bottom: 1px solid rgb(192, 192, 192); color: rgb(108, 108, 108); text-align: center; line-height: 1.5; }
.emoji_zero, .emoji_one, .emoji_two, .emoji_three, .emoji_four, .emoji_five, .emoji_six, .emoji_seven, .emoji_eight, .emoji_nine { margin-left: 5px; margin-right: 8px; }
div.preview-hint { opacity: 0.5; margin-top: 30%; margin-bottom: 30%; align-items: center; display: flex; flex-direction: column; justify-content: center; }
table.hljs-ln tr { border: none; background-color: transparent; }
table.hljs-ln tr td { border: none; background-color: transparent; }
table.hljs-ln tr td.hljs-ln-numbers { user-select: none; text-align: center; color: rgb(170, 170, 170); border-right: 1px solid rgb(204, 204, 204); vertical-align: top; padding-right: 5px; white-space: nowrap; }
table.hljs-ln tr td.hljs-ln-code { padding-left: 10px; }
::-webkit-scrollbar { background-color: rgb(234, 234, 234); width: 14px; height: 14px; border: none; }
::-webkit-scrollbar-corner { background-color: rgb(234, 234, 234); }
::-webkit-scrollbar-button { height: 14px; width: 14px; background-color: rgb(234, 234, 234); }
::-webkit-scrollbar-button:hover { background-color: rgb(208, 208, 208); }
::-webkit-scrollbar-button:active { background-color: rgb(178, 178, 178); }
::-webkit-scrollbar-track { background-color: rgb(234, 234, 234); }
::-webkit-scrollbar-thumb { border: none; background-color: rgb(218, 218, 218); }
::-webkit-scrollbar-thumb:hover { background-color: rgb(208, 208, 208); }
::-webkit-scrollbar-thumb:active { background-color: rgb(178, 178, 178); }
::-webkit-scrollbar-button:horizontal:increment { background-image: url('data:image/svg+xml;utf8,<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"> <g>    <g transform="rotate(-90 256.00000000000006,256) " id="svg_1">   <polygon fill="%23333333" id="svg_2" points="128,192 256,320 384,192  "/>  </g> </g></svg>'); background-repeat: no-repeat; background-size: contain; }
::-webkit-scrollbar-button:horizontal:decrement { background-image: url('data:image/svg+xml;utf8,<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"> <g>    <g transform="rotate(90 255.99999999999997,256.00000000000006) " id="svg_1">   <polygon points="128,192 256,320 384,192  " id="svg_2" fill="%23333333"/>  </g> </g></svg>'); background-repeat: no-repeat; background-size: contain; }
::-webkit-scrollbar-button:vertical:increment { background-image: url('data:image/svg+xml;utf8,<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"> <g>    <g transform="null" id="svg_1">   <polygon points="128,192 256,320 384,192  " id="svg_2" fill="%23333333"/>  </g> </g></svg>'); background-repeat: no-repeat; background-size: contain; }
::-webkit-scrollbar-button:vertical:decrement { background-image: url('data:image/svg+xml;utf8,<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"> <g>    <g transform="rotate(180 255.99999999999997,256) " id="svg_1">   <polygon points="128,192 256,320 384,192  " id="svg_2" fill="%23333333"/>  </g> </g></svg>'); background-repeat: no-repeat; background-size: contain; }
::selection { background: rgb(25, 118, 210); color: rgb(238, 238, 238); }
.modal-box { background-color: rgba(234, 234, 234, 0.952941); }
span.modal-close { color: rgb(102, 102, 102); }
span.modal-close:hover, span.modal-close:focus { color: rgb(34, 34, 34); }
.hljs { display: block; overflow-x: auto; padding: 0.5em; background: rgb(224, 224, 224); }
.hljs, .hljs-subst { color: rgb(54, 54, 54); }
.hljs-comment { color: rgb(118, 118, 118); }
.hljs-keyword, .hljs-attribute, .hljs-selector-tag, .hljs-meta-keyword, .hljs-doctag, .hljs-name { color: rgb(0, 0, 238); }
.hljs-type, .hljs-string, .hljs-number, .hljs-selector-id, .hljs-selector-class, .hljs-quote, .hljs-template-tag, .hljs-deletion { color: rgb(136, 0, 0); }
.hljs-title, .hljs-section { color: rgb(136, 0, 0); font-weight: bold; }
.hljs-regexp, .hljs-symbol, .hljs-variable, .hljs-template-variable, .hljs-link, .hljs-selector-attr, .hljs-selector-pseudo { color: rgb(188, 96, 96); }
.hljs-literal { color: rgb(175, 0, 215); }
.hljs-built_in, .hljs-bullet, .hljs-code, .hljs-addition { color: rgb(0, 135, 0); }
.hljs-meta { color: rgb(31, 113, 153); }
.hljs-meta-string { color: rgb(77, 153, 191); }
.hljs-emphasis { font-style: italic; }
.hljs-strong { font-weight: bold; }

    </style>

    <script type="text/javascript">
var toc = [];

var setVisible = function(node, visible) {
    var cl = 'hide-none';
    if (visible) {
        node.classList.remove(cl);
    } else {
        node.classList.add(cl);
    }
};

var isVisible = function(node) {
    var cl = 'hide-none';
    return !node.classList.contains(cl);
};

var setPostContentExpanded = function(node, expanded) {
    var cl = 'col-expand';
    if (expanded) {
        node.classList.add(cl);
    } else {
        node.classList.remove(cl);
    }
};

var setOutlinePanelVisible = function(visible) {
    var outlinePanel = document.getElementById('outline-panel');
    var postContent = document.getElementById('post-content');

    setVisible(outlinePanel, visible);
    setPostContentExpanded(postContent, !visible);
};

var isOutlinePanelVisible = function() {
    var outlinePanel = document.getElementById('outline-panel');
    return isVisible(outlinePanel);
};

window.addEventListener('load', function() {
    var outlinePanel = document.getElementById('outline-panel');
    outlinePanel.style.display = 'initial';

    var floatingContainer = document.getElementById('container-floating');
    floatingContainer.style.display = 'initial';

    var outlineContent = document.getElementById('outline-content');
    var postContent = document.getElementById('post-content');

    // Escape @text to Html.
    var escapeHtml = function(text) {
        var map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };

        return text.replace(/[&<>"']/g, function(m) { return map[m]; });
    }

    // Fetch the outline.
    var headers = postContent.querySelectorAll("h1, h2, h3, h4, h5, h6");
    toc = [];
    for (var i = 0; i < headers.length; ++i) {
        var header = headers[i];

        toc.push({
            level: parseInt(header.tagName.substr(1)),
            anchor: header.id,
            title: escapeHtml(header.textContent)
        });
    }

    if (toc.length == 0) {
        setOutlinePanelVisible(false);
        setVisible(floatingContainer, false);
        return;
    }

    var baseLevel = baseLevelOfToc(toc);
    var tocTree = tocToTree(toPerfectToc(toc, baseLevel), baseLevel);

    outlineContent.innerHTML = tocTree;
    setOutlinePanelVisible(true);
    setVisible(floatingContainer, true);
});

// Return the topest level of @toc, starting from 1.
var baseLevelOfToc = function(p_toc) {
    var level = -1;
    for (i in p_toc) {
        if (level == -1) {
            level = p_toc[i].level;
        } else if (level > p_toc[i].level) {
            level = p_toc[i].level;
        }
    }

    if (level == -1) {
        level = 1;
    }

    return level;
};

// Handle wrong title levels, such as '#' followed by '###'
var toPerfectToc = function(p_toc, p_baseLevel) {
    var i;
    var curLevel = p_baseLevel - 1;
    var perfToc = [];
    for (i in p_toc) {
        var item = p_toc[i];

        // Insert empty header.
        while (item.level > curLevel + 1) {
            curLevel += 1;
            var tmp = { level: curLevel,
                        anchor: '',
                        title: '[EMPTY]'
                      };
            perfToc.push(tmp);
        }

        perfToc.push(item);
        curLevel = item.level;
    }

    return perfToc;
};

var itemToHtml = function(item) {
    return '<a href="#' + item.anchor + '" data="' + item.anchor + '">' + item.title + '</a>';
};

// Turn a perfect toc to a tree using <ul>
var tocToTree = function(p_toc, p_baseLevel) {
    var i;
    var front = '<li>';
    var ending = ['</li>'];
    var curLevel = p_baseLevel;
    for (i in p_toc) {
        var item = p_toc[i];
        if (item.level == curLevel) {
            front += '</li>';
            front += '<li>';
            front += itemToHtml(item);
        } else if (item.level > curLevel) {
            // assert(item.level - curLevel == 1)
            front += '<ul>';
            ending.push('</ul>');
            front += '<li>';
            front += itemToHtml(item);
            ending.push('</li>');
            curLevel = item.level;
        } else {
            while (item.level < curLevel) {
                var ele = ending.pop();
                front += ele;
                if (ele == '</ul>') {
                    curLevel--;
                }
            }
            front += '</li>';
            front += '<li>';
            front += itemToHtml(item);
        }
    }
    while (ending.length > 0) {
        front += ending.pop();
    }
    front = front.replace("<li></li>", "");
    front = '<ul>' + front + '</ul>';
    return front;
};

var toggleMore = function() {
    if (toc.length == 0) {
        return;
    }

    var p = document.getElementById('floating-more');
    if (isOutlinePanelVisible()) {
        p.textContent = '<';
        setOutlinePanelVisible(false);
    } else {
        p.textContent = '>';
        setOutlinePanelVisible(true);
    }
};

window.addEventListener('scroll', function() {
    if (toc.length == 0 || !isOutlinePanelVisible()) {
        return;
    }

    var postContent = document.getElementById('post-content');
    var scrollTop = document.documentElement.scrollTop
                    || document.body.scrollTop
                    || window.pageYOffset;
    var eles = postContent.querySelectorAll("h1, h2, h3, h4, h5, h6");

    if (eles.length == 0) {
        return;
    }

    var idx = -1;
    var biaScrollTop = scrollTop + 50;
    for (var i = 0; i < eles.length; ++i) {
        if (biaScrollTop >= eles[i].offsetTop) {
            idx = i;
        } else {
            break;
        }
    }

    var header = '';
    if (idx != -1) {
        header = eles[idx].id;
    }

    highlightItemOnlyInOutline(header);
});

var highlightItemOnlyInOutline = function(id) {
    var cl = 'outline-bold';
    var outlineContent = document.getElementById('outline-content');
    var eles = outlineContent.querySelectorAll("a");
    var target = null;
    for (var i = 0; i < eles.length; ++i) {
        var ele = eles[i];
        if (ele.getAttribute('data') == id) {
            target = ele;
            ele.classList.add(cl);
        } else {
            ele.classList.remove(cl);
        }
    }

    // TODO: scroll target into view within the outline panel scroll area.
};

</script>


<!-- HEAD_PLACE_HOLDER -->
</head>
<body>
<div class="container-fluid">
<div class="row flex-xl-nowrap">
    <div id="outline-panel" style="display:none;" class="d-none d-md-block d-xl-block col-md-3 col-xl-2 bd-toc">
        <div id="outline-content" class="section-nav"></div>
    </div>
    <div id="post-content" class="col-12 col-md-9 col-xl-10 py-md-3 pl-md-5 bd-content">
    <h6 id="toc_0">YUM使用官方源<a class="vnote-anchor" href="#toc_0" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">http://mirrors.aliyun.com/
http://mirrors.163.com
</code></pre>
<h1 id="toc_1">==基础源==<a class="vnote-anchor" href="#toc_1" data-anchor-icon="#"></a></h1>
<h6 id="toc_2">Base/Extras/Updates:默认(国外源)<a class="vnote-anchor" href="#toc_2" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# ls /etc/yum.repos.d/
CentOS-Base.repo
CentOS-fasttrack.repo CentOS-Vault.repo
CentOS-CR.repo
CentOS-Media.repo
CentOS-Debuginfo.repo CentOS-Sources.repo
[root@tianyun ~]# yum repolist
repo id            repo name              status
base/7/x86_ 64     CentOS-7 - Base        9,363
extras/7/x86_ _64  CentOS-7 - Extras      449
updates/7/x86_ _64 CentOS-7 - Updates     2,146
repolist: 11,958
</code></pre>
<h6 id="toc_3">aliyun:<a class="vnote-anchor" href="#toc_3" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
[root@tianyun ~]# curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos _7.repo
[root@tianyun ~]# yum clean all
//清除原来旧的YUM数据库信息
[root@tianyun ~]# yum makecache
//更新新的YUM仓库信息
</code></pre>
<h6 id="toc_4">163:<a class="vnote-anchor" href="#toc_4" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# mv /etc/yum.repos.d/CentOS Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
[root@tianyun ~]# curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors. 163.com/.help/CentOS7-Base-163.repo
</code></pre>
<h6 id="toc_5">EPEL:<a class="vnote-anchor" href="#toc_5" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# yum Y install epel-release (国外源)
或
[root@tianyun ~]# mv /etc/yum.repos.d/epel.repo /etc/yum.repos d/epel.repo.backup
[root@tianyun ~]# wget -o /etc/yum.repos.d/epel.repo http://mirrors aliyun.com/repo/epel-7.repo
</code></pre>
<h6 id="toc_6">下载wget后:<a class="vnote-anchor" href="#toc_6" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
</code></pre>
<h1 id="toc_7">==软件官方源==<a class="vnote-anchor" href="#toc_7" data-anchor-icon="#"></a></h1>
<h6 id="toc_8">Nginx;<a href="http://nginx.org">nginx.org</a><a class="vnote-anchor" href="#toc_8" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# vim /etc/yum.repos.d/nginx.repo
[nginx]
name =nginx repo
baseurl=http://nginx. org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
</code></pre>
<h6 id="toc_9">MySQL:<a href="http://www.mysql.com">http://www.mysql.com</a><a class="vnote-anchor" href="#toc_9" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
</code></pre>
<h6 id="toc_10">Zabbix:<a href="https://www.zabbix.com/">https://www.zabbix.com/</a><a class="vnote-anchor" href="#toc_10" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">rpm -ivh http://repo.zabbix.com/zabbix/3.2/thel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
</code></pre>
<h6 id="toc_11">Openstack:<a href="https://www.openstack.org/">https://www.openstack.org/</a><a class="vnote-anchor" href="#toc_11" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">yum install centos-release-openstack-ocata  
yum install https://rdoproject.org/repos/rdo-release.rpm
</code></pre>
<h1 id="toc_12">==本地源==<a class="vnote-anchor" href="#toc_12" data-anchor-icon="#"></a></h1>
<pre><code class="hljs">mkdir /kqf &amp;&gt;/dev/null
sed -i '/mount -t iso9660 \/dev\/sr0 \/kqf/d' /etc/rc.d/rc.local &amp;&gt;/dev/null
        mount -t iso9660 /dev/sr0 /kqf &amp;&gt;/dev/null
        echo 'mount -t iso9660 /dev/sr0 /kqf' &gt;&gt;/etc/rc.d/rc.local
        chmod a+x /etc/rc.d/rc.local
        ##配置本地yum
        rm -rf /etc/yum.repos.d/bak
        mkdir /etc/yum.repos.d/bak
        mv /etc/yum.repos.d/* /etc/yum.repos.d/bak &amp;&gt;/dev/null
##编写本地yum文件
cat &gt; /etc/yum.repos.d/kxl.repo &lt;&lt;DOF
[kxl]
name=kxl
baseurl=file:///kqf
enabled=1
gpgcheck=0
DOF
##清除原有缓存，建议新的缓存
        yum clean all &amp;&gt;/dev/null
        yum makecache  fast 
</code></pre>
<p>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@<br>
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@</p>
<h1 id="toc_13">使用YUM管理RPM包（自动解决包的依赖关系）<a class="vnote-anchor" href="#toc_13" data-anchor-icon="#"></a></h1>
<h6 id="toc_14">==查看可用仓库<a class="vnote-anchor" href="#toc_14" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">[root@tianyun ~]# yum clean all
//清空缓存及其它文件
[root@tianyun ~ ]# yum makecache
//重建缓存
[root@tianyun ~]# yum repolist
//查询可用的仓库
</code></pre>
<h6 id="toc_15">==安装<a class="vnote-anchor" href="#toc_15" data-anchor-icon="#"></a></h6>
<pre><code class="hljs"># yum -y install httpd vsftpd *vnc
# yum -y reinstall httpd 
如果这个包有丢失，这个命令将补全所有包     
# yum -y update httpd
# yum -y update
# yum -y install /root/OpenIPMI-2.0.19-11.el7.x86_ _64.rpm //从本地安装
# yum -y install https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm  //URL
# yum -y groupinstall mariadb  //安装整个软件组
# yum -y remove httpd
# yum -y groupremove mariadb   //卸载整个软件组
</code></pre>
<h6 id="toc_16">==查询(从本地rpm数据库和yum源中查询)<a class="vnote-anchor" href="#toc_16" data-anchor-icon="#"></a></h6>
<pre><code class="hljs"># yum list httpd
# yum list *vnc*
# yum list |grep vnc
# yum list installed
# yum info httpd       //查询包的信息  
# yum group list
# yum grouplist
# yum groupinfo mariadb
</code></pre>
<h6 id="toc_17">==卸载<a class="vnote-anchor" href="#toc_17" data-anchor-icon="#"></a></h6>
<pre><code class="hljs"> yum -y remove mysql-server
 yum -y groupremove mysql-server
</code></pre>
<h6 id="toc_18">==history<a class="vnote-anchor" href="#toc_18" data-anchor-icon="#"></a></h6>
<pre><code class="hljs"># yum history //历史安装
# yum history info 4 //历史安装详情
# yum history undo 4 //历史安装撤销
</code></pre>
<h6 id="toc_19">==扩展查询==<a class="vnote-anchor" href="#toc_19" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">例1:从包名和包描述中查找带有关键字chinese的包
# yum list lgrep chinese //只关注软件包的名
# yum list lgrep piny
# yum search chinese     //
例2 :查找/etc/vsftpd/vsftpd.conf属由哪个包提供?
[root@server0 ~]# yum provides /etc/vsftpd/vsftpd.conf
Loaded plugins: langpacks
vsftpd-3.0.2-9.el7.x86_64 : Very Secure Ftp Daemon
Repo: classroom._content_,rhel7.0_ x86_64_dvd_
Matched from:Filename : /etc/vsftpd/vsftpd.conf
[root@server0 ~]# yum -y install vsftpd-3.0.2-9.e7.x86_ _64
例3 :查找vsftpd.conf属由哪个包提供?
[root@server0 ~]# yum provides */vsftpd.conf
例4 :查找命令gnuplot属由哪个包提供?
[root@server0 ~]# gnuplot
bash: gnuplot: command not found...
[root@server0 ~]#
[root@server0 ~]# yum provides gnuplot
Loaded plugins: langpacks
gnuplot-4.6.2-3.el7.x86_64 : A program for plotting mathematical expressions and data
</code></pre>
<p>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@<br>
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@</p>
<h1 id="toc_20">自建yum源<a class="vnote-anchor" href="#toc_20" data-anchor-icon="#"></a></h1>
<h6 id="toc_21">一.环境基础设置<a class="vnote-anchor" href="#toc_21" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">1.配置防火墙
[root@yangs ~]# firewall-cmnd --permanent --add-service=ftp
[root@yangs ~]# firewall-cmd --reload 


2.关闭SELinux
[root@yangs ~]# setenforce 0
[root@yangs ~]# vim /etc/sysconfig/selinux
SELINUX=disabled


3.服务端FTP设置
[root@yangs ~]# yum y install vsftpd
[root@yangs ~]# systemctl start vsftpd
[root@yangs ~]# systemctl enable vsftpd
</code></pre>
<h6 id="toc_22">二.3种自建yum源类型<a class="vnote-anchor" href="#toc_22" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">◆实现目标1 :提供基础软件Base
挂载centos镜像
[root@yangs ~]# mkdir /var/fp/{centos6u6,centos7u3}
[root@yangs ~]# mount -0 loop /home/centos7u2.iso /var/ftp/centos7u2
[root@yangs ~]# echo "mount -0 loop /homhe/centos7u2.iso /var/ftp/centos7u2" &gt;&gt; /etc/rc.local
[root@yangs ~]# chmod +x /etc/rc.d/rc.local

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

◆实现目标2:提供update
启动yum缓存(服务端)
[root@yangs ~]# vim /etc/yum.conf
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache= 1
[root@yangs ~]# yum clean all
[root@yangs ~]# yum -y update
[root@yangs ~]# mkdir /ar/ftp/update
[root@yangs ~]# find /var/cache/yum/x86_64/7/ -iname *.rpm" -exec cp -rf {} /var/ftp/update \;
[root@yangs ~]# yum -y install createrepo
[root@yangs ~]# createrepo /var/ftp/update

Yum client测试(客户端)
★ [root@yum-client ~]# rm -rf /etc/yum.repos.d/CentOS-Base.repo
★ [root@yum-client ~]# vi /etc/yum.repos.d/updaterepo
[update]
name=centos update
baseurl-ftp://192.168.122.202/gpdate
gpgcheck=0
enabled=1
★ [root@yum-client ~]# yum repolist
Loaded plugins: fastestmirror
update
| 2.9 kB 00:00:00
update/primary_ db
| 511 kB 00:00:00
Loading mirror speeds from cached hostfile
repo id
repo name
status
update
centos update
75
repolist: 75
★[root@yum-client ~]# yum -y update

——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

◆实现目标3:提供其它软件包如nginx, zabbix -downloadonly
★1.配置nginx及zabbix源(服务端)
[root@yum-server ~]# vim /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled= =1
★2.downloadonly
[root@yangs ~]# yum clean all
[root@yum-server ~]# yum install nginx -downloadonly
[root@yum-server ~]# mkdir /var/ftp/{nginx,zabbix}
[root@yum-server ~]# find /var/cache/yum/x86_64/7/ -iname **.rpm" -exec cp -f {} /var/ftp/nginx
★3.创建reopdata : 
[root@yum-server ~]# createrepo /var/ftp/nginx
//如果加入新软件包，重新创建

Yum cllient测试(客户端)
★[root@yum-client ~]# vi /etc/yum.repos.d/nginxepo 
[nginx]
name=nginx
baseurl=ftp://192.168.122.202/nginx
gpgcheck=0
enabled= 1
★[root@yum-client ~]# yum repolist
repo id     repo name      status
nginx       nginx             1
update      centos update     75
★[root@yum-client ~]# yum -y install nginx
</code></pre>
<h6 id="toc_23">三.YUM签名检查机制<a class="vnote-anchor" href="#toc_23" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">rpm软件提供组织例如redhat在构建rpm包时,使用其私钥( private key )对rpm进行签名
cient在使用其rpm包时，为了验证其合法性，可以使用redhat提供的公钥( public key )进行签名检查
</code></pre>
<pre><code class="hljs">方法一:事先导入公钥
[root@tianyun ~]# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 //redhat
[root@tianyun ~]# vim /etc/yum.repos.d/CentOS-Base.repo
[base]
name=CentOS-$releasever-Base
mirrorlist htt://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=os&amp;infra=Sinfra
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
方法二:指定公钥的位置
[root@tianyun ~]# vim /etc/yum.repos.d/CentOS-Base.repo
[base]
name=CentOS-$releasever -Base
mirrorlist htt://mirrorlist.centos.org/?release=$releasever&amp;arch=$basearch&amp;repo=os&amp;infra=$infra
#baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=file://etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
</code></pre>
<h6 id="toc_24">额外选项:<a class="vnote-anchor" href="#toc_24" data-anchor-icon="#"></a></h6>
<pre><code class="hljs">--nogpgcheck  //不检查软件包的签名
yum -y install nginx --nogpgcheck  //用法:安装nginx不进行软件包的签名的检查
</code></pre>

    </div>
</div>
</div>

<div id="container-floating" style="display:none;" class="d-none d-md-block d-xl-block">
    <div id="floating-button" onclick="toggleMore()">
        <p id="floating-more" class="more">&gt;</p>
    </div>
</div>

<!--
<div class="footer" id="vnote-footer">
    <p>Generated by <em><a href="https://tamlok.github.io/vnote/">VNote</a></em>.</p>
</div>
-->
</body>
</html>
