From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/4] KVM-S390: Improve determination of sizes in
 kvm_s390_import_bp_data()
Date: Thu, 18 Aug 2016 05:02:23 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1608180502080.3107@hadrien>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net> <033d8595-d051-1fa8-95b1-5d2056eb5667@users.sourceforge.net> <57B562F3.1080004@bfs.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57B562F3.1080004@bfs.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: walter harms <wharms@bfs.de>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?ISO-8859-15?Q?Christian_Borntr=E4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>



On Thu, 18 Aug 2016, walter harms wrote:

>
>
> Am 17.08.2016 20:06, schrieb SF Markus Elfring:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 17 Aug 2016 18:29:04 +0200
> >
> > Replace the specification of data structures by pointer dereferences
> > to make the corresponding size determination a bit safer according to
> > the Linux coding style convention.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  arch/s390/kvm/guestdbg.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
> > index d1f8241..b68db4b 100644
> > --- a/arch/s390/kvm/guestdbg.c
> > +++ b/arch/s390/kvm/guestdbg.c
> > @@ -216,7 +216,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
> >  	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
> >  		return -EINVAL;
> >
> > -	size = dbg->arch.nr_hw_bp * sizeof(struct kvm_hw_breakpoint);
> > +	size = dbg->arch.nr_hw_bp * sizeof(*bp_data);
> >  	bp_data = kmalloc(size, GFP_KERNEL);
> >  	if (!bp_data) {
> >  		ret = -ENOMEM;
> > @@ -241,7 +241,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
> >  		}
> >  	}
> >
> > -	size = nr_wp * sizeof(struct kvm_hw_wp_info_arch);
> > +	size = nr_wp * sizeof(*wp_info);
> >  	if (size > 0) {
> >  		wp_info = kmalloc(size, GFP_KERNEL);
> >  		if (!wp_info) {
> > @@ -249,7 +249,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
> >  			goto error;
> >  		}
> >  	}
> > -	size = nr_bp * sizeof(struct kvm_hw_bp_info_arch);
> > +	size = nr_bp * sizeof(*bp_info);
> >  	if (size > 0) {
> >  		bp_info = kmalloc(size, GFP_KERNEL);
> >  		if (!bp_info) {
>
>
> IMHO the common pattern for kmalloc is
>   bp_info = kmalloc( nr_bp * sizeof(*bp_info), GFP_KERNEL);
>
> i can not remember code with a check for size < 0, i guess it is here
> to avoid an overflow ? since kmalloc takes a size_t argument this would cause
> a malloc failure an can be ignored.

Shoudn't it be kcalloc?

julia

>
>
> just my 2 cents.
> re,
>  wh
>
