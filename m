Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1E47A892;
	Fri,  4 Sep 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518735; cv=none; b=PqSlHSvwcqt3CCMgGz3zaQykbNIJIrUFCcPAkssHWhXS+MWGXWH/RG5ABlzXihmYLeLNvKJwljR/Gh/Pyq8vF9Kxajn1TwCglhAkDF+H8LH8iyOddfFvLA18328pVe0ae+NKnCqT34qTFYgRvvf2NwGQ7wXLNkvPzxijElMCPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518735; c=relaxed/simple;
	bh=oJmc2yMjXHZBAgsG3MI/UFS/Acfo/2sOqteRP01Z7dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TM5TaUuHFREHUHMZrR3osZU1gls9PhG4a9tTEJu5A1TYdwvUPUPcp5+RQZCIjY6eQIYKX1YahoIDAGxSykQZViMg0ueMHCq6h2utg7z6fEteo/BvI1Ia1XuiYg1IBSZFWFxCQnnMIh/4zIQqTNmA6dEcM7bMDxwFQFTY+AKUDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isV2IgZu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isV2IgZu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACE11F00A3F;
	Fri,  4 Sep 2026 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518732;
	bh=tvyd01m5FmUtu3q6l/t0/X1UQi3FbzSuZHwJCHFz3QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=isV2IgZuqaEj8L6w5TATquMIISnjgvRvBLrttVMb2J3/qELjt9chFPiUY34MdPhYP
	 U28wPbZT8ogHrGtyUr5RJLQSczYHZExyBqdqMTuDI4gEZeqEhLhF7nUfxbbgN5LSLg
	 WpGf0U5aqCH3nfFsuGuAY5TAdMaRGNYw4DPjF1ZLmFN3bIn6UXfe4cqWr+MNfTnNvu
	 S6KbiqTp0Jv0ibjBYHeuTnW7BAKozymnTvHSpJwEHw8uX/NLpZSTc44eFq0eoqawMc
	 D9BkZU83noFXqptzh6Me0L7ADkDCNvLNKqKkWO6JZ37eeSuyw+i+hWbz0qXVlN6AGu
	 3HNhAB4yeUGRQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:56 +0200
Subject: [PATCH v6 05/12] bitmap: Add bitmap_allocate() function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-5-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
In-Reply-To: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
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
 Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=treding@nvidia.com;
 h=from:subject:message-id; bh=wRtcGoPPtBVnuqzylzx/Ya02XdoWLRjgy09wPiiWfTU=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6FB7y46zRAFj+W91sU31vLRZ9vxOWfwPV5
 Zl4kuw26HOJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 oeAMEACJJndPxZkKMt6p/5hvrc40QBNDQZ+kF6WmhtnFd/6EVpvs0pjUb8O3if3mkq4TtTKowKz
 kIuYwA01ot+/ztJA5scT5H/tCqLx/Qds237aUUTv/IzEoq2K4YW/FlTvmXelPijG5HS9T+GeFXV
 RxODMakq1BUp1WBx0Fvx3tiI40Ukv9zyhQFgNYpIld1ACRlTawrq/ce0NYFwF5wGFaPKkbsEIO3
 SOwvT5W5s5BuxLJknJq4AaldPvitW5S1LIvagCvP3/wQcvXSXufgOm2MlU3JOi4viyWwRu/L2+C
 u50xLPvsNEVbWot1lKc75AvkNCcJCtowBhIl8x4HKN+ilKWv8A3go2jvHFSqTIOLCbJmV1DCO5F
 RTJIpj0JWZPUkl6xqHfiWzgFvJJTmV/So6PtCwG/dbYDI5ngKGDvuEB0RCu4aOfMpiQuiyRs18f
 SN4t3ERyRKbWzjXimIPHFupQdwDQVNb/5niYY7HikDSTPJCaZTf0B+qjNaNhchJg+AbXBtp+LWN
 P1a8VilssiEkbeQ8/uw8IMefrUeaSKo9DQyKqMeWYyGE7jWqGUaTQxkTCPSmW+oxhEOq+xpjKac
 +RjQa8xpetUONC0UCwaBtDLZywDwGF1t7Itd05IGfD+dCnNPAW/gg0w+Wz2AIRM2lKYSNKwYNJx
 MloyP4fy9QyiMYw==
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

