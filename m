Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CF372EEA
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137774; cv=none; b=vEPuzBdeVMKIsy5zuOaXnJOZ4bIwA3KFjRK4RVVppotZCylcXQN6v+fv65NKewhA4nuGGrxxhmYLtugxMCnLc/7DhMeYOvXVDRxriTKtPMhMXwvbCIIJuB9BFnJmbnCU3NP/KrkqaNP3cNpPZgs16nigtaGU8MaOMCqoxbKHp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137774; c=relaxed/simple;
	bh=0IbYtktTturnkEVqSlPbeY9GBPBTr7a/zwfoJfBYE+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJ9ECy3r/GtUfhzYNDHvrOlcmnv7Ky+EX/6bEbY8eV5G5r/Sd1My59+In6mFug0GtpU/qvCcgiSLKoh6fkjGvLlMr+PT4ugt/sbjhq47A/vP6MEZDVafa6zUPOsYNuDOe7LuiL3zzbBHFNW0VJfwYj6is3Vn/UezY63rXPnoe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z8jfTWos; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z8jfTWos"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso8728665e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137770; x=1789742570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FKEH1rdH58hXYuPTfWCTfgwfx7OW8iMrRBH+iDZ91m4=;
        b=Z8jfTWosaEo2HWD2p/bKk1WPbhl/j6Pe2eLIR8l6ukhtfdaUijFMgVf2HCa7Z298SD
         CFcykKCNEosaxh8H1INhTq5m0f/XqRC5fsjT3azAOB5zvpsS8/QUec+opqz9bhiKTnqU
         d9RmGJF1NWoJcyLW+ZxqfUoyWaOTXdhY0cpc/f3YvvjKb5wGSG+fI9QgimDFakTbb0kJ
         IIbtE4rW8l5mj6FAffDrI9GM2LakqOKXPCbR52H6mKtRGrfm6xiQsjOBjF1gLaMmLQxl
         wu6l8w57NLr0I5Z07RgoKWtMTRnqmzpagspnC+ipJvRR48TYm/Jk1bElpF3Yht6+affq
         4D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137770; x=1789742570;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKEH1rdH58hXYuPTfWCTfgwfx7OW8iMrRBH+iDZ91m4=;
        b=RGnw1fn/BhGKEElqr6BYDNNISLwBwn2f93/3ru0Y9STVHfm25LhQwpSjdsND05YBqO
         55gfaon+28E6KgZilikpmEClPg27Otpj1TMlUgEqNq6zcl3U1/sGBQ7kMmDyUlEm1lqd
         BMJyg3/JDIeQ2gDGcbH4PqiwH97gOtxDjpLh1FnuNYOL7IbfD25G6PeB+/acYU/IlNHe
         FEBPvK4gsGrIkfJuvEhERQSjBZsWyAYfeorssAvLH3PUa8h72jTjdLrA+Uj86zKEzJvr
         JxR2JwzG29FFe32AgUM/dNIlVlRNL2Hgm75Tg0jdBCnldF0scakI4W2TLYU4L7UcJt9p
         f76Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnwcG8BHSwPeVx23vgRRuJcGo4LpgiH5NL1uq6gd674qbIsM7ixVArfeYph6XfiUywTY74qJCO/W+9@vger.kernel.org
X-Gm-Message-State: AFuF++lBuYIwf8U8I4bja0l9IP2KS/x7nyxBy92TmpTK+YbwOPWDKkOq
	ANTjyOwjs3wMq2nW2UMa+8sS2IF9c1S96KnNUy2DEiSWEmuP37cUHIYLV4V8VdyGnss=
X-Gm-Gg: AYBFou0r3k9gQllPo5lCAK+mjmZtHb5xs8kZujNdDLFx8NM1n48N16A5KfVHGd8RK7s
	TiGXudXOqnQRZ8GN6UuFT0fFL6YMriOJnIWED8FMBNtfMpoXFSaEJ7sv/EfIjgI6DjCzpzIC2aP
	3QaEOi01M2ZzY8R3JUGqYPhK+1l//tPINyCps9BTbpH4RF2BjbO+BSf43N3L9M36CkpscTbHD99
	gm/i/+0mKcqeMp9VwUgD3LwdnPkc9v9DmKX4nVcwtuWpE0wKqcN+Di58ICFQe6hLfh3mvYmQ65m
	196QeDCmaZaTEXF0MiVMeoYQ3Zj0VV/xLbpqbIzXswNx4KrJ2g34VX1DGP1uWZVkk8cMmTjHvJd
	vVzmL3RZK1jU7BSkeY9VqoCZlDDnIBesj9MtZSQf/fzF8T3qXOpTR41qlVi1ijvsD98JNfww4qH
	ffvkm96pZzSJ6oSJWnAkEE56gFzpcVTj4RAW7XdeZype0Zb3v0q/35zo32RGT2iE1B6W8TdgpG8
	KgQ+jM=
X-Received: by 2002:a05:600c:3b1f:b0:49c:fc89:59cb with SMTP id 5b1f17b1804b1-49e61983468mr57196585e9.5.1789137770026;
        Fri, 11 Sep 2026 07:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:49 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 5/6] cpufeature: Include asm/elf.h for ELF_PLATFORM
Date: Fri, 11 Sep 2026 16:40:35 +0200
Message-ID: <20260911-module-include-elf-v2-5-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

linux/cpufeature.h uses ELF_PLATFORM, which is defined in asm/elf.h. It
currently relies on that header being included indirectly through other
files, specifically, drivers/base/cpu.c gets it via linux/module.h ->
linux/elf.h.

Add the missing include in preparation for removing the linux/elf.h include
from linux/module.h.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608151415.UAbFbpvE-lkp@intel.com/
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/cpufeature.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
index 6aff540ee9e5..66027987e9d6 100644
--- a/include/linux/cpufeature.h
+++ b/include/linux/cpufeature.h
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
 #include <asm/cpufeature.h>
+#include <asm/elf.h>
 
 /*
  * Macros imported from <asm/cpufeature.h>:

-- 
2.55.0
