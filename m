Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 15:45:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129144522.GE3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
 <20160129085447.GA3896@osiris>
 <20160129125749.GD3896@osiris>
 <20160129085936.09458371@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160129085936.09458371@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pratyush Anand <panand@redhat.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 29, 2016 at 08:59:36AM -0500, Steven Rostedt wrote:
> On Fri, 29 Jan 2016 13:57:49 +0100
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > Surpringly it wasn't one of my own patches which broke the stack tracer on
> > s390, but one from Steven:
> > 
> > 72ac426a5bb0 ("tracing: Clean up stack tracing and fix fentry updates")
> > 
> > Now I only need to figure out why :)
> 
> Try this one?
> 
>   7717c6be699975f6733d278b13b7c4295d73caf6
>   tracing: Fix stacktrace skip depth in trace_buffer_unlock_commit_regs()
> 
> Or at the very least, merge with Linus's latest and see if something
> else doesn't fix it.

No, that doesn't fix it (current Linus' master):

# uname -a
Linux p2345007 4.5.0-rc1-00032-g26cd83670f2f #26 SMP Fri Jan 29 15:39:47 CET 2016 s390x s390x s390x GNU/Linux

# cat stack_max_size 
4496

# cat stack_trace
        Depth    Size   Location    (0 entries)
        -----    ----   --------
