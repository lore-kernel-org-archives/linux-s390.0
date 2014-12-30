Return-Path: <scottwood@freescale.com>
Message-ID: <1419968672.4961.4.camel@freescale.com>
Subject: Re: [PATCH] srcu: Isolate srcu sections using CONFIG_SRCU
From: Scott Wood <scottwood@freescale.com>
Date: Tue, 30 Dec 2014 13:44:32 -0600
In-Reply-To: <CAJhHMCDan+qaaZjVUucA-sUS8A3vSTYuVHg8XQv4rsHXxAzKLw@mail.gmail.com>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
 <20141229110324.50f1339b@mschwide>
 <CAJhHMCDan+qaaZjVUucA-sUS8A3vSTYuVHg8XQv4rsHXxAzKLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:S390" <linux-s390@vger.kernel.org>, Lai Jiangshan <laijs@cn.fujitsu.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Tiejun Chen <tiejun.chen@windriver.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Andy Fleming <afleming@freescale.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Walter <dwalter@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2014-12-29 at 23:32 -0500, Pranith Kumar wrote:
> On Mon, Dec 29, 2014 at 5:03 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Sat, 27 Dec 2014 12:17:43 -0500
> > Pranith Kumar <bobby.prani@gmail.com> wrote:
> >
> >> @@ -65,10 +65,13 @@
> >>  #include <asm/kexec.h>
> >>  #include <asm/mmu_context.h>
> >>  #include <asm/code-patching.h>
> >> -#include <asm/kvm_ppc.h>
> >>  #include <asm/hugetlb.h>
> >>  #include <asm/epapr_hcalls.h>
> >>
> >> +#if IS_ENABLED(CONFIG_KVM)
> >> +#include <asm/kvm_ppc.h>
> >> +#endif
> >> +
> >>  #ifdef DEBUG
> >>  #define DBG(fmt...) udbg_printf(fmt)
> >>  #else
> >
> > I always cringe when I see an include protected by an #ifdef.
> > Is this really necessary? All that is done in asm-offsets.c is
> > to calculate offsets, the code where the two offsets in question
> > are used (entry64.S) does have the #ifdef for CONFIG_KVM.
> 
> I agree that this is not the ideal way to do this. But, it has been
> the way things were already being done. If you see
> arch/powerpc/kernel/asm-offsets.c, there are quite some includes which
> are within ifdefs.

asm-offsets.c is unusual in that respect, and I think most of those
ifdefs could go away without breaking anything (head_booke.h is not a
normal header file, and kvm_book3s.h should just be removed as it will
be pulled in by kvm_ppc.h if applicable).

> I've considered other alternatives (though not in-depth) and found
> that they will require quite some refactoring. One simple idea is to
> move this #ifdef to within kvm_ppc.h. That should make the inclusion
> of this file a no-op in all the places where this is being included
> without KVM being enabled. But I am not 100% sure of that approach.
> 
> Any suggestions are welcome.

As I suggested elsewhere in the thread, why not be more fine-grained in
what you ifdef in the srcu header?  How will that require excessive
refactoring?

Or, just stick with the linker error.

I also wonder if this is worthwhile just to save around 2000 bytes.
What other core synchronization mechanisms are optional?  What
real-world configs will actually have this disabled?

-Scott
