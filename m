Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 24 Mar 2016 17:38:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/4] s390: let exit_thread_runtime_instr accept a task
Message-ID: <20160324163842.GB4129@osiris>
References: <1458824240-29606-1-git-send-email-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458824240-29606-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 24, 2016 at 01:57:17PM +0100, Jiri Slaby wrote:
> We need to call exit_thread from copy_process in a fail path. Since
> exit_thread on s390 calls exit_thread_runtime_instr, make it accept
> task_struct as a parameter now.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/s390/include/asm/runtime_instr.h | 2 +-
>  arch/s390/kernel/process.c            | 2 +-
>  arch/s390/kernel/runtime_instr.c      | 6 ++----
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/runtime_instr.h b/arch/s390/include/asm/runtime_instr.h
> index 402ad6df4897..6ecfadccd5f5 100644
> --- a/arch/s390/include/asm/runtime_instr.h
> +++ b/arch/s390/include/asm/runtime_instr.h
> @@ -85,6 +85,6 @@ static inline void restore_ri_cb(struct runtime_instr_cb *cb_next,
>  		load_runtime_instr_cb(&runtime_instr_empty_cb);
>  }
>  
> -void exit_thread_runtime_instr(void);
> +void exit_thread_runtime_instr(struct task_struct *task);
>  
>  #endif /* _RUNTIME_INSTR_H */
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 2bba7df4ac51..7fabc985a7dd 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -72,7 +72,7 @@ extern void kernel_thread_starter(void);
>   */
>  void exit_thread(void)
>  {
> -	exit_thread_runtime_instr();
> +	exit_thread_runtime_instr(current);
>  }
>  
>  void flush_thread(void)
> diff --git a/arch/s390/kernel/runtime_instr.c b/arch/s390/kernel/runtime_instr.c
> index fffa0e5462af..f76973888479 100644
> --- a/arch/s390/kernel/runtime_instr.c
> +++ b/arch/s390/kernel/runtime_instr.c
> @@ -43,10 +43,8 @@ static void init_runtime_instr_cb(struct runtime_instr_cb *cb)
>  	cb->valid = 1;
>  }
>  
> -void exit_thread_runtime_instr(void)
> +void exit_thread_runtime_instr(struct task_struct *task)
>  {
> -	struct task_struct *task = current;
> -
>  	if (!task->thread.ri_cb)
>  		return;

Calling exit_thread_runtime_instr() with anything else than current doesn't
make sense. However exactly that happens with one of your later patches.

Even though for your specific use case it will work, I'd prefer if you
would add something like

	if (task != current)
		return;

To make it a bit more obvious (within this patch or later - I don't care ;)
