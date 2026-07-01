Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF4494A0E;
	Wed,  1 Jul 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922136; cv=none; b=E3xrlr2S1AWjoaSEbTBdk2hqeUMkWAsv4kvcx9Qp7XYIp4C0c9ICkytoa9j/rsBkQWWFveUpgmRU8+iev+l3BLju+QC59Xtbe0EYJub4qN1jg6xybGEHPHe4Lw0aC91F5gOlFAltXQN0+uwumikahnR7AZsAQYCkBPQF5yauxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922136; c=relaxed/simple;
	bh=MEXaOUWaqMZh9V0LF993CdNLsqi4tDh/x04Cf5KElnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2SKFNzdZjcd7+8MebblN/SvSJE/tP3m2pSjjKGSdF5WxsyjKxytiCFUxJLey2Rab6cWVpgZc2dSfsgP+bfmifdCGdPLQMxh8HG4wEe/oSPC7YBLDyN0bE+FR9wyOvRP3CX66GHJi2T/Bj00FjMqMqosRgCapC8xeGDCEnxapyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNYKF6zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNYKF6zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B171F000E9;
	Wed,  1 Jul 2026 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922135;
	bh=Bv2mbusdTvV92u03LkLsnqd7ImB7l/m5WEfHrMjrMas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SNYKF6zxBSGYmAbusApOFFCWL6uuUs7pq21mB+LUSsno6qF0/nSaTI6zYzlqtNAJr
	 ZeoEH9Nt1QdK1ka8A8IPKNNTtdogOL5guN4e9X5Iq9XQGF+LfhVtQDo3DE1If4LtHV
	 dsdyLAQfXp0H++qlkxogtml72/gCJ9hzPymFLFTpF5dVYcgiFKtPNkgdlVn997r71d
	 A7syKbp0Bz+to+n93Qbjcgsl/GNMlv5wXyQHfyO7pdnzVnTb/EUvzLxLzIo3ygEPIm
	 iLnFY/gkqNNMpaWrlxkib0XaThC79et+ZcfBJIm8f8M0/ezBxGE9aFACoRniIT0WYc
	 4ekBB8GISLNSw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 01 Jul 2026 18:08:16 +0200
Subject: [PATCH v3 05/11] bitmap: Add bitmap_allocate() function
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-tegra-vpr-v3-5-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
In-Reply-To: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=treding@nvidia.com;
 h=from:subject:message-id; bh=DGBpv2lJgXf+7uFQCQC0wiy13z2JKXDNp8H/H8fGu1M=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqRTuFau1YcqnQD2R1zcsMxdp2c/3VaTKjhCkvY
 IESBd2vNyKJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCakU7hQAKCRDdI6zXfz6z
 oa0JEACzF7v7uihOjhMHBe5Jyz6Q2xPJdUiI8nSwpJ1qTuDnpYhGEg57sn6hJthxEOVFSqy+9xC
 aJiUzj9sSDpEZcNC9b3yysvyM+MEsFUldBvNkaD/9DBzJShfzXdfRhDBVdzzd35ov9szxi4Qlby
 Dybso/w7L4uaO8o+hUivrNLWb2vRu00g+oLjNRJZqiJVsw6MWeWYP5Sovk0XPl7ZJZ6pXCs0uSz
 vJjSrHTAZ3S5I1Ilr86LUB4r5OVtnoLaswv3mHFoq9o9H70HXdV8g9SYbV1rkpGoyoLKjDpTVUo
 EtB5qCMFGGDPcSAgHGMImuXAigAOEmwuSA6DwGMY7BWkkY2x79/jvSC18Z3YgCjUNcXV0epfc9k
 KkcBK2ITzuaGuxkO3SWmm9473jXAb3BijmJFG7JLJpN6pMMIHrFpF0UOn5oOyuofQkZXU9R7++g
 okGECjKuyIUDcuVu2j+ch22XpYaTR9nmM2QTX6SR1tzQBLUDTjrUFmLdRcChjdPnsJD4MUIHA9c
 yfkgIsuSY3yYvIEaHlbWbj2A9B+rIdn5ROhfXnqreH1HiNthbMS3E8M5s9aeUgJAz1P8wTNij7E
 rH8B/EoeVBajcIixSYvzs9WVg64E3OW4ZB0cku6fUKvn07U9vXCs7mO5D6vZ6ARKOfeJncKEntY
 TtjrxqyrEmq4DDw==
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
index 8854acf77869..fb0aec4b17a1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -721,10 +721,10 @@ void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
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
@@ -732,16 +732,31 @@ void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
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

