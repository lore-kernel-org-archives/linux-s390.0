Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
In-Reply-To: <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
 <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
 <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
Date: Wed, 27 Mar 2019 15:35:13 +0530
MIME-Version: 1.0
Message-Id: <87pnqcws2u.fsf@linux.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

QWxleGFuZHJlIEdoaXRpIDxhbGV4QGdoaXRpLmZyPiB3cml0ZXM6Cgo+IE9uIDAzLzI3LzIwMTkg
MDk6NTUgQU0sIEFuZWVzaCBLdW1hciBLLlYgd3JvdGU6Cj4+IE9uIDMvMjcvMTkgMjoxNCBQTSwg
QWxleGFuZHJlIEdoaXRpIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAwMy8yNy8yMDE5IDA4OjAxIEFN
LCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOgo+Pj4+IE9uIDMvMjcvMTkgMTI6MDYgUE0sIEFsZXhh
bmRyZSBHaGl0aSB3cm90ZToKPgoKLi4uLi4KCj4+Cj4+IFRoaXMgaXMgbm93Cj4+ICNkZWZpbmUg
X19IQVZFX0FSQ0hfR0lHQU5USUNfUEFHRV9SVU5USU1FX1NVUFBPUlRFRAo+PiBzdGF0aWMgaW5s
aW5lIGJvb2wgZ2lnYW50aWNfcGFnZV9ydW50aW1lX3N1cHBvcnRlZCh2b2lkKQo+PiB7Cj4+IGlm
IChmaXJtd2FyZV9oYXNfZmVhdHVyZShGV19GRUFUVVJFX0xQQVIpICYmICFyYWRpeF9lbmFibGVk
KCkpCj4+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKPj4KPj4gwqDCoMKgwqByZXR1cm4g
dHJ1ZTsKPj4gfQo+Pgo+Pgo+PiBJIGFtIHdvbmRlcmluZyB3aGV0aGVyIGl0IHNob3VsZCBiZQo+
Pgo+PiAjZGVmaW5lIF9fSEFWRV9BUkNIX0dJR0FOVElDX1BBR0VfUlVOVElNRV9TVVBQT1JURUQK
Pj4gc3RhdGljIGlubGluZSBib29sIGdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQodm9p
ZCkKPj4gewo+Pgo+PiDCoMKgIGlmICghSVNfRU5BQkxFRChDT05GSUdfQ09OVElHX0FMTE9DKSkK
Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Cj4gSSBkb24ndCB0aGluayB0aGlzIHRl
c3Qgc2hvdWxkIGhhcHBlbiBoZXJlLCBDT05GSUdfQ09OVElHX0FMTE9DIG9ubHkgYWxsb3dzCj4g
dG8gYWxsb2NhdGUgZ2lnYW50aWMgcGFnZXMsIGRvaW5nIHRoYXQgY2hlY2sgaGVyZSB3b3VsZCBw
cmV2ZW50IHBvd2VycGMKPiB0byBmcmVlIGJvb3R0aW1lIGdpZ2FudGljIHBhZ2VzIHdoZW4gbm90
IGEgZ3Vlc3QuIE5vdGUgdGhhdCB0aGlzIGNoZWNrCj4gaXMgYWN0dWFsbHkgZG9uZSBpbiBzZXRf
bWF4X2h1Z2VfcGFnZXMuCj4KPgo+Pgo+PiBpZiAoZmlybXdhcmVfaGFzX2ZlYXR1cmUoRldfRkVB
VFVSRV9MUEFSKSAmJiAhcmFkaXhfZW5hYmxlZCgpKQo+PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
ZmFsc2U7Cj4KPiBNYXliZSBJIGRpZCBub3QgdW5kZXJzdGFuZCB0aGlzIGNoZWNrOiBJIHVuZGVy
c3Rvb2QgdGhhdCwgaW4gdGhlIGNhc2UgCj4gdGhlIHN5c3RlbQo+IGlzIHZpcnR1YWxpemVkLCB3
ZSBkbyBub3Qgd2FudCBpdCB0byBoYW5kIGJhY2sgZ2lnYW50aWMgcGFnZXMuIERvZXMgdGhpcyAK
PiBjaGVjawo+IHRlc3QgaWYgdGhlIHN5c3RlbSBpcyBjdXJyZW50bHkgYmVpbmcgdmlydHVhbGl6
ZWQgPwo+IElmIHllcywgSSB0aGluayB0aGUgcGF0Y2ggaXMgY29ycmVjdDogaXQgcHJldmVudHMg
ZnJlZWluZyBnaWdhbnRpYyBwYWdlcyAKPiB3aGVuIHRoZSBzeXN0ZW0KPiBpcyB2aXJ0dWFsaXpl
ZCBidXQgYWxsb3dzIGEgJ25vcm1hbCcgc3lzdGVtIHRvIGZyZWUgZ2lnYW50aWMgcGFnZXMuCj4K
Pgo+PgoKT2sgZG91YmxlIGNoZWNrZWQgdGhlIHBhdGNoIGFwcGx5aW5nIHRoZSB0aGUgdHJlZS4g
SSBnb3QgY29uZnVzZWQgYnkgdGhlCnJlbW92YWwgb2YgdGhhdCAjaWZkZWYuIFNvIHdlIG5vdyBk
aXNhbGxvdyB0aGUgcnVudGltZSBmcmVlIGJ5IGNoZWNraW5nCmZvciBnaWdhbnRpY19wYWdlX3J1
bnRpbWVfc3VwcG9ydGVkKCkgaW4gIF9fbnJfaHVnZXBhZ2VzX3N0b3JlX2NvbW1vbi4KTm93IGlm
IHdlIGFsbG93IGFuZCBpZiBDT05GSUdfQ09OVElHX0FMTE9DIGlzIGRpc2FibGVkLCB3ZSBzdGls
bCBzaG91bGQKYWxsb3cgdG8gZnJlZSB0aGUgYm9vdCB0aW1lIGFsbG9jYXRlZCBwYWdlcyBiYWNr
IHRvIGJ1ZGR5LgoKVGhlIHBhdGNoIGxvb2tzIGdvb2QuIFlvdSBjYW4gYWRkIGZvciB0aGUgc2Vy
aWVzCgpSZXZpZXdlZC1ieTogQW5lZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGxpbnV4Lmli
bS5jb20+CgotYW5lZXNoCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
