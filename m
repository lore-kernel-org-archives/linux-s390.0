Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1F645;
	Thu,  8 Aug 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076075; cv=none; b=ne/KpHmzZJtfT1qkPc0d9Mjri6/EhJDZFAdI7fQuZ1ICNh+SP6kFZ2HyrvJI87Zneg9+VVlLCR/5CN4r0Jlo2TjRFzD1quBldyDaOXuhMMSRNONQiHPd4knT7tTRof1ncF5tWDgXLs5DeN/6XTSC/mCmJMomKh/eCkiiwMy4P1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076075; c=relaxed/simple;
	bh=249cw00l9Ns40bKTUck0mIASntYgstdD1Gu0PZ0t240=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=godC6S2SkkVi9Fra1Ose949dYeID6FHRv4VrVqrBRLGq6AprJY/CjoaXPXaZ3kiGVPC5c2OyWiE/dwL/YT19hBC4+rSxNwUVGpeJbZ4dREyjxZW+lOmPPT1R/GRRcDoL0xTXVBTh9zNvdpiP7S3cXwnzpr5i7OjSKAd5q31ihEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsIWgOv7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsIWgOv7"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso610585a12.0;
        Wed, 07 Aug 2024 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076072; x=1723680872; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JwriE0w3Q2CMimHs9GxN93UOCfhw1F7KFNtEIY74zZU=;
        b=OsIWgOv7auNRInC2XE8UoL508H1YdzcUFFwmestzqmrpqkIRAzLa+/FPWiPOdFZcpp
         xEsr1bUWhoTyDpBrVYxn2nQsuH6zTcZM24toG+we2psVI8NVTda1aIo4R+1UHHv7iCtz
         nWgRUvRksVfObkPgDAdX6VhCjlwrQEgAevqv8TD/mmLjGSimSWEJ4ajAvBkwjOgsjtB/
         DhKcvydAXzeLL2oWgNWwgEFmZfWx4LAJPxz1iBtDZumRhhDJbLGC3BiUT+IIek/8/n5o
         5N7860YJWNNQ0yDxvThzppJgRbLHG0Vjkp6SvbiayNEFLgdTWxL1rtCIbT2DGf6EyBtd
         0JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076072; x=1723680872;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwriE0w3Q2CMimHs9GxN93UOCfhw1F7KFNtEIY74zZU=;
        b=gJcIqlkZRpncTYN607zciIQCKXD0fmWmr0WyGOOlhAJ7Ir4NiKH5rGBlIwCQY+bQ1b
         KAyqVxEYu0ItFCSPMbc+5IZLpwNI0ugTmokGquCdQrcaLdpFrBD4FXh1+1ivrWM+CebX
         STSfa6wVyveYn6KN+oJshtxV13uFqB8sv4zw0IEf9oyWM3SBNJFCFOPlUHiJVIGPf9pq
         uH5BD0itzEPA3pnZgxBeSpINguS5+jsNnjHKmYxXc6K+pWVWftHYAfTWC5zY+o7Yl/4i
         4QpImOat7SAA2Sui7PxI8CbHaimpQhbrq5ihbPG1Ao96gsclVY8SWxuyonMAVqEIYCQu
         K2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUjXW7rSs8kF2aRklP+G0uV6xkYXPCchmUQnJb0bdPCobaVYpNsJtNR3uvGN7ufk5Wc+UOzHCnOHwA3lzNfodQ/DcUIe3wZp5YjJgix
X-Gm-Message-State: AOJu0Yw/Ul+Vdx36R0U/yYtkC2y7YYrVqg8Q9lKXMLJ0qk60LUmHeOkn
	8eep4nx1mP2O/nL8GvNjAIod5V4yaAfIqMBE75+ykNWQCLIYmqGV
X-Google-Smtp-Source: AGHT+IHHSd7MK3R9lwIRETYeziGgrVTOh68t3ND+FhwsOqNWTKT9KtExmw1QL6h0P9EkYIlYDLqdXQ==
X-Received: by 2002:a05:6402:40d3:b0:5b8:eb1d:7fec with SMTP id 4fb4d7f45d1cf-5bbb3c05b1dmr35995a12.6.1723076071903;
        Wed, 07 Aug 2024 17:14:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1f6c4sm73150a12.29.2024.08.07.17.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2024 17:14:30 -0700 (PDT)
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
Subject: [PATCH v6 3/3] s390/mm: get estimated free pages by memblock api
Date: Thu,  8 Aug 2024 00:14:15 +0000
Message-Id: <20240808001415.6298-3-richard.weiyang@gmail.com>
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
---
 arch/s390/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e3d258f9e726..651344206294 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -62,7 +62,7 @@ EXPORT_SYMBOL(zero_page_mask);
 
 static void __init setup_zero_pages(void)
 {
-	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	unsigned long total_pages = memblock_estimated_nr_free_pages();
 	unsigned int order;
 	struct page *page;
 	int i;
-- 
2.34.1

