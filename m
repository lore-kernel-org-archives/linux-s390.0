Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1F28642B
	for <linux-s390@vger.kernel.org>; Fri,  5 Sep 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063350; cv=none; b=YL9/duo2xrML2cRmbJitxlnHmRTkQSD0P/8AmXpM5uzK7ye21mjxHMd+DYn5DhF1jePxMVCTyPON/5dSI0KJK1QrjdJkPoPzyTkTJ9wzn70Bz+Uk7imkw2MNg829pNDeMUrf3WQ7XPMyJ97LBT1rVw2Y8NJw7DFshtJqPD0zdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063350; c=relaxed/simple;
	bh=vk9Cb+Vk9ZtUW2KuwlTe8a3xodP4C8YTSL3zTrsGK3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gP5YHidEFwxrVHHYW3g9QkLrHKXfrPNQlRLGPEe6cinGmmf2XOWnlGUC4nz1J81o3YFoGqq6b5k8jaVG/3d5nsxt6O7WaXqZECX+/pMWdwvYJMrT9+O76tPKnIAwa8TdNHC/I1gGy2ASSJ8DTdauCieJ+c24XoFGELxt6yLm9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pt9LjeMi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pt9LjeMi"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b869d3571so6592755e9.1
        for <linux-s390@vger.kernel.org>; Fri, 05 Sep 2025 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063347; x=1757668147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK0RwwSJzlC/WRnGVCpPlRTi/ItQrFK4FNQp0Qe8tM8=;
        b=Pt9LjeMirypo3z8h/SKmsc44gkIo6ZN9yDsPxxcUt4OH66zqdkDN23EjoLr/oupeXa
         3HzLtyVQ4vpcYlR584kDR8JQExK4zOYYBQ916/43sX+Ofs+5QFR32cwW6vGP0rzgctUP
         E2bodtFwDOz7ZxcW11ZQMH4zyDnuWgSkoWcpu/RGbS6VgS8ZUKmZlBYVDMAScurDz3Jl
         RqsXHn8+SnrpLAOxCQtKOPJH9nnV+dlO9lH8s/PjSzmQUV9mDTElMHgicu0y2Bbv01kZ
         UCFGefygTAZ2ri9W+998vWTXkOX7047dIK0dF9Q3KIL5C4jvxhsmSaWKT0GIdtBHCEyz
         I+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063347; x=1757668147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK0RwwSJzlC/WRnGVCpPlRTi/ItQrFK4FNQp0Qe8tM8=;
        b=d2gmwVkw2eNJPvWX8eKdaZvAbS4xc8vk4/e6O7JbIkIsmq15aK0t4ECodekAcN8/I2
         g+hgMcQujzXpXGXiU0nsBPNa9uZ56USFyOTur6RJmeokeDCxReSjQtdfTABGOMM3giCx
         RQm5Z1wlO+pGm85kHjkvCFizGNfZVZybSWyj/YQWj/kt8Z2afoehORdOa/EDqHEYpdyI
         E2j3wgRbFl3Z+pzzR03SZx4PhvUDcgiMqSq+9Vf0b0nJDZ5NEfHRgXgkbHLwBRCiqsEJ
         mqzou2vyivJnJwRn+9iKAjMrmJSphtU+4Pb4yT/XyrclbwaI/AZyQqp3UGyw4y388PQY
         2Bcg==
X-Forwarded-Encrypted: i=1; AJvYcCXW71I4+WBztFDVAtbhF4yjAEhPjTnXzStd829lm7vGaX255X1FbZKG9iX07Ey4MaUxMGsg4PrYdeZj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AM8NSAihzAd4twqQL4+Y6eCeaNn68JyDoscwky5PwWbor+E2
	5WcAF4zkrL2eeLF2HMlGnrunApx8rNn7rlrz/1gUkkAvd70OocU45VOwjI/SeNTMGvk=
X-Gm-Gg: ASbGncvCyp0OqrBwfMXKrCNm8PDhdJchrIRvwrkMc2aBMz9o80p1Io1z3qdck1ue6/M
	REss/PukEYXEIbkvqQ+ZzeT4E5ZJ31NEfZbEMujzmyGDUlPP9KP33ZwVhoJGNTN1tfv5I5b22tt
	MJIdDJycp9Jne7oQuwfQwUw/loIA86YKk8lLCQfGl+us312EDV2kqSrCOGVzF/q/6IgMLHdqJxC
	7NW3/yDZFlVq4g21pbKZ1DSzwlJT3YwnUeVsKqLBD+4XiusxFB9aoHDc6gaZsI9LlDuXkTF3B0X
	E7TNFZRysAQYr92Vxw0Zw8FUn2Mg9vlnqIjpRvxAS2HRkdcW/wiXorD/f6RyeatLvZ6tgiGbM91
	9XzCOJf19d2e1cFo4XRrfDCBXkrc2xj4TiFGBTd9vmoyzoXI=
X-Google-Smtp-Source: AGHT+IGaFXgKftq7eqLnUWiGjqoNmZIxu9zYqDeeosWGUHYB3ka7ctAPjbsx0oj7KSjVVtsUh1fiJw==
X-Received: by 2002:a05:600c:3145:b0:45b:6b6e:ea37 with SMTP id 5b1f17b1804b1-45b85570c73mr166696325e9.19.1757063346899;
        Fri, 05 Sep 2025 02:09:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:06 -0700 (PDT)
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
Subject: [PATCH 1/2] drivers/s390: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:08:56 +0200
Message-ID: <20250905090857.108240-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090857.108240-1-marco.crivellari@suse.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
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
---
 drivers/s390/char/tape_3590.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 0d484fe43d7e..aee11fece701 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1670,7 +1670,7 @@ tape_3590_init(void)
 
 	DBF_EVENT(3, "3590 init\n");
 
-	tape_3590_wq = alloc_workqueue("tape_3590", 0, 0);
+	tape_3590_wq = alloc_workqueue("tape_3590", WQ_PERCPU, 0);
 	if (!tape_3590_wq)
 		return -ENOMEM;
 
-- 
2.51.0

