Return-Path: <linux-kernel-owner+w=401wt.eu-S1756132AbYHNPkq@vger.kernel.org>
Message-ID: <b3ece790808140840t214ccbq6db63c33b4ebe963@mail.gmail.com>
Date: Thu, 14 Aug 2008 08:40:06 -0700
From: "Tim Hockin" <thockin@hockin.org>
Subject: Re: [patch 1/3] kmsg: Kernel message catalog macros.
In-Reply-To: <200808141153.03269.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080730165656.118280544@de.ibm.com>
	 <200808131433.02966.rusty@rustcorp.com.au>
	 <b3ece790808130004p4763b11fveaf4c8380c7c86f7@mail.gmail.com>
	 <200808141153.03269.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>, lf_kernel_messages@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@suse.de>, =?UTF-8?Q?Jochen_Vo=C3=9F?= <jochen.voss@googlemail.com>, Sam Ravnborg <sam@ravnborg.org>, Kunai Takashi <kunai@linux-foundation.jp>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Gerrit Huizenga <gh@us.ibm.com>, Michael Holzheu <holzheu@de.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Tim Bird <tim.bird@am.sony.com>, Tim Hockin <thockin@hockin.org>
List-ID: <linux-s390.vger.kernel.org>

On Aug 13, 2008 9:15 PM, "Rusty Russell" <rusty@rustcorp.com.au> wrote:

> On Wednesday 13 August 2008 17:04:11 Tim Hockin wrote:
>> But there are a number of places that have ...Well, if they're to be the
>> same messages under the manual-numbering scheme,
>
> someone has to verify that they are really the same anyway.  Not much more
> work to simply fix them in that case, is it?
>
> If it improves normal kernel messages, then everyone wins.

Oh, I agree with that.  I personally don't care much for the msg ID part of
this patch (I mean I don't care either way).  It might be nice to have man
pages, but I just see it becoming out of sync, duplicate numbers, etc.

What I want to see is the elevation of these call-sites from "it's just a
printk()" to "it's a report-worthy event and part of our user<->kernel API".  I
want people to add them when it's appropriate and then not change the strings
later.  I don't care if, in the end, they are structured strings.  I do care if
I have to run dozens of regexes against thousands of log-lines on thousands of
systems.

:)

Tim
