Return-Path: <linux-kernel-owner+w=401wt.eu-S1755841AbYHGIju@vger.kernel.org>
Subject: Re: [patch 3/3] kmsg: convert xpram messages to kmsg api.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080806201118.GB30086@suse.de>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171157.550296160@de.ibm.com> <20080730194308.GB22441@suse.de>
	 <1217493222.8555.8.camel@localhost> <20080805223429.GB6552@suse.de>
	 <1218012373.20769.22.camel@localhost>  <20080806201118.GB30086@suse.de>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:39:13 +0200
Message-Id: <1218098353.1033.19.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-08-06 at 13:11 -0700, Greg KH wrote:
> > >From the patch description of the kernel message catalog script:
> > 
> > The kmsg check is invoked with "make D=1" and reads the source files for
> > all objects that are built by the current configuration and searches for
> > matching kmsg descriptions for the kmsg messages in the source which
> > have a messages id > 0. If a message description can not be found the
> > script prints a blueprint and causes a make error.
> 
> Ok, but you don't describe messages with "0" in them :)

I'll add the creation of a howto to my to-do list that describes how to
work with kmsg.

> > > > > > +#define KMSG_COMPONENT "xpram"
> > > > > 
> > > > > Can't you just use KBUILD_MODULE_NAME instead?  That makes it one less
> > > > > thing you have to define in the code (and forget about when moving files
> > > > > around or cut-and-pasting).
> > > > 
> > > > Two reason why we don't want to use KBUILD_MODULE_NAME:
> > > > 1) the message tag (message component + message id) should never change,
> > > > if you change the code structure the module name might change as well.
> > > 
> > > Um, isn't that the point?  If the code structure changes, then perhaps
> > > the message also should change?  If not, it's trival to adjust.
> > 
> > NO! The message nor the message tag should change if the message
> > semantically still reports the same thing. If the meaning of the message
> > changes then change the message AND the message tag.
> 
> Why can't the message reporting change?  What's the reluctance for
> change here for something that did happen to move to a different file?
> It shouldn't matter _at all_ as you are only looking at the
> tags/messages for a specific kernel version to ensure they match up.
> Any future kernel version might have different ones.
>
> It's not like once you write a message/tag it will stay that way fixed
> for all time, that's just not going to fly with the way the Linux kernel
> is developed.

The message tag should uniquely identify the message so that the
translation projects have something to work with. If we keep changing
the message tag with each kernel release that will create a huge effort
to keep track of the messages.

> > > > 2) we want to be able to use the same kmsg component in multiple .c
> > > > files. 
> > > 
> > > Why would this matter?  It's just a "tag", who cares about the actual
> > > name?
> > 
> > The actual name is not really important, but if the name is choosen
> > wisely it does convey information. Guess what "dasd.17" tells you
> > something about the dasd driver, "zfcp.42" about the zfcp driver and so
> > on. The code structure should not dictate how the message tag is
> > created.
> 
> The message tag should not dictate anything except how to look it up
> somehow.  So it doesn't matter if the name changes, as long as the
> ability to get the real information is still there.
> 
> So the kernel could change the tags every other release and there would
> be no problem.

I think the unique message ids are very important. If we change them all
the time this would severly limit the value of the kernel message
catalog.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
