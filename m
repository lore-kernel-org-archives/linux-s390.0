Return-Path: <linux-kernel-owner+w=401wt.eu-S1761267AbXFGI5i@vger.kernel.org>
Date: Thu, 7 Jun 2007 01:56:45 -0700
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070607085645.GA29054@gnuppy.monkey.org>
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <20070607044017.GA3828@gnuppy.monkey.org> <4667ADDA.2070202@de.ibm.com> <20070607073021.GA21139@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070607073021.GA21139@elte.hu>
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org, "Bill Huey (hui)" <billh@gnuppy.monkey.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 07, 2007 at 09:30:21AM +0200, Ingo Molnar wrote:
> * Martin Peschke <mp3@de.ibm.com> wrote:
> > Do mean I might submit this stuff for -rt?
> 
> Firstly, submit cleanup patches that _do not change the output_. If you 
> have any output changes, do it as a separate patch, ontop of the cleanup 
> patch. Mixing material changes and cleanups into a single patch is a 
> basic patch submission mistake that will only earn you NACKs.

Martin,

First of all I agree with Ingo in that this needs to be seperated from
the rest of the clean ups. However, I don't understand why all of this
is so heavy weight when the current measurements that Peter makes is
completely sufficient for any reasonable purpose I can think of at the
moment. What's this stuff with labels about ?

It's important to get the points of contention so that the greater
kernel group can fix this issues and not log statistics for the purpose
of logging it. The original purpose should not be ignore when working
on this stuff.

By the way, what's the purpose of all of this stuff ? like what do you
intend to do with it over the long haul ?

bill
