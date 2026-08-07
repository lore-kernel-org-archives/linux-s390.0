Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5354480DCB;
	Fri,  7 Aug 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118120; cv=none; b=XldJWhRcgJ8yjcWuGJtHk/nFiSHt1iPgDE2xLcEmbSTUPKURye7uxBSrbEk5XHBNqVCuzv1f9GV8jyQhz3Rv7QenKaOvIHK+GTN1wWLfXHQXNiu6I4XZhx/SK6h9FgVzZUe2HSZmOOYYs3BjPamcU1Qiroe1RN1F64ZxXxM4zLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118120; c=relaxed/simple;
	bh=e21mAeQTUMlhRFf5ezwrR2Qw0RlmiJRWQ3qNZC4OuH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UybzIgvfuSBQ/FJ9LOv8soLozjkx+ozR97U0KIwERxgkoIBIjSsaLycbdwsID9eGitAq2ZdfsczZyWej5HeJmaj/RTPNnomPQKU8LXZGXSbtXQPmYkNFUv/e8Tz8sYYzQZgvZlBT2pk5JV98N2TKwdyTIm0f+6GfMh71laYG68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAc7ypy7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAc7ypy7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6A61F000E9;
	Fri,  7 Aug 2026 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118118;
	bh=G6i7xakpX8Dwar6IEApYmKxiKoL21IvPSWS9A/gXEcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TAc7ypy7uy91ocURkv9VM/VMtzRJ1CwREqZd4iBKT3JROVnFb01mez/Uwhm9yVGpN
	 i8V2wU7wKgygYtaxlvDmpDVDt8EsK6siaBgcHkEdLsEZCJ46BS9RCX9VLXvvIA1RcK
	 n1KgqLVkt3oOEfgydBBTeg9nwj5NFYzTLxgHLRiAN23R7QitKVmk79fE6dqzbZjFLl
	 o9F8U9BVxffM3anm0tZpSwbFSn1sSS6DS5i0Q8LMa0B2dPWNohm6YTPmAD4jwHQmVM
	 sGhu67Ke+TEBcBvNot6xMeM54JhEnQc4vQAwT4RzvNnNU55F5VLwqfwT5IBeeyEXnE
	 M4YC+WGPOs0Sw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:30 +0200
Subject: [PATCH v4 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-10-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=treding@nvidia.com;
 h=from:subject:message-id; bh=Amv4qp5tX12gNsVMO5kThf6U9odepWbA842/SdJEBzY=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/HprxUEDkF7YNXkuUx3mD3Wv6Omp42ATta0
 okbOTVnGuSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xwAKCRDdI6zXfz6z
 oTzpEACqvEWstLuzYaAPJDeIP3lR2uFYwKEtVCmeV8hHU/eQlcRERFHPgVJkx3ul/gh0GpGqpgS
 A0I5u8OVTzyn/6T334TyhKeK7V9sXxOEitUpKQOWg+3mltay5WBq9Y9JlPffkH6k75ysySB7jEH
 vHQwMIYq9rigJMZF//LFimhtQSZGp029lTxH3Hzyffe6qTBHlkPGBl2/FkIs9M4Mo2iHW0570kc
 +gLMw33NycSpoR0dK8KCY9g4ypDp2jneqDNzHSu/lVDqVD7mCWG3Tc/OaD8Uk8RGHegrUdNUuuz
 K51HXP7iMjyJ5eSX3fjprfmzpdgPd+ksntEacG7XFMt7hdrjQxRD9fG/xgsNyS8isxdSHuEDImQ
 3u9yj/6OXOOyFRCPcejWzS1efdAo3+pUe/pAIukmzk5HTo3r/wx41sAGS2qNLwl0ZU5SgkJ2Du2
 Mm32mnY1iKAVKI7xqkIR0osPAlSahomBfoHcAgtqydpeBNz9PbdP147LEvKw3lo4+J/5kY0lTvD
 RCrTASguilnGOPdOLD+axzj624w7lhWauT+/pw7nbDUFMBDrjFDoIVJAnEpfVh3rEt6d1eEc8vo
 AiZrARs8IJVMHXsQgzypvz7SSdoo4KZzNMdZ4+rdCcrLOt4anb2Rr43fki67HI7H9BR+CGDJHPA
 KmaaDqlprG0hTfg==
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
2.54.0

