From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 16:22:26 +0200
Message-ID: <20151028161424-mutt-send-email-mst@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151028091208-mutt-send-email-mst@redhat.com>
	<56307BD1.6010806@de.ibm.com>
	<1446019787.3405.203.camel@infradead.org>
	<20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446041609.3405.228.camel@infradead.org>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 11:13:29PM +0900, David Woodhouse wrote:
> On Wed, 2015-10-28 at 16:05 +0200, Michael S. Tsirkin wrote:
> > 
> > Short answer - platforms need a way to discover, and express different
> > security requirements of different devices.
> 
> Sure. PLATFORMS need that. Do not let it go anywhere near your device
> drivers. Including the virtio drivers.

But would there be any users of this outside the virtio subsystem?
If no, maybe virtio core is a logical place to keep this.

> > If they continue to lack that, we'll need a custom API in virtio,
> > and while this seems a bit less elegant, I would not see that as
> > the end of the world at all, there are not that many virtio drivers.
> 
> No. If they continue to lack that, we fix them. This is a *platform*
> issue. The DMA API shall do the right thing. Do not second-guess it.
> 
> 
>  (From the other mail)

I don't have a problem with extending DMA API to address
more usecases.

> > > > OK so I guess that means we should prefer a transport-specific
> > > > interface in virtio-pci then.
> > >
> > > Why?
> > 
> > Because you said you are doing something device tree specific for 
> > ARM, aren't you?
> 
> Nonono. The ARM platform code might do that, and the DMA API on ARM
> *might* give you I/O virtual addresses that look a lot like the
> physical addresses you asked it to map. That's none of your business.
> Drivers use DMA API. No more talky.

Well for virtio they don't ATM. And 1:1 mapping makes perfect sense
for the wast majority of users, so I can't switch them over
until the DMA API actually addresses all existing usecases.


> -- 
> dwmw2
> 
> 
