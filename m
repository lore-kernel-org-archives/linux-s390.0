Return-Path: <linux-kernel-owner+w=401wt.eu-S1763341AbYHEWiW@vger.kernel.org>
Date: Tue, 5 Aug 2008 15:34:29 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 3/3] kmsg: convert xpram messages to kmsg api.
Message-ID: <20080805223429.GB6552@suse.de>
References: <20080730165656.118280544@de.ibm.com> <20080730171157.550296160@de.ibm.com> <20080730194308.GB22441@suse.de> <1217493222.8555.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217493222.8555.8.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 31, 2008 at 10:33:42AM +0200, Martin Schwidefsky wrote:
> On Wed, 2008-07-30 at 12:43 -0700, Greg KH wrote:
> > On Wed, Jul 30, 2008 at 06:56:59PM +0200, Martin Schwidefsky wrote:
> > > Index: linux-2.6/Documentation/kmsg/s390/xpram
> > > ===================================================================
> > > --- /dev/null
> > > +++ linux-2.6/Documentation/kmsg/s390/xpram
> > > @@ -0,0 +1,54 @@
> > > +/*?
> > > + * Tag: xpram.1
> > 
> > Ick, so you are going to have to define a message number per file?
> > How is that going to work, it looks like you use ids 0-2 below in the .c
> > file, yet in this documentation file they are 1-3.  Off by one
> > somewhere?  :)
> 
> The kmsg number 0 is special, the message tag will not include the
> message number for id 0. And the script won't complain that the message
> description is missing.

Was "0 is special" defined anywhere that I missed?

> And yes, we WANT to define the message numbers per kmsg component. 

But again, you have to manually match up numbers by hand, that's prone
to get messy very quickly.

> > > + * Text: "%d is not a valid number of XPRAM devices"
> > > + * Severity: Error
> > > + * Parameter:
> > > + *   @1: number of partitions
> > > + * Description:
> > > + * The number of XPRAM partitions specified for the 'devs' module parameter
> > > + * or with the 'xpram.parts' kernel parameter must be an integer in the
> > > + * range 1 to 32. The XPRAM device driver created a maximum of 32 partitions
> > > + * that are probably not configured as intended.
> > > + * User action:
> > > + * If the XPRAM device driver has been compiled as a separate module,
> > > + * unload the module and load it again with a correct value for the
> > > + * 'devs' module parameter. If the XPRAM device driver has been compiled
> > > + * into the kernel, correct the 'xpram.parts' parameter in the kernel
> > > + * parameter line and restart Linux.
> > > + */
> > 
> > Any way to put this stuff in the .c file itself?  It's hard enough
> > getting people to update Documentation/ABI/, knowing to go modify
> > something else in the Documentation directory is going to be _very_
> > difficult.
> 
> Yes, already implemented. Just put the comment anywhere in the .c file
> where the message is printed. The Documentation/kmsg directory is just
> an additional option.

Why not have your example show this?

> > > +#define KMSG_COMPONENT "xpram"
> > 
> > Can't you just use KBUILD_MODULE_NAME instead?  That makes it one less
> > thing you have to define in the code (and forget about when moving files
> > around or cut-and-pasting).
> 
> Two reason why we don't want to use KBUILD_MODULE_NAME:
> 1) the message tag (message component + message id) should never change,
> if you change the code structure the module name might change as well.

Um, isn't that the point?  If the code structure changes, then perhaps
the message also should change?  If not, it's trival to adjust.

> 2) we want to be able to use the same kmsg component in multiple .c
> files. 

Why would this matter?  It's just a "tag", who cares about the actual
name?

thanks,

greg k-h
