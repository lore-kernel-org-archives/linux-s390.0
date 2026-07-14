Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FD47DD40
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039402; cv=none; b=MUMJQzbbuKTDDcSXR3Ztxd1iaTHec2K99+ECW1s7z13L51HPk5BBjI+kfip/0UANFbFlui2MCd4QphxGBSO5nQeBWyvGKu+qU3jMzzfwI8NVs/MEKsfccyGceyHnMftJRSWCTfknhwiLTLI1FJBH2aJMmKfmsG7bHBmxuWUzSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039402; c=relaxed/simple;
	bh=Wqi5KzpmB6zpmbpQROgcTMyYw+gD16pJ028ef+YpomU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fX+EegoZThI+py6gneCtjxT2AfkyaUhS/FbQS8nVafHOzHDLN/FTMrsPIsiEM8SQBpe0r5MfvkOE7Aa0LtssBAwdQ2eUJIL9RwtxkZxWWQTqHeMcSjZBYNjYnI6hAbVGSxbCEN6yjS9G/keZU2bSotcMbACrfGlzMv7j8+YBarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ROaTHZn8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ROaTHZn8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b7612475so34287225e9.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039399; x=1784644199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BMcX0YddrsVQYToOf5sZrqslr+alhSoWvC1LhYQrOaI=;
        b=ROaTHZn8Wm29bXZ0bh7lCjmoj53KRSEY1vVFPBG+vYjkYONxB4P8G0AzO9FvDfDIly
         pB0dWkM+niVBfBSjyrtYQVQRncg1hIglMSXasgErlopNQEoF5v4ecwrMjKzvjj8olZSb
         NynmDscV1tkB+qBINXlggCeqH4fwmNNOG8iFDOUKY8DlfRz1yX90KNsH7lwjSstKLqcL
         /ajRWKRv8yChiD/rTcNGxB0q2y+MlAtQ4EEIqGOZ/RztMu67s8HHfq/aQsXgc8ltE9CN
         zMRqR+6anCgw54BVB/2GCVbW3xxcu5lSvCho2+BFVjLP66oJPYdS5c8tKXSMLMfEXGGZ
         z84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039399; x=1784644199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BMcX0YddrsVQYToOf5sZrqslr+alhSoWvC1LhYQrOaI=;
        b=a8QgBKBG2BKEGtqOxv4bKhwwiRRPMQiQu7SJDnrX7mLzlB7XSQXkGfiKsxq9gmohNW
         vzNDIqKtJTJr/+JJHMJprTdWecHkqfjqFKtvd9JjAmbELLEiPpHZcatGXfvYElmfrPEs
         zz3ex1nWNQacyzYK+qX3CfUhvH2PKQdISYnnCnZCWlKP+tDcBR3bXnGbHyQFjfHcaeLy
         SDUDBKD9/dgG4Sc1UK0lekYnz/JX9XEqyO4aP66V94iXB+mkKHFXSX3Ujnvkg4pBFi56
         xaVtkfUMDbZU86W9gI7+ZC+BG9kkJJDs9aiyB1BZzQskp/8c7Z2I4dn1DiY/gxFxfeJQ
         sbPg==
X-Forwarded-Encrypted: i=1; AHgh+RqqPyq1taMytac//mEQmSaZRTCkDOMTyhALF2jmcTYctxq0EexCc0kp4PrRLoiZMQ9UAYWkvbRiVt1i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xXTMP/XML57uK/o+q0XouSuFSyFxWlhmE57zQDL8cLQi887W
	JqFWR/TAx6tbIYcdMiybewbBIHvMVAOZHTPOzysHbI3Q5i91zQVAou0q8XH4SVyTcfo=
X-Gm-Gg: AfdE7cmNYrhismw93uX/vF3CreHJDk2WeBvtVm6ekQwgw31IFhLAn8yrMUK/kNpmrID
	Kv0jC9ACdWlmeJXF9qFbymUj/ZzGZWxbORJBSJEkBNaw/fONKqkRFlWK3TGlV8Ae2g9Z6AAhmaW
	Kuj9f/ZC2pWSD2smpZXcxUW7AIwZ/8WaLASo/yL0J8+SOS4dp3MkFmJSKv4yslUYbWel+jolL/H
	uATfBBUj/AFCjidmxunE8AgnsKWfcFiS3kQ7mhuZOQlsCk7WY54orkUwiFU0LlIael5KQZ8bGKH
	1BB0Il/uvo26kLvk6WVuAQUeoQsS9ria7UUpSWGtg1mJ7VnaG0IbNaDBSGaChz8bIr9VbC1Vfc2
	9WD6P+OaEbywHcOdDlsylw1AdsKdzs0hSN6jKNSONjlGaFx+N8zDxjOeZ6F+3O8HxdlOPuk8F7y
	Xan1dsWlXuxgBYawY8iBMaZA==
X-Received: by 2002:a05:600c:c04b:10b0:495:21e7:fd53 with SMTP id 5b1f17b1804b1-49521e7fd96mr32781175e9.18.1784039398693;
        Tue, 14 Jul 2026 07:29:58 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950871d1bdsm79306125e9.1.2026.07.14.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:58 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 07/14] RDMA/srp: Make the SRP sysfs class net namespace aware
Date: Tue, 14 Jul 2026 16:29:20 +0200
Message-ID: <20260714142927.1298897-8-jiri@resnulli.us>
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

Tag srp_class by the RDMA device's net namespace so SRP hosts derived from
same-named RDMA devices can coexist across namespaces.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0caebbc2810f..2fc8e133c70f 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3189,10 +3189,24 @@ static struct attribute *srp_class_attrs[];
 
 ATTRIBUTE_GROUPS(srp_class);
 
+/*
+ * SRP hosts are named after their ib device, so tag the class by the ib
+ * device's net namespace.
+ */
+static const struct ns_common *srp_net_namespace(const struct device *dev)
+{
+	struct srp_host *host = container_of(dev, struct srp_host, dev);
+	struct net *net = rdma_dev_net(host->srp_dev->dev);
+
+	return net ? to_ns_common(net) : NULL;
+}
+
 static struct class srp_class = {
 	.name    = "infiniband_srp",
 	.dev_groups = srp_class_groups,
-	.dev_release = srp_release_dev
+	.dev_release = srp_release_dev,
+	.ns_type = &net_ns_type_operations,
+	.namespace = srp_net_namespace,
 };
 
 /**
-- 
2.54.0

