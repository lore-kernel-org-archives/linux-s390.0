Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65882472F87;
	Fri,  4 Sep 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518749; cv=none; b=jq6jKMhL3vPApBplfshW7yJsGgAXCcPTC4cwzstoGNbsJsTNQYZxny/+Hs5luNXUl79GtgCDpr/KzakjY3w0epbgiJpaUPepCozGupPO0+LFad6IUJ1VsV1QeHk61GaCnumViFZ7xeYrBXq2bxQwMTUHrokcdp8kVK19dQ77wDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518749; c=relaxed/simple;
	bh=5EtoJr2asw/bScq7iQsbmEz9QkSjIOA5+gLk9QdMxBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwq6a/E7mfz6+yzk0J64IxGgkCo07VhpjEMEHULJFlBiXEq6rHCkpmnfzGywfdzKBQcd6dkdC7Zunzx9uBzDs2B3Qoo+s8N3VHlrj8cpstpHDnzYcoNXLEGK5JVsjqsh/M7x5ejpYrgbish+dcsIiOXTjHLTt6BX/znhXuoTuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdrJ1ddH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdrJ1ddH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04A31F00A3D;
	Fri,  4 Sep 2026 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518746;
	bh=3Jc01ta292IyzRQJ7S0gkfePZTtvrNXCh0bWGk/zJv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mdrJ1ddHAZh0RBFuHKXNfw3fkqkJfmCIOGiJfKTBKm8OhvRyljaX/bBYspXvWQfAb
	 LZBgyRMCh4PrSUIsSvJcJr+0kn+kgqiozuNwWW62jfsITEaPYWqkTxPZttIYwp20qy
	 mDmGrTg3ZtGgFBwGXvX65BhBnuX2jKZ/CPBu1c7J45zFWyEyMf/oqA2RCDQnIfXuh8
	 N9RlPLyDqzPhOjtsWnOGZX4FQgQRZ2ncNLVHaRMP0tcqDuSU8v9WOSVKr2CP/ONTxl
	 kNhPuylaE7OHka7lwRhqI27ZX1m4J+yYlCfnMk9dsl7PBD3Zk3rnuQAaEUZvpLSCjj
	 /+cOz8R91wZug==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:45:01 +0200
Subject: [PATCH v6 10/12] arm64: tegra: Add VPR placeholder node on
 Tegra234
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-10-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=treding@nvidia.com;
 h=from:subject:message-id; bh=tluD4wsCTEuKp0Tp27V1iO02LeJ7xPXs3NTBGtUc+lo=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE7Lt5Anz8aJt2DvjvvqhhLimK66QEmLFp5x
 boZgxc2ZwiJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOwAKCRDdI6zXfz6z
 oZ5hD/43CrJtfKpYLCkCb21+kPu526QvefmWAv6kxTjJ9/mrrSYYAYf25vuyeaAPXr9nyDWryjU
 zq/NsLx+qpynIFU4tV7MxGzjJMYkE6IopYEG7NT6qlIvAq0gPENEhJgSMejC6r0m7s011hz4zqd
 urzSwLnSUQ6B2wPveIp6PR8IdzXeNtQsxfcq6SfDCx3QDuJZlvL5EAxNDTKs7sBo0T2pLi9fXLZ
 gwoTvwaZUkqNZdbWET3UY8VzOIEAYg/H+4FxEy6moXbB+lgXHjUP08KaIwGq3axDOVDtnR32Vmr
 stBa9pFdA8F6T8gs22ScTlAYBVUnJcsjn0KWFfj2v5Jm/PbS6taE2EmstYVgknXM9ilQFm4lHal
 9ItIzTg+7NcvCIZsaYk0y/CgWSM4MtjblPjPTIAZFJnL/aqnNmW5Fy7l3wdUpeaAnjDsqPShQ9p
 SpDCMU0shuMtgu6a9lwAETKx0kJYj2kGnMQbDD7ncJJm/p/XE4OoEeGrS26DcbVWuuFyaeEXwM1
 UNOD8mHOzMbZRw88rmbxfGlFs7YR/XPDF7Mqg6JmDb80LQNFb/+jD2A9YjO13QZJ+xIWw/5qSbf
 Bao6LbbQfVCtnpfkyVNioEs26TBqiyVbXh0QDdpQKUCcC8yJjlw0YI1DpmOfIZTH+eV/RBXAA7n
 cR6eJAxszH9IjsQ==
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
2.55.0

