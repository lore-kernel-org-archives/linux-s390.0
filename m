Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A6C433F5
	for <linux-s390@archiver.kernel.org>; Thu,  6 Oct 2022 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJFK4r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Oct 2022 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJFK4q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Oct 2022 06:56:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C098CA6
        for <linux-s390@vger.kernel.org>; Thu,  6 Oct 2022 03:56:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so1672918pfp.13
        for <linux-s390@vger.kernel.org>; Thu, 06 Oct 2022 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZP/zKyJp37FXzbL8/Q6HCrJnDQOzN4qDGcvULMOGl+8=;
        b=izLmH9lZB6NiCBhbFy6zp5sHJpwwzANBNFy10+0d2h+OQYna4oQt1JRC4gySHOJaBE
         C2edzHf9oAycjpqmvc3zr95lplNqCyN6Qrsy/TfsCZLwccu3YeFV7ZA1GjK7XUv+GgXq
         Tuk570WSL8Q2yvIG9tAST5uqLh1Qmf+JVnt6Ud97ZB3z/MyvKM2xPUBhHQU+5ANqHVBW
         zcqfeD6cyyH8OC3wMR2rPrFiUK51lZXLJ7a/P5xlrPYtgohjtbZYsEydjn2+7oqZAS+g
         pnx//3AJ44/nD0lN5FHk8REtfdKdsZNcmU5fmjDnnoYuedkavA9qZrKFN3XuBkfQ58ZT
         WbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZP/zKyJp37FXzbL8/Q6HCrJnDQOzN4qDGcvULMOGl+8=;
        b=FTXAWya2o1P4fScsKiyesb8CQa33kATffWuXCVgP+ACI40lnMC5o8igxRwfj74nosx
         JNRCOQxdRrP1jVPsWLB0j9HoF6Zltdyy8MzlsvL6KLLakrkbFLuI5WSHBuILJfAzrEry
         8QxVMrEUcDHEuogWoPXz9AKIiNBIMhlaq+u+fAUZ0rC7X+C3374rVvFWL734I5YiXlaO
         SfkNznFYYenpQdGIs5r525YZHywWbWxLRjrrLsTBNb0EmvSzmkf0cTHgZlj+f39P76/e
         MnArbC5xWwoK78QWMezGUw5JnhBnhfBR+grfuJOOcZ52wHuvW750Aq2ScLc92bHvw3ol
         7cxg==
X-Gm-Message-State: ACrzQf3rTQwGkF52W7yZ+RZPag+RszmT91VF33Er8rNLU032rGnz9ckq
        +/kxMk06eTOmjrD+2QsBhRueRF80hvA=
X-Google-Smtp-Source: AMsMyM7E9sg4+9jUJ262BwYr7E96Q1fquYQVe4NtsFinjhmM2HLIM/EXr89tQVa6T1TtdV8YmnB01g==
X-Received: by 2002:a05:6a00:22d1:b0:562:5d7d:5588 with SMTP id f17-20020a056a0022d100b005625d7d5588mr4299810pfj.58.1665053804730;
        Thu, 06 Oct 2022 03:56:44 -0700 (PDT)
Received: from bobo.ibm.com ([118.208.156.99])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b0017808db132bsm12195291plh.137.2022.10.06.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:56:43 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] s390: remove the last remnants of cputime_t
Date:   Thu,  6 Oct 2022 20:56:35 +1000
Message-Id: <20221006105635.115775-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

cputime_t was a core kernel type, removed by commits
ed5c8c854f2b..b672592f0221. As explained in commit b672592f0221
("sched/cputime: Remove generic asm headers"), the final cleanup is for
the arch to provide cputime_to_nsec[s](). Commit e53051e757d6
("s390/cputime: provide archicture specific cputime_to_nsecs") did that,
but just didn't remove the then-unused cputime_to_usecs() and associated
remnants.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Sorry this isn't build or compile tested, I'm doing the same for powerpc
then we can remove the cputime_to_nsecs fallback from core code too.

Thanks,
Nick

 arch/s390/include/asm/cputime.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 1d389847b588..7f9284e2a7db 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -11,21 +11,6 @@
 #include <linux/types.h>
 #include <asm/timex.h>
 
-#define CPUTIME_PER_USEC 4096ULL
-#define CPUTIME_PER_SEC (CPUTIME_PER_USEC * USEC_PER_SEC)
-
-/* We want to use full resolution of the CPU timer: 2**-12 micro-seconds. */
-
-#define cmpxchg_cputime(ptr, old, new) cmpxchg64(ptr, old, new)
-
-/*
- * Convert cputime to microseconds.
- */
-static inline u64 cputime_to_usecs(const u64 cputime)
-{
-	return cputime >> 12;
-}
-
 /*
  * Convert cputime to nanoseconds.
  */
-- 
2.37.2

