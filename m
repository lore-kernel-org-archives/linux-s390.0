Return-Path: <linux-kernel-owner+w=401wt.eu-S1760115AbYHOPkE@vger.kernel.org>
Message-ID: <b3ece790808150839i54fde73uf068cb04d4027156@mail.gmail.com>
Date: Fri, 15 Aug 2008 08:39:52 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <20080815112117.GP10078@bolzano.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <20080730171156.824640459@de.ibm.com>
	 <b3ece790808121735t21b4a629iaf6a968b30332d74@mail.gmail.com>
	 <1218733457.2651.11.camel@localhost>
	 <b3ece790808141150s3770531bsc88ec387e0f840d3@mail.gmail.com>
	 <1218769739.24527.76.camel@localhost> <20080815034419.GB803@suse.de>
	 <b3ece790808142233y3150b4d1sfeaa0342dbac31a6@mail.gmail.com>
	 <20080815112117.GP10078@bolzano.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jan Blunck <jblunck@suse.de>
Cc: Greg KH <gregkh@suse.de>, Joe Perches <joe@perches.com>, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, lf_kernel_messages@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Michael Holzheu <holzheu@de.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Kunai Takashi <kunai@linux-foundation.jp>, Tim Bird <tim.bird@am.sony.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 15, 2008 at 4:21 AM, Jan Blunck <jblunck@suse.de> wrote:
> On Thu, Aug 14, Tim Hockin wrote:
>
>> On Thu, Aug 14, 2008 at 8:44 PM, Greg KH <gregkh@suse.de> wrote:
>> >
>> > What is wrong with what we have already agreed to standardise on here
>> > people?  dev_printk() for devices!  It uniquely shows the device, what
>> > driver is bound to it (if any), the bus id, and everything else.
>>
>> Part of the problem, imho, is the "if any" part.  But I am more than happy to
>> build on existing solutions.  All the world is not a dev, though.  I'd like to
>> be able to report something like an OOM kill in (roughly) the same way as an
>> ATA error, and I want (though could be talked out of) a way to tell these
>> "events" (for lack of a better word) apart from plain-old-printk()s.
>
> I don't think that he wants to unify all the printk's in the system. I don't
> think that reporting all errors "in the same way as an ATA error" makes any
> sense. That would just lead to very stupid and unnatural messages for all
> errors that are not like "ATA errors". Annotation of existing errors is a much
> more flexible and feasible solution to that problem.

Please don't misinterpret.  I don't want to make other errors parse
like an ATA error, I want to make the plumbing be parallel.  I want
one umbrella mechanism for reporting things that are more important
than just-another-printk().

Because frankly, "parse dmesg" is a pretty crappy way to have to
monitor your system for failures, and I am tired of explaining to
people why we still do that.

Tim
