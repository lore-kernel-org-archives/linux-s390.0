Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0736C581;
	Tue, 24 Mar 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371579; cv=none; b=QJd4mjOMz/qe4Eal//vGTNexXX9h808t1Tc3DJ2W2DLxK4Jc9bxFEQbuFaX3wnFCWOPqNuOxkwL6I44O55WmmHaQSHBC2/zmGOi3vzPeYVtVCP+nXKLBs5ggq39zy7dSHkff+ud4CAF4SVcEb/tHMjqWuZyTFB91TsA3qZmZHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371579; c=relaxed/simple;
	bh=cQi+TnP6KS0Xel2L1NUm1zOxuJkTQw+HXZFhNST/QpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8lxFMe3jbVREaKgWfxjut9dyQWbdxyS7MseLjPxbhZvlLnck9RAUwqbyIYwk0MsKfxj19/Tq4EINambXiEUtdiXm+1ehBOnxYkjTEmaevsb7Lrw2T54zlqUqFmDx4C9xRG/eeCBTKMOE2ndCx16b92JvvoQqJDsXG4KQb9Uk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULyMssny; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULyMssny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371579; x=1805907579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQi+TnP6KS0Xel2L1NUm1zOxuJkTQw+HXZFhNST/QpA=;
  b=ULyMssnyIxA+WgYz4/xyz832bS6VnKyxuvu5Ok0+dNNVjR2RfyGrtrtU
   ed6PE3wEPeca+UVwF7mQuddaHj2rgoKRPOAoiytSqNDW5u/ES+fA4A3fk
   ZQl9hxSFfCmptk0j2A8Emh4mVsfgURFzUBmHxahq4pi5lztUmRUxWddDD
   6iPhr4XVrpgAF82B7FSgR+0+OktAelLlig+1XpL6sWeZaUNwgUCh/YBME
   FYp4or+BoTRVWJClIjsI0b5mAtZ3S8vbtFkwdgppaVwS3nGAb6Adf8rfN
   yEfICABoO85WKD0JDO88L5dWvF2nESWlSMQlLr5dv3WfJ4jiAKYrOJ5li
   w==;
X-CSE-ConnectionGUID: SFhs8CXTQguTB5+gxm3jhw==
X-CSE-MsgGUID: bx5lfOLMQyKYRmnFnL2VBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79252739"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79252739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:34 -0700
X-CSE-ConnectionGUID: bklkz5swSMGrpU/gEbGm9Q==
X-CSE-MsgGUID: DjRzhFV5Q9qVW8oMHuNG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228447839"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/10] ARM/PCI: Remove unnecessary second application of align
Date: Tue, 24 Mar 2026 18:56:27 +0200
Message-Id: <20260324165633.4583-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aligning res->start by align inside pcibios_align_resource() is
unnecessary because caller of pcibios_align_resource() is
__find_resource_space() that aligns res->start with align before
calling pcibios_align_resource().

Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
result in changing start either because 0x300 bits would have not
survived the earlier alignment if align was large enough to have an
impact.

Thus, remove the duplicated aligning from pcibios_align_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/arm/kernel/bios32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5b9b4fcd0e54..cedb83a85dd9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -571,8 +571,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.39.5

