From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/3] s390: Virtual channel subsystem support.
Date: Tue, 13 Nov 2012 11:11:34 +0100
Message-ID: <20121113111134.1a8baad1@BR9GNB5Z>
References: <1351700688-42353-1-git-send-email-cornelia.huck@de.ibm.com>
	<1351700688-42353-3-git-send-email-cornelia.huck@de.ibm.com>
	<20121113011755.GA27831@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121113011755.GA27831@amt.cnet>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 12 Nov 2012 23:17:55 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> Hi Cornelia,
> 
> On Wed, Oct 31, 2012 at 05:24:47PM +0100, Cornelia Huck wrote:
> > Provide a mechanism for qemu to provide fully virtual subchannels to
> > the guest. In the KVM case, this relies on the kernel's css support
> > for I/O and machine check interrupt handling. The !KVM case handles
> > interrupts on its own.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/s390x/Makefile.objs     |    1 +
> >  hw/s390x/css.c             | 1209 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/s390x/css.h             |   90 ++++
> >  target-s390x/Makefile.objs |    2 +-
> >  target-s390x/cpu.h         |  232 +++++++++
> >  target-s390x/helper.c      |  146 ++++++
> >  target-s390x/ioinst.c      |  737 +++++++++++++++++++++++++++
> >  target-s390x/ioinst.h      |  213 ++++++++
> >  target-s390x/kvm.c         |  251 ++++++++-
> >  target-s390x/misc_helper.c |    6 +-
> >  10 files changed, 2872 insertions(+), 15 deletions(-)
> >  create mode 100644 hw/s390x/css.c
> >  create mode 100644 hw/s390x/css.h
> >  create mode 100644 target-s390x/ioinst.c
> >  create mode 100644 target-s390x/ioinst.h
> 
> > +void kvm_s390_enable_css_support(CPUS390XState *env)
> > +{
> > +    struct kvm_enable_cap cap = {};
> > +    int r;
> > +
> > +    /* Activate host kernel channel subsystem support. */
> > +    if (kvm_enabled()) {
> > +        /* One CPU has to run */
> > +        s390_add_running_cpu(env);
> 
> Care to explain this?

Old code leftovers; I've removed it.

> 
> > +
> > +        cap.cap = KVM_CAP_S390_CSS_SUPPORT;
> > +        r = kvm_vcpu_ioctl(env, KVM_ENABLE_CAP, &cap);
> > +        assert(r == 0);
> > +    }
> > +}
> 
> 
