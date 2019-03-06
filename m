Return-Path: <SRS0=hX7x=RJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
 <7c81abe0-5f9d-32f9-1e9a-70ab06d48f8e@intel.com>
 <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5058428f-f351-ce26-7348-3b2255e5425d@intel.com>
Date: Wed, 6 Mar 2019 13:17:38 -0800
MIME-Version: 1.0
In-Reply-To: <82a3f572-e9c1-0151-3d7d-a646f5e5302c@ghiti.fr>
Content-Language: en-US
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
To: Alex Ghiti <alex@ghiti.fr>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

T24gMy82LzE5IDEyOjA4IFBNLCBBbGV4IEdoaXRpIHdyb3RlOgo+Pj4KPj4+ICvCoMKgwqAgLyoK
Pj4+ICvCoMKgwqDCoCAqIEdpZ2FudGljIHBhZ2VzIGFsbG9jYXRpb24gZGVwZW5kcyBvbiB0aGUg
Y2FwYWJpbGl0eSBmb3IgbGFyZ2UKPj4+IHBhZ2UKPj4+ICvCoMKgwqDCoCAqIHJhbmdlIGFsbG9j
YXRpb24uIElmIHRoZSBzeXN0ZW0gY2Fubm90IHByb3ZpZGUKPj4+IGFsbG9jX2NvbnRpZ19yYW5n
ZSwKPj4+ICvCoMKgwqDCoCAqIGFsbG93IHVzZXJzIHRvIGZyZWUgZ2lnYW50aWMgcGFnZXMuCj4+
PiArwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqAgaWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSAmJiAh
SVNfRU5BQkxFRChDT05GSUdfQ09OVElHX0FMTE9DKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHNw
aW5fbG9jaygmaHVnZXRsYl9sb2NrKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY291bnQgPiBw
ZXJzaXN0ZW50X2h1Z2VfcGFnZXMoaCkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNw
aW5fdW5sb2NrKCZodWdldGxiX2xvY2spOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FSU5WQUw7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGdv
dG8gZGVjcmVhc2VfcG9vbDsKPj4+ICvCoMKgwqAgfQo+PiBXZSB0YWxrZWQgYWJvdXQgaXQgZHVy
aW5nIHRoZSBsYXN0IHJvdW5kIGFuZCBJIGRvbid0IHNlZW4gYW55IG1lbnRpb24gb2YKPj4gaXQg
aGVyZSBpbiBjb21tZW50cyBvciB0aGUgY2hhbmdlbG9nOiBXaHkgaXMgdGhpcyBhIGdvdG8/wqAg
V2h5IGRvbid0IHdlCj4+IGp1c3QgbGV0IHRoZSBjb2RlIGZhbGwgdGhyb3VnaCB0byB0aGUgImRl
Y3JlYXNlX3Bvb2wiIGxhYmVsP8KgIFdoeSBpcwo+PiB0aGlzIG5ldyBibG9jayBuZWVkZWQgYXQg
YWxsP8KgIENhbid0IHdlIGp1c3QgcmVtb3ZlIHRoZSBvbGQgY2hlY2sgYW5kCj4+IGxldCBpdCBi
ZT8KPiAKPiBJJ2xsIGdldCByaWQgb2YgdGhlIGdvdG8sIEkgZG9uJ3Qga25vdyBob3cgdG8ganVz
dGlmeSBpdCBwcm9wZXJseSBpbiBhCj4gY29tbWVudCwKPiBtYXliZSBiZWNhdXNlIGl0IGlzIG5v
dCBuZWNlc3NhcnkuCj4gVGhpcyBpcyBub3QgYSBuZXcgYmxvY2ssIHRoaXMgbWVhbnMgZXhhY3Rs
eSB0aGUgc2FtZSBhcyBiZWZvcmUgKHJlbWVtYmVyCj4gZ2lnYW50aWNfcGFnZV9zdXBwb3J0ZWQo
KSBhY3R1YWxseSBtZWFudCBDT05USUdfQUxMT0MgYmVmb3JlIHRoaXMgc2VyaWVzKSwKPiBleGNl
cHQgdGhhdCBub3cgd2UgYWxsb3cgYSB1c2VyIHRvIGZyZWUgYm9vdHRpbWUgYWxsb2NhdGVkIGdp
Z2FudGljIHBhZ2VzLgo+IEFuZCBubyB3ZSBjYW5ub3QganVzdCByZW1vdmUgdGhlIGNoZWNrIGFu
ZCBsZXQgaXQgYmUgc2luY2UgaXQgd291bGQgbW9kaWZ5Cj4gdGhlIGN1cnJlbnQgYmVoYXZpb3Vy
LCB3aGljaCBpcyB0byByZXR1cm4gYW4gZXJyb3Igd2hlbiB0cnlpbmcgdG8gYWxsb2NhdGUKPiBn
aWdhbnRpYyBwYWdlcyB3aGVyZWFzIGFsbG9jX2NvbnRpZ19yYW5nZSBpcyBub3QgZGVmaW5lZC4g
SSB0aG91Z2h0IGl0IHdhcwo+IGNsZWFybHkgY29tbWVudGVkIGFib3ZlLCBJIGNhbiB0cnkgdG8g
bWFrZSBpdCBtb3JlIGV4cGxpY2l0LgoKT0ssIHRoYXQgbWFrZXMgc2Vuc2UuICBDb3VsZCB5b3Ug
Z2V0IHNvbWUgb2YgdGhpcyBpbiB0aGUgY2hhbmdlbG9nLApwbGVhc2U/ICBPdGhlcndpc2UgdGhp
cyBhbGwgbG9va3MgZ29vZCB0byBtZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
