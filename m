Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57F3BB10D;
	Fri,  5 Jun 2026 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638102; cv=none; b=lT8wm3SqeET6YkJ9tuXETIXsK40RFpAYG42D7psbEhu+I7OS52Z8wcAD/0532zoF/lxFl+sCrBm/k/vGakmi5T+FZFq13rLBaH1/kIX3qsmwjmr0aKEACSPHJMnZDFwh3FQeZTxuwk0oodf/bPJ+rACtASUc+gfVH4H2zNfFtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638102; c=relaxed/simple;
	bh=OYMeV7jWag8jjr/SGJIJdoM4RRdbcgCBusx85a29JNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFXv91MMNSubPxG3cbDW8+qPfZGjb929u16/81852QNCsseDPyvILWO35v5Fs2DIrAOZ3i0z5s2v8IPoom22Djw/H5TlRykUuWWf6AAyBE3DqZuvt+vzHxXQRoFKSfAPWyG5eHgbLKmHJqHNLbEJEoNY+CR/f9iFG/wPm0+19q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEVqsp4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEVqsp4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1001F00898;
	Fri,  5 Jun 2026 05:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638099;
	bh=q22StVZMYHsonhMzLNuiRfEYi7dvpll9rGA0FOoOgUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEVqsp4iYNJUhy8+//nV8kLacdG87jLd+Z9dGYCa0+TXk9qx8pSEvHMD8RGDS6pFi
	 jgpvpl91arhoFUPeP5+BTLtC/YYlTB1AeOkMmDMr+AtfYzIKc4XpdP4plCI12NGT1u
	 dxHJsVNmLhLHkqeOTCDnrvEbm0T1K+1ApWMxAmBY0AjVyqHYhtpVpof8EPvhmSWtM3
	 yrLWO675IkFl5rR/dS7WrYzlPFTwLcAy8sGsm9kZYvcFv3s1SSU1dp5IVQ7lTf7vl6
	 SqE+dl1QIhiVkM14c95c/0GOGGZW5Y9EvgMyrzTCUG7vpkZF0l17PIfnHt5yw9Mjqk
	 KJGnDe8n2Ykig==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id AA5CAF40077;
	Fri,  5 Jun 2026 01:41:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 01:41:37 -0400
X-ME-Sender: <xms:kWEianm9Odxpr9h6xdaPwhDWDJ5YH7HqaUwKQxlp3j0r6dI8I90zMQ>
    <xme:kWEiavvxzvFtzcUcv6abPoh-DBPv49w99o17uRdV1j-7P4IHprxyMAukE5PVUnDH3
    pVSydazCmNDqaYSXUY3kcmxHfOB_raDnd7wsdT2_wlnqxKrNrgV>
X-ME-Received: <xmr:kWEiajggkh-tASySkGZXu1iL_P9HENioaTqgteAX_tCamtGXa7VyVV3v8tE>
X-ME-Proxy-Cause: dmFkZTFhOfDTFTb8fH37X+ASfp2vsHy1Fqb2Lywq6X3h5fMlxk7wW33nxe7aSTekseFO11
    xBiB7Md3Dfg950zHftACRl4BCrZIGkOLORwuU667qK/t4b7uPTnvvrgSwCuAred6lniidQ
    x6+o43dstQnrbqqi/v6Nl3jrEdQj/OnTFIkpkf7j4tfd81Pm1F4hDhUzK5vMKXR0zokP4K
    KZGWpXQjfkPb9q0v8LW9bszX8CgnIWJLXLSKFiZe/Ul+6TINXLg1BnxiItQp/bB4zXvV+6
    Qcp88FhWc5Q0N1TQTHx/VoF2pZ7nT3Uyapa4Doti8umM92UFgjuSWC48vH+lnu7P/MqXQy
    5fmb7JXidSEtZ94DTq5AOqHkZS7B2jcW9RZpYNSTVsMl9756g7TyoyUAFQFdU+5zUF86JT
    O36jgGKgvkCiI3g/Alv7jhIIamDTa/2iF9zV4B9PuQLxCfp9mSan8it3Ky4vGO0AzNa51w
    vgVxfBvfzy2ytIVHsdR/uT05Yd6f2+ctUGK6dq5LzLXUloZnu6mrSspEjLUK874UUfCORI
    FJccIc8RovUYWSz3K+Ftmeex7VWfnVHNcot6oL84ZpNZHdYPSiXSvNW+O2od2TihDsP6xV
    St0xihM/B25nP3OR4yRm05xPXFUOB1ge+YKPKimm6RhFij7O/o/GIeT+R93g
