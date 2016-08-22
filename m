From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/4] KVM-S390: Less function calls in
 kvm_s390_import_bp_data() after error detection
Date: Mon, 22 Aug 2016 21:37:36 +0200
Message-ID: <20160822213736.62f1ae29.cornelia.huck@de.ibm.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
        <47f88a11-b949-28ed-5589-925888a37574@users.sourceforge.net>
        <20160822150048.309a3e10.cornelia.huck@de.ibm.com>
        <cff92477-f426-a4c7-fffb-f8bbc378afe7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <cff92477-f426-a4c7-fffb-f8bbc378afe7@users.sourceforge.net>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christian =?UTF-8?B?Qm9ybnRyw6RnZXI=?= <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 Aug 2016 18:56:47 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> >> @@ -273,10 +273,12 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
> >>  	vcpu->arch.guestdbg.nr_hw_wp = nr_wp;
> >>  	vcpu->arch.guestdbg.hw_wp_info = wp_info;
> >>  	return 0;
> >> -error:
> >> -	kfree(bp_data);
> >> -	kfree(wp_info);
> >> +free_bp_info:
> >>  	kfree(bp_info);
> >> +free_wp_info:
> >> +	kfree(wp_info);
> >> +free_bp_data:
> >> +	kfree(bp_data);
> >>  	return ret;
> >>  }
> >>
> > 
> > This replaces a perfectly fine fallthrough
> 
> The usage of a single goto label like "error" seems to be convenient.
> But how do these habits fit to the current Linux coding style convention?
> 
> 
> > with some horrible labels.
> 
> Do they explain better which processing steps should be performed
> for an efficient exception handling in this function implementation?

*sigh*

It's _exception handling_. It does not need to be "efficient", it needs
to be easily parsable by humans. If in doubt, the compiler will be
_much_ better at optimizing that kind of stuff anyway.

So still NACK.
