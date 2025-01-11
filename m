Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27617E01B
	for <linux-s390@vger.kernel.org>; Sat, 11 Jan 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574546; cv=none; b=Xj9VwXCSseqm2M9hIIYhk2Sfw6YELtQcQdrNm4+49WPoyvZYji9qdf2d8BWtzvIZrFOWqUpryid0d5Wv1y5ALguyqSZQ6drgiaqxXF9vQLpzU6HHKnLeezV/sPHpXNVbL2f4TTtKhLdiJ6uwV/YPIoxBUcHACfx53krYhKh05NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574546; c=relaxed/simple;
	bh=fAhUoOeYK9fr2EpiTrdYpYKT9gvRJnt1fjb0VAfqM9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9AZGLsJBzR34LFgJ7bouJAxIMX61gLa08FCIosRrfWAW9OfyqhEYupgQ3tWCaLPNNrM9arfzTYaAaGSLj6kDnL86kvbNo3Ck9mjkUBEpIddbRzPilNToyv81Q+QOkD2YzyGrRlSmQzhlShRxGYo6Lnk7RA1vT7uwLFSEmnq+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=XWAH+o6X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="XWAH+o6X"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso46614605ad.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 21:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574541; x=1737179341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He/FF4mW6z63rm6Ez1fm+hLtPmYbF/A35f1xOajKz/c=;
        b=XWAH+o6XKym9MQmLQWn1VzXOO0rwnR9Af5HK04gFfKYWpaOXUthr/ONQUGiTojYCj2
         iG1RBYd/FJcN1kttrOB9Un07OYlvgsbXZq3pBUQg00u1pFWJyCeU1iJUiOrzQ865pY/i
         +VDC3TmSidO+KO3QeXKJkRkNjZXCzcMuXMPTA9pHtn5LraTatzY6X1lQ+6ri+rtmQkYM
         eiOY7oceKVZnjqZevyNADZhmF0e20yRIr8HUC7PHuyvoaRaffZPDQ2t9TYbNjP6W6Fbk
         qk+8ypcfJWUH6YwZ9SO0aDwFE+B7KrrRiidnLj/SrNAJzuhqXMlIrx4RiL8K0BYo2o7q
         FPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574541; x=1737179341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=He/FF4mW6z63rm6Ez1fm+hLtPmYbF/A35f1xOajKz/c=;
        b=dk09MFegAovfYsI7EBAbIHLKGC9Ep9qsXyJwpBgM3sXLrPa6cOeQCyjBU71m9VysT7
         oCAln1I4KiANjruvN1kak2CcZabAD3Ejt28MuUyZraONKoTWwf+AzQXyt4fS2WeBoll9
         31dLNiq8WX2Q5/IGfQkGzitda0IkHC0dAn1IpkCoQneUF18+rV+SAopmXLp25LaVzFMa
         il2lcPcvecXuiuzTPOY1/CzvoTXnbT5dKlyQJRVJYeDNJ4+Hb2AUBHJI+THg7fE1yD8z
         oI2zsHMtlRuhkT96cdrcFFEM/FRTTUqKc77KWgUp722W6xwbWqNi8l6kcPoOJI2OBXPU
         4A7A==
X-Forwarded-Encrypted: i=1; AJvYcCX0JFYT42UlrpR++OVrfjwxK7cXsTY1AXn4OAwFeBi60iEWDWE3pMuwu4Hoc2NIVBOlECER2lu+tqmo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrg+lOOdgbA8Nr2oudcX7MqbG2Yq9Mh3ynyf7mYI0rbNJrH4hW
	QD/D9eEPeZmgmx+iB9tx2960hcDd99kmlNDxNk4jBRQN/tIT0Gfeols1eY/A5j0=
X-Gm-Gg: ASbGncubhm41WVg8+Iwsb+LBnp5J5Z53e4d7nklN0egQPIFuhtH3CdwuyW0S0AFrE80
	lcp8l4nqMPyZmR8pWfDFQaMi5SF6IkmLOSHU4WP5p3ZpRvGhXX+V0ekIk0niXM3DhSHL0w8i81x
	sIUetyU/AhtzEpZDF7uh7VfaXw0Pj1X3QzTWfqE4UwqKYPq1ObHztvOtfTDGllO1C+NMPg1Hsuj
	WHbNTjEkAySlss0SSWIul6ptQ0snpWskFrRe/Hlby+49J9p3QgISdKO0TM=
