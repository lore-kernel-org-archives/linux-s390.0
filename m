Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156F481FCF;
	Fri, 14 Aug 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721385; cv=none; b=N0IBkykkG6pOLIYq3udPYImVuSI9fACfITLc1OxGg9JlWOJEtkaOnfbFy4QkOeh1SChpz/3dcQZD6M26r3AKSS8RDyIo7NM0j8WrNsLKN78g5A9rz0msHLPmvv+uDBaJ8wn5S+ergsOZ5K+neyEWh7csxiuwURvjRZMMHJV9SEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721385; c=relaxed/simple;
	bh=oJmc2yMjXHZBAgsG3MI/UFS/Acfo/2sOqteRP01Z7dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UruSQlbMikuyY27c3c42j5nzxIeaihZWqqgixtL86UpdaaA/6Se7iKvYjmLfKb3uFklzI7+Dxyqv/65Ou+p65uLG9Pi+/vurIUmhj+twjYM1U5O49jLQsl1eYi2GZPRhfVJ1IX4rofjm3F2FcbWhPxspet2M9u/FCkNTitHUjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8fMWOsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8fMWOsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC061F00A3A;
	Fri, 14 Aug 2026 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721383;
	bh=tvyd01m5FmUtu3q6l/t0/X1UQi3FbzSuZHwJCHFz3QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H8fMWOsQ2nY7rRYNXdC3Kxk3tP32Auay7NWiyJ65BNvLq38ZZSecEDKR36HmgNk7+
	 s3Z2rCk2cKe57LilC2o4MM4r9AMF1pxtXhXVntG0Y7DTuY4QHF6MUCMYnpIT3sNeCs
	 0U+jK63PneIHswJSFebrqfu0HdvP7pHlcGdZrXlYUQn6kUgvMdVEc6kb9nB1sd3p3I
	 uATLMVHvhtHrm6Z3HDjq1GXQZ0m/nqvNxNJC57soSA9lreXCC0LBBp1tHEywyqrlLb
	 NtWno1ofLqFfZl9KpPx7NGeFY5mLzpelryD8eu9n3eCqNhRiaR60wyRSRJKIIKQ5K9
	 qyZYSLHwIvD1w==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:12 +0200
Subject: [PATCH v5 04/10] bitmap: Add bitmap_allocate() function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-4-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
In-Reply-To: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=treding@nvidia.com;
 h=from:subject:message-id; bh=wRtcGoPPtBVnuqzylzx/Ya02XdoWLRjgy09wPiiWfTU=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRYn56w7dlp0eX7ejF+F4kvYppmzV/e3SCSG
 vxjhHD4yLWJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WAAKCRDdI6zXfz6z
 obboEAC10PUKwRv39HTc5k+g4sCaMv90YqNR/4He93iCJA/t3/bYB392GuvI40e9i2b+/THKgUv
 owyRKvDL45Y4tLql/kYzRamz9NA9LdbBSs+ALLU7UX6K0hB081zMAGWc60XL5xShzAbvzibh6LE
 Fcm9PIozUNxtcXlYkrNlXUMOFJLN8mURsKvTmSFouWuQz4JpOLeCnBlLu5kr+IRVKq5cdoINN/a
 Hzj2JnV698uLUjjhtSdJB4o3vQePF6pdPbqW4OP7luNAhDEoTa9CATJYbSxPZZ5ANeliBOT9wor
 JbX5uyBlr1UDan0Y4nFQrXn1fYI3sRGT8uiHBnyBcJL5PQuGoXB1SCplKEPypB5tJ0DS1J6cCAq
 JQas5RDquiISPuJiUWJidJ4ziQT1a/yMHfDtZQF3aSwVJWMx64oD1pevUM3mhWEvkMxyaXG+VvN
 YJkx1v5lrMEpFxhFCjKEfg9eowCVBx82wk259dPU7bjlFrLrtb79fgN53JFj/cQ0Km50AOL1tm1
 26P/+JanmM3fSChpg06noCAj0hPxJuseICEeXumslr79YvJzC/24j36oU9o/y0EiyIBk9EDvjTV
 THzOJwt4mjTsP+pyu8XGptz4JPKzIveXxg+hFh09CEdbcj0Ad9lJdbj9DImFUv9p3LkDFqxBQC1
 XuMpNPPr6dO7P4g==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

This is similar to bitmap_allocate_region() but allows allocation of
non-power of two pages/bits.

While at it, reimplement bitmap_allocate_region() in terms of this new
helper to remove a sliver of code duplication.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/bitmap.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7df1573a409c..c2ab02985b5f 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -716,10 +716,10 @@ void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 }
 
 /**
- * bitmap_allocate_region - allocate bitmap region
+ * bitmap_allocate - allocate bitmap region
  *	@bitmap: array of unsigned longs corresponding to the bitmap
  *	@pos: beginning of bit region to allocate
- *	@order: region size (log base 2 of number of bits) to allocate
+ *	@len: number of bits to allocate
  *
  * Allocate (set bits in) a specified region of a bitmap.
  *
@@ -727,16 +727,31 @@ void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
  * free (not all bits were zero).
  */
 static __always_inline
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+int bitmap_allocate(unsigned long *bitmap, unsigned int pos, unsigned int len)
 {
-	unsigned int len = BIT(order);
-
 	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, len);
 	return 0;
 }
 
+/**
+ * bitmap_allocate_region - allocate bitmap region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to allocate
+ *	@order: region size (log base 2 of number of bits) to allocate
+ *
+ * Allocate (set bits in) a specified region of a bitmap.
+ *
+ * Returns: 0 on success, or %-EBUSY if specified region wasn't
+ * free (not all bits were zero).
+ */
+static __always_inline
+int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+{
+	return bitmap_allocate(bitmap, pos, BIT(order));
+}
+
 /**
  * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: array of unsigned longs corresponding to the bitmap

-- 
2.55.0

