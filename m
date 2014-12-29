Return-Path: <scottwood@freescale.com>
Message-ID: <1419894305.4961.2.camel@freescale.com>
Subject: Re: [PATCH] srcu: Isolate srcu sections using CONFIG_SRCU
From: Scott Wood <scottwood@freescale.com>
Date: Mon, 29 Dec 2014 17:05:05 -0600
In-Reply-To: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
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
Cc: "open list:S390" <linux-s390@vger.kernel.org>, Lai Jiangshan <laijs@cn.fujitsu.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:LINUX FOR
 POWERPC..." <linuxppc-dev@lists.ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Tiejun Chen <tiejun.chen@windriver.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Andy Fleming <afleming@freescale.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Daniel Walter <dwalter@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2014-12-27 at 12:17 -0500, Pranith Kumar wrote:
> Isolate the SRCU functions and data structures within CONFIG_SRCU so that there
> is a compile time failure if srcu is used when not enabled. This was decided to
> be better than waiting until link time for a failure to occur.

Yes, false positives and extra ifdefs are so much better. :-P

Why not just ifdef the functions/macros, and leave the types alone?  If
you're worried about direct access to struct members, you could even
ifdef the members away while leaving the struct itself.  It is not
normal practice in Linux to need ifdefs around #includes.

> There are places which include kvm headers and utilize kvm data structures
> without checking if KVM is enabled. In two such archs(s390, ppc64), the current
> patch makes the uses of KVM conditional on KVM being enabled. The other option,
> which is to enable KVM unconditionally seemed a bit too much as we could easily
> figure out KVM only parts and enclose them in ifdefs.

Maybe not so easy (mpc85xx_smp_defconfig with NOTIFY stuff turned off so
that SRCU gets deselected):

In file included from /home/scott/fsl/git/linux/upstream/arch/powerpc/include/asm/kvm_ppc.h:30:0,
                 from /home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/smp.c:39:
/home/scott/fsl/git/linux/upstream/include/linux/kvm_host.h:366:21: error: field 'srcu' has incomplete type
/home/scott/fsl/git/linux/upstream/include/linux/kvm_host.h:367:21: error: field 'irq_srcu' has incomplete type
/home/scott/fsl/git/linux/upstream/scripts/Makefile.build:257: recipe for target 'arch/powerpc/kernel/smp.o' failed
make[2]: *** [arch/powerpc/kernel/smp.o] Error 1
/home/scott/fsl/git/linux/upstream/Makefile:955: recipe for target 'arch/powerpc/kernel' failed
make[1]: *** [arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....

Are you sure KVM is the only SRCU user so impacted?  It's also likely
that new such problems get introduced, because most people are going to
have SRCU enabled and thus not notice the breakage they're adding.

There's also at least one place that needs to be fixed, that currently
expects to get other headers indirectly via srcu.h:

/home/scott/fsl/git/linux/upstream/lib/assoc_array.c: In function 'assoc_array_apply_edit':
/home/scott/fsl/git/linux/upstream/lib/assoc_array.c:1425:2: error: implicit declaration of function 'call_rcu' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
/home/scott/fsl/git/linux/upstream/scripts/Makefile.build:257: recipe for target 'lib/assoc_array.o' failed

-Scott
