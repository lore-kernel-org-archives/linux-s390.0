Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383547DD72;
	Fri,  4 Sep 2026 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518743; cv=none; b=mzTY2cBA4HWiudfxQtdxbkg5T74fScGzcqb+elYCbJXYZ+lbqfHKhDj8Y6zx7hsQkZgxNpUuTosLWTObvhxHWbczHAd9Wb4XuHo3UlSyKCrOBqyIrjvYarDRG7ysiEtBhPmMP9lZiVXZZG56QYEcVg20rzvv0+KOcVslYxx8S58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518743; c=relaxed/simple;
	bh=jgi1JGrUvwRr0PDo4wjIkRwRy5XaraZLoXWlTBSaki0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8I5sy97f/0YE2jmD6lBaXfICzYdn9L/ydUNc5Q+BgSmRSrkjYdNzSSAlRrnd2KPcEGYbwYwmj1s2NzCBVHK5/E7CU7MjYaQNBw8+A19BXMyhEWva+Wqylb9US0qzjDDILXguX5UMsUHRqZO4SQlEI0auSY3Y8SyrouJADfErgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ07LRTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ07LRTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AF31F00A3D;
	Fri,  4 Sep 2026 10:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518740;
	bh=URDYUrqbvoFrys39J8mEIELRy5W+29S6/Co77OGahWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MJ07LRTmfws8dXur0isr7LB/HULUxkMqgSEAyRbIOmKqouVwpQ60B2f+U8uXM5gcN
	 0e4rmcdkfnZ1f/cgp+89IGLqQeroCxFS7+p8ooIVtBQV/gxf7yM0MorJ/2W3l60ERD
	 SqPP8/rtWDfUGWUZdJEkAnHQEBxvRcWfTbEdpPj1xkmjAEcmQ84sXaM03P15lX2dIN
	 5VIPwRCT2W5u7oHyh+uqVSCN8zxCw71ovjataEu9cUYRGZv4qUUVuiVPd8YliRaimJ
	 8n32Ozp6KtRjSV9ii433WdtqaxYPsEu3Oguidc0Wr4taDVXHAvxPHnJRkbEh+VmmwD
	 jWI3To2QfeVRQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:44:59 +0200
Subject: [PATCH v6 08/12] dma-buf: heaps: Add debugfs support
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-8-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=treding@nvidia.com;
 h=from:subject:message-id; bh=PTbCupvjHWmMcXwEcqCBr5NgDg7Tooca+dUOmGKhZ1w=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE6C4dwHTnCbC5FbKmwaT00Do0hU8YNS/+jY
 a0Lv2wvQJmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOgAKCRDdI6zXfz6z
 od3iEACHrxrMF5hDeTgSv/upZk6DbDhcOknfUoMDoE7ao2NckqEMBYrL7W4jHqK4OEK7Zz+Dy56
 l74sJCpjbOE+EkqXP/sHP7Dcowfz3/rUTKNLWMrH4GjEGlu7zCzUfqe9PlPOhT/f5oe6tVL3Q+l
 4fnwRm1olqNLtZKAaffoZQDNLjIFBhQaOkiSocS72I+SMAGt3LOPJmfGNW8bruRDtRjbPbhwrFM
 WqgBdknbnk87TQzuuv/Zudx5uvzXPtUuPjijyUjN+8gaRNGNhWwHmP99qSG5d/B5fdFRKj+I5QI
 dTZRvzzxb/PUNF880+qE3wRTxd/6djnnZtAnFfPGRiDbcN12cApJdAYSaVOm5kRCMx0A6V11rQR
 uDMvgB/adcG3P3T5x6/CVrw+KXHOR/VCGHa16YGbjq/ajwJsGyl6NAVG9vtaG5LfS6pcjlH6HRh
 m6VudFk+pfDpMD0nWlqiHyk1i1i3f3N17D3B0rtg2YGGRqWhikWK9gci3YyCRCr21+wBfRL9zMv
 qlj3Zcw1JoK3hGRi76bXm+p0EULU2PMdnR+MA7z83OdT7phjtBsH8aJTKXrKZIGuBDwClD5mp2h
 9YZqhM/c6XIMG0xogYOIiMIxQZuqifr6ZvL2iC3/JdsepRVwO+hgJzwNBTj6zC5KHqX60d1rizd
 XXb+4oFnVut6Zsw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v5:
- fix failure handling during debugfs root directory creation
- add more cleanup to the newly introduced dma_heap_exit()
---
 drivers/dma-buf/dma-heap.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-heap.h   |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8a6c2b6e0cc6..65c80dac6500 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
@@ -225,6 +226,40 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 }
 EXPORT_SYMBOL_NS_GPL(dma_heap_get_name, "DMA_BUF_HEAP");
 
+#ifdef CONFIG_DEBUG_FS
+static int dma_heap_debug_show(struct seq_file *s, void *unused)
+{
+	struct dma_heap *heap = s->private;
+	int err = 0;
+
+	if (heap->ops && heap->ops->show)
+		err = heap->ops->show(s, heap);
+
+	return err;
+}
+DEFINE_SHOW_ATTRIBUTE(dma_heap_debug);
+
+static struct dentry *dma_heap_debugfs_dir;
+
+static void dma_heap_init_debugfs(void)
+{
+	dma_heap_debugfs_dir = debugfs_create_dir("dma_heap", NULL);
+}
+
+static void dma_heap_exit_debugfs(void)
+{
+	debugfs_remove_recursive(dma_heap_debugfs_dir);
+}
+#else
+static void dma_heap_init_debugfs(void)
+{
+}
+
+static void dma_heap_exit_debugfs(void)
+{
+}
+#endif
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info: information needed to register this heap
@@ -299,6 +334,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 
 	/* Add heap to the list */
 	list_add(&heap->list, &heap_list);
+
+#ifdef CONFIG_DEBUG_FS
+	if (heap->ops && heap->ops->show)
+		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
+				    heap, &dma_heap_debug_fops);
+#endif
+
 	mutex_unlock(&heap_list_lock);
 
 	return heap;
@@ -335,6 +377,16 @@ static int dma_heap_init(void)
 	}
 	dma_heap_class->devnode = dma_heap_devnode;
 
+	dma_heap_init_debugfs();
+
 	return 0;
 }
 subsys_initcall(dma_heap_init);
+
+static void __exit dma_heap_exit(void)
+{
+	dma_heap_exit_debugfs();
+	class_destroy(dma_heap_class);
+	unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
+}
+__exitcall(dma_heap_exit);
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 648328a64b27..1c9bed1f4dde 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 
 struct dma_heap;
+struct seq_file;
 
 /**
  * struct dma_heap_ops - ops to operate on a given heap
@@ -24,6 +25,7 @@ struct dma_heap_ops {
 				    unsigned long len,
 				    u32 fd_flags,
 				    u64 heap_flags);
+	int (*show)(struct seq_file *s, struct dma_heap *heap);
 };
 
 /**

-- 
2.55.0

