Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E886221577;
	Wed, 26 Feb 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572686; cv=none; b=eEpw1ivAHAFnmKqc1AjG6gjAT4T4M7hfAs3Aycvl/rkSnUltL1D7P8RUBR/NZO7yDqKOuS+Tdn31mM3lt+85k9vheSHyaM67Aap2QsdyhCTQvg+SOo8ESNPkCGsqzPrYXsj0rPBIPXB4YAKhQmLNNaxy6mFopOb4EkPRTwHDgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572686; c=relaxed/simple;
	bh=QF11rklDJlulOtMhX6JMt11M85VxHvDVfYl4vULNd3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sS/6KW7vhft4w4eO0+4XZDB3JzV/ozWcR/ijR1YHUWM6P0qfk9q7eeCwcNemT58y5EPA+QdXCLAEXhXYLLQ7cUjScTCEBQLN26raopfZJe9GazCfb/D2pNHUkizzwaLK4j+LisUDjKWGCnZ6F3xzpQkMoZwjMOEW88eSlfz767Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B27628C7;
	Wed, 26 Feb 2025 04:25:00 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 146C63F5A1;
	Wed, 26 Feb 2025 04:24:39 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Steven Price <steven.price@arm.com>
Subject: [PATCH V3 4/5] mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
Date: Wed, 26 Feb 2025 17:54:03 +0530
Message-Id: <20250226122404.1927473-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226122404.1927473-1-anshuman.khandual@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
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

