Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266247FAFF;
	Fri,  7 Aug 2026 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118117; cv=none; b=tleyqTyfmS26hQHBNHQjKbAgX0aT4Vu2LP9WIpTsojWXGNdgBbSzd9hKnSv1yBnZsqV3SPhjP6nssgsJeAI6qri4LwoS7UTHSLJpZ7avFFcs1/UI2UfM4NhgG9QSNro55Ka0WNfxaAml2mrp0Duo0qJfuqy14Q1TThZEYU3tfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118117; c=relaxed/simple;
	bh=apMRM+02fvXP3cXPLgBBApuwmEOdbbW3qxTWZLpyMC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7ll0EgmrpcrjaD5aEDsrF4RQFFaiYeiwOP+UO5UMElDj+OftrGmTM34pPspMfomggDtvzWNYQZxJwlGjHoWJOEV9+ICT8asuu27o45uNINVC+9isDy8sVrhwgEIu90R/oMCZL3+XTa31tDVnNWT1/QUs/I7ORLwU3sRiu7DK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNrolTQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNrolTQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C951F00A3E;
	Fri,  7 Aug 2026 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118115;
	bh=KjPz5KwM66IHcFzGpdKpQJgkWaAK9L9PN1QCj6ca7gQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cNrolTQm1/q8IL28eVEOolVQMIRFnza+QcUGUVLy7nMEC/yyPDAK32Qh5K0RBKcyz
	 vj4RenmjDyzPA2c+xGTWludAszihdu83+QQ+qni8lzjjHK1shqUSdhz9MgOYs29uRA
	 a8odOqEpPaBmNLa/+N8kAs/t2lWPCQJzT0tichG1kNmR4En6qmz8eCY/uQRZBDDS6F
	 h+Hc9C5VthdRp2SjO4gk3zuf5svHPsrT8/eZsrAU8sdPc6dADX5+DyJ+xawITsFt8D
	 k80LyPf0g30sFLD2NLv4REAXsD1/FydGXxziLjboGoAkX3YOo2dwmsf9i5TkKCTx2S
	 WBQzd1qTcDFcQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:29 +0200
Subject: [PATCH v4 09/10] arm64: tegra: Hook up VPR to host1x
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-9-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=treding@nvidia.com;
 h=from:subject:message-id; bh=SIlRPF7qu85T+f5aFGG9WDkYzCh0TW4FAKVAomtiir0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/H6GNQlJYOHGN/qoBdCS0jUkzXd4Vk6jQ2h
 JTmD3cBCLSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xwAKCRDdI6zXfz6z
 oWzMEACIqA/jqNSmmZn/+8D+rbaLVylaNfVjA7uZNJ57u1sidQXKebOXtVoyQn/K+mkeIrhc18N
 O+MFVibwolAWA6T/YnMm1JQH2bxX4ZTFMLzCAh3+eCCHG4CMHp7FDgtzCqcHIBZ1HWSK6bcFn1N
 sAAyjbWG5ZscARPYtRKWr9MI3LRbVNFXabmrRHsh+ChHRM1BudWu6ST5fHq8LdxRkllaIGdU2yi
 xNfUSEflctaaxUdMpfVySJAyM9nF2b3pc2E07nicqP+hrQcjKyJQvgqrqlbaxyFY2Jl66w3FtI2
 7AdCE7W82qsEM+kGkH9aCYuPnZP1ENoeHIrX1VKxPrKsE4xrJORxV1+IARsXJHpwHjo66VwAFjM
 lkxoYFqvmSrKeqwnuqsomNdND8l2ilrbkfMiu8jsma4HRrndgM0NlOXVZTP1z7SOhHRYe9tvW66
 xsHf9OtWLpk/FF/SW7LCaouMUY0WsRQmxQIGv3OsPTMBZnj/OSeyd5pnE6NbyFgo/otthZQf/LE
 fAbCehBm5llGIt1F492e79yn9aWdeLrzrceTWpQqkCYZLCyTsh/J9bRcSA10NMDX8Xa43hQzqdX
 XU7wl1wan+4Gi6e9dehNJZNAivrEy55D536uGWR1iaIsq4RssrzIROnSReMp84W9rsL+MmV5DJN
 bR3HYD9oivnT1Kw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The host1x needs access to the VPR region, so make sure to reference it
via the memory-region property.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 6c4739efc8a5..c6a5ced069e7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -4479,6 +4479,9 @@ vic@15340000 {
 				interconnect-names = "dma-mem", "write";
 				iommus = <&smmu_niso1 TEGRA234_SID_VIC>;
 				dma-coherent;
+
+				memory-region = <&vpr>;
+				memory-region-names = "protected";
 			};
 
 			nvdec@15480000 {
@@ -4497,6 +4500,9 @@ nvdec@15480000 {
 				iommus = <&smmu_niso1 TEGRA234_SID_NVDEC>;
 				dma-coherent;
 
+				memory-region = <&vpr>;
+				memory-region-names = "protected";
+
 				nvidia,memory-controller = <&mc>;
 
 				/*

-- 
2.54.0

