Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C828314A
	for <linux-s390@vger.kernel.org>; Thu, 27 Nov 2025 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206129; cv=none; b=gWJEMECGCORLMpCEaQx+tP5PnBdu9tVzJ94j54Fvkbf3HggvTIKZD3D9BRNsAtujTkVl9EqIrWQT2SDUu0iCCZoIJhGBIymEKsPQmotg9a7NT/X29eD/dw03dWwBI2cVMX9uvPNhWzw8dLKdTVW1DWeRrUsopsdxLxq56nKfyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206129; c=relaxed/simple;
	bh=8JJsvVVFPtkdjob7EPNBW66C8ozHB8IqOnQbl2EHZ6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gK6fuqX4I4Y4OPKGU//srPY715kqgwY0LqQPUJf1lvjKPjFf/biNTW29c5kf+HezCF33mOM8vzm2keNsg1EaSFSd6VXKB/4iPT7sFUkzWn2FQm754mTvn1oy9om0XsN3haGHUC+PiIxrJt4YaI9+yPJiAc+jy8lkTTNY5WK9FPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZOR+N3h; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZOR+N3h"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34372216275so371328a91.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Nov 2025 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764206127; x=1764810927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWpzj6B5gF6DB+hbE+NOEZVJH7N1deEp/v5DIh9IZkw=;
        b=EZOR+N3hkmro5Ut8Jfxo4xO48EhJnknBiNAIoZeF9d2ogUOxKJfHUbh5FBfLS04nsO
         lf+EoSErPy1wSrLlKYzhSPUEEqlf2j5+vHur+bzQwvA5A7G7sQ8+bFX6kEb58HF2MUwm
         6QZZN/kQkAhdd82rIHrBUs1zhCsPfc6aU6BwBUj5YlA0xKHo8dM9+D2r37WbhywScYJq
         q/XIxhUDinBb5nCQAKG8pjXTjViLgp3M2RUSS1m5oJoKiZcdhe3FnmkgZwnih77qn+XP
         3PAjit8IE/HGGcNYrno0u9oIp2fdL7grRA8f6GkE7/25xJUmHDhz8+KppoVanR3eVfAU
         Cwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206127; x=1764810927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWpzj6B5gF6DB+hbE+NOEZVJH7N1deEp/v5DIh9IZkw=;
        b=eiiID/gklCac34tPx4jJN3vHk1toSWKQVxiSSx2TAChR6VcPIqokCKwPf12IuicpSU
         vVQgKu330UH/qImyBhXTLCvGQBXRmKK/t+4/xvHivrKsaIbPM3phn/QKFXRAcgKDGAMR
         p3o6a0itOagvSx6D9lW9+U7lakWhLd87TDVuMSNOY1LQJSFtU1Ivs04LgOnzRUafDLRd
         Ho3mps/8CFQEOdGU8k/djoXLVNkiqIBp0XQftpBx9xEmJ+hhF7zJda5GdMV6SVsuHzg3
         tGF6QjUF0G/vyL/pN8YQrK5EKn2rZ11BnBtSp5crM0dzA36CZTQ2nEbdURyN9RnGHRsT
         OOwA==
X-Forwarded-Encrypted: i=1; AJvYcCX7eeo5SxiHtO2ukFgcTCkllc2D+kk0Q7v5eGQGqXzKlbc93AZ9eXjnJvaGCAbTLAoGAhsOmVuUnAKy@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyZIVFVeRbEJAnR7mC1iEdwB9vG49szO4PgJUoh2KtYAo93yV
	SsFQIxGLQKL19t9vUeHx3jakAMSW7inJmvMFb3W0XQkbMMQqw+Uqc0Om
X-Gm-Gg: ASbGncsxVSgAUsimCR4tydIX7anDa3ReScrrhT6PAd8jafHErCXbDi2s7kxhGyTt02C
	VwK6FSKmy0ytYa8E00mu0rUaquUTotBMsPzMCNcttBxfBWImugP6yhcGCCkQv2GFG+/NDbd/e2l
	fINfa+FTeq+bJJle3v93VD17JobjuQ0AN4hDwXHNB067dMmOKf9w3YRp5U0Uq3swWDOquPfDr0G
	kMOKEvq4Z/3HNu23xgwFE8Vk5xU6BRwmdxA+6Ica9Ue3E3+WLGn6us1yNRRSEQlRC8fKHlBkor3
	lHwjHkZJFPduI3h6K3bZVj9W6hfGaonkUtyVCy72HRhvYPEIzXszdIG5oVDldhtu7NhL5IvjFzF
	L+b1r8usQjYzpJ5AyUBAIuJx05GJ1qWgV3XMtCm1XKPeLowod9sVJ8guhVnVJgiuhSjVzVa7p1V
	1tLwwJDjs9rSAu0dPkasSvsTa0
