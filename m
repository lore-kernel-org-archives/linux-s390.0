Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988047ACE7;
	Fri,  7 Aug 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118102; cv=none; b=pmf+b2oL7ifALI66OldGrpmsWS6qqt2uEDug4IGUcQmYNwhG7oYK+XJDD8EC4coxWk33WRwn4DTOxHf30D31iySZM7x6FO6B/r/s8Y5PCN/8sCudU/sN6kYhAPfES8oU/sihcjMwDg8khnrJDj2baYqslJXpK9zQKJimnZ1SXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118102; c=relaxed/simple;
	bh=xTZIT72cy7ORrwfwatBkNzilRoI4e0e1BeFDd7DPE5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGG95pMJB5BADXju6ywbtEFEbIjjv1jqz7TmVGRco9V3bsqR+nokKeMILHuqI+gTnVgEkfkx+KWKZNuFSK/1w+31mkS5WI68tSlw8k+TECeU6dU5J9raMjF4/w2QiBgR35uX6n+StE5MzRi4x2p0gkM/9zdL9zZ+tS3IKLUfogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuIHmetm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuIHmetm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F1C1F00A3A;
	Fri,  7 Aug 2026 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118101;
	bh=c6zA2T4YXfwsdHoNQLbL/JyAvXh3qkO2k+ehgfnDE/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MuIHmetmub+VK1FGo+A9UmBhQfepI95uUeW4UfOYW/ptyAyUy/t96xh6HH1vAE/73
	 8e4/FhHnhytFYUlZG27iUUtGL+MtYro36oYbZ1KzernGOmHBYvm5DvpCOTtwZjsGRc
	 JaXVw9Xh6ODJ4vVnjVJUAOcKb1fUNM044TYgxQTLkvcOMzu1DTtuP4jLUVlvxQPrBz
	 LTRcbLUoAu+DBqE18XoVWIV8185djbKhs1j7xN3M62sCezj2/GQnkcwY+2GU0TXAOA
	 vpiut17alZeD7ktUOkiA7gYZo2Bgh0g3Ae3F8N17ngW/egLvb/lIpif0kQSTsxTs9T
	 FrnFKF0/po+Hg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:24 +0200
Subject: [PATCH v4 04/10] bitmap: Add bitmap_allocate() function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-4-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
In-Reply-To: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
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
 h=from:subject:message-id; bh=6mWNitHDPhlAiwoCi35Z6UVDAPmizX4WXMqdhhFXGJE=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/GqjkfBqa0m/uQVblFJkD45pC7oLSmL+n/h
 //sqaTyXrqJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xgAKCRDdI6zXfz6z
 obx8D/9jABBh3HqjC5A6IGDuCJwknLCrh/q4jDo7TiLDD/Cl77p3iET5sXHP39p2y8q/yO1cGnf
 sA0+BjzaTEDGF9euWc824Z0QEEvFI59P3rmGkiJSn70i/967s12OjQjR06JX3F5owiERgHBqyNQ
 o1d01OKlP8es7OImVIEfbKmx0n6/VCJXlFfy+QUhlCFvS+eIiFEKo8k0pb2+M954Wd38gWLRKtE
 OCVGAIWwJxZfVfp069wfgIwnHLsfTHlLGFTkmS9meXELnRbzArGITAuARfy2GgDtBhaksqfyZqM
 +7tjQ1ak6nFybAMGdwkPIGIALpwCQwxfVDHV6aLJATEFHxX0VRP3q5UTp8ERVjHGkK0MtBF9oJn
 SgEwj9C9qg39Fjp6E9Zqww+2BVKEK8wsFEr1c8l4Q4Bv4OQJR7rRMktO/B49+0/x/jMiYDvgMWR
 89X7aLiP8sf4HGfpz5rNwzL6P00X+fuo/sqKx1EgNTzX+XRRT7GMTHxgFqbB7iI9loGTUcVdOBL
 n7SxcR2lI7Mw7OVwabw0GKPqcJlwogaODQHzF78PJYOTY8fiyV/NE2XYyh+Ic+gr5vf6DEZeHZf
 soNO+hucYzTMTMQXYeuB5qyhtri1RASEjVuqAq/kNWLVLIxNx4WVtK4o1RPz4flFKftK7CxWCbJ
 IJjBjxmTONLk6BA==
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
2.54.0

