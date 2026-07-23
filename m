Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE10486648
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832425; cv=none; b=U+imhkrczf8ykbldC17POMmFgTmQkUjBlQmeFltCSDF3nN/LweCNTznpJqNFyH3hcCijj4sHpgoutKBLEMDKW9gv3KvkVqWrtpEIVGD67E2fgUrZe+WA+tHmcOkA5rH18JaMMpBravecSAdkyFriBElCKO/e/9Quu6scWJkvF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832425; c=relaxed/simple;
	bh=d0EWrVZ42EPe2bhaOHHufbmj44DuHjUEdUtjBw/ex20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbKQwy4dlSFHnasy5/3HmwL2vxYJ5+8O1Rg2mhSu7lqka0uDCl7KSM7asJ1cEx/xmbIUNAK+RMS3lx/Yb63L19zMMtjj2QVO7EMERlQCQ/9nmoFYxmqeW803ztlmnZVsgyX7afOGyKgl5nOL84OsQmc7tlow+f1+DZxy+DHUyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeV/R+zV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeV/R+zV"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so775042a91.2
        for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832416; x=1785437216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
        b=LeV/R+zV/Qq6oWzzZqslYq4xBY9AOSEsjRVc5DucFqVnQ1m6J/xob2OdY69MCjOQcX
         grCrFfHzQYBTQdZWkW5t2j3QgFd+axn0rvTv2sYfQQpsiIgz2bRWUxrdwCdomPOg7WsV
         LLv4ZKm/dYHRkMjGaof1OywC2zvuoMQjgAX2xATzA3Vi/sbytm/ekeU2eVqFPjDxwU6E
         x28QvIPt25U1D1LcelvFqFrXkhIMvm/ztniRkMU5QSOLOro+sqpbl0jBit5YWALRgkoX
         UpsCJp7NLQWNHbQKTZSCO2LXEdO6aTT+Oenm3b/Pdiv9jby0+hm6SMiREbjXeEwdjh3v
         DtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832416; x=1785437216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa9RhyBV4RDq7tkQpwKRVUOOI8N+P6srYqSVADpe3nI=;
        b=XgqEsXidJwYjl46/XqbhaGdfu8l8tKdQ0529v3XBLZxzpKrs7L5VBZDDFoSLpyPSKn
         IOL0YZ0gaCo5GMGFxrhcU+5RAocWz1FxV5Ta2CIxt2jB0xXmi6im3VXF/L+5jPxaXDqP
         8mulTTAe1rd3Pq6KYuFQmTQGzMX/61VTRzoDSlfLN5qMmmp9iaFGctQR50rnlf98Jbbb
         bt0VPaKuioUAlFyunTOZX4MFWWC0zlJ2Bvl35DzIUBJXl2+Tc0WLmru78AdttOLX5iAG
         QBzbFpH4ALb5qE7pSesArUTYQPL6HnUjylMUAKpqdEFRrYxs0Zk7WfNxyI4P6xjcH7Io
         HlFA==
X-Forwarded-Encrypted: i=1; AHgh+RqMuRojnDz5SMjxyrxWKglY62tJOK92y/mmu5lCsNh4RSn2nQ63TobyObEQXEEJ5WZJrwWVjHwarNOZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWicKYbyJJRsyanpqKtx0Xh6ZiHlRoAJ3KTy7LzUm6iuiaZbp
	TldD7zGqnp6V+wyDEKUWRJZGeBEGH4VZKGMjAXFcEoU2sOHN5avY8ikl
X-Gm-Gg: AR+sD11bkujTv8VWls6ub8QFFoYwPdyg00ecuWCmGRS13JJujdjTh3F+8rz8FtE05GC
	vztF+HWYWPDjx3hIrs6m/F1iUPSjNFOpFrroKOM7W0N4sa8iwbVHsfnH2W34QaXgCMUTais8yt0
	MDNentr6JrCjQcpFYJJaHx8Kmf6vlq/cCVwqXw/Z67C0QZHYL++JSFUroKYro0kmV9wyBs+a1XR
	TNX37PRBaL0TzyWWcEc+jhjEqegXhSKu2ar1mYeuEwQJRoYOLuQj0xIHVul0fvR0nVfeEQXPZ5k
	zqey+sBeYENCr6c/fi8bit0/DCrdFsoPAGmSkCW8X7ooG5dx9wo87MD5yx1PHFTtq4WvGtmq4b7
	6ALM+H9a9ZrSvTiU7Co0E8sG3Bm9L1X584k5kDNa+fAc7cx94+JY/I28FWepCuZKLrPApJxDI
X-Received: by 2002:a17:90b:2b47:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-38ec6454e6dmr4309241a91.10.1784832415649;
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: cocci@inria.fr,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 22/36] iommu/s390: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:24 +0900
Message-ID: <20260723184538.3888637-23-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iommu/s390-iommu.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..d008b1d14a9e 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -1115,8 +1115,6 @@ __setup("s390_iommu_aperture=", s390_iommu_aperture_setup);
 
 static int __init s390_iommu_init(void)
 {
-	int rc;
-
 	iommu_dma_forcedac = true;
 	s390_iommu_aperture = (u64)virt_to_phys(high_memory);
 	if (!s390_iommu_aperture_factor)
@@ -1124,11 +1122,7 @@ static int __init s390_iommu_init(void)
 	else
 		s390_iommu_aperture *= s390_iommu_aperture_factor;
 
-	rc = dma_alloc_cpu_table_caches();
-	if (rc)
-		return rc;
-
-	return rc;
+	return dma_alloc_cpu_table_caches();
 }
 subsys_initcall(s390_iommu_init);
 
-- 
2.43.0

