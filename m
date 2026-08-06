Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6B481256
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031896; cv=none; b=IN2uYEnQhbhiDbax3KefadcvqUBF8mH67IiR+en34fMUXTCO24bOdQnlm7Lht/I3NoFX2d5jqC7uSi68gDJvprCMO52k4mbtQJYeH5NqiPTLGXZq/BwQnpWvlBZ7ZOI20DF6D5PMnKxa9glKYcPSePS4foy+w7DSm9ExP6IJkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031896; c=relaxed/simple;
	bh=FH/WqUfsQ3elAWl2T+YpQuugYmFF4n4zAIj/V4ZWYeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nfZizpYc1ncX8hdn4RbyYhzk7ZcfnGSiUiOCAOvdDD/5EI2pjl3dEuhGQNVpK5OHu6RWsztXmtltpu4QEJTDzm4un9irLSh8+f7hZdrov5EwJiHVMyh0IFD+B/n92/gjuHDr+ZP32NbAUJVXbwCdH7s+gRKrcinl47fNidpO0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=c+4kPqGH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="c+4kPqGH"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49954b88fffso8435905e9.0
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786031886; x=1786636686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcxcP20mYl/V9kym9eotg4juRJdYfnm4DRR+SpbAsvI=;
        b=c+4kPqGHhWt5260TyorRQs8pMoBwZlSJCe3wQjFJg2PiPSdrumPc5//GaI/f9uBV1Y
         g1lDC+fsQEI9ivnImdCLdy2swhLRxNQ7Xj8sV2sghjzVSFrLOAty7mhHyA54vtsb0vMm
         sEXatg46ze2QNcsP6GvRaKpf6xTSVmUAzZt6h/fBI6AI8fOvWz8bsWKBjNSrhfw1+e2u
         4OdSqZxkwKAde+QlzJHu3B479kesZqKWtYRtGLXh3k3QE7eLupLCqtL2B9avpiW60E5L
         KhQLknrp9kqmTnwTFPYZjsVM4Sd1MNbkySh5uVJIvPIjyjZNAkcEa8bG7znO8G5xlNEC
         pAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031886; x=1786636686;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KcxcP20mYl/V9kym9eotg4juRJdYfnm4DRR+SpbAsvI=;
        b=szKtxnXmCkpczq2HNX/Isw7F6pyNTeD79rwQTh9eTtE9ukoSTtLsLBVoxMTBlvFY0O
         PeoR211lurkspQpa4w7yHp4E6rcLztcxMGpPnAAXNI+LxkfCdzv4n7UnkK9173D1ZJnc
         xagOzX81cpkvN9q5UI0lnGCeSEmRG4+uZfich40RNHJ73XK7ZVxcxmnPpEj45ryQtFec
         Ut/0YCbYsUtm/ubytb7G5dD4dK81Fdzuz0kp626MxvZYBIzfS4BPrqC0MGhbccZYD/sx
         s7y+z3EkH/tK7a4OVsfSg/f3V1H6L0SoOQbPlBDx1hnv/bYDohTgEoIUzD2gGkHctoxo
         khtw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7L1QNd+TGBEm+2eEzHl+BwJ2yk92E0bk2rl/Qi7e2rG8+uqAsQJg3W/oyiUyUILjUk/05PaDV1ZRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eyZDpKFoYB0NB6eMuv28Yg9IeoAiiJXWMQHNpwbfQ+8u8gFP
	WP/NIEiExatWGYZmyBTlESb/825zHIlQlAYLSwnkjy2+HDmmHoCVBVcqSVll4cvAmmA=
X-Gm-Gg: AR+sD11/o9pmA+B8wO3WbufmNzyYwCnbJ2BFn3Jbd9udnq4HF2xKqCgSJH2uugI0RTT
	tYxw6UA9fN9u5JjEbdhwsn37yuGh4fxuJfKn4pyq2i7Q9QodpoLYpF33ZvFsTRgKvE4O/UgKFgT
	nLkrumEtFsXQDpjIJZDAdWSxSVM371FHNgx3Mq8+madyUCQdOmFTWq3kEGOhYosiLEmiRc5NWWm
	FeqhsW6yOOLf8WRbV1r9k4CZ069QCD7B3vFE/P3Thm7OSElbKIhlNRNO2rnE41hG1Wdb4KLRFTr
	64SUBcM60K+S9kcjNKcM4AjS7ceb/YW6yENf6NfNXUuftmIYtGdrdCVzM3BXU6tKwXgqQuqy8Xn
	kuhL0zk29pF8tVIMfqiNKaBnHD07nlKTa04UPw3eTw1Ls8EuReAY5UuviGngqfBCr1068C6PzjH
	c6WaDcQRx4Hk3He+q9OYa7eXBN9sxuh/bhgRo2glYR+buDWqPjqLW1upHrS2s3LKoFPspadgafa
	NnqBHATh6C6ysm1PP4XCyh54e4PjGQA9qGa22dBOtQ70Lsw8QhW
X-Received: by 2002:a05:600c:474a:b0:495:7888:281c with SMTP id 5b1f17b1804b1-4994e6d4a13mr184701035e9.0.1786031885691;
        Thu, 06 Aug 2026 08:58:05 -0700 (PDT)
Received: from localhost (p200300f65f0171047dc1d03432df4abc.dip0.t-ipconnect.de. [2003:f6:5f01:7104:7dc1:d034:32df:4abc])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499542851d6sm82258535e9.12.2026.08.06.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:58:05 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1] s390/ap: Drop unused member from ap_device_id
Date: Thu,  6 Aug 2026 17:57:57 +0200
Message-ID: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=FH/WqUfsQ3elAWl2T+YpQuugYmFF4n4zAIj/V4ZWYeA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqdK8Fjdmk3H09tF8ml8/ZkpTN4KzktS+PcHmgV CEV/w+JgZ+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanSvBQAKCRCPgPtYfRL+ ToJOCACrAfHMTxdER1d/L8sAl8ihwYXXI4e8eIoHRRP4MzTd0letlgeeicrh7QqC9kSPnl+Kymy 366IgrRWG/2xHBT1P/FNYy6OIin7KToWfsbtlx8TH+Foh9uFEyB63c1kYCUQTZTKMGi0F6brNEs 8f4ZrqZv4gIZPKaWuiASFRkNdj5R1MYwR6anvFpE2+nxHYz6WPW7qbEGt21lfKOl+qMIG3tenm1 Gh958OXdzfSGnp7lDVbcaZ+NO9zMhYPPrUnEhMwRFhLVNifJd9r36z7vtAg+WPvak9RX8sII14M 5ZhaJjVdzOKGnfTltj9vxw4JeKYOH1lcY23lU9v7ds0mRJJi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

ap_device_id::device_info is not used in the kernel. The structure is
also not part of API/ABI, so the unused member can just be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 include/linux/device-id/ap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/device-id/ap.h b/include/linux/device-id/ap.h
index 0992333a34db..011af33c0bcf 100644
--- a/include/linux/device-id/ap.h
+++ b/include/linux/device-id/ap.h
@@ -14,7 +14,6 @@ typedef unsigned long kernel_ulong_t;
 struct ap_device_id {
 	__u16 match_flags;	/* which fields to match against */
 	__u8 dev_type;		/* device type */
-	kernel_ulong_t driver_info;
 };
 
 #endif /* ifndef LINUX_DEVICE_ID_AP_H */

base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
-- 
2.55.0.11.g153666a7d9bb

