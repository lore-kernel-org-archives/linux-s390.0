Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA93F822F
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110300; cv=none; b=cjxpaOs0eLuKV0UMYA8B5855cbPjPlC7CdQS8fMs9DOZ8RAgQ9v3bt68PFesk0+n9fHa7KZHCGuIkv28kKlcBewlzPXo0FibWUCW+dbyWveqaldGKkQX45LcDy1KN2WUxf1omNpjoRIiaz1miNhnOUxsvAffiBEQhNzTDS0uZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110300; c=relaxed/simple;
	bh=YrYfWQ8DTCejykQdQacgG2ZQYpSnZ8BFiS7ovKQqYpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mW0f4bjnqFa8FLxgsRdrdrcroOeSmYxVaV1qxGzVAdv04W+gDfVxCFM6VoWWGQIC5nkS/BXDndsXAZj9fgjS1V0CpctpzHYRacIhgr+IdDopQZAFBY+Mx7iOkD9mtDvsa7771seFFg9pqxT7P/PpFd3N1y6JAddl2dZAAshmeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJqb3us7; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJqb3us7"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db0a41434bso10754755ad.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789110289; x=1789715089; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUWMyzu+5vvtW+pIvov+ll8ijxwG7oGXz2aY3xXHLFA=;
        b=pJqb3us7r9B0qiHi7rxnIcJICyf5ifHlxrMvMdtnN0/P+o2eejxcDfBBXjfhYOKaZM
         9+weL2acSO5OpUt5s6BiO8D4sqD3XwklFTlFc3xscGNePftXxSfcNcz7f6Sg8tpSEvYZ
         xRyqj2OId5N14smXxiShhsj5OKr28Um6tIpl5CODrJ4A7bugecuTMVIHNiDBDfSevcuJ
         WJnvCWGjBDhyC5zXtJQYHpJLh9mmirMKslMGKDalOFlb054P+lyXTUCrSBdZNU2b00UR
         MmJD+d6Tz/dn/hkcdnQ+hOmDY3uDWoK4S7oNipmwmFW02m+u1DEVU8vplQfP0A+BOl9r
         MpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110289; x=1789715089;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUWMyzu+5vvtW+pIvov+ll8ijxwG7oGXz2aY3xXHLFA=;
        b=Tp8gSU+99Z4WoI8M51tmKkJM5hD+5BSyAkqGpSZbqiDztI0D95PqNBiDbA3tIqBC3t
         rUoZk3iCsjjTSGpW1c6JeLHM8ceVqnK1V9GlFYZpPEB2dGKrpi9qsrhGhHZo3MKCPt0d
         FTZFTlyZErVDBnhPUMO05RGIvQFyzPm78Ihag2hxsVlDtj9FNE5CqHwMFBloSbNZMNYU
         fDBdbzz3J9Qa8l+1HYOFc0cR/m7uctrF2GHgyROTl/NtzbPm8fLBDivl2K1dUREzUJ2z
         wozN4CeiZP1wBsOmsn1V6llcuFDjkanXkueKO53fUmvs8+0Di4UR41vHa/n7bFP3Jwuq
         UMHg==
X-Forwarded-Encrypted: i=1; AKwUvBxlQYD6xnAqUyJPgrZ5LsHK+AXihKGIIYHDpFS5F1n1sAu1fsauj0FNkqJc7TVww6cBAlyqSlScvvuW@vger.kernel.org
X-Gm-Message-State: AFuF++k1/cIHHlL6f54xSQZNdNsDgS1uEYu7NNN6uo7NfZMbcE4f0/kD
	FXJBsd70dDYr2YLWTt03KT8YavmToTkrwv0zVQD2C5hX/oSg3MKscc/2+UacyYf7ySk1DVWLboj
	f
X-Received: from plhs15.prod.google.com ([2002:a17:903:320f:b0:2d7:747:8f71])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d551:b0:2d9:4871:393d
 with SMTP id d9443c01a7336-2dd2a45aef6mr60678725ad.21.1789110288973; Fri, 11
 Sep 2026 00:04:48 -0700 (PDT)
Date: Fri, 11 Sep 2026 07:03:44 +0000
In-Reply-To: <20260911070346.801948-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911070346.801948-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260911070346.801948-7-morbo@google.com>
Subject: [PATCH 6/7] s390/word-at-a-time: Instrument load_unaligned_zeropad()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert s390 to the arch_load_unaligned_zeropad() /
load_unaligned_zeropad() split introduced for x86 earlier in this
series, so KASAN/KCSAN also see reads through load_unaligned_zeropad()
on this architecture.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/s390/include/asm/word-at-a-time.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee7699..6a055bee5ba0 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -48,7 +48,7 @@ static inline unsigned long zero_bytemask(unsigned long data)
  * and the next page not being mapped, take the exception and
  * return zeroes in the non-existing part.
  */
-static inline unsigned long load_unaligned_zeropad(const void *addr)
+static inline unsigned long arch_load_unaligned_zeropad(const void *addr)
 {
 	unsigned long data;
 
@@ -62,4 +62,6 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	return data;
 }
 
+#include <asm-generic/word-at-a-time-instrumented.h>
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
-- 
2.47.3

