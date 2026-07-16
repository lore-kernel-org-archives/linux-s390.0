Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99029423EAF
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208216; cv=none; b=J/evRjRbD+OmkQq8sKSivNKhZb/TIWAFIjy8ADyo4C5oDRzsgjQaXbrGNoMukTZRJTYaw/rslBIKc20tDfMeJysMVyTfaT/ZtY7mrCHZkwcioH4h6daGzJ9GjI7Sby2aVhSr3yXFoTt3pafunSpybRyyMTGIso7JXiRubcrd6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208216; c=relaxed/simple;
	bh=wA8BNmGtATPpMY/ZSlkPeyL8zmIVQzgdWs9Vab6JUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7aBW8TeDO9dOp1pVUYzrLrj8Ialz8+NKrX0fUXyN9xGuJ6gxrXhi6IZOjS69j/DFYVKqk+PIS+eEF5Okweuok9YRKWJwNmXsnT0f/uc/Cw/UtFkYdSeZr/AURL1NeCUPo2U/UA1u/RPALRK4C0eoc4W/U0Brhw7RoIiLgVtv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Br8CC7tV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Br8CC7tV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47362928f65so5974066f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208212; x=1784813012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6vRi0FyHKR2HrcrI2hLHxbpKJ44GeP97d/xvetjGhOQ=;
        b=Br8CC7tV81r5agHImHao83FZpNvcAlBgrrnzrjU/BeBD3ZQ6Xcil83zKAwkgjiY29z
         Iw2dNC65qePtn144A3V5ieMY4wvLiY19HNDAUFJ+YQsBL6cKO/LKClYDHe66pX17t9v5
         gaj17+LjGgQ12CqIMcwpQ2E3+5t7GkpEKvDv1I1YXhCmEPu1Yqf3WnxMteZmSVf+Y/UN
         WfcY79aLue/YPEEw7Ncw6XasTNYAQmHBki6Te1S1P159POStiAKhc1fG60yYJZ0eJcmz
         pPfaDaLqi9DKJoFz5hezkopMCEp3Ax/h+yaL7oQ5VOWPpAhzg/cJsC1a9zpqBg8D/vR7
         2jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208212; x=1784813012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6vRi0FyHKR2HrcrI2hLHxbpKJ44GeP97d/xvetjGhOQ=;
        b=aw2flZYgBQt/CePOruH1C3vutKsvvUa4onHJ6IeHs9pKm5mWs0trD6NJ2unP03MaZP
         HMDRWXfmWh6BPc0kugQpkUA5G4jNYsV7ODDjUOW5G+Dc7ycnheg6VQyHHLs3MwHEy+Bd
         E2ia1pNFy9PWeX/XFv/GQOTE5JDWU1gN3DJkwCRGAPPUaCt9zfY02attvUVURctobtn7
         Atap6ZRMaTke9hSWwFE2wRwhepDOgRZy07kZxCPwRV1RHqHHOIWmb3ubw/bmf4l2Bedp
         g9AiwEJ+Uwzk0umjKCXI4/YmiDnxuqp716rIMPhhSk8uYc6847kdAp9Xfxqgl1G4s8pg
         ZNbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/F6jg7v3Qf0LJez1ofzmAhs0lfSa/EGBU5sa7/++Vx68CzHG8LRXRxEMMmR/dsroSl5NoTHNbIU6/@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1BQgPe52k7qf1BcC3AymOxTuALyp58gb2gvLMcO7WEPTLB1i
	/iJ0SprOXEa1A5nT3ZUrfIPswDiPA5pnZ5RgKcbDsBGRc5tHoeIfyLl+TjWnUx+hEmg=
X-Gm-Gg: AfdE7clzv4hpPqy78QGHvbn4h4DuDV8s0S+4BkQB5nM4XEjaqKKP2JomungRjRJ6HyY
	mizGmZ8B7sobyk9rOfodEMCP4RQxqHHNPUHeOKJTivWVaZ9hvbexCiLt8fZ5u1xIV9/Ox5yqaNe
	bUNfHNkPF7hzH6aLfelRQOsSfpViU+354JuStpSIT48LJurXwyT9e+bPFD3KpbDSZpqK89L3eim
	2dL21UmnLcIsxTCEW/yQNvxouGNTgWpn8B7QAG6BtLMNUsDojQcZjlRKkzYo/bJ3ICkt1Szb2Hf
	JB3mapxYmMjedKjhlzp4DW0F5OcZqQg5H2XuPZNSDsrgKQQU8ReuW13uDFBfg6vcgwGIyMoKShl
	m3quUnn3Z6OFhbfQ0mzj8fyIgyPAJuC29FGUF0F4XLtzwRXFyA0rWVHMDjyik9PnZQToKhXp1RO
	z8MaN7sbxvNTXHMgtHfOFeIQ==
X-Received: by 2002:a05:6000:25e3:b0:474:6a5b:8606 with SMTP id ffacd0b85a97d-47f48857634mr12654000f8f.21.1784208211514;
        Thu, 16 Jul 2026 06:23:31 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm25333364f8f.35.2026.07.16.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:31 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 03/14] RDMA/core: Support renaming a device when changing its net namespace
