From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
Date: Mon, 25 Jan 2016 14:24:28 -0800
Message-ID: <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The input compat code should work like all other compat code: for
32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
64-bit ABI.  We have a helper for that (in_compat_syscall()): just
use it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/input/input-compat.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 148f66fe3205..0f25878d5fa2 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -17,17 +17,7 @@
 
 #ifdef CONFIG_COMPAT
 
-/* Note to the author of this code: did it ever occur to
-   you why the ifdefs are needed? Think about it again. -AK */
-#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
-#  define INPUT_COMPAT_TEST is_compat_task()
-#elif defined(CONFIG_S390)
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
-#elif defined(CONFIG_MIPS)
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
-#else
-#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
-#endif
+#define INPUT_COMPAT_TEST in_compat_syscall()
 
 struct input_event_compat {
 	struct compat_timeval time;
-- 
2.5.0
