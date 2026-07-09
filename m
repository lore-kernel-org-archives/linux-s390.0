Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956C9403AEC
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590952; cv=none; b=PeEi5rbFgDotzwmDhx+6g3o2ZB4lPwigausnopoei2jEOn1j/CnP1h0hz6K5ov3M3wlqWOtxLI9YRss5fb2YJD2nhzyxAf81XRQhZzwpvEZ1pGEh42pUMz++T/Gzn9KDIY5KTFOwX1vUDrH2o/HXTrKXOIxGPLrCCqkbjg/3puk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590952; c=relaxed/simple;
	bh=Q+ioYosMcLR28Rk0UHBuj7VHjIKeDcYl6ZIU8ovFwzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSzPT8Ka9RzoDh+fks400GAu9+12hF3X8mxcFeeo7PAPh0NFq2qNrxir5jWrHU3BVnfjQbXbcU0jchBNEK89Tsd+HIJc9vSdln5Q/GCLJH5lUKlOdjf18DOkeK0WtFfQcUFeh60iDQGkdPeHljqE3I33dRCvK0EzlvTt7RfyWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=e68+VnAC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="e68+VnAC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso388556f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590949; x=1784195749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTe/xvJ3msxEWBlJbFLbtJMtjmfOZ8+sCmPsSsQl0Tk=;
        b=e68+VnACHZD5r0+cV/7XOA3nTEwnDSV3wqroEG/fEfl6PLGr4Ci5ZyMFZ65g+BWnW9
         uLrjRftydX2HvPgPhOAhbw7dLzk12+4nKpZ9kngjNEIJNQjJLgBEPmNRwhYYoBTh6ZG2
         G46vlKa/DYRXLtFIz6w6HFu7C+jXb5eNVq4xp/hDENEajydcsCHoMEnPp/7TV9n/Ggpj
         XgrPQqU7unmGcE6cJ0yMyYg4eevxwostaqgzdrfpRuh0nY75nKUrBTSlkaG577qA+tpW
         G0eCBH1qphKzjk2xobtR5QolJFMWpbtmiEXw97lhpWYG3CjaOt/RQn/VT9UG+IjqGkRX
         QbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590949; x=1784195749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTe/xvJ3msxEWBlJbFLbtJMtjmfOZ8+sCmPsSsQl0Tk=;
        b=DCFh9B/40OnClhhUQ69ciCPSCVEAhUyQsKce8j/aw4FpGcpKZh9Frl+SRVHfRKmyOJ
         2JuM2dUPFJlD47knepVSy/Q+ejLqUBK7cjKs4d3Om+NQvJxkVlz4QHLCRfBBzqIiEN5m
         zBj3XoeLz/iuva6+/nxYxSUuM0a6IAugfYBBi5tP2XAHvTvYMQKc4ZJBTi63MbjWiWp2
         r3EQHHBTrQyAnWLpnJg+vmOnvvgM83zDrL837urYy7VHaTkPvnYRFeV9W9FiN8imaDWH
         6GwTvADG/uULC01JTzFuwBrqff0qzDzbdgDyFzCOjbPTTBao9kgQttr3FuZ7AssaAj7Y
         wTwg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq8Wf9JIaH2V7wIiiieN8rY9QGyGycCWBwJVshzww9+F6ck9zTl+35UOUPdyAIdpAuGGSGFhtztYpu@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD06acPAZgbzSLdrpJyqyOYB2wxJoX7doWKb3EGPY+XI7hDKV
	gAxeXTtfsv3zrz/BgWXjzP/7ouN3myuo07XQZHgWHSsrl1UqX3egcR0vJAqa66ZRbIA=
X-Gm-Gg: AfdE7clgvotN6PihA8pvvlF6Wqo6mWG+L234EhmGegzYovBLs31aTqtYRJFg43yICw5
	k07cmzbZqMTxA/g8fCtgx17YgcV5vhQnFo7Dw2luRp2LCMjnuwohQhXjMaH32bnibe8KDUpsdm4
	+CpuFkxxgAmoPiEEj28tszmyU9OwpHoy1yeKPbwPQ3wZwbFz6/OIRlY+v+X1ywOykNCc9O9imNj
	mTMC8VKEgBlTOxsuNNvbNYxkbHmIto5YtoO2jpmVCvh/FIKx3Pf+YfF0X3SmxvdJwTyiAkZ+4fg
	9xszqrxJxn7m51sM6kEET1q5vdgM0bFogqCwXklk/9+EXPmo3dNxh/80XBcG0PfQCZx68O0wPf6
	7mQZVhkBDKBjr1tr2b3T1rabnSpVX/LgdDNPASBCQH19XgDltAY4E82d3q0UkWPsA+WE8SF+mXW
	jbUg0W5P1XAPhvdn61Te2Ogw==
