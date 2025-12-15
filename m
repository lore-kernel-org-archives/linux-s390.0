Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB682C21FB;
	Mon, 15 Dec 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816547; cv=none; b=G72HhgcUEq7uzXMy0kB1R0R+cwWgYLYDUwFMJRVGik8ECXuGBH3HexZ5SfTPxC/WmiwerU4OqRdjL6Wfl+m/1maLeaLZ2yqrPq+6gFiZQKhtl3Gk/AMXijWcLzfE4gDQzVGjRj8JeMqFCjgn/EeLmMXPo/8bG85w7X03xEnnqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816547; c=relaxed/simple;
	bh=5YJChROSh+unZNlq0l84LRHUsrQFCSp86rmYxmvAFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8W+FaXkHHhsv3KdVjDrESNop+c5UC4e4GkmVWQqVwT022tl/RCk72fF8p+BEZ6xugbTL9+aGgffg1HdhDP1pt4LwNFZU84uEVREkdF+CtNryPueyyeWaTojhPsJcmxe53cZdRDJ2rBiEl7DLJAcm6S8j1Sq/KTrP9QkgypxVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0FE8165C;
	Mon, 15 Dec 2025 08:35:37 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 992853F694;
	Mon, 15 Dec 2025 08:35:41 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/3] prandom: Convert prandom_u32_state() to __always_inline
Date: Mon, 15 Dec 2025 16:35:16 +0000
Message-ID: <20251215163520.1144179-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215163520.1144179-1-ryan.roberts@arm.com>
References: <20251215163520.1144179-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will shortly use prandom_u32_state() to implement kstack offset
randomization and some arches need to call it from non-instrumentable
context. Given the function is just a handful of operations and doesn't
call out to any other functions, let's take the easy path and make it
__always_inline.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/prandom.h | 19 ++++++++++++++++++-
 lib/random32.c          | 19 -------------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index ff7dcc3fa105..e797b3709f5c 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -17,7 +17,24 @@ struct rnd_state {
 	__u32 s1, s2, s3, s4;
 };
 
-u32 prandom_u32_state(struct rnd_state *state);
+/**
+ * prandom_u32_state - seeded pseudo-random number generator.
+ * @state: pointer to state structure holding seeded state.
+ *
+ * This is used for pseudo-randomness with no outside seeding.
+ * For more random results, use get_random_u32().
+ */
+static __always_inline u32 prandom_u32_state(struct rnd_state *state)
+{
+#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
+	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
+	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
+	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
+	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);
+
+	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
+}
+
 void prandom_bytes_state(struct rnd_state *state, void *buf, size_t nbytes);
 void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state);
 
diff --git a/lib/random32.c b/lib/random32.c
index 24e7acd9343f..d57baf489d4a 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -42,25 +42,6 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
-/**
- *	prandom_u32_state - seeded pseudo-random number generator.
- *	@state: pointer to state structure holding seeded state.
- *
- *	This is used for pseudo-randomness with no outside seeding.
- *	For more random results, use get_random_u32().
- */
-u32 prandom_u32_state(struct rnd_state *state)
-{
-#define TAUSWORTHE(s, a, b, c, d) ((s & c) << d) ^ (((s << a) ^ s) >> b)
-	state->s1 = TAUSWORTHE(state->s1,  6U, 13U, 4294967294U, 18U);
-	state->s2 = TAUSWORTHE(state->s2,  2U, 27U, 4294967288U,  2U);
-	state->s3 = TAUSWORTHE(state->s3, 13U, 21U, 4294967280U,  7U);
-	state->s4 = TAUSWORTHE(state->s4,  3U, 12U, 4294967168U, 13U);
-
-	return (state->s1 ^ state->s2 ^ state->s3 ^ state->s4);
-}
-EXPORT_SYMBOL(prandom_u32_state);
-
 /**
  *	prandom_bytes_state - get the requested number of pseudo-random bytes
  *
-- 
2.43.0

