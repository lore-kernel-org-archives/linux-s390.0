Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:40350 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbfGNPVJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 14 Jul 2019 11:21:09 -0400
Subject: Re: [PATCH 01/12] Documentation: move architectures together
References: <20190712022018.27989-1-alex.shi@linux.alibaba.com>
 <20190712113427.62fa7ffc@lwn.net>
From: Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <36c522c5-975e-e38e-daad-0f3d9f93b186@linux.alibaba.com>
Date: Sun, 14 Jul 2019 23:21:03 +0800
MIME-Version: 1.0
In-Reply-To: <20190712113427.62fa7ffc@lwn.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org

SGkgSm9uLAoKVGhhbmtzIGZvciBxdWljayByZXNwb25zZSEKCu+/ve+/vSAyMDE5LzcvMTMg77+9
77+977+977+9MTozNCwgSm9uYXRoYW4gQ29yYmV0INC077+977+9Ogo+IE9uIEZyaSwgMTIgSnVs
IDIwMTkgMTA6MjA6MDcgKzA4MDAKPiBBbGV4IFNoaSA8YWxleC5zaGlAbGludXguYWxpYmFiYS5j
b20+IHdyb3RlOgo+IAo+PiBUaGVyZSBhcmUgbWFueSBkaWZmZXJlbnQgYXJjaHMgaW4gRG9jdW1l
bnRhdGlvbi8gZGlyLCBpdCdzIGJldHRlciB0bwo+PiBtb3ZlIHRoZW0gdG9nZXRoZXIgaW4gJ0Rv
Y3VtZW50YXRpb24vYXJjaCcgd2hpY2ggZm9sbG93cyBmcm9tIGtlcm5lbCBzb3VyY2UuCj4gCj4g
U28gdGhpcyBzZWVtcyBjZXJ0YWluIHRvIGNvbGxpZGUgYmFkbHkgd2l0aCBNYXVybydzIFJTVC1j
b252ZXJzaW9uIG1vbnN0ZXIKPiBwYXRjaCBzZXQuCgpJIGRvbid0IG1lYW4gdGhhdCwgc29ycnks
IGFuZCB3ZSBjYW4gZmlndXJlIG91dCBpZiBib3RoIG9mIHRoZW0gYXJlIHdvcnRoeSB0byBiZSBw
aWNrZWQgdXAuCgo+IAo+IE1vcmUgdG8gdGhlIHBvaW50LCB0aG91Z2guLi5pZiB3ZSBhcmUgZ29p
bmcgdG8gdGhyYXNoIHVwIHRoaW5ncyB0aGlzCj4gYmFkbHksIHdlIHdhbnQgdG8gYmUgc3VyZSB0
aGF0IHdlJ3JlIGRvaW5nIGl0IHJpZ2h0IHNvIHdlIGRvbid0IGVuZCB1cAo+IHJlbmFtaW5nIGV2
ZXJ5dGhpbmcgYWdhaW4uICBHcm91cGluZyBzdHVmZiBpbnRvIGEgbmV3IGFyY2gvIHN1YmRpcmVj
dG9yeQo+IGFkZHMgYSBiaXQgb2Ygb3JkZXIsIGJ1dCBpdCBkb2Vzbid0IGRvIG11Y2ggdG93YXJk
IHRyeWluZyB0byBvcmdhbml6ZSBvdXIKPiBkb2N1bWVudGF0aW9uIGZvciBpdHMgcmVhZGVycywg
YW5kIGl0IGRvZXNuJ3QgaGVscCB1cyB0byBtb2Rlcm5pemUgdGhlCj4gZG9jcyBhbmQgZ2V0IHJp
ZCBvZiB0aGUgb2xkLCB1c2VsZXNzIHN0dWZmLiAgQSBxdWljayBjaGVjayBzaG93cyB0aGF0IG1h
bnkKPiBvZiB0aGVzZSBmaWxlcyBoYXZlIHNlZW4gbm8gY2hhbmdlcyBvdGhlciB0aGFuIHR5cG8g
Zml4ZXMgc2luY2UgdGhlCj4gYmVnaW5uaW5nIG9mIHRoZSBHaXQgZXJhLgoKUmlnaHQsIHRoZXJl
IGlzIHNvbWUgZG9jcyB3aGljaCBuZWVkIHRvIGJlIHVwZGF0ZSBvciBldmVuIGRyb3AsIGFuZCBh
IHJlb3JkZXIgd291bGQgYmUgYSB0aW1pbmcgdG8gcHVzaCBlYWNoIG9mIGFyY2ggbWFpbnRhaW5l
ciB0byBkbyBzb21ldGhpbmcsIGlzbid0IGl0PyBBbnl3YXksIHJlb3JkZXJpbmcgIGRvY3VtZW50
cyBsaWtlIGtlcm5lbCBzb3VyY2UgZGlyIGNvdWxkIGJlIG9uZSBvZiBjaG9pY2VzLiA6KQoKPiAK
PiBTbywgaW4gbXkgbWluZCwgdGhpcyBuZWVkcyBzb21lIHRob3VnaHQuICBNYXliZSB3ZSB3YW50
IGEKPiBEb2N1bWVudGF0aW9uL2FyY2ggaW4gdGhlIGVuZCwgYnV0IEknbSBub3QgY29udmluY2Vk
IHRoYXQgd2Ugc2hvdWxkIGp1c3QKPiBjcmVhdGUgaXQgYW5kIGZpbGwgaXQgd2l0aCBhIHNub3cg
c2hvdmVsLiAgVGhpcyBtaWdodCBiZSBhIGdvb2QgdGhpbmcgdG8KPiBkaXNjdXNzIGF0IHRoZSBr
ZXJuZWwgc3VtbWl0IGluIFNlcHRlbWJlci4KClRoYW5rcyBmb3IgY29uc2lkZXJpbmcsIGFueXdh
eSwgaXQgY291bGQgYmUgYSBnb29kIHN0YXJ0IHRvIGdldCBoYW5kcyBkaXJ0eSB3aGV0aGVyIHRo
ZSBhcmNoIGRpciBpcyBuZWVkZWQuIAoKVGhhbmtzCkFsZXgK
