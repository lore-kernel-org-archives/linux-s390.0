Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723F18DB1A
	for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783990; cv=none; b=d49zyUcEf3WrHlbeAKysSCvWBYXyC32ts8QT12NKL7HWo5L9oeGpXmjUJCmGbynHXXLn72mKWPpk+CMYr5AmfWvqyv6KPbW1ieQoSFs4NyVuR1UlGH7pdraX6zKgjRxxhdICVZCTAqyVQWPLZqz6o4caGsni3Ul85GIenyB+qqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783990; c=relaxed/simple;
	bh=w5lvnxdf7nXQzABIUueKfM2G7ZWWXlgNS18Oez8SQuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3Ci+t7iGp4dOibm3EUSZx1xZjCDUPGelozPYei31Ug3FTNNQBHhqiurdQNGyfSuIgkeuU7fj0hanJLmbQw3j+oeN0KO8DAP1I22A4vUJKMLM7s9wJ/HdcC96FsSEoYRMIrKdxRHXEMFmaAsPzLQxU+DeieKqaYRIff7fya4tyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VmrD+p0k; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VmrD+p0k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749783986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FK5GViGeaS0eKXb1CGklOs8Lcazv9ig1sTbfs/WnUDs=;
	b=VmrD+p0k1+hGglgFMyD3kLFYXh+SMTmVlSrsl5nL5sfKCHcBwrkI++kzMSRi0v0hWA09jU
	Awtwc4OjwwnWnH73KWQTYi0o6jxXhNdzlAKgW0UJDfP8s6cB0zbAizCjx0Z9fBoQOYtHrV
	eO24fkJuo68McBVD7RaFUCIN/zpBRWU=
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
Subject: [PATCH v2 3/3] mm/alloc_tag: add the CONFIG_ARCH_NEEDS_WEAK_PER_CPU macro when statically defining the percpu variable _shared_alloc_tag
Date: Fri, 13 Jun 2025 11:05:07 +0800
Message-Id: <099651f46b0b57f6c7890a64608dc7ca44df7764.1749779391.git.gehao@kylinos.cn>
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

Recently discovered this entry while checking kallsyms on ARM64:
ffff800083e509c0 D _shared_alloc_tag

If CONFIG_ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
s390 and alpha architectures),there's no need to statically define
the percpu variable _shared_alloc_tag. As the number of CPUs
increases,the wasted memory will grow correspondingly.

Enclose the definition of _shared_alloc_tag within the
CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 lib/alloc_tag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index c7f602fa7b23..14fd66f26e42 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -24,8 +24,10 @@ static bool mem_profiling_support;
 
 static struct codetag_type *alloc_tag_cttype;
 
+#ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 EXPORT_SYMBOL(_shared_alloc_tag);
+#endif
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
 			mem_alloc_profiling_key);
-- 
2.25.1

