Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69B71B5C;
	Tue,  7 May 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116439; cv=none; b=WRTehTHsK0aD1JfR5HsFUywR8CBT5aBABd4giqji51wNG8ZoLa8XL6BqRluyuvA/lvbRChwhMEuvJWLczDDkIk55+6ovmqkylFAbQzmZZ09MCKLHs1AJ9eixM7CRMzL53EtGtpVaawcqLg1BWcVDEsPS50sOaFCQ2CK4vE+96TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116439; c=relaxed/simple;
	bh=tniya1MI4D0E7HadkP5SUtQrULgRW0O5FJAB2XEqmEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B1Jzlp4PV8lAVo4GT8ImYrjyCLY5v1NtY/01STC1cNK2TljH8IB3YIkXTdEDSNsa0xgjSGX0I97qfv0eVMQJuadrZsIHo6klgL1idn3p/COkLLkJDtAelYpUi6Gfm787VtRHeue53t3vzNslTSfEAwLjKQIe0u9P+of6j7rF7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQyzNymN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQyzNymN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b794510cdso29088555e9.2;
        Tue, 07 May 2024 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715116436; x=1715721236; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYFrxhuTIrqrxFkifa4GjWEZBcYt9ZP/lSNrLelrdGg=;
        b=LQyzNymNK+erV42jMaew+eG3zqUYAEMjatIONDhy2spcH0kUJHLueQqJO9f1DkZrtA
         HTK2hXaspAGTgnWjFKJbvuUtiLY/GoKWJmrQJYlHw0wehp5Y888/AX2NTgCSMRkCezTH
         n1z0RpuH8otfDd7cgJb6mNYGy14i8LxViS2Z1cQ6w+h21f+cGqODcG+U5FefGWki5uDW
         oHl+6dkkR4LhxD6F46xGGJmnpHF8z/QSJQSMzLt4xrTKudHqy6rnIVPPxh/lbTGFEcHA
         TILH9MxsZC5M+18YLUAM3Ph72e2fsiI3LqNHL9K6psmQtC2tUPZXTSRs1HyMpEp2HGpG
         /pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715116436; x=1715721236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYFrxhuTIrqrxFkifa4GjWEZBcYt9ZP/lSNrLelrdGg=;
        b=vfVRaBuQ+sqmCUyrZ3pWy/JxKEysdYAd4g6PeNBUgy3DF0uK69HY+am+0q+uy/+zJO
         PvXRP9HXusuTcu6BaT+xkZbrM1WgauK2nKwxCxecdJHyE3YgTJucDzmvRG1GZiuNKeqq
         BE0kRNa2TKJae/7gAgM1tv553DVimlO7SpRN9aKtWEhuLX5+DZku/1C5LJwps0/2SM1B
         /PsSAoQ72DK++j5Mh+1AQ7TMhF9+t9dLk+e2JGx5U+IRIX2dfoz5PONP8LWqK4SNrAqZ
         2BOiiUlnTlEjfdk7aOrdKBgSRrax17zGGvPIm/KeUYA+QfvXqaS9X6wA4sdv8qs42fEk
         ftZg==
X-Forwarded-Encrypted: i=1; AJvYcCUn1KhRbjD7reLYcKJ6xm13IESPZxw58lkQUZOOP7M/JnQHs3PtxWrrJDYGN3tILcUmsQpa2U/l+F/OMShyT87i/x2KW7HNN/Ju9slJR6MQRd0m8PgmNxT1b5wfKIxikKrkzoSgXeEmYg==
X-Gm-Message-State: AOJu0Yy79IYaw6kjOPwhLGvY3PBJgDtV77b+7hxHDgVCO1T2W17yeD2v
	gcLt5pRG5XuIlOoNlNGp97BybDEA6lp5R/BEdO0fjSTuIvWb1ocjPtuX/Vc=
X-Google-Smtp-Source: AGHT+IFpKnD/taxvc+XbCDl5lYkaNLsC7exRQb2rbI+vmpaMlrcwCBRNi8IWItD49ePwGNPWIpRnuA==
X-Received: by 2002:a05:600c:3d99:b0:41c:258:9b70 with SMTP id 5b1f17b1804b1-41f719d62d3mr6907085e9.28.1715116435248;
        Tue, 07 May 2024 14:13:55 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0041563096e15sm24808106wms.5.2024.05.07.14.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 14:13:54 -0700 (PDT)
Date: Tue, 7 May 2024 22:13:52 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: dengler@linux.ibm.com, svens@linux.ibm.com
Cc: borntraeger@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
	freude@linux.ibm.com, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] s390/pkey: use kfree_sensitive() to fix Coccinelle
 warnings
Message-ID: <ZjqZkNi_JUJu73Rg@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace memzero_explicit() and kfree() with kfree_sentive() to fix
warnings reported by Coccinelle

WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1506)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1643)
WARNING opportunity for kfree_sensitive/kvfree_sensitive (line 1770)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Changes in v3:
 - use kfree_sensitive() instead of kvfree_sensitive as a correction 

 drivers/s390/crypto/pkey_api.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index dccf664a3d95..933894065623 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1503,8 +1503,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		rc = pkey_keyblob2pkey(kkey, ktp.keylen, ktp.protkey.protkey,
 				       &ktp.protkey.len, &ktp.protkey.type);
 		pr_debug("%s pkey_keyblob2pkey()=%d\n", __func__, rc);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1640,8 +1639,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					&ktp.protkey.type);
 		pr_debug("%s pkey_keyblob2pkey2()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc)
 			break;
 		if (copy_to_user(utp, &ktp, sizeof(ktp)))
@@ -1767,8 +1765,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 					protkey, &protkeylen, &ktp.pkeytype);
 		pr_debug("%s pkey_keyblob2pkey3()=%d\n", __func__, rc);
 		kfree(apqns);
-		memzero_explicit(kkey, ktp.keylen);
-		kfree(kkey);
+		kfree_sensitive(kkey);
 		if (rc) {
 			kfree(protkey);
 			break;
-- 
2.43.2

