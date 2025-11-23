Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA61E834E
	for <linux-s390@vger.kernel.org>; Sun, 23 Nov 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900501; cv=none; b=KVUQqx/tKEZunazRA4oQcrfeUocWrAqdM0Ve34caN3Ye+5w9PTKrvDYlpm8eRBwETMwmZmn6r5V4G0CyRvD1tXQEzsTDLB/2VGctwtCCowe/j3Td8Ds6JqVA/GUL3FL6w5/dBOBbM2rR5pJQaAe1mQdfAxz1zyMc72zF0dzOi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900501; c=relaxed/simple;
	bh=qzv7MNEPESHaBf9knR8U9/ufN8T1/b2k/bwA1Kzg0KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+SuRIEqW0mMx9FT0HDALenRbLPSlysPgcx+gPCMJ12v7JUWy0Koxl4Cvx980YbiDULGbDDtoNeYW5GMDepZJI2iW40JkLy8wTVLZX7+CfwGoZf60LzjfBPw2TIl6dMtJorESV6UpL6UaX9HtyDs0noZ8ZoZVzBp/SgfkTsGKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRUWoZ4r; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRUWoZ4r"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso5342586b3a.2
        for <linux-s390@vger.kernel.org>; Sun, 23 Nov 2025 04:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763900500; x=1764505300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gehuDY8hCnCk3Q8zSl7CeP6iDX7lw6Gp8zKZT6EL4m4=;
        b=GRUWoZ4r/TrxsgIyh13EV8WGN6lYK3/aH2sZVLHAeo36Uityo/yhXap3a/y9U5EJrS
         t21+QWR2WH5zUvz17SzcmQkc/li4G+A8ZaLBxT8uOW6PTMUmHJfw0BU6TPmjj2P/rvRC
         j6I3p5rL8wm01WJyJIerfKRP+tZuq97KpjnSkV1F8hEiGBALpT9B5HLQ97ca6SnW3c9o
         vp549IRwuSrTYQxthIj61O08HeEqrx4eht73R6pBgHUHe/h0P3X1ZMpusiToZJnWpZQp
         foogqfTDoDnAFMuUuCbUs1Fga2+Q+IksXUSrUPt6oDH4e+kareDg12A0TLYU2bEtytGd
         Ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900500; x=1764505300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gehuDY8hCnCk3Q8zSl7CeP6iDX7lw6Gp8zKZT6EL4m4=;
        b=ciRliLS7RxiGZY2KgZDjQ1oQc96bS3pdUJUZHXEqy8Tj/KFR+4276u585FsfGhS+Bz
         Gkx0B+zAQfo/Jfy2n4uNJujOBlW4oh0X1pM+gTxN66kewXjb7QhDA0gSdA2KFuw61avU
         9iMbneinrBodmKI3kZEfNwk7aSlwfEV/6ol+zVZyQ0Fwa8dRcnN0uaqv8AlGWxQ5jFcJ
         3NXl/Sy9fn5xxbd3JwqRyJw2vrgF5/sJyCXjdLOSE0XQhTgFJJ0W6t9/IvUh6Ps2FbzC
         VguElFDcxG+Z0rmwApIuofIqMXyEiog16oJb2L/WM4NGAp/mtTaOi/LRByOefwHRHjfM
         RMew==
X-Forwarded-Encrypted: i=1; AJvYcCUYRe3kJdLuYZ7vlCiSBU0GqcQ47kAcowRtT/gSk0onohCNxAxB0oUfvKIXTcUkex6c1REGskoHRT4E@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4ko364yMDldxbGQn7yjtsBnfGE58AJNG3abvlzKKwab1+6I8
	Hc84sMY/ZEYyWw01g0N+UfQYir7Ag+pN/5v8N/9MZ5TxGbpB5Apkfdr2
X-Gm-Gg: ASbGnct/9NwsbzS8kYtqh4xzMBXvUfabM+RpoxdEEAO6T70i92NdWgWR2JCqm8P73eb
	TmYL6BslY9BU6FtrPsEuu7llNPY4RNRTcl/6JpMbeYYqs86gxGcXTQzsVGiDeNUJw2GAYe69RRd
	UFg6NS0mMhfV0Ny/LiHvnkmmSrM3vNuCO0ksRfvLQFiN7cRfNgYlwzPrfDKUD90BF+YbA0pxmqd
	Gj82WKH4816Bzc2Q5zGFnLYZJgtaR429OjXySnPgd132A/ycfF0/sNmepXg09raLywxH0lNv8L7
	EdfWjx3DVNR09PSdljMmEwA6WNKx1PO5J1HD4MUOCp4122Z43TBU3yejBVoxAJ14ciIQ8V1Pqlz
	ANytIhZlVFFVNuxCdXOIM/vGyf9jiTUs3EC1PdlaeXBIGJpJfy09KzMiel7Ns+axIvmW6Mqfd0Q
	XzJHJH+iv3S5R6Ve0nS1GFzoXyhBAqb7vptJdQrA==
X-Google-Smtp-Source: AGHT+IGKqRo5Rqn/7cYYbwvHMYFh4KwgapmQlfr3dLMTE6/Ihy9Y8y5GgtK/UfE6HYkuLUDpc/O0UQ==
X-Received: by 2002:a05:6a00:22cb:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7c58e601920mr9501764b3a.24.1763900499427;
        Sun, 23 Nov 2025 04:21:39 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([45.121.215.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm11410178b3a.52.2025.11.23.04.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 04:21:39 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	david@kernel.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	hpa@zytor.com,
	arnd@arndb.de,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	thuth@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	anshuman.khandual@arm.com,
	nysal@linux.ibm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	Xie Yuanbin <qq570070308@gmail.com>
Subject: [PATCH v4 2/3] sched: Make raw_spin_rq_unlock() inline
Date: Sun, 23 Nov 2025 20:18:26 +0800
Message-ID: <20251123121827.1304-3-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123121827.1304-1-qq570070308@gmail.com>
References: <20251123121827.1304-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw_spin_rq_unlock() is short, and is called in some hot code paths
such as finish_lock_switch.

Make raw_spin_rq_unlock() inline to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
---
V3->V4: https://lore.kernel.org/20251113105227.57650-3-qq570070308@gmail.com
  -- Revise commit message

 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2931af76405..0f9e9f54d0a8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -678,11 +678,6 @@ bool raw_spin_rq_trylock(struct rq *rq)
 	}
 }
 
-void raw_spin_rq_unlock(struct rq *rq)
-{
-	raw_spin_unlock(rq_lockp(rq));
-}
-
 /*
  * double_rq_lock - safely lock two runqueues
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bbf513b3e76c..a60b238cb0f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1551,13 +1551,17 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
 
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
 extern bool raw_spin_rq_trylock(struct rq *rq);
-extern void raw_spin_rq_unlock(struct rq *rq);
 
 static inline void raw_spin_rq_lock(struct rq *rq)
 {
 	raw_spin_rq_lock_nested(rq, 0);
 }
 
+static inline void raw_spin_rq_unlock(struct rq *rq)
+{
+	raw_spin_unlock(rq_lockp(rq));
+}
+
 static inline void raw_spin_rq_lock_irq(struct rq *rq)
 {
 	local_irq_disable();
-- 
2.51.0

