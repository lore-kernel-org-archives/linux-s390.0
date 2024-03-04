Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E85374E6
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549791; cv=none; b=FC/7n+Zpqx+qNvvZxexV3FBfffOqg0F7iEjxWhD1vZfKaavVIkVwEthht0GdafZIaUZGtOh/Gk2OSKsIifWXzqIP7vYR5Z0VU2zi/qUnDwWiPzPT1DHTFewLrH+rQj53xMey2BAGlD64Pc5GSDOd5CNpHuXTGCfwSycb860oUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549791; c=relaxed/simple;
	bh=J0ys2nCMeqQznpcv3TvixEojj3WOQhbihu0iZmOz7CM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgyM9epd98bd3lHNxmfMs9Vm8bH04+WwE6/gplwX9KNB6oeOUW2HltaIjlNZgL5VN2Db2CJCciXpYM9yX0qGZZlU+qcRjmCa1HY1nUlCsD8CwSD0JJ55U3tIyP4afkca8kqCNwnjlYlhm4j7vVA9zWXgvS1slHpBVFkjfUbz/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2716:1247:52e8:4f90])
	by albert.telenet-ops.be with bizsmtp
	id uawR2B0022qflky06awRS0; Mon, 04 Mar 2024 11:56:27 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rh5zR-002I7A-8W;
	Mon, 04 Mar 2024 11:56:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rh5zc-007bnl-UC;
	Mon, 04 Mar 2024 11:56:24 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] locking/spinlocks: Make __raw_* lock ops static
Date: Mon,  4 Mar 2024 11:56:20 +0100
Message-Id: <78c366485bff13753de758fd27fb6b465ed2850a.1709549641.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_GENERIC_LOCKBREAK=y and CONFIG_DEBUG_LOCK_ALLOC=n
(e.g. sh/sdk7786_defconfig):

    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_spin_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_spin_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_spin_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_spin_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_read_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_read_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_read_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_read_lock_bh' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:68:17: warning: no previous prototype for '__raw_write_lock' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:80:26: warning: no previous prototype for '__raw_write_lock_irqsave' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:98:17: warning: no previous prototype for '__raw_write_lock_irq' [-Wmissing-prototypes]
    kernel/locking/spinlock.c:103:17: warning: no previous prototype for '__raw_write_lock_bh' [-Wmissing-prototypes]

All __raw_* lock ops are internal functions without external callers.
Hence fix this by making them static.

Note that if CONFIG_GENERIC_LOCKBREAK=y, no lock ops are inlined, as all
of CONFIG_INLINE_*_LOCK* depend on !GENERIC_LOCKBREAK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Waiman Long <longman@redhat.com>
---
Compile-tested on all defconfigs that have CONFIG_GENERIC_LOCKBREAK=y:
  - sh/sdk7786_defconfig,
  - sh/shx3_defconfig,
  - s390/debug_defconfig,
and also on s390/debug_defconfig after changing:
    CONFIG_DEBUG_LOCK_ALLOC=n
    CONFIG_DEBUG_WW_MUTEX_SLOWPATH=n
    CONFIG_LOCK_STAT=n
    CONFIG_PROVE_LOCKING=n

v2:
  - Add Acked-by,
  - Drop RFC,
  - Improve patch description.
---
 kernel/locking/spinlock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5ad2..7009b568e6255d64 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -65,7 +65,7 @@ EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
  * towards that other CPU that it should break the lock ASAP.
  */
 #define BUILD_LOCK_OPS(op, locktype)					\
-void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
+static void __lockfunc __raw_##op##_lock(locktype##_t *lock)		\
 {									\
 	for (;;) {							\
 		preempt_disable();					\
@@ -77,7 +77,7 @@ void __lockfunc __raw_##op##_lock(locktype##_t *lock)			\
 	}								\
 }									\
 									\
-unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
+static unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock) \
 {									\
 	unsigned long flags;						\
 									\
@@ -95,12 +95,12 @@ unsigned long __lockfunc __raw_##op##_lock_irqsave(locktype##_t *lock)	\
 	return flags;							\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_irq(locktype##_t *lock)	\
 {									\
 	_raw_##op##_lock_irqsave(lock);					\
 }									\
 									\
-void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
+static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
 {									\
 	unsigned long flags;						\
 									\
-- 
2.34.1

