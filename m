From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 16:26:30 +1100
Message-ID: <1447133190.31884.65.camel@kernel.crashing.org>
References: <cover.1446162273.git.luto@kernel.org>
	<20151109133624-mutt-send-email-mst@redhat.com>
	<1447109937.31884.42.camel@kernel.crashing.org>
	<CALCETrX7Gkw3WrBHff=TpCFHj444E8hHcR6sAqOghQFBo5wp_A@mail.gmail.com>
	<1447121076.31884.61.camel@kernel.crashing.org>
	<CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrW5_bKCX5gKYaH5y4rvD9jrjY5O5d=oX8hHtAM9EE2Bew@mail.gmail.com>
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

T24gTW9uLCAyMDE1LTExLTA5IGF0IDE4OjE4IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
Cj4gCj4gV2hpY2ggbGVhdmVzIHRoZSBzcGVjaWFsIGNhc2Ugb2YgWGVuLCB3aGVyZSBldmVuIHBy
ZWV4aXN0aW5nIGRldmljZXMKPiBkb24ndCBieXBhc3MgdGhlIElPTU1VLsKgIENhbiB3ZSBrZWVw
IHRoaXMgc3BlY2lmaWMgdG8gcG93ZXJwYyBhbmQKPiBzcGFyYz/CoCBPbiB4ODYsIHRoaXMgcHJv
YmxlbSBpcyBiYXNpY2FsbHkgbm9uZXhpc3RlbnQsIHNpbmNlIHRoZSBJT01NVQo+IGlzIHByb3Bl
cmx5IHNlbGYtZGVzY3JpYmluZy4KPiAKPiBJT1csIEkgdGhpbmsgdGhhdCBvbiB4ODYgd2Ugc2hv
dWxkIGFzc3VtZSB0aGF0IGFsbCB2aXJ0aW8gZGV2aWNlcwo+IGhvbm9yIHRoZSBJT01NVS4KCllv
dSBkb24ndCBsaWtlIHBlcmZvcm1hbmNlcyA/IDotKQoKQ2hlZXJzLApCZW4uCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
