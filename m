Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
 <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5e4ff5b-d33a-e641-8159-d4f83bc28d0b@c-s.fr>
Date: Thu, 31 Jan 2019 08:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
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

CgpMZSAzMS8wMS8yMDE5IMOgIDA3OjQ0LCBDaHJpc3RvcGhlIExlcm95IGEgw6ljcml0wqA6Cj4g
Cj4gCj4gTGUgMzEvMDEvMjAxOSDDoCAwNzo0MSwgTWlrZSBSYXBvcG9ydCBhIMOpY3JpdMKgOgo+
PiBPbiBUaHUsIEphbiAzMSwgMjAxOSBhdCAwNzowNzo0NkFNICswMTAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOgo+Pj4KPj4+Cj4+PiBMZSAyMS8wMS8yMDE5IMOgIDA5OjA0LCBNaWtlIFJhcG9w
b3J0IGEgw6ljcml0wqA6Cj4+Pj4gQWRkIGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVlIG9mIG1l
bWJsb2NrX2FsbG9jKigpIGZ1bmN0aW9ucyBhbmQgY2FsbAo+Pj4+IHBhbmljKCkgaW4gY2FzZSBv
ZiBlcnJvci4KPj4+PiBUaGUgcGFuaWMgbWVzc2FnZSByZXBlYXRzIHRoZSBvbmUgdXNlZCBieSBw
YW5pY2luZyBtZW1ibG9jayAKPj4+PiBhbGxvY2F0b3JzIHdpdGgKPj4+PiBhZGp1c3RtZW50IG9m
IHBhcmFtZXRlcnMgdG8gaW5jbHVkZSBvbmx5IHJlbGV2YW50IG9uZXMuCj4+Pj4KPj4+PiBUaGUg
cmVwbGFjZW1lbnQgd2FzIG1vc3RseSBhdXRvbWF0ZWQgd2l0aCBzZW1hbnRpYyBwYXRjaGVzIGxp
a2UgdGhlIG9uZQo+Pj4+IGJlbG93IHdpdGggbWFudWFsIG1hc3NhZ2luZyBvZiBmb3JtYXQgc3Ry
aW5ncy4KPj4+Pgo+Pj4+IEBACj4+Pj4gZXhwcmVzc2lvbiBwdHIsIHNpemUsIGFsaWduOwo+Pj4+
IEBACj4+Pj4gcHRyID0gbWVtYmxvY2tfYWxsb2Moc2l6ZSwgYWxpZ24pOwo+Pj4+ICsgaWYgKCFw
dHIpCj4+Pj4gK8KgwqDCoMKgIHBhbmljKCIlczogRmFpbGVkIHRvIGFsbG9jYXRlICVsdSBieXRl
cyBhbGlnbj0weCVseFxuIiwgX19mdW5jX18sCj4+Pj4gc2l6ZSwgYWxpZ24pOwo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPgo+Pj4+IFJl
dmlld2VkLWJ5OiBHdW8gUmVuIDxyZW5fZ3VvQGMtc2t5LmNvbT7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIyBjLXNreQo+Pj4+IEFja2VkLWJ5OiBQYXVsIEJ1cnRvbiA8cGF1bC5idXJ0b25AbWlw
cy5jb20+wqDCoMKgwqDCoMKgwqDCoCAjIE1JUFMKPj4+PiBBY2tlZC1ieTogSGVpa28gQ2Fyc3Rl
bnMgPGhlaWtvLmNhcnN0ZW5zQGRlLmlibS5jb20+ICMgczM5MAo+Pj4+IFJldmlld2VkLWJ5OiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wqDCoMKgwqDCoMKgwqDCoCAjIFhlbgo+Pj4+
IC0tLQo+Pj4KPj4+IFsuLi5dCj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9tbS9zcGFyc2UuYyBiL21t
L3NwYXJzZS5jCj4+Pj4gaW5kZXggN2VhNWRjNi4uYWQ5NDI0MiAxMDA2NDQKPj4+PiAtLS0gYS9t
bS9zcGFyc2UuYwo+Pj4+ICsrKyBiL21tL3NwYXJzZS5jCj4+Pgo+Pj4gWy4uLl0KPj4+Cj4+Pj4g
QEAgLTQyNSw2ICs0MzYsMTAgQEAgc3RhdGljIHZvaWQgX19pbml0IHNwYXJzZV9idWZmZXJfaW5p
dCh1bnNpZ25lZCAKPj4+PiBsb25nIHNpemUsIGludCBuaWQpCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIG1lbWJsb2NrX2FsbG9jX3RyeV9uaWRfcmF3KHNpemUsIFBBR0VfU0laRSwKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3BhKE1BWF9E
TUFfQUREUkVTUyksCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTUVNQkxPQ0tfQUxMT0NfQUNDRVNTSUJMRSwgbmlkKTsKPj4+PiArwqDCoMKg
IGlmICghc3BhcnNlbWFwX2J1ZikKPj4+PiArwqDCoMKgwqDCoMKgwqAgcGFuaWMoIiVzOiBGYWls
ZWQgdG8gYWxsb2NhdGUgJWx1IGJ5dGVzIGFsaWduPTB4JWx4IG5pZD0lZCAKPj4+PiBmcm9tPSVs
eFxuIiwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHNpemUsIFBB
R0VfU0laRSwgbmlkLCBfX3BhKE1BWF9ETUFfQUREUkVTUykpOwo+Pj4+ICsKPj4+Cj4+PiBtZW1i
bG9ja19hbGxvY190cnlfbmlkX3JhdygpIGRvZXMgbm90IHBhbmljIChoZWxwIGV4cGxpY2l0bHkg
c2F5czogCj4+PiBEb2VzIG5vdAo+Pj4gemVybyBhbGxvY2F0ZWQgbWVtb3J5LCBkb2VzIG5vdCBw
YW5pYyBpZiByZXF1ZXN0IGNhbm5vdCBiZSBzYXRpc2ZpZWQuKS4KPj4KPj4gIkRvZXMgbm90IHBh
bmljIiBkb2VzIG5vdCBtZWFuIGl0IGFsd2F5cyBzdWNjZWVkcy4KPiAKPiBJIGFncmVlLCBidXQg
YXQgbGVhc3QgaGVyZSB5b3UgYXJlIGNoYW5naW5nIHRoZSBiZWhhdmlvdXIgYnkgbWFraW5nIGl0
IAo+IHBhbmljIGV4cGxpY2l0bHkuIEFyZSB3ZSBzdXJlIHRoZXJlIGFyZSBub3QgY2FzZXMgd2hl
cmUgdGhlIHN5c3RlbSBjb3VsZCAKPiBqdXN0IGNvbnRpbnVlIGZ1bmN0aW9ubmluZyA/IE1heWJl
IGEgV0FSTl9PTigpIHdvdWxkIGJlIGVub3VnaCB0aGVyZSA/CgpMb29raW5nIG1vcmUgaW4gZGV0
YWlscywgaXQgbG9va3MgbGlrZSBldmVyeXRoaW5nIGlzIGRvbmUgdG8gbGl2ZSB3aXRoIApzcGFy
c2VtYXBfYnVmIE5VTEwsIGFsbCBmdW5jdGlvbnMgdXNpbmcgaXQgY2hlY2sgaXQgc28gaGF2aW5n
IGl0IE5VTEwgCnNob3VsZG4ndCBpbXBseSBhIHBhbmljIEkgYmVsaWV2ZSwgc2VlIGNvZGUgYmVs
b3cuCgpzdGF0aWMgdm9pZCAqc3BhcnNlbWFwX2J1ZiBfX21lbWluaXRkYXRhOwpzdGF0aWMgdm9p
ZCAqc3BhcnNlbWFwX2J1Zl9lbmQgX19tZW1pbml0ZGF0YTsKCnN0YXRpYyB2b2lkIF9faW5pdCBz
cGFyc2VfYnVmZmVyX2luaXQodW5zaWduZWQgbG9uZyBzaXplLCBpbnQgbmlkKQp7CglXQVJOX09O
KHNwYXJzZW1hcF9idWYpOwkvKiBmb3Jnb3QgdG8gY2FsbCBzcGFyc2VfYnVmZmVyX2ZpbmkoKT8g
Ki8KCXNwYXJzZW1hcF9idWYgPQoJCW1lbWJsb2NrX2FsbG9jX3RyeV9uaWRfcmF3KHNpemUsIFBB
R0VfU0laRSwKCQkJCQkJX19wYShNQVhfRE1BX0FERFJFU1MpLAoJCQkJCQlNRU1CTE9DS19BTExP
Q19BQ0NFU1NJQkxFLCBuaWQpOwoJc3BhcnNlbWFwX2J1Zl9lbmQgPSBzcGFyc2VtYXBfYnVmICsg
c2l6ZTsKfQoKc3RhdGljIHZvaWQgX19pbml0IHNwYXJzZV9idWZmZXJfZmluaSh2b2lkKQp7Cgl1
bnNpZ25lZCBsb25nIHNpemUgPSBzcGFyc2VtYXBfYnVmX2VuZCAtIHNwYXJzZW1hcF9idWY7CgoJ
aWYgKHNwYXJzZW1hcF9idWYgJiYgc2l6ZSA+IDApCgkJbWVtYmxvY2tfZnJlZV9lYXJseShfX3Bh
KHNwYXJzZW1hcF9idWYpLCBzaXplKTsKCXNwYXJzZW1hcF9idWYgPSBOVUxMOwp9Cgp2b2lkICog
X19tZW1pbml0IHNwYXJzZV9idWZmZXJfYWxsb2ModW5zaWduZWQgbG9uZyBzaXplKQp7Cgl2b2lk
ICpwdHIgPSBOVUxMOwoKCWlmIChzcGFyc2VtYXBfYnVmKSB7CgkJcHRyID0gUFRSX0FMSUdOKHNw
YXJzZW1hcF9idWYsIHNpemUpOwoJCWlmIChwdHIgKyBzaXplID4gc3BhcnNlbWFwX2J1Zl9lbmQp
CgkJCXB0ciA9IE5VTEw7CgkJZWxzZQoJCQlzcGFyc2VtYXBfYnVmID0gcHRyICsgc2l6ZTsKCX0K
CXJldHVybiBwdHI7Cn0KCgpDaHJpc3RvcGhlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
