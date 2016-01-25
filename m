From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 04/16] seccomp: Check in_compat_syscall, not is_compat_task, in strict mode
Date: Mon, 25 Jan 2016 14:24:18 -0800
Message-ID: <9cc3588071d4e31b035e0cf1d09483067df38823.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Seccomp wants to know the syscall bitness, not the caller task
bitness, when it selects the syscall whitelist.

As far as I know, this makes no difference on any architecture, so
it's not a security problem.  (It generates identical code
everywhere except sparc, and, on sparc, the syscall numbering is the
same for both ABIs.)

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 580ac2d4024f..26858fa43a60 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -395,7 +395,7 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 	struct seccomp_filter *filter = ERR_PTR(-EFAULT);
 
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	if (in_compat_syscall()) {
 		struct compat_sock_fprog fprog32;
 		if (copy_from_user(&fprog32, user_filter, sizeof(fprog32)))
 			goto out;
@@ -529,7 +529,7 @@ static void __secure_computing_strict(int this_syscall)
 {
 	int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
-	if (is_compat_task())
+	if (in_compat_syscall())
 		syscall_whitelist = mode1_syscalls_32;
 #endif
 	do {
-- 
2.5.0
