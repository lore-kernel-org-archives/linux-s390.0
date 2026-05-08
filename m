Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AF330307;
	Fri,  8 May 2026 04:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214081; cv=none; b=tesQ0+4DTK3AEhdIgNa172ZWAQOPKR3uZerBJp1rmmSwSFXQtXNXt3e44Q8F20j5xI2DaXQSZW3mxx00vO9hRbo2B1b57d8Hn0fzHxfgFfp77VEosw1IAKEaiTvCWoD+eshbw4EFtCacftdZMDdyi+EtedtMaum6W1XiROqH+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214081; c=relaxed/simple;
	bh=gO6akd18GymDMzEWygQZBYKDPIfd+mlj7730dFu+2pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDJtrLrtTulDgPP02hP6Qwdd4iZHdCMdVTVYu01as54LwWeSxanZ6QX1nAfHd7pKwx5rQgDilmObFnDN9wZck6gHREsYNWB/C9pRYoi2c9Cm7ngw1Q7Ay/oIpbe4iEa9SpSSnhD16hE+h8f0QCFjbY/VXWakDfBcyUMLcwslhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L857BEID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L857BEID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D908EC4AF09;
	Fri,  8 May 2026 04:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214081;
	bh=gO6akd18GymDMzEWygQZBYKDPIfd+mlj7730dFu+2pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L857BEIDk3l8+nFdl8zDlgnwrBHdPxcykm6OfVhlFd2/dPVWRnMMB3OrNhPMhtklx
	 VpYBN97ebtX6l84zH0H60iuoQY9zeqamXLEpOHhzZYihO8Zfkb6VwoLaFx6HiJUi5F
	 trsnjzfTBGmUbpR41fsbHhpUyp3gBaPpwA0Rm3rK5zJxUGV48EGr5vf8ADgUZtUnkE
	 AsgoW+42AlrbayKQ3QQyDOPKf/AxQ2LUx9QlUklCivC2DRzrYdOXIcNSzR71Ak0jcF
	 l1cs9ARB6q8fIpG1Rk6gfB2G5LIiUSt0ee9hVdm8yOx2FWf+Kfge5/eUla7n5uvEiv
	 gR+Mebcrjk4yQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2F415F40076;
	Fri,  8 May 2026 00:21:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 00:21:19 -0400
X-ME-Sender: <xms:v2T9ab3MgLwxly3bKc4mH88cek34N8JpRBscWm557UMwh8C-0B1bYw>
    <xme:v2T9adGwoxkUEBzoKIveMiQY4kqpxhdS8Fck0biE6IjIQJHmE9FBjkfGBlnDmnZz8
    8lWZ5HA-EIqrrwQX6Pd5Phnycj9QaqJtJgfAlFf1YnfWbcBcg>
X-ME-Received: <xmr:v2T9aXgRPhYSA8MVPUah3j_zcwIiZ3hx8e9z9bU9hgUk8-HZVCMyU3LKo35mjzHFz8fh8MbA67FhNnqkVjf0hSmtIVuUD0SF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekieffgeevhefgudffveffheettdfgkeeilefhhfduhedugedvhedtteegvdeugfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghsse
    hsohhuthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghn
    shhsohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:v2T9afjKhqlwwuUI4t6g555Uu_gzlScQGHOIbqsPSsHyP6ljDeTZ8A>
    <xmx:v2T9acKKgdgTwbGCiFPQ3qWZAv5EbQh2mYakZLyFE5IKPZgIU-4wjA>
    <xmx:v2T9aTMtPDp8hIusItRZdLQlu8A-zpFegYw-mItq-5kC87b9Eq-REA>
    <xmx:v2T9aUtZdBDuoeV9fr9JfBj3_TvQM-9JLBMSWnbgyITVh7XM_fh9YQ>
    <xmx:v2T9abFzR2W0NQkxmtFdneEhpH9UqGC7NYuVjmgkyf34BPJ7amvM71lu>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:17 -0400 (EDT)
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
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,	Joel Fernandes <joelaf@google.com>
Subject: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU counter
Date: Thu,  7 May 2026 21:21:02 -0700
Message-ID: <20260508042111.24358-3-boqun@kernel.org>
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
allowing those bits to be repurposed for other uses.  This also has the benefit
of tracking more than 16-levels deep if there is ever a need.

Reduce multiple bits in preempt_count for NMI tracking. Reduce NMI_BITS
from 3 to 1, using it only to detect if we're in an NMI.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
---
 include/linux/hardirq.h | 16 ++++++++++++----
 include/linux/preempt.h | 13 +++++++++----
 kernel/softirq.c        |  2 ++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06..cc06bda52c3e 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -10,6 +10,8 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
+DECLARE_PER_CPU(unsigned int, nmi_nesting);
+
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
@@ -102,14 +104,16 @@ void irq_exit_rcu(void);
  */
 
 /*
- * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
  */
 #define __nmi_enter()						\
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		BUG_ON(in_nmi() == NMI_MASK);			\
-		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
+		__this_cpu_inc(nmi_nesting);			\
+		__preempt_count_add(HARDIRQ_OFFSET);		\
+		preempt_count_set(preempt_count() | NMI_MASK);	\
 	} while (0)
 
 #define nmi_enter()						\
@@ -124,8 +128,12 @@ void irq_exit_rcu(void);
 
 #define __nmi_exit()						\
 	do {							\
+		unsigned int nesting;				\
 		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(HARDIRQ_OFFSET);		\
+		nesting = __this_cpu_dec_return(nmi_nesting);	\
+		if (!nesting)					\
+			__preempt_count_sub(NMI_OFFSET);	\
 		arch_nmi_exit();				\
 		lockdep_on();					\
 	} while (0)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index f07e7f37f3ca..e2d3079d3f5f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -18,6 +18,8 @@
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
  * - bits 16-23 are the hardirq disable count (max # of hardirq disable: 256)
+ * - bits 24-27 are the hardirq count (max # of hardirqs: 16)
+ * - bit 28 is the NMI flag (no nesting count, tracked separately)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -25,18 +27,21 @@
  * there are a few palaeontologic drivers which reenable interrupts in
  * the handler, so we need more than one bit here.
  *
+ * NMI nesting depth is tracked in a separate per-CPU variable
+ * (nmi_nesting) to save bits in preempt_count.
+ *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  * HARDIRQ_DISABLE_MASK:	0x00ff0000
- *         HARDIRQ_MASK:	0x07000000
- *             NMI_MASK:	0x38000000
+ *         HARDIRQ_MASK:	0x0f000000
+ *             NMI_MASK:	0x10000000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_DISABLE_BITS	8
-#define HARDIRQ_BITS	3
-#define NMI_BITS	3
+#define HARDIRQ_BITS	4
+#define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4425d8dce44b..10af5ed859e7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(unsigned int, nmi_nesting);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *
-- 
2.50.1 (Apple Git-155)

