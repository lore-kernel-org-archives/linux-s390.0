From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 14/23] arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
Date: Tue, 24 May 2016 03:04:43 +0300
Message-ID: <1464048292-30136-15-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

ILP32 tasks are needed to be distinguished from lp64 and aarch32.
This patch adds helper functions is_ilp32_compat_{task,thread} and
thread flag TIF_32BIT_AARCH64 to address it. This is a preparation
for following patches in ilp32 patchset.

For consistency, SET_PERSONALITY is changed here accordingly.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h         | 13 +++++++++++--
 arch/arm64/include/asm/is_compat.h   | 28 +++++++++++++++++++++++++++-
 arch/arm64/include/asm/thread_info.h |  2 ++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index b5437c5..e18bb8a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -142,7 +142,11 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
-#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
+#define SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	clear_thread_flag(TIF_32BIT);		\
+} while (0)
 
 #define ARCH_DLINFO							\
 do {									\
@@ -181,7 +185,12 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
+#define COMPAT_SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	set_thread_flag(TIF_32BIT);		\
+} while (0)
+
 #define COMPAT_ARCH_DLINFO
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
index 6139b5a..55134cf 100644
--- a/arch/arm64/include/asm/is_compat.h
+++ b/arch/arm64/include/asm/is_compat.h
@@ -45,11 +45,37 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
+}
+
+#else
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
 #ifdef CONFIG_COMPAT
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 4daa559..8802645 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -119,6 +119,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* AARCH32 process */
+#define TIF_32BIT_AARCH64	23	/* 32 bit process on AArch64(ILP32) */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -130,6 +131,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_32BIT_AARCH64	(1 << TIF_32BIT_AARCH64)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
-- 
2.5.0
