Return-Path: <pmladek@suse.com>
Date: Fri, 16 Dec 2016 15:17:35 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 02/15] x86/entry: define _TIF_ALLWORK_MASK flags
 explicitly
Message-ID: <20161216141735.GD393@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-12-08 12:08:27, Josh Poimboeuf wrote:
> The _TIF_ALLWORK_MASK macro automatically includes the least-significant
> 16 bits of the thread_info flags, which is less than obvious and tends
> to create confusion and surprises when reading or modifying the code.
> 
> Define the flags explicitly.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/thread_info.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index ad6f5eb0..1fe6043 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -73,9 +73,6 @@ struct thread_info {
>   * thread information flags
>   * - these are process state flags that various assembly files
>   *   may need to access
> - * - pending work-to-be-done flags are in LSW

Yup, this is not true because also some flags from the most
significant bits are in the _TIF_ALLWORK_MASK.

> - * - other flags in MSW
> - * Warning: layout of LSW is hardcoded in entry.S
>   */
>  #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
> @@ -133,8 +130,10 @@ struct thread_info {
>  
>  /* work to do on any return to user space */
>  #define _TIF_ALLWORK_MASK						\
> -	((0x0000FFFF & ~_TIF_SECCOMP) | _TIF_SYSCALL_TRACEPOINT |	\
> -	_TIF_NOHZ)
> +	(_TIF_SYSCALL_TRACE | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING |	\
> +	 _TIF_SINGLESTEP | _TIF_NEED_RESCHED | _TIF_SYSCALL_EMU |	\
> +	 _TIF_SYSCALL_AUDIT | _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE |	\
> +	 _TIF_SYSCALL_TRACEPOINT | _TIF_NOHZ)

All flags are sorted by the number except for
_TIF_SINGLESTEP and _TIF_NEED_RESCHED  ;-)

The patch does not change the existing behavior. The same
existing flags are listed.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
