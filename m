Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C72036EC
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714966; cv=none; b=sW72JcK06KKB/VtuOO4gyqSzq0uX076wNWHkc4hplQgGUki02EAgH9Qcxszh+Iwgg29wZjoCX6Tmlf+Y+nJWl6V6xMXvkpJSDNxmq6q5ihGj0igBA/JAjo21QTIsVVaJNlCej+c6eJTOJJMeYos3BYW/01zCYt+zv/RHg75DCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714966; c=relaxed/simple;
	bh=Fax7hHEVMpAc/qOSqKwCfGDjLmsEQkvYZP/dGwxaDBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lR+SwUNsGzSZ0qS5HOgsZCvyK0CRM/jIAXGallj3vEJWNBcCIVh+kcSJrImDdXDfJncUZ2XxF0gnKz+kcWR20m4AdJRIHGi7gIvNQPaYuXayWMRx3wlmUg64IM2wK9xFuyhyGXJA6X76QGrIhYx+wcVe30Lsy/In1mAIdglmGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iKgcHAeE; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iKgcHAeE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749714961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osSReSR8wlEOTjq5e/ERNMcEPZE3oL07rXtwliGT33w=;
	b=iKgcHAeEXG1PiRchs8xEiZYE4HSrMocSps4LO+JObpwf/cheHd+GONnkkBh8Z/V8DF0gkV
	qJlpBXSSCxIX50TYftRSjvPj2JmRUoi+e1cyShxGwRG97OVMtym4mih1BGZGXlII1Ogtji
	YtEI0xGYIPB3CRphB9Sq0l2Ae/qUCw8=
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
Date: Thu, 12 Jun 2025 15:54:24 +0800
Message-Id: <492346c5e787d639ddf6a3c86bdc14496696a498.1749702889.git.gehao@kylinos.cn>
In-Reply-To: <cover.1749702889.git.gehao@kylinos.cn>
References: <cover.1749702889.git.gehao@kylinos.cn>
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
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated by #if defined(MODULE)).
However,when building modules for these architectures,the macro is explicitly defined.

Therefore,we need to make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.
And replace all instances of ARCH_NEEDS_WEAK_PER_CPU in the kernel
code with MODULE_NEEDS_WEAK_PER_CPU,gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.
Then,when defining the percpu variable _shared_alloc_tag,wrap it
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