X-ME-Proxy: <xmx:kWEiaiDOZsHfPNWIaLqP-4_yMp9ZKXLRyU3MIY8Vo5mry8H2klWyTQ>
    <xmx:kWEiar7aqjz1N348figYbayWOIYX4Af2r3tIqOC1b4hwUp7M-DnevA>
    <xmx:kWEiaoJDR4KPW_08OV68VwuW9HU6BNbRd4VR3aaXIy0Jjk7LSccJzA>
    <xmx:kWEiah9PNqNFR5Jm-Tdeh9sUpApNCPY-y8xlLkyVD9W8EZqFrq55nA>
    <xmx:kWEialQSKyg28ndyK26UTqInfnkj-dfLao45xwK79Xar3-690K2wpn1e>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:36 -0400 (EDT)
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
Subject: [PATCH v3 03/13] preempt: Introduce __preempt_count_{sub, add}_return()
Date: Thu,  4 Jun 2026 22:41:18 -0700
Message-ID: <20260605054128.5925-4-boqun@kernel.org>
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

In order to use preempt_count() to tracking the interrupt disable
nesting level, __preempt_count_{add,sub}_return() are introduced, as
their name suggest, these primitives return the new value of the
preempt_count() after changing it. The following example shows the usage
of it in local_interrupt_disable():

	// increase the HARDIRQ_DISABLE bit
	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);

	// if it's the first-time increment, then disable the interrupt
	// at hardware level.
	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
		local_irq_save(flags);
		raw_cpu_write(local_interrupt_disable_state.flags, flags);
	}

Having these primitives will avoid a read of preempt_count() after
changing preempt_count() on certain architectures.

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-4-lyude@redhat.com
---
 arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
 arch/s390/include/asm/preempt.h  | 10 ++++++++++
 arch/x86/include/asm/preempt.h   | 10 ++++++++++
 include/asm-generic/preempt.h    | 14 ++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 932ea4b62042..0dd8221d1bef 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -55,6 +55,24 @@ static inline void __preempt_count_sub(int val)
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
+static inline int __preempt_count_add_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc += val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
+static inline int __preempt_count_sub_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc -= val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
 static inline bool __preempt_count_dec_and_test(void)
 {
 	struct thread_info *ti = current_thread_info();
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 6e5821bb047e..0a25d4648b4c 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -139,6 +139,16 @@ static __always_inline bool should_resched(int preempt_offset)
 	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return val + __atomic_add(val, &get_lowcore()->preempt_count);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return __preempt_count_add_return(-val);
+}
+
 #define init_task_preempt_count(p)	do { } while (0)
 /* Deferred to CPU bringup time */
 #define init_idle_preempt_count(p, cpu)	do { } while (0)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 578441db09f0..1220656f3370 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -85,6 +85,16 @@ static __always_inline void __preempt_count_sub(int val)
 	raw_cpu_add_4(__preempt_count, -val);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, val);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, -val);
+}
+
 /*
  * Because we keep PREEMPT_NEED_RESCHED set when we do _not_ need to reschedule
  * a decrement which hits zero means we have no preempt_count and should
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523..c8683c046615 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -59,6 +59,20 @@ static __always_inline void __preempt_count_sub(int val)
 	*preempt_count_ptr() -= val;
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	*preempt_count_ptr() += val;
+
+	return *preempt_count_ptr();
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	*preempt_count_ptr() -= val;
+
+	return *preempt_count_ptr();
+}
+
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	/*
-- 
2.51.0

