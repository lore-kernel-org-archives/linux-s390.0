Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D6401A0D
	for <linux-s390@vger.kernel.org>; Fri,  5 Jun 2026 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638108; cv=none; b=ZaSbYxcJt2bm6pAamETY+R2cwXkwDi3yest/v3ykjisNr5xc/IHh6P6f/2pnrRL+e8tCwJWBbb0+y2NoAOxI1i/GiRiwCtMp65eZCh52gOZp7LQIRPimwlxdPBB67fbL4oP3cTN9zUqQwQt1zjrLytmAT3La3z2zTLqPTczAqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638108; c=relaxed/simple;
	bh=CBE6V82/9cSnE5zKiDaINuabdT3G7eBPLHLX8ZZAYo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSjKjeV9bfMyg2PellGSv7z1itmecQzsRkTsDz/BCG1SJDTCtBsJfxg0DK5N2MpqMebKtnx2PQ6BSVIkR5SYcXmsbK5SmVpA/EmHkROpvRd16KsKb8SEazcqXvHdsbTvMNZg0hbG66gKIljY9I7pidEUw6BJDB01HaAEqV1T3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsRpnZcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsRpnZcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AAC1F00898;
	Fri,  5 Jun 2026 05:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638106;
	bh=3RwpUO4CBjZA9J030nD/wwixercDouC6GsvjDNlY070=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsRpnZcMRDRwVxu0C9FYsEWfdA+5hG3gY4KxtQPojQ0t52j8g7Liy+YvQW7ZTbi3z
	 sjDTJg+sMpI65BLgBLO+joTFrNxqfHzzhyfyiQ1I5Zxcvt6/tFD09ri8O3cU8o2q3G
	 LN31dAch6/Mncnwlqhfyoo4yRjwyLiHV8E/RTk7XbQ7kdEeQvvayinrJYPBKrd6QUv
	 LouAZp1MfyTtvg9W2hlMDmBR96IvOT9gQiniGlgzUgucigOJF6wFs16KBOKVYu9wIo
	 cSD+zwW8Th+Hmq2vNi7CEEs2hJ0hurXi23+Q1o2jpMoTwHhvEBPfaR29lyK8AVESRK
	 ClT+reJuvUpGg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0791DF40068;
	Fri,  5 Jun 2026 01:41:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 05 Jun 2026 01:41:44 -0400
X-ME-Sender: <xms:l2EiatVawqlPiiodPj3IiVvkKJ7P5Nb5ToItwVcKoUK2LAigAu_V9w>
    <xme:l2EiaieaKgvPlfUt7VzBTIvYIxW63VeWrVSd7jKPUHsa0lqqHbYe8bMJgfzCo7C6I
    JKfUZDY6EQDuMh_2QMO_gKAIm7SDe3QYHqunfloq-_7sN_xSxZi-w>
X-ME-Received: <xmr:l2EiavRCQHWHImpg1_0yD6Ot96U9mgi_pRoMQ9oLsm8PNYU60-urVRM7xnA>
X-ME-Proxy-Cause: dmFkZTFhOfDTFTb8fH37X+ASfp2vsHy1Fqb2Lywq6X3h5fMlxk7wW33nxe7aSTekseFO11
    xBiB7Md3Dfg950zHftACRl4BCrZIGkOLORwuU667qK/t4b7uPTnvvrgSwCuAred6lniidQ
    x6+o43dstQnrbqqi/v6Nl3jrEdQj/OnTFIkpkf7j4tfd81Pm1F4hDhUzK5vMKXR0zokP4K
    KZGWpXQjfkPb9q0v8LW9bszX8CgnIWJLXLSKFiZe/Ul+6TINXLg1BnxiItQp/bB4zXvV+6
    Qcp88FhWc5Q0N1TQTHx/VoF2pZ7nT3Uyapa4Doti8umM92UFgjuSWC48vH+lnu7P/MqXlF
    GeOVtGQCkz/77hw7utJcM8Nnu748HG644DL3wNUgTwYWNRbIZnxx2oDFfkUYK7pXuhbe+s
    dKyyp+45sTnSjZpM49Rg9gkpuNINa5ytP+OgAKtc8MjL1tnGTrmEpiizdjBTsXrNWbyux7
    btZSz6tbrb7IkG4Knv3M1tLoxodRBPle8REkapVui30uzARmYC+ezi4lf9ZqW11/pk6n/d
    aZofGXE7LFwGU4avCC6fZigXlFUdQi8WVZW6cHlczGiNm69BpTx4jYafd/kKNIeoGA1AH9
    xDsb4kw/sx05m+lLlDfRnF4BZ5/M7ZwZZL3qnsdXb8+tUNDopP1WeJGQMnMQ
