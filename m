Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FF3A6F0A;
	Fri,  7 Aug 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118115; cv=none; b=Y595ENo1Bf4t6RqszdvY0c6E2/2L7rPCddz6rXFkFTGXHKd/CFoV21dclRJeRXl2RhutIr3iKGFqT4PKbZkgLgCWEK0uq19qPZUi3tPZBb/UtVpJocSrTHqfoky9bGIZ5YyKA8hwaAI5zVLQN69G4/ouKAEmfMq4rRtlV2C1qrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118115; c=relaxed/simple;
	bh=0X5g+1GgSRR3o+1uNSFCOuLJdEe0gSxyhr/iSFVmomY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLWVKH2B3L+fI686Cg0Y/7UOJHQyoiQGt7/q0hwIlmweKVEZ0WuG/fVGZB0WviG5AVYQUvEscuM358sQeEPxzlJci6lWCke65tMhPWP7S7nXIMg+gQD/GfCGa4VhSwCU/SiQMWV48mVtEo5gv0RCENbl49tY3tEEyRGeWnVJwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fG521HT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG521HT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2791F000E9;
	Fri,  7 Aug 2026 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118113;
	bh=mPDOfOXe06M0GKcvxWZbAFqQkr5StCJEdDzYqLh0o2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fG521HT/IirI5WHvsg3ZD+uAs3zdmwK92FygXkTKjBCm/AcOJlDxUvw9uwlkuAhF3
	 cZpLNPl6qGRdBNVS94jMATZ+sZ6d2dbsGanY/frc2XiCgrymAvc+c1QbHtjq2/OQ9j
	 eBgh+tNAFyLu19jjIMD6BS6Vb5dUVLkGICWThBqjCxK42klQ+GxbmJ7p2xfiweNWny
	 I9hZtEFpBV/bhq3COaZAsw0W6lkR99pGQ0GDyQengRi02T8pS+XEtr7LF2RJnCfM6r
	 xwnFsoOWY7plkQC3852lSZGS8eH8FyArearoAUeAE6fX2qA+7fF99cjXcrklLce+va
	 N2+XIGk+NG55w==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:28 +0200
Subject: [PATCH v4 08/10] arm64: tegra: Add VPR placeholder node on
 Tegra234
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-8-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=treding@nvidia.com;
 h=from:subject:message-id; bh=0/rttmORifSF/NkVAelHN1lJzwrp59wyKhJRifwD9aU=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/HOH6+K4FOB3lnMZFEOz9yewRutVo8PCLVT
 aE24DZ6Fl+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xwAKCRDdI6zXfz6z
 oZy4D/9Lh/3uB7Bu63ko1oCw6H8IhK2lPxhqPwXGKEeKQ4yz7BSw10VkW2Mh+7lM3Pv22ZqOztJ
 jB/jULLtQVwQTTatNrM+oC8x/HghXonSRb4BYR9ioSnogKZEok3zpAR+7M4dCV7eB3OhnrYPNMQ
 Eg6dSiMAT5ttcuM9uYlG/X0cQOBQqIlAQRuzzIlLFiIY/+pYX7QuVF8lcJJTO9jEJ6rOa2iwAt4
 h676JKAwYhz6pN08f+bVZptuVlb1Odo2ryD97nT7I1TXoT8WFveS/ZXGh5Shc+qNjUgp6tSWgSb
 T8PsItgz5exnBkUNJh9DJk4HRpPpLtSkJ0eMlWKX08yvjZPFhwugZrgwR1hrPKs0+ObHhysTQ8b
 5uv9esl8qnvMYSW05/DzJ1gGjEAnRsF4N9KjOc7vNpEfidXg541PdvwsDHiFh6yTSoFvLiKVRKs
 1bgru+oVbwyswYNJXQ5b8C2BiRmucpYXSKirAmbAJqGnJjQCQhIJenOVT32G6eTFTyr1HAKdbnj
 8vHDcDebJXpgk8Ozne9EC9ebSAAJyiBwt1hOh6QlospttywdJUXMaekw6JQm618xVCaqe316lGH
 UKKZJQWHWE7B8u1/40KpOr/SRpPpoplczQiM4yntSYyh6kKjIngCbACIZKVbhgbY7FnL2tlFFuS
 O2RKTF7rW11YLww==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

This node contains two sets of properties, one for the case where the
VPR is resizable (in which case the VPR region will be dynamically
allocated at boot time) and another case where the VPR is fixed in size
and initialized by early firmware.

The firmware running on the device is responsible for updating the node
with the real physical address for the fixed VPR case and remove the
properties needed only for resizable VPR. Similarly, if the VPR is
resizable, the firmware should remove the "reg" property since it is no
longer needed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- comment out fixed VPR properties, assume resizable by default
- rename node to "protected"
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 5e29316a4d75..6c4739efc8a5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -29,6 +29,45 @@ aliases {
 		i2c8 = &dp_aux_ch3_i2c;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vpr: protected {
+			compatible = "nvidia,tegra-video-protection-region";
+			status = "disabled";
+
+			/*
+			 * Two variants exist for this. For fixed VPR, the
+			 * firmware is supposed to update the "reg" property
+			 * with the fixed memory region configured as VPR.
+			 *
+			 * For resizable VPR we don't care about the exact
+			 * address and instead want a reserved region to be
+			 * allocated with a certain size and alignment at
+			 * boot time.
+			 *
+			 * The below assumes resizable VPR by default. If the
+			 * firmwares sets up fixed VPR, it is responsible for
+			 * adding the missing "reg" property, removing any of
+			 * the unused properties, as well as adding a unit-
+			 * address matching the "reg" property.
+			 */
+
+			/* fixed VPR */
+			/*
+			reg = <0x0 0x0 0x0 0x0>;
+			no-map;
+			*/
+
+			/* resizable VPR */
+			size = <0x0 0x70000000>;
+			alignment = <0x0 0x100000>;
+			reusable;
+		};
+	};
+
 	bus@0 {
 		compatible = "simple-bus";
 

-- 
2.54.0

