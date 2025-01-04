Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C31B87C6
	for <linux-s390@vger.kernel.org>; Sat,  4 Jan 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001531; cv=none; b=pjwJ0KseUYVQ/yV09ELpnvbeqcWaNEBa/qsach4Q9XdOpc6ENyazzvIOEDfMHmsgvExfkaFREjyg5tigKinb360igczqd2hgpXNPoRfJgP2Y853eCF/ImwF07OsNV6a3uFDNZkcyjJP37zonMOJG7lGBTc2i4f9gY1orjYguFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001531; c=relaxed/simple;
	bh=+9AXsZEgivq8OXu9cFbVsgFlrM5UGkMjHGJQ78emYi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhMms8NLQh4cYiAiAn/yE/X+8/2kXcNjHV0yK/hdDTBkuohvf5eZ3o4ZQyAoThBgPvkrEaMaBUp9jyWHBhgxatvWnRD+CwyNHdPVZpcAyFIp3/gSaaxo88lOwTkIr0hfdTybwNoF8uz/7zYITmnPlhVrjHXeG7oEMaTEA9J/Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=m8ejexet; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="m8ejexet"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21644aca3a0so111564235ad.3
        for <linux-s390@vger.kernel.org>; Sat, 04 Jan 2025 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001529; x=1736606329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DDRJB8oNZeq6N6MlMy+rUGIqaIntb5QA28c12Ptyck=;
        b=m8ejexetduw6tlJy/UtPG2y5lvEVPWFwuVqpRUJ4nB96q6O80hrRQPwPaTZADtz9ig
         lmfBShZkb8qh3LF6sYpcQGhnXOMbvtaPnsuWTZeZeqA2pV/9peWzGWtOg5iTnXAUKSyv
         h+3WVCy7dV7Ctaw/+y8qUQ0QGiAFLoMSZqR5TYG9GmMbpHjue19Ta4F7YboB6RDFCnbv
         cUue+VeXUNAldjhaegSfw1I7zmkhai3kjqVtboAh+Jq+joPS5qn56lrECmG3h/kXhNPt
         RkTOiPv15Xwd9zac1fIlV1yCl7oTU2XwpV5DVVM7a8mSdW0TSxI1B21bBCyaElvZHwwW
         DKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001529; x=1736606329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DDRJB8oNZeq6N6MlMy+rUGIqaIntb5QA28c12Ptyck=;
        b=Sg6RwqKFmyzt7T0mQv82HhjeniVUyvRPVkq0vgCPXMKZ/6JGQ0kXOGI1SnftKS4JJP
         HTTIUgxgxrKsA2NdLbsGDur/as4C3nLM7V1f+YJhkuRt2JJK4nEr49fnJ9v86pDSfHkH
         A0IkcNHWxOlFBjBV350ZW0yzcI+LSiOV0UqSJl2YanXfEsc5ddd3pLgt9MOS0b0rGcXw
         k34aJ9LMQoilO+CXVQvozAV8d6sugnE+GNdkufO5cUaO/w7pim6zEF237cFJTEAdLPq/
         3ogt3W5mMbRfr7KrTToBLX+1Gmy0f6XsvPzA0ntIIYUmVKt16bucmIlMxPQPPJkNXmPG
         ENIA==
X-Forwarded-Encrypted: i=1; AJvYcCVqtj9RQ9F4dKpiFHZxQoaJ1zQ2grk6aCGLnarVOBP9gPJXPLA/IWI8spW9Yr3AUZihIYaJ+gmf7Tlv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61THvxcdUFFStAPIgHC60dr9mmm2B7cJvET5CY/QIgj78OsvV
	WjCyTlXcNu+TSzWgxYcVKC9YB56U5M92Tsdw9r0fDd+uNn80vu82SEVNhdLsWrI=
X-Gm-Gg: ASbGncsQosbSbeNb0ouIxZtms8hJk2h/Rfaq8uibAA0IaUzNVWdI/FC7uZ4iAeegR+d
	tjtNQSFXINDk0oDyRfP7+lHXUMqkOHCwJSKwcRoANMWB534N8mDmhEHFx3ixYLjEXRGKrRRTRtT
	0JzyDEhtKcdT/ts41/GtedzVovgPRTPA18xgWOquFkhvpjaJlhjLHVEIh0sL3qHzTa8ZOpvqBpo
	yIoqy66L2s76PPx5MVee135lbNTWWJv8kJernIivHAD/Jc+2yp4Kx3mdPOnRJM=
X-Google-Smtp-Source: AGHT+IHXNTPwYGpyoF2oIO9YtYeoBNZ9bkHyASDQWStwZpuI0NOPrSg1SLgfLCaPbrvbr04vYZJzgg==
X-Received: by 2002:a17:902:e5c7:b0:215:bf1b:a894 with SMTP id d9443c01a7336-219e6eb5bffmr760628135ad.24.1736001528912;
        Sat, 04 Jan 2025 06:38:48 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc962c5esm260927675ad.12.2025.01.04.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:38:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:34 +0900
