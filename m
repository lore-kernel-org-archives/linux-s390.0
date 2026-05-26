Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263A34FF79;
	Tue, 26 May 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808935; cv=none; b=GA2poyWofZmRWYgxtCb+LVH7yER0CNpH6L9M+WSoSdHhiM2dOMrHO3wwsEQydROGcva3tmshqdAzCQhkv9n0cHFQUCBE+aiS46j8Y5NegG9OXGnpVpM55ZI8x65bBa9/dn0zU/w6CMyAbW5VPoqLjlOOJ9Vnipxda8uMpwjX+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808935; c=relaxed/simple;
	bh=7EF6VDi6I+g5w0YgEi5eLmgKFfZXvhXnmFcHsn8i+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaZgXVWW6MJTyxDFMJkew0N3DWgjZsR2XEtFNzlUSMWx5j65lWnxQiP2DGErMBVXhqcUhk5ETogY5ZGKIXc0B0DCA+iIUVYrnR9zGP5CJlvRJ3ykup2pcjC72snxbt/G92uMNJC87/oCIlaT02vCSuSHb2MnL6KmOHGZcmbP2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNRncOtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNRncOtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0751F00A3A;
	Tue, 26 May 2026 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808933;
	bh=nVURMapIQPY5wSLiaqlC8nqDIUgsA0MO+pQObO9t18c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNRncOtQRPVl6d3oY6OGWGyn10MQj6TmvNSfFt2mbn2S7XyiiB0ExLGrpJHM1sPKz
	 lsL4kgNIesS/CRgYR8GsBjM5sMKA012SZjjLHY5TdfS2EFKekHrzIQvyGUUidQwU/q
	 M1umKnmQzKh5IJoujr+YASx2UhwE2K1xj0xbChnQpiIc30SlEOjunM+qTDpNeaurJ7
	 IC63JgwfAGndzbmEsuCihn/b2tuBhakC0kP3I9e4aIV1ieGE6U9guEHFWZKA6ue+wp
	 X2rI1m6Dz5Q3v7XZeE4ecEJQeXdxUrCTyahfEAxm56JrcE3A24Zek6KiOhVTKA7iD8
	 HTKOkhOjb5xLA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41468F4006B;
	Tue, 26 May 2026 11:22:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 11:22:11 -0400
X-ME-Sender: <xms:o7oVaiIRiwgKJCaH4QPeZ9IiSaSEdVw8Q5H-50K_bDFjWtlWo9q5-g>
    <xme:o7oVaptfVOhm07egNDqJDzZBTSlXvaXB6-wLEzwFrWsnl4TJV54_9HivYpQGzbpmQ
    VM567_ghvYWtBd9jLVZGe2TAPPfysxoEZEX_yXsByaBFhlG7Uq85Q>
X-ME-Received: <xmr:o7oVamdx_l5zUd3RyYIijzPZG5rKj1bhNZy1Y4OQzNao_Zp1WtR1igYGWsl-vdeqEtRcwoegat1UO_RgGzltFJ45fuXpfSX8>
X-ME-Proxy-Cause: dmFkZTF4jGPOhQTuH5Jv1Bu8qtAH+o7ONYfGYAQ/2V25E28snHxkD7IK3o93tbsfRiU/7a
    wQXUgRfJEkkkejgl5eaEdssrvK9BEFErVeCBAF/P260V26+7gSLfAm4n6tGfCP+N/ttsRD
    6QxJ2oZqzgQ6A2MUXSfvc2fqFHT+3ds0mqAmVk4Rm6zv0xJSgJu+HxwPFqLJtm5KboWFe3
    YCCOEC+tC7qbDde3ths7nMiW1He0VMbFq1hd1nUrw8iWtJIcH1ptI6wJJJWDyojp15ZlLi
    7quzpP55FVnVcHxjBLLIEmamqbVW8FZTAIKjjtzR++Rs6Yl9Nlons0ovgF4FHLpWu+ynoW
    wcxM6i9guxGjiFaa/ZTNCi6hJPGpFSYyJo6P26QUeiF1NVpFL1Qk0E8joilkQaJLScd2ug
    eV+W8nDzB2D6BScLq/COO/jkf2nevmZoPA4SYAa1gtTXbb7mhWvcTJm8fIspAhZbwrAWh1
    QHE8BUF8TtqEsQZi8Zq8h03nPWsKTAlcf5CPxBDh+H8wvSqj/8Ly76YC8pLEEfqHdHQ171
    to3m+j94RuR/gEe3t81pUThqryYfnBX7cuELmmCUDMIQd1uUHdru3mQzPT0gCDXXHnxHrY
    akeF+LIWEj8po3G3mL+olQF7QfBPfzwrSW3BE/o2O7o9ZX+HV4KF6q7sgE/Q
X-ME-Proxy: <xmx:o7oVar0JTuYaBT2cg3t-4JZbpP4nEf2knnjcc7pVNMKwQFrciOa7bg>
    <xmx:o7oVah9qGKe1QgiIf7hT2Y4_SUjOOTyCWTy1dZLXcVNezCJZEYVijw>
    <xmx:o7oVah0iwC7qseCdCSaba4fXrZTXUWbvG-1C8jE2z-gvuf0xcbfN0Q>
    <xmx:o7oVakdzRPAhwtmo2148ZiHo6y5kGVs5umEa7zFALdD_obKX_-DuJw>
    <xmx:o7oVakvMFOSycFyHjkwrxAyzlTZOvpgEE-E5X7DtHgsIfqtE2wIxi29H>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:09 -0400 (EDT)
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
Subject: [PATCH v2 07/12] locking: Switch to _irq_{disable,enable}() variants in cleanup guards
Date: Tue, 26 May 2026 08:21:43 -0700
Message-ID: <20260526152148.30514-8-boqun@kernel.org>
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

The semantics of various irq disabling guards match what
*_irq_{disable,enable}() provide, i.e. the interrupt disabling is
properly nested, therefore it's OK to switch to use
*_irq_{disable,enable}() primitives.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-17-lyude@redhat.com
---
 include/linux/spinlock.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 9d6012ac929d..0b4023b67f43 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -571,12 +571,12 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __acquires(_T), __releases(*(raw
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
 
@@ -591,14 +591,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __acquires(_T), __releases(*(raw
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
 
@@ -617,13 +616,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __acquires(_T), __releases(*(spinlock_t
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
 
@@ -639,14 +638,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acquires(_T), __releases(*(spinloc
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
2.50.1 (Apple Git-155)

