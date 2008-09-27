Return-Path: <linux-kernel-owner+w=401wt.eu-S1754205AbYI0XLh@vger.kernel.org>
Subject: Re: [patch 2/6] kmsg: tagged device messages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080926175745.GD700@suse.de>
References: <20080925162827.818261893@de.ibm.com>
	 <20080925163019.750494793@de.ibm.com>  <20080926175745.GD700@suse.de>
Content-Type: text/plain
Date: Sun, 28 Sep 2008 01:11:44 +0200
Message-Id: <1222557104.14610.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Kay Sievers <kay.sievers@vrfy.org>, Joe Perches <joe@perches.com>, Tim Hockin <thockin@hockin.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>, Jan Blunck <jblunck@suse.de>, Rick Troth <rmt@casita.net>, Utz Bacher <utz.bacher@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2008-09-26 at 10:57 -0700, Greg KH wrote:
> Nice, thanks for reworking this.  Feel free to add:
>         Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> here.

Good, I will do that.

> Note that you will get some merge errors with -next in device.h due to
> the dynamic debug printk work that is in my tree and in -next as well.
> But it should be simple to resolve.

Is the dynamic debug printk work going upstream with the next merge
window? If yes then I'll wait until it hit Linus tree and update my
patch.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
