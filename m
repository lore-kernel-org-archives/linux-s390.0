From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: separate section for s390 virtio drivers
Date: Tue, 7 Jul 2015 14:19:41 +0300
Message-ID: <20150707141919-mutt-send-email-mst@redhat.com>
References: <5593F756.9080703@redhat.com>
 <1435763737-10350-1-git-send-email-cornelia.huck@de.ibm.com>
 <55940495.9050007@redhat.com>
 <20150707114444.4f40675c.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707114444.4f40675c.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 07, 2015 at 11:44:44AM +0200, Cornelia Huck wrote:
> On Wed, 1 Jul 2015 17:17:41 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > 
> > 
> > On 01/07/2015 17:15, Cornelia Huck wrote:
> > > The s390-specific virtio drivers have probably more to do with virtio
> > > than with kvm today; let's move them out into a separate section to
> > > reflect this and to be able to add relevant mailing lists.
> > > 
> > > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > ---
> > >  MAINTAINERS | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 246d9d8..fca5c00 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -5766,7 +5766,6 @@ S:	Supported
> > >  F:	Documentation/s390/kvm.txt
> > >  F:	arch/s390/include/asm/kvm*
> > >  F:	arch/s390/kvm/
> > > -F:	drivers/s390/kvm/
> > >  
> > >  KERNEL VIRTUAL MACHINE (KVM) FOR ARM
> > >  M:	Christoffer Dall <christoffer.dall@linaro.org>
> > > @@ -10671,6 +10670,15 @@ F:	drivers/block/virtio_blk.c
> > >  F:	include/linux/virtio_*.h
> > >  F:	include/uapi/linux/virtio_*.h
> > >  
> > > +VIRTIO DRIVERS FOR S390
> > > +M:	Christian Borntraeger <borntraeger@de.ibm.com>
> > > +M:	Cornelia Huck <cornelia.huck@de.ibm.com>
> > > +L:	linux-s390@vger.kernel.org
> > > +L:	virtualization@lists.linux-foundation.org
> > > +L:	kvm@vger.kernel.org
> > 
> > Keeping the KVM mailing list is probably a good idea.
> > 
> > > +S:	Supported
> > > +F:	drivers/s390/kvm/
> > 
> > Since we are at it, do we want to rename the directory to
> > drivers/s390/virtio?  
> 
> Makes sense, just sent a patch.
> 
> > Anyway:
> > 
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Paolo
> > 
> > >  VIRTIO HOST (VHOST)
> > >  M:	"Michael S. Tsirkin" <mst@redhat.com>
> > >  L:	kvm@vger.kernel.org
> 
> OK, how does this go upstream (I guess through the virtio tree)?
> Michael, will you pick the patches or should I prepare a branch?

I'll pick these up.

-- 
MST
