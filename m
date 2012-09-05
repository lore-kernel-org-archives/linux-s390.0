From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 1/7] s390/kvm: Support for I/O interrupts.
Date: Wed, 5 Sep 2012 10:26:00 +0200
Message-ID: <20120905102600.6759cec3@BR9GNB5Z>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771610-52423-2-git-send-email-cornelia.huck@de.ibm.com>
	<5046FF35.6050403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5046FF35.6050403@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 05 Sep 2012 10:28:53 +0300
Avi Kivity <avi@redhat.com> wrote:

> On 09/04/2012 06:13 PM, Cornelia Huck wrote:
> > Add support for handling I/O interrupts (standard, subchannel-related
> > ones and rudimentary adapter interrupts).
> > 
> > The subchannel-identifying parameters are encoded into the interrupt
> > type.
> > 
> > I/O interrupts are floating, so they can't be injected on a specific
> > vcpu.
> > 
> > diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> > index d808694..5a36e65 100644
> > --- a/include/linux/kvm.h
> > +++ b/include/linux/kvm.h
> > @@ -396,6 +396,12 @@ struct kvm_s390_psw {
> >  #define KVM_S390_INT_SERVICE		0xffff2401u
> >  #define KVM_S390_INT_EMERGENCY		0xffff1201u
> >  #define KVM_S390_INT_EXTERNAL_CALL	0xffff1202u
> > +#define KVM_S390_INT_IO(ai,cssid,ssid,schid)   \
> > +	(((schid)) |			       \
> > +	 ((ssid) << 16) |		       \
> > +	 ((cssid) << 18) |		       \
> > +	 ((ai) << 26))
> > +
> >  
> 
> Documentation?
> 

KVM_S390_INTERRUPT is currently completely undocumented... I'll
probably do an extra patch and then have this and the machine check
patch add the new values.
