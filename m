Return-Path: <bobby.prani@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20141229110324.50f1339b@mschwide>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
 <20141229110324.50f1339b@mschwide>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 29 Dec 2014 23:32:10 -0500
Message-ID: <CAJhHMCDan+qaaZjVUucA-sUS8A3vSTYuVHg8XQv4rsHXxAzKLw@mail.gmail.com>
Subject: Re: [PATCH] srcu: Isolate srcu sections using CONFIG_SRCU
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "open list:S390" <linux-s390@vger.kernel.org>, Lai Jiangshan <laijs@cn.fujitsu.com>, Tiejun Chen <tiejun.chen@windriver.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Scott Wood <scottwood@freescale.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Andy Fleming <afleming@freescale.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "supporter:S390" <linux390@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Walter <dwalter@google.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 29, 2014 at 5:03 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Sat, 27 Dec 2014 12:17:43 -0500
> Pranith Kumar <bobby.prani@gmail.com> wrote:
>
>> @@ -65,10 +65,13 @@
>>  #include <asm/kexec.h>
>>  #include <asm/mmu_context.h>
>>  #include <asm/code-patching.h>
>> -#include <asm/kvm_ppc.h>
>>  #include <asm/hugetlb.h>
>>  #include <asm/epapr_hcalls.h>
>>
>> +#if IS_ENABLED(CONFIG_KVM)
>> +#include <asm/kvm_ppc.h>
>> +#endif
>> +
>>  #ifdef DEBUG
>>  #define DBG(fmt...) udbg_printf(fmt)
>>  #else
>
> I always cringe when I see an include protected by an #ifdef.
> Is this really necessary? All that is done in asm-offsets.c is
> to calculate offsets, the code where the two offsets in question
> are used (entry64.S) does have the #ifdef for CONFIG_KVM.

I agree that this is not the ideal way to do this. But, it has been
the way things were already being done. If you see
arch/powerpc/kernel/asm-offsets.c, there are quite some includes which
are within ifdefs.

I've considered other alternatives (though not in-depth) and found
that they will require quite some refactoring. One simple idea is to
move this #ifdef to within kvm_ppc.h. That should make the inclusion
of this file a no-op in all the places where this is being included
without KVM being enabled. But I am not 100% sure of that approach.

Any suggestions are welcome.

-- 
Pranith