X-Google-Smtp-Source: AGHT+IHcpmdtla8m811pOhOWUKKg3mt5D2YgMgKQAi/FtxQToiO3ZEw9yK9yhc6mlxAM0lTabpo8Kw==
X-Received: by 2002:a05:6a00:cd6:b0:729:9f1:69bc with SMTP id d2e1a72fcca58-72d21f45b2fmr19552247b3a.12.1736574541182;
        Fri, 10 Jan 2025 21:49:01 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d405489e2sm2380384b3a.32.2025.01.10.21.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:44 +0900
Subject: [PATCH v4 1/6] elf: Define note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
In-Reply-To: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
 LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

elf.h had a comment saying:
> Notes used in ET_CORE. Architectures export some of the arch register
> sets using the corresponding note types via the PTRACE_GETREGSET and
> PTRACE_SETREGSET requests.
> The note name for these types is "LINUX", except NT_PRFPREG that is
> named "CORE".

However, NT_PRSTATUS is also named "CORE". It is also unclear what
"these types" refers to.

To fix these problems, define a name for each note type. The added
definitions are macros so the kernel and userspace can directly refer to
them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..343f5c40d03a 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -368,99 +368,179 @@ typedef struct elf64_shdr {
 #define ELF_OSABI ELFOSABI_NONE
 #endif
 
+/* Note definitions: NN_ defines names. NT_ defines types. */
+
 /*
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for these types is "LINUX", except NT_PRFPREG that is named
- * "CORE".
  */
+#define NN_PRSTATUS	"CORE"
 #define NT_PRSTATUS	1
+#define NN_PRFPREG	"CORE"
 #define NT_PRFPREG	2
+#define NN_PRPSINFO	"CORE"
 #define NT_PRPSINFO	3
+#define NN_TASKSTRUCT	"CORE"
 #define NT_TASKSTRUCT	4
+#define NN_AUXV		"CORE"
 #define NT_AUXV		6
 /*
  * Note to userspace developers: size of NT_SIGINFO note may increase
  * in the future to accomodate more fields, don't assume it is fixed!
  */
+#define NN_SIGINFO      "CORE"
 #define NT_SIGINFO      0x53494749
+#define NN_FILE         "CORE"
 #define NT_FILE         0x46494c45
+#define NN_PRXFPREG     "LINUX"
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+#define NN_PPC_VMX	"LINUX"
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
+#define NN_PPC_SPE	"LINUX"
 #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NN_PPC_VSX	"LINUX"
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NN_PPC_TAR	"LINUX"
 #define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NN_PPC_PPR	"LINUX"
 #define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NN_PPC_DSCR	"LINUX"
 #define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NN_PPC_EBB	"LINUX"
 #define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NN_PPC_PMU	"LINUX"
 #define NT_PPC_PMU	0x107		/* Performance Monitor Registers */
+#define NN_PPC_TM_CGPR	"LINUX"
 #define NT_PPC_TM_CGPR	0x108		/* TM checkpointed GPR Registers */
+#define NN_PPC_TM_CFPR	"LINUX"
 #define NT_PPC_TM_CFPR	0x109		/* TM checkpointed FPR Registers */
+#define NN_PPC_TM_CVMX	"LINUX"
 #define NT_PPC_TM_CVMX	0x10a		/* TM checkpointed VMX Registers */
+#define NN_PPC_TM_CVSX	"LINUX"
 #define NT_PPC_TM_CVSX	0x10b		/* TM checkpointed VSX Registers */
+#define NN_PPC_TM_SPR	"LINUX"
 #define NT_PPC_TM_SPR	0x10c		/* TM Special Purpose Registers */
+#define NN_PPC_TM_CTAR	"LINUX"
 #define NT_PPC_TM_CTAR	0x10d		/* TM checkpointed Target Address Register */
+#define NN_PPC_TM_CPPR	"LINUX"
 #define NT_PPC_TM_CPPR	0x10e		/* TM checkpointed Program Priority Register */
+#define NN_PPC_TM_CDSCR	"LINUX"
 #define NT_PPC_TM_CDSCR	0x10f		/* TM checkpointed Data Stream Control Register */
+#define NN_PPC_PKEY	"LINUX"
 #define NT_PPC_PKEY	0x110		/* Memory Protection Keys registers */
+#define NN_PPC_DEXCR	"LINUX"
 #define NT_PPC_DEXCR	0x111		/* PowerPC DEXCR registers */
+#define NN_PPC_HASHKEYR	"LINUX"
 #define NT_PPC_HASHKEYR	0x112		/* PowerPC HASHKEYR register */
+#define NN_386_TLS	"LINUX"
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
+#define NN_386_IOPERM	"LINUX"
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
+#define NN_X86_XSTATE	"LINUX"
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 /* Old binutils treats 0x203 as a CET state */
+#define NN_X86_SHSTK	"LINUX"
 #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NN_X86_XSAVE_LAYOUT	"LINUX"
 #define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
+#define NN_S390_HIGH_GPRS	"LINUX"
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
+#define NN_S390_TIMER	"LINUX"
 #define NT_S390_TIMER	0x301		/* s390 timer register */
+#define NN_S390_TODCMP	"LINUX"
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
+#define NN_S390_TODPREG	"LINUX"
 #define NT_S390_TODPREG	0x303		/* s390 TOD programmable register */
+#define NN_S390_CTRS	"LINUX"
 #define NT_S390_CTRS	0x304		/* s390 control registers */
+#define NN_S390_PREFIX	"LINUX"
 #define NT_S390_PREFIX	0x305		/* s390 prefix register */
+#define NN_S390_LAST_BREAK	"LINUX"
 #define NT_S390_LAST_BREAK	0x306	/* s390 breaking event address */
+#define NN_S390_SYSTEM_CALL	"LINUX"
 #define NT_S390_SYSTEM_CALL	0x307	/* s390 system call restart data */
+#define NN_S390_TDB	"LINUX"
 #define NT_S390_TDB	0x308		/* s390 transaction diagnostic block */
+#define NN_S390_VXRS_LOW	"LINUX"
 #define NT_S390_VXRS_LOW	0x309	/* s390 vector registers 0-15 upper half */
+#define NN_S390_VXRS_HIGH	"LINUX"
 #define NT_S390_VXRS_HIGH	0x30a	/* s390 vector registers 16-31 */
+#define NN_S390_GS_CB	"LINUX"
 #define NT_S390_GS_CB	0x30b		/* s390 guarded storage registers */
+#define NN_S390_GS_BC	"LINUX"
 #define NT_S390_GS_BC	0x30c		/* s390 guarded storage broadcast control block */
+#define NN_S390_RI_CB	"LINUX"
 #define NT_S390_RI_CB	0x30d		/* s390 runtime instrumentation */
+#define NN_S390_PV_CPU_DATA	"LINUX"
 #define NT_S390_PV_CPU_DATA	0x30e	/* s390 protvirt cpu dump data */
+#define NN_ARM_VFP	"LINUX"
 #define NT_ARM_VFP	0x400		/* ARM VFP/NEON registers */
+#define NN_ARM_TLS	"LINUX"
 #define NT_ARM_TLS	0x401		/* ARM TLS register */
+#define NN_ARM_HW_BREAK	"LINUX"
 #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
+#define NN_ARM_HW_WATCH	"LINUX"
 #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
+#define NN_ARM_SYSTEM_CALL	"LINUX"
 #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+#define NN_ARM_SVE	"LINUX"
 #define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
+#define NN_ARM_PAC_MASK		"LINUX"
 #define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NN_ARM_PACA_KEYS	"LINUX"
 #define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NN_ARM_PACG_KEYS	"LINUX"
 #define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
+#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
 #define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl()) */
+#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
 #define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl()) */
+#define NN_ARM_SSVE	"LINUX"
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
+#define NN_ARM_ZA	"LINUX"
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
+#define NN_ARM_ZT	"LINUX"
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NN_ARM_FPMR	"LINUX"
 #define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
+#define NN_ARM_POE	"LINUX"
 #define NT_ARM_POE	0x40f		/* ARM POE registers */
+#define NN_ARM_GCS	"LINUX"
 #define NT_ARM_GCS	0x410		/* ARM GCS state */
+#define NN_ARC_V2	"LINUX"
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
+#define NN_VMCOREDD	"LINUX"
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
+#define NN_MIPS_DSP	"LINUX"
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
+#define NN_MIPS_FP_MODE	"LINUX"
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
+#define NN_MIPS_MSA	"LINUX"
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NN_RISCV_CSR	"LINUX"
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
+#define NN_RISCV_VECTOR	"LINUX"
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NN_RISCV_TAGGED_ADDR_CTRL "LINUX"
 #define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
+#define NN_LOONGARCH_CPUCFG	"LINUX"
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
+#define NN_LOONGARCH_CSR	"LINUX"
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
+#define NN_LOONGARCH_LSX	"LINUX"
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
+#define NN_LOONGARCH_LASX	"LINUX"
 #define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
+#define NN_LOONGARCH_LBT	"LINUX"
 #define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
+#define NN_LOONGARCH_HW_BREAK	"LINUX"
 #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
+#define NN_LOONGARCH_HW_WATCH	"LINUX"
 #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
 
-/* Note types with note name "GNU" */
+/* Note used in other file types. */
+#define NN_GNU_PROPERTY_TYPE_0	"GNU"
 #define NT_GNU_PROPERTY_TYPE_0	5
 
 /* Note header in a PT_NOTE section */

-- 
2.47.1

