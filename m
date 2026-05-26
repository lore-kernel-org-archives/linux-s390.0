Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C92F8EA8;
	Tue, 26 May 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808920; cv=none; b=Qc91bhyjF9pNxAVTe2w+LX//aVnHyPc7wDHCHo4M3IQnOYje9J1FhTuwwi1sLAlwhg7Gl5SrHN8g3DCjY3PISsUptZpQ+6SNB1hR0DE2xHvuEeWBiDvErLSA8OJVBxhgq8/xi6ltmO204UqlNlKW9VuxI9Y/IpQXLg8Bd4IhgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808920; c=relaxed/simple;
	bh=ZZcoCYqC5P4cl36T3x7DTtYn9zd/1ViRAAoET77FP0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THCvDt+AGZ13jH6uh7MKl+/8fesVCo1FRPZXcgot+cgHAiLdV/UhcfYMDM15lue8//tJet4svMRPPDkj09bBaB9YDew3pxtR4LSG6VwZeJ+p9JrchER5JQ7YTfXajiib1RvK+4sjoq7JW7kjW5UOuhOVSQ+rcYVbyEGB9Uu2Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhOUsJRQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhOUsJRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070AC1F00A3F;
	Tue, 26 May 2026 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808918;
	bh=8PITXRc1leRyDxXPYqq5KCHe79cPpvenW+AiKvAxoPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NhOUsJRQmYVOCGdf63opsmvDp4dmwrRbSUKrFPhRRJJIqH+xh5oGe8qTAe9D+c1Y3
	 yEhpXqK7E6mOwB5M1xhK1r/3IeBZT922EDsqqkHWtp3aimuIrCJfyiY8r1VGfwbJcR
	 gTTvxQrGEYse0l347wgXkI/c3ifNcoIajkQToCCPQQtf7CvFEDOcbk+XLg8TCnX+/u
	 4nyThHY6b5Yq+64eKBxe8VwhJr4JyJUkMzfNXbsRug5RvytomnM4Eh6fh2micvNay9
	 /uyBeulZK/GHEIBT9XBPNgiceLoWN5oQYtVY42dTdlohgTssJKyp2t3w2m7V40puxg
	 XkO4o5OXihLNQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45105F40076;
	Tue, 26 May 2026 11:21:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 May 2026 11:21:56 -0400
X-ME-Sender: <xms:lLoVaojOjqaFsPVojpkODNhTMe5DtUNtit-EfHddZFnjvQvTjBRRMA>
    <xme:lLoValCaBKaRLZWBzWus_pDnHbKkmT8_1wpBQe4vkKUWXh9GwqfxLaj7G7VaaiQwL
    fccLaGS0rDSRVHr9dVXpH_uX5CyhpCL7c3cDTgq9-o4_4GB-cLZrQ>
X-ME-Received: <xmr:lLoVavLKenHnJom6K19NTjubsTirPKZSG3pSBcXDevWFydtBE2yGAcQXt087NOKrye4osiIvd8wEDDwK36eqW7kXkUCe_CBv>
X-ME-Proxy-Cause: dmFkZTGukvwILOOvmar/YpzpbGxcThya1huxzJh8wPsxZqy8c45YkWNCoU6I+5YwKn52tQ
    FimljOlgnke1vtXjpOlEIIzqmHsNns/ZJmR5LvOMJZ1ZAxr1Wodn13Yfg5DhdKPAFkkKdi
    S/I7TyNwTX0Y8RnSZ8QdIy1Jqo5XXbQ7RrhyzAa5WGdgm6MjwoUKqKh3Uy0nLCbaeSbo/A
    de7q+7hNeF+MaWmtgdzUE1cHx21KJc4LOZtluly95DY4Z5RWj4II3/QyKmUNnRJfzsX0RM
    0qJoKWNtX92mkNHkt//vUyp2c9tsMyTX+3jK+p4XRlCmImR6eKHhgKraqRzLlyyuiALLWF
    +nD0X0Qi/AEfV9oQHERzDVqh1prrXV/iiqf3fzRMZ6f1xQfZbUHt9fD+k1xkLKGIna8Yiv
    JSsdsLmoL+HGczrNmT/tA67O1GZ6Yw1QKBK2WKunAf9z/fybxk8Y7V/lLvCkjMaI0/ZdVI
    6G5N1kkvvuRerxW4RYHVJIJ3ryoo/N3LKSsD+AuNBEqvojXeOipSq8Imy1XKx7g1teZocV
    k+6Rm4WV+Ngz6xo94S3/jiRzdYMz9+JmdT6ucA1htWzsg3EmCLaErip8ZtmFlmkVr0GY4d
    9hKd7AmfXTEN3ufy6g8xCkep8MrDlVTfHBmxzc74C/riVTeNEkTS6GTZHVSQ
X-ME-Proxy: <xmx:lLoVarBLmDEeQ1WRZWWIxva6q4PemMuasfNSaD7BKt3ZU2OLzqwtnQ>
    <xmx:lLoVatpyh7sOtRUyYhxKMux_KwviR9cszvgd048VKq3sLcFYL3Et8A>
    <xmx:lLoVasCh50c10kM6QfJ5aQjdYwzij9wsexIaqKzF4rIV6B2p_KsP5w>
    <xmx:lLoVatBL3JVhebcJYx1UMdOev9Jzavv-X7jXJ6ib8d1ul4dESUd1Gg>
    <xmx:lLoVan8dn2fGpuBzyIu7GhUtR-IWIPKCxSxdOxnw3ORrf-YWkkmdD4JT>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:21:55 -0400 (EDT)
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
Subject: [PATCH v2 01/12] preempt: Track NMI nesting to separate per-CPU counter
Date: Tue, 26 May 2026 08:21:37 -0700
Message-ID: <20260526152148.30514-2-boqun@kernel.org>
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
allowing those bits to be repurposed for other uses.

Reduce NMI_BITS from 4 to 1, using it only to detect if we're in an NMI.
The per-CPU counter currently caps nesting at 15.

[boqun: Solve Steven Rostedt's comment on the BUG_ON() condition]

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
---
 include/linux/hardirq.h                        | 17 +++++++++++++----
 include/linux/preempt.h                        |  9 +++++++--
 kernel/softirq.c                               |  2 ++
 tools/testing/selftests/bpf/bpf_experimental.h |  2 +-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06..1a0360a1000f 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -10,6 +10,8 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
+DECLARE_PER_CPU(unsigned int, nmi_nesting);
+
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
@@ -102,14 +104,17 @@ void irq_exit_rcu(void);
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
+		/* Maximum NMI nesting is 15. */		\
+		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
+		__this_cpu_inc(nmi_nesting);			\
+		__preempt_count_add(HARDIRQ_OFFSET);		\
+		preempt_count_set(preempt_count() | NMI_MASK);	\
 	} while (0)
 
 #define nmi_enter()						\
@@ -124,8 +129,12 @@ void irq_exit_rcu(void);
 
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
index d964f965c8ff..586f96688325 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,6 +17,8 @@
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-19 are the hardirq count (max # of hardirqs: 16)
+ * - bit 20 is the NMI flag (no nesting count, tracked separately)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -24,16 +26,19 @@
  * there are a few palaeontologic drivers which reenable interrupts in
  * the handler, so we need more than one bit here.
  *
+ * NMI nesting depth is tracked in a separate per-CPU variable
+ * (nmi_nesting) to save bits in preempt_count.
+ *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00f00000
+ *             NMI_MASK:	0x00100000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	4
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
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..2d4256ff471f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -449,7 +449,7 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	4
+#define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-- 
2.50.1 (Apple Git-155)

