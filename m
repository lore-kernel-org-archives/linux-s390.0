Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:24344 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507878AbgJ0Wo0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Oct 2020 18:44:26 -0400
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in
 the direct map
Date: Tue, 27 Oct 2020 22:44:21 +0000
Message-ID: <ce66dcf2bbc17d40bcbe752868edb13976b3f1bb.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <20201025101555.3057-3-rppt@kernel.org>
         <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
         <20201026091554.GB1154158@kernel.org>
         <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
         <20201027084902.GH1154158@kernel.org>
In-Reply-To: <20201027084902.GH1154158@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B57301ABB1B231459300569F98D25757@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "rppt@kernel.org" <rppt@kernel.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "will@kernel.org" <will@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDEwOjQ5ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAwNjo1NzozMlBNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjAtMTAtMjYgYXQgMTE6MTUgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAxMjozODozMkFN
ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUA0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IE9uIFN1biwg
MjAyMC0xMC0yNSBhdCAxMjoxNSArMDIwMCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gPiA+ID4g
PiBGcm9tOiBNaWtlIFJhcG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gV2hlbiBERUJVR19QQUdFQUxMT0Mgb3IgQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVAg
aXMgZW5hYmxlZCBhDQo+ID4gPiA+ID4gcGFnZQ0KPiA+ID4gPiA+IG1heQ0KPiA+ID4gPiA+IGJl
DQo+ID4gPiA+ID4gbm90IHByZXNlbnQgaW4gdGhlIGRpcmVjdCBtYXAgYW5kIGhhcyB0byBiZSBl
eHBsaWNpdGx5IG1hcHBlZA0KPiA+ID4gPiA+IGJlZm9yZQ0KPiA+ID4gPiA+IGl0DQo+ID4gPiA+
ID4gY291bGQgYmUgY29waWVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIGFybTY0IGl0IGlz
IHBvc3NpYmxlIHRoYXQgYSBwYWdlIHdvdWxkIGJlIHJlbW92ZWQgZnJvbSB0aGUNCj4gPiA+ID4g
PiBkaXJlY3QNCj4gPiA+ID4gPiBtYXANCj4gPiA+ID4gPiB1c2luZyBzZXRfZGlyZWN0X21hcF9p
bnZhbGlkX25vZmx1c2goKSBidXQNCj4gPiA+ID4gPiBfX2tlcm5lbF9tYXBfcGFnZXMoKQ0KPiA+
ID4gPiA+IHdpbGwNCj4gPiA+ID4gPiByZWZ1c2UNCj4gPiA+ID4gPiB0byBtYXAgdGhpcyBwYWdl
IGJhY2sgaWYgREVCVUdfUEFHRUFMTE9DIGlzIGRpc2FibGVkLg0KPiA+ID4gPiANCj4gPiA+ID4g
SXQgbG9va3MgdG8gbWUgdGhhdCBhcm02NCBfX2tlcm5lbF9tYXBfcGFnZXMoKSB3aWxsIHN0aWxs
DQo+ID4gPiA+IGF0dGVtcHQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gbWFwIGl0IGlmIHJvZGF0YV9m
dWxsIGlzIHRydWUsIGhvdyBkb2VzIHRoaXMgaGFwcGVuPw0KPiA+ID4gDQo+ID4gPiBVbmxlc3Mg
SSBtaXNyZWFkIHRoZSBjb2RlLCBhcm02NCByZXF1aXJlcyBib3RoIHJvZGF0YV9mdWxsIGFuZA0K
PiA+ID4gZGVidWdfcGFnZWFsbG9jX2VuYWJsZWQoKSB0byBiZSB0cnVlIGZvciBfX2tlcm5lbF9t
YXBfcGFnZXMoKSB0bw0KPiA+ID4gZG8NCj4gPiA+IGFueXRoaW5nLg0KPiA+ID4gQnV0IHJvZGF0
YV9mdWxsIGNvbmRpdGlvbiBhcHBsaWVzIHRvIHNldF9kaXJlY3RfbWFwXypfbm9mbHVzaCgpDQo+
ID4gPiBhcw0KPiA+ID4gd2VsbCwNCj4gPiA+IHNvIHdpdGggIXJvZGF0YV9mdWxsIHRoZSBsaW5l
YXIgbWFwIHdvbid0IGJlIGV2ZXIgY2hhbmdlZC4NCj4gPiANCj4gPiBIbW0sIGxvb2tzIHRvIG1l
IHRoYXQgX19rZXJuZWxfbWFwX3BhZ2VzKCkgd2lsbCBvbmx5IHNraXAgaXQgaWYNCj4gPiBib3Ro
DQo+ID4gZGVidWcgcGFnZWFsbG9jIGFuZCByb2RhdGFfZnVsbCBhcmUgZmFsc2UuDQo+ID4gDQo+
ID4gQnV0IG5vdyBJJ20gd29uZGVyaW5nIGlmIG1heWJlIHdlIGNvdWxkIHNpbXBsaWZ5IHRoaW5n
cyBieSBqdXN0DQo+ID4gbW92aW5nDQo+ID4gdGhlIGhpYmVybmF0ZSB1bm1hcHBlZCBwYWdlIGxv
Z2ljIG9mZiBvZiB0aGUgZGlyZWN0IG1hcC4gT24geDg2LA0KPiA+IHRleHRfcG9rZSgpIHVzZWQg
dG8gdXNlIHRoaXMgcmVzZXJ2ZWQgZml4bWFwIHB0ZSB0aGluZyB0aGF0IGl0DQo+ID4gY291bGQN
Cj4gPiByZWx5IG9uIHRvIHJlbWFwIG1lbW9yeSB3aXRoLiBJZiBoaWJlcm5hdGUgaGFkIHNvbWUg
c2VwYXJhdGUgcHRlDQo+ID4gZm9yDQo+ID4gcmVtYXBwaW5nIGxpa2UgdGhhdCwgdGhlbiB3ZSBj
b3VsZCBub3QgaGF2ZSBhbnkgZGlyZWN0IG1hcA0KPiA+IHJlc3RyaWN0aW9ucw0KPiA+IGNhdXNl
ZCBieSBpdC9rZXJuZWxfbWFwX3BhZ2VzKCksIGFuZCBpdCB3b3VsZG4ndCBoYXZlIHRvIHdvcnJ5
DQo+ID4gYWJvdXQNCj4gPiByZWx5aW5nIG9uIGFueXRoaW5nIGVsc2UuDQo+IA0KPiBXZWxsLCB0
aGVyZSBpcyBtYXBfa2VybmVsX3JhbmdlKCkgdGhhdCBjYW4gYmUgdXNlZCBieSBoaWJlcm5hdGlv
biBhcw0KPiB0aGVyZSBpcyBubyByZXF1aXJlbWVudCBmb3IgcGFydGljdWxhciB2aXJ0dWFsIGFk
ZHJlc3MsIGJ1dCB0aGF0DQo+IHdvdWxkDQo+IGJlIHF1aXRlIGNvc3RseSBpZiBkb25lIGZvciBl
dmVyeSBwYWdlLg0KPiANCj4gTWF5YmUgd2UgY2FuIGRvIHNvbXRoaW5nIGxpa2UNCj4gDQo+IAlp
ZiAoa2VybmVsX3BhZ2VfcHJlc2VudChzX3BhZ2UpKSB7DQo+IAkJZG9fY29weV9wYWdlKGRzdCwg
cGFnZV9hZGRyZXNzKHNfcGFnZSkpOw0KPiAJfSBlbHNlIHsNCj4gCQltYXBfa2VybmVsX3Jhbmdl
X25vZmx1c2gocGFnZV9hZGRyZXNzKHBhZ2UpLCBQQUdFX1NJWkUsDQo+IAkJCQkJIFBST1RfUkVB
RCwgJnBhZ2UpOw0KPiAJCWRvX2NvcHlfcGFnZShkc3QsIHBhZ2VfYWRkcmVzcyhzX3BhZ2UpKTsN
Cj4gCQl1bm1hcF9rZXJuZWxfcmFuZ2Vfbm9mbHVzaChwYWdlX2FkZHJlc3MocGFnZSksDQo+IFBB
R0VfU0laRSk7DQo+IAl9DQo+IA0KPiBCdXQgaXQgc2VlbXMgdGhhdCBhIHByZXJlcXVpc2l0ZSBm
b3IgY2hhbmdpbmcgdGhlIHdheSBhIHBhZ2UgaXMNCj4gbWFwcGVkDQo+IGluIHNhZmVfY29weV9w
YWdlKCkgd291bGQgYmUgdG8gdGVhY2ggaGliZXJuYXRpb24gdGhhdCBhIG1hcHBpbmcgaGVyZQ0K
PiBtYXkgZmFpbC4NCj4gDQpZZWEgdGhhdCBpcyB3aGF0IEkgbWVhbnQsIHRoZSBkaXJlY3QgbWFw
IGNvdWxkIHN0aWxsIGJlIHVzZWQgZm9yIG1hcHBlZA0KcGFnZXMuDQoNCkJ1dCBmb3IgdGhlIHVu
bWFwcGVkIGNhc2UgaXQgY291bGQgaGF2ZSBhIHByZS1zZXR1cCA0ayBwdGUgZm9yIHNvbWUgbm9u
DQpkaXJlY3QgbWFwIGFkZHJlc3MuIFRoZW4ganVzdCBjaGFuZ2UgdGhlIHB0ZSB0byBwb2ludCB0
byBhbnkgdW5tYXBwZWQNCmRpcmVjdCBtYXAgcGFnZSB0aGF0IHdhcyBlbmNvdW50ZXJlZC4gVGhl
IHBvaW50IHdvdWxkIGJlIHRvIGdpdmUNCmhpYmVybmF0ZSBzb21lIDRrIHB0ZSBvZiBpdHMgb3du
IHRvIG1hbmlwdWxhdGUgc28gdGhhdCBpdCBjYW4ndCBmYWlsLg0KDQpZZXQgYW5vdGhlciBvcHRp
b24gd291bGQgYmUgaGF2ZSBoaWJlcm5hdGVfbWFwX3BhZ2UoKSBqdXN0IG1hcCBsYXJnZQ0KcGFn
ZXMgaWYgaXQgZmluZHMgdGhlbS4NCg0KU28gd2UgY291bGQgdGVhY2ggaGliZXJuYXRlIHRvIGhh
bmRsZSBtYXBwaW5nIGZhaWx1cmVzLCBPUiB3ZSBjb3VsZA0KY2hhbmdlIGl0IHNvIGl0IGRvZXNu
J3QgcmVseSBvbiBkaXJlY3QgbWFwIHBhZ2Ugc2l6ZXMgaW4gb3JkZXIgdG8NCnN1Y2NlZWQuIFRo
ZSBsYXR0ZXIgc2VlbXMgYmV0dGVyIHRvIG1lIHNpbmNlIHRoZXJlIGlzbid0IGEgcmVhc29uIHdo
eQ0KaXQgc2hvdWxkIGhhdmUgdG8gZmFpbCBhbmQgdGhlIHJlc3VsdGluZyBsb2dpYyBtaWdodCBi
ZSBzaW1wbGVyLiBCb3RoDQpzZWVtIGxpa2UgaW1wcm92ZW1lbnRzIGluIHJvYnVzdG5lc3MgdGhv
dWdoLg0KDQo=
