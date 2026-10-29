const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const root = path.resolve(__dirname, '../public');
for (const file of fs.readdirSync(root)) {
 const text = fs.readFileSync(path.join(root,file),'utf8');
 if (file.endsWith('.js')) new vm.Script(text, {filename:file});
 if (file.endsWith('.html')) {
  for(const match of text.matchAll(/<script[^>]*>([\s\S]*?)<\/script>/g)) if(match[1].trim()) new vm.Script(match[1],{filename:file});
  for(const match of text.replace(/<script[\s\S]*?<\/script>/g, "").matchAll(/(?:href|src)="([^"?#]+)(?:[?#][^"]*)?"/g)) {
   const target=match[1];
   if(!/^(https?:|mailto:|tel:|data:)/.test(target) && !fs.existsSync(path.resolve(root,target))) throw Error(`${file}: missing ${target}`);
  }
 }
}
console.log('PASS: JavaScript syntax and local static links. Visual/browser behavior is not covered.');

