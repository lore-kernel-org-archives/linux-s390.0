Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37E3F411E
	for <linux-s390@vger.kernel.org>; Fri,  5 Jun 2026 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638106; cv=none; b=jSXV+2dGWvdJzYexUPb+1actObSAvZwE7ZXn+z0Z8wIJdwxT5sm3AHJ4tIkwl9tk+soTe8CkQdKGM/lRJ96vCgkzw/JjR92AAJYosMjSQQv9+nyBFjeIrI+BlfvRmDk/iyAFso9yUmuVVzEY8aAQlNybTkZq9zycTdJSq97xx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638106; c=relaxed/simple;
	bh=VxbsBjHdRvXTR0KV6QwpQV6PvkcezsCcgEhIoL++T/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGW7HFZwMWwn+X4JxXeb7YdPWREffxHq0jrlrJNQ6QjlmqQLp1bc7RguB8FuLgNQOuYuGZ3n45ttC4+1tcrFYZzrneXpz3iZDvQ93Q3tr1+6saM+veci063n/j7520Kx6wJiwkwKcSGOkm08Y4rbkBmc2XyVFVpCr2EiOjOCfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4o6W8mD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4o6W8mD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E13F1F008A4;
	Fri,  5 Jun 2026 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638104;
	bh=rQENKqT9pyTIBLJdn4Wt5SoRtkTc7Vr1VCzymuIIqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H4o6W8mDH+lyp47obeZup9tDtWjCkHfHpNPIbQScK/JR9ykMnaVHTyVGFEcLwM7R1
	 MZIkApDHhYEQgbvYMdmmmxI45Jy/cutam+IYnQw2T8CUtCHA08l5bYvViGcPDxAu5Q
	 B9waOL5obx9U+ZM7On8lh09Dv+MlWaLX6m+CYl9H6xxaZmSchYM3N/H4Zz+2MXApv9
	 JU2Qs3b+wr9qnmWT49sS2sbur8zbRDkuKiFEyRb6bicANv8y4sXydiSqIye1N0nmbH
	 4+5pFNITC4FRdGCzbaI1DtAShK4Cg2nFjb3jMKZt34xP7OB32X6wbav+iLhbdx2Vw9
	 1d60d69FGxXOA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 641FEF40072;
	Fri,  5 Jun 2026 01:41:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 01:41:42 -0400
X-ME-Sender: <xms:lmEias6sa1xX0LQqxf935Czyn7HwVyr0VYxk2s3kWeKzUM3PHJJF6A>
    <xme:lmEianDVOWtbD32caQYbgZRmOJNHT6PdKQK_jw36J_8hTt94Hd30NCO9R3M_lAzph
    o-YdoLU7N9RMP_5l9MrYBQQSGll0sVc-QsJgXhDtKpI1PkvXKnI0w>
X-ME-Received: <xmr:lmEiakXzxhTvNMKrKVwCDPLzWMKGN94jNWmKYn02qDgDfFqEyanuPKgcM0I>
X-ME-Proxy-Cause: dmFkZTFCwYGExB8+n21rrRlgZz2BZEPfw3mIE0bRNe76RMQAdH8f2KDaPLT52qZo7gxyWp
    0wXQACdPWdspv4jN5UYFCpihH+vrJtJ5nM33JJDnQyPnqbA42Pv6gENFpmiA7vDUbZDCAC
    N+ZmE7MklGAiGBNJA045y18Z9khhPwbxKZPuahNIwIz69+nOH0m/THs5eb4pu9rOFYQQI9
    b1h3voWmc5QUasjwQpRDRo+W3jNrB4TeCrmSTmM73SZRB0LYstjQaA4JitE82TBWNXKOy5
    NeQugQn5+UA17tSJ+MYIgsz9Sw+H8LaFdylvI7Cq2OhiaEqC4YLyUJJOJm9vOjE+2O1NIb
    ifGBvOfA1bRvdD1rzC6dalPswwrstFlyf7Pap/tukclD4RSnOep05M0BoiV6vs7Bgu2EkN
    p72ke8BUte3XkipOs/+CKWn/TsXg6p4p138xCLDsao5vi8Ksw7pMG7tzPlOYBuOqdg6z8c
    MidLD+dCzBqmfkLMsHdOHLfs1Pt53AU/mth+xQxJ6Wnq5W1rjhMKkcb5wW6tQdd0P7matz
    OCENDIVnfvIMJ8TC4oMgg+jtzeGeX2yW4wFkT7CuUw7nTNzjxH9wZghvZaZUbOwF7xfC59
    Af1ZSoVdz9AYOcDTSgfAw9IS9LKJ+IE4V38tIidtjIBck5rDsCz/vk+vM9iQ
