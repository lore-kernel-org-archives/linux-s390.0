From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
Date: Tue, 28 May 2013 16:49:20 +0200
Message-ID: <2827337.zlCzuksfVM@wuerfel>
References: <519DCBEF.3090208@asianux.com>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
 <20130528081910.GA29557@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130528081910.GA29557@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Chen Gang <gang.chen@asianux.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Ingo Molnar <mingo@kernel.org>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, "mingo@redhat.com" <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, H?vard Skinnemoen <hskinnemoen@gma>
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 28 May 2013 10:19:10 Ingo Molnar wrote:
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > So, if you want to use this, then you should update the CONFIG_BUG text 
> > to include a warning to this effect:
> > 
> >      Warning: if CONFIG_BUG is turned off, and control flow reaches
> >      a BUG(), the system behaviour will be undefined.
> > 
> > so that people can make an informed choice about this, because at the
> > moment:
> > 
> >           Disabling this option eliminates support for BUG and WARN, reducing
> >           the size of your kernel image and potentially quietly ignoring
> >           numerous fatal conditions. You should only consider disabling this
> >           option for embedded systems with no facilities for reporting errors.
> >           Just say Y.
> > 
> > will become completely misleading.  Turning this option off will _not_ 
> > result in "quietly ignoring numerous fatal conditions".
> 
> I'm fine with adding your text as a clarification - but I think 'quietly 
> ignoring fatal conditions' very much implies an undefined outcome if that 
> unexpected condition does occur: the code might crash, it might corrupt 
> memory or it might do some other unexpected thing.
> 
> There are many other places that do a BUG_ON() of a NULL pointer or so, or 
> of a zero refcount, or a not held lock - and turning the BUG_ON() off 
> makes the code unpredictable _anyway_ - even if the compiler does not 
> notice an uninitialized variable.
> 
> So pretty much any weakening of BUG_ON() _will_ make the kernel more 
> unpredictable.

FWIW, I've run some size analyis using the ARM 'multi_v7_defconfig'
and gcc-4.8, using various definitions for BUG() and BUG_ON(), to
see how big the size improvement actually gets

1. Baseline: normal bug plus CONFIG_BUG_VERBOSE
   text    data     bss     dec     hex filename
3743196  224396  206812 4174404  3fb244 vmlinux-bugverbose

2. disabling CONFIG_BUG_VERBOSE, saving 0.6%
3716920  224380  206812 4148112  3f4b90 vmlinux-nobugverbose

3. #define BUG() panic(__func__), #define BUG_ON(c) if(c) BUG(), saving 1.0%
3701076  224384  206812 4132272  3f0db0 vmlinux-bug-panicfunc

3. #define BUG() panic(__func__), #define BUG_ON(c) if(c) BUG(), saving 1.5%
3678884  224400  206812 4110096  3eb710 vmlinux-bug-panic

4. #define BUG() unreachable(), saving 2.1%
3652636  224384  206812 4083832  3e5078 vmlinux-bug-unreachable

5. as 4, plus #define BUG_ON(c) if(c) unreachable(), saving 2.2%
3651108  224380  206812 4082300  3e4a7c vmlinux-bugon-unreachable

6. #define BUG() do{}while(0), saving 2.1%
3654264  224380  206812 4085456  3e56d0 vmlinux-nobug

7. as 6, plus #define BUG_ON if(0 && (c)) unreachable, saving 2.2%
3648392  223996  206748 4079136  3e3e20 vmlinux-no-bugon

8. my patch below, saving 1.8%
3666532  224380  206812 4097724  3e86bc obj-tmp/vmlinux

The gain of doing unreachable and letting the code run off whereever
is minimal compared to the current state of doing nothing, but it
avoids the warnings.

Same test using x86_defconfig:

1. CONFIG_BUG=y, CONFIG_BUGVERBOSE=n
10797859        1395648 1175552 13369059         cbfee3 vmlinux-x86-bug

2. CONFIG_BUG=n, saves 1.0%
10658553        1395584 1175552 13229689         c9de79 vmlinux-x86-nobug

3. with my patch, saves 0.8%
10684186        1395584 1175552 13255322         ca429a vmlinux-x86-archbug

Getting 1-2% savings in kernel size seems absolutely worth keeping the
option, but 0.2-0.4% left for getting reproducible behavior also seems
worthwhile. The result in the patch below.

This basically loses any of the BUG() reporting, but leaves the
logic to trap and kill the task in place when CONFIG_BUG is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 7af5c6c..f25e638 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -3,8 +3,6 @@
 
 #include <linux/linkage.h>
 
-#ifdef CONFIG_BUG
-
 /*
  * Use a suitable undefined instruction to use for ARM/Thumb2 bug handling.
  * We need to be careful not to conflict with those used by other modules and
@@ -51,10 +50,10 @@ do {								\
 	asm volatile(BUG_INSTR_TYPE #__value);			\
 	unreachable();						\
 } while (0)
 #endif  /* CONFIG_DEBUG_BUGVERBOSE */
 
 #define HAVE_ARCH_BUG
-#endif  /* CONFIG_BUG */
+#define HAVE_ARCH_BUG_ON
 
 #include <asm-generic/bug.h>
 
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 2f03ff0..ba38ebb 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -1,7 +1,6 @@
 #ifndef _ASM_X86_BUG_H
 #define _ASM_X86_BUG_H
 
-#ifdef CONFIG_BUG
 #define HAVE_ARCH_BUG
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -33,8 +32,6 @@ do {								\
 } while (0)
 #endif
 
-#endif /* !CONFIG_BUG */
-
 #include <asm-generic/bug.h>
 
 #endif /* _ASM_X86_BUG_H */
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 7d10f96..bbd2872 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -112,12 +112,13 @@ extern void warn_slowpath_null(const char *file, const int line);
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
+	(void)__ret_warn_on;						\
 	unlikely(__ret_warn_on);					\
 })
 #endif
@@ -125,6 +126,8 @@ extern void warn_slowpath_null(const char *file, const int line);
 #ifndef WARN
 #define WARN(condition, format...) ({					\
 	int __ret_warn_on = !!(condition);				\
+	if (0 && (__ret_warn_on))					\
+		printk(format);						\
 	unlikely(__ret_warn_on);					\
 })
 #endif
