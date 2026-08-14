Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148F47DFB0;
	Fri, 14 Aug 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721379; cv=none; b=hytQv9qGqZFUpOLm1DW0xfuXKP3/aGrUHERdYNcck2kHNkm8Nhm1aY1T6cZ+fytxWmUqb1nIihkutI14pXin2TkD4AZD2RAqnzCQJQEt4Q/YA4UKkDRkWCvbxB0h3VnnomNzQEwPSZE9gq1Rto6NuWs+aBSAM9dVjv4JnGUXBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721379; c=relaxed/simple;
	bh=KZt42RcI2xZOV6ZL4xNzHGcUviEo1o5J+l+Mdce427o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZG896zWZbODJRzl8kC85T83IlJEpBzVBdT0aTxIVNFWjwiRJHnj8kv4XCECSPfJyqPqmeW+BTuqZhJFgUjwzosOAU7I0kELiX4PCRKrjzaS646RzvB+HdTu79Aq8uJOyhBOQ/gBUumRgFoaEU7/K2tbC8EchY5GO5nh1mt4DS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQYinDf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQYinDf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026D31F00A3A;
	Fri, 14 Aug 2026 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721377;
	bh=eBlEuAoqOked/LKJu9mRAOEywcTF2CIu7f/dTPjyTCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SQYinDf84Qyd8J39yvDDkE+2yMa0qkyakiGRRmXf/fx0fg4kEyB3/sFc3snNGwS4a
	 gZYSriilhL0IMm0YA0eTk+Fr6+tib5AjGC+psqwuOr58cPmjYAIuQzHxP0Ge6jse5c
	 SYvbKj5F6GHpZyOthwjNwOz8ZbWANjEirhoY4Es1XYu7sKTCZsKE/pVkWklj/YJyCn
	 1Kxbk35QjJ2mW8iRQFaDdfUyLz4khPYq4BpXf8zT3m4sYZxyiEfY2ONGzN2rFEwQDd
	 9zml7Ja1+KceKUU1i9huNizcSLqzefA6V4HsIplKC9KeQgA7MEOtO96w4DwQS+9MES
	 DZXezd2+lIsYw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:10 +0200
Subject: [PATCH v5 02/10] dt-bindings: display: tegra: Document memory
 regions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-2-71832b5d0246@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3649; i=treding@nvidia.com;
 h=from:subject:message-id; bh=pBYGfO+OoRCfoGlySA1v5aSrpzUlJ6EhDp5j2u2Nips=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRXaRTeDiDu4YBKZoD7GNeMdeApLEEF/47+P
 Qs7Dg4EFyCJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80VwAKCRDdI6zXfz6z
 oUKBEACxEJAOL5zdS5PgXCqYYzzNGiLLXVhgFzk9U1eqr3vc0dKYuq2vq77WgkFBI5rq7KrvFNH
 9h3HArdCO4FtE5FqV3SMFXSGQgi45SAZ/XdBjP1goIG38+OdMbFWNyaOl9YPEvNDN1Yn7P9Xjvg
 VrX6hTODGnRwC3W6pjviCz9yboRmRInlgIzCKkXCwYKMoH0Jru+o0ghVJ+EEuVUjG+92JbtTYRf
 ISKuI3IJKNrZBVSEG7TmHBxpAbWMvPLrFyPR5GV1L8sQL/eR3VjObNlgyJ6fCXo66ArRvJXUoIn
 5JE4la8W3ApL+k4SCDAA9iSSdm5qpPhWD+xbbh5q57FsGCQliDaDBGt3j0iwRWrh5vboKT8Vy2L
 iCnF1QDKpvsQgkZKor/kBAT0A+cS9EEvqyaPiVfnPr9MV4DM7rZLblI8afcRz+AlbF+SPprte76
 InWAWIl0Y+51c4Sy6SDRSNjQfRxRTmP5DjmykikMD6ItCdY2igse1frokTOU9npaT0QZcLbuRiy
 qEu5R3XiC+4VApabAOIRvpF2wKDaaBhtaUZuXb9C8A6fslgF/VvQUMsiI9R2P7+w3B5kxhUYgpa
 rqyzS0AgP0wdt22bH0ObJuoXXTtOjm/ualj5F/PXaPsdAmBCavu2SzT89QueATL3Xdx8JV9IzeN
 l2c2CdbqjX3XlyQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add the memory-region and memory-region-names properties to the bindings
for the display controllers and the host1x engine found on various Tegra
generations. These memory regions are used to access firmware-provided
framebuffer memory as well as the video protection region.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- typofix

Changes in v3:
- document properties for VIC
---
 .../devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml |  8 ++++++++
 .../devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml  | 10 ++++++++++
 .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 10 +++++++++-
 .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          |  7 +++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
index bdf981781bd5..fdd3fe9e2547 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
@@ -68,6 +68,14 @@ properties:
       - const: dma-mem # read
       - const: write
 
+  memory-region:
+    items:
+      - description: reference to the video protection memory region
+
+  memory-region-names:
+    items:
+      - const: protected
+
   dma-coherent: true
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
index ce4589466a18..881bfbf4764d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
@@ -57,6 +57,16 @@ properties:
       - const: dma-mem # read-0
       - const: read-1
 
+  memory-region:
+    minItems: 1
+    maxItems: 2
+
+  memory-region-names:
+    items:
+      enum: [ framebuffer, protected ]
+    minItems: 1
+    maxItems: 2
+
   nvidia,outputs:
     description: A list of phandles of outputs that this display
       controller can drive.
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd562..3bf06dcd6198 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -65,7 +65,15 @@ properties:
     items:
       - description: phandle to the core power domain
 
-  memory-region: true
+  memory-region:
+    minItems: 1
+    maxItems: 2
+
+  memory-region-names:
+    items:
+      enum: [ framebuffer, protected ]
+    minItems: 1
+    maxItems: 2
 
   nvidia,head:
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
index 8312b7699cbe..420a1fe5ee80 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
@@ -98,6 +98,13 @@ properties:
     items:
       - description: phandle to the HEG or core power domain
 
+  memory-region:
+    maxItems: 1
+
+  memory-region-names:
+    items:
+      - const: protected
+
 required:
   - compatible
   - interrupts

-- 
2.55.0

