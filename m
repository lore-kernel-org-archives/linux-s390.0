Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3B47986E;
	Fri,  7 Aug 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118100; cv=none; b=BaSVyQW8dkjKYdaR/6MMws26E1kgb99hNtCkJOwgfeyBv3VwKFh9LQX9Zt5kkURuX3SV4oUYcStYPZtj7t8PxKBK1z2rLRNaoZtsWD1bQoDuV8qUyKOqU1uCKAA3riQxghX83LQ9nE/LqntVJPrsx3zZzCXeTdtXkVPKIKhLsjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118100; c=relaxed/simple;
	bh=M4t7LgXVcn0IaM0TDA3Y48PvsVG7jWRH6b/z/7/16Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNTgvtOKtDNLCrqQkCMT9S29LCHmwRrn6TXUhVi4vCGqKhvmFkCSSw3kaTy73pTZ7Ew/kdjMUQUFQ5MzLsImlcqBPcyKUaoy9AfWb9xofaI8VlMgacge8qCQNN2Ka3LslAG3ZerbmOWjf++bBrNPD+bIerT533KlkP0/L1bD4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlQ/rN8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlQ/rN8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DCE1F00A3A;
	Fri,  7 Aug 2026 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118098;
	bh=s5UylNYDTspcuu9MwQe+nNCZE8i0u6cLYLoMeIJYIfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PlQ/rN8eifYQ8QVCPMrG4ANWTYv8vhyu1GIGyz4VGfEy8FUqVhPCgJphWSPd/6xMf
	 SooHgkkSnrIkXwMCG2Cm6Nm14nXXNCS8efjorqIpn3gRKSytiWk1PyT/vgpnTnmOkf
	 4kIVTZJ1oyYTLsMMTrb7rp55T28DKmIwX1RNQBd7Cz0HlUUPmsNPRxGcjxAa5h6Bwv
	 aFYcKOrtza4aDpGIdCICWJJFI0RxMaEy8rZbfasBeNq0tdGoubUKE70+OPP/o9RpKa
	 N2haZ2J7Q97xRwDDfzQKufCVrb2wMuE4tttRw7ilmLO8lpIw8wJzf3IOnTfxY4i3ED
	 7DryO57FWTh8g==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:23 +0200
Subject: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document memory-regions
 for NVDEC
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=treding@nvidia.com;
 h=from:subject:message-id; bh=YiLAGkzcznmBG0BMFt9ttJjGeSWnN/89E2oKOOw+7sE=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/GR37sAZjqZHl9vjJq9BhScKylddewXFQ68
 Zlr4w9zmyqJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xgAKCRDdI6zXfz6z
 oW8xD/9C++PytcJnk3HXIfiT/huNGT/Ml4Mq3xayTRIIuViQuWMsLPhfCgi/ucIJdzk6RTskLSa
 x3yaOEVaKZ+Bd7KcishV/Bpnt6AR4PtAuibHchQvuMFd+eTrgao2hVopJ3G7a4pZsloaPzcNEDB
 +V7A6HFw01zNF56Qi1fiQmyz2jCeyCJ134mCwv72gnhTLUauwn7RgmH28JmTKV8TWWp4oGSa6OB
 cKIHBNJeyTbloYJ9v0TsFW70gvesfwdNVmiOTdyvmXQIaWiQNHQJ33PFnOw3Nr0Dr9l5fftIqjx
 EFnH42dJM6/ozMfQDTPo6ZWTw1DjsrS3vmQPA8IoJSINJJ9/BLzERlNMlS8YwP/4OQg4W2NYG8D
 D+1EBXcdNFLdNK2/PdXfpSMAU1G9uWVrLE1kWsTvXxsAljD34OrfvYJtiHBPLsBiL2UrPUoGMan
 ncHpe1rl5LMCQqHi+nfbZ6W4/H3qL7itpAuiunjnsHqW0lP0nSO4SeS3i1enyVT0cP2rNvU1cm/
 1lAvHLJICevyWHAmAKiNA6ZiepaOaKVL3y0u2MHkF1g5yj2q5yQWK/+BHI6dIN6ZG/FGrHyqe9Q
 3fY0OViQXFucoWk4ffPbbUD+lgrkADuXPKcbaIrFifd7mhD272tQnTPAECE5hqJv7qdks4lH6Yv
 ku8EZDSZYiNXi/Q==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
index 4eb325cfd296..bcaaabca945d 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
@@ -60,6 +60,14 @@ properties:
       - const: dma-mem
       - const: write
 
+  memory-region:
+    items:
+      - description: reference to the video protection memory region
+
+  memory-region-names:
+    items:
+      - const: protected
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:

-- 
2.54.0

