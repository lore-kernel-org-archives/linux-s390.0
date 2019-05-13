Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Date: Mon, 13 May 2019 08:52:41 +0000
Message-ID: <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
In-Reply-To: <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190513085241.CwbAqRfT4AD-BNv6ycJNL377JFUjP7hKf_PblscZCMA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: 'christophe leroy' <christophe.leroy@c-s.fr>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

RnJvbTogY2hyaXN0b3BoZSBsZXJveQ0KPiBTZW50OiAxMCBNYXkgMjAxOSAxODozNQ0KPiBMZSAx
MC8wNS8yMDE5IMOgIDE4OjI0LCBTdGV2ZW4gUm9zdGVkdCBhIMOpY3JpdMKgOg0KPiA+IE9uIEZy
aSwgMTAgTWF5IDIwMTkgMTA6NDI6MTMgKzAyMDANCj4gPiBQZXRyIE1sYWRlayA8cG1sYWRla0Bz
dXNlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gICBzdGF0aWMgY29uc3QgY2hhciAqY2hlY2tfcG9p
bnRlcl9tc2coY29uc3Qgdm9pZCAqcHRyKQ0KPiA+PiAgIHsNCj4gPj4gLQljaGFyIGJ5dGU7DQo+
ID4+IC0NCj4gPj4gICAJaWYgKCFwdHIpDQo+ID4+ICAgCQlyZXR1cm4gIihudWxsKSI7DQo+ID4+
DQo+ID4+IC0JaWYgKHByb2JlX2tlcm5lbF9hZGRyZXNzKHB0ciwgYnl0ZSkpDQo+ID4+ICsJaWYg
KCh1bnNpZ25lZCBsb25nKXB0ciA8IFBBR0VfU0laRSB8fCBJU19FUlJfVkFMVUUocHRyKSkNCj4g
Pj4gICAJCXJldHVybiAiKGVmYXVsdCkiOw0KDQoiZWZhdWx0IiBsb29rcyBhIGJpdCBsaWtlIGEg
c3BlbGxsaW5nIG1pc3Rha2UgZm9yICJkZWZhdWx0Ii4NCg0KPiA+IAk8IFBBR0VfU0laRSA/DQo+
ID4NCj4gPiBkbyB5b3UgbWVhbjogPCBUQVNLX1NJWkUgPw0KPiANCj4gSSBndWVzcyBub3QuDQo+
IA0KPiBVc3VhbGx5LCA8IFBBR0VfU0laRSBtZWFucyBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
KHZpYSB0aGUgbWVtYmVyIG9mIGENCj4gc3RydWN0KQ0KDQpNYXliZSB0aGUgY2FsbGVyIHNob3Vs
ZCBwYXNzIGluIGEgc2hvcnQgYnVmZmVyIHNvIHRoYXQgeW91IGNhbiByZXR1cm4NCiIoZXJyLSVk
KSIgb3IgIihudWxsKyUjeCkiID8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==
