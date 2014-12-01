From: Jens Freimann <jfrei@linux.vnet.ibm.com>
Subject: Re: [GIT PULL 09/11] KVM: s390: add bitmap for handling cpu-local interrupts
Date: Mon, 01 Dec 2014 09:18:42 +0100
Message-ID: <1417421288-sup-219@linux.vnet.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-10-git-send-email-borntraeger@de.ibm.com> <5478AE7D.7010805@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-reply-to: <5478AE7D.7010805@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Excerpts from Paolo Bonzini's message of 2014-11-28 18:18:53 +0100:
> 
> On 28/11/2014 14:25, Christian Borntraeger wrote:
> >  
> > +struct kvm_s390_irq_payload {
> > +    struct kvm_s390_io_info io;
> > +    struct kvm_s390_ext_info ext;
> > +    struct kvm_s390_pgm_info pgm;
> > +    struct kvm_s390_emerg_info emerg;
> > +    struct kvm_s390_extcall_info extcall;
> > +    struct kvm_s390_prefix_info prefix;
> > +    struct kvm_s390_mchk_info mchk;
> > +};
> > +
> 
> struct or union?

This really should be a struct because we use it to keep payload data for
several parallel pending interrupts and don't want to write over other data. 

Jens

> 
> Paolo
