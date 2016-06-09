From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 10/14] parisc/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:00 -0700
Message-ID: <1465506124-21866-11-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <james.hogan@imgtec.com>, Kees Cook <keescook@chromium.org>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>, Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Martin
List-ID: <linux-s390.vger.kernel.org>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/ptrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8edc47c0b98e..e02d7b4d2b69 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -311,10 +311,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
 		/*
@@ -325,6 +321,11 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		regs->gr[20] = -1UL;
 		goto out;
 	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gr[20]);
-- 
2.7.4
