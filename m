Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B630F7F8
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330963; cv=none; b=efjl24LDNoSq4EN7PCEOnah6Qcvpb9YeKp+fj/+JANxwF/4MRS7AtVmOZqTJ5du/QAwfqV3K5taNYHt1P0wwHhLWXABWH1gfXcZuYX+ibzeNi/9neHbDK4jggMTy7EpRCh2YKGs0gQLweDJ4zwq4rOFjTdhcP/h/A6iUHvmUa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330963; c=relaxed/simple;
	bh=e082r4kTfLA0aLgFTCWcX+NL5EgNNmKTh51Ro59hkR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO8KtbQ9EWhmnFlzMm4aFzgKMpE62LbbmLXLwsmMbGVowJu7TOhjEkVod45bwWhP991c2thfxunqLcX58jeMVUrH6qnu74iP4LdIJmNpwEY7BFaeYgrfjnjJqODioblTArQd+IS7cLVSLk4djUZcaGXfJJW96BBvJxTf25oVvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvTbg3Jj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvTbg3Jj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290d4d421f6so22315895ad.2
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330961; x=1761935761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw14jVuf7BqeO+cDKjQTg5GGuEVAt7PwD+gUI7IAUIA=;
        b=ZvTbg3JjuXHrseS7A8JtFy+f2+lGP0o/jbK1hsn7H3Vf0ZOAwgYTV3+mx7I76ML8oX
         rZ2WtcTq59dOKyW7+DVn9+AX/smhr/6Vh1fIW+6PM3wusl/FONZLXBDr3Wqg8k8mTfHZ
         SSdZk6Ac0CbUKiRST6geJikFcMwUvJqpyLqIcgvYEageuF2Fceffqo5qon+YVEYm0aCz
         1p1BEAeNJ82LbbiP8QFOeZJs01IQg3qWMQNo7O8Hmv+YfGDhBYFviy92Fc6YyUVKSRy+
         oXEHJAmpzKB6rdydirZYH4H35CbvxcgLglzjjMc+xVFrKI84s2TZwb6gTChQD25ECUG/
         aVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330961; x=1761935761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw14jVuf7BqeO+cDKjQTg5GGuEVAt7PwD+gUI7IAUIA=;
        b=pNbSR9cgAT4kvImDcDemDzGd9dWUKkshmqd9vSA4u/1cZWi/YqHgPHuY3Z/aaz6eeR
         c9i4w5x6PZeueYlSKylyd18XoH8eh+NSrUueId8C//vOb4v/CAS1r+V9JpLZkRuhKp6H
         bZvBXmbuEqXs1la2nVHMxwIBEoneYPDHF2GPnGva738CLCkyn027H4ELJvxN3fYZEzsO
         7nvLolBh6qpZrIuu1wbx/XdmEmq7hH2xmDq6lKHtFjxYPuhRUcFbaw8STzIUruVjDLk8
         F5xXKcFPA+E6J6FT0Qdtq8/PRMKLJZsNMWgB2FZNi01UMz1YVOBtmLzsVhv1n6hyclm8
         z+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX2cw7hHIKtp8uvBuKPs1IB95EgMWfAErj1NVvYhrL5ngP0mKR2M8VhU9RwHzRVdFKzgj1B3pGdv7tW@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6BvdISEjtPydOkSt1fC5AbUTeDE/VKjlHA1HFqTPczZCBf0n
	0kdid4ulCsxP5N4uu6JTVXxi+3jTLWde9ey+vNXXpg2CLNT9tDiam7Bq
X-Gm-Gg: ASbGnctKZP9HLnqGohJUMMJNwB6QJMp0wp+yW55JYwQOTszm1kw3nn+Ghjt5PYXcB88
	a7ars0jBChADBooDmyTDGW9hHOeOG34y27bDPDo4F5lhMPL9QQndGGASp/kAOtzGJEk9VJSnSG8
	TKGU0Mg0DXRp8bQgpDXbmu6D3UWVLiwsblQ5Ixjpid0FvJm1KKcIcrdVnhZ0rWMsEp3P2BlVAcG
	4+EKBunfKaUImf4jrLqNwQSb1Dhvl913Zasjo9FvMUIwg+lH1OlFDfD0TwQIszaZMF54hQbscm0
	E11rgdK0pJ8YuYhUOS16sm67ze7XCCUY7xfkuojWR5TOXghxfNbshR5qkO+tpu012MFz6UFeG2j
	IoQ8qmFhPEGTrD0BfdQ4E+XSuqyj/ym7g139UTObfjCJRc9o2F9D8v5NRdhaY114/1K5hhJYXkF
	BaTmYrX1IVpmuRNs5HaeMAtp0hV12RWYA=
X-Google-Smtp-Source: AGHT+IHx41IImbCDHn2Jdh7zMNuF3nPpqYLXXAVHuVL/C8w986MehdGPWmZ5hrXWnJ9gl1uAvj5v1w==
X-Received: by 2002:a17:903:18c:b0:294:66ad:113e with SMTP id d9443c01a7336-29466ad11e3mr111410385ad.47.1761330960942;
        Fri, 24 Oct 2025 11:36:00 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2579e2sm62725945ad.111.2025.10.24.11.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:36:00 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 2/3] Provide and use an always inline version of finish_task_switch
Date: Sat, 25 Oct 2025 02:35:40 +0800
Message-ID: <20251024183541.68955-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finish_task_switch is called during context switching,
inlining it can bring some performance benefits.

Add an always inline version `finish_task_switch_ainline` to be called
during context switching, and keep the original version for being called
elsewhere, so as to take into account the size impact.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285eac1e..6cb3f57c4d35 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5069,21 +5069,21 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * Note that we may have delayed dropping an mm in context_switch(). If
  * so, we finish that here outside of the runqueue lock. (Doing it
  * with the lock held can cause deadlocks; see schedule() for
  * details.)
  *
  * The context switch have flipped the stack from under us and restored the
  * local variables which were saved when this task called schedule() in the
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch_ainline(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
 	unsigned int prev_state;
 
 	/*
 	 * The previous task will have left us with a preempt_count of 2
 	 * because it left us after:
 	 *
@@ -5153,20 +5153,25 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
 		put_task_struct_rcu_user(prev);
 	}
 
 	return rq;
 }
 
+static struct rq *finish_task_switch(struct task_struct *prev)
+{
+	return finish_task_switch_ainline(prev);
+}
+
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
 asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	/*
 	 * New tasks start with FORK_PREEMPT_COUNT, see there and
 	 * finish_task_switch() for details.
@@ -5247,21 +5252,21 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	return finish_task_switch_ainline(prev);
 }
 
 /*
  * nr_running and nr_context_switches:
  *
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
 unsigned int nr_running(void)
 {
-- 
2.51.0

