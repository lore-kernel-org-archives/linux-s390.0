Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB628401A02
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590955; cv=none; b=UIb4GchcOi92knUHuHx3+L9BET0Lg+h/WyDXGzKC1mckPURL8zTVLNTLS2wvTf1r3Ejuq25g0Nk8x/1l7nr+J+mNYQgwxOGjzSq0a0AvwePu8oiazLbdpgcwVD66zDiyDH4B97iM+hi4G7DWRe0Pf8QRc1r1BCawkM+5zAOiiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590955; c=relaxed/simple;
	bh=K9CoRzGWe5Snmxtd8ymX7IyXAu1ar0x9Ob9wGfUGEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muz9wRLaU6clfu1E0xhW+7qgHTZPa/mkmXffRpXPgwuHh7kqSLCI6pXh8gEEiOGTcnSVvJgnaKDNCM9BvFlhM4t+IOu17O75syr3sYeBx3XOESR8hcc9mQOHJmt6B4q25tnCCyoaXIvQSlLSFQA2nutuD7ohIES8HR8MKgd3J+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=CTHIOCmE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="CTHIOCmE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c19bad03so15615705e9.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590952; x=1784195752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fNmk0bmqBHuWVqJOuS5xVAk5q96ZY6RqDhKX3ikJqio=;
        b=CTHIOCmEi9IrR73tFiRqc88ohe49m7aLkRMT3+zx6857ZhLioUfs8qKV5jS0R+fyZG
         O7u/tdfTbOR/a1hVWZC6NsB76+wUgI4HuXhLZ+LepMpYnca8JwaBYaOl6zqLFIqUQrUO
         IrsPnoOQvWN6rjsCjYdy2tA9e+aA7pVKxho+l1dbOfdQEFByCpDz8AvQc23KnlayLae+
         ZNIhmUxqiVUpLcuIlM0HWFubIm8c1aCzAjNH5SuXpLU59Pq50lzpYQipkrgwh1q+0CDA
         sKXq6uKcVMTZKCRXpnY0X94ip1CQ/yOSgUyHSeOOohU1CsJYcD4XAjRZTs2o1Ma5Q1bj
         k/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590952; x=1784195752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fNmk0bmqBHuWVqJOuS5xVAk5q96ZY6RqDhKX3ikJqio=;
        b=JEwxPvbRPGnXfLciTDaiVjJi40XtDeQ8CEILjf2cFURM/8Hdw3yxWBXBKSoTO66xUd
         +KODPHhFv42gWNPFTSy+3nu8Es8hb/fH/boaxpCmSHQDL6W0daGcNSsX5auRW95J6QCR
         ayaUXCk+OP9X2FCDiyTVDNuVcuta7rRIYGe4j98C3PDwtkpnpT/JN6dDxHMZJRBW8nrM
         tBdIAcX+/nfEG6kg0ioUJqg3FMGrT/J3IiwJEjrRkgMshj1ygnrkf33aM55FoZMdByjy
         GniK+G+eBLH/KOy7CFNBQ988yvtazVTj7jq+F6ia3CR78K1MwXClCW/nqR2P2Pcy3kUJ
         +iDA==
X-Forwarded-Encrypted: i=1; AHgh+RpEwk7hPCZlYmuu8a+Fp003QKpnVvHX0uswI8SS+Vt9j+JM1L6Fc7AtZLIYjtkW6Qw0BP3X2PQ3X6yS@vger.kernel.org
X-Gm-Message-State: AOJu0YyvezpXaW4/nxqDiK11PxwT/PVF7GRxh6/iAAHVD33twaY8gKfW
	WoCOgZuTokhUkDFJjSwzh+9ElgQr4Pyk+cK4dKPUDvZTtLBwySEXAW4Db/1oYl+GKLw=
