Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 28 Jul 2016 09:24:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [BUG -next] "random: make /dev/urandom scalable for silly
 userspace programs" causes crash
References: <20160727071400.GA3912@osiris>
 <20160728034601.GC20032@thunk.org>
 <20160728055548.GA3942@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728055548.GA3942@osiris>
Message-Id: <20160728072408.GB3942@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Theodore Ts'o <tytso@mit.edu>, linux-next@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 28, 2016 at 07:55:48AM +0200, Heiko Carstens wrote:
> On Wed, Jul 27, 2016 at 11:46:01PM -0400, Theodore Ts'o wrote:
> > On Wed, Jul 27, 2016 at 09:14:00AM +0200, Heiko Carstens wrote:
> > > it looks like your patch "random: make /dev/urandom scalable for silly
> > > userspace programs" within linux-next seems to be a bit broken:
> > > 
> > > It causes this allocation failure and subsequent crash on s390 with fake
> > > NUMA enabled
> > 
> > Thanks for reporting this.  This patch fixes things for you, yes?
> > 
> >        	   	     	    	       	     	    - Ted
> 
> Yes, it does. It's actually the same what I did to fix this ;)

Oh, I just realized that Linus pulled your changes. Actually I was hoping
we could get this fixed before the broken code would be merged.
Could you please make sure the bug fix gets included as soon as possible?

Right now booting a kernel with any defconfig on s390 will crash because of
this.

I will also change the fake NUMA code on s390, since it doesn't make sense
to have possible but not online nodes (in this case).

> > commit 59b8d4f1f5d26e4ca92172ff6dcd1492cdb39613
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Wed Jul 27 23:30:25 2016 -0400
> > 
> >     random: use for_each_online_node() to iterate over NUMA nodes
> >     
> >     This fixes a crash on s390 with fake NUMA enabled.
> >     
> >     Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> >     Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly userspace programs")
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 8d0af74..7f06224 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1668,13 +1668,12 @@ static int rand_initialize(void)
> >  #ifdef CONFIG_NUMA
> >  	pool = kmalloc(num_nodes * sizeof(void *),
> >  		       GFP_KERNEL|__GFP_NOFAIL|__GFP_ZERO);
> > -	for (i=0; i < num_nodes; i++) {
> > +	for_each_online_node(i) {
> >  		crng = kmalloc_node(sizeof(struct crng_state),
> >  				    GFP_KERNEL | __GFP_NOFAIL, i);
> >  		spin_lock_init(&crng->lock);
> >  		crng_initialize(crng);
> >  		pool[i] = crng;
> > -
> >  	}
> >  	mb();
> >  	crng_node_pool = pool;
> > 
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
