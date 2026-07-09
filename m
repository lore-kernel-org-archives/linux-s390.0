Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4CF402BB1
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590958; cv=none; b=JA/y9V6HT2uDJmwVudFrcgc8S1le6mB/HfqqUAEHpmn3oXTHi0pX9Xm4xfdXYfK3hMputPeuIvzwT9LvjVuW+wttKTM2vZcijdXrc96hpVQduaMkbJDzpgDr+7OscjgxCidq2SyyLeCdeJPJUl2M6s+2969W9mQwiJGesViD7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590958; c=relaxed/simple;
	bh=pdMmpZJCv+StAJxQjGBnq4nulDEDCbuKp7xLyLbTHHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILDr/67JN+VoPRqCt2G9ZS/lMHKsoAoGM0yLiP+yC3ybo5TVssdRrf2H9EL14oXtdePE9vSr8cTo84ybVGk9Po2H6MsDlZr/jb6oH8tspIJmEvgTN/apTuzXc7BT/dsYjk29V6iPRaRonexL63Q5TAeN2s55fHiNVgjjmCxw2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=N54syBis; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="N54syBis"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso8762965e9.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590955; x=1784195755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfMuLF2nfHbgRgmO34SL3Jj6SviYlx2uzsjm64OYl7Y=;
        b=N54syBiswM9Yk8e2fpr9lVVBcEETybUF1tI5udYUpv4oHGx0pm3G3j9HCZ0uWX4EAM
         zY719SAoQ3LW8R/m2rwbA4CFuMt2dcW0dmkpd9T7mJTKi+a7bjKgQrdi/Isj/Rxofy3R
         DrcnkJAw8aLRzMMqVe4q+I07EuqfeHV4RThu/3+rQoUCzpLdwTDG0Y0c4v6dWTQqdhr3
         qJ1JlzrGKOoBwqssop5hmxZplWSMNUv3d+kgOIHp4DJC6pax29POn/xpxZcIDhYZzGQ6
         ONEAmkPd3b5JHV9gnmkB1e/Z8Iu7QIUY2jEeV3TUODc8BVSFY6vFrH2XVJlKDn3AbZyZ
         KtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590955; x=1784195755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfMuLF2nfHbgRgmO34SL3Jj6SviYlx2uzsjm64OYl7Y=;
        b=Ngq67sfBLqvA+MvTtzhFyyejygc6ZMARIKYrzN/UgsQE8LUwLX03+l710QOhETW4fd
         EeTn0XoWhKyssZv+jjydCcH00Q6Pk8nYr+l+mTGRKC52+DkYCLum8kYKdBQJvFZ1z5Mg
         W8s8suN4XGiuHfc2EFFmrWzKN0Xg0YEEL83a0OFbWnrvJYJZ2CiDMQaX0pXz4Ks2u7MA
         kQcwj3uXeUQyCS1MMiBvLr+7RuL/U8MXgoG6/y9u05fBx7snB2H8i/v+fft+XGhYRbv0
         +KobtXHQ5Yae5lzTTzRaZrgnXtA0nHujZOEtjFcaS0aqXZ1N1XEkLftbHTBHL432RZV4
         jJUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY7sp5OJ9VMU5e0YsgtvlYUjeeM8E8BX6ajNBbx5wxa0mDO3pRROR8cJyU/KBanSAv/MaMnBbCPz3m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AOo7lGPfxpr6YxqS9NUwX4EclPGczcYBPLEJaIQ29Q/c/JIu
	L5rX4T9WuNh8vEJzf1DZ2TnC3bAjDqn6hIozRpCgVTxw+3PqLSKIMUAy3BGiu1AdG38=
