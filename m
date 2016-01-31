From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [Xen-devel] [PATCH v5 09/10] vring: Use the DMA API on Xen
Date: Sun, 31 Jan 2016 12:27:39 -0800
Message-ID: <CALCETrVjocgx3wVcsgJ3-eLTASvS5rtam7SkQVyXGkx8=xVZFQ@mail.gmail.com>
References: <cover.1454034075.git.luto@kernel.org> <64e979cc139c5e6a9bbfae9f1bc5e6693d91bea9.1454034075.git.luto@kernel.org>
 <56AB4053.4070007@citrix.com> <20160131220601-mutt-send-email-mst@redhat.com>
 <CALCETrU4p5qz_3aq+Xrx7P2m0Ce0yWMczzjngjEp8OzL1yvX6Q@mail.gmail.com> <20160131221600-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20160131221600-mutt-send-email-mst@redhat.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jan 31, 2016 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 31, 2016 at 12:13:58PM -0800, Andy Lutomirski wrote:
>> On Sun, Jan 31, 2016 at 12:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Fri, Jan 29, 2016 at 10:34:59AM +0000, David Vrabel wrote:
>> >> On 29/01/16 02:31, Andy Lutomirski wrote:
>> >> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> >> > ---
>> >> >  drivers/virtio/virtio_ring.c | 12 ++++++++++++
>> >> >  1 file changed, 12 insertions(+)
>> >> >
>> >> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> >> > index c169c6444637..305c05cc249a 100644
>> >> > --- a/drivers/virtio/virtio_ring.c
>> >> > +++ b/drivers/virtio/virtio_ring.c
>> >> > @@ -47,6 +47,18 @@
>> >> >
>> >> >  static bool vring_use_dma_api(void)
>> >> >  {
>> >> > +#if defined(CONFIG_X86) && defined(CONFIG_XEN)
>> >> > +   /*
>> >> > +    * In theory, it's possible to have a buggy QEMU-supposed
>> >> > +    * emulated Q35 IOMMU and Xen enabled at the same time.  On
>> >> > +    * such a configuration, virtio has never worked and will
>> >> > +    * not work without an even larger kludge.  Instead, enable
>> >> > +    * the DMA API if we're a Xen guest, which at least allows
>> >> > +    * all of the sensible Xen configurations to work correctly.
>> >> > +    */
>> >> > +   return static_cpu_has(X86_FEATURE_XENPV);
>> >>
>> >> You want:
>> >>
>> >>     if (xen_domain())
>> >>         return true;
>> >>
>> >> Without the #if so we use the DMA API for all types of Xen guest on all
>> >> architectures.
>> >>
>> >> David
>> >
>> > I doubt HVM domains can have virtio devices.
>> >
>>
>> They certainly can under nested virt (L0 provides virtio device, L1 is
>> Xen, and L2 is Linux).  Of course, this won't work given the current
>> QEMU situation unless Xen can pass things through to dom0 without an
>> IOMMU, which seems plausible to me.
>>
>> But yes, xen_domain() sounds right to me.  I just failed to find that
>> function when I wrote this patch.
>>
>> Michael, if you like the rest of the series, I'd be okay if you
>> changed this patch to use xen_domain() when you apply it.  If I send a
>> v2, I'll fix it up.
>>
>> --Andy
>
> I'd rather you just posted a tested v2 of 9/10 for now as I don't test
> Xen.  It seems easy but I had more than my share of obvious fixes
> failing spectacularly.
>

In that case, let me test for real.  Can you point me to a git tree
when you have patches 1-8 staged and I'll spin patch 9 v2 and test it
with the real context?

--Andy
