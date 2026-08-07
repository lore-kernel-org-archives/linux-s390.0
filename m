Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487947DD48;
	Fri,  7 Aug 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118108; cv=none; b=r/aLT97jKunu5zZkoZSAXQWyQawicgk+iBhxZPEgGM9QBWWAQPfWfQrb7sL2zk76gnYWIjsRTjkIoEXcJZ1ZjCzHf9f+xC65lx9B/vgwcr7o+KcMQ8ARNdrtFD70gatY03AkwbetKLLkipSYlqjXOaACUYxylhevWnxCblHWtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118108; c=relaxed/simple;
	bh=/lyK3MH+KrpZjswhaD9n/Vlx7awF83GKICAteNU36jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKlegBkh7CmusSdhHff2iZxlvou8AFFCQvb1QK0qHNQfT/yYUkaST6giAwe9gz3u2+haS6Pl2+MkAjIvBku2a1MtiCgh3h1AInW6j4L4+sgn+xX92TMJzG9kTx/SlqOZwVpcvOmh7iJAiWABfWG1UWFJjbC7L/eC/GyU+9CfORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1f61WUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1f61WUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A151F000E9;
	Fri,  7 Aug 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118107;
	bh=hBY0mNZW/REn5iOQM3Li4waxIa6sH7N3fTfxvJa+TnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D1f61WUJJ6YAPxkItLUb7i+3Zh9xlMKIQTsURajVXtrq8GWpkNL+OHZkRdFYDT+6a
	 NsEAD1fEcaqGhtgBNtgPdcgXcRz6s8iOlIdQ9aLj1b9M3KVNOr9n5Vker0SNTgsvp1
	 FS6eQXGObdVoZCILHiDKY/sp6BmKKJPXBLvhuHhM1G2FNth92dHfXBhi2alU8ZmHjk
	 ClFT2TxV2Bmk3iP3zJ/hRxz4CCLS3Fz0I7q4EprOyux8hzx9prbeVJNnduGEKqrI16
	 yDUSOUXtk2UcbAtMhzdkLTUXPAZ4l4huOwAoSTKh+SAKG136mcOCAdFso+k2Dfc4B3
	 dHlwVskQDhTAQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:26 +0200
Subject: [PATCH v4 06/10] dma-buf: heaps: Add debugfs support
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-6-5510d16af89e@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3104; i=treding@nvidia.com;
 h=from:subject:message-id; bh=q55jzM9GjUFXxiIP17zlQgzxN/ErPjq/lyQMEmgYzWc=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/GOOgS1uAI4009/HTkT/0d3YyLidCbxD6T+
 Fr4Z+GDZZSJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xgAKCRDdI6zXfz6z
 oYYXEACHZrjzvYw7N3iwfVHCNGu0OX/MxCGBHlo0DZkABWuDYbwnY1fYIciulavfoX7hcfGEI2g
 SWczrNTtXk6sWPMmvJ0Dr7WDoO9BNPu6+FJfENIgcPmkyd2x0mL/+ZAWv56hP1N5ZoZ541QXWKi
 HYLkJ2wRqcInnP34Sum79Uz3xwTjubyC0ql64iaU0Wk4FgdzgjchEjEtwYP5tpfMeVQeAc4Yk+9
 lay5HV5APKPzZeKg/QPmfbKcJ/NA+3UKA+4I8dVhjNP7c3ZCOzDL4swYuESkDnAbZD8lwCFyER7
 ynYlmRDnGHnFp3/p5uJ5C9XK99LOswGBCS3IVdb+aB5g54aWv4Vs9/VvuQjMExenrKy6xCikLEX
 P/rKifVp//+fTL+948JAWRjR3xsxnHWltaqLgjhmmE1Xmu4Jrv6A14Sg8iP5WXGkDtU1KQUpAUX
 e/VYUY+gWenaIuP+sf3o6xfsNzVjOFyA9ptBZZ7IsiDKY23+FbYotRdt/ado8Dd4DFACA02ueLd
 J2LlbpGqQew0GXMeJbEDxnwpMU8BDF1v2F0s8UaK8mT50//0GjaoVTfq6dvi2ZnNea552TJg9Se
 u1OI3+L4cf6VqFJ49h6Cmcs/rL3F2lqXwGq7EPKCLhptVV44LFHEkCHNJ/k/FNvc+LvcKssEFo1
 56gXgKq3p2yWm4w==
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
 drivers/dma-buf/dma-heap.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-heap.h   |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 3937dd41bb0f..389cddd07c8d 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
@@ -225,6 +226,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)
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
@@ -299,6 +340,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 
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
@@ -335,6 +383,14 @@ static int dma_heap_init(void)
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

