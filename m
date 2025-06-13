Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B7242D67
	for <linux-s390@vger.kernel.org>; Fri, 13 Jun 2025 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783974; cv=none; b=LYBe5vcRhi649oODGEuP2T9NXtBR7IBmDb2kgpjoDiHwevgc7GDs7P3fDWOAXmqS7K8M5ZOCsIayaLQy14ao4yK2CFaqpBi8fogh7AkfMMlf/UGw9gvzS7L+zfYdF97Bcznu57epdv67F6xZGJmpnhjQUu0L26VHGVrxiAK5gW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783974; c=relaxed/simple;
	bh=d1E72JCG9NdkFhRoVCh+AuOWZQ8c4f7+g6BypUShgPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaoUo15Q6lt5EQoLBAbL1wnldLpsMmSEQmqL/MlkqeWyE/qyx89jim/+VOV41a1MbBh02OJlgfrtoRxm6ojlDjQMz9nwpjpAjvIB/9qVjtO3kQrCvLJlqoWrUH6QZt9TlLSXbnF6RNr8yc4+MYS0scF/fcU1GQO9aEs0Td7+7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IRnDQ8ko; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IRnDQ8ko"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749783970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3zX8MhJa07yqjHNrL6ieLh1aYMQH27ruTr0qMMWaSs=;
	b=IRnDQ8koDXjvaIA6KMlYvmxXWMvfOTU0iF921IKgbPnUKMpn6dvgPYQnNy6fnowL9kKBD2
	7CVTs8oy9THBnY9JcIHml1z9wOx1nsJjysm6RK8nBDBvWa6rxvuQ9dzWS/boC5E3srenYO
	u0+v/sbFsEfnHtNQHWlQYJC8gnI25cU=
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
Subject: [PATCH v2 1/3] mm/Kconfig: add ARCH_NEEDS_WEAK_PER_CPU Option and enable it for s390/alpha
Date: Fri, 13 Jun 2025 11:05:05 +0800
Message-Id: <e56e87c659105ff70c2dd5740543d0716a7dd485.1749779391.git.gehao@kylinos.cn>
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
code with MODULE_NEEDS_WEAK_PER_CPU,MODULE_NEEDS_WEAK_PER_CPU might
be a more accurate description.
Then,when defining the percpu variable _shared_alloc_tag,wrap it
with the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.

Therefore,we should add the ARCH_NEEDS_WEAK_PER_CPU option
to the mm Kconfig file and enable it for the s390 and alpha
architectures.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/Kconfig | 1 +
 arch/s390/Kconfig  | 1 +
 mm/Kconfig         | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 109a4cddcd13..ce9bc842e384 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0c16dc443e2f..716031d22346 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -132,6 +132,7 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b493..2f55cc95cfcb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -929,6 +929,10 @@ config ARCH_SUPPORTS_PUD_PFNMAP
 	def_bool y
 	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 
+# s390 and alpha should be enabled,see comments for DECLARE_PER_CPU_SECTION
+config ARCH_NEEDS_WEAK_PER_CPU
+       bool
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.25.1

