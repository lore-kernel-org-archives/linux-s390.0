Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
Date: Wed, 28 Oct 2020 21:03:31 +0000
Message-ID: <9e77d0a939eda3029d6ae89bd14d7f1465b0559d.camel@intel.com>
References: <20201025101555.3057-1-rppt@kernel.org>
         <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
         <20201026090526.GA1154158@kernel.org>
         <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
         <20201027083816.GG1154158@kernel.org>
         <20201028112011.GB27927@willie-the-truck>
         <20201028113059.GG1428094@kernel.org>
In-Reply-To: <20201028113059.GG1428094@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A57DF794371B74D8EDF50341EA0B257@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: "will@kernel.org" <will@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>
Cc: "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "penberg@kernel.org" <penberg@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "tglx@linutronix.de" <tglx@linutronix.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

T24gV2VkLCAyMDIwLTEwLTI4IGF0IDEzOjMwICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAyOCwgMjAyMCBhdCAxMToyMDoxMkFNICswMDAwLCBXaWxsIERlYWNvbiB3
cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAyNywgMjAyMCBhdCAxMDozODoxNkFNICswMjAwLCBNaWtl
IFJhcG9wb3J0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCBPY3QgMjYsIDIwMjAgYXQgMDY6MDU6MzBQ
TSArMDAwMCwgRWRnZWNvbWJlLCBSaWNrIFANCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24s
IDIwMjAtMTAtMjYgYXQgMTE6MDUgKzAyMDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+ID4gPiA+
ID4gT24gTW9uLCBPY3QgMjYsIDIwMjAgYXQgMDE6MTM6NTJBTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFANCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFN1biwgMjAyMC0xMC0yNSBh
dCAxMjoxNSArMDIwMCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSW5kZWVk
LCBmb3IgYXJjaGl0ZWN0dXJlcyB0aGF0IGRlZmluZQ0KPiA+ID4gPiA+ID4gPiBDT05GSUdfQVJD
SF9IQVNfU0VUX0RJUkVDVF9NQVANCj4gPiA+ID4gPiA+ID4gaXQgaXMNCj4gPiA+ID4gPiA+ID4g
cG9zc2libGUgdGhhdCBfX2tlcm5lbF9tYXBfcGFnZXMoKSB3b3VsZCBmYWlsLCBidXQgc2luY2UN
Cj4gPiA+ID4gPiA+ID4gdGhpcw0KPiA+ID4gPiA+ID4gPiBmdW5jdGlvbiBpcw0KPiA+ID4gPiA+
ID4gPiB2b2lkLCB0aGUgZmFpbHVyZSB3aWxsIGdvIHVubm90aWNlZC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gQ291bGQgeW91IGVsYWJvcmF0ZSBvbiBob3cgdGhpcyBjb3VsZCBoYXBwZW4/
IERvIHlvdSBtZWFuDQo+ID4gPiA+ID4gPiBkdXJpbmcNCj4gPiA+ID4gPiA+IHJ1bnRpbWUgdG9k
YXkgb3IgaWYgc29tZXRoaW5nIG5ldyB3YXMgaW50cm9kdWNlZD8NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBBIGZhaWx1cmUgaW5fX2tlcm5lbF9tYXBfcGFnZXMoKSBtYXkgaGFwcGVuIHRvZGF5LiBG
b3INCj4gPiA+ID4gPiBpbnN0YW5jZSwgb24NCj4gPiA+ID4gPiB4ODYNCj4gPiA+ID4gPiBpZiB0
aGUga2VybmVsIGlzIGJ1aWx0IHdpdGggREVCVUdfUEFHRUFMTE9DLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ICAgICAgICAgX19rZXJuZWxfbWFwX3BhZ2VzKHBhZ2UsIDEsIDApOw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IHdpbGwgbmVlZCB0byBzcGxpdCwgc2F5LCAyTSBwYWdlIGFuZCBkdXJpbmcg
dGhlIHNwbGl0IGFuDQo+ID4gPiA+ID4gYWxsb2NhdGlvbg0KPiA+ID4gPiA+IG9mDQo+ID4gPiA+
ID4gcGFnZSB0YWJsZSBjb3VsZCBmYWlsLg0KPiA+ID4gPiANCj4gPiA+ID4gT24geDg2IGF0IGxl
YXN0LCBERUJVR19QQUdFQUxMT0MgZXhwZWN0cyB0byBuZXZlciBoYXZlIHRvIGJyZWFrDQo+ID4g
PiA+IGEgcGFnZQ0KPiA+ID4gPiBvbiB0aGUgZGlyZWN0IG1hcCBhbmQgZXZlbiBkaXNhYmxlcyBs
b2NraW5nIGluIGNwYSBiZWNhdXNlIGl0DQo+ID4gPiA+IGFzc3VtZXMNCj4gPiA+ID4gdGhpcy4g
SWYgdGhpcyBpcyBoYXBwZW5pbmcgc29tZWhvdyBhbnl3YXkgdGhlbiB3ZSBzaG91bGQNCj4gPiA+
ID4gcHJvYmFibHkgZml4DQo+ID4gPiA+IHRoYXQuIEV2ZW4gaWYgaXQncyBhIGRlYnVnIGZlYXR1
cmUsIGl0IHdpbGwgbm90IGJlIGFzIHVzZWZ1bCBpZg0KPiA+ID4gPiBpdCBpcw0KPiA+ID4gPiBj
YXVzaW5nIGl0cyBvd24gY3Jhc2hlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbSBzdGlsbCB3b25k
ZXJpbmcgaWYgdGhlcmUgaXMgc29tZXRoaW5nIEknbSBtaXNzaW5nIGhlcmUuIEl0DQo+ID4gPiA+
IHNlZW1zDQo+ID4gPiA+IGxpa2UgeW91IGFyZSBzYXlpbmcgdGhlcmUgaXMgYSBidWcgaW4gc29t
ZSBhcmNoJ3MsIHNvIGxldCdzIGFkZA0KPiA+ID4gPiBhIFdBUk4NCj4gPiA+ID4gaW4gY3Jvc3Mt
YXJjaCBjb2RlIHRvIGxvZyBpdCBhcyBpdCBjcmFzaGVzLiBBIHdhcm4gYW5kIG1ha2luZw0KPiA+
ID4gPiB0aGluZ3MNCj4gPiA+ID4gY2xlYXJlciBzZWVtIGxpa2UgZ29vZCBpZGVhcywgYnV0IGlm
IHRoZXJlIGlzIGEgYnVnIHdlIHNob3VsZA0KPiA+ID4gPiBmaXggaXQuDQo+ID4gPiA+IFRoZSBj
b2RlIGFyb3VuZCB0aGUgY2FsbGVycyBzdGlsbCBmdW5jdGlvbmFsbHkgYXNzdW1lIHJlLQ0KPiA+
ID4gPiBtYXBwaW5nIGNhbid0DQo+ID4gPiA+IGZhaWwuDQo+ID4gPiANCj4gPiA+IE9oLCBJJ3Zl
IG1lYW50IHg4NiBrZXJuZWwgKndpdGhvdXQqIERFQlVHX1BBR0VBTExPQywgYW5kIGluZGVlZA0K
PiA+ID4gdGhlIGNhbGwNCj4gPiA+IHRoYXQgdW5tYXBzIHBhZ2VzIGJhY2sgaW4gc2FmZV9jb3B5
X3BhZ2Ugd2lsbCBqdXN0IHJlc2V0IGEgNEsNCj4gPiA+IHBhZ2UgdG8NCj4gPiA+IE5QIGJlY2F1
c2Ugd2hhdGV2ZXIgbWFkZSBpdCBOUCBhdCB0aGUgZmlyc3QgcGxhY2UgYWxyZWFkeSBkaWQgdGhl
DQo+ID4gPiBzcGxpdC4NCj4gPiA+IA0KPiA+ID4gU3RpbGwsIG9uIGFybTY0IHdpdGggREVCVUdf
UEFHRUFMTE9DPW4gdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSBvZg0KPiA+ID4gYSByYWNlDQo+ID4g
PiBiZXR3ZWVuIG1hcC91bm1hcCBkYW5jZSBpbiBfX3Z1bm1hcCgpIGFuZCBzYWZlX2NvcHlfcGFn
ZSgpIHRoYXQNCj4gPiA+IG1heQ0KPiA+ID4gY2F1c2UgYWNjZXNzIHRvIHVubWFwcGVkIG1lbW9y
eToNCj4gPiA+IA0KPiA+ID4gX192dW5tYXAoKQ0KPiA+ID4gICAgIHZtX3JlbW92ZV9tYXBwaW5n
cygpDQo+ID4gPiAgICAgICAgIHNldF9kaXJlY3RfbWFwX2ludmFsaWQoKQ0KPiA+ID4gCQkJCQlz
YWZlX2NvcHlfcGFnZSgpCQ0KPiA+ID4gCQkJCQkgICAgX19rZXJuZWxfbWFwX3BhZ2VzKCkNCj4g
PiA+IAkJCQkJICAgIAlyZXR1cm4NCj4gPiA+IAkJCQkJICAgIGRvX2NvcHlfcGFnZSgpIC0+IGZh
dWx0DQo+ID4gPiAJCQkJCSAgIAkNCj4gPiA+IFRoaXMgaXMgYSB0aGVvcmV0aWNhbCBidWcsIGJ1
dCBpdCBpcyBzdGlsbCBub3QgbmljZSA6KSAJCQ0KPiA+ID4gCQkJCQkNCj4gPiANCj4gPiBKdXN0
IHRvIGNsYXJpZnk6IHRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHRoaXMgcHJvYmxlbSwgcmlnaHQ/
DQo+IA0KPiBZZXMuDQo+IA0KDQpXZWxsLCBub3cgSSdtIGNvbmZ1c2VkIGFnYWluLg0KDQpBcyBE
YXZpZCBwb2ludGVkLCBfX3Z1bm1hcCgpIHNob3VsZCBub3QgYmUgZXhlY3V0aW5nIHNpbXVsdGFu
ZW91c2x5DQp3aXRoIHRoZSBoaWJlcm5hdGUgb3BlcmF0aW9uIGJlY2F1c2UgaGliZXJuYXRlIGNh
bid0IHNuYXBzaG90IHdoaWxlDQpkYXRhIGl0IG5lZWRzIHRvIHNhdmUgaXMgc3RpbGwgdXBkYXRp
bmcuIElmIGEgdGhyZWFkIHdhcyBwYXVzZWQgd2hlbiBhDQpwYWdlIHdhcyBpbiBhbiAiaW52YWxp
ZCIgc3RhdGUsIGl0IHNob3VsZCBiZSByZW1hcHBlZCBieSBoaWJlcm5hdGUNCmJlZm9yZSB0aGUg
Y29weS4NCg0KVG8gbGV2ZWwgc2V0LCBiZWZvcmUgcmVhZGluZyB0aGlzIG1haWwsIG15IHRha2Vh
d2F5cyBmcm9tIHRoZQ0KZGlzY3Vzc2lvbnMgb24gcG90ZW50aWFsIGhpYmVybmF0ZS9kZWJ1ZyBw
YWdlIGFsbG9jIHByb2JsZW1zIHdlcmU6DQoNClBvdGVudGlhbCBSSVNDLVYgaXNzdWU6DQpEb2Vz
bid0IGhhdmUgaGliZXJuYXRlIHN1cHBvcnQNCg0KUG90ZW50aWFsIEFSTSBpc3N1ZToNClRoZSBs
b2dpYyBhcm91bmQgd2hlbiBpdCdzIGNwYSBkZXRlcm1pbmVzIHBhZ2VzIG1pZ2h0IGJlIHVubWFw
cGVkIGxvb2tzDQpjb3JyZWN0IGZvciBjdXJyZW50IGNhbGxlcnMuDQoNClBvdGVudGlhbCB4ODYg
cGFnZSBicmVhayBpc3N1ZToNClNlZW1zIHRvIGJlIG9rIGZvciBub3csIGJ1dCBhIG5ldyBzZXRf
bWVtb3J5X25wKCkgY2FsbGVyIGNvdWxkIHZpb2xhdGUNCmFzc3VtcHRpb25zIGluIGhpYmVybmF0
ZS4NCg0KTm9uLW9idmlvdXMgdGhvcm55IGxvZ2ljOiANCkdlbmVyYWwgYWdyZWVtZW50IGl0IHdv
dWxkIGJlIGdvb2QgdG8gc2VwYXJhdGUgZGVwZW5kZW5jaWVzLg0KDQpCZWhhdmlvciBvZiBWMSBv
ZiB0aGlzIHBhdGNoc2V0Og0KTm8gZnVuY3Rpb25hbCBjaGFuZ2Ugb3RoZXIgdGhhbiBhZGRpdGlv
biBvZiBhIHdhcm4gaW4gaGliZXJuYXRlLg0KDQoNClNvICJkb2VzIHRoaXMgZml4IHRoZSBwcm9i
bGVtIiwgInllcyIgbGVhdmVzIG1lIGEgYml0IGNvbmZ1c2VkLi4uIE5vdA0Kc2F5aW5nIHRoZXJl
IGNvdWxkbid0IGJlIGFueSBwcm9ibGVtcywgZXNwZWNpYWxseSBkdWUgdG8gdGhlIHRob3JuaW5l
c3MNCmFuZCBjcm9zcyBhcmNoIHN0cmlkZSwgYnV0IHdoYXQgaXMgaXQgZXhhY3RseSBhbmQgaG93
IGRvZXMgdGhpcyBzZXJpZXMNCmZpeCBpdD8NCg0K
