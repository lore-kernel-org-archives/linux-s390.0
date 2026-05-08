Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E8330301;
	Fri,  8 May 2026 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214090; cv=none; b=jrPfWHxeaibiox+2NzfVhmoF4cHbo9x46w4Buew7gZ2Se1u6ketdof6EysU0o98pQEdi29fjLlo44dQkWOxxzxa2EywCYiYZ3ppG4jcS6W3iCHjeKzkmiUXXkZnbGcmEUHwu5+IC7tBDISeSZ1Z7nf7M/DuOdUFqCHtGuoGECyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214090; c=relaxed/simple;
	bh=5il15HEwfN3oGfa4IGpnL47xhPzSBu8O9pMqQv1WFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO/oSp83OKNjtJ5AIjFDiRaj/mKQDFHhEG25OozOvw56dmAmAsLm1bei8vNuyZYV/hqWXANZW/i2sWl6BFh6MEgtxwZZw1C/Gy0ynbnXRpL/+dHLQssWZTshXJdw98Wb8mM0tM4Yb0HjivPug9iGdH3jn9CxhaMliiQgI90yDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpLeUUch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpLeUUch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562AC2BCC9;
	Fri,  8 May 2026 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214090;
	bh=5il15HEwfN3oGfa4IGpnL47xhPzSBu8O9pMqQv1WFQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpLeUUchx9R6ift9jXV6hz9kmMjFwtQfarufJ80L8cLwJNV9gcdmvYn3wsHFxB9or
	 GNiphbcFR/brm5YqHq+lOU/FZDs6+62Rbdgass2mvKsR1WRjHP5jar6y3AmBmSjBuo
	 kvE/RWiKU7TmYwlL43ShyDgyN6tamc6b5aJXCmuJiU4SzyjxeecMkZh4BfB5MGVHaM
	 /PrpvJgzpJtiEO3ajhVQ2VGGF/317mz5GfW4fn+7sjMb38feYSuDeRRjNVVKn+T0Lq
	 uk1Hsy0+lnRELWipwnNXrBkj67gTeZJl6ZkbpiTW/skHTomx6kyosWQ8uj1vBKkaNP
	 x5w/b4PrGxhnA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5328FF40078;
	Fri,  8 May 2026 00:21:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 00:21:27 -0400
X-ME-Sender: <xms:x2T9aVJn54G9B_fz3Xz7papmXs9WLPhNy1KkCm-V-u9aWlYWW9Xz0A>
    <xme:x2T9aYSwj7_u5CUPL1ZrsxeHOG6MA62h9x1ha1qAio4UD8iv89gQV2aScyQDC0xHM
    WHotqvLzKIAbIMt_jKh5V99fRKoyPVadb1djEISqemGEHcWfb2gaSw>
X-ME-Received: <xmr:x2T9aQCXDJ7PTHz4P3cmxI9fUbgOZyJqqmU2CWIQhW-pXrGxTzJyU0mL-NVYuMA_z_VtrvzPS89vz7Ekc5MiVGBUVzAOEb5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekieffgeevhefgudffveffheettdfgkeeilefhhfduhedugedvhedtteegvdeugfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghsse
    hsohhuthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghn
    shhsohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:x2T9afLtR2gkbaEPzeY-rnHuCSgtdqZTVOYYM4QQjddZw1GTGcXpLw>
    <xmx:x2T9afWpeiyLNF14FDDcqPcpvvqse9J1Udh8I2UWe4MqCrKgBq5XAw>
    <xmx:x2T9aakxZ8NkvzTomrL_wyh5DmAI7UDP9sTd57oJw_-sZg8GdHC7NQ>
    <xmx:x2T9aXD9XRtXx7KcrvAZEKwB-RPzIEO6wol08dBf69ilHhz_nXVf-w>
    <xmx:x2T9aZATvx7rQEyUrNV6TqY0xCd4hQ8ErhCTDSGZh-iRW895aKASoICe>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:26 -0400 (EDT)
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
	Miguel Ojeda <ojeda@kernel.org>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>,	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 07/11] locking: Switch to _irq_{disable,enable}() variants in cleanup guards
Date: Thu,  7 May 2026 21:21:07 -0700
Message-ID: <20260508042111.24358-8-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508042111.24358-1-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
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
index 66fa699fff19..cf5cdb8b272c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -574,12 +574,12 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __acquires(_T), __releases(*(raw
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
 
@@ -594,14 +594,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __acquires(_T), __releases(*(raw
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
 
@@ -620,13 +619,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __acquires(_T), __releases(*(spinlock_t
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
 
@@ -642,14 +641,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acquires(_T), __releases(*(spinloc
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

