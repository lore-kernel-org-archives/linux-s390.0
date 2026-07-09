Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC7403B07
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590975; cv=none; b=iXFmU78yrXqIbgZxXTNy8x/y7qeMu12ciKWeoS2J7iGC5cwtlVZpCYEaYza74C8meYvGM2vclq+towX0b1a3RjpoKnxpZXhRC+gSZacNcW0DMdLwsP++Ky45tXmFgNlgDz968stEGBao4G+SgDpm8gebAwDXFebysGWBnx4cTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590975; c=relaxed/simple;
	bh=y0ueD2HhhO9sYx46zBe6GC0lC01oe7J7EHAcGkoIfh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOLhmLipwIQfI8zzUPayN5kzAqzhnEebTNK9kX0WBWb0fC4nBIPrbelh2Dnhygw6b0YdpJp3f/G6kJEAyaxSJ7v/dxeCHfPzliAhrDzhBqbOMGCpsQZFzo9M/meThYp9REXOMx9vGRVi1TMrxvANVwvN/zgoYZi9uVoofSJA7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JZ5i9Tay; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="JZ5i9Tay"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c486f012so7098205e9.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590972; x=1784195772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=JZ5i9TayqfK9QDaV483kelEywHyKCmkriCfBpd7K8DN5YpPk2aQi7z28+jFnMObuRe
         esNGGiSrcNJAVK+8Ex1ueSgOitMpe+rkRHCH3fGfW4eXakRl+fJt8nmMlykYDVFJ95KQ
         faF2515egiE7jA1eALwi3ILuJxd5dWxMHgZPZEPIRbWDFBquVPj5+H9X3EqEHRHboSKu
         9vgq1b78NAK2tHHZimh3SidH+QD0lkaj9iNIDSEEMqOhtX5W/eKM4WHc/6615I7tTbFw
         R1DlBquI+M9bEpkOxLZqqsW71vUrODGTXFejcVORq19VsrehURVcJT1jq7OMgkFuh7+1
         r1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590972; x=1784195772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQWstozVIG97I2bGchwtRWDPF++c2QX2x/LEEkoUKs4=;
        b=Rrv0ck2W+gBbVrQiJdvAhtkGJLxRwYAcV1eYLoyJ2s0lupppmIGyxBxEzuHjMtLeLn
         MP6L1/9zqP4RHgr+zSoH3YD+CCeQTFR6me3hWmuwu5fwdu7w0984gjjEL/3zl3vfvcIR
         33WEfbUwPQd08obf5QEY9c9k8dOmDG0ApQuvAQB7o7vXzkjc+nkbfXo4Cgd1GWAOj8Ma
         gNHfwgIflLLN0uBwgx2161qMHXI743K8agy0xmEz/TDFbLPNEHhKto3TU+zFOp+lsVRj
         Dl0DqGeC9TatRPU2LB5ehdudKkxyVVebdueMqDH5A+qBaThTWpUJJmv1QJdFzBZQdZOs
         SWZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjgaaulaK8Zx2REVErAuDi/nMm4Ec74PuxlYTog0vkDrcy4g+qxskQWjWKBamXbYz9Ca1d7JP1p0X+@vger.kernel.org
X-Gm-Message-State: AOJu0YydyNBawkp8CLGZlDAQ9GK724IijaAiG0tXqX7Xx6dYBQWFAtQU
	PvF0mge3JHWGq87P+4u+BsWg5zXJuZHHpSmB620pjvaLlrzBin6MVYLXq7eDB1MfGeA=
X-Gm-Gg: AfdE7clhHkiN81HividZranyFlc/RxxTKfl82E6MGVBVZfl3PMmjBuFPf4JIadH1eby
	10c5RF4jdt2+/SDruX3UVaI3cS29PXwfJemfEy2YTFH6lFkcnbeVYC5g43eHe9Z53gqJ5Im2yyK
	LRgKZIynsZ1/Hjb7HKjEGS6fZpdijaWnq2Y4vBX8wanLAFWwf1DY24ZWbPkhOAnl8dbeQtx28Dq
	p9HCuV/JU1hfb45eYeuNN8J74y9UgMU/t0OPzeP6Uij3YJwR7xS8bZqsnV3c7vxnoJTfrE3zm2e
	FeCl9b+3/7X+ooqpR/ucRWvNJAikuJw3Gh9kKCTe44oiVpSSg7CXox+cNAzVp/iYSytTXnk4IED
	87+trZH2ts9+O5IB5WuFcqm2dIZrU+tPuTg0VRt4glg3Xhew/WRPmuZiG1bIE2FM3tc3UQDY6n9
	5P7Sj/jkuJo/A7yEHjaPf/Jg==
X-Received: by 2002:a05:600d:844f:20b0:493:c77c:108a with SMTP id 5b1f17b1804b1-493e68a1dc1mr47714715e9.36.1783590972300;
        Thu, 09 Jul 2026 02:56:12 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a572c3sm142014615e9.1.2026.07.09.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:56:11 -0700 (PDT)
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
Subject: [PATCH rdma-next 11/13] RDMA/core: Make device names unique per net namespace
Date: Thu,  9 Jul 2026 11:55:30 +0200
Message-ID: <20260709095532.855647-12-jiri@resnulli.us>
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

Use rdma_dev_access_netns() to scope RDMA device name lookup and "%d" name
allocation to the relevant net namespace. Keep shared mode and
CONFIG_NET_NS=n behaviour system-wide.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3ccf4731154a..cffb0de1c001 100644
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
@@ -1240,7 +1245,8 @@ static __net_init int rdma_dev_init_net(struct net *net)
 }
 
 /*
- * Assign the unique string device name and the unique device index. This is
+ * Assign the unique string device name and the unique device index. The device
+ * name is unique within the net namespace the device is assigned to. This is
  * undone by ib_dealloc_device.
  */
 static int assign_name(struct ib_device *device, const char *name)
@@ -1424,8 +1430,9 @@ static void ib_device_notify_register(struct ib_device *device)
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
@@ -1716,6 +1723,7 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 
 	xa_for_each(&devices, index, device)
 		if (device != skip &&
+		    rdma_dev_access_netns(device, net) &&
 		    !strcmp(name, dev_name(&device->dev)))
 			return true;
 
-- 
2.54.0

