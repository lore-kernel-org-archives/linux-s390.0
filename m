Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AA496D36
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817452; cv=none; b=D9xv7AeLi2GqC8Bgvy0k/LwZlLpyShcVzE80rPEoIpk4dKDUvtCJxwOO3Xzaht5ZAPMATV6ftd7wGH+LGiosd23spIS2v8P/zZ6pfspWIwrfodJZqymhaY4OLyyVm47yWLScJKYORkGtHLgpmNVLG5hF6hr2mrG2f5Q23WAooMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817452; c=relaxed/simple;
	bh=Xwl4Z88MseMQ2yCgNFlns5ZfDU1ZeF7Wh1VKWF7+jzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bh4YS72wKerc7v1Ko4jExVFsEhw6+9dDAx5CEKqjTA5bJQ4nogR+eXu+i/x2CDGH5/+//dxjZSholp7rQ8JweoKYieKkYQQhQkIolWq0xkZSnVCM8alj32eSIJrgt9I0XoLjJQ1AutAarkYExSOkzeFQwSPplxrwMENQbi5tIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzquEbJG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzquEbJG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so1405209a12.1
        for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817451; x=1792422251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yt+Gz4amuSlj6pJiR3lXEaUuz2EQxFiYzktCf84QrFg=;
        b=IzquEbJGA7kMl7cG81GC+xze1CpfQ7IYfQhUvjL4KGX3IILvK+XSl+zntFW4ewf1h6
         1tGwPTPHPp8X+0MLiJN9UbKrCKpNIPVGYiMjpydrJiPeFCRmGG0Wp+ULx6xNFroKeNtz
         2YhPx/mu4d+dxPVj4p71dOrx4hrtU5B+fLUc2Ae7hpfr/n4uey4NBHDMaZY9NmP5aY0J
         5RSfFQtYkkpCGaMx5fRVdYhUCelZAghtSlf0snYlT9ihAUWmtGlsLAFXJ71xzu7hSRjv
         OdiwlEI1u20gtKPVpCK8mWi5SXmHPS4Xe5MQMjcAsu21EhxxCkVRmIvIzIgRdR2VPEk4
         6M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817451; x=1792422251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yt+Gz4amuSlj6pJiR3lXEaUuz2EQxFiYzktCf84QrFg=;
        b=GnDuCLEO4MDwfHvuouXTETse2w+jBNk65FYrhK8WV8qSmo8h/C8/WPQMMxmsu79WWl
         dJpFgJeR9t/vAuj5KhAP3tkAH2xaTKEQbP6xIj3gPNSNYv9BkRL26H+IPHSl9ZTArrUp
         s+hOUx8hnhDPYFd1+xnP89LSmrK5FPYXDYn16MOjb3k4WUzwzSt5yjfSyvF3A62LZioj
         l6bzza0rqVlNyIkY22I3L2lKbwn7U4nF1nDwQ3rhOyQC6zaOkwx8bgz3d3rkdONCMWZ3
         KBfFxcstv+lrEoA2VOHoK6vEdxMquVGB7CmWDZapNPGHmOFi6tYRncPkMuVc7wgW2PAK
         pYmw==
X-Forwarded-Encrypted: i=1; AKwUvBxddHBxxinvJasV/CBYbq0ZRsT/+/y80du282muUGsxjROGyCc7XdH/6OyC36CD95wRHuD1tEE5Fizx@vger.kernel.org
X-Gm-Message-State: AFq9FYK9PChW4ED4LpXrElFdvwbBwL+x5LsYxKUaWaG7YW3USA6SNYR7
	VoeRxPmPlf2zo/H3DH2JOZ9JLkqgoB0RnSLh1cLMikHsq+W3KyAm3OtB
X-Gm-Gg: AYBFou20rEyRR1oxu8SeLuuA0KyycakGXmcaM7MQV2/SAz9whZyP8mpe0/+4kDUohli
	VDDthEZHvYdsT+GrfCgzzQnC+qXTNIxv/jEEpJrppAM7zm0yFElwONaR3QbmxmIvIHCh3XNiCuU
	TGI/XjN6LISehJ12x4kdv79hRKHLj136yGwx7k+5KcWiPwoVNavROIp8sQIf6k23hktrOJ8BGHa
	1aw1dU6+w/Z6tPXPfcEJJtgre8/YBG0gM5jZ0Y3rCk+zyKiSS74oSt/l/MDOPuQKtt5Q9OPy2i+
	3g+Vmxw0RqtKnv3qys97d8gUgiElPQtFzv03ud9GJsAYIl93IKcuRPaxQ32Y2G2/pEtevYzo0XJ
	aMoC8l3V7VKFd2QwHDbULm+BQYUS3aVa3H+HSqta1c5NmYsKYndFpVQM1pI7pv9j0IVJKc+prqA
	/gmKRCTDeNIC11nrwqN27bgGNpiePsK+QI/oPbQOnAHVmMVIKfwMRqXMB4dLijLMGHSlI3bHOM1
	6E1aiQggHVZRKB9By5W027l
X-Received: by 2002:a17:90b:224c:b0:3a8:6045:5a19 with SMTP id 98e67ed59e1d1-3ab3a8ce938mr8135011a91.37.1791817450557;
        Mon, 12 Oct 2026 08:04:10 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca1e04sm17647388a91.1.2026.10.12.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:04:09 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390/sclp: Remove redundant memset after memblock_alloc_low
Date: Tue, 13 Oct 2026 00:04:02 +0900
Message-ID: <20261012150404.555918-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_alloc_low() returns zeroed memory, so the memset after the
allocation in sclp_early_get_core_info() is redundant.

So remove the memset.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/s390/char/sclp_early.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..821b61727d1f 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -138,7 +138,6 @@ int __init sclp_early_get_core_info(struct sclp_core_info *info)
 	if (!sccb)
 		return -ENOMEM;
 
-	memset(sccb, 0, length);
 	sccb->header.length = length;
 	sccb->header.control_mask[2] = 0x80;
 	if (sclp_early_cmd(SCLP_CMDW_READ_CPU_INFO, sccb)) {

base-commit: 9fd7fca66735307fd7afa3450882a55ef80f2add
-- 
2.43.0

