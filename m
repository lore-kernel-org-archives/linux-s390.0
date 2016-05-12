From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Thu, 12 May 2016 03:20:00 +0300
Message-ID: <20160512002000.GA30997@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

I debugged preadv02 and pwritev02 failures and found very weird bug.
Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
of vector, and kernel reports successful read/write.

There are 2 problems:
1. How kernel allows such address to be passed to fs subsystem;
2. How fs successes to read/write at non-mapped, and in fact non-user
address.

I don't know the answer on 2'nd question, and it might be something
generic. But I investigated first problem.

The problem is that compat_rw_copy_check_uvector() uses access_ok() to
validate user address, and on arm64 it ends up with checking buffer
end against current_thread_info()->addr_limit.

current_thread_info()->addr_limit for ilp32, and most probably for
aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
It happens because on thread creation we call flush_old_exec() to set 
addr_limit, and completely ignore compat mode there.

This patch fixes it. It also fixes USER_DS macro to return different
values depending on compat.

This patch is enough to handle preadv02 and pwritev02, but problem #2
is still there.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h     | 1 +
 arch/arm64/include/asm/uaccess.h | 2 +-
 arch/arm64/kernel/binfmt_elf32.c | 1 +
 arch/arm64/kernel/binfmt_ilp32.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7a39683..6ba4952 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -146,6 +146,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 do {						\
 	clear_thread_flag(TIF_32BIT_AARCH64);	\
 	clear_thread_flag(TIF_32BIT);		\
+	set_fs(TASK_SIZE_64);			\
 } while (0)
 
 #define ARCH_DLINFO							\
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 19cfdc5..3b0dd8d 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -51,7 +51,7 @@
 #define KERNEL_DS	(-1UL)
 #define get_ds()	(KERNEL_DS)
 
-#define USER_DS		TASK_SIZE_64
+#define USER_DS		TASK_SIZE
 #define get_fs()	(current_thread_info()->addr_limit)
 
 static inline void set_fs(mm_segment_t fs)
diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
index 5487872..2e8d9f3 100644
--- a/arch/arm64/kernel/binfmt_elf32.c
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -12,6 +12,7 @@
 do {						\
 	clear_thread_flag(TIF_32BIT_AARCH64);	\
 	set_thread_flag(TIF_32BIT);		\
+	set_fs(TASK_SIZE_32);			\
 } while (0)
 
 #define COMPAT_ARCH_DLINFO
diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
index a934fd4..a8599c6 100644
--- a/arch/arm64/kernel/binfmt_ilp32.c
+++ b/arch/arm64/kernel/binfmt_ilp32.c
@@ -59,6 +59,7 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
 do {									\
 	set_thread_flag(TIF_32BIT_AARCH64);				\
 	clear_thread_flag(TIF_32BIT);					\
+	set_fs(TASK_SIZE_32);						\
 } while (0)
 
 #undef ARCH_DLINFO
-- 
2.5.0
