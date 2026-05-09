Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D02BE7D1
	for <linux-s390@vger.kernel.org>; Sat,  9 May 2026 11:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324476; cv=pass; b=t0zS1br+Fd1sFbnnd3mAYq0AbSfIVtf+ENVGLdRVwuPUAsDl8rUyaYG9bJNxKvjI4NoLjZnWgduChBLnQ1WjdnMkbt8HrO2DSYMb4GMTX7RQlpVl3DafAtWUBkz/dCSWD47eJjkVTQ6OmzOhFsWs80miV9ig+F1smfWjOWzp1yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324476; c=relaxed/simple;
	bh=9zJ/Jp0AIo86B4ZPDMd67viV7ao0qHIhk0miTEb1P1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E+Y2mOc1/iyPtGUEmg0uXBZaev63SbADaAXMY4lcAbJTjyVK5xwuim3U5pVtpbb/DVxOQMAX1YpncCH/gtsgcehtSQ6HnX8PZJYrV3Y4oYZAnbLYPKoarWR7WLDe46vaZR/Bq6OSSB+lyEiBK3sKYnAs9DXhw7SvoK7xBw5VxEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAeTUw7R; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAeTUw7R"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7c0dea734bcso4480507b3.2
        for <linux-s390@vger.kernel.org>; Sat, 09 May 2026 04:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778324474; cv=none;
        d=google.com; s=arc-20240605;
        b=gdB9k9O3aR/Qgl+2794kc8bLDrZsVkZk6ycVTgh53nV1RM+ULq23P3QgO/VhW8MNuj
         JJdAuc5aimZ8J5bqezanTpGu1o+TTGDQ1E/48+2SwPQ9AlVsOKCm8N9fwLuDi5Le1bIj
         Nfih4fQC05bYJismusXMAqakaGzYjPkakTTAIaqdMd4e0lDmpikYeIQSFz+No7BL8adu
         EoMyyxoAGqjp0Kf5MZPPO14bLntTnazKp5fwu5+guDkXQn2zWmL5gooMoetIYwYhXynp
         W9SS+IMzdMv9Ii4E7vN9RzN4buZmu9GuOLPrrwOt5GFVvA2CH76akL264e3Jgz4hzpJH
         i6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        fh=Jg47OGvUvmW571S5/qDj/2vZfvhRAt0KonxNQq2YSBU=;
        b=CgeCGgbxc/vZzrKHsomJ+bI2lv2/f0UrrVVB2NhyX+VkMm4bKB45tEwC7j3Z+1zpC7
         qthc2aAoObKeemVKvW7RIlSepkgp8oaFPu6F0WmBkyKJYCl+I9QJL9VZcJDNpD2QR+ps
         VHpSMSrYJr2L1VQyShxmwEPsFJpY7cxULBAx8VtHXzeCXarb+EzdxRu3t7/jdFpRNqHV
         CJOjQ5tTaGbg/LYaScJNIXQBjtk84SO1buBlU0mN0EBauF8AMJ60kWAd9ljJ/BN7ucAR
         DnVTrmmtVb+ve5Dc0sQ6kQ80H4mjMQmzw3RdXkQDv2nAK1pOpHfjtu4HwehJh4TWuakh
         0w9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778324474; x=1778929274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=YAeTUw7RdhE+KGH22BJXrVVDLE+iBu3X6MApbDMeMbMfUJF02/AgJ34216Ad9y03mg
         3u5h8QCUUPB7Jd9/v2hcH+R/gGBrPzSSkCXXt1n97Z5q4+tHorLGWCAJvEG9NxCdO8we
         uvI3POV4DDGpHkNM1Fk+LiAiIh5GTc78XpiD0h2Gux1jHC/oIxf0Y8hsRR76aNLKgNfU
         YSRTIhyRfg/jeROS7kWvfn7kXVHfmbs5yY2POhy/Qd/QW7gq+daGRS2OsMRcJmey8hJE
         AEImZxhq5gLKFoId6lAQw3XfTJ7M9iMELP1gg7dSPKiRIbzeRQOngIUyxQ/ewtV/PJUv
         Ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778324474; x=1778929274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIt0P0A7yVCeb9NAEa3+HLFnhyLLlsPvHqZAy7iz+x8=;
        b=W2LnYioAA9IcloK0Gh4CTpN/xRg3eIV1F9gTuNIRf2jlMZBsk5cS2rLngX4mo42kMN
         pKJypNpD4doPPJC/03TKSyTUN7RNKuKGj9nmaUFz30s6I6dJkbWnI6EZfTXVk/slMobo
         2yrWP4PUqzveReiXiuQfkXjbOKeeECe2v78kp3XhdKc3uPGdnAV9rWzBF47obT7Yv1zl
         vsSZBuGN8sw6Aqu9mExREK8/VZ89vskthTrEMV/m9a+26QGeOD4bUD+XhSKCdY2uRWN3
         n/eUfABXTZEgrYWOCax1Hf1IygwT8IurSfZ4vgIw9uidRBUeGVLEeAShAmcdITlWDz9X
         4xJA==
