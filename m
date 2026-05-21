Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866B3C9EE0
	for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366460; cv=none; b=RXmlzx8TpfK/iOz4pHsOryd7D81Y2SJQcEFRISkcA24zk727gz2CpH538KeyrG2JxIwsZDn79d3o/7dodW23Yrb9yn2JdZfQNRLadtUA1eoLVDTkW0QOiwnonC3kBN/sRR19bsDP2sqfEmVZubh2fB32jQ/CMwqmh3U/huLOHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366460; c=relaxed/simple;
	bh=M+Mk7QbXAKpkL60TJYSGOP1LwJIztNUkg4IEWFcJJr0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BG0xFi06kxKv4ih5xM2HZJf/nDA/1jVJsFMxNIHkjYtlOURvP+eCS5iliFcgufKrJPRi5+LnOYIDMgSDEc8ClRmWxEOw1PgAykwH2ffuo4gICfa2vFfB4hvZgSF52jgd0vkXc0VKHFvz9bZDarvku9ZLTpkhpcZtaebEAaK+ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUxke5aC; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUxke5aC"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d789cebcfso4649365f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 21 May 2026 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779366457; x=1779971257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BH74M0iFxFJ7OeF2nKs4ve50vTBJ6yjjR8WAtMsTpJ0=;
        b=EUxke5aCLIxmL87w5YgCejINSSk2CsD/F0c58wucB2ZDAaPfp83+T3eXirOCfmWnIB
         Z3Cbwjkx7prACsALwXWzCtCGQFyOtMEM4UypGx53JrFKBxEDIfrpx+EMmH+wHr3uCclF
         vGJeUZIy9FbKInnRLiOqYA/e1ZQ6twJIkzdn//appyXnI9rxeG/EgeI9wEGwlWv+/eHo
         pvzYZvGH0fbeyZBlt9h4V7mnypV0xKumaJ8qzVkZgE8HONTifax3L15gvcB1KiJ6atjU
         nUVMnKMOwJ7Eg/w4n5515B0s7mUfczBCLfp2A6hYisEWpl/DidN+B1rT9+UW1z/CYqJZ
         zjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366457; x=1779971257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH74M0iFxFJ7OeF2nKs4ve50vTBJ6yjjR8WAtMsTpJ0=;
        b=KaVKGDZekeThZQJHeO4sMJn6TvIxPOQwdjfWb5T+0ZNhWxV6Bm3mKhvvZT8PBrhPcs
         AKiOjSxx5wVNoDZ3+wuqhFRHh0hod0H4vjJ8r9DNMhAeC7xdMniNZj4lA1NE1gLbjf9E
         wfGjzZAISbcmOQAQiMW1lN8NoPh691M3kSEo8IuwzIavJxxb5hmhUI1jrXamBwIVrswb
         b2HO9SMNmC4ilIAxmZlD+EqE6bHsIQWTrRavZwegMEjpwASbpnFrgcHhd9z7HR65tiHW
         NvLjxzPjXhvjh7Skvvdjr9MvkborvgHXkj/MWAL1FpzOS9ErbD7BHgdI7nvRRprfgeE1
         eIWw==
X-Forwarded-Encrypted: i=1; AFNElJ8iqzv5U79IPROkR9FSwR/C9JhoLZgl0BmAGiiPCYLrfS09fPTSZGHygZyrORQRP+hlWgU0PrK2Ylp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg29Z/6vQ2Syp26L66LOGjdx/IS2YWnVxw29nsdABZ41bY6aBd
	uD/EJMmrsEhupGZl4gAa0zJIkT26sDH32IE9q3i/gSOQipqrc03vXCeGORbGqcanyF4g/XsSmS8
	czQ==
X-Received: from wmbhn25.prod.google.com ([2002:a05:600c:a399:b0:490:3e3f:8c8d])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:490f:b0:48a:5339:a46
 with SMTP id 5b1f17b1804b1-49036090799mr19423255e9.9.1779366456918; Thu, 21
 May 2026 05:27:36 -0700 (PDT)
Date: Thu, 21 May 2026 14:27:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521122727.142280-1-elver@google.com>
Subject: [PATCH] s390: Implement _THIS_IP_ using inline asm
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Both GCC [1] and Clang [2] consider the generic version of _THIS_IP_ to
be broken:

        #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })

In particular, the address of a label is only expected to be used with a
computed goto.

While the generic version more or less works today, it is known to be
brittle and may break with current and future optimizations. For
example, Clang -O2 always returns 1 when this function is inlined:

        static inline unsigned long get_ip(void)
        { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }

Fix it by overriding _THIS_IP_ in <asm/linkage.h> (which is included by
<linux/instruction_pointer.h>) using an architecture-specific inline asm
version. Additionally, avoiding taking the address of a label prevents
compilers from emitting spurious indirect branch targets (e.g. ENDBR or
BTI) under control-flow integrity schemes.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
Link: https://github.com/llvm/llvm-project/issues/138272 [2]
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/s390/include/asm/linkage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/linkage.h b/arch/s390/include/asm/linkage.h
index df3fb7d8227b..1b3ac553a642 100644
--- a/arch/s390/include/asm/linkage.h
+++ b/arch/s390/include/asm/linkage.h
@@ -7,4 +7,6 @@
 #define __ALIGN .balign CONFIG_FUNCTION_ALIGNMENT, 0x07
 #define __ALIGN_STR __stringify(__ALIGN)
 
+#define _THIS_IP_ ({ unsigned long __ip; asm volatile("larl %0, ." : "=d" (__ip)); __ip; })
+
 #endif
-- 
2.54.0.746.g67dd491aae-goog

