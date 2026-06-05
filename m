Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201E3FE35D;
	Fri,  5 Jun 2026 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638120; cv=none; b=gnsrG90ZH5toBD+E7wmtY4uHgYPADcgaj+dtCWfLYMxCzBU7YM5YXV8Kgtlv9EA8uEmFdaVVUlvX//LDr5VE4SKH9+lt55fy+dmDYalB7lbNZdYTsl8JxN51W7Ifd0319ZY3dWBkgkklNAgHWE7AIZIBjOhoZwwuBAlin8VV0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638120; c=relaxed/simple;
	bh=ub2dNJq/xnlK3TL0MDbTdj+ww2iW+ojYYwWRDfK7gu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG2N+vBV54rwYJZF/eJKF9OW846n6AxI7L2U8+dAMped+NVk891BCEFJrer6YWHlw1bIQVbBmwpHcnRI39+hHn/TVyv+/iHRKvnt/nPK7IgISjwc+3O1KGws8pT6ufaWFfEgDn+mT74Omz0W1voayuo9EqrlAFkOJ+7SlhPVqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt1Gv9AW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt1Gv9AW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA51F0089C;
	Fri,  5 Jun 2026 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638118;
	bh=tXrxowM9l6DqFYeAjn5Tac1f8S3PU9cy43ibbb4VImQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bt1Gv9AW2oKS0LY5l6jXhoKt+z+vO3BpaR1T6SbnU+f0deSZ1ABjn9VvZBuuJI/Cj
	 HJkpmzNSK1/QRjbKldJrwhKNOI3XCUlCM4XxVKbeXIia/Z9WCEa10/TH3SRx1S3/ji
	 M3/YFEI2Et/Ost9/EUjQjNPOjR/1RFvoToXJBCMe/UvBXmucwpkv6udMQCtVJTfPbL
	 qIIQ0e+RlihB6+GWfIIWHdAxl8mp85f4D7Li8TAfS5xGp/lm6fGH9xAWTlLvUB33JI
	 guYe2w4tTcB3TNLQRwwQuiccm//hNTjzk3tcXsdy3RTAQ7oMgfOR2lLu90bbAsoDVY
	 NIlGOpngZ1iAQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id E0BD1F40068;
	Fri,  5 Jun 2026 01:41:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 01:41:55 -0400
X-ME-Sender: <xms:o2Eianzn2H9bfu77tyqZX28jnYGvZmbb_4wTqgPBiLvaI4nD_ZLzBg>
    <xme:o2EiaoYl3J-KpNc4n3V8vvSWDbP7DHNiVM2RNPA4N3kNzN5zIL4Ta0zj5EJW7eMmx
    njUBtfRFrtW6WYSW2MVx9kpVcQo4Ih4-ryfLqcokDuf1GoiXc6tVg>
X-ME-Received: <xmr:o2EiaqPQHjozAEzDIMqZPLIygZmmgXzVsC6FZSPHugwmrxcjBGdzqZN4ZPc>
X-ME-Proxy-Cause: dmFkZTFG0WJa+84B5ZLakFCJusLrHx60u/M2e4tgb8vvSWGQWHXMFZeKktHow9VrFaQhwL
    60vkPLe/GHUXrF9uQjn9EtWhYCiYebO343SXKkauObGNd0gaHEDMGyAUdMEWI3xvV5+MXM
    Y5XIGIH+RCj/YpjPsc3XHQUzqyjdf8JDGbXE7uRDsVlh2adsQWoVoEG+11Li6tmpxBjo+n
    GbGHXxcMsG5BC+v/PWXz65OFiJmnJTn18gjrdwmPsAQA0I/XEj3HJhBv36WGSvCgORqSG4
    pkDfFOinWXk05Px2n3ZYSDFusuNrnah7Cqk2jZsViR99U7a3ccatK3SGLf/zDxH9xSS8qX
    d7jFqhlw8739C7P+Vw4YAKRdjftKM5qwXrp10RhjCbtlXYkXUtg/lihoMG8MroPCLFkMdh
    yBe76zLchQusN2z3yRtFCMERRJAag5Jqf4Cx3wSwUn+pSj2N/WkzFAkCBVqPuzAnHg+6En
    f9+adxIwdJJiICLDMxNucNU0d9RCsLswbbtCnlG10BOkgHUhO0qe2BLEUccUrAE9JIiFSH
    ScggFvzBTtTSM3RlvjRzv4BQE2D+Kfb6Vn940IvcY/mrtjs4rqDKUt2ulWpgZ0B1nIqMbW
    RJO95aqzPjRtgDkK0WoypiOUWop4aiyV2dWzyenVoeC5GH1Kw4m/qn4gPcaw
X-ME-Proxy: <xmx:o2EiakI78K4WKgYyXJsZZOt6UBtWmy2NM3bzrmaQ7tx1N4WNrLytQA>
    <xmx:o2EiagbidEIQZ_qqdIKUZzkP_KCAWcftL4OEPe9lt6ea3t0npDaP4w>
    <xmx:o2Eiaq9e9a1GckPM50jah-QmqiyBSzxvr_SIaLRDRAD3GO0UErBAIg>
    <xmx:o2EiavArku1-nRhp5mTVnm2Y5g14M47yfVAPqlqqT0GqywpubN8N9w>
    <xmx:o2EiaqbkaM_or9P7YOXnPZoR-ykqMUO1IyXJPH17WoJFWM03z982K6wk>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:55 -0400 (EDT)
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
Subject: [PATCH v3 13/13] irq: Optimize reschedule check in local_interrupt_enable()
Date: Thu,  4 Jun 2026 22:41:28 -0700
Message-ID: <20260605054128.5925-14-boqun@kernel.org>
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

