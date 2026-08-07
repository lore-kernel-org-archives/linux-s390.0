Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542D47669C;
	Fri,  7 Aug 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118098; cv=none; b=XMmcI3JRdXlRfnDSXPdW4YYqjaO2WKjfyoclDqkcBTrIkD0pDQanAr1zSDbOysDZpHAWpYXjgNlxQeSaY26tlA4ghUvrWYCGIyGHNyPk8oEtLiM0+8lqQHD4P+8gcaW9hDypewaGvFBLMmkKHNPTz3mQURJAC0bgbBKwOrNSiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118098; c=relaxed/simple;
	bh=VYimRZboUo73NyWATKPUVRWs3Ji2b0asaURT1B2xO3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fErRlscESZ8WvDLWMOfnwkLwN52BwlDZKNhS9bgU9A+WX50w0pRNdhDib5r1zn/BBEuOvp5XsmOeO8JdGVZzAFpLnlyCHeAF4oSh6EnE8TULNdWgo49aI9/go1nrbd7PmvdDlwZM7AjpZVqJkX7+Jb26+4islLDRLNDsxbvpGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUEFBcDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUEFBcDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316B81F00A3D;
	Fri,  7 Aug 2026 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118095;
	bh=6wDjxUjdvFqDKE7ihsNogWEq3nkXdKHutOxMVaNR4wo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lUEFBcDWqEtThoK6tc3nxddKzJe1BgQodn0goRpTcmjY0lcM22DQBkMWkv4gLSyq4
	 mtMnd72OftgpI7xVHzSOu9/2X+AKglVA3ebalGrTzmM2eTyXqXYJoJbN1IJ1IjA1Mt
	 9SxqOY1pkYYD4pWvRCReDTOvurB0QhS81JdiRrE51VTq+MyQODh5oJ1IaUcChqbYTr
	 vh3mUYwlBRtPtpU+tL2lBj3f5k1MHKLjLB2Hf8r4q5NuKyrDwFvichDPdIc8pkzlkq
	 v//itfaZ69ELcWZa5fkwYyTKzApzDLXrHhaM2wXnfa3WZHDUqWi5pfAZM9V/bIqdec
	 RUTuFuUEpyYfQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:22 +0200
Subject: [PATCH v4 02/10] dt-bindings: display: tegra: Document memory
 regions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=treding@nvidia.com;
 h=from:subject:message-id; bh=OEbbK13gPXvWULmBiveQ1tyvB4IMXtbDFRxjKTDEMPs=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/G3HrHADPh/Ggndr9/FKGgb6VqppJr/NF9L
 +/yWDD6NkuJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xgAKCRDdI6zXfz6z
 oYXfD/9Fc1X90Pg5FyqxkYpZ7BOZ2ex2bRQheV4r3UOvlCp0A3WBc5aUjgqIsDyYehKISoSRfSC
 MDaOdZ8pBxT2BSdBfkArlaMQTMLJ/H567FU74PNLwiarZOfqV901vdBRWFRcONvfoWEPALAHUD7
 fpa/p5r1MeLxONleVuq1YFijGYDCC0M3l2WEdAWUsY/9E6PTPaiNwICkoxhY7tKAh9j5mDEgTk3
 s4KWx8BNKdWwrqlLuZ4uKQSqp68NysM1LkYSdtPCVVX1lPkqPATpZ1C9X6JmOzu2MiLr+w8CGqM
 2O5JxmI51KzP+dmKyHeuIZMkkLaSbOyGa3xqGd7mCO2XvlhoxWewWCe9AI3tFDrjHVe8+t522ig
 5h7jCZlBVszKpLcI//08B37OFdg9fe+TqhWuSb0FZ930UUWv3rlpWWCWLnj3R1jMM6lOqKsJeYJ
 rnP96XEPSLMSJSgWiovbqx8LF1B54UaH1E/K2OSrsJSR/YgLAbeW7w+Wb2ruJHSJvuz6OqGDXBm
 kTYkvP8vb9494/B3hQRJ1GuYEjAbpGy3YPt/tHDabflvZyUSRws+X/J7b87upvpUMutwwWiPRa5
 7qsp2Vdz19nC+0hqoC4HAgHOIS3F3Drl+t1oTGkLadJhjxB8ZboE43Nci/rwf6PQhph/mjvFNYl
 Tgq5MAtxJ26oLnQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add the memory-region and memory-region-names properties to the bindings
for the display controllers and the host1x engine found on various Tegra
generations. These memory regions are used to access firmware-provided
framebuffer memory as well as the video protection region.

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
2.54.0

