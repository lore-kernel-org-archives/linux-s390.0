Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8E4302E9
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438732; cv=none; b=kS3eL+claSoWGCbY3qP1c6lmArnOb0hkPcMsfh6/yTSRjOJzgWkWwL2fcSVMtGbQGJMPVN6RuIjmbnE5clvShN3/JtbUDP381M3mKejZjh4xvR/tgcdq/5PsfOm18f1EQTx3F+F4SeYqZvPKwYaF+D/Zzj3T6553ydyVDC96EWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438732; c=relaxed/simple;
	bh=SO5eeYPZCjDEPtTUp5vp0e259QcOYfs80Q/ywveYhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awevLJzC3Oqhd4icg8SuntSFM4YIDziRouGYI6fbE4IXHcooJNQxTPS9W1eLTiKUeQrbqoiaUMYnN9S62k+3lQNwCYOkwgoP6lvKbck5lbTcromJcTrlGqnlqnF/OcqNaz/NbP4O6ZxQt8Hu+idLSyr5a99WlSyjJQ3g7HObvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U8J4zG4K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U8J4zG4K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c19bad03so41418285e9.2
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2026 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438729; x=1784043529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=U8J4zG4KRpIeOFa1GCPJGFevewNpJMoIVwWT1bNy1Z+gc5so31ZbR2XjZvbtFrRpF7
         o0mS20Jd8F8xUUCiOBqp+XcXL/nYHX+OoYRD5JNcnn/vohUiv7MQZ/iZLuQ/wOxGYz+c
         zxwEB4EkYuAaMbVsIAdSVMJCe/d6NEQpzsaEUWZzkqwkkEN5HBysNSqWJ6AewayGybXT
         M1V9cfKOXuq/EQEPIrSc15wtYRk6aC8tK35AvJc9Yiexj62/3NNJDEXMhcqd0waeJoOs
         03DNmumjEEQkO8zn/QXhOtMDncKMgtJninJ8y4yjC5hI0F4kAfv29gtLe4A+gL58HQG+
         X8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438729; x=1784043529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=CGgjMtgjz4EIO49rL9t0El9OxHZC8qEzIG/qMIwMjcWTn8vlldBK+s24csvNCKSCyL
         DUrEOM2hazYqYC71IdftYWwIU0k34tRnYFmcPdb4dGIekIgY/qJequAk1X1ARpGm6vJg
         7PDI2I3Z7DUDJtsGSknISolj1/Kfz1ipTxhSBbUSHEU3RCzT9W1nDqTxiKC5/pW14KaX
         ABKcjfFYHfEYcC0sM2eqXsHG5dXj1VrzOTODeLsiBI5pe342CNzOGIo85csYx9nIkR0S
         PJJWH4ccWIXFne9qRqelo4Nmq78YSkD6Ip72vt+6OPLFdIGSk0Xuk3oZ2R9j/XYEmlMT
         0EjA==
X-Forwarded-Encrypted: i=1; AHgh+RoSlZd0cyyxxR/HqSAMlbV+xjb1uVAeRMrAxQZHrPkQY+9DXapYtn/Js8l4CVUwtsWYr1AKNmN5FwQv@vger.kernel.org
X-Gm-Message-State: AOJu0YzusdiQwJAO7SvyTcIsOh1TOHmFqXnJxq4HUbO0CNJbGlYeCQ4P
	dEXh//GW9R1PG2Y7GBHLvUzY7UBsAsAo0ZerJw72Ki7LnW3zSyn5DopiZfOrt3zqdQg=
X-Gm-Gg: AfdE7cmm/XOs/Fp5Lt98/rPvaaczPXvwlLKUfFc8zdOvF7fMgJL1m+/p0vB7z7MFfCY
	kkcy5WMKsnOUylpykEIMRUwlCpXLKBrUAxnYoAs6nA7ZvlcXFqiJuJHYYfyubaLoNYTkRtcMUSV
	BhiEs/J0R4INZHLpY/XkCKd+nGSu2ctZorEqc8Ur7RsEE5lAb8iC79mYAaHlUBKP1cyVFynIcRO
	LPZelwlMAobuWDvqFBmlvCk4L+Ej0WUU5KTTio2eeYIIneRKroOeRm7whTu8hHxabyqjRHeEe23
	QGJRPc/eBlsWy8RlvEWTxW6Y2icH3r50m3dnYAfhkmSmoauGVqD7VzEj7+BVfR7tR1nugL8ucWZ
	ebWuf5LKTZqR2jQsR7tjVR5Xpwpzo9BBAkQ+e++qKd75Loa3y1dpMiFGxH7aAdNCljWSFRInMgW
	BlkYMvxCsnqQ+DDXL5LTJ6Dil9k56ujhpKAY93FPrWo/r3FsNn6IstxyIlGhyBdXme2y9t2I8yA
	5qv4ppeTvnB5w==
X-Received: by 2002:a05:600c:810b:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493df080788mr55474505e9.34.1783438726830;
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
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
Subject: [PATCH 1/4] x86: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:04 +0200
Message-ID: <20260707153819.4172541-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several x86 files use ELF-related declarations and currently rely on them
being provided indirectly through linux/module.h -> linux/elf.h:

* arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
* arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
* arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
* arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
  elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
  linux/elf.h,
* arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
* arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/entry/entry_fred.c  | 1 +
 arch/x86/entry/syscall_32.c  | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/process.c    | 1 +
 arch/x86/kernel/signal.c     | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index fb3594ddf731..ea3bb4298065 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -9,6 +9,7 @@
 
 #include <asm/desc.h>
 #include <asm/fred.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 #include <asm/syscall.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 31b9492fe851..12fceffc99ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -12,6 +12,7 @@
 #include <asm/traps.h>
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index abb3984336eb..18cf40f08557 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -17,6 +17,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
 #include <asm/cpuid/api.h>
+#include <asm/elf.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea..8b90bf86a742 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/elf.h>
 #include <linux/mman.h>
 #include <linux/kvm_types.h>
 #include <linux/nospec.h>
@@ -26,7 +27,6 @@
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
-#include <asm/elf.h>
 
 #include <uapi/asm/elf.h>
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 85435044e33c..e40f7f3d3489 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/mmu_context.h>
 #include <asm/msr.h>
 #include <asm/shstk.h>
+#include <asm/elf.h>
 
 #include "process.h"
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..0fe2d7a6b1af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 
+#include <asm/elf.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
-- 
2.54.0

