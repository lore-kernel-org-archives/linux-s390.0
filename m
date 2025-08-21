Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBD35CEA7
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806876; cv=none; b=FtAODP6iJCTVO235kTfPKJ/Oiyyp966W+aicKzoTVbRyafkTgLIYGkdLZp30wQZ/Idk3YuCtoIvUa+yjsKo0CyKjobOUo93VRlBG148wSWboSWmtYgEITutVed4snISTY2om3Jj6Q55e+Y2gwujSxcnmmlPD3/DkiQawSS6DM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806876; c=relaxed/simple;
	bh=d4tmPeOlqOBXo+X4Tiv9h/CbkpHAugux1EiNuLc/Y0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQUINlcFJqmhlcg097ACVDBLv8jbz3/q3e5t8Mcng+aToEwgyODtX+VPAothOSv1YxrLkChmxPMchthDqoWPR1DMTMrUDnhpfDOFASIPWl4Qo8yO6jXFPSaHigQdHQXLS5fKcCSQmGFBBX9pgxS1n0HwXobmzFK0zt/b36WGnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io0VJ3oA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io0VJ3oA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
	b=io0VJ3oA84hURoo1bbxekgqpYqLKj1HHatcZTV9D7fGZ2ruSAC7a1OWMWtMn1V7qE3//Ot
	oAJz9RMQV2C5lC3olG4IVI/CdkEz6EH3MKsEEAYQeTI9qIj42EVD2bgSYqX7bhJ6b/Z/Nh
	6dGW9/oeGeYqwZuU+UZV90XNRFCIOH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-oLTv_IGEMGOFOEFjKty1-Q-1; Thu, 21 Aug 2025 16:07:50 -0400
X-MC-Unique: oLTv_IGEMGOFOEFjKty1-Q-1
X-Mimecast-MFC-AGG-ID: oLTv_IGEMGOFOEFjKty1-Q_1755806869
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4117542so631174f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806869; x=1756411669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
        b=uAnbi0ev2/SW0wbL/xV/1HLM6t5SFQ0/ZGT8yaN/X98xEPreJcUkc4FROrLOxl1WqK
         8GU32azTyKuZfKkTXfjyZ6//+XTttGCoH5INk3EbKi7DyxR2SQagd+CX5+05jxVmj4ue
         9hfMxfy7THcU+uSIH/cFIni+oohO86NUZ9UvBOPn+FTUKUKUItQz6ss/HG/K50C9R98H
         8RQdh2r7t4pyk3GafK+2QXcXqg8wI5R0pNd0tMLOOWQPukxKRK9MhFmJAclff4RDa7jY
         mOuwSvrLUjEJ7nIrqKk1ZsbStfxkT1y4xpEEnfMLsQEIGcHjsJM8M1ZQ8OyjKlRqScsV
         RFIw==
X-Forwarded-Encrypted: i=1; AJvYcCU19SrjLkkjit2ZoIWV5pI+c9VSm2u1P16JCBGm2ZBBsV/EmbbAoPc3vvGQaPZHZV+1/47BRs9lvWds@vger.kernel.org
X-Gm-Message-State: AOJu0YxzA3Bu24q+4NpBIq9s51TBIbuEpehKyjGeGiQGca4AUMXa1av3
	li0q6/Thc4zh7FMkh9gViB/NVqtWApcC0UUrkFNU91H0cFIapzkCNBqwDxxuXoEXpi9Mmt8a5Us
	SyOcO5Lz9/JPGMx/dEj5CSjI/7HEaU/eTF3NquvZqsR7AObV3DCTpbQqkXPzXNqbhsYDkh2ALGQ
	==
X-Gm-Gg: ASbGncsk7nbMKRqXy9klQbjaLxjEZb/qpjFnV16PGnKIbi6yxj7Jzaeum2jy5LCmlbq
	kKaPqEQMnJgFjL58EPb+LkdG2qwQ/Z1khwDGV/+INq5wgEgUcXRzL8gevRcTsptoyFLF8xuz/N6
	u5vfFoQv/+sViMGBkgI8+W4k/9JYHIP6WTLSHbXZTgQk7r6+Xnbl+B/WU1Eg8EceThoSqE/5npX
	I0jueT+Vq3ezZoUJ8J8rQkpOIyFcO6JSRd75EaBblKppbm09msyw4ieM2I2R8zZIUXL/q5noIWx
	tkhxizudbeTE5smu+EvJUMuSse7Rigc4Jna+EBJ0SE6x7sb60nzX0emWdQYke7dQPAXhcEgXAi6
	7wO4F4ECXYrWwCh6NRJsP9g==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167774f8f.59.1755806868868;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCm64ALptQrKyrLlaLt4xJ2vziBy3gZm4Q1WMVX6wnWhr2W2tRcHnZJHBwxpAOnTfL4mKx+A==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167760f8f.59.1755806868453;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5826751d5sm1323274f8f.14.2025.08.21.13.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
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
Subject: [PATCH RFC 15/35] fs: hugetlbfs: remove nth_page() usage within folio in adjust_range_hwpoison()
Date: Thu, 21 Aug 2025 22:06:41 +0200
Message-ID: <20250821200701.1329277-16-david@redhat.com>
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

The nth_page() is not really required anymore, so let's remove it.
While at it, cleanup and simplify the code a bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/hugetlbfs/inode.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 34d496a2b7de6..dc981509a7717 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -198,31 +198,22 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 		size_t bytes)
 {
-	struct page *page;
-	size_t n = 0;
-	size_t res = 0;
+	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	size_t n, safe_bytes;
 
-	/* First page to start the loop. */
-	page = folio_page(folio, offset / PAGE_SIZE);
 	offset %= PAGE_SIZE;
-	while (1) {
+	for (safe_bytes = 0; safe_bytes < bytes; safe_bytes += n) {
+
 		if (is_raw_hwpoison_page_in_hugepage(page))
 			break;
 
 		/* Safe to read n bytes without touching HWPOISON subpage. */
-		n = min(bytes, (size_t)PAGE_SIZE - offset);
-		res += n;
-		bytes -= n;
-		if (!bytes || !n)
-			break;
-		offset += n;
-		if (offset == PAGE_SIZE) {
-			page = nth_page(page, 1);
-			offset = 0;
-		}
+		n = min(bytes - safe_bytes, (size_t)PAGE_SIZE - offset);
+		offset = 0;
+		page++;
 	}
 
-	return res;
+	return safe_bytes;
 }
 
 /*
-- 
2.50.1

