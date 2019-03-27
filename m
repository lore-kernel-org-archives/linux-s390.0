Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
 <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
 <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr>
 <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com>
 <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
 <87pnqcws2u.fsf@linux.ibm.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <95819dc9-7910-f273-681c-a241fee62dd2@ghiti.fr>
Date: Wed, 27 Mar 2019 13:54:15 +0100
MIME-Version: 1.0
In-Reply-To: <87pnqcws2u.fsf@linux.ibm.com>
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

T24gMDMvMjcvMjAxOSAxMTowNSBBTSwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToKPiBBbGV4YW5k
cmUgR2hpdGkgPGFsZXhAZ2hpdGkuZnI+IHdyaXRlczoKPgo+PiBPbiAwMy8yNy8yMDE5IDA5OjU1
IEFNLCBBbmVlc2ggS3VtYXIgSy5WIHdyb3RlOgo+Pj4gT24gMy8yNy8xOSAyOjE0IFBNLCBBbGV4
YW5kcmUgR2hpdGkgd3JvdGU6Cj4+Pj4KPj4+PiBPbiAwMy8yNy8yMDE5IDA4OjAxIEFNLCBBbmVl
c2ggS3VtYXIgSy5WIHdyb3RlOgo+Pj4+PiBPbiAzLzI3LzE5IDEyOjA2IFBNLCBBbGV4YW5kcmUg
R2hpdGkgd3JvdGU6Cj4gLi4uLi4KPgo+Pj4gVGhpcyBpcyBub3cKPj4+ICNkZWZpbmUgX19IQVZF
X0FSQ0hfR0lHQU5USUNfUEFHRV9SVU5USU1FX1NVUFBPUlRFRAo+Pj4gc3RhdGljIGlubGluZSBi
b29sIGdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQodm9pZCkKPj4+IHsKPj4+IGlmIChm
aXJtd2FyZV9oYXNfZmVhdHVyZShGV19GRUFUVVJFX0xQQVIpICYmICFyYWRpeF9lbmFibGVkKCkp
Cj4+PiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+Pj4KPj4+ICDCoMKgwqDCoHJldHVy
biB0cnVlOwo+Pj4gfQo+Pj4KPj4+Cj4+PiBJIGFtIHdvbmRlcmluZyB3aGV0aGVyIGl0IHNob3Vs
ZCBiZQo+Pj4KPj4+ICNkZWZpbmUgX19IQVZFX0FSQ0hfR0lHQU5USUNfUEFHRV9SVU5USU1FX1NV
UFBPUlRFRAo+Pj4gc3RhdGljIGlubGluZSBib29sIGdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBw
b3J0ZWQodm9pZCkKPj4+IHsKPj4+Cj4+PiAgwqDCoCBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0NP
TlRJR19BTExPQykpCj4+PiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiBJIGRvbid0
IHRoaW5rIHRoaXMgdGVzdCBzaG91bGQgaGFwcGVuIGhlcmUsIENPTkZJR19DT05USUdfQUxMT0Mg
b25seSBhbGxvd3MKPj4gdG8gYWxsb2NhdGUgZ2lnYW50aWMgcGFnZXMsIGRvaW5nIHRoYXQgY2hl
Y2sgaGVyZSB3b3VsZCBwcmV2ZW50IHBvd2VycGMKPj4gdG8gZnJlZSBib290dGltZSBnaWdhbnRp
YyBwYWdlcyB3aGVuIG5vdCBhIGd1ZXN0LiBOb3RlIHRoYXQgdGhpcyBjaGVjawo+PiBpcyBhY3R1
YWxseSBkb25lIGluIHNldF9tYXhfaHVnZV9wYWdlcy4KPj4KPj4KPj4+IGlmIChmaXJtd2FyZV9o
YXNfZmVhdHVyZShGV19GRUFUVVJFX0xQQVIpICYmICFyYWRpeF9lbmFibGVkKCkpCj4+PiAgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiBNYXliZSBJIGRpZCBub3QgdW5kZXJzdGFuZCB0
aGlzIGNoZWNrOiBJIHVuZGVyc3Rvb2QgdGhhdCwgaW4gdGhlIGNhc2UKPj4gdGhlIHN5c3RlbQo+
PiBpcyB2aXJ0dWFsaXplZCwgd2UgZG8gbm90IHdhbnQgaXQgdG8gaGFuZCBiYWNrIGdpZ2FudGlj
IHBhZ2VzLiBEb2VzIHRoaXMKPj4gY2hlY2sKPj4gdGVzdCBpZiB0aGUgc3lzdGVtIGlzIGN1cnJl
bnRseSBiZWluZyB2aXJ0dWFsaXplZCA/Cj4+IElmIHllcywgSSB0aGluayB0aGUgcGF0Y2ggaXMg
Y29ycmVjdDogaXQgcHJldmVudHMgZnJlZWluZyBnaWdhbnRpYyBwYWdlcwo+PiB3aGVuIHRoZSBz
eXN0ZW0KPj4gaXMgdmlydHVhbGl6ZWQgYnV0IGFsbG93cyBhICdub3JtYWwnIHN5c3RlbSB0byBm
cmVlIGdpZ2FudGljIHBhZ2VzLgo+Pgo+Pgo+IE9rIGRvdWJsZSBjaGVja2VkIHRoZSBwYXRjaCBh
cHBseWluZyB0aGUgdGhlIHRyZWUuIEkgZ290IGNvbmZ1c2VkIGJ5IHRoZQo+IHJlbW92YWwgb2Yg
dGhhdCAjaWZkZWYuIFNvIHdlIG5vdyBkaXNhbGxvdyB0aGUgcnVudGltZSBmcmVlIGJ5IGNoZWNr
aW5nCj4gZm9yIGdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSBpbiAgX19ucl9odWdl
cGFnZXNfc3RvcmVfY29tbW9uLgo+IE5vdyBpZiB3ZSBhbGxvdyBhbmQgaWYgQ09ORklHX0NPTlRJ
R19BTExPQyBpcyBkaXNhYmxlZCwgd2Ugc3RpbGwgc2hvdWxkCj4gYWxsb3cgdG8gZnJlZSB0aGUg
Ym9vdCB0aW1lIGFsbG9jYXRlZCBwYWdlcyBiYWNrIHRvIGJ1ZGR5Lgo+Cj4gVGhlIHBhdGNoIGxv
b2tzIGdvb2QuIFlvdSBjYW4gYWRkIGZvciB0aGUgc2VyaWVzCj4KPiBSZXZpZXdlZC1ieTogQW5l
ZXNoIEt1bWFyIEsuViA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+Cj4KPiAtYW5lZXNoCj4K
ClRoYW5rcyBmb3IgeW91ciB0aW1lIEFuZWVzaCwKCkFsZXgKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
