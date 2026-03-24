Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62F38911B;
	Tue, 24 Mar 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371609; cv=none; b=o39a7TtOj6yNGmFrGp0BDv7MmujKcOOFjaAo3LRafuPVE6TPLEaXRWyn4A7jg+vNVz+WHVGjcOmPWp4BNwziMYqkHCjTJ3w5sgrHWZMaP/A7yJWDRSA9YS9lA2tvLDfzRjfynVRbkck/nhQf9x8PUfqNU7rwt4AJfANGAu8BNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371609; c=relaxed/simple;
	bh=9hvV8PDAdyGkHU10me7VyjfjKt6p0yD22QH58KrfakU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWdnOF9MjhNyx/v4Vn+o8GGnuxvhCG64XirlpMWGX6sOQ0UE44yyQR5Ue2D+Yg83/jF3HydXITG2dCpN44C54GtxDfKKYuTUXGCEVhsyDNWwz05zRRu8UbRlNm/bE6saylOFJXvBbUKlN27qvCd4UCO5TGoE75mxmLb3jHGqmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpEHST9P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpEHST9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371607; x=1805907607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hvV8PDAdyGkHU10me7VyjfjKt6p0yD22QH58KrfakU=;
  b=gpEHST9P1UugeaS32z4rzTOOKQ9kQj4bIIQ7osxvVXJxWCmJ9ddnBqSp
   H9E8F2CV5VUEmNyesdo3O4RNI4sgeGnoI+7QP2aaJjoyPVY+We+FXuLmt
   7+gLB87ce3pnwfGQ51eaBGeg1yn8j4MJS/7ruQ0Im3YaHVEA8n4ujALmD
   1NS3qMdWW/H6yx9O7+Q8GIrBbhCBzqIDCRm+HDJ0J35jFdHh9Vo+IK2LI
   FPn0XXe/WImSbsCSIu3UtlqPMKxs2C8BEVxjEILdnAVr0DpcM3Wb5//9r
   sjpapG5eGao8ltTti4DPhqKFhvgV2oJzIUgwVgLFqOX182Ycx01Z31hqF
   g==;
X-CSE-ConnectionGUID: LSgROxn/Tsi1yLyFZVyL3w==
X-CSE-MsgGUID: YKVnB93wRB6HsX9nY4ouZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75281401"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75281401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:06 -0700
X-CSE-ConnectionGUID: ZabKv/GtRfqHh4rMbY+IrQ==
X-CSE-MsgGUID: KjVhSRgDSkWdd+eayrpYDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219540084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:57 -0700
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
Subject: [PATCH 06/10] MIPS: PCI: Remove unnecessary second application of align
Date: Tue, 24 Mar 2026 18:56:29 +0200
Message-Id: <20260324165633.4583-7-ilpo.jarvinen@linux.intel.com>
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
 arch/mips/pci/pci-generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index f4957c26efc7..aaa1d6de8bef 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -32,8 +32,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.39.5