In local_interrupt_enable(), we could avoid re-reading preempt count
because of should_resched() by using the result from
hardirq_disable_exit(), however this means __preempt_count_add_return()
and __preempt_count_sub_return() need to return all the preempt count
bits (including the PREEMPT_NEED_RESCHED bit), since the only user of
__preempt_count_{add,sub}_return() is hardirq_disable_{enter,exit}(),
hence make them return "unsigned long" to optimize this.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 arch/arm64/include/asm/preempt.h | 12 ++++++------
 arch/s390/include/asm/preempt.h  |  4 ++--
 arch/x86/include/asm/preempt.h   |  4 ++--
 include/asm-generic/preempt.h    |  4 ++--
 include/linux/interrupt_rc.h     | 31 ++++++++++++++++++++-----------
 5 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0dd8221d1bef..e9f597d87413 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -55,20 +55,20 @@ static inline void __preempt_count_sub(int val)
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
-static inline int __preempt_count_add_return(int val)
+static inline unsigned long __preempt_count_add_return(int val)
 {
-	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	pc += val;
-	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+	WRITE_ONCE(current_thread_info()->preempt_count, pc);
 
 	return pc;
 }
 
-static inline int __preempt_count_sub_return(int val)
+static inline unsigned long __preempt_count_sub_return(int val)
 {
-	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	pc -= val;
-	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+	WRITE_ONCE(current_thread_info()->preempt_count, pc);
 
 	return pc;
 }
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 1d5e4d7e9e1b..d0021b979a5d 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -136,12 +136,12 @@ static __always_inline bool should_resched(int preempt_offset)
 	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
 }
 
-static __always_inline int __preempt_count_add_return(int val)
+static __always_inline unsigned long __preempt_count_add_return(int val)
 {
 	return val + __atomic64_add(val, (long *)&get_lowcore()->preempt_count);
 }
 
-static __always_inline int __preempt_count_sub_return(int val)
+static __always_inline unsigned long __preempt_count_sub_return(int val)
 {
 	return __preempt_count_add_return(-val);
 }
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 12353eeebc52..fc1a2799990a 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -103,12 +103,12 @@ static __always_inline void __preempt_count_sub(int val)
 	__pc_op(add, __preempt_count, -val);
 }
 
-static __always_inline int __preempt_count_add_return(int val)
+static __always_inline unsigned long __preempt_count_add_return(int val)
 {
 	return __pc_op(add_return, __preempt_count, val);
 }
 
-static __always_inline int __preempt_count_sub_return(int val)
+static __always_inline unsigned long __preempt_count_sub_return(int val)
 {
 	return __pc_op(add_return, __preempt_count, -val);
 }
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index c8683c046615..7629e23102d1 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -59,14 +59,14 @@ static __always_inline void __preempt_count_sub(int val)
 	*preempt_count_ptr() -= val;
 }
 
-static __always_inline int __preempt_count_add_return(int val)
+static __always_inline unsigned long __preempt_count_add_return(int val)
 {
 	*preempt_count_ptr() += val;
 
 	return *preempt_count_ptr();
 }
 
-static __always_inline int __preempt_count_sub_return(int val)
+static __always_inline unsigned long __preempt_count_sub_return(int val)
 {
 	*preempt_count_ptr() -= val;
 
diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
index dd4444c61330..c044dc395452 100644
--- a/include/linux/interrupt_rc.h
+++ b/include/linux/interrupt_rc.h
@@ -27,7 +27,7 @@ DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
 static inline void local_interrupt_disable(void)
 {
 	unsigned long flags;
-	int new_count;
+	unsigned long new_count;
 
 	WARN_ON_ONCE(in_nmi());
 
@@ -41,9 +41,25 @@ static inline void local_interrupt_disable(void)
 	}
 }
 
+#ifdef CONFIG_PREEMPTION
+static inline void local_interrupt_enable_reched(unsigned long pc)
+{
+	if (pc)
+		return;
+	/* No PREEMPT_NEED_RESCHED bit? Check tif_need_resched() */
+#ifndef PREEMPT_NEED_RESCHED
+	if (!tif_need_resched())
+		return;
+#endif
+	__preempt_schedule();
+}
+#else
+static inline void local_interrupt_enable_reched(unsigned long pc) {}
+#endif
+
 static inline void local_interrupt_enable(void)
 {
-	int new_count;
+	unsigned long new_count;
 
 	new_count = hardirq_disable_exit();
 
@@ -52,15 +68,8 @@ static inline void local_interrupt_enable(void)
 
 		flags = raw_cpu_read(local_interrupt_disable_state.flags);
 		local_irq_restore(flags);
-		/*
-		 * TODO: re-read preempt count can be avoided, but it needs
-		 * should_resched() taking another parameter as the current
-		 * preempt count
-		 */
-#ifdef CONFIG_PREEMPTION
-		if (should_resched(0))
-			__preempt_schedule();
-#endif
+
+		local_interrupt_enable_reched(new_count);
 	}
 }
 
-- 
2.51.0

