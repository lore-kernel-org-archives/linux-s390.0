From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 06/16] auditsc: For seccomp events, log syscall compat state using in_compat_syscall
Date: Mon, 25 Jan 2016 14:24:20 -0800
Message-ID: <2c5ac9f83ad077d1f66c9e6469eb73274703f6d1.1453759363.git.luto@kernel.org>
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

Except on SPARC, this is what the code always did.  SPARC compat
seccomp was buggy, although the impact of the bug was limited
because SPARC 32-bit and 64-bit syscall numbers are the same.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 195ffaee50b9..7d0e3cf8abe1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2412,8 +2412,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
-			 signr, syscall_get_arch(), syscall, is_compat_task(),
-			 KSTK_EIP(current), code);
+			 signr, syscall_get_arch(), syscall,
+			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
 }
 
-- 
2.5.0
