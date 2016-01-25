From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 05/16] ptrace: in PEEK_SIGINFO, check syscall bitness, not task bitness
Date: Mon, 25 Jan 2016 14:24:19 -0800
Message-ID: <d1f58b0983fc85bf2440fdb86b186d9f214e03f7.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Users of the 32-bit ptrace() ABI expect the full 32-bit ABI.
siginfo translation should check ptrace() ABI, not caller task ABI.

This is an ABI change on SPARC.  Let's hope that no one relied on
the old buggy ABI.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2341efe7fe02..c79b91d09e35 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -681,7 +681,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 			break;
 
 #ifdef CONFIG_COMPAT
-		if (unlikely(is_compat_task())) {
+		if (unlikely(in_compat_syscall())) {
 			compat_siginfo_t __user *uinfo = compat_ptr(data);
 
 			if (copy_siginfo_to_user32(uinfo, &info) ||
-- 
2.5.0
