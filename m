Return-Path: <linux-kernel-owner+w=401wt.eu-S1753294AbYI1CUV@vger.kernel.org>
Date: Sat, 27 Sep 2008 19:04:19 -0700
From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 2/6] kmsg: tagged device messages.
Message-ID: <20080928020419.GA1257@suse.de>
References: <20080925162827.818261893@de.ibm.com> <20080925163019.750494793@de.ibm.com> <20080926175745.GD700@suse.de> <1222557104.14610.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1222557104.14610.3.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?iso-8859-1?B?Vm/f?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Sep 28, 2008 at 01:11:44AM +0200, Martin Schwidefsky wrote:
> On Fri, 2008-09-26 at 10:57 -0700, Greg KH wrote:
> > Note that you will get some merge errors with -next in device.h due to
> > the dynamic debug printk work that is in my tree and in -next as well.
> > But it should be simple to resolve.
> 
> Is the dynamic debug printk work going upstream with the next merge
> window? If yes then I'll wait until it hit Linus tree and update my
> patch.

Yes, it is slated for 2.6.28 inclusion and is in the -next and -mm
releases.

thanks,

greg k-h
