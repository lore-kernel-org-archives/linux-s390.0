From: Jens Freimann <jfrei@linux.vnet.ibm.com>
Subject: Re: [GIT PULL 05/11] KVM: s390: refactor interrupt injection code
Date: Mon, 01 Dec 2014 09:22:03 +0100
Message-ID: <1417422046-sup-6015@linux.vnet.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com> <1417181139-25623-6-git-send-email-borntraeger@de.ibm.com> <5478ADD3.10307@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-reply-to: <5478ADD3.10307@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Excerpts from Paolo Bonzini's message of 2014-11-28 18:16:03 +0100:
> 
> On 28/11/2014 14:25, Christian Borntraeger wrote:
> >  
> > +static int __inject_prog_irq(struct kvm_vcpu *vcpu,
> > +                 struct kvm_s390_interrupt_info *inti)
> > +{
> 
> Why the __s? :)

I used the __s here to say "careful, this is usually not called directly". 

Jens

> 
> Paolo
