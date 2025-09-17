Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72633BB30
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123550; cv=none; b=UeviNPJKYJb+xYqiAJpvF21w+0l+WiAHJIj/T1/N4VonQIaVDKgkCYgXJ3PD1ApL+/RY1GQBQ/q7stkAan4deTklbya1FUshOYnjRUiu6xh9j9PybXuQ9yVCj5fmUm+CXB8a70BFEDf2fkJpTdHWJZQMyUk05C2cCbZS93HSTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123550; c=relaxed/simple;
	bh=14dVJh5LLNSsQMouLJW1+odXPDO7vGIGVZX71yzalWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meOe8Wy1s0z+tlQ+Tw32QY6iNIHYzF3W/q7P9/Mtn6F8xIy4NRc7DfR8cm2gwJBEbv7hOLvVuYti61LY1V62HLLM0ohw5srToDusJcvVfZ/prSdT3fU0yhxbWUK26H3eHMvV0l14Lfpwms5ftdtc8y7/aW3kjkpAwehIQ+QBI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DP25JFl0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DP25JFl0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2f10502fso21872085e9.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123546; x=1758728346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQMKJhlNsyXsN8hraKIynod7eK47kKIO6zJUMqoMyYI=;
        b=DP25JFl0GhaujR0ef+QtDtj+AJw8+Lk+PtA4NmIkvMxRsb8Yue60XPCpZIndaWxa9U
         mBF3mCXcS+rJJ43BIZtPGBxC+Of/RwL/oaZhcVvL0xXxNMk+81sI59vbgpdklRF4EOof
         P2Bs5M/7mQyb+J/U4jSgqNx+yWuL5mqKgmgZc++ksKsV5GOSpw+jIzgtzlhORlYSXS6b
         eHFZMFCFeFSjJfoliz0f4qoZFxRyo2bMcsziV60RcXWjmH2Z8L72IBCLVOVWiaE1bV9L
         Oa2+VitzT7cpGustpDCKVRtW46CsugVxW/MWn8BDm8EPI/dXFUMzHaFgOAbN+RYxS0N2
         xizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123546; x=1758728346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQMKJhlNsyXsN8hraKIynod7eK47kKIO6zJUMqoMyYI=;
        b=eQSmzAJr2ZsGXG/sk+oKzLIspvZ6bI6cLeH4JTrUqoYSTLMAc5TPJ9O5bsuLMvnH8t
         FMU37+TiA7LFk0O+SRdHVdVFKafGnJd78Eq9JcyScO+FSPSVQXtRRImCtuMqdRpJzHz7
         qlzPlmzCOVaB/eUCn0de3bHREPYjAvNFgd+YKDJfKNkOfIcMesSYAA3AEJ6m5jND+b4H
         lu5c7yQWbSfsxajN4STzFgXAnAJEw0RWW6JoED5c/SJUsySkTlobbgo79iiK4zS9MrdH
         xpmTSeCZNqIylYfWnqUO2+Hkfq9GuAY9xWy4TUn0WlW9n9fY8yWFzjcJHVS+zqaixzj+
         aIcw==
X-Forwarded-Encrypted: i=1; AJvYcCWe/mtR1cZAyq22STq5lenbn4K8s7SZrJGYGXyuJ/QjrjqInaMSPjSkAe0uu0aSxo6TEQrk4A6DTjfl@vger.kernel.org
X-Gm-Message-State: AOJu0YxVp39TroDg1QoJKKeZC9VDjo5Jte90Bj4/MPP3uheSD0jgpN9K
	BjR26zxu6v5/mTs8gAGrKVE80Q2P33hOdEmRLKU468+uKUOA9qhVSuMtlQLBhgxYOL4=
X-Gm-Gg: ASbGncv3nR/qlrjpNLquo0XuGrLV24Hj/LMV4WiXXW7cE2rXRLH1nCkr+VTRTtZ5Opm
	UGz9EJQsPaBmU1SZymnhJSpVn2ec+9zQjjYrICsC3KtfWCdzC7uhWOTg18H8fDJ08bi8tsEs5Vu
	kPDHlxYgnuOgxaJn3SmnW2IpskbCiyluuV/6pt3HDut9vM4JLPa17TkYo5wzs5g/X1hXUYnYZfR
	0YewJTN9DwF6+4buXMsriFxx+KyepymyGBHBbZXsMregY/8ztEkAK49ee9vpDDH4CbWCDiUYoeZ
	fvQ19AYem49fQMg3qm53RdS5YqqoNeMiW/gHJ6/5S/NdNCiSllRI2g/AuPq+oPA6VuSRxZIax4f
	q50AeN9ED5lnk+CnMszNKysMvwOCeD6Ziwk7nKehUBaPeYec=
X-Google-Smtp-Source: AGHT+IExlJvr1s8wpdqGiMxNMltp++fzMVipn3Ukanng0vmVWhtAsTfmNFFfXT3S2vlwQa79qdLk8w==
X-Received: by 2002:a05:6000:400c:b0:3e3:4863:5dfa with SMTP id ffacd0b85a97d-3ecdf9aeeddmr2127444f8f.1.1758123546212;
        Wed, 17 Sep 2025 08:39:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drivers/s390: WQ_PERCPU added to alloc_workqueue users
Date: Wed, 17 Sep 2025 17:38:57 +0200
Message-ID: <20250917153859.363593-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 drivers/s390/char/tape_3590.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index a1bafaf73f87..2a2931d303cb 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1671,7 +1671,7 @@ tape_3590_init(void)
 
 	DBF_EVENT(3, "3590 init\n");
 
-	tape_3590_wq = alloc_workqueue("tape_3590", 0, 0);
+	tape_3590_wq = alloc_workqueue("tape_3590", WQ_PERCPU, 0);
 	if (!tape_3590_wq)
 		return -ENOMEM;
 
-- 
2.51.0

