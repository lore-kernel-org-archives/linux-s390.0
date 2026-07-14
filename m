Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA447ECF8
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039430; cv=none; b=usIhbhRiHa1TzU9vDmo1ysBslYYyeipDW2Npmgxfpovu1cLcadON1wOcwlVtbUNbRxFJ4GoCV0gDf4m2oJRm+F2GdaU6zPDiRU624HnnPhboTLRKqKJ4iFnPCLx0xup3qhAoO19tzQ6cDtbgGpFqQrqNo/4Tt+XPBaojTrxldVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039430; c=relaxed/simple;
	bh=AlWKq+WCpJ6jqrd7bHxM+xUmQDKopJjD0aSNOnzQ77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9dg8uEzmtxND149tccTOWpTPTUKONkSWv/m3L1VeEanbJuz3m+akHWG9daTG9Ok4pesw9FC5QgFokuI4EGSbfJp/ZTxfwV6o85gkeGkEmu/88MfX5iViBIuTbGPM34QfhUgd6nAY63pdMkg53kv5zEqoPpU13gPoGtw6XFC0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=eU3KBUJN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="eU3KBUJN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b021916bd3so3517281e87.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039426; x=1784644226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=eU3KBUJNoAxPw7pVvTRmdsZuqaSzCsRc5zvDXfoqhEXRqsJzYvuCRa20VFhhOE30sb
         sWtoh0VOxwrR+Wb36oLsaQftZjmTMtTyQP12VJTgjqGIjHpLrJvZp22+mGbjtUrHEnLK
         E1vLqDUj+W90vyHhsS3oCNcAYLtdwzSIyDEzeia2vKHmBOAnyGZ7P0q/biZofagDyyUn
         AL/jhBP9LWECGNjpAecCcCpnOU28iuPSNFx7TOAYJrvWsa76PoYR84qCM9sVeej+/ZJC
         wvCGEd27wgcXw3FDtvWPSGPQU2gWz6+mI4NbxdtFcOLSYzfZLHA0l+sYEJf/RPt5kGzP
         csWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039426; x=1784644226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=YtnSHVzpzjSpwlBseWOP3IHG9IgjQRQYF+h4PibaeV6dLSnPZO4vFkX7kjyW1uZm4h
         9333pZ9A3VRxNpNXCNqjkRW38lEg/YLgh5bYiatqv8X+DmAu77pvaw7xTCLN9RyMuWMz
         RYuDvszuq3GXn8Y9MGV1CLnaPbsIECeMszvExWsWNraqlcmcygCXnaQ4rTh01xijuwOl
         DW/VAEypwfcylg/Z9p7k+XXG0vQFZ4slV563vyR6sXOsdOBbaVv5mr2WQa0L6DRPjZLn
         4/bCYWOtQVPQ0EEQeXcU8IwRWzPhO04SrNYtYwKuCgI7Bf2XQYk8q5sWA2MyE7pVBgQ4
         amnw==
X-Forwarded-Encrypted: i=1; AHgh+RoW5S3nUWLGj0Ek21ru4pTu6RVycDKYUcVBdNGK0Gy3rCr0FSIjQSkd4Sxc8kKPed00GS0M1fFtsIS+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1uX3tpusTLJqgMe5NQWQrhKDMC9zvspIPVC6NQ07nx9fKtST
	qnf/yMF1QF/3WO9BA7JytZRNvlQS94pEfyaEBt0FGKlTpXzdk4052OB90YJD+D1rqKs=
X-Gm-Gg: AfdE7ckEzKRHbOWsmUMDS9gVrJZjXS3FgZHmWJuVzJuIj1+hWnKgCoyGgQ7dLD7SrOV
	zrLWpZBYk1SaZrt+srq4y46NBqTwrdXVpi+vJPrkIip87HjivsZ3ec8Te4shbLITNi9J73lFKJn
	Uec+fxNCJguLVVT5qKTo/babZiypDPmkPXvUwcuBWDncUgItTE9IVl+EuUadvkGloa7QxVBzO9J
	ypwlKvyK2evUlFkHacFmfBIKBRp9vZ22wPpJ8/+j3qAtRw9zL+pXEZv8mOqSYN8x33GijBJ8ZyJ
	qaKdfr1VWyvhmQJg/OVtGL+gZIRMJi/g0sSemAXRtiMd/blE5p3MWcmudIA25bwrLqBG6WRI9sI
	NO+YHa5MRJmUFeCXaHj+2f8Du7A0ugfJNncPcq/85ZMPTD/ZhNtQEVV81u3gGnKxbNNP/2Q1dmR
	nFFelrxDxF9BQGP3L7tlV9xbk=
X-Received: by 2002:ac2:51d1:0:b0:5b0:bc3:dc05 with SMTP id 2adb3069b0e04-5b02369c7cdmr2818323e87.40.1784039424734;
        Tue, 14 Jul 2026 07:30:24 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a2e9sm3573711e87.1.2026.07.14.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v2 13/14] RDMA/rxe: Implement disassociate_ucontext callback
Date: Tue, 14 Jul 2026 16:29:26 +0200
Message-ID: <20260714142927.1298897-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714142927.1298897-1-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

rxe needs no teardown here: its user-mapped queues live in
reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
while userspace holds the mappings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1ec130fee8ea..6eb10d2f0653 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
+static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
+{
+}
+
 /* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
@@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
 	.device_group = &rxe_attr_group,
+	.disassociate_ucontext = rxe_disassociate_ucontext,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
-- 
2.54.0

