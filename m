Return-Path: <linux-kernel-owner@vger.kernel.org>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH seccomp v2 5/8] s390: Enable seccomp architecture tracking
Date: Wed, 11 Nov 2020 07:33:51 -0600
Message-Id: <a381b10aa2c5b1e583642f3cd46ced842d9d4ce5.1605101222.git.yifeifz2@illinois.edu>
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: containers@lists.linux-foundation.org
Cc: YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, David Laight <David.Laight@aculab.com>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, Giuseppe Scrivano <gscrivan@redhat.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, Jann Horn <jannh@google.com>, Josep Torrellas <torrella@illinois.edu>, Kees Cook <keescook@chromium.org>, Tianyin Xu <tyxu@illinois.edu>, Tobin Feldman-Fitzthum <tobin@ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Valentin Rothberg <vrothber@redhat.com>, Will Drewry <wad@chromium.org>

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for s390.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/s390/include/asm/seccomp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 795bbe0d7ca6..71d46f0ba97b 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -16,4 +16,13 @@
 
 #include <asm-generic/seccomp.h>
 
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
+#ifdef CONFIG_COMPAT
+# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
+# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
+# define SECCOMP_ARCH_COMPAT_NAME	"s390"
+#endif
+
 #endif	/* _ASM_S390_SECCOMP_H */
-- 
2.29.2
