Return-Path: <linux-kernel-owner+w=401wt.eu-S1760205AbYHNSu3@vger.kernel.org>
Message-ID: <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
Date: Thu, 14 Aug 2008 11:50:12 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <1218733457.2651.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, Joe Perches <joe@perches.com>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 14, 2008 at 10:04 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:

>> I don't care for the magic file-global KMSG_COMPONENT. It just feels
>> wrong. In most cases, I want the prefix to be hierarchical. For example,
>> rather than "tg3" I want "net.tg3" or "netdev:tg3" or something.
>
> But what is the alternative to the #define to specify the base name of
> the message tag? KBUILD_MODNAME has been proposed but I don't think this
> is a good idea since I want the message tags to be independent of the
> code structure.

We had talked internally about something like this:

  globally:

    // this is the actual implementation
    extern void send_kmsg(int level, const char *fmt, ...);

    // this is a convenience wrapper, maybe not needed as they get combinatoric
    #define kmsg_err(fmt, ...) \
    	send_kmsg(KERN_ERROR, fmt, ##__VA_ARGS__)

  inside a subsystem-specific header:

    #define mysubsys_kmsg_err(fmt, ...) \
    	kmsg_err("mysubsys:" fmt "\n", ##__VA_ARGS__)

  inside each subsystem-driver:

    #define mydriver_kmsg_err(fmt, ...) \
    	mysubsys_kmsg_err("mydriver:" fmt, ##__VA_ARGS__)

  then the driver just calls:

    mydriver_kmsg_err("something happened");

  and you get, at the bottom:

    printk(KERN_ERROR "mysubsy:mydriver:something happened\n");

I'm not sure how your ID number fits in there, propbably

    printk(KERN_ERROR "mysubsy:mydriver.%d something happened\n", id);

That way, the hierarchy is defined by the meaningful hierarchy of
subsystems and busses and drivers.  Subsystems which have device structs
can add them into the mix (netdev, ATA, etc).  The core infrastructure
stays small, while providing driver and subsys maintainers the flexibility
to define their own event hierarchies.

>> Further, We want to make a clearer denotation between "just another
>> printk()" and these things, which are really "important events". Maybe a
>> global prefix that makes it easy to seperate them out? Or a parallel
>> "event" interface that logs to printk() and a netlink socket?
>
> Well the kmsg macros distinguish between id==0 and id>0 messages. For a
> id==0 message there is no documentation required and the kmsg prefix
> will be just the KMSG_COMPONENT. You could consider that to be "just
> another printk". For id>0 the kmsg macros will create the tuppel
> KMSG_COMPONENT.ID so you already can separate "normal" and "important"
> prinkts.

That works, I suppose.  I'd still advocate for a netlink-style conduit
(maybe with buffering?) for "important event" kmsgs, separate from plain
old printk.

I'd also advocate that maybe we should go a bit further with the
structure, by providing a soft-structured set of key-value pairs.  I'm not
100% on the details, but something like:

    printk(KERN_ERROR
    	"mysubsy:mydriver.%d something happened -- pid=%d status=0x%04x\n",
    	id, pid, status);

Where everything after "--" (or some other delimiter) is a key=value.

>> What I want to see is the elevation of these call-sites from "it's just a
>> printk()" to "it's a report-worthy event and part of our user<->kernel
>> API".  I want people to add them when it's appropriate and then not change
>> the strings later.  I don't care if, in the end, they are structured
>> strings.  I do care if I have to run dozens of regexes against thousands
>> of log-lines on thousands of systems.

> Yes, and this has already happened with the s390 device driver messages.
> With the conversion to kmsg our developers removed a lot of crud from
> the code, this alone makes it worthwhile.

Do you see *every* printk() becoming a kmsg?  Just printk() in drivers?
Or just some hand-chosen printk()s ?

Tim
