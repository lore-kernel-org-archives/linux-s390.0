Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 07:29:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
Message-ID: <20160126062951.GA17107@ravnborg.org>
References: <cover.1453759363.git.luto@kernel.org>
 <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160126062951.XhLnsGJS5BqLEc8wccL5qIyisM74WnHMUUCyWC1B7R8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 25, 2016 at 02:24:16PM -0800, Andy Lutomirski wrote:
> On sparc64 compat-enabled kernels, any task can make 32-bit and
> 64-bit syscalls.  is_compat_task returns true in 32-bit tasks, which
> does not necessarily imply that the current syscall is 32-bit.
> 
> Provide an in_compat_syscall implementation that checks whether the
> current syscall is compat.
> 
> As far as I know, sparc is the only architecture on which
> is_compat_task checks the compat status of the task and on which the
> compat status of a syscall can differ from the compat status of the
> task.  On x86, is_compat_task checks the syscall type, not the task
> type.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/sparc/include/asm/compat.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
> index 830502fe62b4..5467404857fc 100644
> --- a/arch/sparc/include/asm/compat.h
> +++ b/arch/sparc/include/asm/compat.h
> @@ -307,4 +307,10 @@ static inline int is_compat_task(void)
>  	return test_thread_flag(TIF_32BIT);
>  }
>  
> +static inline bool in_compat_syscall(void)
> +{
> +	return pt_regs_trap_type(current_pt_regs()) == 0x110;
Could you please add a comment about where 0x110 comes from.
I at least failed to track this down.

	Sam
