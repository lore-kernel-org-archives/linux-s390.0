From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Date: Mon, 10 Mar 2008 01:37:53 +0000
Subject: Re: [PATCH 1/1] dasd: fix double elevator_exit call when deadline
Message-Id: <20080310013753.GC6396@josefsipek.net>
In-Reply-To: <1204884215.21438.3.camel@localhost>
References: <1204884215.21438.3.camel@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 07, 2008 at 11:03:35AM +0100, Martin Schwidefsky wrote:
> On Fri, 2008-03-07 at 10:28 +0100, Heiko Carstens wrote:
> > On Fri, Mar 07, 2008 at 10:17:51AM +0100, Martin Schwidefsky wrote:
> > > On Thu, 2008-03-06 at 21:08 +0100, Bastian Blank wrote:
> > > > On Wed, Mar 05, 2008 at 06:02:03PM -0500, Josef 'Jeff' Sipek wrote:
> > > > >  config DASD
> > > > >  	tristate "Support for DASD devices"
> > > > > -	depends on CCW && BLOCK
> > > > > +	depends on CCW && IOSCHED_DEADLINE && BLOCK
> > > > 
> > > > select IOSCHED_DEADLINE?
> > > 
> > > Yes, this makes more sense.
> > 
> > Err... I made the "depends on" suggestion because of this from
> > Documentation/kbuild/kconfig-language.txt :
> > 
> >   Note:
> > 	select is evil.... select will by brute force set a symbol
> > 	equal to 'y' without visiting the dependencies. So abusing
> > 	select you are able to select a symbol FOO even if FOO depends
> > 	on BAR that is not set. In general use select only for
> > 	non-visible symbols (no promts anywhere) and for symbols with
> > 	no dependencies. That will limit the usefulness but on the
> > 	other hand avoid the illegal configurations all over. kconfig
> > 	should one day warn about such things.
> 
> IOSCHED_DEADLINE depends only on BLOCK. Since the dasd driver itself
> depends on BLOCK the select will always work. I think this is better
> than a hidden dasd driver if IOSCHED_DEADLINE is not selected. 

It gets more ugly if/when someone changes the IOSCHED_DEADLINE dependencies
=> changes are that the DASD 'select' statement will not be updated.

Josef 'Jeff' Sipek.

-- 
Mankind invented the atomic bomb, but no mouse would ever construct a
mousetrap.
		- Albert Einstein
