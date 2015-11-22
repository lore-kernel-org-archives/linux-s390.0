From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Mon, 23 Nov 2015 00:11:09 +0200
Message-ID: <20151123000329-mutt-send-email-mst@redhat.com>
References: <20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
	<20151029104301-mutt-send-email-mst@redhat.com>
	<1446135536.3405.279.camel@infradead.org>
	<20151108120627-mutt-send-email-mst@redhat.com>
	<20151108114946.GG2255@suse.de> <5651BDC0.2040206@gmail.com>
	<1448207661.89124.50.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1448207661.89124.50.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, marcel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

T24gU3VuLCBOb3YgMjIsIDIwMTUgYXQgMDM6NTQ6MjFQTSArMDAwMCwgRGF2aWQgV29vZGhvdXNl
IHdyb3RlOgo+IE9uIFN1biwgMjAxNS0xMS0yMiBhdCAxNTowNiArMDIwMCwgTWFyY2VsIEFwZmVs
YmF1bSB3cm90ZToKPiA+IAo+ID4gCj4gPiBJIHRyaWVkIHRvIGdlbmVyYXRlIGEgRE1BUiB0YWJs
ZSB0aGF0IGV4Y2x1ZGVzIHNvbWUgZGV2aWNlcyBmcm9tCj4gPiBJT01NVSB0cmFuc2xhdGlvbiwg
aG93ZXZlciBpdCBkb2VzIG5vdCBoZWxwLgo+ID4gCj4gPiBUaGUgcmVhc29uIGlzLCBhcyBmYXIg
YXMgSSB1bmRlcnN0YW5kLCB0aGF0IExpbnV4IGtlcm5lbCBkb2VzCj4gPiBub3QgYWxsb3cgYW55
IGRldmljZSBiZWluZyBvdXRzaWRlIGFuIElPTU1VIHNjb3BlIGlmIHRoZQo+ID4gaW9tbXUga2Vy
bmVsIG9wdGlvbiBpcyBhY3RpdmF0ZWQuCj4gPiAKPiA+IERvZXMgYW55Ym9keSBrbm93IGlmIGl0
IGlzICJieSBkZXNpZ24iIG9yIGlzIHNpbXBseSBhbiB1bmNvbW1vbgo+ID4gY29uZmlndXJhdGlv
bj8KPiA+IChzb21lIGRldmljZXMgaW4gYW4gSU9NTVUgc2NvcGUsIHdoaWxlIG90aGVycyBvdXRz
aWRlICphbnkqIElPTU1VCj4gPiBzY29wZSkKPiAKPiBUaGF0J3MgYSBrZXJuZWwgYnVnIGluIHRo
ZSB3YXkgaXQgaGFuZGxlcyBwZXItZGV2aWNlIERNQSBvcGVyYXRpb25zLiBPcgo+IG1vcmUgdG8g
dGhlIHBvaW50LCBpbiB0aGUgd2F5IGl0IGRvZXNuJ3Qg4oCUIHRoZSBub24tdHJhbnNsYXRlZCBk
ZXZpY2VzCj4gZW5kIHVwIGJlaW5nIHBvaW50ZWQgdG8gdGhlIGludGVsX2RtYV9vcHMgZGVzcGl0
ZSB0aGUgZmFjdCB0aGV5Cj4gc2hvdWxkbid0IGJlLiBJJ20gd29ya2luZyBvbiB0aGF0Li4uCj4g
Cj4gLS0gCj4gZHdtdzIKPiAKCkludGVyZXN0aW5nLiBUaGlzIHNlZW1zIHRvIGltcGx5IHN1Y2gg
Y29uZmlndXJhdGlvbnMgYXJlbid0CmNvbW1vbiwgc28gSSB3b25kZXIgd2hldGhlciBvdGhlciBn
dWVzdCBPUy1lcyB0cmVhdCB0aGVtCmNvcnJlY3RseS4KCklmIG1hbnkgb2YgdGhlbSBhcmUsIHdl
IHByb2JhYmx5IHNob3VsZG4ndCB1c2UgdGhpcyBpbiBRRU1VOgp3ZSBjYXJlIGFib3V0IGd1ZXN0
cyBhY3R1YWxseSB3b3JraW5nIDopCgotLSAKTVNUCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
