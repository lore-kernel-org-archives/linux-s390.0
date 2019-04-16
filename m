From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 1/5] cpu/speculation: Add 'mitigations=' cmdline option
Date: Tue, 16 Apr 2019 10:32:37 -0500
Message-ID: <20190416153237.ici3ezhy5h5fji22@treble>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
 <20190416141335.GH31772@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416141335.GH31772@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 16, 2019 at 04:13:35PM +0200, Borislav Petkov wrote:
> On Fri, Apr 12, 2019 at 03:39:28PM -0500, Josh Poimboeuf wrote:
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 38890f62f9a8..aed9083f8eac 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2320,3 +2320,18 @@ void __init boot_cpu_hotplug_init(void)
> >  #endif
> >  	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
> >  }
> > +
> > +enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
> > +
> > +static int __init mitigations_cmdline(char *arg)
> 
> Forgot the verb: "mitigations_parse_cmdline".

Sure.

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aed9083f8eac..cf9fea42d8fc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2323,7 +2323,7 @@ void __init boot_cpu_hotplug_init(void)
 
 enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
 
-static int __init mitigations_cmdline(char *arg)
+static int __init mitigations_parse_cmdline(char *arg)
 {
 	if (!strcmp(arg, "off"))
 		cpu_mitigations = CPU_MITIGATIONS_OFF;
@@ -2334,4 +2334,4 @@ static int __init mitigations_cmdline(char *arg)
 
 	return 0;
 }
-early_param("mitigations", mitigations_cmdline);
+early_param("mitigations", mitigations_parse_cmdline);
