Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D9219E8D;
	Wed, 26 Feb 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572670; cv=none; b=OEG6x5k6SfHpriYzNZmuaZqLOiULpfmtwmCa4cW5ZoM1yqGCEmOZw3M/h7HQQS3ByHWYJ5LP6RxWKERBYPmg9KVS3v5eTgxeHT3qC2aEBcOgck3Xw0DayeM42cU50Zo+NgHmPMoJ1KMc1T2D9s42smVDx/V+sMabe6olCs+tGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572670; c=relaxed/simple;
	bh=oh130ZfN7W4wku04HmoxfgsWtF4oVy+oljkEG0XQAD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exV5+vvcv2v1uSLygLz/FXJEUogcIHFkMOZVdcM20I9pGxYrFNFJ39UkY57jIgxloH9fVUmgrkjZKUrV+239FQ9yB3Mt91kzOT6ZCyew8B8k75Lo1dEm1tghLTvddAaeVYSZxAeyAJ5jGt2EEdjrQubP7j9Qo1OvpTCLe9pUH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB9C16F3;
	Wed, 26 Feb 2025 04:24:44 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1DC13F5A1;
	Wed, 26 Feb 2025 04:24:24 -0800 (PST)
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
Subject: [PATCH V3 1/5] configs: Drop GENERIC_PTDUMP from debug.config
Date: Wed, 26 Feb 2025 17:54:00 +0530
Message-Id: <20250226122404.1927473-2-anshuman.khandual@arm.com>
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

The platforms that support GENERIC_PTDUMP select the config explicitly. But
enabling this feature on platforms that don't really support - does nothing
or might cause a build failure. Hence just drop GENERIC_PTDUMP from generic
debug.config

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 kernel/configs/debug.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 20552f163930..8aafd050b754 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -73,7 +73,6 @@ CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y
 CONFIG_DEBUG_VM_RB=y
 CONFIG_DEBUG_VM_VMACACHE=y
-CONFIG_GENERIC_PTDUMP=y
 CONFIG_KASAN=y
 CONFIG_KASAN_GENERIC=y
 CONFIG_KASAN_INLINE=y
-- 
2.25.1

