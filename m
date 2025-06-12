Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492F22173A
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716880; cv=none; b=t7OPolypXq0q3DZJD4eDMB1MeU3wX96cMQM/ew6OfAG1VNcv+isw9R/mUsBb08PSRrye2UaOS5ZtjQ23z1koQnJa5ZbhJu1bWkgjrPxdMc/y4x546hkj4ccYtRXYbCqEj0h23tIYW7DXBQuI6QUO0/M9gxWXHL0p7rNO0MzgbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716880; c=relaxed/simple;
	bh=Nz1hoxeCVid4KDiYsbry1h75tkpxToMSbYYTBDfpWX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOAwscAGVW9/h/ZI3jdDpdqpsT2xsoEQN6uRcgpmkBtC8U13+ket4xffqQ6PqHNbV6SfQr+xIPSHP3SA6+3rA3ULjYf+90RthtGVQMiKXEsyi1AqqhbwAfgs2EJRf4S0F3Ow1/L5IukgfVy7UdFJsH6Kk2Y6TuFK0wJPllXtutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nmPzjN15; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nmPzjN15"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749716876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkwHp5gNVL4KbrY8qJCfk1r1LfLJg5q3t6hNJxRz8qU=;
	b=nmPzjN15kNg2zZxVlReQNakgS5TF3ho91Ph6hVAfiA4oJKSrWfJCp+pQEPZJtlhCTA4Lyu
	0cRw1Owdsye3SJJjmFPVqo6b2hHxZzWDOoiQ3NswjOECaZ5DWipIDY5grB5UAaXWwwG2ly
	2xJVBI8AEgg5oaEnRvQhSiqvPS/z6Mc=
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
Subject: [PATCH 1/5] mm/Kconfig: add ARCH_NEEDS_WEAK_PER_CPU option
Date: Thu, 12 Jun 2025 16:27:26 +0800
Message-Id: <c7e5c5d737c2373f18320e5589e1921c662f8e35.1749715979.git.gehao@kylinos.cn>
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

Recently discovered this entry while checking kallsyms on ARM64:
ffff800083e509c0 D _shared_alloc_tag

If ARCH_NEEDS_WEAK_PER_CPU is not defined((it is only defined for
s390 and alpha architectures),there's no need to statically define
the percpu variable _shared_alloc_tag. As the number of CPUs
increases,the wasted memory will grow correspondingly.

Therefore,we need to implement isolation for this purpose.

However,currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
is enclosed within the #if defined(MODULE) conditional block.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)).However,when building modules for these
architectures,the macro is explicitly defined.

Therefore,we need to make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.
And replace all instances of ARCH_NEEDS_WEAK_PER_CPU in the kernel
code with MODULE_NEEDS_WEAK_PER_CPU,gated
by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.Then,when defining
the percpu variable _shared_alloc_tag,wrap it
with the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.

Therefore,we should add the ARCH_NEEDS_WEAK_PER_CPU option
to the mm Kconfig file.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 mm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b493..36bb4d6fd360 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -929,6 +929,10 @@ config ARCH_SUPPORTS_PUD_PFNMAP
 	def_bool y
 	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 
+# s390 and alpha be enabled,see comments for DECLARE_PER_CPU_SECTION
+config ARCH_NEEDS_WEAK_PER_CPU
+       bool
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.25.1

