From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Wed, 11 Nov 2015 16:08:33 +1100
Message-ID: <1447218513.31884.144.camel@kernel.crashing.org>
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
	<1447202682.31884.123.camel@kernel.crashing.org>
	<CALCETrWAVOATcCaUabunjYd+NYM1HRqJXG9K=DgrZCnBbWCexw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrWAVOATcCaUabunjYd+NYM1HRqJXG9K=DgrZCnBbWCexw@mail.gmail.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

T24gVHVlLCAyMDE1LTExLTEwIGF0IDIwOjQ2IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
Cj4gTWUgbmVpdGhlci7CoCBBdCBsZWFzdCBpdCB3b3VsZG4ndCBiZSBhIHJlZ3Jlc3Npb24sIGJ1
dCBpdCdzIHN0aWxsCj4gY3JhcHB5Lgo+IAo+IEkgdGhpbmsgdGhhdCBhcm0gaXMgZmluZSwgYXQg
bGVhc3QuwqAgSSB3YXMgdW5hYmxlIHRvIGZpbmQgYW4gYXJtIFFFTVUKPiBjb25maWcgdGhhdCBo
YXMgYW55IHByb2JsZW1zIHdpdGggbXkgcGF0Y2hlcy4KCk9rLCBnaXZlIG1lIGEgZmV3IGRheXMg
Zm9yIG15IGhlYWRhY2hlICYgZmV2ZXIgdG8gc3Vic2lkZSBzZWUgaWYgSSBjYW4KZmluZCBzb21l
dGhpbmcgYmV0dGVyLiBEYXZpZCwgbm8gaWRlYSBmcm9tIHlvdXIgc2lkZSA/IDotKQoKQ2hlZXJz
LApCZW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
