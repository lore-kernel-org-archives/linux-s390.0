From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Wed, 11 Nov 2015 11:44:42 +1100
Message-ID: <1447202682.31884.123.camel@kernel.crashing.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
	<1447133316.31884.67.camel@kernel.crashing.org>
	<CALCETrVPQc04Ah7FXcRMb4RhpUJ1WPCoC_4dbacB8a+u5XpmwA@mail.gmail.com>
	<1447151874.31884.82.camel@kernel.crashing.org>
	<CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
	<1447194427.31884.100.camel@kernel.crashing.org>
	<CALCETrWb9poeyxXhcbAbQkpcP-XYjWtz2w9iSPkKJH8rdzAj-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWb9poeyxXhcbAbQkpcP-XYjWtz2w9iSPkKJH8rdzAj-A@mail.gmail.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S.
	Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

T24gVHVlLCAyMDE1LTExLTEwIGF0IDE1OjQ0IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
Cj4gCj4gPiBXaGF0IGFib3V0IHBhcnRpdGlvbiA8LT4gcGFydGl0aW9uIHZpcnRpbyBzdWNoIGFz
IHdoYXQgd2UgY291bGQgZG8gb24KPiA+IFBBUFIgc3lzdGVtcy4gVGhhdCB3b3VsZCBoYXZlIHRo
ZSB3ZWFrIGJhcnJpZXIgYml0Lgo+ID4KPiAKPiBJcyBpdCBwYXJ0aXRpb24gPC0+IHBhcnRpdGlv
biwgYnlwYXNzaW5nIElPTU1VPwoKTm8uCgo+IEkgdGhpbmsgSSdkIHNldHRsZSBmb3IganVzdCBz
b21ldGhpbmcgdGhhdCBkb2Vzbid0IHJlZ3Jlc3MKPiBub24tZXhwZXJpbWVudGFsIHNldHVwcyB0
aGF0IGFjdHVhbGx5IHdvcmsgdG9kYXkgYW5kIHRoYXQgYWxsb3cgbmV3Cj4gc2V0dXBzICh4ODYg
d2l0aCBmaXhlZCBRRU1VIGFuZCBtYXliZSBzb21ldGhpbmcgbW9yZSBjb21wbGljYXRlZCBvbgo+
IHBvd2VycGMgYW5kL29yIHNwYXJjKSB0byB3b3JrIGluIGFsbCBjYXNlcy4KPiAKPiBXZSBjb3Vs
ZCBjZXJ0YWlubHkganVzdCBtYWtlIHBvd2VycGMgYW5kIHNwYXJjIGNvbnRpbnVlIGJ5cGFzc2lu
ZyB0aGUKPiBJT01NVSB1bnRpbCBzb21lb25lIGNvbWVzIHVwIHdpdGggYSB3YXkgdG8gZml4IGl0
LsKgIEknbGwgc2VuZCBvdXQgc29tZQo+IHBhdGNoZXMgdGhhdCBkbyB0aGF0LCBhbmQgbWF5YmUg
dGhhdCdsbCBoZWxwIHRoaXMgbWFrZSBwcm9ncmVzcy4KCkJ1dCB3ZSBoYXZlbid0IGZvdW5kIGEg
c29sdXRpb24gdGhhdCB3b3Jrcy4gQWxsIHdlIGhhdmUgY29tZSB1cCB3aXRoIGlzCmEgcXVpcmsg
dGhhdCB3aWxsIGZvcmNlIGJ5cGFzcyBvbiB2aXJ0aW8gYWx3YXlzIGFuZCB3aWxsIG5vdCBhbGxv
dyB1cwp0byBvcGVyYXRlIG5vbi1ieXBhc3NpbmcgZGV2aWNlcyBvbiBlaXRoZXIgb2YgdGhvc2Ug
YXJjaGl0ZWN0dXJlcyBpbgp0aGUgZnV0dXJlLgoKSSdtIG5vdCB0b28gaGFwcHkgYWJvdXQgdGhp
cy4KCkJlbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
