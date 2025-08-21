Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4C350D7E
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806906; cv=none; b=emFmw0QzmI/AcjeBGJy7wV5p9wRxWlkayxWmZ4CWTcbI9E9djNt1OBTBtLmNjYVzukoL8tHOfUbHw3KtJN/pJIbADI0YfQILEfvWAgGL2LhUaKnBPqWVCB6DgEXOcHH2rOFXi8m9rpmmaKQoyVKkhZxGSFHRGnSlg6Ut2kdfOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806906; c=relaxed/simple;
	bh=sP22NtXAK7RUwr0f+hWxIzaLt9EECIyrZ2EEKfR5Am4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/lUuxtPTRNdvT2o5N09yWOfs4br44byvRKxrTzDrPGzfZOQydJVIR4ourpp115SCTgYVFghdfG/ON4VHhRSVoEY6H7T+laAUt2ZoGULLvRwtWqjXLYPoCXC9o2KuyuhqUIhbH6eQ95pa7uHOBASDynq9Ls/5hSlh1qG/7MRvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7SCpvim; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7SCpvim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
	b=A7SCpvimcYLbxvTibcC3xaGvdVne9fEmjkQbv2yKcbYyPftBJ0FWfyByehxUmY8cF+Hv0l
	x6XUeKOvzQkgI8AGfetxHSQO74S4rXVJVQp7VSd+zdQG2vByoNBIKs1MOlWFSKJrkPnEq3
	sZU9HSFYVvjH9teeLmehrN0tKSbKLNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-tt10ijZNMeecdn6n8uMHGg-1; Thu, 21 Aug 2025 16:08:21 -0400
X-MC-Unique: tt10ijZNMeecdn6n8uMHGg-1
X-Mimecast-MFC-AGG-ID: tt10ijZNMeecdn6n8uMHGg_1755806900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8382835e9.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806900; x=1756411700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
        b=AeCBBh6dOCBBR44asLhqUSc0VhQQ411DByoDMIQTTCgeDZiJ8DQMSIH4ON0okwmSr+
         MNuogUnmux9FhriZAzsVUbXKRM2uzIrhMB8WJ8ewkX0sViTLnFSOGrb6gdzj6IiayvsN
         RXnaYL3fBNxEUqZ5xAqBgDdrCcsatiS2u79EgKyG+/2PpXymb55fJ4AGYqHsMVeSj2RY
         6vw+XlGkLvp9G6Z8la+NMZFiQHAhvD/9XNe3xWGHKHRRsNJF7ks+wpgKta4jRL2eVKyB
         5URZsBJAyaUAqh6IG20ufuDJUquDjs9s1iDIOtoJEL+QPT9WjcERg0UEaXb9wAZEdPNo
         LqHg==
X-Forwarded-Encrypted: i=1; AJvYcCWFTVkpGsTLy85Gi2cqGVKlPL7bNjqQXLRiXUB4TmY8duFqZg63x8x2P3v18OZ1hvSoN4YyqjI6Zx3B@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqw+v3EcPMfEyvA2TW+gPxIqYFayAIrJw2CSlxOyCFiXfghL9f
	5gD1VWnaplARDS+qIyDyUp5jtRFJSsr8p2xkw1LShmm77sVA9QQCeHXomh3e8UEWzmJHXe0JdoU
	oegle9Hxlh1JP1JUdTW/5UquIyQmbm2eKqRrElvZ/89Rru4NjlnmzldsRYLGk62I=
X-Gm-Gg: ASbGncttBJjlAdT+iZFwM8AthKhaOCBeq6vryRifqfSv4jmzhXA7ZBw5YC5qAmDGHzL
	hJNBSrWj1L9fG08w3OAkoU+tGj7oAKL5W4qAWQuECTU5xRdF2iYNIifK2UumbLDgis9uC/4NBvl
	Wt4xORlceImUBYrJV5bqDMX4ohjpeJljfvBoOKL4+G9Zp6NXPuzMhsImcCIdmU1qOCaLJX2EJ4v
	xBRGbjGCoEr7CLpsDH4zY+UbT+5sL9jV/EzkbLe6LN/i/rksvf2ogHYu8ptTD83fzpW67TTNBvm
	gIFzP1IlWNydxS3YkMWWxOPvIPPOgxtktNWUxVNDEg3YCSdQbvqNF32gr+bsrK1EJ1q1FAeREaL
	vZdDTAW1X7v4EQHzpeEa1Pg==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr510225e9.2.1755806900278;
        Thu, 21 Aug 2025 13:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpV2b3uhR/IYbmrTMgtg0gx1wkF4+JdBDenNBBSMhYf9nynPUCNMa8PTADPxo4/liFiw6TqA==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr509915e9.2.1755806899756;
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487986fsm13999227f8f.1.2025.08.21.13.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: [PATCH RFC 26/35] mspro_block: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:52 +0200
Message-ID: <20250821200701.1329277-27-david@redhat.com>
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

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c9853d887d282..985cfca3f6944 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -560,8 +560,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
 		t_offset += msb->current_page * msb->page_size;
 
 		sg_set_page(&t_sg,
-			    nth_page(sg_page(&(msb->req_sg[msb->current_seg])),
-				     t_offset >> PAGE_SHIFT),
+			    sg_page(&(msb->req_sg[msb->current_seg])) + t_offset / PAGE_SIZE,
 			    msb->page_size, offset_in_page(t_offset));
 
 		memstick_init_req_sg(*mrq, msb->data_dir == READ
-- 
2.50.1

