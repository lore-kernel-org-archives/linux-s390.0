Return-Path: <linux-kernel-owner+w=401wt.eu-S1758463AbXFGHak@vger.kernel.org>
Date: Thu, 7 Jun 2007 09:30:21 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070607073021.GA21139@elte.hu>
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <20070607044017.GA3828@gnuppy.monkey.org> <4667ADDA.2070202@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4667ADDA.2070202@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: "Bill Huey (hui)" <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Martin Peschke <mp3@de.ibm.com> wrote:

> Bill Huey (hui) wrote:
> > There are roughly about 400 locks in a normal kernel for a desktop. The
> > list is rather cumbersome anyways so, IMO, it really should be handled
> > by parsing tools, etc... There could be more properties attached to each
> > lock especially if you intend to get this to work on -rt which need more
> > things reported.
> 
> Adding stuff to an already wide table in a readable fashion is more 
> difficult than making a list longer.
> 
> Do mean I might submit this stuff for -rt?

Firstly, submit cleanup patches that _do not change the output_. If you 
have any output changes, do it as a separate patch, ontop of the cleanup 
patch. Mixing material changes and cleanups into a single patch is a 
basic patch submission mistake that will only earn you NACKs.

	Ingo
