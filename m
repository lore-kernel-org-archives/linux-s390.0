Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5084014AA;
	Fri,  5 Jun 2026 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638120; cv=none; b=Ksn/Rvhnlp1h2gJfE1crIm91/kPyLIX49YNrcrwMiCPwWxD81se2Re01JX5BtABKqpqkxK+T90L5f6ynrBEIAKvFB0unuPejHDKkjim8l2Y5/s8fFyDvi7HQ0JcPomNtpv7WNzajLlg1UrzFCceloi9CA8JIvKrPwpwM8LDWQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638120; c=relaxed/simple;
	bh=dLOHKW7WAr1j2ZaVPZw1AOGUtt3G5GCtMKdlXWtC1+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WY7oLUc1NI1X3luhjsQKlaGXQxlnycyvs+zI3FD908KbI0VqDN1TMbWYW9ipusrCM2uTbhRsRi5SgVu8X6/Lo+UKb4eWG5lIXoOcJSeDTiNpoD42oAsQe1bgkECBC4QpLImZGaD1Ma4m0ZEAq67ILRznZFOfVwlnNfTKs70zhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRZfQ1Em; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRZfQ1Em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291051F008A0;
	Fri,  5 Jun 2026 05:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638117;
	bh=cte+3SORcsAa7eW9vZLxBcB/RUJa01gm+E+K6ToVCog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRZfQ1EmhHh/fcOTKw4OmaKBk72iM6URnBfbl4OIYW3EsxD79F26PyzDv5DakTIKk
	 0gazh2CEDaAOaWaWCJ8JVd8Bn+go1fER4lmBlZ+v/utn/XT/SDXBfu151UbTFnzlNg
	 vA4/kcwzm+IfMRgOGGBdjBjyEIIKL8COuTwzJoxH/0FDY8d3DgMWLwgzId6XQ90ily
	 0TVqxVBKmxgrojgAAoFF7Hk5PozoFp5EvVKSUjGHmd2hng9z6mUZpt/DaDD03HnvUD
	 oyrH246/GqVTxxGMypjesyTV/StUgAjJy25GqmhsQbjsUyJBwS8Z8R6devg1dGrdUd
	 Ed+uDFgESmGQw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7094EF4006D;
	Fri,  5 Jun 2026 01:41:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 01:41:54 -0400
X-ME-Sender: <xms:omEiakGP5XVXHljs8KMeu83vG8CW7KvyEkMObkH8eCeRilh9RIiYJQ>
    <xme:omEiameSlkFLoE_C2fs9ms0g1T8CQbIfyViWI4hZrJPaR7SLUSImLIkEWJbNshSCM
    qNsZodoj6cnUDNuAFrMF805juMt8XN_nICcp-6HCUZScvhV-ueTOQ>
X-ME-Received: <xmr:omEianBSvRFrHZXLU7uIF9cLYVuVLaO1mDIA1KCZNnlTnyBWDpQBrtp1j3s>
X-ME-Proxy-Cause: dmFkZTGNdErcnsY9nz6zZJNqzBGcFpZ3oCsZyVSAsXPEfKD6fiAd7MM8RW3ErpHOKO8vqP
    y7FRxpXUBU5yb8Y73fmewycTgcYRdiPbEiXJpQaKxk1+aC6Vj3AAV2l/TRkhTd+1u+mIGl
    dQfEAWycnSLZO+qO217j/GTm+GQxoHWyRwvdph+wtnOrnU/D7PvfaSdl50PQ+1o9QW7RYj
    snzJFBhgLjSJ/jkZdib8Dc9ob5AHsrvEPqt2vef8Hmx2uDf0JqmoZZ+HexXrtwk5r0bry3
    HVu0i63lg3nGwPLJ2r8Np94WJ6jG6+OWNN7TpxDaYMxO59AtKcBppdJ6IoJJH6Zm9jQmfy
    d/M23rmFX/UEDMXUP5h4monMRjH3DBFbRBl3dq3TGCS9QG3xV5SjlbUSvMywVg8PIR6IFK
    KXMTZHNWG50pa++o/LTrjqU+tS5L11u4ow7nYXPXlPIFaek05dqOtUwW/zxRhcsbtpEZSR
    ISus0WT/tkwAGiTp3tz0+/6ZUWTvLgozaBgYkLZTwlbtRl/bPzm1sk3zU61ZBdP4XfrXtm
    nk3D+iIL4bflhzo6zjYipul55NCqZP5sTBozuwFgumkeLXVXTq/GWN7Czth//d3jja9eh1
    h/wjOwNzkRTyhq3JTkj4jSZ4w0vgmr38G80/zXvpjAFcVTP7qJZ/MeUZNobA
