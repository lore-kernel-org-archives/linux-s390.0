Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF039B96A
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033298; cv=none; b=Dfbbo9hAvuLdxxCoZi6LaWZ/L2har2Smb7Z0qzdy53K7vAelSb4Q8gjmcBmLcKCv4KP+oOs7XEIgy1lkas4hhKj6DMAEoirRtikKT9sghEGORh1lWpnw/fULHTz0/dA01lbutAWfOcnJ9G06yXMkrTYOeR8RiCj9uPn+EkOn3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033298; c=relaxed/simple;
	bh=gW7svUO+VeTFDBz8VKhZWugBbYes8hYkjN/rc5f9U1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwsIhlKQtLMg3/mlMzsBbaYg0mwrMIectZxBazhkokXP0glf6JbDFGJ7rVmDjgbDc7Zz3XZfTtxaj1gALDzsewtF9uiEGN9mxaH+Tn1MGUHUExFX0KXtSnOyBAgtmJtSw4BHKaMTPI01/dqPFY6gUuaISov4v32xLIBsEo+VCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EpHVbu3F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EpHVbu3F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so27851905e9.2
        for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786033294; x=1786638094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h1/pC57LR+u2NidciiZRGacJgL2CoK0vqRunsH8xnzw=;
        b=EpHVbu3FES5b21ayp3YBZc59L/NgqORy1UFI+gdXSKty/bvD/fHQOucqJ48nPGP4O2
         rnsa0YQ0XjmakuABzRFqvkWQ+T/RaYxHyNs5qlr25ExBj3VDBD8X9ww/kbZSiaC5VQWl
         2sqshrzgVKEXxZFDyzov/B6vhJTYRPBglQEQ4ww78f1WZ4/Q86LQLvo8SmTqKvvt6ufn
         4pkZlRlxgmiYKnK2OXZRRcT6nXTJs+oYzzD8XSscj5BeZvqi+2WD25l/pTCY01cEFHas
         cI0G3foVdulG80g/vPSy5Cy07vMxLUXaK4Wh9TcCW4HDkySnTrJ4xQ2zw0taVbtoGgsr
         Qq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786033294; x=1786638094;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h1/pC57LR+u2NidciiZRGacJgL2CoK0vqRunsH8xnzw=;
        b=SFAnH2ftndwjCNU80gPKeuxxn9yGhSLwYQEcHuQ9jkOUQcXUxXkKIjA4yOSYtUWISD
         RUr+DBQNj2NugG+9osPsxGLWxCMJ7grgeOcjT8gyoCThmBUZol9es6XJx+nmfIecjhSj
         pkuHkHBN/M08eEixIXPWKMTDDt57++0oMczniVUnvaKjBT0dozvrMxTH1Dlnz/uWo1Xp
         FJAeGB9uWfbL+ZosXXS62b3+9eO2XUS1mpgldeGUrYdu59/ci3iE1gS17UsZfHgV0MtL
         CRRpC0WKh112BBL02I14CbJr07gF0OY4w0XzRpwGfqj+hxZglcRSWEfLpDk5aULY+tBr
         xO1w==
X-Forwarded-Encrypted: i=1; AHgh+Roqyzi/AoRzcWZaDxrHQlkUbz1IDVNJozZVyY2hxWkcFn4J1xKp59dBcRSFS6pWoFD+Wjuvs4uK7/jn@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWr/w0HplpvoeACZK64bL6UBxAUkM4/zygQgjgSFy0KGeU2Kg
	Ozu4abhALNoBXY9OXlOJwMgP1MAKy+Jn8sSj9Vav6Sv/1HqW7qEzunqNLsb/7Jc8yE0=
