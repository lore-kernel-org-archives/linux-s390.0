Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB53112BA;
	Tue, 26 May 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808922; cv=none; b=FX5SmbdcJlvJQxv+rRE2xy/Y5G3P3F3W2yb/hD2DScEF+RZocRsM1DYEN3HIBzz/oI3nM90Vvp+o67p71YVPjjWS/xjajwbYi6qiIXqq9v0Sfjr7+k/vnKAJQLbFkSO1szIRj1+JsRyl9fBY5PZ7gwLWNh2yPefWmeQsZ7uzh/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808922; c=relaxed/simple;
	bh=KDUPVVy4LWT4qXP3JW3S0BPesciZhFvkvvRNGKBgiVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR+krMzhTo/ktwZTK5psKNrdAnqcyOYa8Y2YmrDt1maBdrjr1GP9/d9w/AVcIhmlFcteW6ahTWX7VaBad4QA0eArRlZ49MpCxkI8tQGdc0h3s6GTiCIQqxIqn8SeLrsz24QFtUkLKF2HiaOUIgeDOCFcKDMu4tsLo5Tihdw/CGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AohFGsNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AohFGsNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09D91F00ADE;
	Tue, 26 May 2026 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808920;
	bh=GSGWcrbKUqYCp9pV6zjmEzU+OdWTYrfKAxnLgC4CsfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AohFGsNbNkhpAJCkx73CLE7JB9mRHjnLrMQkv5wzIccjEhuQ4DOXxoZSoOido6obw
	 09nPCjsGF7+1wnCTfwXF/OdMfXfaQl94w/p4RJ3PzfGm5KWi/VZcklY3vu+DT/fEIn
	 pJGh1Sraa+qNe18MNy/zvN6ZgvUZuFMc7uk1qJXWFSWKimxQN2qq3AAS2RMo+qwuc/
	 v8jSkuW8vQeAReAm8empVzDz9YW4aSq934UqrExjZGqmqqstAwv6qcS3I6Cy3j/W87
	 OGODHN5caLE/ueWJ8W7S/sl5uPVKoasNr7JTC0kFLr9mRIB5N3trRl/AuhwcQLGgUn
	 ThQdqrVhx6BfQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3427BF4006B;
	Tue, 26 May 2026 11:21:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 11:21:58 -0400
X-ME-Sender: <xms:lroVaqFeNWnh8tL3TJJl2VqvkKpMwC68mOjivc3JrddrEwrMtB1gow>
    <xme:lroVajNnDDR-qG4FaA9lteWPHomxdnNkNb_7a-UZYhEeD1f841LWdOUSQBFOBab8T
    -mdw8sskflOqPMYjeotcgL767b2YabbfB35avbw1czXSvMMu2Qstw>
X-ME-Received: <xmr:lroVaqHbcg4UAMPjFhc_wiCOZbzQAdQlB74XUu2FkkLYvgcZSzCWCrakvaaW2udd1U4Sz0R3M9ho2uXVl5YIcXmXxucXYo6J>
X-ME-Proxy-Cause: dmFkZTGukvwILOOvmar/YpzpbGxcThya1huxzJh8wPsxZqy8c45YkWNCoU6I+5YwKn52tQ
    FimljOlgnke1vtXjpOlEIIzqmHsNns/ZJmR5LvOMJZ1ZAxr1Wodn13Yfg5DhdKPAFkkKdi
    S/I7TyNwTX0Y8RnSZ8QdIy1Jqo5XXbQ7RrhyzAa5WGdgm6MjwoUKqKh3Uy0nLCbaeSbo/A
    de7q+7hNeF+MaWmtgdzUE1cHx21KJc4LOZtluly95DY4Z5RWj4II3/QyKmUNnRJfzsX0RM
    0qJoKWNtX92mkNHkt//vUyp2c9tsMyTX+3jK+p4XRlCmImR6eKHhgKraqRzLlyyuiALLW5
    QFyFIqSAxJHnbrYToBKdzL82BpAr+8bWoD+3qMnuaWUYdSZfNxfvBAkYhp4C50O/cdPipd
    /RZAkYynwWdENbzrnJZi4S479MMLK+LnzHe5Gc+LMlj8nlCNK/9V7QR15JInfnpR1DiRQw
    GOEDzl5YSvOwpObus0rabT0wDZfJBPPw/ShrRKn1W9besTrVM9qgAhBUDsC8nQXWLeMIbW
    nPFpkcttnGqTjGBT39WBm2ftjItRCj42y27aPxOHssdvwgifRgCi/IzR1gzc6a6/844oUy
    wZ+qx5+E5tT9FEwMTk62Al/6uYHq1jX2IYD+F3NP5O1mOn+SSKb/haxtBKxQ
