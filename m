From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] vfio/ccw: allocate irq info with the right size
Date: Tue, 18 Jul 2017 11:07:49 +0200
Message-ID: <20170718110749.5e7bcc65@gondolin>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
        <20170718014926.44781-2-bjsdjshi@linux.vnet.ibm.com>
        <20170718103213.29a597b2@gondolin>
        <20170718084943.GC15985@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170718084943.GC15985@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, Jing Zhang <bjzhjing@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Jul 2017 16:49:43 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2017-07-18 10:32:13 +0200]:
> 
> > On Tue, 18 Jul 2017 03:49:25 +0200
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> > > From: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
> > > 
> > > When allocating memory for the vfio_irq_info parameter of the
> > > VFIO_DEVICE_GET_IRQ_INFO ioctl, we used the wrong size. Let's
> > > fix it by using the right size.
> > > 
> > > Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > Signed-off-by: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
> > > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > > ---
> > >  hw/vfio/ccw.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > index 12d0262336..8d97b53e77 100644
> > > --- a/hw/vfio/ccw.c
> > > +++ b/hw/vfio/ccw.c
> > > @@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
> > >          return;
> > >      }
> > >  
> > > -    argsz = sizeof(*irq_set);
> > > +    argsz = sizeof(*irq_info);
> > >      irq_info = g_malloc0(argsz);
> > >      irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
> > >      irq_info->argsz = argsz;  
> > 
> > irq_set is larger than irq_info, but yes, let's do this correctly.
> > 
> > Out of curiosity, how did you spot this?
> >   
> 
> I'm trying to reuse the code here, while introducing some new MMIO
> regions, which you will see them some days later. ;>
> 

Looking forward to that :)
