Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C273403AF7
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590979; cv=none; b=qCyICeikk2c6TfVJV44lSbmJ1CpNwByYXBAQgPWuDEoFsNFWV0uCxD7a2Kla4/RtHx/9pJrQb9U8mnM8QDOYnh5Jn9N7g5QXp5WtOCk3VyztKRGQ0jTKmMVWxYImwjZn4PskEk9dt0/Sw6puTnzNwntYqIBNzqdiqgFBbzd8jPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590979; c=relaxed/simple;
	bh=BtV4YlWqSeeVkZLMl7O/Z8uUv5IQpghIyehpmENCIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWyZH9ZMDWjBN6OiaNb0TdXJx0JceJ4uKbTNlw+vY1Dxfn4ZsCpdpWSsaQWWG0sg/xqpVZR0AvQkGbY2QO+1gB6tcJzZnwvx/6OT7Qu+xfDeIQCwPHqsupOSSIvi+jsCmqbnfdEbzwEZkaoc2obYydcr08gNSyGodIRe8iFBaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GI+x+lL8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="GI+x+lL8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c1950518so4523355e9.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590966; x=1784195766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=GI+x+lL8sq0CkxXuBnv0Cu1jA9kMWZ1Be8D5Z6yYyqffjpsE6H8buIGveFfzQvQo5I
         kOschQwaJRUU4taSyUeZB9PvIqFsA1wN0Q8PWWg3yp1EqdDrxLwE0kHXlh0zMnbSiZ+l
         Dr0wPMcBCdOQvz2h9Ut4yIlcl7T+CSPowbYTZR9Jzv9ox1zyIuKrW8b4mFIWJD02oWaY
         kRt+uqCVIG1jVHd74eIvyCk2h6KWQpHFM0V2gqKAj0FUKCBG0wmTbA3uxsuk/FbsYCId
         2NbZr2C8FpmGhLC1jT0+aidmMp+Pv0Qr+y1wrY6N63VNXyODWLRQ1SGZ88b4pe7g2zlY
         PQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590966; x=1784195766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMAXl1cpFneAc8qw41p6eJ7Eq0JeDqgZ4KunEwtw9x4=;
        b=mY5TpWGGyZ9/4ZOvJazc56IVwUwW1obmgHHiBEA3XrNrDoPvce/09dd9X++C4egnXl
         OeW1lwhxFewrzU2qf9/o+zBC6fHAd9txbwUS7lvIF7zWosLQ60OwAE3+4Mqhw7C1p1SO
         89+a3rsLtZnWh6ZC4rU6ZMruckN/R7dgXTY9jnBA/LEQBcyOSIIwwa5T1Av62eGu8GtE
         ieRrMilNw+axwfKrDAgY3DQdS9six3j6/t7xiOoOWp/xNbryL+4u8TB4FVxZxsiF7EVb
         19KIteTlIt1/7pKUgJgn7JfWiWworxb+Y1r1BxSAJ2B/SACb6/W1rCjwrLlETDWxT0vQ
         XsPA==
X-Forwarded-Encrypted: i=1; AHgh+RoqNtIcCmAxzSAnuqWpxrOGfZVx48+tWTAmUQ43nPMk6NMea4itOax98TZh6ckOrn6ZajmNUk8EyOIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2X/YWLvGi381yWWQjhzLWliPFZb4O5zzGJJiQcs1+3BpCsSEf
	FPoenJlLm8CfpCBEVEUavLf6rIRQVu5i8He+3NyXeebeINITenfOnOnubaBmrCsXH/8=
X-Gm-Gg: AfdE7ckr932Ql3UgfurfEdSMIYsEDRHhwYUPL4OisiGM4i9wRAH7YHh5y8E5qUiDDXW
	1/hc00qHdze8JQbgv6N2Ns12+0FW9gmdnjy2LIGmXg6PFtM9tIFyCZCfIsxXhTaEvYOVlpHIVmP
	owvMTD7f868tqb8zD2pQoGkvolJnoqarHW/pqPclorvuT4gVZK1i5URQl6FpvawE9P/GEPTas+S
	EEsxcEvmivbjvHAOfxexTUOZ6pfqC4tkA/bgg0es51KK5NEfKVT4v+5ehItQlrAkapZWd57vl/d
	gU4FR+ufRAMX1zCHNLcsnEVw4JlXEewmEfjmSOkOoMRg1W4Yly49xOz0hFAe0ec36wDfoeMjJ5N
	RkqvqhLNBcez8CHr57bZ6AK0nuFRm1+uN6ymXYHod+4B+wuUs7cxdRuK2K3C4frECDtFfZYmuEL
	Lp6nX0L8X3xVy6Tl920NrO4Q==
X-Received: by 2002:a05:600c:3ba2:b0:493:e542:ffd5 with SMTP id 5b1f17b1804b1-493ec65ecf7mr22790365e9.5.1783590965776;
        Thu, 09 Jul 2026 02:56:05 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f16cfsm51734255e9.12.2026.07.09.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:05 -0700 (PDT)
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
	wenjia@linux.ibm.com
Subject: [PATCH rdma-next 09/13] RDMA/cma: Document that CM configfs cannot be net namespace scoped
Date: Thu,  9 Jul 2026 11:55:28 +0200
Message-ID: <20260709095532.855647-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709095532.855647-1-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document the rdma_cm configfs limitation: configfs is global, so same-named
RDMA devices in different net namespaces cannot both be represented there.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/ABI/testing/configfs-rdma_cm | 4 ++++
 drivers/infiniband/core/cma_configfs.c     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-rdma_cm b/Documentation/ABI/testing/configfs-rdma_cm
index 74f9506f42e7..739f7b6a1259 100644
--- a/Documentation/ABI/testing/configfs-rdma_cm
+++ b/Documentation/ABI/testing/configfs-rdma_cm
@@ -12,6 +12,10 @@ Description: 	Interface is used to configure RDMA-cable HCAs in respect to
 		for this HCA has to be created:
 		mkdir -p /config/rdma_cm/<hca>
 
+		Note: configfs has no network namespace support, so this
+		interface cannot represent two devices that share a name in
+		different network namespaces (possible in exclusive netns mode).
+
 
 What: 		/config/rdma_cm/<hca>/ports/<port-num>/default_roce_mode
 Date: 		November 29, 2015
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 891e52afb8f4..c389d4e37b6b 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -65,6 +65,10 @@ static struct cma_dev_port_group *to_dev_port_group(struct config_item *item)
 	return container_of(group, struct cma_dev_port_group, group);
 }
 
+/*
+ * configfs is not net namespace aware, so a name shared by devices in
+ * different namespaces resolves to the first match here.
+ */
 static bool filter_by_name(struct ib_device *ib_dev, void *cookie)
 {
 	return !strcmp(dev_name(&ib_dev->dev), cookie);
-- 
2.54.0

