Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0253D6B
	for <linux-s390@vger.kernel.org>; Sun, 16 Jun 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501763; cv=none; b=aM0M5YcguojOu4vzP2imHQLl9SxlwD6NjlONDvpecpB5Xac9Lcwh4cummhe04GfhOxgVkVyDEApqWepJrhRd33Awe7mFowo7tQODWJmCIIkEL3Ea0atWhOYrfjX2UqBtHZriCUTr73uRq/uzR+qZHeBTrMM5ulpsb0a+K0NDqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501763; c=relaxed/simple;
	bh=eewxmgfHmCdoJSXXMgRzESdyPhOdYCe5chjx/EMYjxk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cPy3fgt8hArdpjrWckc8JpwCqOQC8IZv33O0WdvNex8MSA+90k9IgM9ACJh21hrEFehac36dIFvrVDx/WnKmwSyl6WArTRP7lij3iVnNCpVwnHNjUI76Fj56/8oqcHJHeobK7yxJXGEd1jXQFVK/oZXBs7deqF3RMwFSkOm/Ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVFcmG7P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVFcmG7P"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c8353d8d0so4303790a12.1
        for <linux-s390@vger.kernel.org>; Sat, 15 Jun 2024 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718501760; x=1719106560; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq96Rf9+3SaAN8Q2fFpUtHn84wg3Cq2hV46UyTATzaQ=;
        b=FVFcmG7PrKYyFhO7xql6aYgVK7piz7DkEIjxh05jQ8Y0C2akWyHgMMikUNjfVgjryV
         z+ljFMqJnauoOA2jf5GFaQRqvdGCumaAhKRBv/Wb4jl/lMNIZf5TgrqBdYqK+UtmKpiA
         wM0C3d+7klzZGk2YLjwukQVNiHxstx0DXzuFbjFdi/QFs8q2nP8eWdy+2wWCGYwGzcVu
         cnXD6bwF8goRviY8vhq3dDN6xNht8vG3TocwOr4LN3hRMDszH7+wge7vIn920bvvD4mn
         RZztMJecxcbpNublsomlD8GeDDWaRPLfwokeIkX5Dq1mBPBuT0UJRWeOxLZ3ERPjhA1z
         ltRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718501760; x=1719106560;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq96Rf9+3SaAN8Q2fFpUtHn84wg3Cq2hV46UyTATzaQ=;
        b=C1xOtYAkZareJkhi8+hUrue6kgfxfz+zMT33ojvZyPS1z9BThx5vgzCs3a6t/7XAly
         bU7XsmslDS0z1KI9oknp+zavWtvI46A0R1HcoUPBGvK2duwz++3ZENmCcUn5YyRf49Q/
         IOuJOoEx5rNZkbCdDhNp5ZlrbRUTd4nkkjufbDXni6zW/JP0BCvHauihr5d35Uy6Vho6
         GUCMXMI/wViB+dxw/HqTZ7t2V/XVqUX6r2GucRRP99f+aAMTx5JORz87Du1W5Ob+ZB8h
         HWNfpboOIsLu0I9K6q0dduKnOYN5qtVzBmZlbowN9fsS4UJte2+N5Y40Bp9dzCtDqlAt
         hs/A==
X-Gm-Message-State: AOJu0YxW9MH8QdJqWDOqbpeL9d9sYLUuaD89fNH4SYqv8/z3+xGPvG7r
	zvfURH+KZA012lZ9kWKUjs/kkKihoV8CVDj8I21nuLVpS7h80kBPRLh2d43Q5vw=
X-Google-Smtp-Source: AGHT+IH+6aWufJ6UlOo1msIz9ZpIvQp78Ti1Dc/pT5Fo42u/qllH30wvrpapVJvtDZMvAxFLSVrfLg==
X-Received: by 2002:a50:a69b:0:b0:57c:acf4:c6c5 with SMTP id 4fb4d7f45d1cf-57cbd67f735mr3674394a12.24.1718501760278;
        Sat, 15 Jun 2024 18:36:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439606sm4388843a12.90.2024.06.15.18.35.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jun 2024 18:35:59 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] s390/mm: get total ram pages from memblock
Date: Sun, 16 Jun 2024 01:35:37 +0000
Message-Id: <20240616013537.20338-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

On s390, zero page's size relies on total ram pages.

Since we plan to move the accounting into __free_pages_core(),
totalram_pages may not represent the total usable pages on system
at this point when defer_init is enabled.

We can get the total usable pages from memblock directly. The size maybe
not accurate due to the alignment, but enough for the calculation.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport (IBM) <rppt@kernel.org>
CC: David Hildenbrand <david@redhat.com>

---
Not tested on a machine, hope it is fine.
---
 arch/s390/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e769d2726f4e..d811ffa5e147 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -65,12 +65,13 @@ static void __init setup_zero_pages(void)
 	unsigned int order;
 	struct page *page;
 	int i;
+	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
 
 	/* Latest machines require a mapping granularity of 512KB */
 	order = 7;
 
 	/* Limit number of empty zero pages for small memory sizes */
-	while (order > 2 && (totalram_pages() >> 10) < (1UL << order))
+	while (order > 2 && (total_pages >> 10) < (1UL << order))
 		order--;
 
 	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-- 
2.34.1

