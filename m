From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 06 May 2013 14:47:29 +0000
Subject: Re: Build failure after "phylib: remove !S390 dependeny from Kconfig"
Message-Id: <1367851649.4569.119.camel@chaos.site>
In-Reply-To: <20130506131040.GC4322@osiris>
References: <20130506131040.GC4322@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Le Monday 06 May 2013 � 15:10 +0200, Heiko Carstens a �crit :
> On Mon, May 06, 2013 at 01:40:07PM +0200, Jean Delvare wrote:
> > > (...)
> > > Well, I'm fine with your patch. As long as we don't have a nice solution
> > > for s390 being the only architecture with !GENERIC_HARDIRQS we will have
> > > to live with Kconfig hacks. Unfortunately.
> > 
> > OK. Will you pick what I sent as is, or do you want me to resend it
> > somewhere? Just let me know. FWIW I think this should go to the 3.9
> > stable kernel branch.
> 
> Since the patch is bit odd I think it should go to David Miller.

Not sure if David would enjoy reading that ;)

OK, I'll send it to David.

-- 
Jean Delvare
Suse L3