X-ME-Proxy: <xmx:omEiaoutB1XNfyRFcycQLcyt3196gs6LPaLSsdN5DnIOW3jOGmj-jQ>
    <xmx:omEiahsharQ5m502EbaXDzC0oOr8jyXpLBSL6tyJf-QAF74Szq47ag>
    <xmx:omEiaqAYaufe5Xu1CDW8S0L7axxIvgdRm6Y71eGIY6fOOr4tRsMRTA>
    <xmx:omEiao3df6szJBIycbcYKmDxC_IZWo1ekXvpKE8KizOigLvXK7hGtw>
    <xmx:omEian-S7B0U97IhQmD3cgGQb7ttfVIb5Blx2faJjvbLe9fS1TAXzQz8>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:53 -0400 (EDT)
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
Subject: [PATCH v3 12/13] s390/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
Date: Thu,  4 Jun 2026 22:41:27 -0700
Message-ID: <20260605054128.5925-13-boqun@kernel.org>
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

From: Heiko Carstens <hca@linux.ibm.com>

Convert s390's preempt_count to 64 bit, and change the preempt
primitives accordingly.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260509181249.16281C67-hca@linux.ibm.com
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/lowcore.h | 13 +++++++----
 arch/s390/include/asm/preempt.h | 41 +++++++++++++++------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..cbbca82f8443 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -276,6 +276,7 @@ config S390
 	select PCI_MSI			if PCI
 	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
 	select PCI_QUIRKS		if PCI
