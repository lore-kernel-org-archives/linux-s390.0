Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DB481FA5;
	Fri, 14 Aug 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721390; cv=none; b=Vg+Fw7zXiUgpLJ0U4yj3QCPX63utVnAJY6g7I/TzPopd5JztPNCEqMt7sULqJk1D+UwFYVv/eyFkE8VUfn9DLtpAw8+nmzuF7/+2BEaDcqButUfSxpGFBsEj0puUHSydkc3TLuCWujvkqzdJOrBrox5zMqSPsjRdI5s/72pdmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721390; c=relaxed/simple;
	bh=YKAfeUFKRAPjvhpRQgV8Bmpb0xoRLjn0rVI26lpgxS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0xmEtxwxcLk5+70k/wxrQdju1ZHTPOihhZvE3EBxS32yR1g6t36+HrOTECoJeivwSa/BdeTpKWmCbkwvWexoFvkyCLvHE5dSUyvPyCLwaONjVDbPZa0pfd8sx/V80EAvY2bfhGkv+QDmJIqrSOoPJ1apV0Db7ElJsc3JXXtXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln9neMLZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln9neMLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D21F00A3A;
	Fri, 14 Aug 2026 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721389;
	bh=2BzkMYY6PcCnjt83f3h4QxpYa7pa6qO3m5eLZk1ygvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ln9neMLZiNxLoktO8600yFMf9c696Sy2dR+14AC2Hs2g+Xi89Txg/bSadDBOpbwcv
	 BjvkAaOqDRQNOHgRnewOmAypSnsKE+p2FrMqlmZ2f8C+cVq58bhg6cssdS3UQxJfKI
	 4FYONwhecSKXCZPQ+MF/0p1j/7vXqbFHU902HXezxWfV29DnYWXw43Mql6vCbCX0Uw
	 PUFhHldktEKV7l/kU0JqP1PDRyq2wf7e8rQap5YtVkKbAoJJVLBtknA4AFMTdxu7VN
	 0tsKp78ANWAq5hhJVzfZBWQfwVhmQXBNALrKFZv6gzQIZaf9k6CQ9cYKzWTXlCcb82
	 T/Ew0aZzK5jXA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 14 Aug 2026 17:29:14 +0200
Subject: [PATCH v5 06/10] dma-buf: heaps: Add debugfs support
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-tegra-vpr-v5-6-71832b5d0246@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=treding@nvidia.com;
 h=from:subject:message-id; bh=HQOwe346eKLILGUmI6Jj24mMizqBZC+UN1JuTqxPA6o=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRYmBB73yTjIp5WYf1lpDC/x5XoUQVQFUBsE
 No/1I1LYFCJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80WAAKCRDdI6zXfz6z
 oZWhD/4hADdFVVuUvAoZK8vnwfXJ/xRPQxPYCgpzlO8eC/xBPUIs2BUZCanYUlRY/Z96oGX7ivB
 u+VLQ/yymD2KtVUK1Cr5+MZNleFgmE6dONc2BdeToY3RfHjQq1apoi+paNZvQeZIhMH77FHFGbc
 kpgO9CLRwB+2rMDRspKHQoxXt3Iz3v3DvXJsZQvKTEwlrDGntDF+kLyrihrF6zLL/8aXexV1aX9
 UAqqpn/zR04SbLtYQT08gdMQ2N9fuxXs5V+DEKW10Pq7UmbnEp0YzH9bRFAs0X99ULNLbggnRPh
 ikGbklpZPQkphOWasX007jnCYHoPGGfVannQFtE+lCH5KgVA7yRqjaYyF0/GEpZtIJBYBVBu6TN
 78xWK9CyM6mluHtF4kr3sF0b3zNf/ElnTuqgCVRrq5WIqG4CF4mb3yuubfvDkPAUL//ToIfmVD1
 +JnhzKzBJqKSyxC959QmwhelV/tls+oASyCVKUMSf1vwc+1PdNV+9ViaCDF5gXT+4SrVbXAXoPA
 fzKUZ2FmUvkjCxr+6BMxmnZLmRhFs5ge/h+xS4FDsZLGdgtT7bQJqLCL+oZFoM2A79WT+tP5cmt
 52I38IluSVfOTmhe4upYRzOlQUw0hLB4XcPa2mI8dPQWD0/iwaaZGaTIoQg+c9qj3TiWs8Q9/p1
 3YgAjy39e97CSgA==
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
index 3937dd41bb0f..f279b8fdd3ce 100644
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

