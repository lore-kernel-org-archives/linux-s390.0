Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DB257451
	for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783982; cv=none; b=egRHdg3LdZAeGJ5tVj1SuDtQs3UH/8A+/AclhvMs6aadHoZYqHqy7HMeSWfoTbcLObffZ8u23uHzeRYmMq1DpwefBdfYVWt3OjsWpRSWXBWG12sin2P8Gv8KQixbqHsbJnjOBC0lMQ4+H2hrFkbzvv0uPazOD6+KnTEsYDQRrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783982; c=relaxed/simple;
	bh=sA/cHPXepmhSQ4sf1CJGrbqHxcSeK1Ifu4NpXSLjcwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tie7TI/QpgAmLMeILQaGEs4+O65a26vFCFfI/Hm/4JxfdM0wA9h8cMC8xKTsxuCTDO4eqexavr9Bf7n8oldftgZgnwpKDExZjazSbgf/CpLtu+6PfUjb3BVAyi2hxvWgte+2f06COEDbXPC+2kXWS3MTtPgkvFl5OjlRhK/A13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cjEzBzVn; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cjEzBzVn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749783978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1KqbN5j6IJTznE7UN7VxaAri/tZdWWDiyKWfIujmkA=;
	b=cjEzBzVnQN3XoxmjsLUuvaPi0fjOR7G6NRzIC9eUJXK0nCzokaA3geR9L662GweNhgj3MZ
	/E4JeDWdEc364JE5lkCXlI1vQMd7Qx2aDIWNr2pop4uPQIhS1I+WRX/1lWW8anEfcNoBDD
	12X0vDh4qfPcWY5/KfCwGjzaMskKAB0=
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
Subject: [PATCH v2 2/3] mm: replace ARCH_NEEDS_WEAK_PER_CPU with MODULE_NEEDS_WEAK_PER_CPU
Date: Fri, 13 Jun 2025 11:05:06 +0800
Message-Id: <862093fa9c9a9e02ed5bae32488b6730aed71dc7.1749779391.git.gehao@kylinos.cn>
In-Reply-To: <cover.1749779391.git.gehao@kylinos.cn>
References: <cover.1749779391.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

As stated in the first patch of this patch series,
we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.

Previously,ARCH_NEEDS_WEAK_PER_CPU was enclosed within
the #if defined(MODULE) conditional block,and it was only
needed for modules.

So,replace all instances of ARCH_NEEDS_WEAK_PER_CPU
in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/include/asm/percpu.h | 2 +-
 arch/s390/include/asm/percpu.h  | 2 +-
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 6923249f2d49..b164d3720e9e 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -11,7 +11,7 @@
  * Always use weak definitions for percpu variables in modules.
  */
 #if defined(MODULE) && defined(CONFIG_SMP)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 #include <asm-generic/percpu.h>
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 84f6b8357b45..0afc7ce9c26f 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -18,7 +18,7 @@
  * generate external references.
  */
 #if defined(MODULE)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 /*
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

