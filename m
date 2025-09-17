Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E237059F
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123552; cv=none; b=nU8wqbqvJIQdXzfAu0BFhL5CWl9h2kG4g+QGME3gtFmlipK4MHrc9h7AaWzF8toxD6tuegWDTBWluwjhHpexJDD9tSwB26vlVBS7xjSaZihwcazVPgNLXaXtGjaxszRV5y5PUdiEchYv3lgFCumcP8HMf10/ESrfdR1vn01I274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123552; c=relaxed/simple;
	bh=UKI0GMrIrFld4692U92NbL9P6hnzaYrAgSVS+6kT4NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChgryWOpveC1BcYU9EiMp4Rl3RhBw0XzJSRNgvqSBH645oEAWBk6KuHRwZ4ibzDRBuKJeBYjVgRjFGzA0OBUyxvvsVdoLeCECE4JVWg4EEBJEOxDqN1boRes0trdYWLE4qum5iGYshc99cNehPppr901NwSNzOFXWZ6DKpAtcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bBEXHGcw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bBEXHGcw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso2071152f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123548; x=1758728348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVZVmy10Hzps3+n7t5S3fBRU0IFzjHVdjlxkyI552mE=;
        b=bBEXHGcwmargVZqO4A5K8KgcV/LT1vvWQaH63VnLJm/8INegfwQkLs0XHm4yQxTr3Y
         SJMrMQFpLGbM1tXqlrn7CANE+3o3ajxn2o+P48MeBByTNLv+M69TDVnymbDY53QgatHr
         evYYEFmLrQ/+CUB1H5QFND97qT0GW3joGtegHYgBoONT1Z47bFYldzvDG28buJYW+9Gn
         3af2zje7THCSallZcDtNwOsgJYUi4BcTjJu+HeJpAqS38XiR86Hvr6KYeci8Yf0Q1B8R
         YCC6XXl3tqQuwcp3mvexWmpqsVGU5Sn0UfFoHDOtGVQf7NyLWEPTtt7rrPqmCUpMvS2/
         iYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123548; x=1758728348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVZVmy10Hzps3+n7t5S3fBRU0IFzjHVdjlxkyI552mE=;
        b=KkSS8nmBRNE23GyuBoSoBuajqF9oXtUIsNxASa4Qxp0l8Yj49u3cg/6WdH3YFKzp0g
         dbyrsvSpUuN0zzU211VRXvOB7KP4PRGmNlJs1LtM8qb5QcPsQRCo2X503h8I0IddlKon
         XW9O7te6EXrIzgBXTRtN6vwLnb3/64Eat1CyC5WiMRKotBg49p18Bmhysvpu3aFQ/Vlw
         VkYBA8vu8CH1vlFol7oHYd/oZj93bj0z7J3izUVN3fxTxKU6LK1OIE7nZhlV95eH2wbw
         GqfkVD7WCNwMR6sLsJpwoLXjblipcQDRU9wV9QV03eOTJyJdk9ha/9TSsYHFgaSnKFDk
         fysQ==
X-Forwarded-Encrypted: i=1; AJvYcCVewmWOwlPFQCG0zY+7Vv2/I5cT7L4eLnuAAhHxj2LaZ9DE+YTBmH33loRIvNtLqGt91wOz0FwO0IGp@vger.kernel.org
X-Gm-Message-State: AOJu0YytvOtkJkJzxJzR5enXnnouVyx2lSxTAWvA+sL666x/u/BX8tTj
	Z6zIfiRGzL0GUZmKkuV7G7JlETBflUkuRELuZzdIztLzVht78EXneqRdcInBWjTKxEA=
X-Gm-Gg: ASbGncsOI5IdlBh9iiI0GVzw4JuXDxtHiKJjgbUBLrcoCEcXILcBglH10skd+cDy7g+
	0zVzPaC5y7aSCcMfirYr27sIDcp3gXYQCjWe5DwBgJA5YCx8DTnG7+k6oS7QuoK47KeEwVyVbWm
	MLFfsTVk+O7XZA2SWyvoOJkO249JHNwsjcnv80hOdFzYimd418TIfvn61idT2k+UnAWZNd4/Sxe
	MSoX4INgfYIIVPzCMF3C8vduyLfbL3BkShQLRsNf4eVBxFfjLkPAZtvVqlymI2mxIfVHxdBNIxG
	PFDDBUtUKP4lXgjkZJK10yf1kApiq3kOopr28Lni62kNHNbFpsmLGr1U0sZAtCaBzbnpFoE/7wj
	rsCiUUFTr5hYfcbSp+wxChMXA3GdJbSpb/9C+CVPAFgR5A98=
X-Google-Smtp-Source: AGHT+IFZkFyB8wLD1suxu+q9rNVi45peL0SKj0VLllUK4PJZNrtdqFLmgjE0enuXhQVI0UYmVz1X+g==
X-Received: by 2002:a05:6000:18a7:b0:3e7:ff32:1ab with SMTP id ffacd0b85a97d-3ecdfa4d27amr2496111f8f.50.1758123548077;
        Wed, 17 Sep 2025 08:39:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
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
Subject: [PATCH v2 3/3] s390: replace use of system_wq with system_dfl_wq
Date: Wed, 17 Sep 2025 17:38:59 +0200
Message-ID: <20250917153859.363593-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
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

system_wq is a per-CPU worqueue (replaced by system_percpu_wq), but the
current code does not benefit from it. Because of that, system_wq has been
replaced by system_dfl_wq, the new unbound workqueue.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/s390/kernel/hiperdispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index e7b66d046e8d..2507bc3f7757 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
 		return 0;
 	if (hd_online_cores <= hd_entitled_cores)
 		return 0;
-	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
+	mod_delayed_work(system_dfl_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
 	hd_update_capacities();
 	return 1;
 }
-- 
2.51.0

