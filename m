Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B571B85DD;
	Wed, 25 Sep 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260272; cv=none; b=nGkKAAFOnnfd1ZNjma70vkacOpBzqxeiaQZu7CsSI9xdCWjbR2LGKK2948psbzUZZV00hZUi0XwUFls54vLr0FoKWhCEFgKIKVnzuFRMZ88IokJwFoBsghon4Ag/liOd8euILUfcm4w5/aX2ANamRpb0RNpWHoP7OdFIDFhOTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260272; c=relaxed/simple;
	bh=U3d8CQGBMI1O7OwcSx9hM90yjPjYTMTT20J+qkVUGL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=maxNgv/+efa8wKbNrr5vSIesYZltHRJTknIE3hivwLG3yAuHxaHfg/xdfZhb39W+SdUJ0K4hCKCwkWYqlS8TKThiL9kzAj97SuiLG4lCngD7EMB5HfPKrZchNYQ5rDRMwX0hsoQJG9TKsSF7myZ6SfAqOItp6uejnCRPy8uqX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROHS9N+2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROHS9N+2"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b0d1c74bbso386894b3a.0;
        Wed, 25 Sep 2024 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727260269; x=1727865069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYqXw8OYGu5L02xVnohsi0XdJVLMEJm6JxGQGWoUZ5c=;
        b=ROHS9N+2D0LaIg7mWWomSF33k47ymB63om4EYQHHXC7bcvzPOf+GgL7AazELQnJbzZ
         nAJlvDdkJA6lU0Zft88Kd0vSIsTJ+gzj+PdQHyimukf+WTrwgYKJxAUUAGNCOSV3MnAq
         88UB0A4qkCByt6EO5AvmOTZ/mt+YBhVkvC15f3spn7wu4a4eCWqmQoylsvKmsVfMYwL+
         Od3z1uEirqL5vD2V7FnxKZqaUPT3lNG2n7a8pCjKZE7YwOhN0lPFFJtjPdOmv65Lbfe2
         tJDEeKsZGsfLxI77fHcyyHMw5O6i+TIvoKgtg85gYfrXlvDdQWPhCnc4GMu8zldg7che
         i3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727260269; x=1727865069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYqXw8OYGu5L02xVnohsi0XdJVLMEJm6JxGQGWoUZ5c=;
        b=ddsY2GkdfUvZz+qTTo/Bf6F4kQvSa8dAwwprSMv8KBlucIEi0qg6Z88shtUhL+nD9I
         kYhfT0FOTHccfaGuk/6BhlsX7AhyntytNcn89I1ulzJj4M8E0gv1O6dG6KonNiGIwEan
         ZrI+W9TvQw2x+g/sBopIOW3KoSro/qRPcdUql5j/6+7bzj1Dc857OZt6btZr2T4ptaFk
         ghICArCqe2LEnJi8PsnGZ9yOB69Xbb5oyGK0PPIkxRBL1uU1CSG7jmAUq7x9FcFBpb/7
         S18Z5zsak4UgGvenghUTBRqTluqeUoEnf+0T6KeM/Ye2cM9pDhWAr5bBDUWvKokIxRk6
         huPA==
X-Forwarded-Encrypted: i=1; AJvYcCVthqYynoOl5vEkCmCBHpXt+WZ+HpiF0OB/q8UnTdXIa5GXtFwCGUC9cEqzWMYbBjxthLPt68nJx3rYKk0=@vger.kernel.org, AJvYcCXrkTHH4epjFtbvcrUlfuz3T917DHnIYhbB6ZNkVNEcdaIKfkOhIT2PkgkByoYg24ohY6gpEzfnZIBCMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY30qOYGmXkEWXIe+Md7tYHgTx4ObvJsyB+KdjMXPX7Vfpfsf0
	5Nu4Z5FF6XjtAf0ep/io4NwgodrF+BqqE71bB338byVd59hg/Vrr
X-Google-Smtp-Source: AGHT+IHZLg+8BIA0RKDfbRVJeLkGNnhk2Y0HT7AdGNf+UDqE6ObVxRC0COMdJBYRyST1GeKjjl6aLg==
X-Received: by 2002:a05:6a00:138a:b0:70d:2a4d:2eeb with SMTP id d2e1a72fcca58-71b0aaa22c5mr2956953b3a.3.1727260269152;
        Wed, 25 Sep 2024 03:31:09 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc92c9f6sm2514989b3a.135.2024.09.25.03.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:31:08 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] s390/zcrypt: use kzalloc instead of kmalloc/memset
Date: Wed, 25 Sep 2024 16:00:36 +0530
Message-Id: <20240925103036.1062542-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses below issue,
WARNING: kzalloc should be used for cprb, instead of kmalloc/memset

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/s390/crypto/zcrypt_ep11misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 004ce022fc78..3c3d403abe92 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -195,11 +195,10 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
 	size_t len = sizeof(struct ep11_cprb) + payload_len;
 	struct ep11_cprb *cprb;
 
-	cprb = kmalloc(len, GFP_KERNEL);
+	cprb = kzalloc(len, GFP_KERNEL);
 	if (!cprb)
 		return NULL;
 
-	memset(cprb, 0, len);
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
 	memcpy(cprb->func_id, "T4", 2);
-- 
2.34.1

