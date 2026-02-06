Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F0212542;
	Fri,  6 Feb 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387841; cv=none; b=dMikEO7Tm4fgKGiQBdnwUBkArJGpiLFiUWQdqSjVkbuJ5HmQJ0NOr/qJ8VnhudjActyZkyBSkbOnhvK7NKew3JRAQy0IiupIScie531UGqfZ91VB2Okfq2FaLC0cKUSZVhsmZ80j9aGYkm1O3xlBsZHPGkjyyZMy6kCBTf2QvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387841; c=relaxed/simple;
	bh=Do+hwWPxjZYbNWyybj7BAgIt5vnOwzvEtgVy4FMIXwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu0V6TSQ3IpmIgByPJisjs2G0SLAM6o7O4gV9gtodISsohfOnapRovh2iS+vCpcukw4uaVBWMkDB3e0W4D2t9ZB3uvTomlRVBC7ZCOOY/AXDoSLJ9bM/hl3m1mrijgF6MWX++sSSAx6WGDDpIEJ7+cZp/VBSetsiw9i91vKi3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNCOcSTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNCOcSTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C84C19424;
	Fri,  6 Feb 2026 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387841;
	bh=Do+hwWPxjZYbNWyybj7BAgIt5vnOwzvEtgVy4FMIXwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNCOcSTUpyOl9Q4mQMbIw/URy1l4D0S4asdOyftfsDcewue8Dao7li7nylw6jdcwE
	 5xcCiyjI3UiF0TauFM9tLjJ8X4dezh3KXpax440RTfP2Ql0TwnHiTyko6XU/bojUvv
	 sZme44B3wIxiPO5Konropk5kzhzrEJrsDg19F4SG4dMN9FqNlYgMtRFZ7sPQ4GZuum
	 GwLqscapKQe5/ksPhSAwloBYLxXkckaoYnECQws7iJQYpvxbnyf/1LOy58zv7lUvmI
	 2qoQ3CyzqCo7aEPiDlZx6WHpY6T2bdtoHv3tqUL6o4SEHwUMgwS/fDuTASEFBuahwR
	 tdeMxn8n7tTnw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 08/15] tick/sched: Remove nohz disabled special case in cputime fetch
Date: Fri,  6 Feb 2026 15:22:38 +0100
Message-ID: <20260206142245.58987-9-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260206142245.58987-1-frederic@kernel.org>
References: <20260206142245.58987-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even when nohz is not runtime enabled, the dynticks idle cputime
accounting can run and the common idle cputime accessors are still
relevant.

Remove the nohz disabled special case accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81c619bf662c..2b58cdc326c3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -792,9 +792,6 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 	ktime_t now, idle;
 	unsigned int seq;
 
-	if (!tick_nohz_active)
-		return -1;
-
 	now = ktime_get();
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
@@ -835,7 +832,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -859,7 +856,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
-- 
2.51.1

