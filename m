From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC/PATCH 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Fri, 17 Nov 2017 10:19:28 +0100
Message-ID: <20171117101928.1ea9d354@mschwideX1>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
        <1510007400-42493-4-git-send-email-frankja@linux.vnet.ibm.com>
        <3b439732-70a4-8b95-4b9e-87f230dd7aaa@redhat.com>
        <eebe97cd-5c3d-f54f-6dfc-e6a105c57dc4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <eebe97cd-5c3d-f54f-6dfc-e6a105c57dc4@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 Nov 2017 10:02:57 +0100
Janosch Frank <frankja@linux.vnet.ibm.com> wrote:

> On 15.11.2017 10:55, David Hildenbrand wrote:
> > On 06.11.2017 23:29, Janosch Frank wrote:  
> >> For later migration of huge pages we want to write-protect guest
> >> PMDs. While doing this, we have to make absolutely sure, that the
> >> guest's lowcore is always accessible when the VCPU is running. With
> >> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
> >> the invalidation notification bit and kicking the guest out of the SIE
> >> via a notifier function if we need to invalidate such a page.
> >>
> >> With PMDs we do not have PGSTEs or some other bits we could use in the
> >> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
> >> time a host pmd will be invalidated, we will check if the respective
> >> gmap PMD has the bit set and in that case fire up the notifier.
> >>
> >> In the first step we only support setting the invalidation bit, but we
> >> do not support restricting access of guest pmds. It will follow
> >> shortly.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> >> ---  
> 
> >> index 74e2062..3961589 100644
> >> --- a/arch/s390/mm/gmap.c
> >> +++ b/arch/s390/mm/gmap.c
> >> @@ -595,10 +595,17 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
> >>  	if (*table == _SEGMENT_ENTRY_EMPTY) {
> >>  		rc = radix_tree_insert(&gmap->host_to_guest,
> >>  				       vmaddr >> PMD_SHIFT, table);
> >> -		if (!rc)
> >> -			*table = pmd_val(*pmd);
> >> -	} else
> >> -		rc = 0;
> >> +		if (!rc) {
> >> +			if (pmd_large(*pmd)) {
> >> +				*table = pmd_val(*pmd) &
> >> +					(_SEGMENT_ENTRY_ORIGIN_LARGE
> >> +					 | _SEGMENT_ENTRY_INVALID
> >> +					 | _SEGMENT_ENTRY_LARGE
> >> +					 | _SEGMENT_ENTRY_PROTECT);  
> > 
> > Can we reuse/define a mask for that?  
> 
> We could define GMAP masks, that only leave the bits needed for GMAP
> usage. Integrating this in pgtable.h might be hard and we only have one
> user of this.
> 
> > 
> > Like _SEGMENT_ENTRY_BITS_LARGE
> >   
> >> +			} else
> >> +				*table = pmd_val(*pmd) & ~0x03UL;  
> > 
> > Where exactly does the 0x03UL come from? Can we reuse e.g.
> > _SEGMENT_ENTRY_BITS here?  
> 
> No, _SEGMENT_ENTRY_BITS contains these bits.
> 
> This is effectively ~(_SEGMENT_ENTRY_READ | _SEGMENT_ENTRY_WRITE) to get
> rid of the software bits linux uses for tracking.
> 
> > 
> > Or is there a way to unify both cases?  
> 
> That will be difficult because of the different origin masks.
> 
> >>  
> >>  /*
> >> + * gmap_protect_large - set pmd notification bits  
> > 
> > Why not gmap_protect_pmd just like gmap_protect_pte?  
> 
> When I started I thought adding edat2 would not be harder than adding
> edat1. The large suffix could have later been used to do 1m and 2g
> handling because the bits are at the same places.
> 
> I'll change this one and all later occurrences.
> 
> >   
> >> + * @pmdp: pointer to the pmd to be protected
> >> + * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
> >> + * @bits: notification bits to set
> >> + *
> >> + * Returns 0 if successfully protected, -ENOMEM if out of memory and
> >> + * -EAGAIN if a fixup is needed.
> >> + *
> >> + * Expected to be called with sg->mm->mmap_sem in read and
> >> + * guest_table_lock held.  
> > 
> > gmap_pmd_op_walk() guarantees the latter, correct?  
> 
> Yes
> 
> >   
> >> + */
> >> +static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,
> >> +			      pmd_t *pmdp, int prot, unsigned long bits)
> >> +{
> >> +	int pmd_i, pmd_p;
> >> +
> >> +	pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
> >> +	pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;  
> > 
> > initialize both directly and make them const.  
> 
> Sure
> 
> >>  static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
> >>  			      unsigned long len, int prot, unsigned long bits)
> >> @@ -990,11 +1026,20 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
> >>  		rc = -EAGAIN;
> >>  		pmdp = gmap_pmd_op_walk(gmap, gaddr);
> >>  		if (pmdp) {
> >> -			rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
> >> -					      bits);
> >> -			if (!rc) {
> >> -				len -= PAGE_SIZE;
> >> -				gaddr += PAGE_SIZE;
> >> +			if (!pmd_large(*pmdp)) {
> >> +				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
> >> +						      bits);
> >> +				if (!rc) {
> >> +					len -= PAGE_SIZE;
> >> +					gaddr += PAGE_SIZE;
> >> +				}
> >> +			} else {
> >> +				rc =  gmap_protect_large(gmap, gaddr, pmdp,
> >> +							 prot, bits);
> >> +				if (!rc) {
> >> +					len = len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;  
> > 
> > Shouldn't you also have to take the difference to (gaddr & HPAGE_MASK)
> > into account, like you do in the next step? (so always subtracting
> > HPAGE_SIZE looks suspicious)  
> 
> Yes it seems we have to do that.
> We just never ran into troubles because len is generally < HPAGE_SIZE
> and tables don't seem to cross segment boundaries.
> 
> >> +/**
> >> + * pmdp_notify - call all invalidation callbacks for a specific pmd
> >> + * @mm: pointer to the process mm_struct
> >> + * @vmaddr: virtual address in the process address space
> >> + *
> >> + * This function is expected to be called with mmap_sem held in read.
> >> + */
> >> +void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
> >> +{
> >> +	unsigned long *table, gaddr;
> >> +	struct gmap *gmap;
> >> +
> >> +	rcu_read_lock();
> >> +	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
> >> +		spin_lock(&gmap->guest_table_lock);
> >> +		table = radix_tree_lookup(&gmap->host_to_guest,
> >> +					  vmaddr >> PMD_SHIFT);
> >> +		if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN)) {
> >> +			spin_unlock(&gmap->guest_table_lock);
> >> +			continue;
> >> +		}
> >> +		gaddr = __gmap_segment_gaddr(table);
> >> +		*table &= ~_SEGMENT_ENTRY_GMAP_IN;  
> > 
> > We can perform this page table change without any flushing/stuff like
> > that because we don't modify bits used by the HW. Is that guaranteed by
> > the architecture or are there any special conditions to take into
> > account? (applies also to were we set the _SEGMENT_ENTRY_GMAP_IN)  
> 
> ACC is ignored when the validity is 0 and 62 and 63 (0x3) are "available
> for programming".
> It pretty much sounds like these are OS bits free for any usage, I'll
> ask the hardware team when I find time.

Bits 62 and 63 used to be reserved bits but they have been defined for OS
usage with the z13 PoP.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
