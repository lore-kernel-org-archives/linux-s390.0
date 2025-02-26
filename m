Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF84A1A;
	Wed, 26 Feb 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572666; cv=none; b=mZ5MNXwuuYSgu3lDpUPBBcN4T5g014sgo+xoKLTuZnKBE5SgxubqgUBR5ATmk/VU5DfwY6pe66KdKXScdGB8O1rbbXMQRL3IJkHkJzwLZC6kibishybXRUSdGZLJXGYaO2BuEKDj76axP5J/Xsgvg8X9d/eysdtAmC9YUF7qeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572666; c=relaxed/simple;
	bh=Is/QCHbWqAmr1YoxzAfhHFGcmQ46LcKYWWOELKfsQ8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aPVsLNRskg1fQujRtAKEBBRlGyJGDPMeR5rGPohe/PYEzLg9NMp9HOmSuKFPSn53u+QLoLFhJhQ2vsp1PYH3+X15hBUNzbImLDhWl14nlSK3bF3nrFCLP6r68uN6Y93/+qZZPyytmeeevwZ3Y2rUIP7OWgdUDw9tmgwaJwVqkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B55113D5;
	Wed, 26 Feb 2025 04:24:40 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 646443F5A1;
	Wed, 26 Feb 2025 04:24:20 -0800 (PST)
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
	linux-s390@vger.kernel.org
Subject: [PATCH V3 0/5] mm: Rework generic PTDUMP configs
Date: Wed, 26 Feb 2025 17:53:59 +0530
Message-Id: <20250226122404.1927473-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series reworks generic PTDUMP configs before eventually renaming them
after some basic clean ups first. This is derived after splitting changes
from the following patch.

https://lore.kernel.org/all/20250205050039.1506377-1-anshuman.khandual@arm.com/

This series applies on v6.14-rc3 and has been tested on arm64. Although it
also builds on other platforms as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Changes in V3:

- Added CONFIG_PTDUMP_DEBUGFS in mpc885_ads_defconfig per Christophe
- Added back MMU dependency for CONFIG_ARCH_HAS_PTDUMP on riscv platform

Changes in V2:

https://lore.kernel.org/all/20250217042220.32920-1-anshuman.khandual@arm.com/

- Dropped the patch "mm: Make GENERIC_PTDUMP dependent on MMU"
- Dropped GENERIC_PTDUMP from mpc885_ads_defconfig
- Dropped PTDUMP config options from ptdump.rst

Changes in V1:

https://lore.kernel.org/all/20250213040934.3245750-1-anshuman.khandual@arm.com/

Anshuman Khandual (5):
  configs: Drop GENERIC_PTDUMP from debug.config
  arch/powerpc: Drop GENERIC_PTDUMP from mpc885_ads_defconfig
  docs: arm64: Drop PTDUMP config options from ptdump.rst
  mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
  mm: Rename GENERIC_PTDUMP and PTDUMP_CORE

 Documentation/arch/arm64/ptdump.rst       |  2 --
 arch/arm64/Kconfig                        |  2 +-
 arch/arm64/include/asm/ptdump.h           |  4 ++--
 arch/arm64/kvm/Kconfig                    |  4 ++--
 arch/arm64/mm/Makefile                    |  2 +-
 arch/powerpc/Kconfig                      |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig |  2 +-
 arch/powerpc/mm/Makefile                  |  2 +-
 arch/riscv/Kconfig                        |  2 +-
 arch/riscv/mm/Makefile                    |  2 +-
 arch/s390/Kconfig                         |  2 +-
 arch/s390/mm/Makefile                     |  2 +-
 arch/x86/Kconfig                          |  2 +-
 arch/x86/Kconfig.debug                    |  2 +-
 arch/x86/mm/Makefile                      |  2 +-
 kernel/configs/debug.config               |  1 -
 mm/Kconfig.debug                          | 11 ++++++-----
 mm/Makefile                               |  2 +-
 18 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.25.1

