Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F965403AEC
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590963; cv=none; b=LPAoDKs2G8Ky6m1MHsje4GrnKaipvaSLeysUlgsyuGGrS09BP6WxRigIoXGf9cTY4rumLxRbl3b3pNsiU8uUwR9MSFB7cdVCUSxKxe1ecIG7gPoUWZTE3OJODoDBvM8zMqw4yyUIHmAn3Z7CuoZnzT81/xq5Z7YB615GdcACR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590963; c=relaxed/simple;
	bh=awVS+vQGfFNww7dDbkg0d58ZIZ/RFJpwp0CqYWFg7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOaF0EEcKsGqJPKjilng8LWae+0ed3TsPUPakDLLEK5N/MXstg/rqv7Jrkqh83blfuDCz560VSyzpWtqT+AIq36Bu0ckT6cOEELvnozojYrVS3qLiyxsn0btAua0ImeOw6Hvp5z0nPw+lsnoorcwt61HLF3mY0/9l1acUZtT/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yeh3j9NB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="yeh3j9NB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c486f012so7097055e9.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590958; x=1784195758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3yvdJf8rTADXlXQqLGp3uJl8dCU4opoMAKhUr4P3so=;
        b=yeh3j9NBf4Uy8nYz2Tlz2QOY4RKLaAqKG139KrLDfIv61xcfVt4SRgLF9QO+2n0IM7
         xWpvQWE+xVIBthY/C4A5fUZGVs1WwOvLjgpNxvC/RLcwK0KtRw4SVKlNY3gAAUxf0fpM
         6dMBnfrd19qHrh26U1EfBpvIeMyoijg7Ow7rFEGpI4HxyscaUULxCr7HZrAnKzAr6IFd
         mMJSC9MaHjUGRNNUVrQGP9vIxHurx6fwkS6YIgj1A+t3K7Op/nH0jIkspSRNWWey3YBf
         bS72jnvs/ZLrH9YwEEnN82thwsj8iYH0N/m/97khkjmNhS5jgdI0aGRoXIiBmRdmZNP6
         tFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590958; x=1784195758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3yvdJf8rTADXlXQqLGp3uJl8dCU4opoMAKhUr4P3so=;
        b=Ii1FSzSE2IXVQLbNVUXce7aFQNwHti8UiITXZU1mIqUE5O/ZzVYbmV53njxYMip8B3
         pd2ISYkONi35L8aWOP1gypQgptwYBaVk80rmY3L+umADwvstogCg55C1zfaq3K7P2U/7
         v0Qj/xiFoVrpVIbkxE2nKQjlRe6dPqOvjokUKEIvevplSsREoRcQSfp7Rqz//et1zaRq
         L8VL1+vHp5xwvhjzamDFnTiwB6fKv17gdxHktoyF6gXdv/E6bmHemlPzTCBCZXj5SwyT
         4aD7cvtbCkP742Y5G55NHcbyH8ik3zDVutH/3VVqkd/ZfmCsu5ahQTZ90DbtlwI60/N2
         tpEg==
X-Forwarded-Encrypted: i=1; AHgh+Rqam6F62u3I3uqm/sISumignsrd3XYpkxO2maxEljrSrLNYUiOpioPleNns3PdFdPHv4NJWLtx5I6Yf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70alEk5UFr/C/peCvcnC3XpviK3lZ7x0swa/DRtENod4xKRIF
	hH1NV2sCnNVfnEyHMsVaHHqzjYNJMqKtuBFjqPvRyMMCfhFVRdI68mFmR+W8755GtuI=
X-Gm-Gg: AfdE7clcz0mfoS+ZUpauAwE+VRrNIMQRy+9CFWx+qM6cr84d+lSIl+88gcAdAGq4IPb
	O3qqIaiQl4bhLh4egV94npdOSljVd1L67rIsIEF0PQZsf5lSk966GhkSNqOTqB0fHanQsUfW5LF
	bkpJJKDbyUi0TjdjG9l864Hpdz8DcMr9now8385Tck46CkYqFmC/bVmNz7QacNVQsQNdzAWiIE1
	1vWL0bcDizZUpqB/rwWANiM/zFP+5NVN6ZKYf1uIV+x3v2oHP0Uheu3LnPCKDC5UZFHdnzWDP22
	6whgJQD/pRsSpb4S8eLzsNENidv9rKCccNDxL9N9mrTZvR4aG10ewfYTdSfaXIbEj/OUDDSSOdd
	1oKp9jZniTx4BolLk9M2heNVQcLKpuDuVGHulTEgO/oxNHR0gEythkHfiePMK18YV9tFn/KJBnB
	q7hDHnCHV30h6GBX8Go/G4fPzuki/3klUl
X-Received: by 2002:a05:600c:3b05:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-493e6859787mr59433245e9.2.1783590958491;
        Thu, 09 Jul 2026 02:55:58 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm52753503f8f.2.2026.07.09.02.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:58 -0700 (PDT)
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
Subject: [PATCH rdma-next 07/13] RDMA/srp: Make the SRP sysfs class net namespace aware
Date: Thu,  9 Jul 2026 11:55:26 +0200
Message-ID: <20260709095532.855647-8-jiri@resnulli.us>
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

Tag srp_class by the RDMA device's net namespace so SRP hosts derived from
same-named RDMA devices can coexist across namespaces.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index acbd787de265..a070fcf86e8a 100644
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

