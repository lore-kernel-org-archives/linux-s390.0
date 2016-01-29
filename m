Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 08:59:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129085936.09458371@gandalf.local.home>
In-Reply-To: <20160129125749.GD3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
	<20160129085447.GA3896@osiris>
	<20160129125749.GD3896@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jan 2016 13:57:49 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> Surpringly it wasn't one of my own patches which broke the stack tracer on
> s390, but one from Steven:
> 
> 72ac426a5bb0 ("tracing: Clean up stack tracing and fix fentry updates")
> 
> Now I only need to figure out why :)

Try this one?

  7717c6be699975f6733d278b13b7c4295d73caf6
  tracing: Fix stacktrace skip depth in trace_buffer_unlock_commit_regs()

Or at the very least, merge with Linus's latest and see if something
else doesn't fix it.

-- Steve