X-ME-Proxy: <xmx:lroVansIuj_YiZiHU-iGTuF5HKiwGNVQbVScNywpxO_jew1TtxSrOw>
    <xmx:lroVam8LIgHFvk7RerGv0LNQp-2e54rn9O9Pb3KVVVPUlK5BmeTeaw>
    <xmx:lroVajKODkcoLeKvpbgtQcIBqUisBHKq4R6dZ6q7-Tg5PnzXZInrWQ>
    <xmx:lroVaoCLTiZlWMS6nq_XZ-sLgwGD6pS2LlUnoTonRSXHy6S4hS_A_A>
    <xmx:lroVav4QT22XLfF9lysn3Dq-fJForxzPsfzsdk3BQJOKPohlkvlb9VjT>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:21:57 -0400 (EDT)
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
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 02/12] preempt: Introduce HARDIRQ_DISABLE_BITS
Date: Tue, 26 May 2026 08:21:38 -0700
Message-ID: <20260526152148.30514-3-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boqun Feng <boqun.feng@gmail.com>

In order to support preempt_disable()-like interrupt disabling, that is,
using part of preempt_count() to track interrupt disabling nested level,
change the preempt_count() layout to contain 8-bit HARDIRQ_DISABLE
count.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-2-lyude@redhat.com
---
 include/linux/preempt.h                        | 16 +++++++++++-----
 tools/testing/selftests/bpf/bpf_experimental.h |  5 ++++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 586f96688325..e2d3079d3f5f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,8 +17,9 @@
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
- * - bits 16-19 are the hardirq count (max # of hardirqs: 16)
- * - bit 20 is the NMI flag (no nesting count, tracked separately)
+ * - bits 16-23 are the hardirq disable count (max # of hardirq disable: 256)
+ * - bits 24-27 are the hardirq count (max # of hardirqs: 16)
+ * - bit 28 is the NMI flag (no nesting count, tracked separately)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -31,29 +32,34 @@
  *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
- *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00100000
+ * HARDIRQ_DISABLE_MASK:	0x00ff0000
+ *         HARDIRQ_MASK:	0x0f000000
+ *             NMI_MASK:	0x10000000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
+#define HARDIRQ_DISABLE_BITS	8
 #define HARDIRQ_BITS	4
 #define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_DISABLE_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_SHIFT	(HARDIRQ_DISABLE_SHIFT + HARDIRQ_DISABLE_BITS)
 #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_DISABLE_MASK	(__IRQ_MASK(HARDIRQ_DISABLE_BITS) << HARDIRQ_DISABLE_SHIFT)
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
 
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_DISABLE_OFFSET	(1UL << HARDIRQ_DISABLE_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 #define NMI_OFFSET	(1UL << NMI_SHIFT)
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2d4256ff471f..a811b080db02 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -448,17 +448,20 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
+#define HARDIRQ_DISABLE_BITS	8
 #define HARDIRQ_BITS	4
 #define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_DISABLE_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define HARDIRQ_SHIFT	(HARDIRQ_DISABLE_SHIFT + HARDIRQ_DISABLE_BITS)
 #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_DISABLE_MASK	(__IRQ_MASK(HARDIRQ_DISABLE_BITS) << HARDIRQ_DISABLE_SHIFT)
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
 
-- 
2.50.1 (Apple Git-155)

