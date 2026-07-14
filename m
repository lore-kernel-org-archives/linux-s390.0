Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5E47F2CC
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039391; cv=none; b=oh/JRffd08DMCdUF6bIfbIo6rC9Zm9L0jn4etPNlZSH1ECTWzC+LK951L7xrQjLjqzZX6lBmCwemsyFNUPmsq/er5n3d33IpRq3EZg9pKlN5ijzPrQVTc0t5+aGxJfY4ZH6WBnGAQuOxaS4kYS2AOkH6iCbu8hqX5n40opIg7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039391; c=relaxed/simple;
	bh=DZOG7H+X305alvcfYyKRY+OmEfAdQKwMydMDvfsKbqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqFUJQ3dcwUcAglYfUfVMtkQ5WpFldJWU5J36h/Bu7Z8GSkuNrgnG1u+X863bqFrmSdFxwrQQm396rifMKU3/WSgJkiXAOF9sch0FS000NGHwNuGxYwfjGXdAG4dmiHlanVq1fEiGsaAbFyDnav9XUy9BrCHFwb9hTAfcUZASWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=l4XP7SF0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="l4XP7SF0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474560436c3so803307f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039386; x=1784644186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hvdgg/J5f+MIG37tkYT96k3bKW9qtjOneXBYLVa18U=;
        b=l4XP7SF0IByEVKhGr7Vf7Y1yShSB4+Rs/MFo7ues8QMwl7+WB+50t8kXlqdJq7xZpU
         bEt85JrI/XVLxozq0aUkX/M38HpMMwjMag2E5PA/VmhebAXIaSTohdjPF+Os71Jfa53y
         knbZyRJQxmPfR1FQH9+VmjZTRVj1aULztk+OWV/BkaHEvnfVv66vA9HF7/fexINQuvXH
         Pc5wHQRwsQMduR9cUkKX/XXk+B/IVOt32EIP58t4kVQqHWH9IYQURJ0qhDmxS+Rr7K90
         IFHfGe+EvrjW5MoP84+0y9IBwXt41jRuIHe620DsnY8tAdr8nQg08gVAD6fsDx/alodF
         8+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039386; x=1784644186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hvdgg/J5f+MIG37tkYT96k3bKW9qtjOneXBYLVa18U=;
        b=iQJ2gwnfybCBmUp3q5acjhAlYy+WOz3kvIZnxblHC72ofd+5BFHn2O7MYloFAQy+2Z
         k3cqWPY/jVhxljppOW9pTYw/++BSNsCathhHgxdROgyDY80Cpq2RW556CDStK73tW/5W
         PrfrDXgp0Eb7q5/edaYvQJ5cK72mJZq+fEAv1k1UO7Oe7TKvaq5Y9tiDjxOVkhVE8n08
         xf0C7h5QwXO0Uf+xJxuDPZH/45DJsWTT4wQFnOFADefiK1xrPzJ8EDGA7bgzIzKN6qYB
         5HwvqAOjqk5haYPldFPk3wVczNP+4k/AA6L2s0H3uk1ZfGNSO/divQxssyWJzUngJhT+
         OHLA==
X-Forwarded-Encrypted: i=1; AHgh+RoNzeknixFdFO48HZGlNwUnpQPNl1xACi3bthaMETePKR8e+BQ5PEvXp4NrCGvorXFhZBG6VCDoZo6U@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHtgIuW1OEl8VHQbLp1oVYfcg/NlrUof6hROaGgzdjwW7vadR
	6OBqvoy5Gg0CijQkB8P5kwK0PuERFWAnTN8vi7tJB6pvZjuPMzMU/kfpUv/xn1TbVAjO8xACUyz
	f/j8n
X-Gm-Gg: AfdE7cmXkS5DWsOQt9Quo1G6AIxdKdoxHvXoqmC/2hwvzEepQ6pyOiI9kzVtCp7xZ5d
	seiSkolmy6VdtAcW4WfcsDrYmNahAWQXc0qNTCImPdWPlT7K/dgdg6jifIP1p2aJ86zcRoHUnlu
	KM6T0ESo6jeEMiilklAvYFXaUevFcx1ddk8+X8U4hLPudZkGSahhE0StcfTKfpE9fVhbxABrzjN
	POMMAtOanV9W1sZh/MY6CyIE0e8H61vrdh/P7zVTvzuKpfq2jfMfrkJhZgqOdI93MnKmhWTWEY/
	x180+OYl0FOHzQVkfRlYD+bmc9Bszo8iNEVBDixpOFs1n+e2y2aNiZiQ3tUc6f8SwU75C7J40lX
	5qEH/laYXHW1kMUkylmo8NZzxdJhXzYhyzGB9SqWyJqGpEd63h/GETJActcfeOWUikerTaohaEJ
	INTtR4vMKRU5z+4hr/6paenw==
X-Received: by 2002:a5d:5d12:0:b0:472:4861:5d4d with SMTP id ffacd0b85a97d-47f2dcc35e6mr14880023f8f.23.1784039385694;
        Tue, 14 Jul 2026 07:29:45 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm9076863f8f.4.2026.07.14.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:45 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 04/14] RDMA/nldev: Report net namespace move errors through extack
Date: Tue, 14 Jul 2026 16:29:17 +0200
Message-ID: <20260714142927.1298897-5-jiri@resnulli.us>
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
index c0b6613dba4c..366bd8463c07 100644
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
index 77a758080148..8648e95700bf 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1195,10 +1195,8 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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