X-Forwarded-Encrypted: i=1; AFNElJ/OFXgmwDBycuctDwimSu9/N1TgDFmY75rJvp1CTTJnGcfOIS9KLxMSZuUlxOvhGbyeJRHjXfeXh8M/@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMp5bsFaa7IZYDOT7C5K0bFKg/eGm/xIatBRdTOIhhVips9Fi
	zNnpcwxd5BJdYfWw/Eawg2UKlOPb+p6FavHaVqAZ8r72ZKiccQZvJ+IExpsNsIAnKGyV7fWuscZ
	rFvp19lmLK2cr+yVIb43qfIMCbpoS/CM=
X-Gm-Gg: Acq92OGS7Oc76MgGd8rtTYE6LWhjDn9ZJiMHwaE8XtPgRRwDes3z8gNq+9zN8ihSUgP
	6MVYKfvbR8D2s0Q9+wYXGsa5bgezAdnfIT9JRvfqGwbUo3YQ4zgIg7o+8B9AqqHXtCUpXsV5KsZ
	rrfaf+G+bf1gAVAYBAfBq/07Y0k0FFFMdvcxTLOItxM/QLGaGhuesHiiuvdNrRQPIwBiYfjtURh
	JXaJyEbZUVHElbVU67PczJWlYiLyMWgu3U7kKrIIcqm9FhjcgKcZUQCNk0ynaTBcJXD8Mx2Nvfb
	t+a3QqA=
X-Received: by 2002:a05:690c:e3ed:b0:7bd:6a98:58e4 with SMTP id
 00721157ae682-7c104bb091emr20425757b3.27.1778324474394; Sat, 09 May 2026
 04:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Sat, 9 May 2026 07:01:02 -0400
X-Gm-Features: AVHnY4JmYlXDKdj4Xp-aA7FtSfefy9b28FYyhJ4KqsK6_4gIiVDKucQbACylHK8
Message-ID: <CALSA8UZaE8FR2K-60fPYE6uSUvUNuLnH=8pPq0Hak2ADQpp1Qw@mail.gmail.com>
Subject: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mjambigi@linux.ibm.com, 
	=?UTF-8?Q?Nicol=C3=B2_Coccia?= <nicolo.coccia@leonardo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by
socket options")
Signed-off-by: Nicol=C3=B2 Coccia <n.coccia96@gmail.com>
---
v1 -> v2:
 - Rebased against netdev/net tree
 - Added Fixes tag

 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket
*sock, int level, int optname,

     smc =3D smc_sk(sk);

+    /* pre-fetch user data outside the lock */
+    if (optname =3D=3D SMC_LIMIT_HS) {
+        if (optlen < sizeof(int))
+            return -EINVAL;
+        if (copy_from_sockptr(&val, optval, sizeof(int)))
+            return -EFAULT;
+    }
+
     lock_sock(sk);
     switch (optname) {
     case SMC_LIMIT_HS:
-        if (optlen < sizeof(int)) {
-            rc =3D -EINVAL;
-            break;
-        }
-        if (copy_from_sockptr(&val, optval, sizeof(int))) {
-            rc =3D -EFAULT;
-            break;
-        }
-
         smc->limit_smc_hs =3D !!val;
         rc =3D 0;
         break;
--=20
2.51.0
