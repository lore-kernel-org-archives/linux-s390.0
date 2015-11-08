From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Sun, 8 Nov 2015 12:37:47 +0200
Message-ID: <20151108120627-mutt-send-email-mst@redhat.com>
References: <20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
	<20151028175136-mutt-send-email-mst@redhat.com>
	<CALCETrWd7mK5bW2p_dvvjDRnqE31=ueAz5SAYKwY-PD5uZp76A@mail.gmail.com>
	<20151029104301-mutt-send-email-mst@redhat.com>
	<1446135536.3405.279.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446135536.3405.279.camel@infradead.org>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 29, 2015 at 05:18:56PM +0100, David Woodhouse wrote:
> On Thu, 2015-10-29 at 11:01 +0200, Michael S. Tsirkin wrote:
> > 
> > Example: you have a mix of assigned devices and virtio devices. You
> > don't trust your assigned device vendor not to corrupt your memory so
> > you want to limit the damage your assigned device can do to your
> > guest,
> > so you use an IOMMU for that.  Thus existing iommu=pt within guest is
> > out.
> > 
> > But you trust your hypervisor (you have no choice anyway),
> > and you don't want the overhead of tweaking IOMMU
> > on data path for virtio. Thus iommu=on is out too.
> 
> That's not at all special for virtio or guest VMs. Even with real
> hardware, we might want performance from *some* devices, and security
> from others. See the DMA_ATTR_IOMMU_BYPASS which is currently being
> discussed.

Right. So let's wait for that discussion to play out?

> But of course the easy answer in *your* case it just to ask the
> hypervisor not to put the virtio devices behind an IOMMU at all. Which
> we were planning to remain the default behaviour.

One can't do this for x86 ATM, can one?

> In all cases, the DMA API shall do the right thing.

I have no problem with that. For example, can we teach
the DMA API on intel x86 to use PT for virtio by default?
That would allow merging Andy's patches with
full compatibility with old guests and hosts.

> -- 
> dwmw2
> 
> 



-- 
MST
