Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] s390: squash facilities_src.h into gen_facilities.c
Date: Sun,  6 Nov 2016 12:45:28 +0900
Message-Id: <1478403928-20799-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478403928-20799-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We generally expect headers in arch/$(ARCH)/include/asm directory
are included from kernel sources, but facilities_src.h is not;
it is included from the arch/s390/tools/gen_facilities.c tool.

There is no reason to expose this header to the public include path.
Furthermore, facilities_src.h makes sure to be included only from
gen_facilities.c by the following:

  #ifndef S390_GEN_FACILITIES_C
  #error "This file can only be included by gen_facilities.c"
  #endif

This check can be removed by merging the two files.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/asm/facilities_src.h | 80 ----------------------------------
 arch/s390/tools/gen_facilities.c       | 76 ++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 83 deletions(-)
 delete mode 100644 arch/s390/include/asm/facilities_src.h

diff --git a/arch/s390/include/asm/facilities_src.h b/arch/s390/include/asm/facilities_src.h
deleted file mode 100644
index 8b1a692..0000000
--- a/arch/s390/include/asm/facilities_src.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *    Copyright IBM Corp. 2015
- */
-
-#ifndef S390_GEN_FACILITIES_C
-#error "This file can only be included by gen_facilities.c"
-#endif
-
-struct facility_def {
-	char *name;
-	int *bits;
-};
-
-static struct facility_def facility_defs[] = {
-	{
-		/*
-		 * FACILITIES_ALS contains the list of facilities that are
-		 * required to run a kernel that is compiled e.g. with
-		 * -march=<machine>.
-		 */
-		.name = "FACILITIES_ALS",
-		.bits = (int[]){
-#ifdef CONFIG_HAVE_MARCH_Z900_FEATURES
-			0,  /* N3 instructions */
-			1,  /* z/Arch mode installed */
-#endif
-#ifdef CONFIG_HAVE_MARCH_Z990_FEATURES
-			18, /* long displacement facility */
-#endif
-#ifdef CONFIG_HAVE_MARCH_Z9_109_FEATURES
-			7,  /* stfle */
-			17, /* message security assist */
-			21, /* extended-immediate facility */
-			25, /* store clock fast */
-#endif
-#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
-			27, /* mvcos */
-			32, /* compare and swap and store */
-			33, /* compare and swap and store 2 */
-			34, /* general extension facility */
-			35, /* execute extensions */
-#endif
-#ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
-			45, /* fast-BCR, etc. */
-#endif
-#ifdef CONFIG_HAVE_MARCH_ZEC12_FEATURES
-			49, /* misc-instruction-extensions */
-			52, /* interlocked facility 2 */
-#endif
-#ifdef CONFIG_HAVE_MARCH_Z13_FEATURES
-			53, /* load-and-zero-rightmost-byte, etc. */
-#endif
-			-1 /* END */
-		}
-	},
-	{
-		.name = "FACILITIES_KVM",
-		.bits = (int[]){
-			0,  /* N3 instructions */
-			1,  /* z/Arch mode installed */
-			2,  /* z/Arch mode active */
-			3,  /* DAT-enhancement */
-			4,  /* idte segment table */
-			5,  /* idte region table */
-			6,  /* ASN-and-LX reuse */
-			7,  /* stfle */
-			8,  /* enhanced-DAT 1 */
-			9,  /* sense-running-status */
-			10, /* conditional sske */
-			13, /* ipte-range */
-			14, /* nonquiescing key-setting */
-			73, /* transactional execution */
-			75, /* access-exception-fetch/store indication */
-			76, /* msa extension 3 */
-			77, /* msa extension 4 */
-			78, /* enhanced-DAT 2 */
-			-1  /* END */
-		}
-	},
-};
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index fe4e6c9..8cc53b1 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -7,13 +7,83 @@
  *
  */
 
-#define S390_GEN_FACILITIES_C
-
 #include <strings.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <asm/facilities_src.h>
+
+struct facility_def {
+	char *name;
+	int *bits;
+};
+
+static struct facility_def facility_defs[] = {
+	{
+		/*
+		 * FACILITIES_ALS contains the list of facilities that are
+		 * required to run a kernel that is compiled e.g. with
+		 * -march=<machine>.
+		 */
+		.name = "FACILITIES_ALS",
+		.bits = (int[]){
+#ifdef CONFIG_HAVE_MARCH_Z900_FEATURES
+			0,  /* N3 instructions */
+			1,  /* z/Arch mode installed */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z990_FEATURES
+			18, /* long displacement facility */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z9_109_FEATURES
+			7,  /* stfle */
+			17, /* message security assist */
+			21, /* extended-immediate facility */
+			25, /* store clock fast */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+			27, /* mvcos */
+			32, /* compare and swap and store */
+			33, /* compare and swap and store 2 */
+			34, /* general extension facility */
+			35, /* execute extensions */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
+			45, /* fast-BCR, etc. */
+#endif
+#ifdef CONFIG_HAVE_MARCH_ZEC12_FEATURES
+			49, /* misc-instruction-extensions */
+			52, /* interlocked facility 2 */
+#endif
+#ifdef CONFIG_HAVE_MARCH_Z13_FEATURES
+			53, /* load-and-zero-rightmost-byte, etc. */
+#endif
+			-1 /* END */
+		}
+	},
+	{
+		.name = "FACILITIES_KVM",
+		.bits = (int[]){
+			0,  /* N3 instructions */
+			1,  /* z/Arch mode installed */
+			2,  /* z/Arch mode active */
+			3,  /* DAT-enhancement */
+			4,  /* idte segment table */
+			5,  /* idte region table */
+			6,  /* ASN-and-LX reuse */
+			7,  /* stfle */
+			8,  /* enhanced-DAT 1 */
+			9,  /* sense-running-status */
+			10, /* conditional sske */
+			13, /* ipte-range */
+			14, /* nonquiescing key-setting */
+			73, /* transactional execution */
+			75, /* access-exception-fetch/store indication */
+			76, /* msa extension 3 */
+			77, /* msa extension 4 */
+			78, /* enhanced-DAT 2 */
+			-1  /* END */
+		}
+	},
+};
 
 static void print_facility_list(struct facility_def *def)
 {
-- 
1.9.1
