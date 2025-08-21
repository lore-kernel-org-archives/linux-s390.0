Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5C371E9F
	for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806903; cv=none; b=kzACLxhkTrnVNF5pyrItoN2nJJP/Kp5uecdlY9pcikLIUHqxGu8rgGw3YKoRB4jKgYmi1tVBpNMmNwZib5hBAdScRcOWYHGybQkkezxyHI7XJkiXQGlFJcFg+gBCnG5ggkPnAk9XbfL/PE4tF1FInPC3zw9mA6496Ikgjb5njss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806903; c=relaxed/simple;
	bh=r9aVOOwiYkYkJ2XxN3c4oDiixJCUuv2T31t2h3Fc0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK2ZqzQQ6QZbEpM+0KlnxEcnvr25oFxmRwgGW8E6A68k9neWY7OiKAAXtN0V0nXF8uWo9LNJevz4PzdhQeSDHSM65aQ1va+6k/YKG0bfaasoGNxRYrP+5Cnl3jsvIZahS8eY1l0QvwuTXTvRwYWVhAD4kPXY0YB/VEy1hNVtsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9QEUCIo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9QEUCIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
	b=N9QEUCIogiC101Gz+YwJ7Z7m5vi+HHY9IpUIgjXUtBM7syDWqUJa+AJfAQ5H2r2M43Eqmy
	7X1YutAKrYObOYmfElxD2g4NzUtgx8+zzkvc1/UqT6BaZVtJ8gutIyh8VpIRMsMB4esQTN
	UV0e/P2IDG3ZWLOKyQ10zRNdeldVxNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0KsMNmY0OnCalmz2K2P9OQ-1; Thu, 21 Aug 2025 16:08:18 -0400
X-MC-Unique: 0KsMNmY0OnCalmz2K2P9OQ-1
X-Mimecast-MFC-AGG-ID: 0KsMNmY0OnCalmz2K2P9OQ_1755806898
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b51411839so824305e9.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 13:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806897; x=1756411697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
        b=JwPG2eukhTNdUoI4XSv0Je+ZP/DzoCsWvAW9X9ZgGg+2PTPy+0fYnqDVIJGbO+ZF7t
         tzFGNO0m8di6JoHo36YvbgcQzRQig1/GkQ/R/BHsW2Jq+cFYESqHUQww18ddqZ7DxnjS
         ez2S/hJvWiBzchltYPGeRlhB549EYR01qlx4JmU+csQr2uQrMJ/TRNCLuG9Y7zSPUaOb
         OKlcm5cxDGTz228iO4HSJdqefEw5F4x63i+bvdITgDAx8zRpSgh/XZMFaFLTP+U2FHBu
         N70wD8tnUiiivqdG5mlvTPnZ4O7iwhRSjOMvRqoRoFD6xVWQFV2n3o5L6Bz2Br0n7G7Y
         UgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcg+I2NsvJP/RudJD/k4mhhSEq53dMdTVwoFO+zHdPSv6SbR4GK0Y98+dEq3cjvFXK7UpEjy1ZgHfu@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrT7Wh1ajWTolVo0XUQvxntezxyIPVWIn+I9Cz9cjLhbAFCzU
	9Lz8u+rTnUTzqQBQI0qrB7BfWk7t69VPPdhcZWhMyz37OjlEAdVjNe2xi8IwFGkgPjxHl2lJk2n
	boPqCd6FNajcg2nVkYElD9vHDTqmntMhpoddGlKy6OVkV2NjuNh81zZgYJyPmrU4=
X-Gm-Gg: ASbGncteZzKTYaHEnP9wnP8vVcbtP6QrgEUxVyMMGeJIPQtTMgVPo/jRUhINq0RUyei
	N5W6Fnzlig6aJTsgpL7tfleeopQfTiV57aYXTOxS0rav68dIjy1A8Xd7FDeVBwfGkBgPnGLDC0B
	e9k8rLRuis5esDANGohtkDd2R5QaSBZaOqd7nSeS8PyNVZljrpBb7avJbLg4WSJUAGuVbvJnqGd
	nlfS/CLC4DYee/v0qEkIebEWLzZyBGsKaZ5yG2BsCiWZKttaA3+F1NqLXbn+Hq6gHVuCKehjoxb
	udJ/FrmIKzvmJk0qlURutp10EXfwFBiszJOf3C1UWpBao3yySow8rS6nrdMwxMLKyWR/bHa7A0C
	ye70jkCsPN8XOsX/pJQzBtg==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2506165e9.29.1755806897470;
        Thu, 21 Aug 2025 13:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPdYXvWWhsiYzUao4v8GSpApokx2tOJxTxGWaryOs6bj53AmOc+7o5w7P2pIRGnKU6jzi+ow==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2505625e9.29.1755806896948;
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a551sm8831035e9.19.2025.08.21.13.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
Subject: [PATCH RFC 25/35] drm/i915/gem: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:51 +0200
Message-ID: <20250821200701.1329277-26-david@redhat.com>
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

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index c16a57160b262..031d7acc16142 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -779,7 +779,7 @@ __i915_gem_object_get_page(struct drm_i915_gem_object *obj, pgoff_t n)
 	GEM_BUG_ON(!i915_gem_object_has_struct_page(obj));
 
 	sg = i915_gem_object_get_sg(obj, n, &offset);
-	return nth_page(sg_page(sg), offset);
+	return sg_page(sg) + offset;
 }
 
 /* Like i915_gem_object_get_page(), but mark the returned page dirty */
-- 
2.50.1

