Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbgFWIjZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 04:39:25 -0400
Message-ID: <20200623083721.155449112@infradead.org>
Date: Tue, 23 Jun 2020 10:36:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 1/8] lockdep: Prepare for NMI IRQ state tracking
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

There is no reason not to always, accurately, track IRQ state.

This change also makes IRQ state tracking ignore lockdep_off().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3646,7 +3646,16 @@ static void __trace_hardirqs_on_caller(v
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
@@ -3692,7 +3701,27 @@ void noinstr lockdep_hardirqs_on(unsigne
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
@@ -3720,6 +3749,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 	DEBUG_LOCKS_WARN_ON(current->hardirq_chain_key !=
 			    current->curr_chain_key);
 
+skip_checks:
 	/* we'll do an OFF -> ON transition: */
 	curr->hardirqs_enabled = 1;
 	curr->hardirq_enable_ip = ip;
@@ -3735,7 +3765,15 @@ void noinstr lockdep_hardirqs_off(unsign
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