X-Gm-Gg: AR+sD13Q6j7V3+WMsb9I8Ui6SmivDDaj1kbbRcs7LCn8zX74i2oK9iAXF1f5uWNcTwE
	bS4lPo78bWNa4aX8MnANxdDQ8wjEg3vsjC7XDLkhpFAwQmefZqzQOUVJkXj+X7GLgChphkPr1Q3
	OflNp1RSg3hXgm4GmMmQ/7SPd3i3H0XyCwjxS5lukqSzhZOsaVKO2t3jv9p+fsosACnzJLQIZ4y
	Eaal7TmvfTTF/91g0qkXjBEikdtm/jYCfupr0u2P1dsw4+P0+HRYzSd3xm+xrFQCDEGzIqEyv9k
	95ivl3vrjnE7F6/kZd1M48UhIunDqCtBFhcW4z27PsXhvMljxbuT/ACFB0WjHn11gvE1F2l23xg
	c2TShlNf9sfjJMc83U6MVheAnel8eEB36tRr+5dW58ixlIQ2MuJRZGQwCoNnR4weXEiAh5A4Qwu
	7h0XixC9BY12eJaOVTDtA2/z7vxQxQ/+SLHWyQQMRUNETWWUEbwtsuqBF/ARnYQeBmkKwd58dI7
	YczRsdnlG4bF8RR2V/nuxQ68gBV5tMjlx8BZlFq0FqxipywBwQb
X-Received: by 2002:a05:600c:6052:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-4994e70ae8dmr184868025e9.4.1786033293688;
        Thu, 06 Aug 2026 09:21:33 -0700 (PDT)
Received: from localhost (p200300f65f0171047dc1d03432df4abc.dip0.t-ipconnect.de. [2003:f6:5f01:7104:7dc1:d034:32df:4abc])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4995420bd1csm75263925e9.3.2026.08.06.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:21:32 -0700 (PDT)
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
Subject: [PATCH v2] s390/ap: Drop unused member from ap_device_id
Date: Thu,  6 Aug 2026 18:21:19 +0200
Message-ID: <55aa5d3b5b1794b5fca7f3ae75b48dcefa09e808.1786033091.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gW7svUO+VeTFDBz8VKhZWugBbYes8hYkjN/rc5f9U1Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqdLSEMvZOAYvX0sX2yjM2hatuyAHibRgfpT0qy EHEY5SgRB+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanS0hAAKCRCPgPtYfRL+ TkCgCACoWvq1O6Iulq40xY8jd1jZIgFzKEJwT7xntFT9+Ehot3SZZVX2KqheTrS1Te10PynrieQ pKqi0XnQD5H7Vyi5RBnd12AaUhZFAxPdrlnpy73FoNybKLfheAvAbmhqJSRDxhH1DFYaN7y5bsy +BISty6Xst6qFZ9Va206LrfmCZwxIVRvvk402+c/5lWOxhgcLpkaifTxFuNbzluOuwTphICoF+U bYOCLFuOcJW2qZph3EqzU5qAnqsxQ23z+21im+IMfgydIvSUQnzg+Jq3WKvioD5Dvnotu/lvt6g qh7eTqih/pY7PKPL20ZHKSfnbM3EoaEKIut0lBRtmqbXXKof
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

ap_device_id::driver_info is not used in the kernel. The structure is
also not part of API/ABI, so the unused member can just be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

Sashiko was quick to identify two issues in my patch. Before someone
gets around to review v1 by hand, here is a v2 addressing Sashiko's
concerns:

 - remove the typedef for kernel_ulong_t
 - s/device_info/driver_info/ in the commit log

Thanks
Uwe

 include/linux/device-id/ap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/device-id/ap.h b/include/linux/device-id/ap.h
index 0992333a34db..e050abebbf3d 100644
--- a/include/linux/device-id/ap.h
+++ b/include/linux/device-id/ap.h
@@ -4,7 +4,6 @@
 
 #ifdef __KERNEL__
 #include <linux/types.h>
-typedef unsigned long kernel_ulong_t;
 #endif
 
 #define AP_DEVICE_ID_MATCH_CARD_TYPE		0x01
@@ -14,7 +13,6 @@ typedef unsigned long kernel_ulong_t;
 struct ap_device_id {
 	__u16 match_flags;	/* which fields to match against */
 	__u8 dev_type;		/* device type */
-	kernel_ulong_t driver_info;
 };
 
 #endif /* ifndef LINUX_DEVICE_ID_AP_H */

base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
-- 
2.55.0.11.g153666a7d9bb

