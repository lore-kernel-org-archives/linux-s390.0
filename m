Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 18:12:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129171249.GG3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
 <20160129085447.GA3896@osiris>
 <20160129125749.GD3896@osiris>
 <20160129085936.09458371@gandalf.local.home>
 <20160129144522.GE3896@osiris>
 <20160129102241.1b3c9c04@gandalf.local.home>
 <20160129164917.GF3896@osiris>
 <20160129115659.1b31f9c5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160129115659.1b31f9c5@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pratyush Anand <panand@redhat.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 29, 2016 at 11:56:59AM -0500, Steven Rostedt wrote:
> On Fri, 29 Jan 2016 17:49:18 +0100
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>  
> > Which looks much better. The stack tracer also works again!
> 
> Great! Although, it shouldn't have affected the stack tracing of kprobe
> events :-/

Yes, you're absolutely right. I mixed up my trees (one 4.4 based and one
Linus' master).

> Although the previous commit I showed would.

So, the save_stack_trace_regs() patch from Pratyush does work
out-of-the-box on Linus' master tree and the stack tracer only if your
additional patch is applied.

Sorry for the confusion!
