Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 02/15] x86/entry: define _TIF_ALLWORK_MASK flags explicitly
Date: Thu, 19 Jan 2017 09:46:10 -0600
Message-Id: <6a57d8917b43ec60e3a4d26627af9f007a0a360c.1484839971.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1484839971.git.jpoimboe@redhat.com>
References: <cover.1484839971.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The _TIF_ALLWORK_MASK macro automatically includes the least-significant
16 bits of the thread_info flags, which is less than obvious and tends
to create confusion and surprises when reading or modifying the code.

Define the flags explicitly.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/x86/include/asm/thread_info.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ad6f5eb0..207d0d9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -73,9 +73,6 @@ struct thread_info {
  * thread information flags
  * - these are process state flags that various assembly files
  *   may need to access
- * - pending work-to-be-done flags are in LSW
- * - other flags in MSW
- * Warning: layout of LSW is hardcoded in entry.S
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
@@ -103,8 +100,8 @@ struct thread_info {
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -133,8 +130,10 @@ struct thread_info {
 
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK						\
-	((0x0000FFFF & ~_TIF_SECCOMP) | _TIF_SYSCALL_TRACEPOINT |	\
-	_TIF_NOHZ)
+	(_TIF_SYSCALL_TRACE | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING |	\
+	 _TIF_NEED_RESCHED | _TIF_SINGLESTEP | _TIF_SYSCALL_EMU |	\
+	 _TIF_SYSCALL_AUDIT | _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE |	\
+	 _TIF_NOHZ | _TIF_SYSCALL_TRACEPOINT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-- 
2.7.4
