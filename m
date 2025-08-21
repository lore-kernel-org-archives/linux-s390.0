Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FE382395
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806948; cv=none; b=G82KrYkZeQp2y7ipqOv4MAhERgRuXSTPhSJlRIsnX0jkHC1as9+j01nxmeSAyUIq/zU6MGZVflPgr0GY7eOBIGUwLid0bhXyCCLVHTJvXfJOE0EIcoKw0AB4rIhSjH9RpOeg1Zy3ULhWXoIZNWFv9/jkBUvjfosyXDWsm/c0vFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806948; c=relaxed/simple;
	bh=vBZZGz0SB0V7Hvywd1N29mvuGT2dBN/lU5Bb9Xz8Q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF35uCbOcagWXoVSQMk6GPhoV6SwjWFY3QrwbZT7dEelzORvfmf6Q7bZSg2iOjym4Se+KjihqW9LW6QYxAz3+uDFaKKnfJ6x4bnbiGZc2jqLxvX4MYELxb4emKRmik5qZ4n77v/Ac5vshcWDcd4KSeVuR8vwyihplcHHjcjkrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5vZFh9y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5vZFh9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
	b=V5vZFh9yYb5Jfj9361Ie35xXZ+kHktM64VEFVJjixbl6dfO1LiwX3On81XCWmrx8swlmX3
	mIlwEcPFzRk3g9Jbz0HzKsnePoJ9zfbVuJmiGc2OIu95HCpVT3RlNUiIQGHNP5ulkyMLYL
	TPfTSTI1CNzeqcKEmU0t9twE6w8zsIU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-j8rPzJv4MmS2MJXrPEGJ8w-1; Thu, 21 Aug 2025 16:08:52 -0400
X-MC-Unique: j8rPzJv4MmS2MJXrPEGJ8w-1
X-Mimecast-MFC-AGG-ID: j8rPzJv4MmS2MJXrPEGJ8w_1755806926
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso6550505e9.3
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806925; x=1756411725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
        b=IRSmaYvX7yKGfnc68yhafv7czPvleNvYbUH8pYSUcZjrhUmjPG5KKY+fonb/PnPLSJ
         567f+TYlvt8Whe7iYM33+gXRj8phM4HALcRO0CXq1NZ00fzwNtBttmHRpQiCaNEzRM1y
         iNKoyvz53OXhEHP/4QGpdZNT++cK+HCtKkE/vySXEc4ji1h/KbeQueurQvOJc9fiycEY
         8ZozLkxJZspYiYutpQeE1cEQS31g1aVn0GuM4vL3uJ1hzFnzdzKys4Ztsj8fxnK5zyHq
         /yefPV7J8b3+7aiMly6WxvyYHQUGfWTlcgkPX1hNRPgnaIUpv66x4N1OzKUsrVcOqyiz
         n9PA==
X-Forwarded-Encrypted: i=1; AJvYcCVhdFU4nqP5CSFLwKBQ1vf6daA0iLzmutswRlrqNzbz2SoHVTQyP6U6vjDboWre2P4R3k4S8yAXzCbv@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOmAYjESP2KmGJ0pwflCUUZ9WC5uUavz1P+iMI2+WQFsmYdP8
	zdTzLRZ5o4GakwLcugaJtRkQIp1lPw6JNa5jZ1iHvK9HFvYB2x6h+6UJ2JpA7PIC1ZXrEc9oX2g
	tqklYGHvB920jn3H3UcIpUdpgx7SrbwFgSQGReHcjxK1E9zGVD0S9srgCtCCqdA0=
X-Gm-Gg: ASbGncv15MscK0lWUOvoYiuEs+E1ei4lIv+mpL0uH5yXCnWfLFdD8fH9cdrJG0Mg3vp
	MdSYttHhK7Xi9y09f1xzP1mybq+F6kYgoy/qYn1gb4C6VgtlDl7fOQF2O4Nj4h13pKaVN/p6cR3
	JG36SSKQCEFsfZz1kcMns+/cBpR25c/PtakTBRehjakXIGvaV6bSUhQrPPyV2ru1lyNH/Wfm/qx
	XmJF8orhqeMT0CGnxhQb4W+erUR/ikNgg4sTCLIJPYySMZayV8Imh4yvDKg1CvHvYPzhISRjtKU
	+AulBxTUCpc99ApwdEaNltTiCbjft1xWXU/7WCmF3dKZaNMiR4B4zuKX+d34F2GAHXEO1Ap9AhT
	IzCQr4BEl99R73hyykOBQog==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774415e9.16.1755806925535;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDDv+I9AWZPVyKVFD2prHDmQqsK3mzEWwP5yNf0oRJXtHjmqgi3hMC3hwAmszm5rTAtK85Rg==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774035e9.16.1755806925116;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e0a479sm8895255e9.21.2025.08.21.13.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 35/35] mm: remove nth_page()
Date: Thu, 21 Aug 2025 22:07:01 +0200
Message-ID: <20250821200701.1329277-36-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all users are gone, let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h                   | 2 --
 tools/testing/scatterlist/linux/mm.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f59ad1f9fc792..3ded0db8322f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,9 +210,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
-#define nth_page(page,n) ((page) + (n))
 static inline bool page_range_contiguous(const struct page *page,
 		unsigned long nr_pages)
 {
diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 5bd9e6e806254..121ae78d6e885 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -51,7 +51,6 @@ static inline unsigned long page_to_phys(struct page *page)
 
 #define page_to_pfn(page) ((unsigned long)(page) / PAGE_SIZE)
 #define pfn_to_page(pfn) (void *)((pfn) * PAGE_SIZE)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 #define __min(t1, t2, min1, min2, x, y) ({              \
 	t1 min1 = (x);                                  \
-- 
2.50.1

