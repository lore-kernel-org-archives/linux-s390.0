Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
Date: Wed, 27 Mar 2019 09:44:56 +0100
MIME-Version: 1.0
In-Reply-To: <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
Content-Language: fr
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

CgpPbiAwMy8yNy8yMDE5IDA4OjAxIEFNLCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOgo+IE9uIDMv
MjcvMTkgMTI6MDYgUE0sIEFsZXhhbmRyZSBHaGl0aSB3cm90ZToKPj4gT24gc3lzdGVtcyB3aXRo
b3V0IENPTlRJR19BTExPQyBhY3RpdmF0ZWQgYnV0IHRoYXQgc3VwcG9ydCBnaWdhbnRpYyAKPj4g
cGFnZXMsCj4+IGJvb3R0aW1lIHJlc2VydmVkIGdpZ2FudGljIHBhZ2VzIGNhbiBub3QgYmUgZnJl
ZWQgYXQgYWxsLiBUaGlzIHBhdGNoCj4+IHNpbXBseSBlbmFibGVzIHRoZSBwb3NzaWJpbGl0eSB0
byBoYW5kIGJhY2sgdGhvc2UgcGFnZXMgdG8gbWVtb3J5Cj4+IGFsbG9jYXRvci4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJlIEdoaXRpIDxhbGV4QGdoaXRpLmZyPgo+PiBBY2tlZC1ieTog
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PiBbc3BhcmNdCj4+Cj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2h1Z2V0bGIuaCAKPj4g
Yi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2h1Z2V0bGIuaAo+PiBpbmRleCBl
YzJhNTVhNTUzYzcuLjcwMTMyODRmMGYxYiAxMDA2NDQKPj4gLS0tIGEvYXJjaC9wb3dlcnBjL2lu
Y2x1ZGUvYXNtL2Jvb2szcy82NC9odWdldGxiLmgKPj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL2Jvb2szcy82NC9odWdldGxiLmgKPj4gQEAgLTM2LDggKzM2LDggQEAgc3RhdGljIGlu
bGluZSBpbnQgaHN0YXRlX2dldF9wc2l6ZShzdHJ1Y3QgaHN0YXRlIAo+PiAqaHN0YXRlKQo+PiDC
oMKgwqDCoMKgIH0KPj4gwqAgfQo+PiDCoCAtI2lmZGVmIENPTkZJR19BUkNIX0hBU19HSUdBTlRJ
Q19QQUdFCj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgZ2lnYW50aWNfcGFnZV9zdXBwb3J0ZWQodm9p
ZCkKPj4gKyNkZWZpbmUgX19IQVZFX0FSQ0hfR0lHQU5USUNfUEFHRV9SVU5USU1FX1NVUFBPUlRF
RAo+PiArc3RhdGljIGlubGluZSBib29sIGdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQo
dm9pZCkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIC8qCj4+IMKgwqDCoMKgwqDCoCAqIFdlIHVzZWQg
Z2lnYW50aWMgcGFnZSByZXNlcnZhdGlvbiB3aXRoIGh5cGVydmlzb3IgYXNzaXN0IGluIAo+PiBz
b21lIGNhc2UuCj4+IEBAIC00OSw3ICs0OSw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBnaWdhbnRp
Y19wYWdlX3N1cHBvcnRlZCh2b2lkKQo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+PiDC
oCB9Cj4+IC0jZW5kaWYKPj4gwqAgwqAgLyogaHVnZXBkIGVudHJ5IHZhbGlkIGJpdCAqLwo+PiDC
oCAjZGVmaW5lIEhVR0VQRF9WQUxfQklUU8KgwqDCoMKgwqDCoMKgICgweDgwMDAwMDAwMDAwMDAw
MDBVTCkKPgo+IElzIHRoYXQgY29ycmVjdCB3aGVuIENPTlRJR19BTExPQyBpcyBub3QgZW5hYmxl
ZD8gSSBndWVzcyB3ZSB3YW50Cj4KPiBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkIHRv
IHJldHVybiBmYWxzZSB3aGVuIENPTlRJR19BTExPQyBpcyAKPiBub3QgZW5hYmxlZCBvbiBhbGwg
YXJjaGl0ZWN0dXJlcyBhbmQgb24gUE9XRVIgd2hlbiBpdCBpcyBlbmFibGVkIHdlIAo+IHdhbnQg
aXQgdG8gYmUgY29uZGl0aW9uYWwgYXMgaXQgaXMgbm93Lgo+Cj4gLWFuZWVzaAo+CgpDT05GSUdf
QVJDSF9IQVNfR0lHQU5USUNfUEFHRSBpcyBzZXQgYnkgZGVmYXVsdCB3aGVuIGFuIGFyY2hpdGVj
dHVyZSAKc3VwcG9ydHMgZ2lnYW50aWMKcGFnZXM6IG9uIGl0cyBvd24sIGl0IGFsbG93cyB0byBh
bGxvY2F0ZSBib290dGltZSBnaWdhbnRpYyBwYWdlcyBBTkQgdG8gCmZyZWUgdGhlbSBhdCBydW50
aW1lCih0aGlzIGlzIHRoZSBnb2FsIG9mIHRoaXMgc2VyaWVzKSwgYnV0IG5vdCB0byBhbGxvY2F0
ZSBydW50aW1lIGdpZ2FudGljIApwYWdlcy4KSWYgQ09OVElHX0FMTE9DIGlzIHNldCwgaXQgYWxs
b3dzIGluIGFkZGl0aW9uIHRvIGFsbG9jYXRlIHJ1bnRpbWUgCmdpZ2FudGljIHBhZ2VzLgoKSSBy
ZS1pbnRyb2R1Y2VkIHRoZSBydW50aW1lIGNoZWNrcyBiZWNhdXNlIHdlIGNhbid0IGtub3cgYXQg
Y29tcGlsZSB0aW1lIAppZiBwb3dlcnBjIGNhbgpvciBub3Qgc3VwcG9ydCBnaWdhbnRpYyBwYWdl
cy4KClNvIGZvciBhbGwgYXJjaGl0ZWN0dXJlcywgZ2lnYW50aWNfcGFnZV9ydW50aW1lX3N1cHBv
cnRlZCBvbmx5IGRlcGVuZHMgb24KQ09ORklHX0FSQ0hfSEFTX0dJR0FOVElDX1BBR0UgZW5hYmxl
ZCBvciBub3QuIFRoZSBwb3NzaWJpbGl0eSB0byAKYWxsb2NhdGUgcnVudGltZQpnaWdhbnRpYyBw
YWdlcyBpcyBkZWFsdCB3aXRoIGFmdGVyIHRob3NlIHJ1bnRpbWUgY2hlY2tzLgoKQnkgdGhlIHdh
eSwgSSBmb3Jnb3QgdG8gYXNrIHlvdSB3aHkgeW91IHRoaW5rIHRoYXQgaWYgYW4gYXJjaCBjYW5u
b3QgCmFsbG9jYXRlIHJ1bnRpbWUgZ2lnYW50aWMKcGFnZXMsIGl0IHNob3VsZCBub3QgYmUgYWJs
ZSB0byBmcmVlIGJvb3R0aW1lIGdpZ2FudGljIHBhZ2VzID8KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
