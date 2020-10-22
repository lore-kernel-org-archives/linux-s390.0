Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27612 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509965AbgJVJDB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Oct 2020 05:03:01 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Buggy commit tracked to: "Re: [PATCH 2/9] iov_iter: move
 rw_copy_check_uvector() into lib/iov_iter.c"
Date: Thu, 22 Oct 2020 09:02:54 +0000
Message-ID: <789c746b1abc45598fe1e44c6f60104d@AcuMS.aculab.com>
References: <20200925045146.1283714-1-hch@lst.de>
 <20200925045146.1283714-3-hch@lst.de> <20201021161301.GA1196312@kroah.com>
 <20201021233914.GR3576660@ZenIV.linux.org.uk>
 <20201022082654.GA1477657@kroah.com>
 <80a2e5fa-718a-8433-1ab0-dd5b3e3b5416@redhat.com>
 <5d2ecb24db1e415b8ff88261435386ec@AcuMS.aculab.com>
 <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
In-Reply-To: <df2e0758-b8ed-5aec-6adc-a18f499c0179@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
List-ID: <linux-s390.vger.kernel.org>
To: 'David Hildenbrand' <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Nick Desaulniers <ndesaulniers@google.com>
Cc: Christoph Hellwig <hch@lst.de>, "kernel-team@android.com" <kernel-team@android.com>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNCj4gU2VudDogMjIgT2N0b2JlciAyMDIwIDA5OjQ5DQou
Li4NCj4gPj4+IEJ1dCwgdGhpcyBsb29rcyBub3cgdG8gYmUgYSBjb21waWxlciBidWcuICBJJ20g
dXNpbmcgdGhlIGxhdGVzdCB2ZXJzaW9uDQo+ID4+PiBvZiBjbGFuZyBhbmQgaWYgSSBwdXQgIm5v
aW5saW5lIiBhdCB0aGUgZnJvbnQgb2YgdGhlIGZ1bmN0aW9uLA0KPiA+Pj4gZXZlcnl0aGluZyB3
b3Jrcy4NCj4gPj4NCj4gPj4gV2VsbCwgdGhlIGNvbXBpbGVyIGNhbiBkbyBtb3JlIGludmFzaXZl
IG9wdGltaXphdGlvbnMgd2hlbiBpbmxpbmluZy4gSWYNCj4gPj4geW91IGhhdmUgYnVnZ3kgY29k
ZSB0aGF0IHJlbGllcyBvbiBzb21lIHVuc3BlY2lmaWVkIGJlaGF2aW9yLCBpbmxpbmluZw0KPiA+
PiBjYW4gY2hhbmdlIHRoZSBiZWhhdmlvciAuLi4gYnV0IGdvaW5nIG92ZXIgdGhhdCBjb2RlLCB0
aGVyZSBpc24ndCB0b28NCj4gPj4gbXVjaCBhY3Rpb24gZ29pbmcgb24uIEF0IGxlYXN0IG5vdGhp
bmcgc2NyZWFtZWQgYXQgbWUuDQo+ID4NCj4gPiBBcGFydCBmcm9tIGFsbCB0aGUgb3B0aW1pc2F0
aW9ucyB0aGF0IGdldCByaWQgb2ZmIHRoZSAncGFzcyBiZSByZWZlcmVuY2UnDQo+ID4gcGFyYW1l
dGVycyBhbmQgc3RyYW5nZSBjb25kaXRpb25hbCB0ZXN0cy4NCj4gPiBQbGVudHkgb2Ygc2NvcGUg
Zm9yIHRoZSBjb21waWxlciBnZXR0aW5nIGl0IHdyb25nLg0KPiA+IEJ1dCBub3RoaW5nIGV2ZW4g
dmFndWVseSBpbGxlZ2FsLg0KPiANCj4gTm90IHRoZSBmaXJzdCB0aW1lIHRoYXQgcGVvcGxlIGJs
YW1lIHRoZSBjb21waWxlciB0byB0aGVuIGZpZ3VyZSBvdXQNCj4gdGhhdCBzb21ldGhpbmcgZWxz
ZSBpcyB3cm9uZyAuLi4gYnV0IG1heWJlIHRoaXMgdGltZSBpcyBkaWZmZXJlbnQgOikNCg0KVXN1
YWxseSBkb3duIHRvIG1pc3NpbmcgYXNtICdtZW1vcnknIGNvbnN0cmFpbnRzLi4uDQoNCk5lZWQg
dG8gcmVhZCB0aGUgb2JqIGZpbGUgdG8gc2VlIHdoYXQgdGhlIGNvbXBpbGVyIGRpZC4NCg0KVGhl
IGNvZGUgbXVzdCBiZSAnYXBwcm94aW1hdGVseSByaWdodCcgb3Igbm90aGluZyB3b3VsZCBydW4u
DQpTbyBJJ2QgZ3Vlc3MgaXQgaGFzIHRvIGRvIHdpdGggPiA4IGZyYWdtZW50cy4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==
