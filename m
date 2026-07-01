Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C904A1399;
	Wed,  1 Jul 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922151; cv=none; b=U/nTL//A0STFjPx4+iTDvdwHUqzSXvnO1Rm5FJDk9hjCHyQEG9SLCbY+X1hBItKFYJXILtQO0nhoo6DeWR3KCsWDRfnciV610Yf0sz6FvQbn/txbAVIOE6TVBnyW8HNxzli16tFXPdi+ztQgwj6HKSqwF3x5HZFjtfFsYv2/J/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922151; c=relaxed/simple;
	bh=zFZHb+vckqmeW5/qe6Lnals0WYJN2IB0+VhsNvydGrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnPbjCkpn/LmcqgvPAXz4QZMCG7VZuM5U58iUAZyFhZwrbED4SDyStzOc4qE3PNo80lBS63W1VVTTIk14YmE1L8krqeh/o2foy1/3+EPVEg23dLumzrtvBIu41vQStlBRZHCf55ISB/3rtXeo+/s3+DN8sqASzNdVURESg22m0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnz+D3Id; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnz+D3Id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD1C1F000E9;
	Wed,  1 Jul 2026 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922150;
	bh=4Unwf8Y0GemNXKUGqAL43H7EkFPlfBNoXdpGfDkeiBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gnz+D3IdUXuVOVWa2GuAO0CPnDVDuNPxI0bxMgZ1CCLbmQcqis6eHmiljYSyH8TnG
	 lOk6cRve/V3j/loIu/rENCmrvJBobhijsDx+AMjsTpwtosFcJF5Wd62yTvThRTU6yO
	 fWFx+x5b5isRCdasal1QqDMqQpaCR1AoyM0V0t3FQnYkNbBMpw5t5REqFCXOHYvHqg
	 hw2gQQbs+1bC7Nh8wvxOctHBYU2LuWbx3mS2ooAYXkKhA8GF6kk5NEMl8mPwCC3OV0
	 TQjUPAo/t65zBhrwie/hGhZFf3fFJgm6KRRuzaJLDsLsPTXznFleLh1sLZBThbdUXB
	 YQ87n7zoHi5tw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 01 Jul 2026 18:08:21 +0200
Subject: [PATCH v3 10/11] arm64: tegra: Hook up VPR to host1x
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-tegra-vpr-v3-10-d80f7b871bb4@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=treding@nvidia.com;
 h=from:subject:message-id; bh=KF8Sd3fIMlXn3DnsH8XZMC5FC5yldMYPw2MRMs8ZODU=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqRTuGsBSQajHtTbkOtmApHYHmsA/lKcquSASmn
 d1AOS3I8s2JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCakU7hgAKCRDdI6zXfz6z
 ofmvD/oDrWOX50ibPn/1LcDdJ3M9JnaVCPT2pPYYaw4cvn8H7q7fnN45m4ssG0YXlBdvz/7SLCO
 sObxoQ3IIsIxrb+wMNWFi9d7GsP8EUeXCznhiQfIE1Cz88QTGcbB7nZiJczuTRgJytA3A0VaR4G
 2XC1Z+NHQth/+RFR0UjpMrIfr5llRXuZvkNe5carFTuXwZla98IWzpyIiNyRBu0+DYY04TCags4
 5dwj34kqTpvIKgtBURuhEfCRroDZzosR7KiH+UV2dFVxCcGw3cHc8/Qf9d78QKWAmO83v6GsNnG
 t59v7fBWy22fdMA2mHpAHmhF7xbS3mLPxz3VaXYrGPXocZvJyCHtB8NS6RQ+xd34T+KBcAiPGtt
 8kTD3x3xxjDELR6YubpWrO23cXTlK1BcDF/mjjOkB3QvVtHK+quJNQ94RyNsY9SlbAoEj8JYWBl
 K0Wkm8GXRAaKFGGVpOZxp/pmaPFlHMF4RTe5vBC0bVdpRUFU1DOt0dohjjr5YRJeOcK5zt92nfW
 NRcJsCqmOleJzM9iDcsnlUHyn4piqtCK0yxh8RuCvL5Ow7bIRnlxavAp5INYCcDhQxDDH0gvzNC
 XjFfyfbKFLQAP4DX5EWs5PopJ6VVeO2W6YJeQP5ZAZdQMeoUgFF0d6ZeVVGsgSeK41R1awYuLII
 qe1pmdgXywpsyGQ==
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
index 52ff11873580..38637e8e6fc9 100644
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

