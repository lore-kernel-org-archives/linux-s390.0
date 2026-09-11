Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB832370AF5
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137773; cv=none; b=jamH8x3XazPt0LeI0oWNZsfs60UpGSCX1hLDGkIBxD7hINXfhd8iUZntZo0Mg39s6mofwcvpJE01Yh7dEewP0kPqwMymIUHBRwDgt53zIDkY837w0yNc9D26/qmO4WvGMUumUsl/Jfp0QqiyqLuYLxt71OBwq78r2HFeS7e83Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137773; c=relaxed/simple;
	bh=vyJh04de2eQI9xDXQLk2SsoY9d27ljdKRQo9PLvYs3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmK7SSwcXM8pC7upPYSz9YOJIR/BMhja0/t/gcPVIn/dKWeiwpU0ptzLeo9fMV3nhnUWSeCExYydfaL5mkriUaMjChgEgocV5aMIQ6NMh/njeYAdJoZrTYAfp1fUciBkAzcxvSbW3XFXIAgJwCBrmulsqGgwGMoBQz4uOqii1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry9/DkDa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry9/DkDa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso11808715e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137769; x=1789742569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=Ry9/DkDaFZ4TdwpnSd2qNFVelkgZf0I+sK/vUSrXGJVDvUzGWKFLqdb8UxWJFtIRyd
         QGt2zLsY13XYCfEcx00KmUUPRDrGz+NYn9CJmX9yUyb6hq7gEJz42IC4MRCnwIaEcpdW
         tQUujaQLqeUNnfCJTTcjYm7FSljCpemBd6+PukhbHVRJ4Q4stj3C5SASxuwEvbjV0Osg
         /Q9Xgj+v7KR2zVR2teJezj0miqoZCcV0EC/BLQEfUdpZPOknI1tMHRR4RQUQMW5zLmKr
         P4KyxRefgvqyrABexKeT1gw6lYCx5pucDAHN4oMpIUKFHJiBPNydC9j33pcTbhnipiQE
         DZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137769; x=1789742569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7y0rlVQh9abTylMWGDq0N15j8M2y0GYhOvmNvpShVQ=;
        b=XamAJEMVj6Z7/Wruh2cjKV0b5bDDjRS+ycO9qmGj46eG/RV6hSjxb5W+40DsR1asoJ
         aaOZFUOXW/DW7+Hbw+YbOAEF04FM8WNTA2XtJj0z767zIufTr2iw4av477RFIY5AX1cp
         9ce66l5X/8490cbklPB6QIAI8e8FnCRynXhoDSz+cNBPhmfswQ6I43F5Rb6VVCmlWQm2
         u5adeYy4dgZ2hbKa8O1N4la+bv5yG5K46JxzrSxXAIot3p7/Qbnz/vb0Dnq42KfaxBOZ
         HrR+vmKNAlEKPgyGMIvhu1Oim1g2G8RlxLq74kW3hqz7rkeHEbPpce9z8VXt1S91Mvl+
         P9FA==
X-Forwarded-Encrypted: i=1; AKwUvBzEVxFjG8uOZbQsQpI47oE//nnoQ6PYJuum1Fxo4fnQ1sIctu11Bz5cG/m8/SoyshmRKC8A9U04i94w@vger.kernel.org
X-Gm-Message-State: AFuF++khpUNBPbrmC4uO8BAkGWo7/lcMOsQ2wbgA9hK/KCK16GEKCdMj
	/kZGhnP/lmYNdnm0j6J/cja6sXxRiRvu0gg7d4FaGGM7/i//SfEZWonYEA92D5B+75g=
X-Gm-Gg: AYBFou10tqor36P2Z4aVCHwDMCN9IEbP17HDT4CQLcUPLzH7OzQk3TopiFg04G9L5a4
	2RBaLPF9G2hZeVq0v48KU5d9YPSZu+B1GXuV2yZsKw8UIp9/pZnScke3VjVgRB3zJ5j3C9pX48x
	E+2il2BfxZgoevzlZ+jJP/glw2ldEWQvOpLysSZ//AfETKN/b0GGyvi3CgVumYNlEAQZ6+udPJE
	NTuXCLEdfUbvsd2Czhfxfkpt3wnG2s43G/ZBtu9rt5ojT5w/DKWJ8+PrsRW+e5uVqn+kRSeLeCW
	nwGZUXKT3SNHz/j8oL5aaivuh2Vu/CbYROA+BAa6aSf1voAOcAxtUJqV6uF7MNxo5WOEm3KRgSo
	RA4al2lXgCvwPBcVZQktt9f5ic0KUNi8wZncQTNLZ1a8qEB+Q0h0G3xf+wUfP6X1DKuIKAiDZUN
	ZAojwetBKm5+347yls2jOvvldit+Pe80kUsuY4pBxygn7Bm6/BcZ64ZLq9H3UI8gIWgWtvlWsew
	VZtpw==
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6c:be0b with SMTP id 5b1f17b1804b1-49e619bd068mr62359435e9.17.1789137768683;
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:48 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] s390: Remove the asm/mmu_context.h include from asm/elf.h
Date: Fri, 11 Sep 2026 16:40:34 +0200
Message-ID: <20260911-module-include-elf-v2-4-954c732975fb@suse.com>
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

The asm/mmu_context.h include was added to asm/elf.h by commit 146e4b3c8b92
("[S390] 1K/2K page table pages.") in 2008, when the new macro
elf_read_implies_exec() used disable_noexec() /
current->mm->context.noexec. Commit 043d07084b53 ("[S390] Remove data
execution protection") removed that macro in 2011 and asm/elf.h no longer
needs asm/mmu_context.h.

Several s390 files currently depend on declarations provided indirectly
through asm/elf.h -> asm/mmu_context.h:

* arch/s390/mm/mmap.c: check_asce_limit() -> asm/pgalloc.h,
* arch/s390/kernel/processor.c: enter_lazy_tlb() -> asm/mmu_context.h.

Add the missing includes to these files and remove the asm/mmu_context.h
include from asm/elf.h.

This is a preparatory cleanup for adding the asm/elf.h include in
linux/cpufeature.h, which would otherwise create the following cycle:

linux/pgtable.h -> asm/pgtable.h -> linux/cpufeature.h -> asm/elf.h ->
asm/mmu_context.h -> asm/pgalloc.h -> linux/mm.h -> linux/pgtable.h

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/include/asm/elf.h  | 1 -
 arch/s390/kernel/processor.c | 1 +
 arch/s390/mm/mmap.c          | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index bb63fa4d20bb..e22e3ab25760 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -170,7 +170,6 @@ typedef s390_fp_regs elf_fpregset_t;
 typedef s390_regs elf_gregset_t;
 
 #include <linux/sched/mm.h>	/* for task_struct */
-#include <asm/mmu_context.h>
 
 /*
  * This is used to ensure we don't load something for the wrong architecture.
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index e33a3eccda56..76b2c7478c6e 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -27,6 +27,7 @@
 #include <asm/param.h>
 #include <asm/sclp.h>
 #include <asm/smp.h>
+#include <asm/mmu_context.h>
 
 unsigned long __read_mostly elf_hwcap;
 char elf_platform[ELF_PLATFORM_SIZE];
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index ef7bfc87758c..8206f347e00e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -18,6 +18,7 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 #include <asm/elf.h>
+#include <asm/pgalloc.h>
 
 static unsigned long stack_maxrandom_size(void)
 {

-- 
2.55.0