X-ME-Proxy: <xmx:lmEiajyG_ECODsknMZaiWeI6lB4RM-vHCwzS-PLCp6k5bCe6EXIhlA>
    <xmx:lmEianhqhWew4_M-RbHKXbUo9j7BJ6hB77uaIa51Ix-nkG3kmlephA>
    <xmx:lmEiajnjrfVmMD59vAD_hOpEb1wCKtBMQwa4E2GJxkCuwW2EC6mW1Q>
    <xmx:lmEiarKWbhlo4-3nQzXarPfEw3SXJQgaSWdfTsOLyo6L81tykc9_ww>
    <xmx:lmEiakClBCsQNUnsD-35n_uhF0mJr-eTEXof0sHzFm3oZii2Z8rIPQfZ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:41 -0400 (EDT)
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 06/13] irq: Add KUnit test for refcounted interrupt enable/disable
Date: Thu,  4 Jun 2026 22:41:21 -0700
Message-ID: <20260605054128.5925-7-boqun@kernel.org>
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

From: Lyude Paul <lyude@redhat.com>

While making changes to the refcounted interrupt patch series, at some
point on my local branch I broke something and ended up writing some kunit
tests for testing refcounted interrupts as a result. So, let's include
these tests now that we have refcounted interrupts.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-7-lyude@redhat.com
---
 kernel/irq/Makefile                  |   1 +
 kernel/irq/refcount_interrupt_test.c | 109 +++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 kernel/irq/refcount_interrupt_test.c

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 86a2e5ae08f9..44c4d6fc502a 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SMP) += affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
 obj-$(CONFIG_IRQ_KUNIT_TEST) += irq_test.o
+obj-$(CONFIG_KUNIT) += refcount_interrupt_test.o
diff --git a/kernel/irq/refcount_interrupt_test.c b/kernel/irq/refcount_interrupt_test.c
new file mode 100644
index 000000000000..b4f224595f26
--- /dev/null
+++ b/kernel/irq/refcount_interrupt_test.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for refcounted interrupt enable/disables.
+ */
+
+#include <kunit/test.h>
+#include <linux/interrupt_rc.h>
+
+#define TEST_IRQ_ON() KUNIT_EXPECT_FALSE(test, irqs_disabled())
+#define TEST_IRQ_OFF() KUNIT_EXPECT_TRUE(test, irqs_disabled())
+
+/* ===== Test cases ===== */
+static void test_single_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+}
+
+static void test_nested_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static void test_multiple_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static void test_irq_save(struct kunit *test)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_irq_restore(flags);
+	TEST_IRQ_ON();
+
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_irq_save(flags);
+	TEST_IRQ_OFF();
+	local_irq_restore(flags);
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_single_irq_change),
+	KUNIT_CASE(test_nested_irq_change),
+	KUNIT_CASE(test_multiple_irq_change),
+	KUNIT_CASE(test_irq_save),
+	{},
+};
+
+/* (init and exit are the same */
+static int test_init(struct kunit *test)
+{
+	TEST_IRQ_ON();
+
+	return 0;
+}
+
+static void test_exit(struct kunit *test)
+{
+	TEST_IRQ_ON();
+}
+
+static struct kunit_suite refcount_interrupt_test_suite = {
+	.name = "refcount_interrupt",
+	.test_cases = test_cases,
+	.init = test_init,
+	.exit = test_exit,
+};
+
+kunit_test_suite(refcount_interrupt_test_suite);
+MODULE_AUTHOR("Lyude Paul <lyude@redhat.com>");
+MODULE_DESCRIPTION("Refcounted interrupt unit test suite");
+MODULE_LICENSE("GPL");
-- 
2.51.0

