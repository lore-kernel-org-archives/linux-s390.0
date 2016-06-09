From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 13/14] tile/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:03 -0700
Message-ID: <1465506124-21866-14-git-send-email-keescook@chromium.org>
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
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index 8c6d2f2fefa3..d89b7011667c 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,14 +255,15 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 work = ACCESS_ONCE(current_thread_info()->flags);
 
-	if (secure_computing(NULL) == -1)
+	if ((work & _TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs)) {
+		regs->regs[TREG_SYSCALL_NR] = -1;
 		return -1;
-
-	if (work & _TIF_SYSCALL_TRACE) {
-		if (tracehook_report_syscall_entry(regs))
-			regs->regs[TREG_SYSCALL_NR] = -1;
 	}
 
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->regs[TREG_SYSCALL_NR]);
 
-- 
2.7.4
