Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6E79D0
	for <linux-s390@vger.kernel.org>; Wed,  2 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881445; cv=none; b=kkaPi4hOZaB/VVjF/CFLzY8NjDit4Nv4xrgBB2CSFKhQpv8cVe/HkX1KRTqx/Lv6sDCTghqie9JJEvw5tfTrpVUalw2AlqbW9zd/smzpS+epIGhEF76UfMohGqw8qxMWfTcVwSwZvd8/9jXG/2M5dM6ZQzqKYn+yeLJb470AtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881445; c=relaxed/simple;
	bh=lEgBy/6Tl2+mIg/szUca7enHsJ6t1zZRiLyTNp98rXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxurnQD0BkmOY2e5hS+rQgErExj1+mj5eX0OkvhbBg2TgbfrMcL+G5KHn5tH/QOYud9VmKNaVwHY/AI9cZK/qum/xOPnyirITL94iygAeQYEkGiDXjzFVKunZocRG2Qe4gOeVcypFJxOUsee4SzgLVcspa5+/Qk3XTtn7tVCcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:80d:3d68:c8fe:1932])
	by albert.telenet-ops.be with cmsmtp
	id KT3z2D00V4Qoffy06T3zu0; Wed, 02 Oct 2024 17:04:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sw0tL-00180F-9h;
	Wed, 02 Oct 2024 17:03:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sw0tT-005oa1-H8;
	Wed, 02 Oct 2024 17:03:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend2] locking/spinlocks: Make __raw_* lock ops static
Date: Wed,  2 Oct 2024 17:03:55 +0200
Message-Id: <7201d7fb408375c6c4df541270d787b1b4a32354.1727879348.git.geert+renesas@glider.be>
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
index 438c6086d540ecc4..7685defd7c5262e4 100644
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

