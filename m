From: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 22 Nov 2015 22:21:34 -0000
Message-ID: <adab330424e9faea591560c4097fc644.squirrel@twosheds.infradead.org>
References: <cover.1446014204.git.luto@kernel.org>
	<20151119153821-mutt-send-email-mst@redhat.com>
	<CALCETrXXsThXpbRMQ_CWTsq7_HiRFaK+dTeDYaz5cSm0QtoW_w@mail.gmail.com>
	<1447976286.145626.122.camel@infradead.org>
	<20151120085658-mutt-send-email-mst@redhat.com>
	<1448207908.89124.54.camel@infradead.org>
	<20151122231622-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151122231622-mutt-send-email-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.a@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>



> There's that, and there's an "I care about security, but
> do not want to burn up cycles on fake protections that
> do not work" case.

It would seem to make most sense for this use case simply *not* to expose
virtio devices to guests as being behind an IOMMU at all. Sure, there are
esoteric use cases where the guest actually nests and runs further guests
inside itself and wants to pass through the virtio devices from the real
hardware host. But presumably those configurations will have multiple
virtio devices assigned by the host anyway,  and further tweaking the
configuration to put them behind an IOMMU shouldn't be hard.


-- 
dwmw2
