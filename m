Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BF3D66;
	Thu,  8 Aug 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076073; cv=none; b=Qo0vYdD6a2GMVUKxPxEJGjU9tj5TAvuHmou36EvaO64gaZZA849GKtpv1KSF/07ubGyX8rfz+qeMSMO6DimJLd0gQ3e3EIYSnTFFrB6C29s0gFt9RAbXBobKYJFW7awa0eJ9ON7GuaLJKlHqabftN4DAF6Btj0zv64yoWDpd3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076073; c=relaxed/simple;
	bh=0wSU1bafZB97QK2b7Ea/j7tsbaen9+hz1Ts3shuE31w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ggj940VjyqvK5mgovhe88rIZmDKXTjOLUZzwOvhR5qE3Q2mdTKdLN2QOh2XhT/IDByYPHpyLwvgMkIVUUEt1puVI7c2qCRGbyd0soaZ4YI4cOkP/epJC3EHu2YykZFq9D8XaNN3omuGtpz2SvzFHPC0rSZecwnilApZUhP3O5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVOMm0MQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVOMm0MQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so47894966b.3;
        Wed, 07 Aug 2024 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076070; x=1723680870; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1quz4+XXJaWh3wMTjkQHoxnVA0f2NXUhht29C+e6hY=;
        b=MVOMm0MQBRmlWuK6RWuVbsGYYjJ/q4IlwnVm8k7Ijgy4SyWSqwSqsv38Rck5Gn5VYM
         Q9Ip4nOMvnAG+95M9km9P0D+OtyMlGaiRlp228X5Bo49+wc09b0FrhwAVkppJZEi+PAg
         13AB4cNXbTUeNRVHYo0S3oiyQBmvOytIiOnT4pkbMoyOmebgkZoobDqW8FhuS1mFqEev
         b2FAjpDsPwjJu8t3sKx5kPIBsZMPuu6PZ4VhCXmUxBaYkmJttIrpEgqBs62Yd9s/X/Zw
         gpWH3+V5SZhOY2zNCDePHvg3hd9Mspwwu+swhjls10H+V2I5G2eumtJU6D3/yZN4hUM4
         FBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076070; x=1723680870;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1quz4+XXJaWh3wMTjkQHoxnVA0f2NXUhht29C+e6hY=;
        b=tFfnw/vNWfIZoyU6YoLmbIQAO+hnMrhHiRPcfjiBLyxcZAw2hqTIY6I5p0Y4WTdhjI
         eTAzEmIBFnPhvGVws5dUxIr0oRr1T3UbX49PsCPy1t4fXrbGnSdftDkMjgPJWSXqSODk
         TEEbuL4zxisX3hle7YZ8srxdDV7G4CsOybtkafDU3UbIu8zJrMUR5B8dcKufNEza/iEr
         8gGciDHDs3cOkP1GQh5m4DzWuB20mZLBKLqchVn+IqHvM0IVM7N1lz+C4ickraXl5y//
         qBwcEdZbeaoqNGzc8hUVVlLenfEiiidGEsx0WEJxQJGfJBVCWh4ufxRpvHb+Tywnm6/6
         oeMA==
X-Forwarded-Encrypted: i=1; AJvYcCWiTvoPY5kireA+UcNsJOsOAXHYEYFlwgiLJ0eRxYnEdgJa/QEu8MLHwtNsfcZERHvbdKBvnbXEatE+n0JlBNBTG5W9r+EmLXa4y/cZ
X-Gm-Message-State: AOJu0YxzBtESWKOe1HRW0tvmDJ8W3/j4kugax2VOSWE4aA/tMlG2jDuL
	bmkGH7IpK/ichQRYEhQwfu1yV2gIA92DtZlHMiVs+aGIq9i6Cidy
X-Google-Smtp-Source: AGHT+IEe1yNGN5PUCQJfhsmlB50nSXvNQ25O0Lop6u6OHJWSvcy1isrWBOSiRn+Uxt9f6VekPZLh8A==
X-Received: by 2002:a17:907:809:b0:a77:cacf:58b5 with SMTP id a640c23a62f3a-a8090c25770mr10159966b.1.1723076069042;
        Wed, 07 Aug 2024 17:14:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7eee0sm694579966b.149.2024.08.07.17.14.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2024 17:14:28 -0700 (PDT)
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
Subject: [PATCH v6 1/3] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
Date: Thu,  8 Aug 2024 00:14:13 +0000
Message-Id: <20240808001415.6298-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

During bootup, system may need the number of free pages in the whole system
to do some calculation before all pages are freed to buddy system. Usually
this number is get from totalram_pages(). Since we plan to move the free
pages accounting in __free_pages_core(), this value may not represent
total free pages at the early stage, especially when
CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

Instead of using raw memblock api, let's introduce a new helper for user
to get the estimated number of free pages from memblock point of view.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---
v6: fix memblock test
v5: cleanup the stale name
v4: adjust comment per david's suggestion
---
 include/linux/memblock.h  |  1 +
 mm/memblock.c             | 17 +++++++++++++++++
 tools/include/linux/pfn.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index fc4d75c6cec3..673d5cae7c81 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -467,6 +467,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index 3b9dc2d89b8a..213057603b65 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1731,6 +1731,23 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+/**
+ * memblock_estimated_nr_free_pages - return estimated number of free pages
+ * from memblock point of view
+ *
+ * During bootup, subsystems might need a rough estimate of the number of free
+ * pages in the whole system, before precise numbers are available from the
+ * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
+ * obtained from the buddy might be very imprecise during bootup.
+ *
+ * Return:
+ * An estimated number of free pages from memblock point of view.
+ */
+unsigned long __init memblock_estimated_nr_free_pages(void)
+{
+	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+}
+
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
diff --git a/tools/include/linux/pfn.h b/tools/include/linux/pfn.h
index 7512a58189eb..f77a30d70152 100644
--- a/tools/include/linux/pfn.h
+++ b/tools/include/linux/pfn.h
@@ -7,4 +7,5 @@
 #define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((phys_addr_t)(x) << PAGE_SHIFT)
+#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
 #endif
-- 
2.34.1

