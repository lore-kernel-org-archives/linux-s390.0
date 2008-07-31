Return-Path: <linux-kernel-owner+w=401wt.eu-S1752274AbYGaIgo@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <3ae72650807301502h3e54e80yb405af7192048b89@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 10:36:26 +0200
Message-Id: <1217493386.8555.12.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2008-07-31 at 00:02 +0200, Kay Sievers wrote:
> On Wed, Jul 30, 2008 at 18:56, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> 
> > +#define kmsg_dev_alert(id, dev, format, arg...) \
> > +       printk(__KMSG_CHECK(ALERT, id) KMSG_COMPONENT \
> > +               ": %s: " format, (dev)->bus_id , ## arg)
> 
> Care to use dev_name(), bus_id will be removed soon.

Yes, will do. Thanks.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
