Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6D4071DE;
	Fri,  4 Sep 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518752; cv=none; b=g07lsdj0rD/QfhunR14ETHdyzK35KJjJx+bRl2Ag7q6S/bEdrzo24rYlJ50eKCxs/1guUWNYVZz1rb1v8JJPNMe4jTXCDqGVVT+1Y4DYehVF/PYUPm5fi7+l9T2UbLAOjZyV2smssfHQibvoiLgZcqHL5SjqIhXoluAVf+gSHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518752; c=relaxed/simple;
	bh=M/R66TK9cvXJNZGsNZJnMU04s2BAQALQxYjf0kzv07A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMGgQ33TMwYgEnw+RS0qrJvoR9my39RgMUxkOElHJnbZC9tv0GvF9Z3BhHMQ/O8vl1BB6TyD9eZ0SV4zu+zxEhsQ3X4WJTVikfjcO1JNVnM3ZiTWU3ZGGc1nGf7/b4AHszlfKlDAD56UWpSxeHJRC/B67XCjrZB+7zs+auUrdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIcZYSNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIcZYSNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C051F00ACA;
	Fri,  4 Sep 2026 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518749;
	bh=YsqfU4rnOxCjbdNELUfPy2EP2mOE10vhuCcFu2B7Ivw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eIcZYSNz+EMU1wJDbnZ7IB4nUkt6pmqiN9ypT7xdXDKBetutOJBe6ISblfxsuhABO
	 8gu9ZrpfWEV8GuQQaIkVaMrKKTsBcPI1a9LVKBPB6lp4vFb4p6MUt1o8J+f8Q9JQ+5
	 i1zu5i2VpZDULgo04uuwuPTweSqZrxltdhEJW978nE2aEbSz4ONKWizPqUykM5cINR
	 3Eb4qo29Q25adrLfYNlJiAtOTc4+PdXD6tmqo+3aZAtdCE2rvKqnUXcieI52wq03YJ
	 TckMPq3pX9hclABWT2q5hTtbU0BdWb1968ZkMkzAaazhu2nK5fftv2/tqDszxW0Iii
	 /VFNdlKvValtg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:45:02 +0200
Subject: [PATCH v6 11/12] arm64: tegra: Hook up VPR to host1x
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-11-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=treding@nvidia.com;
 h=from:subject:message-id; bh=uOEc0ecGZ8h9g47cFlkUo3cheaRQXqI5mvM+m7jx2j8=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE7YpgB+UW4bihyCTOissm5QATEBPRPgX85W
 J6eTpZr/RqJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOwAKCRDdI6zXfz6z
 oQ2TD/sHzBA2pRG369bC31+gXcK7TapnCz45reqcz4nihHa3IPi+ER91aVZ02HHKlgS8XCmhR5H
 NQCQtM9uARyGfjdGOuPIYCIeSUJ2tUpUscrh0pzM1PlO2B5R/o/IuOvBpaYXDXo8utSe5muX4xM
 1gx8QtCKLfBq/Qp6R5ac6C/ybJtthKei5x8m8FH2opPQ+Kw7ZhODt0tIA6Kyz3EUuyXr1oOaLSl
 d1uHqpDMyBFcRo9v38nbm9Gu9tcHcee4LYaCWSjp2e27lqDB5ynyOxYPiVqhUPDHODEnE40GSF0
 HCPOGK8aWmRdKrLYiiZrnyc34ZDX5tukJ9ylMT6Gsoili58f1VQbTP38Vflhxl3r+ijmgi3XmRs
 ombeMOdZvJxHCvsaXignsftiQQ8DNLv6+zTkTbGznqfjb1New6aYPoS2HRZ0d82MDn9BFWP/6KN
 NG2PW/g99K10YYoTpZYQ0lyQAa5zfAh/tKEkwb8avEoHXswF5fUp+Dx+pD1cXlev/6LeEiHtJe7
 E/UxTdopwiGCS7COTxnXp/OTH4M7HCrZavExIayJrB8QFFTsfsTtCCdXB1doBC4SAKbDYAfuV3+
 Spwv2ajjV1+ob6L4xpL2aITbV7myXUR8GNx919nAJ2d/FleBjFqIl4+PTBjwErta9Mb7Y0V92l2
 3X0W6eay5myH43Q==
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

