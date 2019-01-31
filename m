Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
Date: Thu, 31 Jan 2019 07:44:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190131064139.GB28876@rapoport-lnx>
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
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Petr Mladek <pmladek@suse.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, devicetree@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
List-ID: <linux-s390.vger.kernel.org>

CgpMZSAzMS8wMS8yMDE5IMOgIDA3OjQxLCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gT24g
VGh1LCBKYW4gMzEsIDIwMTkgYXQgMDc6MDc6NDZBTSArMDEwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToKPj4KPj4KPj4gTGUgMjEvMDEvMjAxOSDDoCAwOTowNCwgTWlrZSBSYXBvcG9ydCBhIMOp
Y3JpdMKgOgo+Pj4gQWRkIGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIG9mIG1lbWJsb2NrX2Fs
bG9jKigpIGZ1bmN0aW9ucyBhbmQgY2FsbAo+Pj4gcGFuaWMoKSBpbiBjYXNlIG9mIGVycm9yLgo+
Pj4gVGhlIHBhbmljIG1lc3NhZ2UgcmVwZWF0cyB0aGUgb25lIHVzZWQgYnkgcGFuaWNpbmcgbWVt
YmxvY2sgYWxsb2NhdG9ycyB3aXRoCj4+PiBhZGp1c3RtZW50IG9mIHBhcmFtZXRlcnMgdG8gaW5j
bHVkZSBvbmx5IHJlbGV2YW50IG9uZXMuCj4+Pgo+Pj4gVGhlIHJlcGxhY2VtZW50IHdhcyBtb3N0
bHkgYXV0b21hdGVkIHdpdGggc2VtYW50aWMgcGF0Y2hlcyBsaWtlIHRoZSBvbmUKPj4+IGJlbG93
IHdpdGggbWFudWFsIG1hc3NhZ2luZyBvZiBmb3JtYXQgc3RyaW5ncy4KPj4+Cj4+PiBAQAo+Pj4g
ZXhwcmVzc2lvbiBwdHIsIHNpemUsIGFsaWduOwo+Pj4gQEAKPj4+IHB0ciA9IG1lbWJsb2NrX2Fs
bG9jKHNpemUsIGFsaWduKTsKPj4+ICsgaWYgKCFwdHIpCj4+PiArIAlwYW5pYygiJXM6IEZhaWxl
ZCB0byBhbGxvY2F0ZSAlbHUgYnl0ZXMgYWxpZ249MHglbHhcbiIsIF9fZnVuY19fLAo+Pj4gc2l6
ZSwgYWxpZ24pOwo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGlu
dXguaWJtLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBHdW8gUmVuIDxyZW5fZ3VvQGMtc2t5LmNvbT4g
ICAgICAgICAgICAgIyBjLXNreQo+Pj4gQWNrZWQtYnk6IFBhdWwgQnVydG9uIDxwYXVsLmJ1cnRv
bkBtaXBzLmNvbT4JICAgICAjIE1JUFMKPj4+IEFja2VkLWJ5OiBIZWlrbyBDYXJzdGVucyA8aGVp
a28uY2Fyc3RlbnNAZGUuaWJtLmNvbT4gIyBzMzkwCj4+PiBSZXZpZXdlZC1ieTogSnVlcmdlbiBH
cm9zcyA8amdyb3NzQHN1c2UuY29tPiAgICAgICAgICMgWGVuCj4+PiAtLS0KPj4KPj4gWy4uLl0K
Pj4KPj4+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21tL3NwYXJzZS5jCj4+PiBpbmRleCA3
ZWE1ZGM2Li5hZDk0MjQyIDEwMDY0NAo+Pj4gLS0tIGEvbW0vc3BhcnNlLmMKPj4+ICsrKyBiL21t
L3NwYXJzZS5jCj4+Cj4+IFsuLi5dCj4+Cj4+PiBAQCAtNDI1LDYgKzQzNiwxMCBAQCBzdGF0aWMg
dm9pZCBfX2luaXQgc3BhcnNlX2J1ZmZlcl9pbml0KHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IG5p
ZCkKPj4+ICAgCQltZW1ibG9ja19hbGxvY190cnlfbmlkX3JhdyhzaXplLCBQQUdFX1NJWkUsCj4+
PiAgIAkJCQkJCV9fcGEoTUFYX0RNQV9BRERSRVNTKSwKPj4+ICAgCQkJCQkJTUVNQkxPQ0tfQUxM
T0NfQUNDRVNTSUJMRSwgbmlkKTsKPj4+ICsJaWYgKCFzcGFyc2VtYXBfYnVmKQo+Pj4gKwkJcGFu
aWMoIiVzOiBGYWlsZWQgdG8gYWxsb2NhdGUgJWx1IGJ5dGVzIGFsaWduPTB4JWx4IG5pZD0lZCBm
cm9tPSVseFxuIiwKPj4+ICsJCSAgICAgIF9fZnVuY19fLCBzaXplLCBQQUdFX1NJWkUsIG5pZCwg
X19wYShNQVhfRE1BX0FERFJFU1MpKTsKPj4+ICsKPj4KPj4gbWVtYmxvY2tfYWxsb2NfdHJ5X25p
ZF9yYXcoKSBkb2VzIG5vdCBwYW5pYyAoaGVscCBleHBsaWNpdGx5IHNheXM6IERvZXMgbm90Cj4+
IHplcm8gYWxsb2NhdGVkIG1lbW9yeSwgZG9lcyBub3QgcGFuaWMgaWYgcmVxdWVzdCBjYW5ub3Qg
YmUgc2F0aXNmaWVkLikuCj4gCj4gIkRvZXMgbm90IHBhbmljIiBkb2VzIG5vdCBtZWFuIGl0IGFs
d2F5cyBzdWNjZWVkcy4KCkkgYWdyZWUsIGJ1dCBhdCBsZWFzdCBoZXJlIHlvdSBhcmUgY2hhbmdp
bmcgdGhlIGJlaGF2aW91ciBieSBtYWtpbmcgaXQgCnBhbmljIGV4cGxpY2l0bHkuIEFyZSB3ZSBz
dXJlIHRoZXJlIGFyZSBub3QgY2FzZXMgd2hlcmUgdGhlIHN5c3RlbSBjb3VsZCAKanVzdCBjb250
aW51ZSBmdW5jdGlvbm5pbmcgPyBNYXliZSBhIFdBUk5fT04oKSB3b3VsZCBiZSBlbm91Z2ggdGhl
cmUgPwoKQ2hyaXN0b3BoZQoKPiAgIAo+PiBTdGVwaGVuIFJvdGh3ZWxsIHJlcG9ydHMgYSBib290
IGZhaWx1cmUgZHVlIHRvIHRoaXMgY2hhbmdlLgo+IAo+IFBsZWFzZSBzZWUgbXkgcmVwbHkgb24g
dGhhdCB0aHJlYWQuCj4gCj4+IENocmlzdG9waGUKPj4KPj4+ICAgCXNwYXJzZW1hcF9idWZfZW5k
ID0gc3BhcnNlbWFwX2J1ZiArIHNpemU7Cj4+PiAgIH0KPj4+Cj4+Cj4gCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
