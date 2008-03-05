From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 05 Mar 2008 08:58:22 +0000
Subject: Re: [PATCH 1/1] dasd: do not force use of deadline IO scheduler
Message-Id: <20080305085822.GA4419@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20080304192601.GK6664@josefsipek.net>
References: <20080304192601.GK6664@josefsipek.net>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> > Considering the call trace you sent:
> > 
> > > -	elevator_exit(block->request_queue->elevator);
> > > -	rc = elevator_init(block->request_queue, "deadline");
> > 
> > block->request_queue->elevator = NULL is missing here.
> > 
> > > -	if (rc) {
> > > -		blk_cleanup_queue(block->request_queue);
> > > -		return rc;
> > > -	}
> > 
> > Fallback to noop and printing a warning wouldn't be bad.
> 
> Is noop better than the default (e.g., CFQ)?
> 
> I was thinking that if the deadline init fails, we put back the old elevator
> - whatever it may be.
> 
> > In addition something like depends on IOSCHED_DEADLINE should be added to
> > the Kconfig file.
> 
> Alright, so...
> 
> 1) Kconfig change, ->elevator = NULL

That should be the way to go, since we want the deadline scheduler.
