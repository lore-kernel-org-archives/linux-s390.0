Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F873FE37C
	for <linux-s390@vger.kernel.org>; Fri,  5 Jun 2026 05:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638101; cv=none; b=q33Uhf8Pi/BCxrDm0oE0WVmrlHgPfugAD45eczaf8G/NUUKhGbcK+/Mdm01q1zyUqogjKEiPnmDJ6CEub54Ll/jeA7N4mi8VvT7GAuDXydj9dskawfYeSddHfRmR2gbsRaIn7hPHfx5VuNUpArELpFW0Q49rdicS6qYSO+W7AbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638101; c=relaxed/simple;
	bh=VsHssmG4iLDQg0XELCmXp+HbJFOZQrjGWZwsM0sxDDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8WuKUiZGBtwh6yQk+9sBg3ueMMtQagcOLvXjRPhwRs8swXoHC4/pZ6kmuujpwub+1p1Rkin7u4kMIXpuM7Cn6504LHAKfkDc9V8cG+Z/t5M50SCdbtq9uPfmDIBC5tGC0eiOuCRlS3SA/z7L2/UqUPqjgzgj+w/MOHdxRmKGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0AvAI0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0AvAI0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17E01F0089E;
	Fri,  5 Jun 2026 05:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638098;
	bh=/DGq2VclRBHsAUIaHXCPJUpfdhEM7VNlnnsEfM8ae3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0AvAI0je5HFbIxwVACgj35f4RdZer0MXZ/UIHzfG1jAyoAvLihR0O9/m+zYkJYyo
	 zlpKXNDLb6LaXMR3apTHwQh7DTu/Qc3jW+NI29dqJ86Vx5Xx3g2T6nHhw5vYs9DRUh
	 bAaoZ87s/ynM2A0QXo1YAWbQg+wjLlJhF7VXil5+bpQ9LK6qFhlcxgRKSuX8blATZC
	 cOVbxddynzeCA9mZjV49ACv2cmzwC2DJLc+YbTWFurPby5/iWnCd73B+cUCORDAcUE
	 /uiHka4A9jjgh7SmcKQn+QyGkW0WQ/QYX8GmGsDaA/E2JFT57xcokBw2QVnpSQSUq7
	 zT0/If1WTvy7Q==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 27096F40078;
	Fri,  5 Jun 2026 01:41:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Jun 2026 01:41:36 -0400
X-ME-Sender: <xms:kGEiat_QIYi_NvEuySR6sO393d15cNkX5K2FyeGvYQrEVCFfYkAJzA>
    <xme:kGEiao-1ewkmW4P4Vdnu9Rimby4BeP9kSB92VY-fZ1BwVVadI1amYKBD9DcldBgxs
    Lru50N2bBykHQkxaAUsv3EqVnHc-L2aKaOcf8xAIAgnF4J6lHnyQg>
X-ME-Received: <xmr:kGEiaqiM_ryLoIsu3VsYFoNcDfBT553O6l-IKs9BEWRG_UqmssXCbdaYApc>
X-ME-Proxy-Cause: dmFkZTFhOfDTFTb8fH37X+ASfp2vsHy1Fqb2Lywq6X3h5fMlxk7wW33nxe7aSTekseFO11
    xBiB7Md3Dfg950zHftACRl4BCrZIGkOLORwuU667qK/t4b7uPTnvvrgSwCuAred6lniidQ
    x6+o43dstQnrbqqi/v6Nl3jrEdQj/OnTFIkpkf7j4tfd81Pm1F4hDhUzK5vMKXR0zokP4K
    KZGWpXQjfkPb9q0v8LW9bszX8CgnIWJLXLSKFiZe/Ul+6TINXLg1BnxiItQp/bB4zXvV+6
    Qcp88FhWc5Q0N1TQTHx/VoF2pZ7nT3Uyapa4Doti8umM92UFgjuSWC48vH+lnu7P/MqXtO
    1x7/NWjqOpmZJG2oWYOrLpGPqVyo+okymTgf44j8sFEdWMojKiseEGVjpZUelIIeOS9o8E
    HdWyH8Xufbs1TTRzWZRr1qJr/SNNelAtATCOTjox8ShD9mKRQ0u6c+b8rbSLel/LZID4n5
    nKR7RaEb4K4FBscijWIxu+5c6cSlGa00JCIjG8oTYmaxKXfsUjn4MkrdC75vOYqwMvtM4/
    RtBWb6Crse49u4woUwI7sMvScGA4raR5d6KZ1LjCgAWQE725NkNeNtG/3PBOa2bR4KmLAv
    ir2FrfQ+geGHbWvA1TRaFPHsUQ3H8ZhEYlm4yLkAWTs8rm1vumFN2owWXa9Q
X-ME-Proxy: <xmx:kGEiaqlbApKBOnd_WcIRs8b7QDMmnWx6TRb4gE6U_PMMPGWO4pGnwg>
    <xmx:kGEial1Xb2_jnsJ2j1Q2bJ75IfiTRzFT_Tu6Z3iGoBM0tgGwzcz5kQ>
    <xmx:kGEianv3wqfN-rQy1K7vDyOSln410SoYGPT9VVMrwT4O4bLX5nq01Q>
    <xmx:kGEiagVYogJar1dgtgPjp6v2GsPuKyuUCTEHzebtP0doOYSJCleYEw>
    <xmx:kGEiagsRP9jtPVVe7bS0WF8r6L7a-zXrTOmI5VWQ9zbXC2Jn_Xw7JaTC>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:35 -0400 (EDT)
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
	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v3 02/13] preempt: Introduce HARDIRQ_DISABLE_BITS
Date: Thu,  4 Jun 2026 22:41:17 -0700
Message-ID: <20260605054128.5925-3-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605054128.5925-1-boqun@kernel.org>
References: <20260605054128.5925-1-boqun@kernel.org>
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
2.51.0

