Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB613D6B;
	Thu,  8 Aug 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076073; cv=none; b=Bjbz30d8HAM1U4d6qotuU5RqeHhQbdGLaq/Tl0WWFS+RnsHv9Tfr4hduPUmiZ1zVcn4i8agbn85rTEAJg7Um3Rw/uNffe+HqKxRIvOCz0WAsiqK631dVESsA0WWqJevyZnLGvF+rAwxz47gUDPEQtEGCfwDX+CwMYXKRH2m7dXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076073; c=relaxed/simple;
	bh=/tlZkyZ2Brl7h61xyezG9SMHX3SrPQ+LqMEBs5KVJT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VeMv8eaHVqrzASXtwhU6w9jiIEG/UopBbL0RcBZhqnxY+W5xcT3RIComXtuC2zVf4NowDX+fJwEUHJPSsFBY82r6YvSlH/44lO0vQ2euevNLCss1t0AA6Qsj7zTPcQOU3PX8gDstw1q1w6bbAlZawF0TFKJM6Gv8MVFL7GQQTQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOpdlC9q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpdlC9q"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab63a388bso14802166b.1;
        Wed, 07 Aug 2024 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076070; x=1723680870; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NryPogQUlVepSvzhnijJxf4XWkE+rRPYtCWNysxNB9U=;
        b=FOpdlC9qVD1KGi1bS43TV3WlZZ8zwE9si6+N4MMmOMjIQuJhNLa6KpouV0H2Dg6Hdd
         5r+rQT/qW4FSK8/1ExuKKClBQdc3jooGaHYNeuCAB5SJflKCNW4mVmbKvGsqoZH1qqHE
         Ab/9x348HBx8ZAij78hpGVTYqTUd0O7w2aaa88RyusKFZL/sGsaI8Gnvc3fKXV7wOMWp
         uUqmsAQUfDGIV0VzviVezmO0E3O1hsGdcbUCGsSoCPE6+A/+p5lUIJbCGQOr1Eh8E5Ya
         OJQFUmTF5WrFDmK5knK4MvoNcmyzkK6ogbTZ5s7wN8cnMv475s+Rb5QmSzes5jCU0KlY
         WPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076070; x=1723680870;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NryPogQUlVepSvzhnijJxf4XWkE+rRPYtCWNysxNB9U=;
        b=vgPRN7TtMOIP4e6qzIuMSwlgMKSg26Zq3tJu9a9NFB/QBEUaw54vIWCq59hpfYO/PE
         G1/hrjFIoJWwglQhhkONKuavgdmOOoVh9gMiLY1Hh6zSQmqKmACDt2vMlpNfPEIZOydZ
         6PB3nZyBYEEi52dNomZW6xlS1fU93IFPa1OjYVRtcTF5QpMJ0ihj7i+tssCBwHr9zFGr
         FTZWn0nn/GuJeloYR+MRD4vQ4FKeEByIKOxJSbzQGbQYraop8hivxpKyHNlJVuKEpD6N
         5udXW4yqDoK618zXLjcHYTDAtcbszS0HGe6MT9Y5F6H7AUrjFvYPOI8bRPjp5sSekpaF
         r6gw==
X-Forwarded-Encrypted: i=1; AJvYcCViShrCD8qu+ihZFA8PUbZh21I6+kalXuFxcM3TKc7JB8Emg5aPlgVEp4FRRhOaSb0uIfbyzyEsRn/hboU5DhlxrEofkInBojE/6Iiy
X-Gm-Message-State: AOJu0YwCUTQL2YruGD9v3XszdcC3w81dD12Yg2ylf/RxPitFEDsTXLls
	ZXBAhs18l3pggaqa5PIYBYnaF9y9hP8T3QPFSurjCBM0/+Xgm1im
X-Google-Smtp-Source: AGHT+IFBBcwaC/rSWy+Q2eZrAPcUvhwc7fifS6ckd1H+3H+mA5lXgCRuCrbOXxsinlZwpdykBxOBrg==
X-Received: by 2002:a05:6402:2682:b0:5a1:b6d8:b561 with SMTP id 4fb4d7f45d1cf-5bbb23449e2mr257540a12.9.1723076070287;
        Wed, 07 Aug 2024 17:14:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2e5c8edsm70477a12.81.2024.08.07.17.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2024 17:14:29 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	oleg@redhat.com
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 2/3] kernel/fork.c: get estimated free pages by memblock api
Date: Thu,  8 Aug 2024 00:14:14 +0000
Message-Id: <20240808001415.6298-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240808001415.6298-1-richard.weiyang@gmail.com>
References: <20240808001415.6298-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Instead of getting estimated free pages from memblock directly, we have
introduced an API, memblock_estimated_nr_free_pages(), which is more
friendly for users.

Just replace it with new API, no functional change.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>
CC: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..d99f148d818b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -997,7 +997,7 @@ void __init __weak arch_task_cache_init(void) { }
 static void __init set_max_threads(unsigned int max_threads_suggested)
 {
 	u64 threads;
-	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	unsigned long nr_pages = memblock_estimated_nr_free_pages();
 
 	/*
 	 * The number of threads shall be limited such that the thread
-- 
2.34.1

