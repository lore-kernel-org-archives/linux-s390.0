Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD4137CCA5
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806914; cv=none; b=IjNnAFrTs/iqMKOcoxW5NYEOLmpSXkQaw4FI0kMdh6Qk+JHPb+AxWWVpHnyIJyCA2Yy981hgBix/+0Fp5wT1HKrWOJy5gstwdyuNvE5mdOOjdnlWqP2vnEMmjbr6V0cfKPABmo5LeMR9D7VwnMha3pq/nKJc1f7yZ9mabuc8w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806914; c=relaxed/simple;
	bh=o0B/aIsMAhafmNCelOfWp+ALdEBw0Dyti3dxNNba1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNECOHxkMtTrYfBdv6I/xXyS+Ap5VBqIQ3He6xf5Jip1K+Y7Fk++6KiTielf5aOVvVb4AgecL4ZhPBD/SM9youms69nhUF5wGQR57nIIF5ak7HzNYfcyKWVsb3aBMyp0Il00q3R31pFPYdPOO2rrZ5J0DBjPn3cyP5qRquu1rbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ez15zeTT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ez15zeTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
	b=Ez15zeTTSoQ7LtmjnTiLG9pQHXOTnPbEhkmb6bsxXkTzpFERwB57E4nPpa1LbfRSmHkoeU
	AdnTTe1Ax7VgR6ue8oigJqZU+yszoAo/BybgP0IQjYjZ4mpFw5Rj6emA/4VJzQY/Ap9Ai+
	m4ruHqFDS0YUSIEfVDJwvfkX1IMzkAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-kQRmlf04M9aha1ifUIgZBQ-1; Thu, 21 Aug 2025 16:08:20 -0400
X-MC-Unique: kQRmlf04M9aha1ifUIgZBQ-1
X-Mimecast-MFC-AGG-ID: kQRmlf04M9aha1ifUIgZBQ_1755806895
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc56225aso832774f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806894; x=1756411694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
        b=gBRetjP4phNf9dkbZAiUszUMwkngTqNJw+fPKpylghwo12v0Bc5yE9neln+fhFHCqV
         Y0yQDOdxG1bcujJfKqllLekHE1mpkftSO2jjiZygDkQS1tM4kF8JlNWDtIOYNK5Wl5C9
         uNfkuqnS4LftnsU66fuvaKTda4sW0JE+jdiql5A3EUZz89zWXxxX7wD9Cq9WeBlUuhxH
         68sD7nPD8MpAHWvvOZOLuD7HUXrVEMG3swyKOOZvpOVIN0M0w0DXu/Nlvj50nhPlFM3E
         7SUfW3gcUg6y4tM0LCUdFops71mZXyExvQDuGm/XPUR3sgCSGJojcOz57zql6bFH0tW9
         tozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyVSlGa/5HUjlyzsiL6C6UG+VXWmlVUVS9vczFTBvU5TdTtasSNWMD5Gr2LfwH5Q3BCIQrBerZsD9w@vger.kernel.org
X-Gm-Message-State: AOJu0YxySIddwXC2AAJhKrfuO+31/AuM/uaSqyX0+kyV5xCrxwnd8coo
	QaPtkWwMq6xQmDfrBC2k6YhoCEJyf144G7P5+AS31Zdki5/or+YJVqYsHwUJUPXH4IQv7uATx9H
	Xj+MpE4Fudb+eAWbRM218/mIuYSFQ8XA4lLw4ypN3lznXvlcOiM6phlOMJvwY2MY=
X-Gm-Gg: ASbGncvLAqHG60pfWzliHA75gt1RKdEk72agjjIo3wDFlYPsQxUN9t4ARZT0mDqxEOF
	C72sEta1J+wMCJ/IsoFEseYX4mYbU3EuQi265wl6j7KGO2cA5J53JszB4Bv1XDJxZTRYjEDUDBV
	OoKPBOtIWiF4kq4gxE0GunRlqgRFyUYj3eyNxjbUrJAI6xqap57AfUXyHegaf8P5uy0SjL1JM50
	IibRjKZxOa2Bhdaz9nTU8CJuTz+pBh/Q5VnxqFk6gEmzPq5ZMoYZ02JhXK6n6mj2xqGBnYwb2pm
	KhLwejwGV1FJx5BTL0Aqr7DVnWGoBQVy9dr1QZ1wY9CJX5Oi+yd7tkcDsZXGAsRncDc8NJHuI3B
	+WQ6FEI5rstFFoo6aDqSZVw==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215853f8f.44.1755806894499;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrE9N2OTZOZSEOVxEUY9xhX4UsF8UOhI+5wOqBRpd/3VSIxUjVMLdiea20BiXkc+w3FSZ8A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215789f8f.44.1755806894010;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074e38d65sm12982954f8f.27.2025.08.21.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
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
Subject: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:50 +0200
Message-ID: <20250821200701.1329277-25-david@redhat.com>
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

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/ata/libata-sff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7fc407255eb46..9f5d0f9f6d686 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	offset = qc->cursg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SHIFT;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
@@ -631,7 +631,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
+		ata_pio_xfer(qc, page + 1, 0, count - split_len);
 	} else {
 		ata_pio_xfer(qc, page, offset, count);
 	}
@@ -751,7 +751,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	offset = sg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SIZE;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
-- 
2.50.1