X-Gm-Gg: AfdE7cnJ2VG+Rtu2/U7ktkHkc1FcWIBc8XWZHtgJo1nP55rj2xEutNLskZKmhuN/5PN
	m8hzU7kZbqxDTK5xvYk37H/tErw1/6xWqiz701XuY5kOy6/MA2VMxNS+twrY5QLLgZobuoXfx4D
	f4J4e9QJcJva3nU7Aug2x5QaHYqGBDtjNNrG0FQ3G/eMfPuWWsDLTDRyrUyJxraPkI7iwBiPy0P
	4b8AOszNTEzNzr7jYiLj32PCp3LdZD0nfeoU4s0/oIqjtb185mVP+5zqNB4UL6brmWh3wbhAshP
	6vrh72fkQeHCQ2GV3MVz2rYIrPHpy0YwCg3hg2ebOyVcx40oN20FZwCOe6yKvhLL55L6zBBTGfa
	Pmx40BvlVjAdRBn50TJjEL6Cdnhv/Q0p27Qaz9xn0QtJQ6ojwBt/1fUE7TIYQAMEjHm06RSgsAs
	nHJ7Byornl3c7tIKdlldPHZQ==
X-Received: by 2002:a05:600c:83c6:b0:493:b8cd:2555 with SMTP id 5b1f17b1804b1-493e690497emr64042885e9.3.1783590955326;
        Thu, 09 Jul 2026 02:55:55 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50293284f8f.5.2026.07.09.02.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:54 -0700 (PDT)
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
Subject: [PATCH rdma-next 06/13] net/smc: Look up the pnetid ib device within the net namespace
Date: Thu,  9 Jul 2026 11:55:25 +0200
Message-ID: <20260709095532.855647-7-jiri@resnulli.us>
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

Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
cannot bind to a same-named RDMA device from another namespace once names
become per-netns.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/smc/smc_pnet.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 63e286e2dfaa..ff9c9c35cc2f 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -304,13 +304,18 @@ static bool smc_pnetid_valid(const char *pnet_name, char *pnetid)
 	return true;
 }
 
-/* Find an infiniband device by a given name. The device might not exist. */
-static struct smc_ib_device *smc_pnet_find_ib(char *ib_name)
+/*
+ * Find an infiniband device by a given name, restricted to the devices
+ * accessible from @net. The device might not exist.
+ */
+static struct smc_ib_device *smc_pnet_find_ib(struct net *net, char *ib_name)
 {
 	struct smc_ib_device *ibdev;
 
 	mutex_lock(&smc_ib_devices.mutex);
 	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
+		if (!rdma_dev_access_netns(ibdev->ibdev, net))
+			continue;
 		if (!strncmp(ibdev->ibdev->name, ib_name,
 			     sizeof(ibdev->ibdev->name)) ||
 		    (ibdev->ibdev->dev.parent &&
@@ -408,8 +413,8 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
 	return rc;
 }
 
-static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
-			   u8 ib_port, char *pnet_name)
+static int smc_pnet_add_ib(struct smc_pnettable *pnettable, struct net *net,
+			   char *ib_name, u8 ib_port, char *pnet_name)
 {
 	struct smc_pnetentry *tmp_pe, *new_pe;
 	struct smc_ib_device *ib_dev;
@@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	bool new_ibdev;
 
 	/* try to apply the pnetid to active devices */
-	ib_dev = smc_pnet_find_ib(ib_name);
+	ib_dev = smc_pnet_find_ib(net, ib_name);
 	if (ib_dev) {
 		ibdev_applied = smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
 		if (ibdev_applied)
@@ -518,7 +523,7 @@ static int smc_pnet_enter(struct net *net, struct nlattr *tb[])
 			if (ibport < 1 || ibport > SMC_MAX_PORTS)
 				goto error;
 		}
-		rc = smc_pnet_add_ib(pnettable, string, ibport, pnet_name);
+		rc = smc_pnet_add_ib(pnettable, net, string, ibport, pnet_name);
 		if (!rc)
 			new_ibdev = true;
 		else if (rc != -EEXIST)
@@ -1170,6 +1175,9 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
 	struct smc_net *sn;
 	int rc = -ENOENT;
 
+	if (!rdma_dev_access_netns(smcibdev->ibdev, &init_net))
+		return -ENOENT;
+
 	/* get pnettable for init namespace */
 	sn = net_generic(&init_net, smc_net_id);
 	pnettable = &sn->pnettable;
-- 
2.54.0

