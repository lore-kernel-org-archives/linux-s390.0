From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 27/40] [S390] Use block_sigmask()
Date: Tue, 14 Feb 2012 11:41:00 +0000
Message-ID: <1329219673-28711-28-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Matt Fleming <matt.fleming@intel.com>

Use the new helper function introduced in commit 5e6292c0f28f
("signal: add block_sigmask() for adding sigmask to current->blocked")
which centralises the code for updating current->blocked after
successfully delivering a signal and reduces the amount of duplicate
code across architectures.

In the past some architectures got this code wrong, so using this
helper function should stop that from happening again.

Cc: Oleg Nesterov <oleg@redhat.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/s390/kernel/compat_signal.c |    6 +-----
 arch/s390/kernel/signal.c        |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index 6fe78c2..53a82c8 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -581,7 +581,6 @@ give_sigsegv:
 int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 		    siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
-	sigset_t blocked;
 	int ret;
 
 	/* Set up the stack frame */
@@ -591,10 +590,7 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 		ret = setup_frame32(sig, ka, oldset, regs);
 	if (ret)
 		return ret;
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&blocked, sig);
-	set_current_blocked(&blocked);
+	block_sigmask(ka, sig);
 	return 0;
 }
 
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index a8ba840..c4f5790 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -385,7 +385,6 @@ static int handle_signal(unsigned long sig, struct k_sigaction *ka,
 			 siginfo_t *info, sigset_t *oldset,
 			 struct pt_regs *regs)
 {
-	sigset_t blocked;
 	int ret;
 
 	/* Set up the stack frame */
@@ -395,10 +394,7 @@ static int handle_signal(unsigned long sig, struct k_sigaction *ka,
 		ret = setup_frame(sig, ka, oldset, regs);
 	if (ret)
 		return ret;
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NODEFER))
-		sigaddset(&blocked, sig);
-	set_current_blocked(&blocked);
+	block_sigmask(ka, sig);
 	return 0;
 }
 
-- 
1.7.4.4
