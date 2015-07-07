From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: separate section for s390 virtio drivers
Date: Tue, 7 Jul 2015 11:44:44 +0200
Message-ID: <20150707114444.4f40675c.cornelia.huck@de.ibm.com>
References: <5593F756.9080703@redhat.com>
	<1435763737-10350-1-git-send-email-cornelia.huck@de.ibm.com>
	<55940495.9050007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <55940495.9050007@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Jul 2015 17:17:41 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> 
> 
> On 01/07/2015 17:15, Cornelia Huck wrote:
> > The s390-specific virtio drivers have probably more to do with virtio
> > than with kvm today; let's move them out into a separate section to
> > reflect this and to be able to add relevant mailing lists.
> > 
> > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  MAINTAINERS | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 246d9d8..fca5c00 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5766,7 +5766,6 @@ S:	Supported
> >  F:	Documentation/s390/kvm.txt
> >  F:	arch/s390/include/asm/kvm*
> >  F:	arch/s390/kvm/
> > -F:	drivers/s390/kvm/
> >  
> >  KERNEL VIRTUAL MACHINE (KVM) FOR ARM
> >  M:	Christoffer Dall <christoffer.dall@linaro.org>
> > @@ -10671,6 +10670,15 @@ F:	drivers/block/virtio_blk.c
> >  F:	include/linux/virtio_*.h
> >  F:	include/uapi/linux/virtio_*.h
> >  
> > +VIRTIO DRIVERS FOR S390
> > +M:	Christian Borntraeger <borntraeger@de.ibm.com>
> > +M:	Cornelia Huck <cornelia.huck@de.ibm.com>
> > +L:	linux-s390@vger.kernel.org
> > +L:	virtualization@lists.linux-foundation.org
> > +L:	kvm@vger.kernel.org
> 
> Keeping the KVM mailing list is probably a good idea.
> 
> > +S:	Supported
> > +F:	drivers/s390/kvm/
> 
> Since we are at it, do we want to rename the directory to
> drivers/s390/virtio?  

Makes sense, just sent a patch.

> Anyway:
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Paolo
> 
> >  VIRTIO HOST (VHOST)
> >  M:	"Michael S. Tsirkin" <mst@redhat.com>
> >  L:	kvm@vger.kernel.org

OK, how does this go upstream (I guess through the virtio tree)?
Michael, will you pick the patches or should I prepare a branch?
