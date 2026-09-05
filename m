Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C18223DFF
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599794; cv=none; b=cpZTPI56eD8z/H3ZGXsFZ+BRfFg2m1IDEvBfeTSRVH781LvseFzeuCG2AolsR52S5A0/n0s8JXeS9+mG3wQ1Z/5hVMhtDC9P+2JWtPOfFhG/FFDHlABZ2yLk3vvUyM+J4RGdOQoC4xogTayQVetYlUHRfdO6bLlwdptP2zJxV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599794; c=relaxed/simple;
	bh=QlTrr6JjdErdr6UnK8F9WXX2MMLSdjsQ5MJMrybwsrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a8QAqy6IUricsp+nvWcmMLwi8/PRBOAVRTojn103jpaLbC3nFrUSP1feLS2tqvbW68Zq5n4s7J/f6MuPjUjd9jLTs0BQLfgrPiq+lstUqqx1cApnAwh/7cPv6+J/vz2N/RHzxI3fAoKUa7l67VDtkHUOiWazPArv9Ue2hsjyklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rplofPGY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rplofPGY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956869750eso14420205e9.2
        for <linux-s390@vger.kernel.org>; Sat, 05 Sep 2026 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599791; x=1789204591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2VfUci30wgtwS2sdORmaqwFwHrpLhfXm3x7VkRHQQQ=;
        b=rplofPGY/qeyWYyUVAta1Fio+0c8YrLfUZFav+3rAFmKHhVlhgzG96f+kasaVgZZR/
         3DFzbqc0zwroU2mWTQhxjCT9RLg01aMoaA1OTZrPn4fQmXrtqC6mIOOTcJlFH5jy+ySN
         SLB1nAmlmrMI3eOk3ndwEcpzZxeJGl8xv7REdCQHjBrb2yC01sLvAxGSNsi02hkUdVyo
         RXYYrTdKYZggNfNopcxoZSfV1h5rEa0/8b34t38dtmpJP3FYTydO1RiQIK2aijg8cYW5
         h5F36x/Y9GJtm9+ORhlD7gnKWDOxT86eLaHKjd+fyHlYb2B52yoI0SrVfQZ0Z3dwNwXt
         EtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599791; x=1789204591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2VfUci30wgtwS2sdORmaqwFwHrpLhfXm3x7VkRHQQQ=;
        b=k8dO8dEXLIHg4dIoMw2FX0F0GaQrKgZ3o82X/kEWbjyEYiDn6sVyc4zJeURawUhkDq
         DYKVQWelzAz3EjNLUraH/TYnx/VzNCcsXGMUrL6OlLESKBZlw9ErcW0mVBhO+/gF0rmH
         KL7B+7oWLHmwRxHxHr7xx2sLuX/0OU35dntUgba+l4gw6Rv0sgiBkJB+nlo3msB3YkoZ
         7R7O4hoYiRQlP4xCZigECzubWBQ4Z9geR4iKh9+KQSlOsvJzeVy/qhfRi422mThL4pXJ
         mFrDSfQH0eI9GBEBNorfFacDroL3O4FO8tUG/Vt0yRf7GnZP84Ohuwca3Jn/9PxErbr2
         wIyw==
X-Forwarded-Encrypted: i=1; AKwUvByYWq8CQ2A0X1QXAjIZ+qKNdn/27VXJFHoju/k5CBOsPHenwqwZeddlxYUgNfbwRkCaTUUecVtLFXOY@vger.kernel.org
X-Gm-Message-State: AFuF++kfEMgqpYofo3fl781+4ygYiMDd1FmBJe8xIM6tfEdaIUpkRhbu
	EZ0TklOWOGBdLMNUmYtoNolXNVMy+lK7OLj8oK22dkGvz0Sgpn3Z7eCS
X-Gm-Gg: AYBFou2sbBK8/5m70UkQUYdP/Vvwynz/z9YYIGnFD8/KcQz/N2UY4wyjnNSqU48XprL
	agm+QphRPmEqU9zuIAuAfBK5DyXkzARGRdFXATTtUloivKIbRMddZv8m7f8ffLVCbZZvaDtt396
	daobAgoeulCQPtp1+SVmtCFrOIes9eyOXi2gGz1F8JnjKxWW+2FVIRgrG06WqxbVJ6LWE0n+4Fr
	sOvs7gNpbhmUqD9rXC9GZ9MyHBSiHNBlZfUwXSIE0iebQNaYi+4V6IWm2GXsuESE8u0SLNcky9K
	Q+AayDfq1fwcPEodWjNIHTFhkBuVWeXx40/Xq5swr4ulgGNILv8J6NZDFIhnGT9lyZBkty153/A
	47lsojAwnf7F4JclTTKcTKKbCyeIj7lRLvqj5jL2WY40OG+VPwh0f11x68wgMHU6J62X8cfbQQb
	x73JspVbPpPFay0ntSgrTBg0vRFM98avBhiWwbgx62os+ERqDZ9tBxrwzo+WKkElOmktkMeMx0H
	nivz/YhnlbXb1CpFI7qPCZEQZp4GdtVXNvuVHptIUfwgt5qYaVbcSD5/cKx0tPjOHHRg/Ix9KsL
	BhfIFn9mEVLEiPCe6ZTGIDJPJa+t8lOrrewOFGL/j5xqIvXUOq+aw4zCTTXgRp0k1i0zAR0FAum
	3GA==
X-Received: by 2002:a05:600c:314f:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49cffde4629mr53877965e9.17.1788599791198;
        Sat, 05 Sep 2026 02:16:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm13716212f8f.33.2026.09.05.02.16.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:16:30 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH] docs: s390: pci: Fix the sriov_numvfs attribute name
Date: Sat,  5 Sep 2026 11:16:27 +0200
Message-Id: <20260905091627.40946-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The attribute is sriov_numvfs (drivers/s390/pci/pci_sysfs.c); the
document names it sriov_numvf, which does not exist.

Use sriov_numvfs.

Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/arch/s390/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index 80f4ba193159..565434626fb5 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -67,7 +67,7 @@ Entries specific to zPCI functions and entries that hold zPCI information.
 
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
-  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
+  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
 
 * /sys/bus/pci/devices/DDDD:BB:dd.f/:
 
-- 
2.53.0