X-Gm-Gg: AfdE7ckcuzo7z11XGRdfcyhyMv8Jk6p15p+Ih3fAbjxMXgECGULOc6Z2z4f+lnGxmp/
	x+/sWKGR0c6OBB+aP00iDNSkLgUoiUrjKzQtt+/8K0jjCNhyff4eM47wJOXq6BqSkl7zzvoepfu
	GrYBPQEgjq4AWxWBzI2YH7EDIdC2oBfRysf9goajJTUrWz2yBkA/LjeN3u63tTBXzaZEUpfuaXA
	jBXIeWsrVKngXOyuDTt2cLwcqKH/LxXYjR14WcBaQLTtUi1+L/+6zy9f14yk871wZFT8+68zAqd
	wA/01PIKX0OlaX3/fR18bseA5f5cMJmKDRfhPNhJHHjSIaIYQZGPeJe5fegfGSAmgi7t4/nkJ3V
	lHmLX8sJfZ2ZpWdlwoshTYj2eWwQtfLhlgkKJ9qt5yKidCXi4SW8OEyq2pjzCI3L4fdbQDj5MQz
	A+wnuP4eZ3yLKfTRpbYHKkmw==
X-Received: by 2002:a05:600c:630a:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493e686c848mr60622675e9.29.1783590952129;
        Thu, 09 Jul 2026 02:55:52 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148952445e9.2.2026.07.09.02.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:51 -0700 (PDT)
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
Subject: [PATCH rdma-next 05/13] RDMA/nldev: Allow setting the device name while changing net namespace
Date: Thu,  9 Jul 2026 11:55:24 +0200
Message-ID: <20260709095532.855647-6-jiri@resnulli.us>
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

Accept RDMA_NLDEV_ATTR_DEV_NAME together with RDMA_NLDEV_NET_NS_FD so a
netlink move can rename the device in the destination namespace. Keep the
name semantics aligned with the existing RDMA rename path.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c |  6 ++++++
 drivers/infiniband/core/nldev.c  | 27 ++++++++++++++++++---------
 include/uapi/rdma/rdma_netlink.h |  5 ++++-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2391bc7c8d23..8705011fab66 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1901,6 +1901,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 		if (ret == -EEXIST)
 			NL_SET_ERR_MSG(extack,
 				       "Device name already exists in the target net namespace");
+		else if (ret == -EINVAL && name)
+			NL_SET_ERR_MSG(extack,
+				       "Unable to use requested device name in the target net namespace");
 		goto ns_err;
 	}
 
@@ -1931,6 +1934,9 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	if (ret == -EEXIST)
 		NL_SET_ERR_MSG(extack,
 			       "Device name already exists in the target net namespace");
+	else if (ret == -EINVAL && name)
+		NL_SET_ERR_MSG(extack,
+			       "Unable to use requested device name in the target net namespace");
 
 	put_net(net);
 	return ret;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 5fd1ef2c5050..473bf9667f83 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1177,6 +1177,24 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!device)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_NET_NS_FD]) {
+		char name[IB_DEVICE_NAME_MAX] = {};
+		u32 ns_fd;
+
+		if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
+			nla_strscpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
+				    IB_DEVICE_NAME_MAX);
+			if (strlen(name) == 0) {
+				err = -EINVAL;
+				goto done;
+			}
+		}
+		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
+		err = ib_device_set_netns_put(skb, device, ns_fd,
+					      name[0] ? name : NULL, extack);
+		goto put_done;
+	}
+
 	if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
 		char name[IB_DEVICE_NAME_MAX] = {};
 
@@ -1190,15 +1208,6 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto done;
 	}
 
-	if (tb[RDMA_NLDEV_NET_NS_FD]) {
-		u32 ns_fd;
-
-		ns_fd = nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
-		err = ib_device_set_netns_put(skb, device, ns_fd, NULL,
-					      extack);
-		goto put_done;
-	}
-
 	if (tb[RDMA_NLDEV_ATTR_DEV_DIM]) {
 		u8 use_dim;
 
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 3af946ecbac3..ee11c3bbbae2 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -516,7 +516,10 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_DEV_PROTOCOL,		/* string */
 
 	/*
-	 * File descriptor handle of the net namespace object
+	 * File descriptor handle of the net namespace object. May be combined
+	 * with RDMA_NLDEV_ATTR_DEV_NAME (a literal device name) to also rename
+	 * the device in the destination namespace; the move fails with -EEXIST
+	 * if that name is already taken there.
 	 */
 	RDMA_NLDEV_NET_NS_FD,			/* u32 */
 	/*
-- 
2.54.0

