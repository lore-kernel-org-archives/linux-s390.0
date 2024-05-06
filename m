Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D215746D;
	Mon,  6 May 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016093; cv=none; b=L4n10Q2gtGBf2gjRW+/TSNQAy4nscs4jn6eaKaHoVZ21n8tVjGnLQcleoy2xBxmRwfaHH2f9zmWTkczZ7l+VkSq6Uqt0Fy39LtVIaphrRSd4WC7eWikw4x67bS72Mw58jvs+v8aGbhQeQ2Kqa4/tscBPmy18JNZZM9IpkbJCUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016093; c=relaxed/simple;
	bh=kZzzye/o4Y1DGZlbwAGGiYTrIUJXceDBAPJyGPxpAlg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rbbL4f0WIHg755IEZpAK5e/4jZlU4e8NBoPDEFf5JhEDm6fab9ehUJaG3inODKaZRsQFBpK3xmYrSaLeJe9krPjMCgFPpmhzVIJhbCUzBp+K68y30IX8NOMjjQhOa5rzDzWDqS6x1lde9NbaIn35arPBUhI0V9hKsUMT5wVzphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZJj8tUp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZJj8tUp"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572ba002a6bso88586a12.1;
        Mon, 06 May 2024 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715016089; x=1715620889; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MjXGGQfFYjUv2MCmlhbRoRlxsaHrJHMOHHQciYlmeo=;
        b=KZJj8tUpvKn7M1cWdhRboJ8HjHaTID9pqo4QIlLLypf/nKf9wy4AFD5QeDA/bQ0tx2
         tXebdFLIx8KumAoIYYK6JT1OlVXLozz4HCuFs2/usI8agZe+YNJbuMDhi2V4BhfDxj9I
         R5v5TfF5I0JdXWQAYuKub+pLcM0OzLTtS2X38KKpqroyVgHd4l9RDLgBzUxWvbZVznff
         PMjFYuohdsUefVvufDyOc+eWlyXy6i2cChmSY9azZxtP81nUbIDsN3FNsdBfHhKui0yC
         BeLamB24GLY/1qrCb+4Vja5XS1Hbt0z4kK4Bk/Y/2L7qzrJvURg1bldWLezgVhfgbhTI
         /+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016089; x=1715620889;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MjXGGQfFYjUv2MCmlhbRoRlxsaHrJHMOHHQciYlmeo=;
        b=CRoontkWiYVGFU7CegAvMnCvTXeloqSc5WEWCory6amLtfnjjCF6lUt8dlYtRbBSC0
         oELLGNSQBiwQrPwyzzDkPymyaiAj9el14/NkPPM+j/jV9gQJKFlWqe9n05LCzyxAd/94
         SsFeCGfX/s1lscWZPjXg1f6Yw58A0AHAaMbP5m5xjZ7evodJPS1g5n7hO+1C87YlwbHu
         RFRQMf0+n5RB9Oz86IDwqj5Yqv/9mNUrT/sLgUt9pY9MXufFPS9Pf6v2oGo+5Albis+d
         tZhCQk9rtUHg3lbTzBeaLCmuj6f9fux4DtcC+rcYjXTrHffq+gZo5llkmGOuELs/te5f
         uTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5SXtOl/Xj2+KKX9eOTcFiMiFTjmq7xvqnxc8v4AIm/ILU+O0HRoIZc64D8moktRH1iYtRfX72nY5Kq0MMvKPNgCBShpcQRymeYMY762UDkhXXh6i7aO6xj61Q4cs/I2+sXo+8CKQhCA==
X-Gm-Message-State: AOJu0YwM1CrGRe2x/Gt5dl0azyi/3MJOhNl38/OLkWp3j8JDas9hto1G
	30eACSqY5UrsWVUhhZJJpFuSWxqlr4bcbPYncByUoPm2Iz1WANks0/IN9C0=
X-Google-Smtp-Source: AGHT+IH+K2uUyJTnRd1CbOUqaMorpGnkj3Q1rFV6+NMyULJjL2nlKhASp9DcYZ6pxQYd+Hm4PXA98Q==
X-Received: by 2002:a50:cc9e:0:b0:56b:fd17:3522 with SMTP id q30-20020a50cc9e000000b0056bfd173522mr7076979edi.14.1715016089177;
        Mon, 06 May 2024 10:21:29 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7ce19000000b00572a7127cb0sm5417947edv.50.2024.05.06.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:21:28 -0700 (PDT)
Date: Mon, 6 May 2024 18:21:26 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: svens@linux.ibm.com
Cc: borntraeger@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	hca@linux.ibm.com, freude@linux.ibm.com, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2]  s390/pkey: use kvfree_sensitive() to fix Coccinelle
 warning
Message-ID: <ZjkRlmoCtpsR-bBC@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace memzero_expliocit() and kfree() with kvfree_sensitive() to fix
warnings reported by Coccinelle

WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Changes in v2:
 - merges all patches that fixe same problem into one

 drivers/s390/crypto/pkey_api.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dccf664a3d95..e1dd7e0bdfd4 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1503,8 +1503,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, ktp.protkey.protkey,
 				       &ktp.protkey.len, &ktp.protkey.type);
 		pr_debug("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kvfree_sensitive(kkey, ktp.keylen);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1640,8 +1639,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					&ktp.protkey.type);
 		pr_debug("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kvfree_sensitive(kkey, ktp.keylen);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1767,8 +1765,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen, &ktp.pkeytype);
 		pr_debug("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kvfree_sensitive(kkey, ktp.keylen);
 		if (rc) {
 			kfree(protkey);
 			break;
-- 
2.43.2

