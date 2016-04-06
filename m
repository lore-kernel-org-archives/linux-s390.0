From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
Date: Wed, 6 Apr 2016 20:31:01 +0200
Message-ID: <20160406183101.GW3448@twins.programming.kicks-ass.net>
References: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
 <1459508695-14915-11-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459508695-14915-11-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 01, 2016 at 01:04:54PM +0200, Michal Hocko wrote:
> diff --git a/arch/x86/lib/rwsem.S b/arch/x86/lib/rwsem.S
> index 40027db99140..d1a1397e1fb3 100644
> --- a/arch/x86/lib/rwsem.S
> +++ b/arch/x86/lib/rwsem.S
> @@ -101,6 +101,14 @@ ENTRY(call_rwsem_down_write_failed)
>  	ret
>  ENDPROC(call_rwsem_down_write_failed)
>  
> +ENTRY(call_rwsem_down_write_failed_killable)
> +	save_common_regs
> +	movq %rax,%rdi
> +	call rwsem_down_write_failed_killable
> +	restore_common_regs
> +	ret
> +ENDPROC(call_rwsem_down_write_failed_killable)
> +

I had a conflict here and made that:

--- a/arch/x86/lib/rwsem.S
+++ b/arch/x86/lib/rwsem.S
@@ -106,6 +106,16 @@ ENTRY(call_rwsem_down_write_failed)
 	ret
 ENDPROC(call_rwsem_down_write_failed)
 
+ENTRY(call_rwsem_down_write_failed_killable)
+	FRAME_BEGIN
+	save_common_regs
+	movq %rax,%rdi
+	call rwsem_down_write_failed_killable
+	restore_common_regs
+	FRAME_END
+	ret
+ENDPROC(call_rwsem_down_write_failed_killable)
+
 ENTRY(call_rwsem_wake)
 	FRAME_BEGIN
 	/* do nothing if still outstanding active readers */