+	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 50ffe75adeb4..0974ab278169 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -160,10 +160,15 @@ struct lowcore {
 	/* SMP info area */
 	__u32	cpu_nr;				/* 0x03a0 */
 	__u32	softirq_pending;		/* 0x03a4 */
-	__s32	preempt_count;			/* 0x03a8 */
-	__u32	spinlock_lockval;		/* 0x03ac */
-	__u32	spinlock_index;			/* 0x03b0 */
-	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
+	union {
+		struct {
+			__u32	need_resched;	/* 0x03a8 */
+			__u32	count;		/* 0x03ac */
+		} preempt;
+		__u64	preempt_count;		/* 0x03a8 */
+	};
+	__u32	spinlock_lockval;		/* 0x03b0 */
+	__u32	spinlock_index;			/* 0x03b4 */
 	__u64	percpu_offset;			/* 0x03b8 */
 	__u8	pad_0x03c0[0x0400-0x03c0];	/* 0x03c0 */
 
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 0a25d4648b4c..1d5e4d7e9e1b 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -8,11 +8,8 @@
 #include <asm/cmpxchg.h>
 #include <asm/march.h>
 
-/*
- * Use MSB so it is possible to read preempt_count with LLGT which
- * reads the least significant 31 bits with a single instruction.
- */
-#define PREEMPT_NEED_RESCHED	0x80000000
+/* Use MSB for PREEMPT_NEED_RESCHED mostly because it is available. */
+#define PREEMPT_NEED_RESCHED	0x8000000000000000UL
 
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
@@ -26,25 +23,25 @@
  */
 static __always_inline int preempt_count(void)
 {
-	unsigned long lc_preempt, count;
+	unsigned long lc_preempt;
+	int count;
 
-	BUILD_BUG_ON(sizeof_field(struct lowcore, preempt_count) != sizeof(int));
-	lc_preempt = offsetof(struct lowcore, preempt_count);
+	lc_preempt = offsetof(struct lowcore, preempt.count);
 	/* READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED */
 	asm_inline(
-		ALTERNATIVE("llgt	%[count],%[offzero](%%r0)\n",
-			    "llgt	%[count],%[offalt](%%r0)\n",
+		ALTERNATIVE("ly		%[count],%[offzero](%%r0)\n",
+			    "ly		%[count],%[offalt](%%r0)\n",
 			    ALT_FEATURE(MFEATURE_LOWCORE))
 		: [count] "=d" (count)
 		: [offzero] "i" (lc_preempt),
 		  [offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS),
-		  "m" (((struct lowcore *)0)->preempt_count));
+		  "m" (((struct lowcore *)0)->preempt.count));
 	return count;
 }
 
-static __always_inline void preempt_count_set(int pc)
+static __always_inline void preempt_count_set(unsigned long pc)
 {
-	int old, new;
+	unsigned long old, new;
 
 	old = READ_ONCE(get_lowcore()->preempt_count);
 	do {
@@ -63,12 +60,12 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	__atomic_and(~PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
+	__atomic64_and(~PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	__atomic_or(PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
+	__atomic64_or(PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
@@ -88,8 +85,8 @@ static __always_inline void __preempt_count_add(int val)
 
 			lc_preempt = offsetof(struct lowcore, preempt_count);
 			asm_inline(
-				ALTERNATIVE("asi	%[offzero](%%r0),%[val]\n",
-					    "asi	%[offalt](%%r0),%[val]\n",
+				ALTERNATIVE("agsi	%[offzero](%%r0),%[val]\n",
+					    "agsi	%[offalt](%%r0),%[val]\n",
 					    ALT_FEATURE(MFEATURE_LOWCORE))
 				: "+m" (((struct lowcore *)0)->preempt_count)
 				: [offzero] "i" (lc_preempt), [val] "i" (val),
@@ -98,7 +95,7 @@ static __always_inline void __preempt_count_add(int val)
 			return;
 		}
 	}
-	__atomic_add(val, &get_lowcore()->preempt_count);
+	__atomic64_add(val, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline void __preempt_count_sub(int val)
@@ -119,15 +116,15 @@ static __always_inline bool __preempt_count_dec_and_test(void)
 
 	lc_preempt = offsetof(struct lowcore, preempt_count);
 	asm_inline(
-		ALTERNATIVE("alsi	%[offzero](%%r0),%[val]\n",
-			    "alsi	%[offalt](%%r0),%[val]\n",
+		ALTERNATIVE("algsi	%[offzero](%%r0),%[val]\n",
+			    "algsi	%[offalt](%%r0),%[val]\n",
 			    ALT_FEATURE(MFEATURE_LOWCORE))
 		: "=@cc" (cc), "+m" (((struct lowcore *)0)->preempt_count)
 		: [offzero] "i" (lc_preempt), [val] "i" (-1),
 		[offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS));
 	return (cc == 0) || (cc == 2);
 #else
-	return __atomic_add_const_and_test(-1, &get_lowcore()->preempt_count);
+	return __atomic64_add_const_and_test(-1, (long *)&get_lowcore()->preempt_count);
 #endif
 }
 
@@ -141,7 +138,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 static __always_inline int __preempt_count_add_return(int val)
 {
-	return val + __atomic_add(val, &get_lowcore()->preempt_count);
+	return val + __atomic64_add(val, (long *)&get_lowcore()->preempt_count);
 }
 
 static __always_inline int __preempt_count_sub_return(int val)
-- 
2.51.0

