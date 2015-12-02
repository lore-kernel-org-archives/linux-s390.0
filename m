From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 20/23] s390: show virtualization support in /proc/cpuinfo
Date: Wed,  2 Dec 2015 12:06:21 +0100
Message-ID: <1449054384-76374-21-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch exposes the SIE capability (aka virtualization support) via
/proc/cpuinfo -> "features" as "sie".

As we don't want to expose this hwcap via elf, let's add a second,
"internal"/non-elf capability list. The content is simply concatenated
to the existing features when printing /proc/cpuinfo.

We also add the defines to elf.h to keep the hwcap stuff at a common
place.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/elf.h  | 7 +++++++
 arch/s390/kernel/processor.c | 6 ++++++
 arch/s390/kernel/setup.c     | 9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index bab6739..08e34a5 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -104,6 +104,9 @@
 #define HWCAP_S390_TE		1024
 #define HWCAP_S390_VXRS		2048
 
+/* Internal bits, not exposed via elf */
+#define HWCAP_INT_SIE		1UL
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -169,6 +172,10 @@ extern unsigned int vdso_enabled;
 extern unsigned long elf_hwcap;
 #define ELF_HWCAP (elf_hwcap)
 
+/* Internal hardware capabilities, not exposed via elf */
+
+extern unsigned long int_hwcap;
+
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
    intent than poking at uname or /proc/cpuinfo.
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 7ce00e7..647128d 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -61,6 +61,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp",
 		"edat", "etf3eh", "highgprs", "te", "vx"
 	};
+	static const char * const int_hwcap_str[] = {
+		"sie"
+	};
 	unsigned long n = (unsigned long) v - 1;
 	int i;
 
@@ -75,6 +78,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		for (i = 0; i < ARRAY_SIZE(hwcap_str); i++)
 			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
 				seq_printf(m, "%s ", hwcap_str[i]);
+		for (i = 0; i < ARRAY_SIZE(int_hwcap_str); i++)
+			if (int_hwcap_str[i] && (int_hwcap & (1UL << i)))
+				seq_printf(m, "%s ", int_hwcap_str[i]);
 		seq_puts(m, "\n");
 		show_cacheinfo(m);
 	}
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c837bca..dc83ae6 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -80,6 +80,8 @@ EXPORT_SYMBOL(console_irq);
 unsigned long elf_hwcap __read_mostly = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
+unsigned long int_hwcap = 0;
+
 int __initdata memory_end_set;
 unsigned long __initdata memory_end;
 unsigned long __initdata max_physmem_end;
@@ -793,6 +795,13 @@ static int __init setup_hwcaps(void)
 		strcpy(elf_platform, "z13");
 		break;
 	}
+
+	/*
+	 * Virtualization support HWCAP_INT_SIE is bit 0.
+	 */
+	if (sclp.has_sief2)
+		int_hwcap |= HWCAP_INT_SIE;
+
 	return 0;
 }
 arch_initcall(setup_hwcaps);
-- 
2.3.0
