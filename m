From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
Date: Mon, 22 Jan 2018 14:24:37 +0100
Message-ID: <20180122142437.18f390a0@mschwideX1>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
        <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
        <46e78910-6ea8-d384-df68-80b9e7fe0f6c@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <46e78910-6ea8-d384-df68-80b9e7fe0f6c@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 Jan 2018 14:14:56 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

Yes, please take this via the kvm tree.

>  thanks applied. 
> Martin unless you have concerns I will take this via the kvm tree.
> 
> On 12/13/2017 01:53 PM, Janosch Frank wrote:
> > It seems it hasn't even been used before the last cleanup and was
> > overlooked.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> > ---
> >  arch/s390/mm/gmap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> > index ffc11d8..d396da8 100644
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -2237,7 +2237,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
> >   * Called with sg->parent->shadow_lock.
> >   */
> >  static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
> > -			       unsigned long gaddr, pte_t *pte)
> > +			       unsigned long gaddr)
> >  {
> >  	struct gmap_rmap *rmap, *rnext, *head;
> >  	unsigned long start, end, bits, raddr;
> > @@ -2322,7 +2322,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
> >  			spin_lock(&gmap->shadow_lock);
> >  			list_for_each_entry_safe(sg, next,
> >  						 &gmap->children, list)
> > -				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
> > +				gmap_shadow_notify(sg, vmaddr, gaddr);
> >  			spin_unlock(&gmap->shadow_lock);
> >  		}
> >  		if (bits & PGSTE_IN_BIT)
> >   


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
