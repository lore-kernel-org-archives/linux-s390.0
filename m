Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 22 Nov 2018 07:43:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [for-next][PATCH 11/18] s390/function_graph: Simplify with
 function_graph_entry()
In-Reply-To: <20181122003332.940703297@goodmis.org>
References: <20181122002801.501220343@goodmis.org>
        <20181122003332.940703297@goodmis.org>
MIME-Version: 1.0
Message-ID: <20181122074319.54d62bc3@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20181122064319.oTUMAeQbWkSobVCb4nLgCsxmALyZOt5SgoTZjFl_nSs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-s390@vger.kernel.org, stable@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 21 Nov 2018 19:28:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The function_graph_entry() function does the work of calling the function
> graph hook function and the management of the shadow stack, simplifying the
> work done in the architecture dependent prepare_ftrace_return().
> 
> Have s390 use the new code, and remove the shadow stack management as well as
> having to set up the trace structure.
> 
> This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> is used.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Julian Wiedmann <jwi@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: stable@kernel.org
> Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

A quick test showed that the patch series works fine on s390.
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

> ---
>  arch/s390/kernel/ftrace.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> index 84be7f02d0c2..39b13d71a8fe 100644
> --- a/arch/s390/kernel/ftrace.c
> +++ b/arch/s390/kernel/ftrace.c
> @@ -203,22 +203,13 @@ device_initcall(ftrace_plt_init);
>   */
>  unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
>  {
> -	struct ftrace_graph_ent trace;
> -
>  	if (unlikely(ftrace_graph_is_dead()))
>  		goto out;
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		goto out;
>  	ip -= MCOUNT_INSN_SIZE;
> -	trace.func = ip;
> -	trace.depth = current->curr_ret_stack + 1;
> -	/* Only trace if the calling function expects to. */
> -	if (!ftrace_graph_entry(&trace))
> -		goto out;
> -	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
> -				     NULL) == -EBUSY)
> -		goto out;
> -	parent = (unsigned long) return_to_handler;
> +	if (!function_graph_enter(parent, ip, 0, NULL))
> +		parent = (unsigned long) return_to_handler;
>  out:
>  	return parent;
>  }


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
