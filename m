Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9442377B
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208223; cv=none; b=Co7R+si0tbM+ua+/lLgdxbTSU0H7fT4rq8am/q1OTd+Ook4ezHYnvjqv/71ieVZcOb3umcbX0r2rSCwtfr71q6LljExg2if/KU5hH8F9N9V0zaxzJbba5Wz96dfiuzKaXJisvF14Cy8A+AAtoqaf2XI3LUIr/JCZjcCEC/0oA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208223; c=relaxed/simple;
	bh=arqp4STH24gOt1WR8ANOHexprcbXDePbt4BmXI/EbWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkn6hqHMxg6cHRgEEzP8KzlIHp5C1/WTKbuCUBzDRarrvJF8e8aG6LZJNuQHhEOu+slI8jjE8BaJNwjdUhaMlSoUL+uOvbJjOaVErATMHgErfn8eCxfvF/XFH+py2jvaC3SG8m3radGBFl275NZgokqCASSDVYdqDLM5uu995lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ivOkC5BN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ivOkC5BN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so203866f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208219; x=1784813019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=ivOkC5BNl3SQ19XypVbUyQW3/zuX/mHlWCJ/CuOTXYJ2NERig2+XGdmbP7yrONswqS
         jUGgo8ElXZtq57huP6IhSZmAZTMiGT11supfwnyNNbCS2w8wW0AaDWpqJjSHOSNQdM62
         YIlTbju1fzkI8vRsIw75Bup0ZM5S5DKaKjIYO0/4n6+fBtUCTDN1oZooYqeBe+kU0te5
         eDF63RqOh+hCY6pg97mo6hk32nSzInJLgA6tJMwXeEv9lem0bKQSU9laAfmwFFVMi/W8
         qbyI4x7wX1Kxij/UN9Hl/Nc48lQvUkos20pnXgv9IB9ncwYkEGW2/Vdn2s/lC1NYF1jb
         jQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208219; x=1784813019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qLqbGYXrDU0DpDR0so2JkJHWGdeLy/bGDG6GJds0Ueg=;
        b=AQvGhFF+dAeqVzGWSdN/7Nlwp7a4Eo3YmOnVlL0hucpHuGH7UaZmffOtg/DmraIi/t
         kixRwgxivZTQ6Yk07bXtS4EXlZT3HhechFSSpkoD902C4DArVa9XRqZDn0SQlLo4Yj2B
         nBgVW93XsmUTZrIIVva6QstWZ0eUno+jDtQ9fCmTfxwTsuHL07EcV1U7z8NlmUlcz/pp
         G6dseh5nl2yUB6nU3Av7YJbNksikPm6qjw3Ngpz3iHlMM03mzVXaoGBQwG2339pPrrhq
         QuXGuxixUMZneYsOIzo6fcFmvg7VO/e8a8fKLNA23fPFa0m2u37uV5szE3KNxdIpgbau
         xaDw==
X-Forwarded-Encrypted: i=1; AHgh+RrQl8pQa2BMPKupCTVSpHNLMkJ6vVyN/9/2Lm8LILq+ZYPpFfz3O4RPt4zdMD7JzUJ/r4BQ4NB7eJUd@vger.kernel.org
X-Gm-Message-State: AOJu0YxyE5upjeWvrQUhdtE3U+gZc9P0DNnSRuQSraGiwDwH/atItiPB
	GLL2E7WhexX7KVTpC2eD98W7MkXcLWtgMTGsC0+N+kCc7ixs1e0HmfXS5I+r/YP/n3g=
X-Gm-Gg: AfdE7cm6OMfHfrFwzSFYjhEsDO369GvsFXShhPxlDaKe0MrmiBi+JDQ4LKogUo/qb4r
	ZRoIOlhCvEC0AVe2c5NP3CRN8cOMJYnPQImekQnXABRtn5gHcw3y7ZX64F6cIXQ7vAat/PpmfEc
	rz4j1o0n5Jm3R8uKTzsREyXnrMDwWSqYF8XVMadyBdqYaN6FsbC461B1eAckgFbtupdluX3y84y
	llgP9Xu5kOxHxSH71aPBIA6mVDOom70SxzTNICgb1kpBLFs1+AsMqMdQWvfbZgjPKMwh8dSfQTb
	WqE9W3rzLMw3oQaOcH4yURpA2V9DlbUHW5WP3Y5IqnkwuiIe+iD5zav22/5YpM87zigV+OUVbdQ
	ej3pCzLgaVIfOwKc1lkvzOUG7dsa0cbJkiLIQ8HTSneWkObPcaurald5tBBMPbywMn2imh3Ln1A
	ct9yQ0TpE/KIQHvMaEeLOtAQ==
X-Received: by 2002:a05:6000:4b0d:b0:46d:8169:bb39 with SMTP id ffacd0b85a97d-47f2dd1f302mr23305304f8f.37.1784208219414;
        Thu, 16 Jul 2026 06:23:39 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a5d7sm23809932f8f.10.2026.07.16.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:38 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 05/14] RDMA/nldev: Allow setting the device name while changing net namespace
Date: Thu, 16 Jul 2026 15:23:06 +0200
Message-ID: <20260716132316.1495242-6-jiri@resnulli.us>
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

