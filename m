Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9C485CEC;
	Fri, 14 Aug 2026 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721396; cv=none; b=e1TWMMSrT81SCw+lqttJt/oUbP//JVAWeK3L1IjqrJS7PGjepHXcATFenfcp6qron68wNK6l/8nQWdKM9fqIzWeY0v19BsCDMm0KXgFZVY6S3TJaA5vbDB616Jrn0e3OK7HtnPlxvJilC9VYS2d61UCBvANM/NetF+wRW/nK9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721396; c=relaxed/simple;
	bh=5EtoJr2asw/bScq7iQsbmEz9QkSjIOA5+gLk9QdMxBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Soo/pNSRGNNM6SJIabKJdUhgHDJnqoUSvHlE18qwTzSc6z0Kg1jLQA2e+R7lEfV7nH7bI79mHUQ4EbqJAY48HtZ8REEEcu0erl5J8zrCmPFGNOSJysko9oWYnGQ960PwW+vVwbzYq/T4uDP5oXTk/TdOm4UdtTsBFIt0XzzPii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcMsbplE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcMsbplE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190991F00A3D;
	Fri, 14 Aug 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721394;
	bh=3Jc01ta292IyzRQJ7S0gkfePZTtvrNXCh0bWGk/zJv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NcMsbplEtDdQm6kh/SGOLa0/RJQNEWfL/2BfcjnGXSUNBYosAjU0UjnY9lqbWaoJ9
	 Nie8FAah4yhGJ55myjaV0rn9kAUDHZlcnnA+8c5Ga8uNtWAPWYt/+gaPFZvtFNJmg+
	 s2FlVihIsR7NcKRwbaa2oktybdQRP+j1QOkgPiNqzBx8fXZA15gdbWHnJ9QBSTzLLX
	 2CV2SXUi9O995eCjstVnkSWEbxVghqpUOFlq58CjSA4RzlNCqWradz6dV6lzuwzLE3
	 D7Q+CFhySsr0Na19Z8tc/Rb4CPGtlNnqorlvDV4iVdM7N22Ei7ksrkpadYIYCCUZa8
	 TP7eYcE7F23Ag==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:16 +0200
Subject: [PATCH v5 08/10] arm64: tegra: Add VPR placeholder node on
 Tegra234
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-8-71832b5d0246@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=treding@nvidia.com;
 h=from:subject:message-id; bh=tluD4wsCTEuKp0Tp27V1iO02LeJ7xPXs3NTBGtUc+lo=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRYDbNpqpdmgbeamv4SdSlpqySEBNbb9exns
 Tov5wvAxDaJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WAAKCRDdI6zXfz6z
 oWaID/0QBemia5v7XUxUcYFPeszOyYomA7N68168MqyiTj7lE0A+c9LcFnN5wTRYmZjQ3lubFAT
 F2HaLwt+kPeF/rzJ8ZkcCgRjp4ZJ+jhGFu+IkvpzRy/idEkblTNtJiSVFRxmNjv1VfbeFSHaiG7
 Bp8voh2mGvgzmRKPeSasjQeBZkcuhByhnkjeirZ2Z7bryipcJKMcGc2LykMBFp1I/LhMQugP8mp
 MmUexP9jDjXpoSc6lpg8hC0MyZ95YAwh8cv/dztaihtWMEP8i+zfe14J2jhGA+DuxxNStXOVSSd
 okTJkF3HU2vgfHQ9ffWlLUpBWuLHdV5++fA9pLVApYRlfM2p4eN9F0RuOvbJMTri5w2OhlwoFs9
 yBn8zjkPEdjbeEr3dJr8GNBsdBd/2E+646SwOz2H/FymQfdcO2KZ1fCNqoY6zcxJm29FO989zw9
 WsnYje5s5jmPWh4vTbHXKbsGhg6Nrij/0aIpuQfrKEWH4HgVECEezUGJvGV7GGfcWb8l/w8oKjm
 FFczQ7Y6jWGGk3R68xW7D//Bq15sv4ee0TV7zgIiywdgvrhMK5PkD7+htoOPyb/7O2Ch09ZZWOu
 Pfs9PIILCsG6PBXjil+eqWs1zcmONmwP+iRo7XXXIl3db+vvHbSZcivk5Oi67d6NvBIouAaEx0o
 WkPiMhhZYK2UFTw==
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

