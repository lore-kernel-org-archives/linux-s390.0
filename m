Return-Path: <schwidefsky@de.ibm.com>
Date: Mon, 29 Dec 2014 11:03:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] srcu: Isolate srcu sections using CONFIG_SRCU
Message-ID: <20141229110324.50f1339b@mschwide>
In-Reply-To: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:S390" <linux-s390@vger.kernel.org>, Lai Jiangshan <laijs@cn.fujitsu.com>, Tiejun Chen <tiejun.chen@windriver.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Andy Fleming <afleming@freescale.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "supporter:S390" <linux390@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "open
 list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Walter <dwalter@google.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 27 Dec 2014 12:17:43 -0500
Pranith Kumar <bobby.prani@gmail.com> wrote:

> @@ -65,10 +65,13 @@
>  #include <asm/kexec.h>
>  #include <asm/mmu_context.h>
>  #include <asm/code-patching.h>
> -#include <asm/kvm_ppc.h>
>  #include <asm/hugetlb.h>
>  #include <asm/epapr_hcalls.h>
> 
> +#if IS_ENABLED(CONFIG_KVM)
> +#include <asm/kvm_ppc.h>
> +#endif
> +
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
>  #else

I always cringe when I see an include protected by an #ifdef.
Is this really necessary? All that is done in asm-offsets.c is
to calculate offsets, the code where the two offsets in question
are used (entry64.S) does have the #ifdef for CONFIG_KVM.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
