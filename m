Return-Path: <linux-kernel-owner+w=401wt.eu-S1755826AbXKFVk0@vger.kernel.org>
Date: Tue, 6 Nov 2007 13:39:29 -0800
From: Greg KH <greg@kroah.com>
Subject: Re: mm snapshot broken-out-2007-11-06-02-32.tar.gz uploaded -
	S390x build fails
Message-ID: <20071106213929.GA13634@kroah.com>
References: <200711061033.lA6AXrhT018804@imap1.linux-foundation.org> <473083CA.9060607@linux.vnet.ibm.com> <20071106131037.ea014b48.akpm@linux-foundation.org> <20071106211345.GB5993@kroah.com> <20071106143344.b9e5ba09.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071106143344.b9e5ba09.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, apw@shadowen.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 06, 2007 at 02:33:44PM -0800, Andrew Morton wrote:
> > On Tue, 6 Nov 2007 13:13:45 -0800 Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 06, 2007 at 01:10:37PM -0800, Andrew Morton wrote:
> > > > On Tue, 06 Nov 2007 20:40:02 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> > > > drivers/s390/char/sclp_cpi_sys.c:242: error: storage size of `system_name_attr' isn't known
> > > > drivers/s390/char/sclp_cpi_sys.c:264: error: storage size of `sysplex_name_attr' isn't known
> > > > drivers/s390/char/sclp_cpi_sys.c:287: error: storage size of `system_type_attr' isn't known
> > > > drivers/s390/char/sclp_cpi_sys.c:317: error: storage size of `system_level_attr' isn't known
> > > > drivers/s390/char/sclp_cpi_sys.c:333: error: storage size of `set_attr' isn't known
> > > > make[2]: *** [drivers/s390/char/sclp_cpi_sys.o] Error 1
> > > > make[1]: *** [drivers/s390/char] Error 2
> > > > make: *** [drivers/s390] Error 2
> > > > 
> > > > The patch git-s390.patch is causing this failure.
> > > 
> > > git-s390 newly adds that file.  I suspect that this code works OK for the
> > > s390 guys (they're using Linux).  But Greg's driver tree basically ports
> > > their driver to Gregnux, in which nothing works any more.
> > > 
> > > Greg, this is turning into a bit of a trainwreck.  Can you please have a
> > > think about how we can provide a bit of back-compatibility to ease this
> > > transition rather than just trashing everything?
> > 
> > It's _always_ a trainwreck when I touch anything in the driver core,
> > look at how many individual patches it took to do a lot of this work
> > (50+ and still growing).  My method is to introduce the new api, convert
> > everyone over to it, and then remove the old crappy one.
> > 
> > Now for dealing with external trees, I have _no_ visiblity into them for
> > the most part.  I can't build s390 stuff (no cross compiler), so I can't
> > even test their changes.
> > 
> > But, there really should not be that many places that are touching these
> > types of things that I am currently changing (ksets and ktypes and
> > subsystems.)
> > 
> > So, how do I do this?  Do I just not let my changes trickle into your
> > tree, and hold off until I merge them with Linus, hoping that me and Kay
> > have tested everything good enough?  That way, no build ever should
> > break, but functionality might not be all working as well as it could
> > be.
> > 
> > Or we live with some breakage as you pull my stuff into your tree.
> > 
> > Either way, I'm glad to help fix the broken stuff, and I'm also glad to
> > take the responsibility for getting this all right the first time it
> > goes to Linus.
> > 
> > What do you think is best to do?
> > 
> 
> Leave the old interfaces in place, deprecate them, remove them later.  If
> at all possible.

It's usually not a matter of them being "interfaces" but structure
changes.  The only way to slim these things down into something that
works properly (ksets being dynamic instead of static), and changing
the majority of these ksets into kobjects as ksets is not the correct
usage, doesn't lend themselves to being able to keep the old stuff
around anymore.

Almost all of these build problems are a simple one-line change in the
offending code, so it's not a tough change for me to do on stuff in your
tree.

thanks,

greg k-h
