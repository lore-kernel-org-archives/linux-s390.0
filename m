Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73218470456;
	Fri,  4 Sep 2026 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518754; cv=none; b=rEdwpI/yaWE6oWyk1DYG9+pHJvBzBhqicmb7wSDIhjxE2F4RJFX2tXo2ZwSeJnw0KXsxYB1aGKrqsP7Rhnd461We48Eg+2gamo07N95I5CsXmP6NMNDvGiug0n4UXNvUBVaNMUfX8UwjEY7TUmC5CQj9PpHvOMcUS/5UsaJV67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518754; c=relaxed/simple;
	bh=HZxNmsZi+S62DG3AHdYyAcEUJkoueMrh5HNOsoP0nfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rck6iZi637AoEXFvzQbVwUNYxzC6vm1EV8KvOVuIdR3qE+qrE7zsVWwMdA+ZBRRSMp4JUTTVeBqGHI4wJVZtbSE6f888Un78Fq54+Y+T1P0DbvW6E1YxxIOplJR6a1cduwKac41j+/N3DBNnwE9ou5v7vikFdC+eGLCt3AFRz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP9DP3WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP9DP3WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C11F00A3D;
	Fri,  4 Sep 2026 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518752;
	bh=tp5ZGMgCkDYYyYju3vZvBz8YmJ8LdRAUta1tmaeUPO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YP9DP3WWRHbpiBvqdRY47YbL8PcKvkW6ZXkIs1iXMKrHnkCIpHGrZPLBccBF7fo+9
	 LV2JfjAHdxT74nfkVvRATWOGtmNEYIfha/f9lSFm+oRgKm90U62Knia62E+zDOb5h8
	 BQHGnIwPgCVW2OaNJzvAXlgTZb2AbvzmXnUwyoIQQbE5eGYFWO1Di0Lr+YUVs2rnf0
	 r7W6QnGFNrRfOdMjFQ+XjH/4PTzUJexNHgYqqxF0Lu30hod7dzL+Wyz/10mkHaqB/T
	 O/hvZ9CjdZzI1ffSGAwm/du+AWBMSAkXfEGbuPOSnZdgEhDQUX68+TcEIjfSjIePTl
	 aQbfiX0MrZCSg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:45:03 +0200
Subject: [PATCH v6 12/12] arm64: tegra: Add VPR placeholder node on
 Tegra264
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-12-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=treding@nvidia.com;
 h=from:subject:message-id; bh=R7+I3znIc+C4CFBfwF3uhHrkIxj2+n+gJD2B2rW3tV0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE7rP80/4E7a4eMykLVRISmqrRHTPAuxP98w
 IQWcaSm6L+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOwAKCRDdI6zXfz6z
 oaKNEACHyKhsBTZ1ctuBVdFSOjnEQ57mTqBOSye23UOv+Cr1ljxFp2QbH5hIEcClwoZOO9RCHkp
 Ta4o8lXpIGEeh0Os6ntBR3KiBB3v0WNaZwRZMwygvkxDFdGVgZv+m77w6UjOiNOOiwCO3J5sAXi
 Z1LPXrk5DPnIVRNxKPWenoikUckPR8eZDbkLjzC4i1lugL0pzKxtYA/KfhtpKQ3ySP74CCNVlLR
 lIV7U3WbT+g1GKMvtGNimuiIRl5iPmXfM+hs0uLpc9uWLGhsLMVfGVUTCmjIDDgabJWY1W/ikVx
 oKbI5FF342XhJ+LD2NO99czozExIVH/xTcwhhijOUOMPZ5WCV20Z2Ct1BlhkN8a3yK8CweWyWvN
 0OoosKFHIGaJw/ZXOKhzODb3vrk0W1sMsJMrrRbAWpXoeNWJhh26wKyk5uZ5kypmlSSv6tSUmSS
 0i60LJTaLmdfnl5vZnL2nKNBmpjWdZnT9lhXfDn4/v+saokkEIbUkA5QzpPBWsc/EQSwKN79Hjc
 t6gbLAylaeVwcS6w/AalDjDGEDVGDQ//gIHc4WSypdbJIpT4N2qhlCQaTIHyq3NxEj8C24lCtvz
 vJBUWMxwp8mg/mGygNuSa9PivjI7QtLST0GOLttf8SYkBQ0Fa3MYv1YSkoYYglsWVF3WDMfY8I5
 2up7C/PXiHlgD7Q==
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
index 964f18b256b1..998f7e28b9cb 100644
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

