Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCCB311C1D;
	Tue, 26 May 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808924; cv=none; b=iqKnhwNZAL8zNHmVVyCHaY6lPJinAh0vmD7FAIj/u2pIf7lkt/GAuG9AaV3d6ilPSbfvgPE3g3gS/YBQCHdpUSP3KpDLdoOmPKQwwBoEcxMkE316ocFqeMKhAi6AS82VUymjgyJxt+BBpXt3vEmfb0zLE3rqqoSn7RlcvyTB3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808924; c=relaxed/simple;
	bh=Vehb/t6SCVfzU1bT05V1SwVIcwnemQ6o+FGhRxk1pnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9Cl9ixoTagmPBcSdMOf2zoSXBchRihsRLDg6FGIOXGN7oI9/E+sV402EL2XZ1ZyY7UshRmXOB2Layi1xpzCwu2/JC7nudRfaRhuq7VAcqLENsfNviSFDadAE1pwl8OhZEDqhhw0R7oVkSyT24IgYLQ8OJTuIZVHNkcm9s7kVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyspl5Yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyspl5Yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A911F00A3A;
	Tue, 26 May 2026 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808922;
	bh=dtyam0hhN2xA27ITouHJzp9jxSe25UlhsLT0mi+B6dE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pyspl5YrsdYhs1d1/72no/un+M8h/0hSzyxnuc/M+qYRGzRUPARxvBctMR8XE5pEQ
	 hdcYisjmsLr3aiDgZU/qGhIz9btMo/8i47tOcaHkuOQbERhsTGVsIxgB+8SzdIMqed
	 mqoERXapqquoEyjKXvXXg+NOlPhLfmXl46F+SKXTosxJQ/1I676Pxvtbqs+yDktBq1
	 0WcHQVJVU+l/7QkfAgjCqp7t6qAxZAui4JDpMlAWLpcAlfcaMzr0S+b5pkiQYOxuNZ
	 3tmrzkXSEWYgH3JEc0z7WbNcTbYiw+Y9uUsbEsrzMoegd5IU4tT2ekzqKfKge3Ucpk
	 EGgtFP4UquLPA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21ACAF40076;
	Tue, 26 May 2026 11:22:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 11:22:00 -0400
X-ME-Sender: <xms:mLoVamSRk-bQJzpXsXFePxe1L7E1f_dNuQoQzB1-SwJQFNurPV5prQ>
    <xme:mLoVavw57Zlgsq_PeyFnaZ_rWCDOHE0tfKDHI-nNEhxHVOlEautNtE0Ypc0qxmCet
    s7iGQjQN2SR33TE6601Bahsxj8dnt36R3hbRgPfLUfHK77KqlztxAk>
X-ME-Received: <xmr:mLoVai5Pi6VdnjEaZ7Yw07u3qNtfvUsiGATQ0fF3vy0t27iN2iWvjjllZdIj5TwafH9Twdxk4M6EH484wAilCkzNYT3ryDJv>
X-ME-Proxy-Cause: dmFkZTGukvwILOOvmar/YpzpbGxcThya1huxzJh8wPsxZqy8c45YkWNCoU6I+5YwKn52tQ
    FimljOlgnke1vtXjpOlEIIzqmHsNns/ZJmR5LvOMJZ1ZAxr1Wodn13Yfg5DhdKPAFkkKdi
    S/I7TyNwTX0Y8RnSZ8QdIy1Jqo5XXbQ7RrhyzAa5WGdgm6MjwoUKqKh3Uy0nLCbaeSbo/A
    de7q+7hNeF+MaWmtgdzUE1cHx21KJc4LOZtluly95DY4Z5RWj4II3/QyKmUNnRJfzsX0RM
    0qJoKWNtX92mkNHkt//vUyp2c9tsMyTX+3jK+p4XRlCmImR6eKHhgKraqRzLlyyuiALLDo
    STtF9535pUY4wHIg6gpJ/rAGyCaiYTBD2ISq6To1jwGxQAVpTNMz84wZeOWfzMeQhQ2RQB
    678BPBLOH2NMNsAN9ZHybV/Tjbykr/4yPX681FrlZ+mZimg1rXq+VxOFA8NVsAN97EKxep
    hgvVX0pDucDb8cqVlpB+xiNkY4QAUqE2OFha9TLxGKhMcU8Rk1/cqMzB1NkztwFeSGWlrq
    NTEiCLkpqtxCLiBuVQJmtJv07Wf7+KVuuL4jlS+x1hallNQC9+SFMk12SZaEyFmRp9SE0n
    WTzleHY6WMhg4lX8Hrly3CUAc08r9ykPyyLadBnkMe3ETteo//FDSV2oNCrA
X-ME-Proxy: <xmx:mLoVajyBviIAKS_wP7F8wzfoxsxFbBBAz8GniKV4XaRFDzk5tyhZUw>
    <xmx:mLoVanYH-IEBVA7oviU2EMpEVO-Wvd7LPmCgpKQPxm0XBdEnEIqZPg>
    <xmx:mLoVaiwQKzPlWUEeoo_D35OcI2pv6QRJ2YVMUDI5RbVBHXRB3B_Wpw>
    <xmx:mLoVasxXV8ozipbdcJfPNB6b6l7DrIuk4ewA_eoRUQPW1VNscTC-hw>
    <xmx:mLoVasufF-HeMFK2xu_QYiBiPMFxADCgBO65x_FdPN3NGQ638MeXbdNb>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:21:59 -0400 (EDT)
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
Subject: [PATCH v2 03/12] preempt: Introduce __preempt_count_{sub, add}_return()
Date: Tue, 26 May 2026 08:21:39 -0700
Message-ID: <20260526152148.30514-4-boqun@kernel.org>
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

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
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
2.50.1 (Apple Git-155)

