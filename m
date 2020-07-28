Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Jul 2020 08:50:29 -0000
From: "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/header] lockdep: Move list.h inclusion into lockdep.h
In-Reply-To: <20200716063649.GA23065@gondor.apana.org.au>
References: <20200716063649.GA23065@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159592622946.4006.7922093273246703940.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/header branch of tip:

Commit-ID:     e885d5d94793ef342e49d55672baabbc16e32bb1
Gitweb:        https://git.kernel.org/tip/e885d5d94793ef342e49d55672baabbc16e32bb1
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Thu, 16 Jul 2020 16:36:50 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jul 2020 10:45:46 +02:00

lockdep: Move list.h inclusion into lockdep.h

Currently lockdep_types.h includes list.h without actually using any
of its macros or functions.  All it needs are the type definitions
which were moved into types.h long ago.  This potentially causes
inclusion loops because both are included by many core header
files.

This patch moves the list.h inclusion into lockdep.h.  Note that
we could probably remove it completely but that could potentially
result in compile failures should any end users not include list.h
directly and also be unlucky enough to not get list.h via some other
header file.

Reported-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Petr Mladek <pmladek@suse.com>
Link: https://lkml.kernel.org/r/20200716063649.GA23065@gondor.apana.org.au
---
 include/linux/lockdep.h       | 1 +
 include/linux/lockdep_types.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 3b73cf8..b1ad5c0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -21,6 +21,7 @@ extern int lock_stat;
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
+#include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 7b93506..bb35b44 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -32,8 +32,6 @@ enum lockdep_wait_type {
 
 #ifdef CONFIG_LOCKDEP
 
-#include <linux/list.h>
-
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
