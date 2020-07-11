Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2020 10:09:57 -0000
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/core] lockdep: Prepare for NMI IRQ state tracking
In-Reply-To: <20200623083721.155449112@infradead.org>
References: <20200623083721.155449112@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219720.4006.9282048000882212758.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     859d069ee1ddd87862e1d6a356a82ed417dbeb67
Gitweb:        https://git.kernel.org/tip/859d069ee1ddd87862e1d6a356a82ed417dbeb67
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 27 May 2020 15:00:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:01 +02:00

lockdep: Prepare for NMI IRQ state tracking

There is no reason not to always, accurately, track IRQ state.

This change also makes IRQ state tracking ignore lockdep_off().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
---
 kernel/locking/lockdep.c | 46 +++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4..d595623 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -395,7 +395,7 @@ void lockdep_init_task(struct task_struct *task)
 
 static __always_inline void lockdep_recursion_finish(void)
 {
-	if (WARN_ON_ONCE(--current->lockdep_recursion))
+	if (WARN_ON_ONCE((--current->lockdep_recursion) & LOCKDEP_RECURSION_MASK))
 		current->lockdep_recursion = 0;
 }
 
@@ -3646,7 +3646,16 @@ static void __trace_hardirqs_on_caller(void)
  */
 void lockdep_hardirqs_on_prepare(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs do not (and cannot) track lock dependencies, nothing to do.
+	 */
+	if (unlikely(in_nmi()))
+		return;
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (unlikely(current->hardirqs_enabled)) {
@@ -3692,7 +3701,27 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * NMIs can happen in the middle of local_irq_{en,dis}able() where the
+	 * tracking state and hardware state are out of sync.
+	 *
+	 * NMIs must save lockdep_hardirqs_enabled() to restore IRQ state from,
+	 * and not rely on hardware state like normal interrupts.
+	 */
+	if (unlikely(in_nmi())) {
+		/*
+		 * Skip:
+		 *  - recursion check, because NMI can hit lockdep;
+		 *  - hardware state check, because above;
+		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
+		 */
+		goto skip_checks;
+	}
+
+	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
 		return;
 
 	if (curr->hardirqs_enabled) {
@@ -3720,6 +3749,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
 			    current->curr_chain_key);
 
+skip_checks:
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
 	curr->hardirq_enable_ip = ip;
@@ -3735,7 +3765,15 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
-	if (unlikely(!debug_locks || curr->lockdep_recursion))
+	if (unlikely(!debug_locks))
+		return;
+
+	/*
+	 * Matching lockdep_hardirqs_on(), allow NMIs in the middle of lockdep;
+	 * they will restore the software state. This ensures the software
+	 * state is consistent inside NMIs as well.
+	 */
+	if (unlikely(!in_nmi() && (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)))
 		return;
 
 	/*
