Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Message-ID: <32747ea1-7437-8055-a4f5-9f22378e57ae@linaro.org>
Date: Mon, 10 Dec 2018 14:48:25 -0200
MIME-Version: 1.0
In-Reply-To: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-mips@vger.kernel.org, linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Hogan <jhogan@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Nitin Gupta <ngupta@vflare.org>, Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <jroedel@suse.de>, Rafael David Tinoco <rafael.tinoco@linaro.org>, Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Minchan Kim <minchan@kernel.org>, Paul Burton <paul.burton@mips.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

T24gMTIvMTAvMTggMToxNSBQTSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOgo+IE9uIE1vbiwg
RGVjIDEwLCAyMDE4IGF0IDEyOjIxOjA1UE0gLTAyMDAsIFJhZmFlbCBEYXZpZCBUaW5vY28gd3Jv
dGU6Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVz
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0X3R5cGVzLmgKPj4gaW5kZXggODRi
ZDliZGMxOTg3Li5kODA4Y2ZkZTNkMTkgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3BndGFibGVfNjRfdHlwZXMuaAo+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3Rh
YmxlXzY0X3R5cGVzLmgKPj4gQEAgLTY0LDggKzY0LDYgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCBw
dHJzX3Blcl9wNGQ7Cj4+ICAjZGVmaW5lIFA0RF9TSVpFCQkoX0FDKDEsIFVMKSA8PCBQNERfU0hJ
RlQpCj4+ICAjZGVmaW5lIFA0RF9NQVNLCQkofihQNERfU0laRSAtIDEpKQo+PiAgCj4+IC0jZGVm
aW5lIE1BWF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMJNTIKPj4gLQo+PiAgI2Vsc2UgLyogQ09ORklH
X1g4Nl81TEVWRUwgKi8KPj4gIAo+PiAgLyoKPj4gQEAgLTE1NCw0ICsxNTIsNiBAQCBleHRlcm4g
dW5zaWduZWQgaW50IHB0cnNfcGVyX3A0ZDsKPj4gIAo+PiAgI2RlZmluZSBQR0RfS0VSTkVMX1NU
QVJUCSgoUEFHRV9TSVpFIC8gMikgLyBzaXplb2YocGdkX3QpKQo+PiAgCj4+ICsjZGVmaW5lIE1B
WF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMgKHBndGFibGVfbDVfZW5hYmxlZCgpID8gNTIgOiA0NikK
Pj4gKwo+IAo+IC4uLgo+IAo+PiAgI2VuZGlmIC8qIF9BU01fWDg2X1BHVEFCTEVfNjRfREVGU19I
ICovCj4+IGRpZmYgLS1naXQgYS9tbS96c21hbGxvYy5jIGIvbW0venNtYWxsb2MuYwo+PiBpbmRl
eCAwNzg3ZDMzYjgwZDguLjEzMmMyMGI2ZmQ0ZiAxMDA2NDQKPj4gLS0tIGEvbW0venNtYWxsb2Mu
Ywo+PiArKysgYi9tbS96c21hbGxvYy5jCj4gCj4gLi4uCj4gCj4+IEBAIC0xMTYsNiArMTAwLDI1
IEBACj4+ICAgKi8KPj4gICNkZWZpbmUgT0JKX0FMTE9DQVRFRF9UQUcgMQo+PiAgI2RlZmluZSBP
QkpfVEFHX0JJVFMgMQo+PiArCj4+ICsvKgo+PiArICogTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklU
UyBzaG91bGQgYmUgZGVmaW5lZCBieSBhbGwgYXJjaHMgdXNpbmcgenNtYWxsb2M6Cj4+ICsgKiBU
cnlpbmcgdG8gZ3Vlc3MgaXQgZnJvbSBNQVhfUEhZU01FTV9CSVRTLCBvciBjb25zaWRlcmluZyBp
dCBCSVRTX1BFUl9MT05HLAo+PiArICogcHJvdmVkIHRvIGJlIHdyb25nIGJ5IG5vdCBjb25zaWRl
cmluZyBQQUUgY2FwYWJpbGl0aWVzLCBvciB1c2luZyBTUEFSU0VNRU0KPj4gKyAqIG9ubHkgaGVh
ZGVycywgbGVhZGluZyB0byBiYWQgb2JqZWN0IGVuY29kaW5nIGR1ZSB0byBvYmplY3QgaW5kZXgg
b3ZlcmZsb3cuCj4+ICsgKi8KPj4gKyNpZm5kZWYgTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklUUwo+
PiArICNkZWZpbmUgTUFYX1BPU1NJQkxFX1BIWVNNRU1fQklUUyBCSVRTX1BFUl9MT05HCj4+ICsg
I2Vycm9yICJNQVhfUE9TU0lCTEVfUEhZU01FTV9CSVRTIEhBUyB0byBiZSBkZWZpbmVkIGJ5IGFy
Y2ggdXNpbmcgenNtYWxsb2MiOwo+PiArI2Vsc2UKPj4gKyAjaWZuZGVmIENPTkZJR182NEJJVAo+
PiArICAjaWYgKE1BWF9QT1NTSUJMRV9QSFlTTUVNX0JJVFMgPj0gKEJJVFNfUEVSX0xPTkcgKyBQ
QUdFX1NISUZUIC0gT0JKX1RBR19CSVRTKSkKPj4gKyAgICNlcnJvciAiTUFYX1BPU1NJQkxFX1BI
WVNNRU1fQklUUyBpcyB3cm9uZyBmb3IgdGhpcyBhcmNoIjsKPj4gKyAgI2VuZGlmCj4+ICsgI2Vu
ZGlmCj4+ICsjZW5kaWYKPj4gKwo+PiArI2RlZmluZSBfUEZOX0JJVFMgKE1BWF9QT1NTSUJMRV9Q
SFlTTUVNX0JJVFMgLSBQQUdFX1NISUZUKQo+PiAgI2RlZmluZSBPQkpfSU5ERVhfQklUUwkoQklU
U19QRVJfTE9ORyAtIF9QRk5fQklUUyAtIE9CSl9UQUdfQklUUykKPj4gICNkZWZpbmUgT0JKX0lO
REVYX01BU0sJKChfQUMoMSwgVUwpIDw8IE9CSl9JTkRFWF9CSVRTKSAtIDEpCj4gCj4gSGF2ZSB5
b3UgdGVzdGVkIGl0IHdpdGggQ09ORklHX1g4Nl81TEVWRUw9eT8KPiAKPiBBU0FJQ1MsIHRoZSBw
YXRjaCBtYWtlcyBPQkpfSU5ERVhfQklUUyBhbmQgd2hhdCBkZXBlbmRzIGZyb20gaXQgZHluYW1p
YyAtLQo+IGl0IGRlcGVuZHMgd2hhdCBwYWdpbmcgbW9kZSB3ZSBhcmUgYm9vdGluZyBpbi4gWlNf
U0laRV9DTEFTU0VTIGRlcGVuZHMKPiBpbmRpcmVjdGx5IG9uIE9CSl9JTkRFWF9CSVRTIGFuZCBJ
IGRvbid0IHNlZSBob3cgc3RydWN0IHpzX3Bvb2wgZGVmaW5pdGlvbgo+IGNhbiBjb21waWxlIHdp
dGggZHluYW1pYyBaU19TSVpFX0NMQVNTRVMuCj4gCj4gSG0/Cj4gCgpZb3UncmUgcmlnaHQsIHRl
cnJpYmx5IHNvcnJ5LiBUaGlzIHdhcyBhIGxhc3QgdGltZSBjaGFuZ2UuCgptbS96c21hbGxvYy5j
OjI1NjoyMTogZXJyb3I6IHZhcmlhYmx5IG1vZGlmaWVkIOKAmHNpemVfY2xhc3PigJkgYXQgZmls
ZSBzY29wZQoKSSdsbCByZXZpc2l0IHRoZSBwYXRjaC4gQW55IG90aGVyIGNvbW1lbnRzIGFyZSB3
ZWxjb21lLgoKVGhhbmsgeW91CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
