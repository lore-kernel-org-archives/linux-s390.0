From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 13 Nov 2009 10:00:25 +0000
Subject: Re: strncmp errors?
Message-Id: <20091113100025.GD4839@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1258103991.16857.87.camel@Joe-Laptop.home>
References: <1258103991.16857.87.camel@Joe-Laptop.home>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 13, 2009 at 01:19:51AM -0800, Joe Perches wrote:
> On Fri, 2009-11-13 at 10:07 +0100, Heiko Carstens wrote:
> > On Mon, Nov 09, 2009 at 01:28:00PM -0800, Joe Perches wrote:
> > > Typically, strncmp uses the length of the second
> > > argument as the maximum comparison length.
> > > Perhaps these strncmp uses should be modified?
> > > arch/s390/kernel/vdso.c:	if (strncmp(s, "on", 3) == 0)
> > > arch/s390/kernel/vdso.c:	else if (strncmp(s, "off", 4) == 0)
> > > arch/s390/kernel/setup.c:	if (strncmp(str, "hwc", 4) == 0 || strncmp(str, "sclp", 5) == 0)
> > > arch/s390/kernel/setup.c:	if (strncmp(str, "3215", 5) == 0)
> > > arch/s390/kernel/setup.c:	if (strncmp(str, "3270", 5) == 0)
> > Why do you think we have errors in here?
> 
> Other uses of strncmp in the same file.
> 
> $ grep strncmp arch/s390/kernel/setup.c
> 	if (strncmp(str, "hwc", 4) == 0 || strncmp(str, "sclp", 5) == 0)
> 	if (strncmp(str, "3215", 5) == 0)
> 	if (strncmp(str, "3270", 5) == 0)

These are all NULL terminated.

> 		if (strncmp(ptr + 8, "3270", 4) == 0) {
> 		} else if (strncmp(ptr + 8, "3215", 4) == 0) {

These are not.

> 	if (!strncmp(p, "off", 3))

This one is NULL terminated.

> > The only thing I can see is that the length parameter is superfluous
> > and that we could have used strcmp instead.
> 
> If that's what's appropriate, isn't
> that what should actually be used?

So everything is correct. Can't see a reason to change anything here, except
for cleanup reasons. But it's not worth the test effort to verify if not
something breaks in a subtle manner.
