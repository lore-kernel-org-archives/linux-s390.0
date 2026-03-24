Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F3391E7E;
	Tue, 24 Mar 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371622; cv=none; b=DYzFqj+MiubjNr7ReBhFREq0VWFMcYtxn5FvjFmUeY1SAZvxP0j2J0Wd/TyFDE/vvuFN2d2UAsDeguQ88h6Lk01XKxH/5x5GpYE6cBpKwggLZ6bjG1A/MStuXRT46mgBoqo3lJHTaMJ5HGIIqZlydFfjiYCAY326Wf5jwyHwTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371622; c=relaxed/simple;
	bh=d6KLxSDgRcKiLzDY+NMiMRY2jmIC2rw/9NmZTIuAx/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3MSQxt+FutHshNqorQJz00/UHDu/9KJCTeObK3XpLts6o7QrXXERdY+Fy0nEMtPdJpecMDz/sefyzEt1AmZIL9NVOzsfOpea0jAYbzvZMBtQD4RFqQd10ZSoVE9L4E9mo7ceOvp/DG0VcY28y+uSiqjv+QNbd796Z6Zr265lXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBzXgPUR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBzXgPUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371620; x=1805907620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6KLxSDgRcKiLzDY+NMiMRY2jmIC2rw/9NmZTIuAx/o=;
  b=jBzXgPUR0QtWYycsjVLpDEUrOCItsFVArtlgUN6FA6YG2yoXW0dqxawJ
   jLuXUTLNI9fj21Z7kshsLHqAAmiTCq4GP+q3J5vvh809C4L8hUBa4d+Wc
   0am6j7Rr8D0i/PgLOPWsnxPiQBJnyWBLBI5TXG25rs85bg6DlTW9iqE/q
   zhd/bHo0ZvpcWDvsFmKP5F67EkJriuJY8P/EcoQo4+7ewTFB1TawVLtNy
   MIlm6robS/dgLFkLWltLQh0+lk7FiXSGjMqv7PykvT4kByKnijsu66CG3
   6s7KQJTN6X0Lur2H/w4M+OAtoImSHzxnNDbrBzQttbrgoKj+Tpupjz9yl
   Q==;
X-CSE-ConnectionGUID: F1CyYZZqSC+xZFXs0ca8bg==
X-CSE-MsgGUID: 9nh59SSPRESai79d3MTEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75281439"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75281439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:18 -0700
X-CSE-ConnectionGUID: ib4xzWKRSNm/cm3wyP1vbg==
X-CSE-MsgGUID: WCv5QcPyT7OGGuY23A4d9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219540242"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:10 -0700
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
Subject: [PATCH 07/10] parisc/PCI: Cleanup align handling
Date: Tue, 24 Mar 2026 18:56:30 +0200
Message-Id: <20260324165633.4583-8-ilpo.jarvinen@linux.intel.com>
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

Caller of pcibios_align_resource() (__find_resource_space()) already
aligns the start address by 'alignment' so aligning is only necessary
if align > alignment.

Change also to use ALIGN() instead of open-coding.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/parisc/kernel/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index f99b20795d5a..f50be1a63c4c 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999-2001 Hewlett-Packard Company
  * Copyright (C) 1999-2001 Grant Grundler
  */
+#include <linux/align.h>
 #include <linux/eisa.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -200,7 +201,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
-	resource_size_t mask, align, start = res->start;
+	resource_size_t align, start = res->start;
 
 	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
 		pci_name(((struct pci_dev *) data)),
@@ -209,11 +210,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	/* If it's not IO, then it's gotta be MEM */
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
-
-	/* Align to largest of MIN or input size */
-	mask = max(alignment, align) - 1;
-	start += mask;
-	start &= ~mask;
+	if (align > alignment)
+		start = ALIGN(start, align);
 
 	return start;
 }
-- 
2.39.5

