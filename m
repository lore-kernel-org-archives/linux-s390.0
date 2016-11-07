Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1478524386.29112.18.camel@tiscali.nl>
Subject: Re: [PATCH 2/2] s390: squash facilities_src.h into gen_facilities.c
From: Paul Bolle <pebolle@tiscali.nl>
Date: Mon, 07 Nov 2016 14:13:06 +0100
In-Reply-To: <20161107105005.3477a324@mschwide>
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
         <1478403928-20799-2-git-send-email-yamada.masahiro@socionext.com>
         <20161107070322.GA4075@osiris> <20161107105005.3477a324@mschwide>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-s390@vger.kernel.org, Sascha Silbe <silbe@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-11-07 at 10:50 +0100, Martin Schwidefsky wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > On Sun, Nov 06, 2016 at 12:45:28PM +0900, Masahiro Yamada wrote:
> > > 
> > > We generally expect headers in arch/$(ARCH)/include/asm directory
> > > are included from kernel sources,  but facilities_src.h is not;
> > > it is included from the arch/s390/tools/gen_facilities.c tool.
> > > 
> > > There is no reason to expose this header to the public include path.
> > > Furthermore, facilities_src.h makes sure to be included only from
> > > gen_facilities.c by the following:
> > > 
> > >   #ifndef S390_GEN_FACILITIES_C
> > >   #error "This file can only be included by gen_facilities.c"
> > >   #endif
> > > 
> > > This check can be removed by merging the two files.
> > > 
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

It took me some time to figure out that gen_facilities is only used to
generate a small header file (generated/facilities.h). And that header's only
goal is to define FACILITIES_ALS and FACILITIES_KVM.

Pasted below is an attempt to use asm/facilities.h instead of
generated/facilities.h. That allows to drop arch/s390/tools/ entirely. I don't
actually have an s390 machine at hand to test this, but this does build and
the preprocessed code this generates looks sane.

(Yes, asm/facilities.h might need another level of preprocessor defines to
become actually readable.)

Thanks,


Paul Bolle

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 54e00526b8df..a0ee0a1ee677 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -108,7 +108,6 @@ drivers-y	+= drivers/s390/
 drivers-$(CONFIG_OPROFILE)	+= arch/s390/oprofile/
 
 boot		:= arch/s390/boot
-tools		:= arch/s390/tools
 
 all: image bzImage
 
@@ -127,10 +126,6 @@ vdso_install:
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	$(Q)$(MAKE) $(clean)=$(tools)
-
-archprepare:
-	$(Q)$(MAKE) $(build)=$(tools) include/generated/facilities.h
 
 # Don't use tabs in echo arguments
 define archhelp
diff --git a/arch/s390/include/asm/facilities.h b/arch/s390/include/asm/facilities.h
new file mode 100644
index 000000000000..c87f18d29217
--- /dev/null
+++ b/arch/s390/include/asm/facilities.h
@@ -0,0 +1,43 @@
+#ifndef __ASM_FACILITIES_H
+#define __ASM_FACILITIES_H
+
+#define FACILITIES_ALS \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z900_FEATURES), UL) << 0 |	/* N3 instructions */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z900_FEATURES), UL) << 1 |	/* z/Arch mode installed */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z9_109_FEATURES), UL) << 7 |	/* stfle */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z9_109_FEATURES), UL) << 17 |	/* message security assist */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z990_FEATURES), UL) << 18 |	/* long displacement facility */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z9_109_FEATURES), UL) << 21 |	/* extended-immediate facility */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z9_109_FEATURES), UL) << 25 |	/* store clock fast */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z10_FEATURES), UL) << 27 |	/* mvcos */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z10_FEATURES), UL) << 32 |	/* compare and swap and store */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z10_FEATURES), UL) << 33 |	/* compare and swap and store 2 */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z10_FEATURES), UL) << 34 |	/* general extension facility */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z10_FEATURES), UL) << 35 |	/* execute extensions */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z196_FEATURES), UL) << 45 |	/* fast-BCR, etc. */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_ZEC12_FEATURES), UL) << 49 |	/* misc-instruction-extensions */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_ZEC12_FEATURES), UL) << 52 |	/* interlocked facility 2 */ \
+	_AC(IS_BUILTIN(CONFIG_HAVE_MARCH_Z13_FEATURES), UL) << 53	/* load-and-zero-rightmost-byte, etc. */
+
+#define FACILITIES_KVM \
+	_BITUL(0)  |	/* N3 instructions */ \
+	_BITUL(1)  |	/* z/Arch mode installed */ \
+	_BITUL(2)  |	/* z/Arch mode active */ \
+	_BITUL(3)  |	/* DAT-enhancement */ \
+	_BITUL(4)  |	/* idte segment table */ \
+	_BITUL(5)  |	/* idte region table */ \
+	_BITUL(6)  |	/* ASN-and-LX reuse */ \
+	_BITUL(7)  |	/* stfle */ \
+	_BITUL(8)  |	/* enhanced-DAT 1 */ \
+	_BITUL(9)  |	/* sense-running-status */ \
+	_BITUL(10) |	/* conditional sske */ \
+	_BITUL(13) |	/* ipte-range */ \
+	_BITUL(14)  	/* nonquiescing key-setting */ \
+	, \
+	_BITUL(9)  |	/* transactional execution */ \
+	_BITUL(11) |	/* access-exception-fetch/store indication */ \
+	_BITUL(12) |	/* msa extension 3 */ \
+	_BITUL(13) |	/* msa extension 4 */ \
+	_BITUL(14)	/* enhanced-DAT 2 */
+
+#endif
diff --git a/arch/s390/include/asm/facility.h b/arch/s390/include/asm/facility.h
index 09b406db7529..aed6b5454662 100644
--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_FACILITY_H
 #define __ASM_FACILITY_H
 
-#include <generated/facilities.h>
+#include <asm/facilities.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
deleted file mode 100644
index 72a4b2cf1365..000000000000
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
deleted file mode 100644
index 6d9814c9df2b..000000000000
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
deleted file mode 100644
index fe4e6c910dd7..000000000000
