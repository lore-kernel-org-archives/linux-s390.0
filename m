From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/6] virtio core DMA API conversion
Date: Wed, 11 Nov 2015 09:27:07 +1100
Message-ID: <1447194427.31884.100.camel@kernel.crashing.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALCETrVkE3=KCxK-_bf-P8UfTS96Vck+QPE8EsLvP7THxpLe1A@mail.gmail.com>
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

T24gVHVlLCAyMDE1LTExLTEwIGF0IDEwOjU0IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
Cj7CoAo+IERvZXMgdGhhdCB3b3JrIG9uIHBvd2VycGMgb24gZXhpc3Rpbmcga2VybmVscz8KPiAK
PiBBbnl3YXksIGhlcmUncyBhbm90aGVyIGNyYXp5IGlkZWE6IG1ha2UgdGhlIHF1aXJrIGFzc3Vt
ZSB0aGF0IHRoZQo+IElPTU1VIGlzIGJ5cGFzc2VzIGlmIGFuZCBvbmx5IGlmIHRoZSB3ZWFrIGJh
cnJpZXJzIGJpdCBpcyBzZXQgb24KPiBzeXN0ZW1zIHRoYXQgYXJlIG1pc3NpbmcgdGhlIG5ldyBE
VCBiaW5kaW5nLgoKIk5ldyBEVCBiaW5kaW5ncyIgZG9lc24ndCBtZWFuIG11Y2ggLi4uIGhvdyBk
byB3ZSBjaGFuZ2UgRFQgYmluZGluZ3Mgb24KZXhpc3RpbmcgbWFjaGluZXMgd2l0aCBhIEZXIGlu
IGZsYXNoID8KCldoYXQgYWJvdXQgcGFydGl0aW9uIDwtPiBwYXJ0aXRpb24gdmlydGlvIHN1Y2gg
YXMgd2hhdCB3ZSBjb3VsZCBkbyBvbgpQQVBSIHN5c3RlbXMuIFRoYXQgd291bGQgaGF2ZSB0aGUg
d2VhayBiYXJyaWVyIGJpdC4KCkJlbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
