Return-Path: <linux-kernel-owner+w=401wt.eu-S1760175AbXFGH1p@vger.kernel.org>
Date: Thu, 7 Jun 2007 09:27:20 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070607072720.GA19976@elte.hu>
References: <1181165656.7133.23.camel@dix> <20070606230641.GA11592@elte.hu> <46674EA9.9090601@de.ibm.com> <1181198376.7348.202.camel@twins> <4667ACC3.60009@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4667ACC3.60009@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Martin Peschke <mp3@de.ibm.com> wrote:

> Admittedly this gives you the top five contention points, [...]

if the infrastructure your are advocating does not allow us to keep the 
existing output then it's simply not flexible enough. Why on earth are 
you even arguing about this? A "cleanup" should not change the output, 
simple as that. Do a patch that has the _same_ output and then we can 
see whether it's a good patch. You made the same mistake with your 
/proc/timer_stats cleanups. I dont like NACK-ing patches but you seem to 
be missing the basic precondition of cleanups: no functional effect to 
the code, and certainly no change in output.

	Ingo
