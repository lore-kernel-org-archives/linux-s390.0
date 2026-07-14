Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62C442115
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039421; cv=none; b=WPaw8fZAH6L/GZ4lq4Kz8xnTuHyRR6OweUSKkNcyUOsJCt/1KZ98VIaYCA1ajZvpxR12PjQHzUNvTbM/wrr78SLHl4vQi9FJq9MhB3Jn330JsRFGcM2V+yUgN8zO7Z0PIXbGAwGaAqqqvAmdnQCDzeZsm7r1wHvqq1G2tQwq3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039421; c=relaxed/simple;
	bh=vXTVHC8jrIfunzmq69nH+ECf64rA25Ltg6ybB9/xSAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFvR8oJcJQBFg5sDN7fTwSHpUughEfpYjs7L3nVGXoAHbSjtYImWOqGZwqF7FqumwxcyygcR+wNhB7vV63KNVJZ+x6d5uStgl3SXKrKS9Ci1WpNo33gQ0yd8rSgKcCtjEuhh12pFVEsKhLUqs8ShVUfwsQxGns2EwCEmKhbebW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=yiRL3cZY; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="yiRL3cZY"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso12556341fa.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039416; x=1784644216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=yiRL3cZY7eyG1TxmA7qo4lIGpnJYumz4/n1g5qcE1/Z2loCuguzG4swBu0DViUKfZG
         bX64uFF1VLuOSd3VTkVSTA03Zg5KU0shpHG42LsVvCYC6mUnjx9qMxEMmolc40Gov5++
         nP+gGJ73SBtiyBiGoOYKvH8v8fjXAXwF+hUUwy4O5FNKuvBHGfF6vVXXvCGqPEQyE8sb
         ef9jcwjy89H0cyIu2b9MMAVoR5PH0xKZ0E412v1ErfdMW5dAIZIy+TjWmruWvUgrxClw
         ik9Zf8e5kt3nRppJ8EsmkH/6BHl5Lw4GDvStE0KnYE80UUT9jjCzJFhP+vDAfNe/fTQV
         mMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039416; x=1784644216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axmo6X45l643i+ylWNgoVG07bt+75yV7VClJ23IyRYM=;
        b=KzHgmHRS6zmll4oXfZ5cDDlc24ly/uz915V0t4riW1mIX4Qrgu3h9w0+aisjAWKp+5
         afqYcwkZaO8cV65q70g1EOeytUbbE9AbxAT6MkfvoRLNA+lCw9JUvYN9VBiXxAlFetT7
         Mk34DhQr8j09zX8FqWf0+A7DKggbfKo+On/VJCcL1RZSD5rSTsJeNthd9eWOpVnbYpdV
         hjPEm+ajX9WXV8JF0xaEw+tbs2qIFVFpet/IVyCv4B5HqZ/RdGiucA5T6idijP+Zhiuj
         Kk2nPXWWiqrry+E6LwwE6CzL8OS6QCkP5sMMudGMl+GCZSo/aPencVX0/yvmRVKirYFY
         Y44Q==
X-Forwarded-Encrypted: i=1; AHgh+RrL7aKYHH52UY+PAvGSS7Th2cJaGigdrz2VgYjgAXzyIu8gQLfTU1P8A0EIT4zfdaDWJWEoKwws7b7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxbHV4AMs0lgXlX7JiV31Y4dDuXw5MkrOLXQgtusbk5C1owb5As
	M4jJyGC9aiEtrGPIsI6KpmDGGNo8eR5TJG1yqAbhKKgzQaKeWu5RAD3VO0BZmhtpFAA=
X-Gm-Gg: AfdE7cl9BtashZ4R+RAjUj6hnEx73nShtTHbC7n/L7LOu5VEJpTbv+6hTWUzTfR4xPP
	A41TjOnfuK9gfR1nlmtGtohe5e3xej1K1qM1s2gVymEW/5dQO9YTgV2AXQezgnwOyCCWYHsv/sS
	eGHn/yvgOiPXygk+JyM8p6QUqAsoXG91q5vXNQfxhWU2XlfHz+m9w42Ukiv3LPj8dTs41Nd45BE
	8XxcmY0XU1qD8MnBJVJ5cc8l2stR7FIgurhTUmt23LrHMy5htr3ksWPUpq/MHGZ9zEN5F6s2Koe
	FvfOEzaM7+bvPqn99JaWuZbseKkOYS7iGZ0EFvZALkyyiSR4GkLLQ+CdIkhefJKeVH7EVTdkuPh
	nH+m7w57BXooh+C4sztNPvoQAQK0tol6obUp90XmjPLRYbNAQ7I668DFS2yFn/7/up4g43Pv8yV
	Fuj3AtEPitsryRMJJDL24BqA==
X-Received: by 2002:a2e:a584:0:b0:39d:ab29:b731 with SMTP id 38308e7fff4ca-39dab29bc4dmr8571781fa.27.1784039415388;
        Tue, 14 Jul 2026 07:30:15 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84bb39fesm34469241fa.42.2026.07.14.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:30:13 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique per net namespace
Date: Tue, 14 Jul 2026 16:29:24 +0200
Message-ID: <20260714142927.1298897-12-jiri@resnulli.us>
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

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index bb02640239d7..4c75078448a3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -129,7 +129,7 @@ static DECLARE_RWSEM(rdma_nets_rwsem);
 bool ib_devices_shared_netns = true;
 module_param_named(netns_mode, ib_devices_shared_netns, bool, 0444);
 MODULE_PARM_DESC(netns_mode,
-		 "Share device among net namespaces; default=1 (shared)");
+		 "Share device among net namespaces; default=1 (shared). In exclusive mode device names are unique per net namespace");
 /**
  * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
@@ -359,7 +359,8 @@ static struct ib_device *__ib_device_get_by_name(const char *name,
 	unsigned long index;
 
 	xa_for_each (&devices, index, device)
-		if (!strcmp(name, dev_name(&device->dev)))
+		if (rdma_dev_access_netns(device, net) &&
+		    !strcmp(name, dev_name(&device->dev)))
 			return device;
 
 	return NULL;
@@ -437,7 +438,11 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-/* Pick a free index for the '%d' style @name pattern. */
+/*
+ * Pick a free index for the '%d' style @name pattern within net namespace
+ * @net. Returns the index on success or a negative errno. The caller builds
+ * the final unique device name from the returned index.
+ */
 static int __alloc_name_id(struct net *net, const char *name,
 			   const struct ib_device *skip)
 {
@@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const char *name,
 	xa_for_each (&devices, index, device) {
 		char buf[IB_DEVICE_NAME_MAX];
 
-		if (device == skip)
+		if (device == skip || !rdma_dev_access_netns(device, net))
 			continue;
 		if (sscanf(dev_name(&device->dev), name, &i) != 1)
 			continue;
@@ -1233,7 +1238,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1416,8 +1422,9 @@ static void ib_device_notify_register(struct ib_device *device)
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
- * @name: unique string device name. This may include a '%' which will
- * 	  cause a unique index to be added to the passed device name.
+ * @name: device name, unique within the device's net namespace. This may
+ *	  include a '%' which will cause a unique index to be added to the
+ *	  passed device name.
  * @dma_device: pointer to a DMA-capable device. If %NULL, then the IB
  *	        device will be used. In this case the caller should fully
  *		setup the ibdev for DMA. This usually means using dma_virt_ops.
@@ -1708,6 +1715,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0