Date: Thu, 16 Jul 2026 15:23:04 +0200
Message-ID: <20260716132316.1495242-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132316.1495242-1-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Allow namespace moves to request a destination device name. Keep requested
names on the same literal-name path as the existing RDMA rename operation,
and keep teardown fallback naming on the trusted kernel-controlled path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  2 +-
 drivers/infiniband/core/device.c    | 48 ++++++++++++++++++++---------
 drivers/infiniband/core/nldev.c     |  2 +-
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 19104c542b27..3bd5bb7135a3 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -356,7 +356,7 @@ void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
 				     const struct attribute_group **groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd);
+			    struct ib_device *dev, u32 ns_fd, const char *name);
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet);
 void rdma_nl_net_exit(struct rdma_dev_net *rnet);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b55fb075d0ae..c0b6613dba4c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -268,7 +268,8 @@ static struct notifier_block ibdev_lsm_nb = {
 };
 
 static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
-				 struct net *net, const char *fallback_pattern);
+				 struct net *net, const char *requested_name,
+				 const char *fallback_pattern);
 
 /* Pointer to the RCU head at the start of the ib_port_data array */
 struct ib_port_data_rcu {
@@ -1173,7 +1174,7 @@ static void rdma_dev_exit_net(struct net *net)
 		 */
 		if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
 			ret = rdma_dev_change_netns(dev, net, &init_net,
-						    "ibdev%d");
+						    NULL, "ibdev%d");
 			if (ret && ret != -ENODEV)
 				WARN(1,
 				     "Failed to move RDMA device %s to init_net on netns exit: %d\n",
@@ -1714,12 +1715,13 @@ static bool rdma_dev_name_in_netns(struct ib_device *skip, struct net *net,
 }
 
 /*
- * Choose the name @device should use in net namespace @net: keep the current
- * name when it is free, otherwise use a trusted '%d' @fallback_pattern
- * (namespace teardown) to pick a free index. The caller must hold the write
- * side of devices_rwsem.
+ * Choose the name @device should use in net namespace @net. @requested_name
+ * is used as a literal device name when set. Otherwise keep the current name
+ * when it is free, or use a trusted '%d' @fallback_pattern for teardown. The
+ * caller must hold the write side of devices_rwsem.
  */
 static int rdma_dev_pick_netns_name(struct ib_device *device, struct net *net,
+				    const char *requested_name,
 				    const char *fallback_pattern,
 				    char *buf, size_t buf_len,
 				    const char **new_name)
@@ -1728,6 +1730,15 @@ static int rdma_dev_pick_netns_name(struct ib_device *device, struct net *net,
 
 	lockdep_assert_held_write(&devices_rwsem);
 
+	if (requested_name) {
+		if (!rdma_dev_name_in_netns(device, net, requested_name)) {
+			*new_name = requested_name;
+			return 0;
+		}
+
+		return -EEXIST;
+	}
+
 	if (!rdma_dev_name_in_netns(device, net, dev_name(&device->dev))) {
 		*new_name = dev_name(&device->dev);
 		return 0;
@@ -1758,7 +1769,8 @@ static int rdma_dev_pick_netns_name(struct ib_device *device, struct net *net,
  * Naming rules are handled by rdma_dev_pick_netns_name().
  */
 static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
-				 struct net *net, const char *fallback_pattern)
+				 struct net *net, const char *requested_name,
+				 const char *fallback_pattern)
 {
 	char buf[IB_DEVICE_NAME_MAX];
 	const char *new_name;
@@ -1784,8 +1796,9 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 		 * down, so a doomed user move does not disable a live device.
 		 */
 		down_write(&devices_rwsem);
-		ret = rdma_dev_pick_netns_name(device, net, fallback_pattern,
-					       buf, sizeof(buf), &new_name);
+		ret = rdma_dev_pick_netns_name(device, net, requested_name,
+					       fallback_pattern, buf,
+					       sizeof(buf), &new_name);
 		up_write(&devices_rwsem);
 		if (ret)
 			goto out;
@@ -1801,8 +1814,9 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 	 * level.
 	 */
 	down_write(&devices_rwsem);
-	ret = rdma_dev_pick_netns_name(device, net, fallback_pattern, buf,
-				       sizeof(buf), &new_name);
+	ret = rdma_dev_pick_netns_name(device, net, requested_name,
+				       fallback_pattern, buf, sizeof(buf),
+				       &new_name);
 	if (ret) {
 		if (fallback_pattern) {
 			WARN(1,
@@ -1857,7 +1871,7 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 }
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd)
+			    struct ib_device *dev, u32 ns_fd, const char *name)
 {
 	struct net *net;
 	int ret;
@@ -1873,9 +1887,12 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 		goto ns_err;
 	}
 
-	/* Moving a device to the namespace it already lives in is a no-op. */
+	/*
+	 * Moving a device to the namespace it already lives in is a no-op; a
+	 * supplied name still renames it in place.
+	 */
 	if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
-		ret = 0;
+		ret = name ? ib_device_rename(dev, name) : 0;
 		goto ns_err;
 	}
 
@@ -1891,7 +1908,8 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 
 	get_device(&dev->dev);
 	ib_device_put(dev);
-	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, NULL);
+	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, name,
+				    NULL);
 	put_device(&dev->dev);
 
 	put_net(net);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 32b6c4d68ca0..77a758080148 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1195,7 +1195,7 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		u32 ns_fd;
 
 		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd);
+		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
 		if (err == -EEXIST)
 			NL_SET_ERR_MSG(extack,
 				       "Device name already exists in the target net namespace");
-- 
2.54.0

