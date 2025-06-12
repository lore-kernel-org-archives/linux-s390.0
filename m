Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF11222593
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716905; cv=none; b=GXp6kanWi9i7UixVTNXwHGxlttKKDkEmW/HnqIcBWqiuxjPSwJ/sicWqOZpYeKAAnp8gYcPuc/agmgdA2+cuOEuWJXCtF/HKsVUa0FAIkkg54jhdleCc8qaVaW+cl7cqRSsmfq2jUOqsQyBBYBdLFLRItacCEO4giJoJP5pLuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716905; c=relaxed/simple;
	bh=+KqSikubmTwLv67VH07QK1YJvLomsd5Sw3lt8h/T5Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNRqfMrccixWa02A601jt0PdK3VMnzoQsRe4UydNwxkNi/il/PWttTtVAjkkxGvk2Pmd0DWneRngbVB4Y5AIWbedFTU9EAfBtJJrX89JxYWv9atJuKuWs6d4O8ikjWQapjCw2RtxBBhUN9mzdXNLrg95pL6y433Sono8me8u/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxZh/hf4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxZh/hf4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749716901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuO6LfcqvanLNT/SurJr0xI1g963JuVICLigVyy7BYQ=;
	b=SxZh/hf4lH88e4FaL8K+3BNhAEzEFijYRtOukTko/SGVWs6GQrh99fqfUPdf+INg7j7QX1
	qjMuhUmdqbl3JyDw46gFlfCdpt6p7B2AWPRJ6Msv/eFP2/tDcWm/GVfITHnN8X7XEamL1t
	PEWkz3cdalwDXwvqhlxmnhXUGWXndZc=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH 4/5] mm: use MODULE_NEEDS_WEAK_PER_CPU instead of ARCH_NEEDS_WEAK_PER_CPU
Date: Thu, 12 Jun 2025 16:27:29 +0800
Message-Id: <7c3402b5860385e7898f1f854a5cf83d4c5dcf65.1749715979.git.gehao@kylinos.cn>
In-Reply-To: <cover.1749715979.git.gehao@kylinos.cn>
References: <cover.1749715979.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

We have made ARCH_NEEDS_WEAK_PER_CPU a Kconfig option and
introduced MODULE_NEEDS_WEAK_PER_CPU,so we should use
MODULE_NEEDS_WEAK_PER_CPU instead of ARCH_NEEDS_WEAK_PER_CPU
in all current places within the mm/ module.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 include/linux/alloc_tag.h   | 6 +++---
 include/linux/percpu-defs.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8f7931eb7d16..f349cca0ebed 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -88,7 +88,7 @@ static inline struct alloc_tag *ct_to_alloc_tag(struct codetag *ct)
 	return container_of(ct, struct alloc_tag, ct);
 }
 
-#ifdef ARCH_NEEDS_WEAK_PER_CPU
+#ifdef MODULE_NEEDS_WEAK_PER_CPU
 /*
  * When percpu variables are required to be defined as weak, static percpu
  * variables can't be used inside a function (see comments for DECLARE_PER_CPU_SECTION).
@@ -102,7 +102,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_shared_alloc_tag };
 
-#else /* ARCH_NEEDS_WEAK_PER_CPU */
+#else /* MODULE_NEEDS_WEAK_PER_CPU */
 
 #ifdef MODULE
 
@@ -123,7 +123,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #endif /* MODULE */
 
-#endif /* ARCH_NEEDS_WEAK_PER_CPU */
+#endif /* MODULE_NEEDS_WEAK_PER_CPU */
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 0aeb0e276a3e..b4ecfc3a7b2b 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -64,13 +64,13 @@
  * 2. Static percpu variables cannot be defined inside a function.
  *
  * Archs which need weak percpu definitions should define
- * ARCH_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
+ * MODULE_NEEDS_WEAK_PER_CPU in asm/percpu.h when necessary.
  *
  * To ensure that the generic code observes the above two
  * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
  * definition is used for all cases.
  */
-#if defined(ARCH_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
+#if defined(MODULE_NEEDS_WEAK_PER_CPU) || defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
 /*
  * __pcpu_scope_* dummy variable is used to enforce scope.  It
  * receives the static modifier when it's used in front of
-- 
2.25.1

