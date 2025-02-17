Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A715442A;
	Mon, 17 Feb 2025 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739766158; cv=none; b=XW8G02j8yozpnseGY7VJJFpaYjtCQ0q5fQ4yVuJW7auw6wuAG01Y5z/CqUINVNfl12Mwqvxcf+esOxBlcBNkyJlfpaRfVYB+QG/7vAm0PL8pbtw7DhJL4iWGVdde5pg8DqVmA6S6CIdco2LAS4cneK1bbyOCLhww7ApJ7T+vPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739766158; c=relaxed/simple;
	bh=s0rzw+ZkXrpCuWf2kihPfwbrbzTX/Rb/M4+NMoo5fhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjyUrs1C6KiXjdUrLbQH84ySikgPhUE9hmk0j7nhK6gCrNkoIpjixYkyTl1qxiUh+j22zTDjJ7TgtvvclvrbrahfqW6pJthrKOjryEZGoKGWHrV/N03644sz+nviVLjMFcgERkcPntgDLOtyM3F37mINAeKHQym4QUKbkXbn0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B2F21063;
	Sun, 16 Feb 2025 20:22:48 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 473943F59E;
	Sun, 16 Feb 2025 20:22:25 -0800 (PST)
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
Subject: [PATCH V2 0/5] mm: Rework generic PTDUMP configs
Date: Mon, 17 Feb 2025 09:52:15 +0530
Message-Id: <20250217042220.32920-1-anshuman.khandual@arm.com>
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

Changes in V2:

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
 arch/powerpc/configs/mpc885_ads_defconfig |  1 -
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
 18 files changed, 22 insertions(+), 25 deletions(-)

-- 
2.25.1

