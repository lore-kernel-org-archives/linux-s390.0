Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 13:57:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129125749.GD3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
 <20160129085447.GA3896@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160129085447.GA3896@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pratyush Anand <panand@redhat.com>, schwidefsky@de.ibm.com, rostedt@goodmis.org, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 29, 2016 at 09:54:47AM +0100, Heiko Carstens wrote:
> On Fri, Jan 29, 2016 at 10:50:28AM +0530, Pratyush Anand wrote:
> > Implement save_stack_trace_regs, so that stacktrace of a kprobe events can
> > be obtained.
> > 
> > Without this we see following warning:
> > "save_stack_trace_regs() not implemented yet."
> > when we execute:
> > echo stacktrace > /sys/kernel/debug/tracing/trace_options
> > echo "p kfree" >> /sys/kernel/debug/tracing/kprobe_events
> > echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> > 
> > Reported-by: Chunyu Hu <chuhu@redhat.com>
> > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > ---
> 
> Thanks. I just figured out that the ftrace stack tracer doesn't work at all
> anymore on s390.  I will apply your patch after I fixed that. ;)

Surpringly it wasn't one of my own patches which broke the stack tracer on
s390, but one from Steven:

72ac426a5bb0 ("tracing: Clean up stack tracing and fix fentry updates")

Now I only need to figure out why :)
