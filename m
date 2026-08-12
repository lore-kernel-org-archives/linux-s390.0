Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BF3A6EF7
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566654; cv=none; b=c785UGhNP7IHHu5W98+a4GnZyxQnixOKb9/R838UKfRcSVv2X2smFlXjTafQwr/mEt3BRTonhoyryBfnoCcenIJ0+NMBEN2641aZJ/LvwBqEyKXg6+ayVrFsGc/IsrkVYCwd7QVVfJEV596jAVnSUW7R+JX3Cr9ZOCsThYBPHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566654; c=relaxed/simple;
	bh=LlJ6I9bvGmzRIaPyWdQfyz9C6oMMl+wo6V8c/miVHEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pq3wA1B6IM8ka3kQ6rw9oxSou7xj0uAcvO0Ch527u3W6voFdZibAaqeyydicomFhtwZme3yIPkiLeyR4bqSCkthuOmNKXB+MdeW+ppYbE4WUOqcxufiSNC7eb7HzZbmwTiLjbKTkCzl8HDZguuS5RoL1vJ4o9hWN+XTr4py75Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZkB4iT7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZkB4iT7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so8946565e9.3
        for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786566651; x=1787171451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ay9eqpJSfXPclJqhj8WgHyKYU5OeiSUdDYoWzRdbrqg=;
        b=iZkB4iT7barINWLKAfvNVhv/E02J9rCOMX0r0RLauBrEMT7FWpBsavGZq2S7bv3UdC
         NTLxLdJQ8hDCytXNfE8Eh/V727DLrOMaEclaYKSdz2IVea+wkk5zWA+/jCI6J6F9tu2b
         qNusBC9l7mbW5iMvC01XZk8LRu82akQTJ/2+3Ty+Sx2vZkdoda9ApDVmmc17jGBK3Lri
         TSMH23DCtncjAVBq4tkaWSE32zjLbZWS1zAs836apqyQunfKAkhjwdDFnu/F/G48cyel
         f9gpUozyPY9LMk6eTpTWcox2HR/bx+br1DSEEOxhvfTHTc8G060V2EY5ZFzUFIc20jxL
         v5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566651; x=1787171451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ay9eqpJSfXPclJqhj8WgHyKYU5OeiSUdDYoWzRdbrqg=;
        b=kJbC8JV2h/KHM6pZzvUkMcLjGKddolt53PMWy2igZGqQCbZM0QUVPKw4BS3gjSB6TF
         1msDIDAo1J/L+OJlrYStJPFig/iZdQ12O4s3EBuPEmwsnYVPeIItneHEavDcnXQJ0Mqn
         kHtwTD9bJp9Gx3Wi3J6de00yyQmEaf4xBVTMXBDQYrj9KiqhFsKY5oiVo8KrL8eKTDlD
         I7nlF6mpzznu6MnRspNlEL50SblH7bkr+sJuIm7w/ND0XHryhL/7QNSoa3/5DAOj+kgR
         LjZzq7Qr4QWpF9jONvjHpsqOXWQrmlZoS3+jd3dd78loC5OW+KkMo6rnIaHdsQRHigM2
         lqZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSdCUL6U7AoPxot/XRhGjv8Uh7FWwzbRL8Hobqms38kQO1xP1GRT31/QY46+IWwRMSxyDGeVtl+LLQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhyg/jEZD9Al4GbOEipIq3TcnJ+etWt79FOtVZLSkUx/3nxk/8
	kxJ8bPK4XT3oW3zgl+W9oPVCQlSb0QJcQluik1g4VCk01cXFQK4M+7rt