X-Google-Smtp-Source: AGHT+IEbVGx3N69Si7CHlaljqaf40tFMimNr+eyLkblnTtUDUiJAn2jdCvTJXncBxHt/s07HBZRGvQ==
X-Received: by 2002:a17:90b:48c6:b0:340:5c38:3a56 with SMTP id 98e67ed59e1d1-34733f5cef1mr21117170a91.37.1764206126598;
        Wed, 26 Nov 2025 17:15:26 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c414c226f9sm22447356b3a.53.2025.11.26.17.15.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:15:25 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Oven Liyang <liyangouwen1@oppo.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH 1/2] mm/filemap: Retry fault by VMA lock if the lock was released for I/O
Date: Thu, 27 Nov 2025 09:14:37 +0800
Message-Id: <20251127011438.6918-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251127011438.6918-1-21cnbao@gmail.com>
References: <20251127011438.6918-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Oven Liyang <liyangouwen1@oppo.com>

If the current page fault is using the per-VMA lock, and we only released
the lock to wait for I/O completion (e.g., using folio_lock()), then when
the fault is retried after the I/O completes, it should still qualify for
the per-VMA-lock path.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kristina Martšenko <kristina.martsenko@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Wentao Guan <guanwentao@uniontech.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: Nam Cao <namcao@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Oven Liyang <liyangouwen1@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm/mm/fault.c       | 5 +++++
 arch/arm64/mm/fault.c     | 5 +++++
 arch/loongarch/mm/fault.c | 4 ++++
 arch/powerpc/mm/fault.c   | 5 ++++-
 arch/riscv/mm/fault.c     | 4 ++++
 arch/s390/mm/fault.c      | 4 ++++
 arch/x86/mm/fault.c       | 4 ++++
 include/linux/mm_types.h  | 9 +++++----
 mm/filemap.c              | 5 ++++-
 9 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..49fc0340821c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -313,6 +313,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -342,6 +343,10 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 			goto no_context;
 		return 0;
 	}
+
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 125dfa6c613b..842f50b99d3e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -622,6 +622,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -668,6 +669,10 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 			goto no_context;
 		return 0;
 	}
+
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 2c93d33356e5..738f495560c0 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -219,6 +219,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -265,6 +266,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 			no_context(regs, write, address);
 		return;
 	}
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 806c74e0d5ab..cb7ffc20c760 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -487,6 +487,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -516,7 +517,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (fault_signal_pending(fault, regs))
 		return user_mode(regs) ? 0 : SIGBUS;
-
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 	/* When running in the kernel we expect faults to occur only to
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4..b94cf57c2b9a 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -347,6 +347,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
@@ -376,6 +377,9 @@ void handle_page_fault(struct pt_regs *regs)
 			no_context(regs, addr);
 		return;
 	}
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index e1ad05bfd28a..8d91c6495e13 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -286,6 +286,7 @@ static void do_exception(struct pt_regs *regs, int access)
 		flags |= FAULT_FLAG_WRITE;
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
+retry_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -310,6 +311,9 @@ static void do_exception(struct pt_regs *regs, int access)
 			handle_fault_error_nolock(regs, 0);
 		return;
 	}
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 retry:
 	vma = lock_mm_and_find_vma(mm, address, regs);
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 998bd807fc7b..6023d0083903 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1324,6 +1324,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
+retry_vma:
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
 		goto lock_mmap;
@@ -1353,6 +1354,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 						 ARCH_DEFAULT_PKEY);
 		return;
 	}
+	/* If the first try is only about waiting for the I/O to complete */
+	if (fault & VM_FAULT_RETRY_VMA)
+		goto retry_vma;
 lock_mmap:
 
 retry:
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b71625378ce3..12b2d65ef1b9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1670,10 +1670,11 @@ enum vm_fault_reason {
 	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
 	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
 	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
-	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
-	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
-	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
-	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_RETRY_VMA      = (__force vm_fault_t)0x000800,
+	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x001000,
+	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x002000,
+	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x004000,
+	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 7d15a9c216ef..57dfd2211109 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3464,6 +3464,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	bool mapping_locked = false;
+	bool retry_by_vma_lock = false;
 
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(index >= max_idx))
@@ -3560,6 +3561,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (fpin) {
 		folio_unlock(folio);
+		if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+			retry_by_vma_lock = true;
 		goto out_retry;
 	}
 	if (mapping_locked)
@@ -3610,7 +3613,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
 		fput(fpin);
-	return ret | VM_FAULT_RETRY;
+	return ret | VM_FAULT_RETRY | (retry_by_vma_lock ? VM_FAULT_RETRY_VMA : 0);
 }
 EXPORT_SYMBOL(filemap_fault);
 
-- 
2.39.3 (Apple Git-146)

