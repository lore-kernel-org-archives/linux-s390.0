Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35363223714
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716896; cv=none; b=JP/K/Io4VTPtuN3sw7dFpHfR7b0TAebvwiWbXl//cF4D9Cip5OuohYmkMmLpOAfY4yUtPbbkKSpT7SJp+ZWgiO+HeqRHk+VBUHqGPbQvGm57EJxQ3olc7Cpw0U+QlLlD1+AKwYWR89YYUbPW8Tkc+sPX+0q9SnSgmbVidde88kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716896; c=relaxed/simple;
	bh=LvsURw/nqMWRXkm+nrhQDBaJHU6fMAmmLXpVcAQ1/T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1nq7OsVvy+fa1vEzk/111byQ2QeUZRr+rGJnl53w91S/LZw4LHKWpuJids5IXWXbOF+3k/TnzYJNEQ9kbINMUz36KatyTOpfWxWoHqlTUjNXXoOGkJncih6/2k9z+LvLPTRmAS6DEoP/UAWL04eZjqRCkcIIDymxxQ3yhI8a34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kyGJZhrQ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kyGJZhrQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749716893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9di4IfgIfQZ0n6KWtQk6/b40WsXW7j7pcH/DrSfee4=;
	b=kyGJZhrQrniGsFhmlDOfmIcwdCwzLroPX7NLDuuw9E4yS0eeKDCnyyGZfNn9PYrekuCFCq
	UZZCsAgplLBiwIj72HQnDxKNlUU1MjQURJ3mXs+kkmafXVfkZg0c1SH5z6rehMyfDlXvPZ
	AsNgV51iAuoVo9aMfcbkRVmUgjuxiUM=
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
Subject: [PATCH 3/5] s390: Modify the definition logic of WEAK_PER_CPU
Date: Thu, 12 Jun 2025 16:27:28 +0800
Message-Id: <1baad81a8033eec2927f8a3ac6b792e930766724.1749715979.git.gehao@kylinos.cn>
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

As stated in the first patch of this patch series,
we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option,
and replace all instances of ARCH_NEEDS_WEAK_PER_CPU
in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,
gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.

We'll make corresponding changes for the s390
architecture.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/s390/Kconfig              | 1 +
 arch/s390/include/asm/percpu.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 84f6b8357b45..a202baef86fb 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -17,8 +17,8 @@
  * per cpu area, use weak definitions to force the compiler to
  * generate external references.
  */
-#if defined(MODULE)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#if defined(MODULE) && defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU)
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 /*
-- 
2.25.1

