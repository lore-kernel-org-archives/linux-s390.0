Return-Path: <linux-kernel-owner+w=401wt.eu-S1757307AbXFGKVj@vger.kernel.org>
Date: Thu, 7 Jun 2007 12:21:23 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
Message-ID: <20070607102123.GB12155@elte.hu>
References: <1181165656.7133.23.camel@dix> <1181204221.7348.238.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181204221.7348.238.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> we have around 1400 locks in the kernel, this would give 414400 per cpu.
> 
> vs the old code:
> 
> 2048*(4*8) = 65536
> +
> 2048*(4*4*8 + 4*8) = 327680 per cpu
> 
> worst case
> 
> I'm not convinced 300 lines less code is worth that extra bloat.

agreed, this is not worth it. It would be acceptable if the statistics 
stuff was flexible enough to have the same footprint as the current 
lockstat data structures.

	Ingo