Subject: [PATCH v2 1/5] elf: Define note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
In-Reply-To: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, devel@daynix.com, 
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
---
 include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d29cec..014b705b97d7 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -372,8 +372,6 @@ typedef struct elf64_shdr {
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for these types is "LINUX", except NT_PRFPREG that is named
- * "CORE".
  */
 #define NT_PRSTATUS	1
 #define NT_PRFPREG	2
@@ -460,9 +458,91 @@ typedef struct elf64_shdr {
 #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
 #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
 
-/* Note types with note name "GNU" */
+/* Note used in ET_EXEC and ET_DYN. */
 #define NT_GNU_PROPERTY_TYPE_0	5
 
+/* Note names */
+#define NN_PRSTATUS	"CORE"
+#define NN_PRFPREG	"CORE"
+#define NN_PRPSINFO	"CORE"
+#define NN_TASKSTRUCT	"CORE"
+#define NN_AUXV	"CORE"
+#define NN_SIGINFO	"CORE"
+#define NN_FILE	"CORE"
+#define NN_PRXFPREG	"LINUX"
+#define NN_PPC_VMX	"LINUX"
+#define NN_PPC_SPE	"LINUX"
+#define NN_PPC_VSX	"LINUX"
+#define NN_PPC_TAR	"LINUX"
+#define NN_PPC_PPR	"LINUX"
+#define NN_PPC_DSCR	"LINUX"
+#define NN_PPC_EBB	"LINUX"
+#define NN_PPC_PMU	"LINUX"
+#define NN_PPC_TM_CGPR	"LINUX"
+#define NN_PPC_TM_CFPR	"LINUX"
+#define NN_PPC_TM_CVMX	"LINUX"
+#define NN_PPC_TM_CVSX	"LINUX"
+#define NN_PPC_TM_SPR	"LINUX"
+#define NN_PPC_TM_CTAR	"LINUX"
+#define NN_PPC_TM_CPPR	"LINUX"
+#define NN_PPC_TM_CDSCR	"LINUX"
+#define NN_PPC_PKEY	"LINUX"
+#define NN_PPC_DEXCR	"LINUX"
+#define NN_PPC_HASHKEYR	"LINUX"
+#define NN_386_TLS	"LINUX"
+#define NN_386_IOPERM	"LINUX"
+#define NN_X86_XSTATE	"LINUX"
+#define NN_X86_SHSTK	"LINUX"
+#define NN_X86_XSAVE_LAYOUT	"LINUX"
+#define NN_S390_HIGH_GPRS	"LINUX"
+#define NN_S390_TIMER	"LINUX"
+#define NN_S390_TODCMP	"LINUX"
+#define NN_S390_TODPREG	"LINUX"
+#define NN_S390_CTRS	"LINUX"
+#define NN_S390_PREFIX	"LINUX"
+#define NN_S390_LAST_BREAK	"LINUX"
+#define NN_S390_SYSTEM_CALL	"LINUX"
+#define NN_S390_TDB	"LINUX"
+#define NN_S390_VXRS_LOW	"LINUX"
+#define NN_S390_VXRS_HIGH	"LINUX"
+#define NN_S390_GS_CB	"LINUX"
+#define NN_S390_GS_BC	"LINUX"
+#define NN_S390_RI_CB	"LINUX"
+#define NN_S390_PV_CPU_DATA	"LINUX"
+#define NN_ARM_VFP	"LINUX"
+#define NN_ARM_TLS	"LINUX"
+#define NN_ARM_HW_BREAK	"LINUX"
+#define NN_ARM_HW_WATCH	"LINUX"
+#define NN_ARM_SYSTEM_CALL	"LINUX"
+#define NN_ARM_SVE	"LINUX"
+#define NN_ARM_PAC_MASK	"LINUX"
+#define NN_ARM_PACA_KEYS	"LINUX"
+#define NN_ARM_PACG_KEYS	"LINUX"
+#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
+#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
+#define NN_ARM_SSVE	"LINUX"
+#define NN_ARM_ZA	"LINUX"
+#define NN_ARM_ZT	"LINUX"
+#define NN_ARM_FPMR	"LINUX"
+#define NN_ARM_POE	"LINUX"
+#define NN_ARM_GCS	"LINUX"
+#define NN_ARC_V2	"LINUX"
+#define NN_VMCOREDD	"LINUX"
+#define NN_MIPS_DSP	"LINUX"
+#define NN_MIPS_FP_MODE	"LINUX"
+#define NN_MIPS_MSA	"LINUX"
+#define NN_RISCV_CSR	"LINUX"
+#define NN_RISCV_VECTOR	"LINUX"
+#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
+#define NN_LOONGARCH_CPUCFG	"LINUX"
+#define NN_LOONGARCH_CSR	"LINUX"
+#define NN_LOONGARCH_LSX	"LINUX"
+#define NN_LOONGARCH_LASX	"LINUX"
+#define NN_LOONGARCH_LBT	"LINUX"
+#define NN_LOONGARCH_HW_BREAK	"LINUX"
+#define NN_LOONGARCH_HW_WATCH	"LINUX"
+#define NN_GNU_PROPERTY_TYPE_0	"GNU"
+
 /* Note header in a PT_NOTE section */
 typedef struct elf32_note {
   Elf32_Word	n_namesz;	/* Name size */

-- 
2.47.1