X-Gm-Gg: AR+sD12CCgngCwrSs2EVD2WrwkCO6wrRI0XmtJzrZ2woBZq+xBMCCqZ/rypE6BJCf6G
	qB1p2QAygYkvtlDcE1sPlYzCL8XE//CjXMrX+oMoTE7J+6ZxtzXKtHbZbQ+xBnTjpYW2JM9r/qC
	2d5MlvewUezgrXLilza+Dt5/c9k/o3p1NvIauIW2nJe9iEZfYA7YzDxw+VxUetGDqqR4jGSn9Sp
	m3o4IewvRfkGKdQWeD57SpH6IN/v6KM6XZiMTgZBERdSYxIq9gA+wX8TWFLJyLz64v5rOqLeejY
	nkGwfyKURKTopbegkELnnAlD02aHLjgJ3Ph6EtlwmPebthr7BoK05gl6xz9VEcOZUM/+mZBhCub
	Dk8uP3as+rqToX1mLgnfZZLHTRts0NBtaagdNjVDRvxtCvi4P63AXx7nqUsIKRXIpPp9K1YYGt6
	s2WFREe3rmOnqsoXiFbkImRJ1T4p1fui2wM5KTyP40jnoicsjb93rOx0RcMTDfiY5vGfXRa46NW
	HxvTMUbsi1OKGOi2xSVgqpDVB2tFPVihJwxzUsNtiQOxvz16mokwhGVFirZqmMzQz+ceckZeDfO
	3SHi/w1kLIW/UHQZzsU+V5JK5yEKrGMvnVgixCnXM2VzO9oNWvSvh6ovVB79LtMs0gxD
X-Received: by 2002:a05:600c:4585:b0:499:5b04:6920 with SMTP id 5b1f17b1804b1-499821fe9ecmr2744625e9.16.1786566650998;
        Wed, 12 Aug 2026 13:30:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a869-c801-382b-4199-5518-da16.310.pool.telefonica.de. [2a02:3100:a869:c801:382b:4199:5518:da16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e31783sm7640995e9.3.2026.08.12.13.30.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 13:30:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/percpu: Fix MVIY_PERCPU() with older binutils
Date: Wed, 12 Aug 2026 22:30:36 +0200
Message-Id: <20260812203036.3018-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a737737cdb9c ("s390/percpu: Infrastructure for more efficient
this_cpu operations") introduced MVIY_PERCPU(), which stringifies
arguments that are already C string literals. This generates an
assembler macro invocation with whitespace-separated quoted arguments:

  GEN_MVIY "459712" "%r3"

GNU as versions prior to binutils 2.39 drop the separating whitespace
between quoted macro arguments during input scrubbing. They
consequently parse the invocation as a single argument and emit
repeated warnings:

  Warning: missing closing `"'

The .ifc in GEN_MVIY never matches and GNU as exits successfully
without emitting the mviy instruction. As a result, the interrupted
per-CPU sequence is not marked in lowcore and the exception return
path cannot repair the per-CPU address register after migration.

All MVIY_PERCPU() callers pass C string literals. Use them directly
and separate the assembler macro arguments with an explicit comma. The
resulting invocation is:

  GEN_MVIY 459712, %r3

This form is unambiguous for GNU as and LLVM's integrated assembler.
This behavior was fixed in GNU as from binutils 2.39, but Linux
supports binutils 2.30.

Fixes: a737737cdb9c ("s390/percpu: Infrastructure for more efficient this_cpu operations")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/s390/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 1d955dd0defa3..feb58acf87d69 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -107,8 +107,8 @@
 	"	.endif\n"							\
 	".endr\n"								\
 	".endm\n"								\
-	ALTERNATIVE("GEN_MVIY " __stringify(disp)    " " __stringify(reg) "\n",	\
-		    "GEN_MVIY " __stringify(dispalt) " " __stringify(reg) "\n",	\
+	ALTERNATIVE("GEN_MVIY " disp    ", " reg "\n",				\
+		    "GEN_MVIY " dispalt ", " reg "\n",				\
 		    ALT_FEATURE(MFEATURE_LOWCORE))				\
 	".purgem GEN_MVIY\n"
 
-- 
2.53.0

