Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44634401A13
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590943; cv=none; b=fiIRB7UNUc3IpNIH+G3SJ7jFxVqENj8A8L21pDHi432svkt+HsxHe9ZpPYOThoV0NwrCd4LZ8KyJoqxjauJYRJQQsrCNHOBmAeyMZeCpFv0kDvbt/WVe+U4UTSHAhHKf84v5ZRivAqxgF/oLwb3767Die5E+hHIqCCnL0BmWBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590943; c=relaxed/simple;
	bh=fj0Q6ihUmYqKUkY8KaHXFWF5Aioa8BtTYy9MtuieBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVSRJTSDrnsQ5erEgMBFqzM1fKnMuUQEaBwmbx7OQQ6bem08Y+gDr0I733rZclYsed77BdB+BJfcjTrb874nuBWezs7sa1ah1p9jloxhy2euVDB8hbz+NVtFDF6FcuOsiklcYYiY+f8b0XEqdVyFsDsR81zEnYzEX/l6KbBIBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=abftVDo+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="abftVDo+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ba701891so11992945e9.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783590939; x=1784195739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=abftVDo+TqZFBqGgvWr2ca/J30dmn23Ggx9DM63vd/vD9ZAJwAwOpIDORAvdSq8bPw
         sMb9DVZOY1/lJUlO8wSJd4lKhxJ8D130Qxv8Z1lqBrKG63cXICGw/GdoSxYpSeSvYv28
         K4nIk6NsO55qQyeWvRhicqMNBD1u+nV9lj8+YYz89ewiL+9ZNDXnEafbVV4xs4ftX3ml
         OoQLNY2wy/zHDOehiTfStb1/l8UrZ+YZYT7i2ppWn3HLlBReOcaWJa/NBv5GMhBJ2aNH
         v7eX0nFTi0YmmojY7AbCeoc9WTv8x4jvo3ML3I4Fpmxw3Fga94SLzzSqkVc4i+ukn7Rx
         g78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590939; x=1784195739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=iwaFlLoUvlIG9wMhZpQ7X4U/VsJMSbDk4ZlALk25M0k4p1il9Y1OMOpnjZwoI+sxnG
         wdnBm+SzH7uaH7FCOfQKLs3QCBZKpjUVfn5BoPGaMn1N0ytC/Qf55HyRDApxRGnIUJ+5
         m8zLU/mC76ykBYVxZ94RKcynUlGp1jTsJWAla9sxiAUbPaDnH97RKrdxKOV/kcWllcz4
         0kggpQxB42Imz7Rav05WP+yOdCFtewCvZP2LDCr7z09XhCxxWA27gfyvm3YkcLFkpBW5
         zieb0I7/MlgHobkcUACIl0keO/m54I4V3x+XaC5eO7964ts0ZVT6QlxpYUfWlYZ8YnVJ
         LJ4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7iTV6R1TrvKoeKIvmVPhHDxraBQdb7d+9n+AqySN9imcimIXZ8gNJUeMLlN6NbiSaYmbp/2WFlqz2@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6sX7MkcyGjRde2gsGc+ZXMddT2ekJEks2vRqRKjgnHbW8GHk
	w+DXUXibNb/y9lnqyVOwLlohUyIfPZg9JQEHN8lvTTh5s07WOsd8CsfGb3ZasSND03U=
X-Gm-Gg: AfdE7cnj8k0wx4uLGb8nT8+IybBgXk4ySrOjzWlJGe1snhasm3bHilU+/ykL6c0kxF6
	Y555gr3X3rIe/SiZpzKohVHsQx8TQGQ3XFwVIUIMj0J8Oz6bXSzqdzOjLxtZBG3NThNZSjLaITd
	LsJ7PuHjYQlcnP5cuVNg4kquj6CpUurpP8q/nhgmTanO583C4fdoPG6cMDky00Wx1Rbx7NOZx6f
	2MznQ0LJzjlAtuNHBrvFKxTpG4R7exosHFGuTybKPx9wPtOOJAR5/noyN6PgDaJ8TcBc2l2gcwg
	RWsZ3VGGN9TdlwbPgw16uAFub8WQ+c8Zy4hGmGFF/EeoBW9sw+MlFVpkT1rWcu2B7owfixt2Jyk
	118f+3B0kR0ElF8Tl4e0NGVNhPkOej0L/TewSU0X+QWrBhzU6scIxPYAwUUx8z73iCbtM5Y48WD
	9XAM9rEUJAa9wUKCuZDqpn8w==
X-Received: by 2002:a05:600c:628e:b0:493:a5f9:d345 with SMTP id 5b1f17b1804b1-493e68c6944mr61922075e9.26.1783590939349;
        Thu, 09 Jul 2026 02:55:39 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a5d174sm148937985e9.2.2026.07.09.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:55:38 -0700 (PDT)
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
Subject: [PATCH rdma-next 01/13] RDMA/core: Pass the net namespace to the device name lookups
Date: Thu,  9 Jul 2026 11:55:20 +0200
Message-ID: <20260709095532.855647-2-jiri@resnulli.us>
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

