Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130646DFF1;
	Fri,  4 Sep 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518729; cv=none; b=tYuKW29Buo8rgmcZt6iTCFpIg5vwSvY1vZFHnUYEau1WgFSLPuDc5huAmHrvFJl/f+CVomU+nngTONCUO162KyfKgomjiWV42RS+dsVfZxeAXyZaAj0qNMJ3GmWlEFyf46UFdIfglDEwXxVN1TAOdAyfZ6YHDVjvYvvYF3vdOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518729; c=relaxed/simple;
	bh=D4Xh9zc5N/4RWPWjcg0XK0nxc0XsnOaquGDBNqbZDwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rX5ecesVC0TG4EU7no+S5QuOZWka3PxcOVzgH2apuEoUp6ctLijPy0EomDt6b8UyI1dZxmtw4Bh2MB2tUfMTmc72raLP4vZGqwxd7mg9QHTnDUkw++Z53fl5RTFvdB5//efKgO7k5N+vwSg/KO/rbsw2Ydt3drY8ZcHzL3Ua0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4VteYfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4VteYfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211151F00A3E;
	Fri,  4 Sep 2026 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518726;
	bh=hagYf35q6G2UhsHzty44d2izTZaC/NeM9Zitkk0WHRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P4VteYfZoOUKRz6lqankTJMKJHc22APwmujZJPl/o9mFh+IaXlyFuO4ak0voN5g1+
	 SkPOsetnsV8OgScpk2tWZMqM6V6brZ2/wcoAJdD37U/u1/ZUhg5SWVOjIeHELTS65P
	 pbrK8W62YAb2sNPLRs8sJuv4H8SIWeVvm/qt2Bop5lmROPJTj6ET2fTuqE1+ltqHmJ
	 cdFluDoQEkGzlkB2wggIhYLNLCP+idVVB06/yEMa5e2gQXMUSkDDSzsSzyojU8FSGA
	 q3Le5bnorB5CtElF/RC4Yo0O8r1V1S75q7G6ZZomHcMbEjcxVMbnTKjkjyZ8sS5iWJ
	 jw0cjbyxhhxxA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:54 +0200
Subject: [PATCH v6 03/12] dt-bindings: gpu: host1x: Document memory-regions
 for NVDEC
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=treding@nvidia.com;
 h=from:subject:message-id; bh=96od8SnVSYMiavrRwbh7Ehk1YxWlsQuy9Uk4ZKu5YoI=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6a7RpJI/GCW4mTGRJ87hxtCRDZnRUuKBN7
 pMhWoYQXcOJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 occEEACxZ8dNEU7BnEN2Ha6fyLYWa+f1AwIxLCAG071sdb02B+kE1t9bISlQZt9JywhEH3ommb6
 efRnWfcpz3n38v0h0WnFrjzBJgURRzhc3NWBBpF4on5vJuXUFd14lhkleafdS1eTlcX+2jhKsX1
 seoHP+vg0Ks6FKmpTL0OKgtrKgy6ku+wkPNhK2pUylTPM4v6NP9j5OEKOCJ2TkFjwRUx1/i6viq
 j2hDpWCI+onyBKR5P5Lf90rVaBhYDO8zZpivHAvfwexg/kCj+UCVg0GE6cwNIo6e3AOYZS4fYUC
 E9H4MftsWwewlBj1Zq2KjRC3hyTfWS5DLPp59ZRTbgeLWg8iA5wuGJ/ED+CIHYUvticQ93nMVA1
 n7gvWqthSmuAunsNZx8nmg0jwJYFVmG38lGOYm2wYbwE9brDWT2neM6V2lM3zvfaNDffWqDy3mq
 hYEZq1xglKDRgNdZ+JPDMHDHHc0dL+1HqbX46xkB0bO/vni8UXpBZTLR/vikYgRGc6l+a0/Bxs+
 6/BcZttVbk+FEyNWKKHRCbF9oeSxsA6iPh/5W7ER4DU5e8yF0DlSE0KEpIkxMbhHTPVwqvQewrW
 zHc6+V4hT2sFlQ1D1Y7fcOVlrGyML932LvpQOio2aw9cbloake8bpTwzaOZi7hyrxZ99VMjAQLt
 EEsWSIg7v53KUNg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.55.0

