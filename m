Return-Path: <linux-kernel-owner+w=401wt.eu-S1753934AbXFGGjs@vger.kernel.org>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <46674EA9.9090601@de.ibm.com>
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu>
	 <46674EA9.9090601@de.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 08:39:36 +0200
Message-Id: <1181198376.7348.202.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2007-06-07 at 02:17 +0200, Martin Peschke wrote:
> Ingo Molnar wrote:
> > * Martin Peschke <mp3@de.ibm.com> wrote:
> > 
> >> The output has changed from a terribly wide table to an enormously 
> >> long list (just the generic way the statistics code prints data). 
> > 
> > Sigh, why dont you _ask_ before doing such stuff?
> 
> A nice diffstat is always worth a try, isn't it?
> And I see other reasons for code sharing.
> Ah, and doing it has been actually quite simple once I had figured out
> what the original code does. :-)
> 
> > It is a terribly wide table because that makes it easily greppable
> 
> If one looks for contentions of "xtime_lock" within my enormously long list,
> they could issue:
> 
>     grep -e "xtime_lock contentions" data
> 
> and get
> 
>     xtime_lock contentions 0x17bd2 3327 account_ticks+0x96/0x184
>     xtime_lock contentions other 0
> 
> for example.
> 
> So how is this worse?

How will you find the 5 most contended locks with 1 grep?

It used to be:
  grep ":" /proc/lock_stat | head -n 5

lock stat is more about finding who is bad than examining a particular
lock (of course in the process of fixing that lock, that does become
interesting).

Nor was it _that_ wide, it easily fit into an xterm, even on my laptop.
