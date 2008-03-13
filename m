Return-Path: <linux-kernel-owner+w=401wt.eu-S1754751AbYCMJNg@vger.kernel.org>
Subject: Re: [patch 3/6] Guest page hinting: mlocked pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200803131027.29378.rusty@rustcorp.com.au>
References: <20080312132132.520833247@de.ibm.com>
	 <20080312132703.689828503@de.ibm.com>
	 <200803131027.29378.rusty@rustcorp.com.au>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 10:13:17 +0100
Message-Id: <1205399597.26537.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-03-13 at 10:27 +1100, Rusty Russell wrote:
> On Thursday 13 March 2008 00:21:35 Martin Schwidefsky wrote:
> > --- linux-2.6.orig/include/linux/fs.h
> > +++ linux-2.6/include/linux/fs.h
> > @@ -513,6 +513,9 @@ struct address_space {
> >  	spinlock_t		private_lock;	/* for use by the address_space */
> >  	struct list_head	private_list;	/* ditto */
> >  	struct address_space	*assoc_mapping;	/* ditto */
> > +#ifdef CONFIG_PAGE_STATES
> > +	unsigned int		mlocked;	/* set if VM_LOCKED vmas present */
> > +#endif
> >  } __attribute__((aligned(sizeof(long))));
> 
> Minor nit: I think this would be better under private_lock where it wouldn't 
> consume any extra space on 64-bit.

Yes, makes sense. I moved the #ifdef.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
