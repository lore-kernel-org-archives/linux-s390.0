Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22662DEA8C
	for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739401; cv=none; b=RGoniEbdjq7dce8ItkoKqBuRvVl7M6GIcFDAA1pNSBqIC+Y9osWB2Ien9ZGrYLTUjwG4gB7j2o9Le2mP/9/vrlKB8LRDYBTV1NWRjsdJUXigsrrwCLmc3l/T8b2PB2Ed/bS6p9SiYvbCZ6CZATtog/NeXN7vnJTmnCX+RQPDZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739401; c=relaxed/simple;
	bh=pWT1cPEvuIsmQo6GtAuGEsb57xm3hz5gYaHUhJkIbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEUBtcghU+km49+3oEg8kzBt658m2itnyxeNEmK14tNL25yRWYCE8eq9xtxlT/2UX3jKOLRTRubBtMdqYZOINfaELywbXGCslgfhaVnpJnrgKOxI1BefMK8waIhZ8yXQX07/PcdhqSZ75e6bSlZdjZlQY2yO/RmS0H7p68/miso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOn9kQGZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOn9kQGZ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso2941402b3a.2
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765739399; x=1766344199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g+gpMOnc0vQHF+ukJzfO2USCcKfWV/qKZdEDby2+sQ=;
        b=kOn9kQGZSX3npLPN5nHCKN1zSf+ok3Rj0BH+BoQeS9GPeUDjkExnThqHyyJIXddEuM
         Tmjrb9JwjwFISHaE6TiqSPjB34buyZFtOz3dPjhuqEG6W+sjWhYPlcBnDW06fGWRZ5UO
         0dBzDOEwaZylnd9u5cD4q3Io6KEbIDWJUcJlQuwmLimTEMBgFQOYMDnot+tHTmOa/Goj
         B9uaqy/9RjZhnu/EujCpD6Jeuc0a9MZSUKmdUxmcy7JA2ZreEByujs48jkTgm+yPbJWp
         yPP6jzgL7jGaSG0LmNmOhAabtUttnCyLHuLXizy2WsF4WfUgIWpTXjifAxxBwJJA9YAp
         IvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765739399; x=1766344199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6g+gpMOnc0vQHF+ukJzfO2USCcKfWV/qKZdEDby2+sQ=;
        b=PJD9mAvz69yrYQZ48bBQri64clXzVlT5WK42OhYwSp87FBvFs4+BtgvK9/VGplX3ta
         mv2B6eZAr7EFHaXOK0ary96IeeIoD0dU+vKudv3ZLeDWuK8392+4KF7L/z5x/N/BPJwt
         uXhMcIYn0WsYhT8+X+bw0ryrPfjz1idSucMyYowZiVG/X1mf0igzWBMf9jegLEQ69Yds
         A+B8XkRRnBlnpoY9dqb4E6o3ig6f9oHl4zzJXzVxfkXvxD2G/Vic4/Bax7vcIPFiWvWx
         8+WeEoY1Fc46d5rJetrOuxaAJyIN0cP/tjqhZYvue9sH3a1WosqR7BgoRXbVKDlz1kn4
         e+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXx2NeW5D9YwKGZKv0yOopaAUlLhZBfzJvGGrtwOjWNWWFLvM/HiYQ693sL5j0znBusa0FC74u+J51N@vger.kernel.org
X-Gm-Message-State: AOJu0YyNkMvFjIFpdHHNFSSup5HdQNz+6PR0jdaMh/rYO6iUsmi05vh6
	YNxEyDr9OiZzjxYfhy70fNG1NG1bX/L4yYK3EwUJI4qvsu4cQk4MMWW3
X-Gm-Gg: AY/fxX6UaHxFSHjBGylbkA+rQ0ZoFfnErQjSwpN2Vq2D1E2Oi+JV72ZD/N99G86lTWk
	64aeTAkgVkwemqSxFj3VOukSj6oapNtZ2UitkDPX1jdfmCZl1IaHrrQNAbMeidt7JZVATEjZfbU
	JFGLXQVicQwxIoGLcEspSDUT23I0SVpk6NQ61y4kR6ZYaP0CkSo68m7LPdKMB9UpROWfzzdYDh4
	kiUHtIht+pDwG4E+vb0amjUwjUtRjPBJCY6h86qL8MYT0Qby2Fmh1Ec45c7+2ucYDcbj5RyAvfp
	DLBUBx08sgHzwTI1WDyKWh4GFFKnfnO9awfrJFrTaQEWX0jpJkfTUN77HuwNrqyQelDBaKBiK8E
	vbXrpcP8VZd4MJJevtai4UTQbaVrSaaF8K8b6eaVbNkJWlvMvp4zCs8FKKgp323Md8sbXaKBg+D
	7QTCtO3dMYx8bNG8mFeRS8mp8YEYnXmJU=
X-Google-Smtp-Source: AGHT+IFEjQ5W/F/1GV+Udmo7P6q8cvk4k0ZspkiPRW94iOHQJNGagX56DVsdqgrn7t+EEED1vTORKQ==
X-Received: by 2002:a05:6a20:72a8:b0:366:14af:9bbd with SMTP id adf61e73a8af0-369b07ae5b5mr8721021637.71.1765739399013;
        Sun, 14 Dec 2025 11:09:59 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a1c5esm6909062a91.3.2025.12.14.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 11:09:57 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 2/3] sched: Make raw_spin_rq_unlock() inline
Date: Mon, 15 Dec 2025 03:09:06 +0800
Message-ID: <20251214190907.184793-3-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214190907.184793-1-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
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
 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be16911..20146da3f181 100644
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
index d30cca6870f5..bef6cb13266d 100644
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

