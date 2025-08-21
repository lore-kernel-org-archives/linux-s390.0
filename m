Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16A313550
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806873; cv=none; b=Lh7X8sde5LLSgVxj2zMknlq22xoTPrOq8QnSxoSWfweLgUOkpPkfjGfNGT8TuQ7dtSVxIAuB6XnqmxbCLzo0ddt5GjdxPHzEuINjYQZdSryJd9lR4AM1vbFTdesEE8aO4qoW0+P4ZomzcxYMWwoMdqHdLqFmCkdhbrnx/JxQT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806873; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2PTEfnJ6ZU8485tkH3/yqy0dZh/WcbEG5aBnWszci9QqCi28LbhFX9A8LA6wl81HYspsWqI3e5Z0UGGFvnPnYOGjgEqjSPMLSDz04HpgWcEeexHwC+aYzCP/e5nyHwExQvjU7RtrKJ7pleZV1ZMWTlpYdWpUnUwRhKNf/+cjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQegWUNt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQegWUNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=bQegWUNtDMs5UIWTi66EHbfuIIa5+qKC9ZhLsRrB9Fe3tywG+NPTR3N3T8oW8JE3gyOvlc
	0cuFkah4boJL7Ei9wbFCRdzzv2JA46SSgX4nMefPLpN4ezoYIn/Av0Dt9geCi9Fmky85u9
	ra/HbnAWuQyLLd9JZMZS757ma2k49X0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-LkTXq3dAM2SvFk1ZBipXcA-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: LkTXq3dAM2SvFk1ZBipXcA-1
X-Mimecast-MFC-AGG-ID: LkTXq3dAM2SvFk1ZBipXcA_1755806850
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so9581955e9.2
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=YORR8RNbj8SfvyxqYAyYigzOiZfH5MDsqAyUGzQrqU6KbOXV7j4r4PH8dBjxqeBnFi
         SBR+DqJ8qIMTcHZ4esgi33kFKqc281ikqUBcxY37F6X3S0/rnDSzIy/oBBqdYIvAcvWC
         aLD2v63GK/qbBVT3ZRo5DNJz/77PZ8s3gymhqNCx69NRQTUHnjPU0UUsOTUVkejsmGUQ
         bZ1U+VfahTSMmkHsGHrNC64DuY5o/z5GTRpjUeQ3o1HubqQNsJVOrPqmNGgtUkuSTzLQ
         tDk8It94Zg4+IPak3dE68IBa9RpEgVjB4K6LNN4iHu8Zqmgt6XMS0xcHN8KeZtVJ9jzc
         MaHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkljYe9CV9F/SDcLnRXBns7LCoMgCU+P8WYl0zrSIjRQzxzu0Tlad9UGkxSNhOrqWN8rNlQ94tRMrT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MY4tvXkL2nuGkKorv7kSC+OtqeAthAk7d90sfRdYVpF1HXsw
	PHcNvwo2KJRdHzZLR9n1ppT/lNIblc12beqyffx9VmoEDPTVVkRO0a0NYJ9f14tlCU2m9JocXPz
	4AlAyWdEIj8ykLxXSJDfUQmDbta6N2iuxo4XFElMaeplh2grAezheiTYt3Wgookg=
X-Gm-Gg: ASbGncvX9ukiahu1Shc9+6pdzF7BWnN1GmEVd0N+wvLeptwpi/h+1QGHYPjVunC8N4O
	DnsLBjy6kWkxEwWSBZ8zO2h4eB4Iq0hMcPDoGVkt6samD0jYz8b26ulb6m2nniCYhoRVYA5Yqwb
	McuVdDSrDOJVHfoPjdUgZafaJgRGAIJU4azjnrz6/aKAb+ixueRtkPSd4Pv6ziAnITHJ3ZH3DV/
	S/eObGH0SCDyPXUOt5n7Nsz4AawT67e50LA418HGjahzkxRpNOJN8KrTaByqvo5vmXazRs3k7Bs
	QJGVUf+J+mzVhQBFwlhnoDfPmfDYcfYZOkw3bHLFlsRtkEebLYL6r6jPbgYdkKZPcm/FYKA6IwY
	nyuYqN8dQ6PhjTDXPRIFYdQ==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2956145e9.31.1755806850061;
        Thu, 21 Aug 2025 13:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
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
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
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

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1

