Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24C37D5D7
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806917; cv=none; b=mqON5xF/8yyv2YgHjN/g/5ZleNBjrVTkCj9YoF9xKxSGtX8MKUXp62H0TMVcZwG4BI5FIJHgFOrXCbAXyNvWGT2Py287S8gMTfij+S3R+JUJIXZlqea6Nzkxy4rqbMjrtzjztuz6jQIIaPX6zEjiStA1uCoXutLW5+6kidwZ8Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806917; c=relaxed/simple;
	bh=u2IvbkeQqipan9xn1FH8uDngo5kbDeDcvQE423cldao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuZpuDq/6VrGgTnxX0ULNkFS+pNDbvTleNmwboHpGMOmwvf94hfZva0eRn+ht+TgfYCSQBBVuDgQvRMnTxBdT4eo++mf3FA0VIMaECc/hPLwngkKYoP3s9UHSPCmBO+wMElekZ2V4c5h3wCOjex7nzdo7eVxr2lnemhmiw1hQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqYvWK5q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqYvWK5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIthYg0x+2djveHghlw2Jb9wmVGYKVQz7R4ULrPQfiU=;
	b=VqYvWK5qZmXkaJ0F1/pgzyaayAzFxqzTdWnBMJq2kvu4XCkQceJGMMw7qdJQF13Hr1exbU
	TA6Px5JnIjusXe1/h0yQAgJj2VibRufsLFeExWsyrG0eMGdcMXe1n6wmGdT3eaPOzKNsWn
	eJIZ0QQlv2k0TuvkUzy1dkaRXwP2+zk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-lK_CTS-NOg-0huQ6UWUNSQ-1; Thu, 21 Aug 2025 16:08:33 -0400
X-MC-Unique: lK_CTS-NOg-0huQ6UWUNSQ-1
X-Mimecast-MFC-AGG-ID: lK_CTS-NOg-0huQ6UWUNSQ_1755806912
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so8656905e9.3
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806912; x=1756411712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIthYg0x+2djveHghlw2Jb9wmVGYKVQz7R4ULrPQfiU=;
        b=ECRgb/xW6X+lCa3NdNP/c+vPmb8mqND8NtNUKkBSM0y3p11yFZJDYIKYJia1+IFBkM
         p2x/byTcxX4QLQZGQ8CCwXwMHirP0GJBZuVvnec26X0I3edW+32bXFBmHS8HG0QHq8PZ
         llaip3oC0ATI2KHAY/lz5L/YJ2CTNKqP/3D+obaSBCkPiH68ErrBLmLwKPJ5l5pnKdVL
         LmDCFWdqJq2qch7/jxffZ1VZVS/cp+rGcoC4pTiFEBBZhc280L2m60F7GdrBP/SVaVre
         BNdbUCzUbnk8cE0zapmPBFjgoPJ0i+z6roN0mBZcNNEpeSoa8iH891hFZh8i/HMm0UlP
         8F6w==
X-Forwarded-Encrypted: i=1; AJvYcCV8nKTYOrJFU9/J9zi/yNT92RdFkQEQn23sHZ7k+ZY78/uESvbbyKTgV2jweGCDmP7zXnyCZQayewWp@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnGEh63DRlwDbnfQb+1T2R/aKacZqszHmVEn0brvqfIqKijsE
	Uz6y2QqJP6E7itXASuKjNmtFmsxjyWMOqbS+QnjV7XtUrF5NZ1mVK5AHiMBsfuM2Gh+LCoFAF30
	F96Mpm/jyxdCzEo6/dNaLbVvk0iyo7lGAvvz6z0pXVpquCALR7wsZAwAsaBQyNhY=
X-Gm-Gg: ASbGncsmyEEDwXsLJ7G3RJujbe8HVXB/xAborXyhLy4/Rq2kMUn931i051J4Htf35Lx
	SAXRyphx50Ytr/oxj3BJK57dvLqOuc06TUX/z5TEtdvp4tpZA/2XFLzfCaakW7gbIwfmfE1yyFc
	yq2BacPhmuRfZTLbAvK6XOZSBDpONNA1uTiMlBaaUkzgYP1KC3UBt/bAj+0lhtG/S6avyiklOyB
	W15JrTzbkeeWIp5/DJCdJA0K986t99xVRCWUzhOsxG5n5YhB6FwLnJeHF/jkhJSrwpo3mPf68B0
	LRr3UpEa37Wx87Fi9QVsROn4yOkJ9e2nL90WHh7H7gJmttVt9DTLcM2TNSM6a8CTeunxP4N6nR5
	idPmTYr2Gv7zCiKLARBQh1Q==
X-Received: by 2002:a05:6000:40de:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c5dcefee22mr195275f8f.59.1755806912317;
        Thu, 21 Aug 2025 13:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRe/VOMg0cdir08bDTWMwU06A85Ixelypa7wMbtHpunFYS8URS38ofNnAO5nDnYJmoWLlWSQ==
X-Received: by 2002:a05:6000:40de:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c5dcefee22mr195231f8f.59.1755806911819;
        Thu, 21 Aug 2025 13:08:31 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50f16eb1sm7598185e9.3.2025.08.21.13.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:31 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Subject: [PATCH RFC 30/35] vfio/pci: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:56 +0200
Message-ID: <20250821200701.1329277-31-david@redhat.com>
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

Cc: Brett Creeley <brett.creeley@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/vfio/pci/pds/lm.c         | 3 +--
 drivers/vfio/pci/virtio/migrate.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
index f2673d395236a..4d70c833fa32e 100644
--- a/drivers/vfio/pci/pds/lm.c
+++ b/drivers/vfio/pci/pds/lm.c
@@ -151,8 +151,7 @@ static struct page *pds_vfio_get_file_page(struct pds_vfio_lm_file *lm_file,
 			lm_file->last_offset_sg = sg;
 			lm_file->sg_last_entry += i;
 			lm_file->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
+			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
 		}
 		cur_offset += sg->length;
 	}
diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index ba92bb4e9af94..7dd0ac866461d 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -53,8 +53,7 @@ virtiovf_get_migration_page(struct virtiovf_data_buffer *buf,
 			buf->last_offset_sg = sg;
 			buf->sg_last_entry += i;
 			buf->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
+			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
 		}
 		cur_offset += sg->length;
 	}
-- 
2.50.1

