From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v3 1/2] KVM: kvm-io: support cookies
Date: Wed, 3 Jul 2013 17:26:03 +0300
Message-ID: <20130703142603.GD32123@redhat.com>
References: <1372859439-18733-1-git-send-email-cornelia.huck@de.ibm.com>
 <1372859439-18733-2-git-send-email-cornelia.huck@de.ibm.com>
 <20130703135642.GC32123@redhat.com>
 <20130703161439.579c3a0f@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130703161439.579c3a0f@gondolin>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jul 03, 2013 at 04:14:39PM +0200, Cornelia Huck wrote:
> On Wed, 3 Jul 2013 16:56:42 +0300
> Gleb Natapov <gleb@redhat.com> wrote:
> 
> > On Wed, Jul 03, 2013 at 03:50:38PM +0200, Cornelia Huck wrote:
> > > Add new functions kvm_io_bus_{read,write}_cookie() that allows users of
> > > the kvm io infrastructure to use a cookie value to speed up lookup of a
> > > device on an io bus.
> > > 
> > > kvm_io_bus_{read,write} now returns the index on the bus; existing callers
> > > have been fixed up to accept return codes > 0.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > ---
> > >  arch/ia64/kvm/kvm-ia64.c   |   2 +-
> > >  arch/powerpc/kvm/powerpc.c |   4 +-
> > >  arch/x86/kvm/x86.c         |   6 +--
> > >  include/linux/kvm_host.h   |   4 ++
> > >  virt/kvm/kvm_main.c        | 102 ++++++++++++++++++++++++++++++++++++++-------
> > >  5 files changed, 97 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> > > index 5b2dc0d..465ab54 100644
> > > --- a/arch/ia64/kvm/kvm-ia64.c
> > > +++ b/arch/ia64/kvm/kvm-ia64.c
> > > @@ -250,7 +250,7 @@ mmio:
> > >  	else
> > >  		r = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, p->addr,
> > >  				     p->size, &p->data);
> > > -	if (r)
> > > +	if (r < 0)
> > No need to change kvm_io_bus_(read|write) return value now. Just do
> > there:
> > 
> >   r = __kvm_io_bus_write(bus, &range, val);
> >   return  r >=0 ? 0 : r;
> > 
> 
> Well, if the index is not interesting for anything but the cookie code,
> I can certainly drop it.
It is certainly not right now.

--
			Gleb.
