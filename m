Return-Path: <linux-kernel-owner+w=401wt.eu-S1754854AbYHRRvo@vger.kernel.org>
Message-ID: <b3ece790808181051v1dc1ff81yc5b46348d59ab491@mail.gmail.com>
Date: Mon, 18 Aug 2008 10:51:34 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <20080818092317.GD6635@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
	 <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
	 <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de>
	 <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
	 <20080815112117.GP10078@bolzano.suse.de>
	 <b3ece790808150839i54fde73uf068cb04d4027156@mail.gmail.com>
	 <20080818092317.GD6635@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jan Blunck <jblunck@suse.de>, Greg KH <gregkh@suse.de>, Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Sam Ravnborg <sam@ravnborg.org>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 18, 2008 at 2:23 AM, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
>> > I don't think that he wants to unify all the printk's in the system. I don't
>> > think that reporting all errors "in the same way as an ATA error" makes any
>> > sense. That would just lead to very stupid and unnatural messages for all
>> > errors that are not like "ATA errors". Annotation of existing errors is a much
>> > more flexible and feasible solution to that problem.
>>
>> Please don't misinterpret.  I don't want to make other errors parse
>> like an ATA error, I want to make the plumbing be parallel.  I want
>> one umbrella mechanism for reporting things that are more important
>> than just-another-printk().
>>
>> Because frankly, "parse dmesg" is a pretty crappy way to have to
>> monitor your system for failures, and I am tired of explaining to
>> people why we still do that.
>
> "parse dmesg" does not work for monitoring your system for failures;
> dmesg buffer can overflow.
>
> If something fails, you should get errno returned for userspace, and
> that's where you should be doing the monitoring.
>
> So... what parts don't return enough information to userspace so that
> you need to parse dmesg? Lets fix them.

If I get a DMA timeout on my disk, I want to know about it.  If I get
an OOM kill, I want to know about it.  Etc.

I *don't* want every application to participate in system monitoring,
and that's what it seems you're suggesting.  I want a monitoring
daemon which is notified of important system events.  We like to
report these things in various ways, including squirting them out onto
the network.

I *don't* want to run regexes against dmesg or /var/log/messages or
/var/log/kernel every N seconds, that's just a gross hack.  I really
want first-class notifications of significant events.  I don't mind
having to do parsing of events - as I said before, they can even be
loosely structured strings.  They just need to be more important than
a plain old printk(), and preferably come through a different channel.

I understand that many users will not want this level of monitoring,
and that's why it should be flexible enough to devolve into printk().
But we have thousands of systems.  I need a better view of what is
happening.

Tim
