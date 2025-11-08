Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEE255F24
	for <linux-s390@vger.kernel.org>; Sat,  8 Nov 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622758; cv=none; b=bzgqNZeDY0RotM13eklNTUzP9QWIqV1jGghfFV/hA9Ux9yOqbWeQG5KrP4lQ4q3du2h8oufcLTJ9GrxVE9deihI/K1Dp6b2x4ZK+hdBwMyJuPp+GNG+/I0yXQSKj1zcgMkyhFImAfwRKBkiRu7TIBvgkOV+v3Cx9CclKa2jzcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622758; c=relaxed/simple;
	bh=+z69aBAj7PeYbAZxC2mqFkm9oFXI8oBi1usMI/J9M1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgMRLE8PLBf6nVaHI+aujthEz4vwYOU9Uh7KQJfMPM9ms44IeNabS1EiNsoOvrj7M2pwa9LTE6utfY744gn02/TjEZz3TRYLuHoDSW2i1vyfraWn+MOOI9xGBURSYxSS+mqYNfizs075u/LZzRdxG2WhjAEO3oQO0ABofZS/yJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0WBlict; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0WBlict"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3434700be69so2313015a91.1
        for <linux-s390@vger.kernel.org>; Sat, 08 Nov 2025 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762622756; x=1763227556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5bwZ5Z+zIq2ecop9oyYTCXszFNgUcbYI97Mt5lZei4=;
        b=J0WBlictv1UtOD3c6FrOLvgRRDmKVVQESK5XNOfl6LVTEaMUz8oU52DH2QUtAB6m6j
         RhneXNAIZwI2zDSKqiXLLZVShgQGRc7mJ42sjmmHHO9NUgivOil5GUUF3vrrPCneTykJ
         YmC+sPMwl+m4vX6OWNlwiwFkGOLsF9M+uMsiaNS6SSreA8xY/nQWq0MO48deq0uKkZDs
         f5vykvjpMewrZVZQa8xiY5IGQAYzgDqkUe3xfPy0ouDWHZP+mLD3cwGQM4PIfc0BVSzT
         LNeGPAsi+O99PGJ7ALkAnnJ487CHKDXxIjAWlBqcjtXPj/3I95EHab+a0MwarEmDw0dl
         ULDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762622756; x=1763227556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5bwZ5Z+zIq2ecop9oyYTCXszFNgUcbYI97Mt5lZei4=;
        b=AYyxzWSnQjhvvYQZlEl8ar2QyJou2DnACKMFMmAeKaJol1lUNDvohsYixBf1WGD5jX
         sp3BvZgnqjvqs4f8gl4fWQ56LNfCOYwJFqA28OVK+MI8E4+z3QATClHy8x0EZKflinNn
         0G3AHv567D1FWR6KkMeOtQ7rNdv9Ka+lDOA91LmQe9PEMbGHK7AXcdSKgYsXTXyPiEee
         zbIxLgfI66i1FbzURwxqmHew3xZBP16QDLa352u7MnqaJEqWcwP05ekID4MGfki6GUv8
         weElW2D9WsaHtk5ZpC2qP+7KZ6cszbF3QuqrcMZ+iQbMNSTI3Pzc9TTA7ZIuJacfbgU5
         Orxw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3DY4sd6KUmp1U7kAdCf3FBbcK1KqkS9t/UZqOJ5IrCCwEvKb5TSnEpTsr+wyBBSajZuXZ8/nCtnu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ul928fGgcNjqRU+ag/u+WfoH4CnXiEyu9q6Au6VUJitee/ff
	9VdMV1Vkr8eXjCWQhWxMfMY9CJU2XeHxZVPC5pelnt1G38EfFXzXV6Gm
X-Gm-Gg: ASbGncvCleB6cCPCpyP1BO2NDdCUgCkko64X76r4Rnv/sb0DKYlaQwscBRmJWXGnAEF
	MX0PhAiqjkSd4TIi9OppSQtU/hv3bLjcBJv/n2/CNx+jHYssFnogRCJbe3+pBTjyb3i2T1FiTUa
	ST6N8mgtH+g36ssvzuEecJf8Wuaect2L45yc2zWUMyEV94aXrfVUhbkhok1Vi21rcfGdMz1lifB
	agusMR/3X3pJOTmlBvivZUc+rqQVkWsb9cU54pZgdPTE5lO8w3t3ZiPu6JHfKcnc4X9lvQbl8fM
	VtVHiC0wQSPVo5Pm4RroVjw4uDka/C97ofGM9Lrd+bJqM4y2kS38sJx7hg4vaIZ76rUUXYwNBNM
	JM/MwrwvE70GxUROJC7//1Rw0qg+dhpqYvggYzYRjvtJT+OVnxk0f0s902crH1MPrhmHTbZhC/c
	smwA7ALW+UnRsm8Q8tq22BnaGJEGAKj1kF7IY=
X-Google-Smtp-Source: AGHT+IFzryf94me9ukx/zbL0xbjMPFhvtV+1CTMJbLmCIUchy3O1OLGY4lLG83s/d5GEdAHNinNGqw==
X-Received: by 2002:a17:90b:4b04:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-3436cbc9436mr4012371a91.26.1762622756323;
        Sat, 08 Nov 2025 09:25:56 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm2769122a91.7.2025.11.08.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:25:55 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
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
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
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
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH v2 2/4] Make raw_spin_rq_unlock inline
Date: Sun,  9 Nov 2025 01:23:44 +0800
Message-ID: <20251108172346.263590-3-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251108172346.263590-1-qq570070308@gmail.com>
References: <20251108172346.263590-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is short, and is called in some critical hot code paths,
such as finish_lock_switch.

Make it inline to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81cf8452449a..0e50ef3d819a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -677,11 +677,6 @@ bool raw_spin_rq_trylock(struct rq *rq)
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
index f702fb452eb6..7d305ec10374 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1541,13 +1541,17 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
 
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

