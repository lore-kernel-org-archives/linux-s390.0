From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 21:37:54 +1100
Message-ID: <1447151874.31884.82.camel@kernel.crashing.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
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
To: Andy Lutomirski <luto@amacapital.net>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

T24gTW9uLCAyMDE1LTExLTA5IGF0IDIxOjM1IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
Cj4gCj4gV2UgY291bGQgZG8gaXQgdGhlIG90aGVyIHdheSBhcm91bmQ6IG9uIHBvd2VycGMsIGlm
IGEgUENJIGRldmljZSBpcyBpbgo+IHRoYXQgcmFuZ2UgYW5kIGRvZXNuJ3QgaGF2ZSB0aGUgImJ5
cGFzcyIgcHJvcGVydHkgYXQgYWxsLCB0aGVuIGl0J3MKPiBhc3N1bWVkIHRvIGJ5cGFzcyB0aGUg
SU9NTVUuwqDCoFRoaXMgbWVhbnMgdGhhdCBldmVyeXRoaW5nIHRoYXQKPiBjdXJyZW50bHkgd29y
a3MgY29udGludWVzIHdvcmtpbmcuwqDCoElmIHNvbWVvbmUgYnVpbGRzIGEgcGh5c2ljYWwKPiB2
aXJ0aW8gZGV2aWNlIG9yIHVzZXMgYW5vdGhlciBzeXN0ZW0gaW4gUENJZSB0YXJnZXQgbW9kZSBz
cGVha2luZwo+IHZpcnRpbywgdGhlbiBpdCB3b24ndCB3b3JrIHVudGlsIHRoZXkgdXBncmFkZSB0
aGVpciBmaXJtd2FyZSB0byBzZXQKPiBieXBhc3M9MC7CoMKgTWVhbndoaWxlIGV2ZXJ5b25lIHVz
aW5nIGh5cG90aGV0aWNhbCBuZXcgUUVNVSBhbHNvIGdldHMKPiBieXBhc3M9MCBhbmQgbm8gYW1i
aWd1aXR5Lgo+Cj4gdmZpbyB3aWxsIHByZXN1bWFibHkgbm90aWNlIHRoZSBieXBhc3MgYW5kIGNv
cnJlY3RseSByZWZ1c2UgdG8gbWFwIGFueQo+IGN1cnJlbnQgdmlydGlvIGRldmljZXMuCj4gCj4g
V291bGQgdGhhdCB3b3JrPwoKVGhhdCB3b3VsZCBiZSBleHRyZW1lbHkgc3RyYW5nZSBmcm9tIGEg
cGxhdGZvcm0gcGVyc3BlY3RpdmUuIEFueSBkZXZpY2UKaW4gdGhhdCB2ZW5kb3IvZGV2aWNlIHJh
bmdlIHdvdWxkIGJ5cGFzcyB0aGUgaW9tbXUgdW5sZXNzIHNvbWUgbmV3CnByb3BlcnR5ICJhY3R1
YWxseS13b3Jrcy1saWtlLWEtcmVhbC1wY2ktZGV2aWNlIiBoYXBwZW5zIHRvIGV4aXN0IGluCnRo
ZSBkZXZpY2UtdHJlZSwgd2hpY2ggd2Ugd291bGQgdGhlbiBuZWVkIHRvIGRlZmluZSBzb21ld2hl
cmUgYW5kCmhhbmRsZSBhY2Nyb3NzIGF0IGxlYXN0IDMgZGlmZmVyZW50IHBsYXRmb3JtcyB3aG8g
Z2V0IHRoZWlyIGRldmljZS10cmVlIApmcm9tIHdpZGx5IGRpZmZlcmVudCBwbGFjZXMuCgpBbHNv
IGlmIHRvbW9ycm93IEkgY3JlYXRlIGEgUENJIGRldmljZSB0aGF0IGltcGxlbWVudHMgdmlydGlv
LW5ldCBhbmQKcHV0IGl0IGluIGEgbWFjaGluZSBydW5uaW5nIElCTSBwcm9wcmlldGFyeSBmaXJt
d2FyZSAob3IgQXBwbGUncyBvcgpTdW4ncyksIGl0IHdvbid0IGhhdmUgdGhhdCBwcm9wZXJ0eS4u
LgoKVGhpcyBpcyBub3QgaHlwb3RoZXRpY2FsLiBQZW9wbGUgYXJlIHVzaW5nIHZpcnRpbyB0byBk
byBwb2ludC10by1wb2ludApjb21tdW5pY2F0aW9uIGJldHdlZW4gbWFjaGluZXMgdmlhIFBDSWUg
dG9kYXkuCgpDaGVlcnMsCkJlbi4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
