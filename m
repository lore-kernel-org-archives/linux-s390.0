Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F30484249;
	Fri, 14 Aug 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721399; cv=none; b=kgWkrMCnxiqFd/Xf9uPi/TFqNnPuucI1X2Hm2roqlCEOEZ4r7/DTmeNS0jXlG1ADfU+FRZrgWqrhopXfD48lZX1xzbcF+2e0Lb8Zv07YrmusuMI3emzOjeT99AzgHUIzuQcBSP+k3vY30xagyTU29ryxg96PCV26mlK5wntzHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721399; c=relaxed/simple;
	bh=M/R66TK9cvXJNZGsNZJnMU04s2BAQALQxYjf0kzv07A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMv/oKvVaHVCDlw7DyYxH9aOFcx8O3QOdNhOSxDTupxYJu5W4GFTuanZMKB1d9C0yQSuevcTcmzxWUNgbS+AjL9x2nkuXfko0R4hFhZ2wDKsmaqB1iY+VOrjevUGJLtoCpiVF3dhvs6E07x5ubA1ScRCbUcJhQWullVgCAbnXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlY9dOe/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlY9dOe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3671F000E9;
	Fri, 14 Aug 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721397;
	bh=YsqfU4rnOxCjbdNELUfPy2EP2mOE10vhuCcFu2B7Ivw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TlY9dOe/m49Es17ojXqtIC6JsPPLhB51fuiigq9mhO0OsfqU/dpS8ol9VSMirZnys
	 N+Sz7Y0JvYdHmVXeGhp8lyOGBKXLCZRDGKUGk5Af1VVt5A0DxxrqHZrIW1wv7HVEuI
	 Gk+W6MGpvoBmb3bQILgXFn225Y9gykLhrAfhdMmbi+FyWEntwqfXVZkEOkp7M44puc
	 DdILQj4CoIG67RY/8F1SNui1WxkIqGgZT9PlkkXmIAnN0eqFymVnrX5PDfHaPLYabi
	 jDEZUsxAYgC7oqJaLzWt+C0vDZoz/Gpks+B5Y/ifhVblSniSS/eCj9O87aYsKWHVt6
	 c94JDdp63Kh4A==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:17 +0200
Subject: [PATCH v5 09/10] arm64: tegra: Hook up VPR to host1x
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-9-71832b5d0246@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=treding@nvidia.com;
 h=from:subject:message-id; bh=uOEc0ecGZ8h9g47cFlkUo3cheaRQXqI5mvM+m7jx2j8=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRYQ9J+7I4U2eaXmCOV49EwtyF4cmPzXhSyC
 Tq+2quY1HaJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WAAKCRDdI6zXfz6z
 oU/AD/0XRytJsEu68Ff0PfHtnK+eBBRHrioM9YqCgL5aBA80Zw/VnVUReuBPZZ6wyk2zAETMZGU
 I06nPkJi6TA/NwJwuc2pygr5F7fDVmL+rsO38ovw2JGgCdiCOciqpsd9cDqquDI59a5dwo1VULN
 LhvF8edxPjVFQlcCRihSuMvlOuhwngvYJ2or6ng0CLh4w4xrPsFCPTG9eh0hUvQQIdMeyIroGug
 K6+q4Y/za6Isw3zXh++Yb7elZScIp3dPC96xEpF67MVqJ5Zr+Hdt2BoC1OUWAX2vCNXn+ezHxLW
 CnjP4Y5h6zOC7WNnucPZGvecau6mMIU3EEXqKy/OehY0OFZujo6EsFJsopFibt1OIZ5L1oXcq8N
 TwU08UiHSX7OCL7SpcZ8vIG/093IzXWnkkZL8sfsc1Ygg1QL2oervYhf+zsLFMlHu7FMt4UqouL
 hNmstA9OD+5jBqNaSQ112uV2CINjMclaevNLLjm48+z6m363cfrD102Ybu9PjEibOoT/psH5Am2
 mLHTSjBZblYA78ADS4coEm/4O7B2/Nwu4Lv2dGanNcw5Ey1unUinkIQrexFKxH1rNu3GpEqyAGE
 SAy3sjcVNL3Paa25oMm2xMKJ+zD9mjY3+e/sYwrE6sW/OnXgp6X1KggP85+52DqrsX0GcezgMAk
 C3trgaesgMJRKPg==
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
2.55.0

