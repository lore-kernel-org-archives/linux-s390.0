From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Tue, 10 Nov 2015 16:28:36 +1100
Message-ID: <1447133316.31884.67.camel@kernel.crashing.org>
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
Cj4gCj4gLyogUXVtcmFuZXQgZG9uYXRlZCB0aGVpciB2ZW5kb3IgSUQgZm9yIGRldmljZXMgMHgx
MDAwIHRocnUgMHgxMEZGLgo+ICovCj4gc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lk
IHZpcnRpb19wY2lfaWRfdGFibGVbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoCB7IFBDSV9ERVZJQ0Uo
MHgxYWY0LCBQQ0lfQU5ZX0lEKSB9LAo+IMKgwqDCoMKgwqDCoMKgIHsgMCB9Cj4gfTsKPiAKPiBD
YW4gd2UgbWF0Y2ggb24gdGhhdCByYW5nZT8KCldlIGNhbiwgYnV0IHRoZSBwcm9ibGVtIHJlbWFp
bnMsIGhvdyBkbyB3ZSBkaWZmZXJlbmNpYXRlIGFuIGV4aXN0aW5nCmRldmljZSB0aGF0IGRvZXMg
YnlwYXNzIHZzLiBhIG5ld2VyIG9uZSB0aGF0IG5lZWRzIHRoZSBJT01NVSBhbmQgdGh1cwpkb2Vz
bid0IGhhdmUgdGhlIG5ldyAiYnlwYXNzIiBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNlLXRyZWUuCgpD
aGVlcnMsCkJlbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
