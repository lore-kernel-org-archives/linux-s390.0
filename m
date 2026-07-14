Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77219448CF6
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039378; cv=none; b=H5sOTHz4FAv6lf91GVujecHMefjKppP9eFe7RDrV1NmO9FJ7Po90xWXaODTRvvv7zd75FAX5DXY9EGVRYmbrKhwT2EGJbzaZEoFVwgRG4Xo2sCydgykH1HqG2aLUlMMrcPCKCsdRrAT/HctD6ZgEXdP2fV1m+BQ1hYo5XAKmynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039378; c=relaxed/simple;
	bh=fj0Q6ihUmYqKUkY8KaHXFWF5Aioa8BtTYy9MtuieBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMZ781k0MyR06TipubJa/xpYTYixk7JwDvtRNzOWDj6OK8cGQM26sszG6SGE4VTSFmfWItH+9PM7aUQ1Ja7NHWUnXBUklOD1qy5ZrshNK6AlLYink8CAEHlIDcg4PfQM/aU/KM4Mm69zZHjuqMoTzBefVuoB9QYl/HV/ugtUJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Rw5eW6pp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Rw5eW6pp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47de008b020so579175f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784039375; x=1784644175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=Rw5eW6ppmDIrndA6q1mBhiSrnWhnU2hXHfxl2KFtVK1zkFOxQ43DK6GNmKOJP0oX5q
         r3vwazSVBJXfppL7Hoi94Ew9DpoaJut7vGKVwOYJ8an9S2GM0nQ7Oe3jGQcJVXuqWiua
         P9pqV36DnvKqa+LewDRIhJTP2Qfnov4Trpk3SgB/Znf3aIF8a7Jb+Fft3Etng1+OQBG8
         nlajd3Mu024JqN050emv6K2zEa6bKNEL0URvLDxBJSz9kSUx1T2f51I0X3H0sB40oVht
         z7O38q89XSmUmFTTh3hg/YndietSfsrcqhAaQtd3sKVGd6Yzniz2akLTlCOK6RLGw8lW
         /4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039375; x=1784644175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=KW8lvJus3s6EBg8rg5Lg8Do+kc7fhogZK1fgBOdgOXU4euBWaoQ8fY191tTC6l3akw
         ET/YkELx1KcqA6T8STusDTa0aq/y6nOTvgYUxESuWjgQZm3oU1vijF3i/EXspTLOZUEy
         V95vrQ5tjrlc+/KQtRwHKj3K1iSeeL5oezZ7EXHljJL/7ZshYqrEBKNNURw7bX+vvnVc
         m3gS6kpVmtSeImaGhmJZrVGlchKYMDZ4RKdJAEfrinTxJKORtH5Lxf//11M5UGg4J4ZO
         TAnTRr3Jlj7R8gkWFZ2eRpvx08E/jnuWYhBtouVHaOPjjdauKJ4FjFFdm4CegCI/kG8A
         wNeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYFfLKmhXZDNE8I+v/dKGY4pi7mnR4uyPbM16Yc/ke79Fkdg9bmUsn5x68rU+kfhl9wIZiOxMu9yFi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GlpbYXbPqKQh6hNKPfEkLWvwXphiWlrGkPbXJqgoK89Um+hd
	sFFgNyAQggHMZWoXnWwt9LsT3wE7cQTLbQ1wJOL89u3Xlb1JCvRP7/IdPBMGg6rsHOo=
X-Gm-Gg: AfdE7ckr7DMjAOZOlWAXDQSdpqUeM6TGsTyfDUUul7FsiAAmfKuHGu2nHw2aOQJNFG7
	yNE1l2b4s/ve2FYHx15beS4LVHQyD5Fc0aMDCA9nUiqeSm1M3EBUUJ5XDSoAYgmIUnXlP6+OaQ1
	faCdEpGqaTOyoblTl8Nz5dD9OY5EhKNE7a/v0Kk/0UItMCSZD5rgVrb2i2GS+a3uQojVTLaCN1K
	oH9UUkW3x6d/sXc7N0Qeuyj7FW0eaqvkTq17zNe3tFbrjsZUmQIhVDiWo0DyHIttZak5BB6/YW0
	OhRBGo8ICfrJax1yiv11/x6cBOEj2UqKY4BbnyqxoYcZ0G1Z+yTLhUDhRKS33JQEwj3QPUh5NRv
	3ursVbyZe+YftTMvtF4MySpsFmRmU73KbpLqBzGQfk+hqB3uamFoRD5QXueZ4DjR3jsFOIiLqts
	T0y8jnFXsmtBe01vW3YELlng==
X-Received: by 2002:a05:6000:1866:b0:478:7019:e5ef with SMTP id ffacd0b85a97d-47ef6986d21mr22449614f8f.21.1784039374656;
        Tue, 14 Jul 2026 07:29:34 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm8626412f8f.35.2026.07.14.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:29:34 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 01/14] RDMA/core: Pass the net namespace to the device name lookups
Date: Tue, 14 Jul 2026 16:29:14 +0200
Message-ID: <20260714142927.1298897-2-jiri@resnulli.us>
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

Prepare for per-netns RDMA device names by passing the target net
namespace through the name lookup and allocation helpers. Keep current
global uniqueness behaviour.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b8193e077a74..de610f52c9b2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -351,7 +351,8 @@ void ib_device_put(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_device_put);
 
-static struct ib_device *__ib_device_get_by_name(const char *name)
+static struct ib_device *__ib_device_get_by_name(const char *name,
+						 const struct net *net)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -395,7 +396,7 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 		return 0;
 	}
 
-	if (__ib_device_get_by_name(name)) {
+	if (__ib_device_get_by_name(name, rdma_dev_net(ibdev))) {
 		up_write(&devices_rwsem);
 		return -EEXIST;
 	}
@@ -435,7 +436,8 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-static int alloc_name(struct ib_device *ibdev, const char *name)
+/* Pick a free index for the '%d' style @name pattern. */
+static int alloc_name_id(struct net *net, const char *name)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -462,15 +464,22 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
 	}
 
 	rc = ida_alloc(&inuse, GFP_KERNEL);
-	if (rc < 0)
-		goto out;
-
-	rc = dev_set_name(&ibdev->dev, name, rc);
 out:
 	ida_destroy(&inuse);
 	return rc;
 }
 
+static int alloc_name(struct ib_device *ibdev, const char *name)
+{
+	int id;
+
+	id = alloc_name_id(rdma_dev_net(ibdev), name);
+	if (id < 0)
+		return id;
+
+	return dev_set_name(&ibdev->dev, name, id);
+}
+
 static void ib_device_release(struct device *device)
 {
 	struct ib_device *dev = container_of(device, struct ib_device, dev);
@@ -1223,7 +1232,8 @@ static int assign_name(struct ib_device *device, const char *name)
 	if (ret)
 		goto out;
 
-	if (__ib_device_get_by_name(dev_name(&device->dev))) {
+	if (__ib_device_get_by_name(dev_name(&device->dev),
+				    rdma_dev_net(device))) {
 		ret = -ENFILE;
 		goto out;
 	}
-- 
2.54.0