X-Received: by 2002:a05:6000:230d:b0:472:76ad:b329 with SMTP id ffacd0b85a97d-47df071bac3mr6678726f8f.6.1783590948908;
        Thu, 09 Jul 2026 02:55:48 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50292543f8f.5.2026.07.09.02.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:48 -0700 (PDT)
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
Subject: [PATCH rdma-next 04/13] RDMA/nldev: Report net namespace move errors through extack
Date: Thu,  9 Jul 2026 11:55:23 +0200
Message-ID: <20260709095532.855647-5-jiri@resnulli.us>
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

Thread extack through the existing net namespace move helper and report the
main failure reasons from the core path. Keep the existing move UAPI shape
unchanged.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  3 ++-
 drivers/infiniband/core/device.c    | 24 ++++++++++++++++++++++--
 drivers/infiniband/core/nldev.c     |  6 ++----
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 3bd5bb7135a3..aaf330b0d333 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -356,7 +356,8 @@ void ib_port_unregister_client_groups(struct ib_device *ibdev, u32 port_num,
 				     const struct attribute_group **groups);
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name);
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack);
 
 int rdma_nl_net_init(struct rdma_dev_net *rnet);
 void rdma_nl_net_exit(struct rdma_dev_net *rnet);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 191f05898bae..2391bc7c8d23 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1871,18 +1871,22 @@ static int rdma_dev_change_netns(struct ib_device *device, struct net *cur_net,
 }
 
 int ib_device_set_netns_put(struct sk_buff *skb,
-			    struct ib_device *dev, u32 ns_fd, const char *name)
+			    struct ib_device *dev, u32 ns_fd, const char *name,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net;
 	int ret;
 
 	net = get_net_ns_by_fd(ns_fd);
 	if (IS_ERR(net)) {
+		NL_SET_ERR_MSG(extack, "Invalid target net namespace fd");
 		ret = PTR_ERR(net);
 		goto net_err;
 	}
 
 	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG(extack,
+			       "Missing CAP_NET_ADMIN in the target net namespace");
 		ret = -EPERM;
 		goto ns_err;
 	}
@@ -1893,6 +1897,10 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 */
 	if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
 		ret = name ? ib_device_rename(dev, name) : 0;
+
+		if (ret == -EEXIST)
+			NL_SET_ERR_MSG(extack,
+				       "Device name already exists in the target net namespace");
 		goto ns_err;
 	}
 
@@ -1901,7 +1909,16 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	 * changed and this cannot be blocked waiting for userspace to do
 	 * something, so disassociation is mandatory.
 	 */
-	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
+	if (ib_devices_shared_netns) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot change net namespace of RDMA device in shared netns mode");
+		ret = -EOPNOTSUPP;
+		goto ns_err;
+	}
+
+	if (!dev->ops.disassociate_ucontext) {
+		NL_SET_ERR_MSG(extack,
+			       "Device does not support namespace changes (no disassociate support)");
 		ret = -EOPNOTSUPP;
 		goto ns_err;
 	}
@@ -1911,6 +1928,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	ret = rdma_dev_change_netns(dev, current->nsproxy->net_ns, net, name,
 				    NULL);
 	put_device(&dev->dev);
+	if (ret == -EEXIST)
+		NL_SET_ERR_MSG(extack,
+			       "Device name already exists in the target net namespace");
 
 	put_net(net);
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 3540cb0b9d4f..5fd1ef2c5050 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1194,10 +1194,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		u32 ns_fd;
 
 		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd, NULL);
-		if (err == -EEXIST)
-			NL_SET_ERR_MSG(extack,
-				       "Device name already exists in the target net namespace");
+		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
+					      extack);
 		goto put_done;
 	}
 
-- 
2.54.0

