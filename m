Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8B4734CC;
	Fri,  4 Sep 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518726; cv=none; b=b1W00e4GAQIQsuDIwLIxZ2cOI5W/HZVyL1Hk1fe0e9sUAvt4e/UEAnxhUTQGGHr/0YZ+MxQP4zoWZdD1UVbKXD5cn4QsD1NXOAG56BDkSI4/+WZmHWFfbbjXWUMn3jup5k0E8qNmTe21c9jV9tGAjZLgC+46hW6jHHtdx4Kc4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518726; c=relaxed/simple;
	bh=KZt42RcI2xZOV6ZL4xNzHGcUviEo1o5J+l+Mdce427o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iprRD7E4LlG2llYGpBNpq+cK8sJtX1hCC8AkvtbNi3wBfJLb1h9f2Q/701mmDkTQHKRu1gspjvhP8JedEwvfsAYgk8XslS0I+W1uoMwPYQ54UMOdcch2okNz8pDE1VVjlvKM+n4QnMCh9IAV8P9OUnWJCFxm03CgHkYlJs1dKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7qjQCNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7qjQCNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5888C1F00A3F;
	Fri,  4 Sep 2026 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518724;
	bh=eBlEuAoqOked/LKJu9mRAOEywcTF2CIu7f/dTPjyTCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W7qjQCNSCGZXXbyc8J6OTl+dQX2qqTPLVjOZKbya9DaDtLYXNDq7yOSjCiH1Fzmgo
	 j56j7wBwCKgUFodXzPAzL44OFOVSiFiFB0CvB/ZPoNY++4LLfUpv/1blCs5hrACui9
	 7s3xQ8px/dRmqO1WqB7SNO1OwaM8sT6TH0S7lQdEJ5iufiYOMh563huoUusBqCgBCB
	 zhHSeRVxDESEqeAASr3hnpXE5pStPPx3KVcFlwkWCZcMWP/CilLTYfN9qTVoErlRHl
	 4e5cB+aYiwobAfiBrDJkRzORM9Qlzq/j4AcH/+K0EYc4RubGDf6QCNgHP2XBX7SfFv
	 lmBN6OJRScywQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:53 +0200
Subject: [PATCH v6 02/12] dt-bindings: display: tegra: Document memory
 regions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-2-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3649; i=treding@nvidia.com;
 h=from:subject:message-id; bh=pBYGfO+OoRCfoGlySA1v5aSrpzUlJ6EhDp5j2u2Nips=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6g4z7jq+Sip+gg86QNRWNnQFHfWBE9B9un
 WUw4njXGJ+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 oTHMD/9TaZE5hzVAIbzqNa7syKW4k6S0ycYYYrVebi+lRO2QXDPm/tiDrM/ofrEIhvjWjXhW6Sd
 vhsLe4VBQt5yWfvAQpdM7PkubSeMTlUl/kdcw18kKnGBzhK8BLC1EzF6+JsNcBHxlCj005NiZnv
 EGUWrm6j4L7rV0ZB56H/YkwhfZakABtZzFtWy1Yfq7pOhVfJsrSkvNJBqJuH9DAAmuGIHEckjee
 5ExquwU8/hHHEod/bY8sGI4eDSLUOlotFszxJwKNPVm1uTrYp7Nm5G/2AysJTTQFUJi3ZDtQL23
 EEv7fLVyDGez4estd42id989nAFMj9+W74/fntP858iqMU1Nto0lx8CN5vLdGFgbl31BK4xjPk2
 CMDIGbPh9gAr0h5ODf9C2XizTrcP0s7kJL7pDwKFcW96yuRRWeFt4AzlYmVjYYoy4iD8S57QLM0
 iszSa/8npHYY5cwXNF1+27CG7wfaeEoD86ohEqnukcb5BtUvO7yLGGPT1FSakUf9b95savaDHDQ
 48J3/vfeH9HEU7THe9IdVTzFGFEZCQamYrYCA/dkcc9Ba3fMbJhJiWd6yXSueej1R/H/jm0d34t
 633FWGP86kmFzarMQXxJcNsP0IMtCM02qoW1TN0rPTFHOzlA16p6cgHvrJm95lWm0j/lYcXDkZc
 FajeSlJPG5eUtcA==
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

