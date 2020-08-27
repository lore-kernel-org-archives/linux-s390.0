Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v6 5/5] KVM: MIPS: clean up redundant kvm_run parameters
 in assembly
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <20200623131418.31473-6-tianjia.zhang@linux.alibaba.com>
 <e447bb5c-8b83-dfb1-a293-f2e9e586c2ec@flygoat.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <fdc4635f-7e44-3227-ea65-db28abde42d6@linux.alibaba.com>
Date: Thu, 27 Aug 2020 20:51:22 +0800
MIME-Version: 1.0
In-Reply-To: <e447bb5c-8b83-dfb1-a293-f2e9e586c2ec@flygoat.com>
Content-Type: text/plain; charset="gbk"; format="flowed"
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, chenhuacai@gmail.com

SGksIFBhb2xvCgoKRG8geW91IG5lZWQgYW55IG90aGVyIGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2g/
CgoKVGhhbmtzLAoKVGlhbmppYQoKCk9uIDcvMTYvMjAgMTA6MTAgQU0sIEppYXh1biBZYW5nIHdy
b3RlOgo+Cj4KPiDvv73vv70gMjAyMC82LzIzIDIxOjE0LCBUaWFuamlhIFpoYW5nINC077+977+9
Ogo+PiBJbiB0aGUgY3VycmVudCBrdm0gdmVyc2lvbiwgJ2t2bV9ydW4nIGhhcyBiZWVuIGluY2x1
ZGVkIGluIHRoZSAKPj4gJ2t2bV92Y3B1Jwo+PiBzdHJ1Y3R1cmUuIEZvciBoaXN0b3JpY2FsIHJl
YXNvbnMsIG1hbnkga3ZtLXJlbGF0ZWQgZnVuY3Rpb24gcGFyYW1ldGVycwo+PiByZXRhaW4gdGhl
ICdrdm1fcnVuJyBhbmQgJ2t2bV92Y3B1JyBwYXJhbWV0ZXJzIGF0IHRoZSBzYW1lIHRpbWUuIFRo
aXMKPj4gcGF0Y2ggZG9lcyBhIHVuaWZpZWQgY2xlYW51cCBvZiB0aGVzZSByZW1haW5pbmcgcmVk
dW5kYW50IHBhcmFtZXRlcnMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFRpYW5qaWEgWmhhbmcgPHRp
YW5qaWEuemhhbmdAbGludXguYWxpYmFiYS5jb20+Cj4+IFJldmlld2VkLWJ5OiBIdWFjYWkgQ2hl
biA8Y2hlbmhjQGxlbW90ZS5jb20+Cj4KPiBUZXN0ZWQtYnk6IEppYXh1biBZYW5nIDxqaWF4dW4u
eWFuZ0BmbHlnb2F0LmNvbT4KPgo+IENhbiBjb25maXJtIGl0IHdvcmtzIG9uIExvb25nc29uLTNB
NDAwMC4KPgo+IFRoYW5rcyEKPgo+PiAtLS0KPgo=
