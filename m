From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
Date: Fri, 18 Jul 2014 11:14:16 +0100
Message-ID: <20140718101416.GB1818@arm.com>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@men>
List-ID: <linux-s390.vger.kernel.org>

T24gVHVlLCBKdWwgMTUsIDIwMTQgYXQgMDM6NDc6MjZQTSArMDEwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+IE9uIFN1biwgSnVsIDEzLCAyMDE0IGF0IDE6MDEgUE0sIEFuZHkgTHV0b21pcnNr
aSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4gd3JvdGU6Cj4gPiBUaGUgY29yZSBtbSBjb2RlIHdpbGwg
cHJvdmlkZSBhIGRlZmF1bHQgZ2F0ZSBhcmVhIGJhc2VkIG9uCj4gPiBGSVhBRERSX1VTRVJfU1RB
UlQgYW5kIEZJWEFERFJfVVNFUl9FTkQgaWYKPiA+ICFkZWZpbmVkKF9fSEFWRV9BUkNIX0dBVEVf
QVJFQSkgJiYgZGVmaW5lZChBVF9TWVNJTkZPX0VIRFIpLgo+ID4KPiA+IFRoaXMgZGVmYXVsdCBp
cyBvbmx5IHVzZWZ1bCBmb3IgaWE2NC4gIGFybTY0LCBwcGMsIHMzOTAsIHNoLCB0aWxlLAo+ID4g
NjQtYml0IFVNTCwgYW5kIHg4Nl8zMiBoYXZlIHRoZWlyIG93biBjb2RlIGp1c3QgdG8gZGlzYWJs
ZSBpdC4gIGFybSwKPiA+IDMyLWJpdCBVTUwsIGFuZCB4ODZfNjQgaGF2ZSBnYXRlIGFyZWFzLCBi
dXQgdGhleSBoYXZlIHRoZWlyIG93bgo+ID4gaW1wbGVtZW50YXRpb25zLgo+ID4KPiA+IFRoaXMg
Z2V0cyByaWQgb2YgdGhlIGRlZmF1bHQgYW5kIG1vdmVzIHRoZSBjb2RlIGludG8gaWE2NC4KPiA+
Cj4gPiBUaGlzIHNob3VsZCBzYXZlIHNvbWUgY29kZSBvbiBhcmNoaXRlY3R1cmVzIHdpdGhvdXQg
YSBnYXRlIGFyZWE6IGl0J3MKPiA+IG5vdyBwb3NzaWJsZSB0byBpbmxpbmUgdGhlIGdhdGVfYXJl
YSBmdW5jdGlvbnMgaW4gdGhlIGRlZmF1bHQgY2FzZS4KPiAKPiBDYW4gb25lIG9mIHlvdSBwdWxs
IHRoaXMgc29tZXdoZXJlPyAgT3RoZXJ3aXNlIEkgY2FuIHB1dCBpdCBzb21ld2hlcmUKPiBzdGFi
bGUgYW5kIGFzayBmb3IgLW5leHQgaW5jbHVzaW9uLCBidXQgdGhhdCBzZWVtcyBsaWtlIG92ZXJr
aWxsIGZvciBhCj4gc2luZ2xlIHBhdGNoLgoKSSdkIGJlIGhhcHB5IHRvIHRha2UgdGhlIGFybTY0
IHBhcnQsIGJ1dCBpdCBkb2Vzbid0IGZlZWwgcmlnaHQgZm9yIG1tLyoKY2hhbmdlcyAob3IgY2hh
bmdlcyB0byBvdGhlciBhcmNocykgdG8gZ28gdmlhIG91ciB0cmVlLgoKSSdtIG5vdCBzdXJlIHdo
YXQgdGhlIGJlc3QgYXBwcm9hY2ggaXMgaWYgeW91IHdhbnQgdG8gc2VuZCB0aGlzIHZpYSBhIHNp
bmdsZQp0cmVlLiBNYXliZSB5b3UgY291bGQgYXNrIGFrcG0gbmljZWx5PwoKV2lsbApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
