Return-Path: <linux-kernel-owner+w=401wt.eu-S965822AbXFFXHU@vger.kernel.org>
Date: Thu, 7 Jun 2007 01:06:41 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070606230641.GA11592@elte.hu>
References: <1181165656.7133.23.camel@dix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181165656.7133.23.camel@dix>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Martin Peschke <mp3@de.ibm.com> wrote:

> The output has changed from a terribly wide table to an enormously 
> long list (just the generic way the statistics code prints data). 

Sigh, why dont you _ask_ before doing such stuff? It is a terribly wide 
table because that makes it easily greppable but still watchable in one 
chunk in a sufficiently zoomed out xterm. Please preserve this output 
format, quite some work went into it - NACK :-(

	Ingo
