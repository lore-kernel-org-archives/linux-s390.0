From: "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: RE: [PATCH 2/4] x86: convert threshold_bank.cpus from atomic_t to
 refcount_t
Date: Mon, 20 Feb 2017 12:20:04 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B41C4D921@IRSMSX102.ger.corp.intel.com>
References: <1487588781-15123-1-git-send-email-elena.reshetova@intel.com>
 <1487588781-15123-3-git-send-email-elena.reshetova@intel.com>
 <20170220111727.7vohleiu2btmsx3g@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170220111727.7vohleiu2btmsx3g@pd.tnic>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Luck, Tony" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

DQo+IE9uIE1vbiwgRmViIDIwLCAyMDE3IGF0IDAxOjA2OjE5UE0gKzAyMDAsIEVsZW5hIFJlc2hl
dG92YSB3cm90ZToNCj4gPiByZWZjb3VudF90IHR5cGUgYW5kIGNvcnJlc3BvbmRpbmcgQVBJIHNo
b3VsZCBiZQ0KPiA+IHVzZWQgaW5zdGVhZCBvZiBhdG9taWNfdCB3aGVuIHRoZSB2YXJpYWJsZSBp
cyB1c2VkIGFzDQo+ID4gYSByZWZlcmVuY2UgY291bnRlci4gVGhpcyBhbGxvd3MgdG8gYXZvaWQg
YWNjaWRlbnRhbA0KPiA+IHJlZmNvdW50ZXIgb3ZlcmZsb3dzIHRoYXQgbWlnaHQgbGVhZCB0byB1
c2UtYWZ0ZXItZnJlZQ0KPiA+IHNpdHVhdGlvbnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBF
bGVuYSBSZXNoZXRvdmEgPGVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFucyBMaWxqZXN0cmFuZCA8aXNoa2FtaWVsQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBXaW5kc29yIDxkd2luZHNvckBnbWFpbC5jb20+DQo+IA0KPiBUaGF0IFNPQiBj
aGFpbiB0ZWxscyBtZSB0aGF0IHlvdSB3cm90ZSB0aGUgcGF0Y2ggYW5kIEhhbnMsIEtlZXMgYW5k
DQo+IERhdmlkIGhhbmRsZWQgaXQgaW4gc29tZSB3YXkgYW5kIHRoZSBsYXN0IG9uZSAtIERhdmlk
IC0gaXMgc2VuZGluZyBpdCB0bw0KPiBtZS4gSXQgZG9lc24ndCBsb29rIGxpa2UgdGhhdCB0aG91
Z2guDQo+IA0KPiBTbyB3aGF0IGFyZSB5b3UgdHJ5aW5nIHRvIGV4cHJlc3Mgd2l0aCBpdD8NCg0K
V2hvbGUgcmVmY291bnQgY29udmVyc2lvbiB3YXMgYSBsb25nIHBpZWNlIG9mIHdvcmsgYW5kIHRo
ZSBhYm92ZSBwZW9wbGUgY29udHJpYnV0ZWQgdG8gdGhpcyBjb2RlIGVpdGhlciBhcw0Kd3JpdGVz
IG9yIHJldmlld2VycyBvciBib3RoLiAgSSBhbSBwcmltYXJ5IHdyaXRlciBvZiB0aGUgY29kZSBh
bmQgSSBhbSBoYW5kaW5nIHBhdGNoZXMgaW4gb3VyIHRyZWUgYW5kIHNlbmRpbmcgdGhlbSBvdXQs
IA0Kc28gaG93IGV4YWN0bHkgdGhlIGFib3ZlIHNob3VsZCBsb29rIGxpa2U/IA0KDQpQbGVhc2Ug
bm90ZSB0aGF0IHdlIGhhdmUgYWJvdXQgMzAwIHBhdGNoZXMgYW5kIGlmIEkgaGF2ZSB0byBtb2Rp
ZnkgZWFjaCBzaWduLW9mZiB0bw0KcmVmbGVjdCB3aG8gY29udHJpYnV0ZWQgdG8gZWFjaCBjb21t
aXQgaW4gd2hhdCBwYXJ0aWN1bGFyIHdheSwgSSB3aWxsIGdvIGluc2FuZS4gIA0KDQpCZXN0IFJl
Z2FyZHMsDQpFbGVuYS4NCg==
