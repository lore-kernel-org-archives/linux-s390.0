Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Tue, 27 Aug 2019 06:35:02 +0800
From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 05/11] ftrace: create memcache for hash entries
Message-ID: <20190826223501.ymj3g4ftrf5eqhzq@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-6-changbin.du@gmail.com>
 <20190826074437.GM2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074437.GM2369@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Changbin Du <changbin.du@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org

On Mon, Aug 26, 2019 at 09:44:37AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 25, 2019 at 09:23:24PM +0800, Changbin Du wrote:
> > When CONFIG_FTRACE_FUNC_PROTOTYPE is enabled, thousands of
> > ftrace_func_entry instances are created. So create a dedicated
> > memcache to enhance performance.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index a314f0768b2c..cfcb8dad93ea 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -94,6 +94,8 @@ struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
> >  /* What to set function_trace_op to */
> >  static struct ftrace_ops *set_function_trace_op;
> >  
> > +struct kmem_cache *hash_entry_cache;
> > +
> >  static bool ftrace_pids_enabled(struct ftrace_ops *ops)
> >  {
> >  	struct trace_array *tr;
> > @@ -1169,7 +1171,7 @@ static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip,
> >  {
> >  	struct ftrace_func_entry *entry;
> >  
> > -	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> > +	entry = kmem_cache_alloc(hash_entry_cache, GFP_KERNEL);
> >  	if (!entry)
> >  		return -ENOMEM;
> >  
> > @@ -6153,6 +6155,15 @@ void __init ftrace_init(void)
> >  	if (ret)
> >  		goto failed;
> >  
> > +	hash_entry_cache = kmem_cache_create("ftrace-hash",
> > +					     sizeof(struct ftrace_func_entry),
> > +					     sizeof(struct ftrace_func_entry),
> > +					     0, NULL);
> > +	if (!hash_entry_cache) {
> > +		pr_err("failed to create ftrace hash entry cache\n");
> > +		goto failed;
> > +	}
> 
> Wait what; you already have then in the binary image, now you're
> allocating extra memory for each of them?
>
No, here we only allocate ftrace hash entries. The prototype data is not copied.
The entry->priv points to prototype data in binary.

> Did you look at what ORC does? Is the binary search really not fast
> enough?
For ftrace, binary search is not enough. Just like the hash tables
(ftrace_graph_notrace_hash, ftrace_graph_hash) we already have which is used to
filter traced functions.


-- 
Cheers,
Changbin Du
