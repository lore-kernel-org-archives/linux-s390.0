From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 02/12] KVM: s390: define GISA format-0 data structure
Date: Wed, 17 Jan 2018 08:57:22 +0100
Message-ID: <20180117075722.GA5708@osiris>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-3-borntraeger@de.ibm.com>
 <d25b016f-eb6f-7b8e-87d8-9224291be6c8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d25b016f-eb6f-7b8e-87d8-9224291be6c8@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 16, 2018 at 09:25:12PM +0100, David Hildenbrand wrote:
> 
> > +struct kvm_s390_gisa {
> > +	u32 next_alert;
> > +	u8 ipm;
> > +	u8 reserved01;
> > +	u8:6;
> > +	u8 g:1;
> > +	u8 c:1;
> > +	u8 iam;
> > +	u8 reserved02[4];
> > +	u32 airq_count;
> > +};
> > +
> >  /*
> > - * sie_page2 has to be allocated as DMA because fac_list and crycb need
> > - * 31bit addresses in the sie control block.
> > + * sie_page2 has to be allocated as DMA because fac_list, crycb and
> > + * gisa need 31bit addresses in the sie control block.
> >   */
> >  struct sie_page2 {
> >  	__u64 fac_list[S390_ARCH_FAC_LIST_SIZE_U64];	/* 0x0000 */
> >  	struct kvm_s390_crypto_cb crycb;		/* 0x0800 */
> > -	u8 reserved900[0x1000 - 0x900];			/* 0x0900 */
> > +	struct kvm_s390_gisa gisa __aligned(sizeof(struct kvm_s390_gisa)); /* 0x0900 */
> 
> can we instead specify sie_page2 as packed if really needed? (I can see
> that we have a BUILD_BUG_ON below, which is nice)
> 
> (alignment within well defined data structures looks strange)

The alignment, if needed, should go to the definition of struct
kvm_s390_gisa above. The structure needs at least an alignment of eight
bytes since bitops are used to modify ipm (in a later patch), by using a
(long *) cast to this structure.
But of course it is all naturally aligned anyway... ;)
