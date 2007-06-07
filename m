Return-Path: <linux-kernel-owner+w=401wt.eu-S935682AbXFGEkx@vger.kernel.org>
Date: Wed, 6 Jun 2007 21:40:17 -0700
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070607044017.GA3828@gnuppy.monkey.org>
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46674EA9.9090601@de.ibm.com>
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org, "Bill Huey (hui)" <billh@gnuppy.monkey.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 07, 2007 at 02:17:45AM +0200, Martin Peschke wrote:
> Ingo Molnar wrote:
> >, quite some work went into it - NACK :-(
> 
> Considering the amount of code.. ;-)    I am sorry.
> 
> But seriously, did you consider using some user space tool or script to
> format this stuff the way you like it - similar to the way the powertop tool
> reshuffles timer_stats data found in a proc file, for example?

When I was doing my stuff, I intended for it to be parsed by a script or
simple command line tools like sort/grep piped through less. I also though
it might be interesting to output the text into either a python or ruby
syntax collect so that it can go through a more extensive sorting using
those languages.

There are roughly about 400 locks in a normal kernel for a desktop. The
list is rather cumbersome anyways so, IMO, it really should be handled
by parsing tools, etc... There could be more properties attached to each
lock especially if you intend to get this to work on -rt which need more
things reported.

bill
