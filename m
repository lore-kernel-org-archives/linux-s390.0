From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Xen-devel] [PATCH v5 09/10] vring: Use the DMA API on Xen
Date: Sun, 31 Jan 2016 22:18:17 +0200
Message-ID: <20160131221600-mutt-send-email-mst@redhat.com>
References: <cover.1454034075.git.luto@kernel.org>
	<64e979cc139c5e6a9bbfae9f1bc5e6693d91bea9.1454034075.git.luto@kernel.org>
	<56AB4053.4070007@citrix.com>
	<20160131220601-mutt-send-email-mst@redhat.com>
	<CALCETrU4p5qz_3aq+Xrx7P2m0Ce0yWMczzjngjEp8OzL1yvX6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrU4p5qz_3aq+Xrx7P2m0Ce0yWMczzjngjEp8OzL1yvX6Q@mail.gmail.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jan 31, 2016 at 12:13:58PM -0800, Andy Lutomirski wrote:
> On Sun, Jan 31, 2016 at 12:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Jan 29, 2016 at 10:34:59AM +0000, David Vrabel wrote:
> >> On 29/01/16 02:31, Andy Lutomirski wrote:
> >> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> >> > ---
> >> >  drivers/virtio/virtio_ring.c | 12 ++++++++++++
> >> >  1 file changed, 12 insertions(+)
> >> >
> >> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> >> > index c169c6444637..305c05cc249a 100644
> >> > --- a/drivers/virtio/virtio_ring.c
> >> > +++ b/drivers/virtio/virtio_ring.c
> >> > @@ -47,6 +47,18 @@
> >> >
> >> >  static bool vring_use_dma_api(void)
> >> >  {
> >> > +#if defined(CONFIG_X86) && defined(CONFIG_XEN)
> >> > +   /*
> >> > +    * In theory, it's possible to have a buggy QEMU-supposed
> >> > +    * emulated Q35 IOMMU and Xen enabled at the same time.  On
> >> > +    * such a configuration, virtio has never worked and will
> >> > +    * not work without an even larger kludge.  Instead, enable
> >> > +    * the DMA API if we're a Xen guest, which at least allows
> >> > +    * all of the sensible Xen configurations to work correctly.
> >> > +    */
> >> > +   return static_cpu_has(X86_FEATURE_XENPV);
> >>
> >> You want:
> >>
> >>     if (xen_domain())
> >>         return true;
> >>
> >> Without the #if so we use the DMA API for all types of Xen guest on all
> >> architectures.
> >>
> >> David
> >
> > I doubt HVM domains can have virtio devices.
> >
> 
> They certainly can under nested virt (L0 provides virtio device, L1 is
> Xen, and L2 is Linux).  Of course, this won't work given the current
> QEMU situation unless Xen can pass things through to dom0 without an
> IOMMU, which seems plausible to me.
> 
> But yes, xen_domain() sounds right to me.  I just failed to find that
> function when I wrote this patch.
> 
> Michael, if you like the rest of the series, I'd be okay if you
> changed this patch to use xen_domain() when you apply it.  If I send a
> v2, I'll fix it up.
> 
> --Andy

I'd rather you just posted a tested v2 of 9/10 for now as I don't test
Xen.  It seems easy but I had more than my share of obvious fixes
failing spectacularly.

-- 
MST