X-ME-Proxy: <xmx:l2EiaiyAEL0RHmq-qSLMyRrsBQlMdOAXuoCcklRnvU9eGfiyj1arCw>
    <xmx:mGEiatpx8mS55Y0ejhf5bEWOPwQiyyDeQdNkv2VOACfiktioV2_6vA>
    <xmx:mGEiam7CVZDV3y4b7stj7xlKReXSWXF5A_WqBwBK7MvecJrzDvD05Q>
    <xmx:mGEiapth-k6k5XDWrDXzMLflgS4QjROtwaXEqSiMM1wj3rSTKlb5uw>
    <xmx:mGEiaiBZkgU_eBOjTpZokU9wAzNyTniE9xEANOEpwJUBrGEgd8dxXvWm>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:43 -0400 (EDT)
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
Subject: [PATCH v3 07/13] locking: Switch to _irq_{disable,enable}() variants in cleanup guards
Date: Thu,  4 Jun 2026 22:41:22 -0700
Message-ID: <20260605054128.5925-8-boqun@kernel.org>
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

The semantics of various irq disabling guards match what
*_irq_{disable,enable}() provide, i.e. the interrupt disabling is
properly nested, therefore it's OK to switch to use
*_irq_{disable,enable}() primitives.

Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-17-lyude@redhat.com
---
 include/linux/spinlock.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3d405cc4c121..799a8f7d2741 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -572,12 +572,12 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __acquires(_T), __releases(*(raw
 #define class_raw_spinlock_nested_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
-		    raw_spin_lock_irq(_T->lock),
-		    raw_spin_unlock_irq(_T->lock))
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
 #define class_raw_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, _T)
 
-DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq_disable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
 #define class_raw_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, _T)
 
@@ -592,14 +592,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __acquires(_T), __releases(*(raw
 #define class_raw_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
-		    raw_spin_lock_irqsave(_T->lock, _T->flags),
-		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    raw_spin_lock_irq_disable(_T->lock),
+		    raw_spin_unlock_irq_enable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
 #define class_raw_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, _T)
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
-			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+			 raw_spin_trylock_irq_disable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
 #define class_raw_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, _T)
 
@@ -618,13 +617,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __acquires(_T), __releases(*(spinlock_t
 #define class_spinlock_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
-		    spin_lock_irq(_T->lock),
-		    spin_unlock_irq(_T->lock))
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq, __acquires(_T), __releases(*(spinlock_t **)_T))
 #define class_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irq, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
-			 spin_trylock_irq(_T->lock))
+			 spin_trylock_irq_disable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq_try, __acquires(_T), __releases(*(spinlock_t **)_T))
 #define class_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irq_try, _T)
 
@@ -640,14 +639,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acquires(_T), __releases(*(spinloc
 #define class_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_bh_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
-		    spin_lock_irqsave(_T->lock, _T->flags),
-		    spin_unlock_irqrestore(_T->lock, _T->flags),
-		    unsigned long flags)
+		    spin_lock_irq_disable(_T->lock),
+		    spin_unlock_irq_enable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave, __acquires(_T), __releases(*(spinlock_t **)_T))
 #define class_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irqsave, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
-			 spin_trylock_irqsave(_T->lock, _T->flags))
+			 spin_trylock_irq_disable(_T->lock))
 DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, __acquires(_T), __releases(*(spinlock_t **)_T))
 #define class_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, _T)
 
-- 
2.51.0

