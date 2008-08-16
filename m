Return-Path: <linux-kernel-owner+w=401wt.eu-S1753278AbYHPSG6@vger.kernel.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <b3ece790808151003o24e518a1ra217010f6658c2c6@mail.gmail.com>
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
	 <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
	 <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de>
	 <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
	 <20080815160355.GD23720@suse.de>
	 <b3ece790808151003o24e518a1ra217010f6658c2c6@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 16 Aug 2008 20:06:30 +0200
Message-Id: <1218909990.6037.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <gregkh@suse.de>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Jochen =?ISO-8859-1?Q?Vo=DF?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2008-08-15 at 10:03 -0700, Tim Hockin wrote:
> On Fri, Aug 15, 2008 at 9:03 AM, Greg KH <gregkh@suse.de> wrote:
> >> I'd like to be able to report something like an OOM kill in (roughly)
> >> the same way as an ATA error, and I want (though could be talked out
> >> of) a way to tell these "events" (for lack of a better word) apart
> >> from plain-old-printk()s.
> >
> > That's great, then create something that can handle both!  Don't throw
> > away some wonderful information that way over half the kernel has access
> > to just because the minority doesn't.  That would mean that we would
> > loose information in those drivers overall.
> 
> Sorry, I never meant to imply that dev_printk() was to be ignored, my
> examples was meant to be trivial to demonstrate :)  dev_printk() is
> good.  We should keep it :)

The invention of dev_printk was a good thing. It adds structure to the
messages if it is about a device. Before we had a simple printk that did
or did not include information about the device driver and the device
name. dev_printk makes sure that this information is always added.
BUT, what dev_printk does not do is to make sure that the message can be
uniquely identified so that the description of the message can be found
in the message catalog. Our approach is to combine the driver name and a
simple index into a message tag. The original dev_printk remains almost
unchanged. A typical hunk in the code looks like this:

@@ -24,8 +27,8 @@ static int zfcp_ccw_probe(struct ccw_dev

        down(&zfcp_data.config_sema);
        if (zfcp_adapter_enqueue(ccw_device)) {
-               dev_err(&ccw_device->dev,
-                       "Setup of data structures failed.\n");
+               kmsg_dev_err(73, &ccw_device->dev,
+                            "Setup of data structures failed.\n");
                retval = -EINVAL;
        }
        up(&zfcp_data.config_sema);

The kmsg_dev_printk still has almost the same structure, only the
message id is added. There is one real difference though:
the driver name is specified with KMSG_COMPONENT and not via
dev_driver_string(dev). We do that so that the kmsg-doc script can
actually find the driver name. The dev_driver_string(dev) is dynamic and
a static tool has a hard time to find the actual driver string.  

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
