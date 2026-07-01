Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854C48B382;
	Wed,  1 Jul 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922148; cv=none; b=J8EgqKDRhIU5QxuOS1U22z5wysZ8NJe7h5va6DWCg0qIaGIxDhNZZrs6swmFawY2UGL25HH1Xnycxxuve2y1RQxxZNgiGknGWU9am7Y0Z+LC731w/5JKCz68ob/da1KQgYFiUvnvHf6wpApXNw6wrlOAdDV/kkDbjZQz9SugwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922148; c=relaxed/simple;
	bh=nMvDJcEMVjZballZczNLhp/sqnI/dLZtQ3LCgLlGVlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5V7e/ht3gTlB3xtzQGqqEFVtyzZrmOSfgS9fcOYtq4//ZJu2ODPJptUugtu3bix3l6bkWA75KTZ0XBR1upnjX0VAXVZaz9P9/8SqjgCqiEdRxQa8SwGQ6tq8k/JQxpuVAx8bzudrFDTNfqDeV71c8rk+q3yTaAgEBJ6VzI/wRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmKqxCAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmKqxCAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E331F00A3D;
	Wed,  1 Jul 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922141;
	bh=iYZqazgdSolQpQy+2sB7A95oPlBKAYAbvYuR6Jmn1N8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fmKqxCAW9ZQw2ij76EHSisJlZt7PILYObqadJGxOimfQFEaoyLw+Lww86/xhDz60/
	 mu4xeYfSGkyL/CLFsLSGFJCl1wgA+kGQvEA+7zMjlQRW/jowerVR3ydGOkHCC9uDVb
	 3vGfLhdbIFJyvp4Hl6XXXCHnOxNGYf1Bg86Shtku9U3u3lSf/EjyKB2uynKynHTAN2
	 SxnF1/t94D9lpIshIGAvJXaf3PZ9520rGqzeHDETNAtAs759d3zd9R6KkVrOrrjflN
	 Z7A2b2DvDJXsuIR/ONvBvZwEvsmeM+R9BFQitZv4mqyZ0MAl7d9+Jelh+/f3q0a3e1
	 PhB8Q5GD87lkQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 01 Jul 2026 18:08:18 +0200
Subject: [PATCH v3 07/11] dma-buf: heaps: Add debugfs support
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
In-Reply-To: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=treding@nvidia.com;
 h=from:subject:message-id; bh=QlmXWpcpy6Y0NBVntHIBMLvS9FZD2uUVsJ4SeVpIf+Y=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqRTuGp+zb11y66T9UFttG10WqjASBRaNLa3apL
 UC8kjL7aY6JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCakU7hgAKCRDdI6zXfz6z
 oZenEACSZnZGdi9oDEskVtAmQ7Iq+Z1zDTxEt4m8vq8x+Tdli9Lp8CM6EoNlpa2chjq78Z1BkY8
 CI6atjAQw1htYZJT5hVMoDluRn3EXAdH/T6z3JGodHS+bX+6rd7FBEkDKZLkTo81tv7tr2T+ATw
 eKO4g+DAwcexRYKeRnrr8cRAnlhEHSeUCb+byIYHYMqtqDnBSZR3kR/4nHrzorvikJF2ifD/sKQ
 gcVLkfBN2Zb4pr3FxtEdKzlTNlOmKITsRZ+sZEBtO7opp3NwJFImhGPzBAjWs6h21kPinPhFab4
 ZDG6iwuDXGegKGLwJ8rE2eShFeikOV5yXp4ZTPfi3CUD19I39n48nh9j3MgbM7JdmPZkj9aZrHw
 ncVZ2/xWFWw4zxwr6fkrHmXOEDg9M+68wn7+O72Pz/YndLVyOBq6DvsDmTHvSIz02AMeqlIQFB1
 A43oxA9Wvk7q7PHXWCUzu2UEOjrJp4MVrsm4z7YI0RgTy23l4dxRKDGO1C6LZBIGkP+Mvgby6NK
 FVZBFENxayPwfxHZzHXTJS8vIt3pZHrzwteSy+jGS0s6uO2NJoa3lBHLfbq0iE9xLpoUSu7wW/B
 G3r78fDqHtQft7uMHo+16WCcD1trjs8KbP+fQBJCuS5/GEKvjnxIgj7YhRHnHN3CTFKk/pn7rna
 LanK40WLvws7xzw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/dma-buf/dma-heap.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-heap.h   |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index a76bf3f8b071..1ceb6ee8c05a 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
@@ -224,6 +225,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)
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
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("dma_heap", NULL);
+	if (IS_ERR(dir))
+		return;
+
+	dma_heap_debugfs_dir = dir;
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
@@ -298,6 +339,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 
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
@@ -334,6 +382,14 @@ static int dma_heap_init(void)
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
2.54.0

