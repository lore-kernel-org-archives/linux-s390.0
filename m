Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847047F2FC
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039398; cv=none; b=fzWtWq2wAn1scXJnmVl4bjjAvlRQ90+BhftmxxBpBmVB8F9FcRm7tYH31/s6a4dHV8duUvh/KTSfTa8ebGthWbJg1jBhyo1zAxkutqSG5uGiv+claSv09jGJN5821fIJizWq4nNoGFhLnS+mIveJYMipjh/EnAua9Ia9bgKvpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039398; c=relaxed/simple;
	bh=arqp4STH24gOt1WR8ANOHexprcbXDePbt4BmXI/EbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRUiptCNdSIw+ICpCOpL5imZQx3rllEvR3P+s8Lref6hkF0gBLXoqFvfQPmYletVpbIxVgWuOWiV7pxPh4eHWaZvUFuOqgArPZ77o6cYFghyJWmimCUXdzDnZ/3YprT2vKfFxaGTopqsRRnYrz4QseUoAmryS9/fn2xTt/VwwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xnM16DlI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xnM16DlI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso2568066f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039391; x=1784644191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=xnM16DlIVzUY6LxMgC10w6o1KZ1GA5Ge0pBWSNrp3nPS4xlRgsO91PCdOr/S/JQRgB
         7qu+9jf3f29ab3nWMQSpMfueDgXJ8R69tFkUeHris0sDwhellQyeKVofMVCgZX0RhCeh
         fMS+0hTS8Jtex9f6F1pyxwAFysjWulzd/iXEGF7uzdO6jArS9/D8A8woD/UM3mtuI5e/
         SdyBi1aYbyXfHjZ2fPcjsUkl4JAyRVyc7F8rlDfnqo9lgG2whCiCElgueazkrZVtHAN0
         vMfUE4hcAmiqOrrjjE15IhgukjutQG/VfSzoqN3T2Y+KF2BDOaa5rs9AANvYAuSbrivr
         KcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039391; x=1784644191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=MvGcBx9Fysnrd2jIoc/rNgpkF+bEM+D9UgXG31aC83q/pxKYALeHWqIDGIATJJrvlr
         1fy33aEE0T1546kJrVyeAic/hREY2K8wKuBpxMQdtWh0adpP+S//Yg/2hUA5BYJPP0cy
         bH2zaCa45LeDsaAN5tDA+SS4TbVXv54A8iI+rnr+iuC01CgJQTmlavW9zZ6Uk4WrYTSa
         oiL9IkUE0g9hKL+c73oZvvAzaThKiopBfqqGEAUPwfG3nIl3ouY8sZKY+GG8KfeCJic+
         f2mWptAQLALMOTRDpR+Qyh967oN1KTE4kxLSyuQ9AcB0UL8KsJX2KxooTcXh+lpshzzw
         4LPg==
X-Forwarded-Encrypted: i=1; AHgh+RpAvSSvYsgF8PcHFWyzRG1jFkY0BvZ1L5leOwKIwvySLrjVBNMK4eu+XP37CHm8itR+SCf9hArAawyQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHVCYVXEwGvYqFqCLPIl+pJ6s7IJHLNG7HjqItti18cOfAN3l
	77SLRXR/o9nsa71xFXn3VGBGuN1ZeWiPVUC2FrkBi2TgVmbd1pKtF8kKxGLAGmmFf9w=
X-Gm-Gg: AfdE7ckDQiZi39ZCXuAUO9ypVIEt2jMPQumle5xxPNoCWvmNlEQyBE7YaaBH3Fc4CFY
	iVKBm5K+O3a/1whA+I3G37dxgJuerIBGT0HKRhedRp9BswlRfOwDwLAIevgq/6hQ94PBCXzFZn2
	2GunlKa4i2kA7RdQRqnWoalINPWkuuFVzc7zLoR+bRAKGsNRiUPNhGMb3GP7u+BXvMUOi3tz4gs
	cncOTKC/m8ximX5orae5hic8qa8yPKlFArpeHFgemtRRm7+8q5+o1D160HRaz3Y9EbJdUFW4Do+
	8ZJ9KJT7qQMayVsD4lMLfWbopaevnV4Bp3xc0w7yKtvxokOdAPleya6fNVbH/QI7qS0p3zzsAhe
	JvkjxGEh0PkfimOm7MZuTraB9Y5gbDlqa2SAsASbUGaXj70Q+F6YPywL06dqUXNFhZLkHP3F80b
	l2b1QH7DzgaqBZF3TUR+1rZg==
X-Received: by 2002:a05:6000:2388:b0:47d:ec60:657e with SMTP id ffacd0b85a97d-47f2dcecd20mr15946477f8f.39.1784039391456;
        Tue, 14 Jul 2026 07:29:51 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm9077226f8f.4.2026.07.14.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:51 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 05/14] RDMA/nldev: Allow setting the device name while changing net namespace
Date: Tue, 14 Jul 2026 16:29:18 +0200
Message-ID: <20260714142927.1298897-6-jiri@resnulli.us>
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
index 366bd8463c07..bb02640239d7 100644
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
index 8648e95700bf..4efa387ec1be 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1178,6 +1178,24 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 
@@ -1191,15 +1209,6 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
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

