From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Thu, 23 May 2013 13:58:26 +0000
Subject: [Aneesh Kumar K.V] Re: [mmotm:master 98/322] /c/kernel-tests/src/tip/arch/s390/include/asm/pgtable.h
Message-Id: <87r4gx4xn1.fsf@linux.vnet.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--=-=-="
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--=-=-=
Content-Type: text/plain



Forgot to cc the s390 list.


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, kbuild-all@01.org
Subject: Re: [mmotm:master 98/322] /c/kernel-tests/src/tip/arch/s390/include/asm/pgtable.h:1354:62: error: expected declaration specifiers or '...' before ',' token
In-Reply-To: <519ddd97.0c1Iy86hq5fLERvb%fengguang.wu@intel.com>
References: <519ddd97.0c1Iy86hq5fLERvb%fengguang.wu@intel.com>
User-Agent: Notmuch/0.15.2+52~gb714a80 (http://notmuchmail.org) Emacs/24.3.50.1 (x86_64-unknown-linux-gnu)
Date: Thu, 23 May 2013 17:09:39 +0530
Message-ID: <87txlu3oxw.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain

kbuild test robot <fengguang.wu@intel.com> writes:

> tree:   git://git.cmpxchg.org/linux-mmotm.git master
> head:   8d4c612420310911f3152bf23e1923c8d7073995
> commit: 78e3c7a9571d456ad799ed0b357540addc7de796 [98/322] mm/THP: add pmd args to pgtable deposit and withdraw APIs
> config: make ARCH=s390 allmodconfig
>
> All error/warnings:
>
>    warning: (ARM_GIC && ARM_VIC && RENESAS_INTC_IRQPIN && RENESAS_IRQC && VERSATILE_FPGA_IRQ && REGMAP && GPIO_LYNXPOINT && GPIO_GRGPIO && GPIO_PCF857X && GPIO_LANGWELL && MFD_CORE && MFD_MAX77686 && MFD_MAX8997 && AB8500_CORE && MFD_LP8788 && MFD_TPS65910 && TWL4030_CORE && MFD_WM831X_I2C && MFD_WM831X_SPI && EXTCON_MAX77693) selects IRQ_DOMAIN which has unmet direct dependencies (HAVE_GENERIC_HARDIRQS)
>    warning: (ARM_GIC && ARM_VIC && RENESAS_INTC_IRQPIN && RENESAS_IRQC && VERSATILE_FPGA_IRQ && REGMAP && GPIO_LYNXPOINT && GPIO_GRGPIO && GPIO_PCF857X && GPIO_LANGWELL && MFD_CORE && MFD_MAX77686 && MFD_MAX8997 && AB8500_CORE && MFD_LP8788 && MFD_TPS65910 && TWL4030_CORE && MFD_WM831X_I2C && MFD_WM831X_SPI && EXTCON_MAX77693) selects IRQ_DOMAIN which has unmet direct dependencies (HAVE_GENERIC_HARDIRQS)
>    In file included from /c/kernel-tests/src/tip/arch/s390/kernel/asm-offsets.c:13:0:
>>> /c/kernel-tests/src/tip/arch/s390/include/asm/pgtable.h:1354:62: error: expected declaration specifiers or '...' before ',' token
>    make[2]: *** [arch/s390/kernel/asm-offsets.s] Error 1
>    make[2]: Target `__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target `prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>

Sorry about breaking the build. the below should fix. Please fold

commit 7b0c8a587f0ece7c6bba6f29eeec6ac37bba11f3
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Thu May 23 17:08:43 2013 +0530

    s390: Fix build error
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 9fba7a8..b99bbfb 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1351,7 +1351,7 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, , pmd_t *pmdp,
+extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW

--=-=-=--
