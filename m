Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB43655F0
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137768; cv=none; b=V3fmMkCkAdaWPwzJo9w9jzOIjtqUjaH4RSLH43HICS9XJusj99brmViiQQrkmANTEmwyLbo1OQPrVvhju13Jusr8mLvz9DftpuopX0DJ3zc0gomyR5A3QJz77BNkSDzIfFgFPaqCI/ZYx9Z1gnYGkesE8veCB8/AIhzmAdkz+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137768; c=relaxed/simple;
	bh=Q6gYJk+pvivEut4Dg9S1KYlKEBevCBrSEwCT14tMvuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1dJd00vkvML97+msgT49qp90Bql7E3hg2VMdwcLE5OYJvkG38exRujrciIp0ePoh8HX4sGWVLj5wyOD2JWxO4dK0M3jmF0p1qa6M5poKH51EWytRxExGvyrDEsCmRpsg6bbjaMrxUs1cBr8KkCRHu8a9TecX/JPMPvNUMZzaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b5syWAab; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b5syWAab"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso3110325e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137764; x=1789742564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o6xq0BxW8kPi2a+1MlzTOWetcM4nnwrAPZoyBYnvLVM=;
        b=b5syWAabYfLW/JkamLeCwo12Ds0StLNJSUY639dt7/PEU/zeXEnHt1BG/56u3em7j/
         QbBuSSvhKFQimwQL5tycIRYUKhpy079ocqnMl2oUiWmvHqaF3I/BZTYGalvm5opiRKRJ
         fClUSQX4cnLSlHYJByehBH+NYN9Y4fNk4LFOyQaKajA3GlE69PnSOhDt3rKwiX1hp7zS
         QbQ1PKkqX7CeVUzqRDKNuAbhztGsSN9maJ2hKkU6pPAnQdaGUUMf69EYIFNfPDQmk7LK
         5duFJ96WYai4NazsmJ0Y2M1qoSbdFoZBMMxUuW20BI/PfHPKD5GE3XhGIOz60+FYUmaA
         fJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137764; x=1789742564;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6xq0BxW8kPi2a+1MlzTOWetcM4nnwrAPZoyBYnvLVM=;
        b=NsqsJFkfF73Uj3NAVSs2aKLXWnwpo8XY5VooEFPJEaI7tkuIhIW6K8h+XlWWs++zwg
         QFlFrOYKAlNcnxtmc/SFKlbOvT63+ookOlyH63Kw2y3yWpEtjco/omgpIAlcyw/eS8KE
         PkfX2hZsPZC8ACD5/kjxUa5v0klFMgAtJjUJFgppLCgQ1OyjxizvIgN6X9l+U+/rGyQU
         Uzcz5Xd1bwxv4lRA3QeLrUMBIEYogZQZslXq3k32DCmKLShZjnvb+RkpDpHzNxv8F6MR
         DmJDQFNVAUzrqPR95zfwCD34CE7s3dXlRXC8rOs15aETRJ/wNwC359eDIX1IUO9BR7ss
         hUNg==
X-Forwarded-Encrypted: i=1; AKwUvBzLM6LYLy/nRnnySPVezITQnRtwS/IJLjg4XJ3ywrkw//7DEakp6jBqw1sPLMlBNJoCh827/hPpWPud@vger.kernel.org
X-Gm-Message-State: AFuF++lInnXGxP367GGtDka2PZxTtRANS9SUghktvkGcgYcGi11TFbE1
	xrpfrcjtlxhKlcrq/X6FQghgOYUzf2TZSv8e6HCcsv4aNMaZHqZPG04K1aHxZDG2ZZA=
X-Gm-Gg: AYBFou1leHNacfcO/ft6/2mJMH4oDV0+gfRbwJbmv6I8PkA87BXNUfVXr0MBejq0hzl
	9skqy45hQ00Sr69MYzB7B4uwYao26AHE7s/efxAWguJmSCD7YEyDWI8JI8t7WZaiaXm6mFSJZQK
	CNhuP3F/yP3HQ8eFC9fpYOIeXOf+06DXawxsCmxJki5RPjXk9RsKPj4rLNWl3O7qgtmUHZLuWDz
	cX0of1dp8Ehbkx/HHoWY6jNyJyzZpK26k3uQFJYbzMAg3/AERafqyc5MWqftqQ1ofVlrch+XGTf
	3moy/VI3jZ5QdcwUsxNjSLBoWb1pAlyJVTU54PEqhyMMQdYMLIAQtkinNDl4n4s+dqWh9SIP1U+
	osjssBJl29oH/2JhhV9aNCVYgf47QZjgmJMpzW1PiZHMOO9gj7uTms9sbYGIv6+CZ1Q59N1Q+CM
	zes1CKrbShy1EeqUm+hBEHsB5zh6IEx04Vt1Pv2204mhj8/vyrLdXyNfR4Hvk45p/tmt36TEvGE
	XW63A==
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr56105305e9.9.1789137763706;
        Fri, 11 Sep 2026 07:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:43 -0700 (PDT)
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
Subject: [PATCH v2 1/6] x86: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Fri, 11 Sep 2026 16:40:31 +0200
Message-ID: <20260911-module-include-elf-v2-1-954c732975fb@suse.com>
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
index 91123a90710c..4ace5b534f65 100644
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
index 4297ceb2cb24..7dd5a039186e 100644
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
index 346c438ac880..e7f736b53f41 100644
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
2.55.0
