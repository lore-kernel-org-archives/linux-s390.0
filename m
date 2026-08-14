Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB95486E40;
	Fri, 14 Aug 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721403; cv=none; b=MwGIsZC45AVzZtAIMPCRT2zQuIaRH9VgYWEDbDhRW5CnRfbLU/uuEks6KWpRI68pzkbU6u2uo+MyVrgKMwPwBC3hENfyhYDRdT+zI8cOmf4dlqqONPhnq8nHnWMw2xMCrttPrKHdY49cGM+jjSYvHDCvn4bqyL1tHZxIQHIsoMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721403; c=relaxed/simple;
	bh=tl4J5nZhsTsNnoEGHzqT7X31R2+FzAdmY+JzEZBZ/wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLZywGSmk4W1yDFGa9LWqCUfyHED97woPrjCj45b2QuQkyZ0I8f+eZd+ftE5eCpl1uVyELOsCSnDKzExFznlN+d/+oSAOQkcB1glkqPCtDVqqD05mShwHRNAnzJigtDx34Ja3/lvgRKWG65PfmsrUmCl52WVOHLHw42dcjDuKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyLKd7df; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyLKd7df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70961F000E9;
	Fri, 14 Aug 2026 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721400;
	bh=uaLT8Pt+Su2uzISlW009doIM0VJ15n6/6fL5974J+dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dyLKd7dfiBNnwmTsFUCJeuYgeUh8Ew4Yy3vfvAWnGGsbpXhsuQXVd8XQ9w2HaM6Zu
	 QgBFaTPJEssOx024yYFYiy0ikk8y+yf6M2aqF58IXU4qyJA374I2BXJ7LsBV6pl8DT
	 5Xj+P2HKB2Pvpmjt6zEYOI340apfB0nAFJ7XkX9fme6Uj6Sja0Sl4FcAYaZnu8TMkU
	 guyQVkgOZfVNqwCLYiPXu0ohVQDFkAnBDc0rCPHMOOb+6qmvJLpRHkLxEJw7lW+vos
	 Ntys2s5CLDmS3/R8vkRNfeJVwr6Ss0RjKsCRj38cipYc0tgAJxcOXlAUDB4Z8VRD4s
	 iGqg8t0wrurrw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:18 +0200
Subject: [PATCH v5 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-10-71832b5d0246@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=treding@nvidia.com;
 h=from:subject:message-id; bh=db5pktqTEHmL7nm7eEWg8RTfTXMm0eSnWFgz4562xI4=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRZRCHM4P+QZFcsZdjlqbbApnEWVTk6Wm7E+
 KnIdEu0AYmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WQAKCRDdI6zXfz6z
 oSXAD/9osIn6vKwbtFrpb26y/g3b9z+UjI1W3E3npab2OW3Xl4zfKOoluxB7F9krSl7aDrrKhw9
 uI7kMIHw32NFU50O6kjYGE1Zi6s89gv4UeeYqNiIPtYqyU3dVS6/wt2AN2eoQgD6y5y7lgsX+a2
 b+TaC+idL5S+NJxjlha1/Ax3mH0kmL/NYjMVT2F+OWOfJDFbmYtwCkXa/bnlAJaExbFvVow52w3
 lKV4KUg+Q1zuwcv9wWrrkcEOElranQ1b5jO/E27+zvhIle3MhK/RkJOKCiRlFR7g1/oAIVHCYVx
 vLgtY9ifFDRxVuTQrWHpCJcq9q+YtSAZUiM4WjJutFgVF0fejgX7YDv23ar7NkoI7I+eiHqKv7r
 KznaE0HyuGIGpGExgj3QeEEMVqz7I4xibixSV+MPk2EVlm16ZcqShTUu9ZaIadCxfAS1rcRqSz1
 Cz/etrRh+A2EV+V+tgDcNBE5kmN6YvTZE826o1yVVtSAVlrf7S4s/rOnwfRHTxTH7Ek3OWUkdpR
 kuXJlxiZ+xIKx4VQ9y03bVyg+FeLRphkOO952z6VQq5Gk13e02mBOUG2liVGPh70aWOmkoXVhtN
 b268m+4V1J8PieinrHxibQ6o225G8PrDeNOSGlbNKkQf6afUzpcG51yPU2vS4//Wl7rnKmgE8qO
 nrj9H5tdo/9uipA==
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
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 31bd29df8e46..b3a8ea64aa37 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -24,6 +24,39 @@ shmem_bpmp: shmem@86070000 {
 			reg = <0x0 0x86070000 0x0 0x2000>;
 			no-map;
 		};
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
 	};
 
 	/* SYSTEM MMIO */

-- 
2.55.0

