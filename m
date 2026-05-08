Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97D332ED0;
	Fri,  8 May 2026 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214090; cv=none; b=Y3Nkg5JBrLSQJhbk6vXSRKWlkntmF4Ye1iazKCvfxb0kpdHJ08CGLF1JVs1woY2iF0AoldCo7OMGqmFDM+qurnme8g3cQAZLBo5YfAoKUX7DgFDKCE0YJc/mp3YSEASzdEpMUf9J8nkWZsc3qu4e2ux28tgfc0QvUc8HYUE4PIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214090; c=relaxed/simple;
	bh=ojydZY/xJWBLbjMhhVliboBMhbb87iswhHxUUdAbCJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0wImnGej4t8fyAOLNyrRu7KKLLw9YY0I9DKKb5/6A9FDxIWHh92dmZhkjZJA56y5FfpRh6vy2BJ2zNxVRm3WVlltmgm9FB8HJbVTdhGyqz9MZa39qlanDHN8zEyOTGuYYLxDQcPyH+TOzuop2R/h+AJAL3b7l9QxBFfKju8BLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOkaErU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOkaErU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C5C2BCFA;
	Fri,  8 May 2026 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214090;
	bh=ojydZY/xJWBLbjMhhVliboBMhbb87iswhHxUUdAbCJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOkaErU8AV0MpuHlQuzrg70swUE3fHjl5bNbDdKMeiiQvj/8Y3M5h1Utc2y9q3r9G
	 Savo/hLn3uU6u3w4CLx9u55Nr9uCnGi4cuO13v9fi3qjket1uZ9y6mvslN1QE+30wW
	 aN/OFEGWcHQGNs1bCQnN32HYzGvSTVXnGZyxNX1DCCaygWK5VDSkHjUKQ4XAcURLq1
	 RCOqY33Ni5LHrbYCGppve/6XlZUNVYVhRyem5lwLjkxlRjzwdZYymrt+q9s44igfXQ
	 FT20x9XWGsm5ZQYsIB2CM72Qh5ntGnEg2gRkpB+g0l+oCURId7/CVBAWSDnolG6EO8
	 4QQz6o3H+Al2g==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D8A18F40076;
	Fri,  8 May 2026 00:21:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 00:21:28 -0400
X-ME-Sender: <xms:yGT9aX--gwYP_5kQn2Ao83tHMvQBh54Lc02c86WGybSBXKkJhV0b6A>
    <xme:yGT9aZn1l-L1z42Zk0Mww1BIgAuX-Td7yZ7YIt3L2jbHUL5ekFDx-e2DFroCiXP04
    65uprEzS-Y71FWi-ZjbtjRBpPSkGIzuBIgsIfYMo2JHEcSy-jY>
X-ME-Received: <xmr:yGT9aXcoL7TILxBE10Yf07NJ9oHRhFqFG1M7AHMIRZsMvQs49KBgTONLvUT69GDFDq5Ki51yEuFPSJDgzfoJgOucFGwJ-IrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtfedugfeivddvfeegjeehleehvdfhhefhffeuleehtdevgfeggefgheduuedtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeehiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmh
    grrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhonhgrshesshhouhhthhhpohhlvgdrshgvpdhrtghpthhtoh
    epshhtvghfrghnrdhkrhhishhtihgrnhhsshhonhesshgruhhnrghlrghhthhirdhfihdp
    rhgtphhtthhopehshhhorhhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehhtggrse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdr
    tghomhdprhgtphhtthhopegrghhorhguvggvvheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:yGT9aUnqd89fNuG4-B2RzsGa13wlMFWtSpErXajVKo-J_Q0SMeEEgg>
    <xmx:yGT9acikR84neMseXY7pjuWjfkVmKNU13iw3Sonr8f53BS8bEU8jaw>
    <xmx:yGT9aSlucn6SriOOjfS9uKZtixIFYPPOe7_JTfi0yG8iaCwqUB6nBg>
    <xmx:yGT9adG1345W2gBQ6_lCRbdGplAVYJdXexe2U1n_xIJ2XtmcWnaT3w>
    <xmx:yGT9aYIMaTH3MwOUbe3l-pw0H05hIpAyEYe6l3Ytxrv1pVBvySeAu_y->
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:28 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>,	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org
Subject: [PATCH 08/11] sched: Remove the unused preempt_offset parameter of __cant_sleep()
Date: Thu,  7 May 2026 21:21:08 -0700
Message-ID: <20260508042111.24358-9-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508042111.24358-1-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The preempt_offset is always 0 in all the callsites of __cant_sleep(),
hence remove it. It also allows us to clear the code a bit by stopping
using a "preempt_count() > .." comparison.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 include/linux/kernel.h | 4 ++--
 kernel/sched/core.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5570a16cbb1..24414c79e59a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -72,7 +72,7 @@ extern int dynamic_might_resched(void);
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_sleep(const char *file, int line);
 extern void __cant_migrate(const char *file, int line);
 
 /**
@@ -95,7 +95,7 @@ extern void __cant_migrate(const char *file, int line);
  * this macro will print a stack trace if it is executed with preemption enabled
  */
 # define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+	do { __cant_sleep(__FILE__, __LINE__); } while (0)
 # define sched_annotate_sleep()	(current->task_state_change = 0)
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..75dba7cc09bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9165,7 +9165,7 @@ void __might_resched(const char *file, int line, unsigned int offsets)
 }
 EXPORT_SYMBOL(__might_resched);
 
-void __cant_sleep(const char *file, int line, int preempt_offset)
+void __cant_sleep(const char *file, int line)
 {
 	static unsigned long prev_jiffy;
 
@@ -9175,7 +9175,7 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
 		return;
 
-	if (preempt_count() > preempt_offset)
+	if (preempt_count())
 		return;
 
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-- 
2.50.1 (Apple Git-155)

