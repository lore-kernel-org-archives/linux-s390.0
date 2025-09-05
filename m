Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1625287502
	for <linux-s390@vger.kernel.org>; Fri,  5 Sep 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063351; cv=none; b=tRP+xOmHiVEW80zkq4DRFNmi4Wm5UWakySa+zp2JBRdl6ED9J4pjh4zO4W+FR+iZCiEk/Vndf9Zp/+3oD+aDreEF3dnGNDcAe8CA++TZ1RopBi4LULD5F9KylyHh0d5vfWZz5Nckr51GeVfsjPMUJcZkWpp3Cj2oqErcnaMcIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063351; c=relaxed/simple;
	bh=b/+MOpMmP/GIfKr7wTa1E1BNlwW6DNYUo8mVwHKUgBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cou2DtUwSrvz85yCedK9PePXM4SCxRMNsJ9quTBzJT54jqX0cdKj987LtpExH8LeWt9uvo7BeUTrfvvYeKMcUCEhO1Zi1WhAGY9wfxppLpXUjHm6t2mm3XPOHxRaQHpzm8Fk8QUnFgu23ZdwMbn893IAKQLvjVXm97duz8xeuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=So9XhtQ4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="So9XhtQ4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1261055f8f.2
        for <linux-s390@vger.kernel.org>; Fri, 05 Sep 2025 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063348; x=1757668148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M5qxE3ItNC3Mnz+ynWNndW7FEsZCwWL/Y4p9WAoVvE=;
        b=So9XhtQ4HbtUkWbI6JgJcbA07cMolu8XLIO8hxW/aNfarSoJr/nZE9H2zR1ZrL4/h5
         31IBtwyDwV1+jisPxLDUCjixjV4pmCBsoq74yM0sJ7TDT32Kp/YGer69BXKuHvatUAhY
         GB49Dieu5GQzFVQ/iurwwwQwRvJxRMjUitZBxJtoBd/cXDynGkJilwCaLK9oj6gjmG/O
         kb57yDLt5hE5vVt3XnPyYH7sOul7LkQHD21LTpz4Bl6H1qWIvm5/SB4K8d18aGkUjsdk
         xULIN5+2sVbG3morvIQGwGIF4Diu1S7tOYlYJslUsATv5Ltjz/itSfs3GR1o+lSSgQZ6
         t4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063348; x=1757668148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M5qxE3ItNC3Mnz+ynWNndW7FEsZCwWL/Y4p9WAoVvE=;
        b=E49vbtslNwJ6thIwNbykelkLBnyRakOJSVvArVwq54G/YRsj7TTZAvFE/y/uJLYRAH
         xOQMn9/oF6C9Iv3+BHvTu3Lu9oOEqUbXVlZLnl/3uZIvZuHZmInAKoDkVRU7sfHh5tKQ
         JPVKamLzpuv8WeXUTZc5X/Oo2i/EVRLzbX9s3bPZjXXDtD9GxctjccHza+ZiUZ2cP0Hv
         T72hSZ8bTL9mR8DT6PcpIheJT8OilubMe94sYNaOB6g5DSNHsc/20uKaaKvctl9VkLen
         Kyhu2I0XEenwAtGB5qz6pZ/PwB4XbaSDqbB1AetDUPUcpZhINjArnmq1R5S4rQsVD7O1
         Wkqw==
X-Forwarded-Encrypted: i=1; AJvYcCUnGJYNcndQOFG+KwI6Cb5SGXkPK4a2pWkxCuH4v++eHSL+4lwZq/Yy/JSAcBRE0IPF3hFGm1d0Pk92@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FZdHsBEuZqaO6tetPwY6FX8Ma3gYOympPQWyZfEHrHXnTL0X
	ra0RqpJ9AOAfmK5vy57t+TUpsRDgK+EqI236zyzmm3ujx5iEyoryhrRrx5xqh+GlY7I=
X-Gm-Gg: ASbGncs1bJYbf8tre8YAgvq2OTaOBaA12AN6rsD2Gu5F5wu873C+B3fPacj/h3Qf3pU
	uV1MOIX8jck0mAwkqNK86SBdxCxILV3hzTUZnevN3aUCZdXkgdOZuLWiw3LOabcj7OLunSSmi2r
	Bt+PX8nkuWIcxaKVvTIfduUmqrPnDdJoZ3Wu2PCvu5MtekW5L1K8pwzsEIRmJGx6QHUZJEdHGmj
	2Xk3eDb01Az4fV3zifMnW93aqdY++/T5pK78wwWxKuulP95PZSHJlIesFR0A7mn5AVsLdYQ6duX
	Q21a94uHwEA5zJEukZon+d1WvqoT32uQSQyBUjo41iwW/PB0UtJOqJCnbnD2sGD28EzCMnMFU1f
	GlQg4IsxhrPh8wERUzPtGkayw/T04d4f+0cEe5NjE7mczHr7sqEr4Q4fymw==
X-Google-Smtp-Source: AGHT+IHgs81iOxB8/hn8VA8Mb3DxvlmefAcfwUJkrY/1A7uC4lmN4hVFGgcv1OogLAr+V7yPhyPC6w==
X-Received: by 2002:a05:6000:2308:b0:3d7:abf7:24af with SMTP id ffacd0b85a97d-3d7abf72cecmr12599967f8f.23.1757063347795;
        Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:08:57 +0200
Message-ID: <20250905090857.108240-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090857.108240-1-marco.crivellari@suse.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index 7fa4c0b7eb6c..f0a8b4841fb9 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -116,7 +116,7 @@ static void pibwork_handler(struct work_struct *work)
 	mutex_lock(&pibmutex);
 	timedout = ktime_add_ns(data->expire, PIBWORK_DELAY);
 	if (ktime_before(ktime_get(), timedout)) {
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		goto out;
 	}
 	vfree(data->pib);
@@ -174,7 +174,7 @@ long diag324_pibbuf(unsigned long arg)
 		pib_update(data);
 		data->sequence++;
 		data->expire = ktime_add_ns(ktime_get(), tod_to_ns(data->pib->intv));
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		first = false;
 	}
 	rc = data->rc;
diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index e7b66d046e8d..85b5508ab62c 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
 		return 0;
 	if (hd_online_cores <= hd_entitled_cores)
 		return 0;
-	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
+	mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
 	hd_update_capacities();
 	return 1;
 }
-- 
2.51.0

