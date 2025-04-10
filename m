Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD19281523;
	Thu, 10 Apr 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284834; cv=none; b=kZgsJaKnBxfmQNGjiygMNiSkru3yAJl/yIOJu3PxAY1YLR3y3jF7a04UjEMaiMm8D/6PCw2CK2N3xC/Mrs/qQM488SbqiJ9msMVguq9lfhvK7nqjFOSpdLhWFRdW7dUyCVm9XdPva4441RB4ZCRzSwAKCE8S9at8eMYFf/r7QHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284834; c=relaxed/simple;
	bh=xwKbTBbKepb2MvuC5gD9+CWJTF8oxw5ci/TNlKFNajU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqfzWSQeCxyaPdKrP1FUJ1461OoazgBZt8edAjUYgDDul/PzhI657I3Mey2c61DohKgPyvtx3cDzxXqpHj8YBiAjkjE615+dKjnIOzp2tQpej1Chlm8smDocjUdyKg+IceAkYoN/l+5F+YMlhhPyDVCly5VlpLERDO+74J567GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSdlmAXT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSdlmAXT"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so5924385ad.0;
        Thu, 10 Apr 2025 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284833; x=1744889633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdcxMcGWeslHOma6SjvRq7Io4AouhBYz+R93jChV46U=;
        b=SSdlmAXTOnjMLZF+oQQBGQ/RodczTml9yY2vfja7ieOmgCLM0rnZHNGcARULPqoi8s
         JGUaKN0jXddJlpIdYHIWKfY69tGe+WN4CLlLtb1EX7E4TOpJYbpWmYeYyjt7TwovmA0J
         5DiqjsnS9sakvzbQ9yoVezcPVxyNf+yoz3+X4z153ueRJEvz58S36xvzh8TQ7raOwU0e
         qbmRfaoEHXALSoMq3kLJsDR5eZnhDz5QE2YI7qNN83xC+JjQk1KKAdTO8q3bOd2I/Mga
         lu4hALIUk5M62VllKCKUeYQeZ8ice4q4xabKH0tXyztmXOEZg/YDv1a6p6tU003mlLSg
         9VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284833; x=1744889633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdcxMcGWeslHOma6SjvRq7Io4AouhBYz+R93jChV46U=;
        b=H9PEzCMf3/3nfVrg4llXL/XiM2DYfFSbXbhfG5wHRrIrW30WYXj84gioE6tT9J2EK0
         uiTchi2Aun6+nE1KZ8CjM7FB70E8Vd0r4gkowEOHbo2ADqZtE5nVGrYkvkpEDcYDOl7m
         H7kWQGCh2FtvFRoMXWPb6/ahyeOg97uRMEbqwtU4SFr0CfrpSDgUW9GPlbfOz9cS8I8q
         DOlvOOoVmoxzmAws352nmE7qGMljeysHMvvj75O76UByvm/jNTPhx1XU0be6Tkst7+rQ
         75ygB1rlF3udcexezNrA5TxqjpqTFZkmddIIcweww7MpKXxtVK2OF8fKUOsXsxh7pEqK
         c4pA==
X-Forwarded-Encrypted: i=1; AJvYcCU4gid8Tz6ozsGLIrs0QEO00dzPGTbJeZ5/7OGGY7dmZkewDaUGpDL/xSxPbGShBIunfGss1JpznpL3Qas=@vger.kernel.org, AJvYcCWLL2y4ifHJMt9kopCk7T+Vs0bJvPq/LIRc2uXZ1+eehKIPz2TN6PZxVD6R6KLjZ8eofEkTCWWvMe/NtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pyWSX/tNV5sZDs7EhTlQ9V4Quw9Ykvxbdm95Zwc4dq1xO6iM
	NgyVN/SLeuXiUr1mpOs9JzX+vRVpg5+JTjIppHjNWxsA2J0DgRPT
X-Gm-Gg: ASbGnctLjEOt2B81TpNrcGMZTF3+pILSuRkC5arMFWjd+p+O4x1Op5PZNbva5gLx42x
	RNlkH4WVM8r2xPttVbLHkNf3PqrZr5BUSjQB1mX4u5CG4BU3T31OMKOp4eoVSRNKS7ASab1d5tz
	pqX1nPPUn4K9eM6ATCC5kj9mGcZQs4YkBReAogT3BJiCy04bl+zCm/sV0BfwSnYQPy97iLsl4d/
	v7bh3rVbw9EF6Qba8/Ap1zuzFkfQ/wUIvkr2Oi+s+3BMNnfhREFjepxKa08NyQFlB1/CDn9F9xa
	I9XGdKU0SoqE4m+efgjfBAwNtaKt9+MJb528cIklr909Mve64SCGI7s7kL0=
X-Google-Smtp-Source: AGHT+IGbmEpXUVT5b4jUmOqc0Gktk+vzHso8uec96xMXDQnlPxXIgOdHnD7GIqeT1W8b02bCC3uLuQ==
X-Received: by 2002:a17:902:f552:b0:225:b718:4dff with SMTP id d9443c01a7336-22be03e129emr31667495ad.53.1744284832522;
        Thu, 10 Apr 2025 04:33:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:242e:867:9d6a:e7c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ea6csm28132715ad.97.2025.04.10.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:33:51 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Cc: skhan@linuxfoundation.org
Subject: [PATCH] Removing deprecated strncpy()
Date: Thu, 10 Apr 2025 17:02:30 +0530
Message-Id: <20250410113230.28116-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per the Documentation/process/deprecated
the strncpy() fails to guarntee NULL termination
since the function adds zero pads, this isn't really convenient
for short strings as it may cause performce issues

strscpy() is a preffered replacement because
it overcomes the limitations of strncpy as mentioned above

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 arch/s390/boot/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/printk.c b/arch/s390/boot/printk.c
index 8cf6331bc060..8f3b2244ef1b 100644
--- a/arch/s390/boot/printk.c
+++ b/arch/s390/boot/printk.c
@@ -158,7 +158,7 @@ static noinline char *strsym(char *buf, void *ip)
 
 	p = findsym((unsigned long)ip, &off, &len);
 	if (p) {
-		strncpy(buf, p, MAX_SYMLEN);
+		strscpy(buf, p, MAX_SYMLEN);
 		/* reserve 15 bytes for offset/len in symbol+0x1234/0x1234 */
 		p = buf + strnlen(buf, MAX_SYMLEN - 15);
 		strcpy(p, "+0x");
-- 
2.39.5

