From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Fri, 20 Nov 2015 13:56:39 +1100
Message-ID: <1447988199.3016.2.camel@kernel.crashing.org>
References: <cover.1446014204.git.luto@kernel.org>
	<20151119153821-mutt-send-email-mst@redhat.com>
	<CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
	<1447976286.145626.122.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447976286.145626.122.camel@infradead.org>
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
To: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@amacapital.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

T24gVGh1LCAyMDE1LTExLTE5IGF0IDIzOjM4ICswMDAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6
Cj4gCj4gSSB1bmRlcnN0YW5kIHRoYXQgUE9XRVIgYW5kIG90aGVyIHBsYXRmb3JtcyBkb24ndCBj
dXJyZW50bHkgaGF2ZSBhCj4gY2xlYW4gd2F5IHRvIGluZGljYXRlIHRoYXQgY2VydGFpbiBkZXZp
Y2UgZG9uJ3QgaGF2ZSB0cmFuc2xhdGlvbi4gQW5kIEkKPiB1bmRlcnN0YW5kIHRoYXQgd2UgbWF5
IGVuZCB1cCB3aXRoIGEgKnF1aXJrKiB3aGljaCBlbnN1cmVzIHRoYXQgdGhlIERNQQo+IEFQSSBk
b2VzIHRoZSByaWdodCB0aGluZyAoaS5lLiBub3RoaW5nKSBpbiBjZXJ0YWluIGNhc2VzLgo+IAo+
IEJ1dCB3ZSBzaG91bGQgKk5PVCogYmUgaW52b2x2aW5nIHRoZSB2aXJ0aW8gZGV2aWNlIGRyaXZl
cnMgaW4gdGhhdAo+IHF1aXJrLCBpbiBhbnkgd2F5LiBBbmQgcHV0dGluZyBhIGZlYXR1cmUgYml0
IGluIHRoZSB2aXJ0aW8gZGV2aWNlCj4gaXRzZWxmIGRvZXNuJ3Qgc2VlbSBhdCBhbGwgc2FuZSBl
aXRoZXIuCj4gCj4gQmVhciBpbiBtaW5kIHRoYXQgcWVtdS1zeXN0ZW0teDg2XzY0IGN1cnJlbnRs
eSBoYXMgdGhlICpzYW1lKiBwcm9ibGVtCj4gd2l0aCBhc3NpZ25lZCBwaHlzaWNhbCBkZXZpY2Vz
LiBJdCdzIGNsYWltaW5nIHRoZXkncmUgdHJhbnNsYXRlZCwgYW5kCj4gdGhleSdyZSBub3QuCgpJ
dCdzIG5vdCB0aGF0IGNsZWFyIGJ1dCB5ZWFoIC4uLiBhcyBJIG1lbnRpb25lZCwgSSBjYW4ndCBm
aW5kIGEKd2F5IHRvIGRvIHRoYXQgcXVpcmsgdGhhdCB3b24ndCBicmVhayB3aGVuIHdlIHdhbnQg
dG8gYWN0dWFsbHkgdXNlCnRoZSBpb21tdS4uLsKgCgpCZW4uCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
