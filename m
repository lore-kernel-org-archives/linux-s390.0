Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF5183CA6;
	Mon, 17 Feb 2025 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766170; cv=none; b=ZjTiHHdVELO2A2Zr+EKDwfHYmKwlA78MTrgUMNkzJwfVBZixvk8sI0UNNVfPFpeCgo+5doI13vRpXVoq7NL143x2UWypFN5vB7m4gWsculAGDhVSfApE1xhVbXOBXJpsyiOt8r0oH1v8lbHu2rMARWAix9N8cgQPDfcXJWeT9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766170; c=relaxed/simple;
	bh=QF11rklDJlulOtMhX6JMt11M85VxHvDVfYl4vULNd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OhJglFkhtvgzXCYWvTfTabRGudBLfwOryPB05rtQa3UBIEx9QSJcSsFPUIXlVuwpoB72BkUTRHrDxGCDWRjVmVHZ2ZRtei/54Nk45UzvDhctu9rq7BquRvVXy/JFSGKME8kwlQittDQUwElxZDrBFRd1BX6UFwtN7P25eLiMrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B9871D14;
	Sun, 16 Feb 2025 20:23:07 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6ADA33F59E;
	Sun, 16 Feb 2025 20:22:44 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: steven.price@arm.com,
	christophe.leroy@csgroup.eu,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 4/5] mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
Date: Mon, 17 Feb 2025 09:52:19 +0530
Message-Id: <20250217042220.32920-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217042220.32920-1-anshuman.khandual@arm.com>
References: <20250217042220.32920-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEBUG_WX selects PTDUMP_CORE without even ensuring that the given platform
implements GENERIC_PTDUMP. This problem has been latent until now, as all
the platforms subscribing ARCH_HAS_DEBUG_WX also subscribe GENERIC_PTDUMP.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 41a58536531d..a51a1149909a 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -186,6 +186,7 @@ config ARCH_HAS_DEBUG_WX
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
 	depends on ARCH_HAS_DEBUG_WX
+	depends on GENERIC_PTDUMP
 	depends on MMU
 	select PTDUMP_CORE
 	help
-- 
2.25.1

