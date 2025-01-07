Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517641EE7B1
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254110; cv=none; b=EiEMB7AleKnaEwqlA8bC9BnJvzSYcvQApmTewRH+33wTkV449llcPdGl62GVDdlKm+23jI6S5HIHcVwWYy9cUlfDppY0rmCA1N26j5t+hBLhr4wdnfEgkb1+lR9Q/QOj08jU8zD/NgRc1FPTVs/eX35Wuchel+dJISfb76aU9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254110; c=relaxed/simple;
	bh=fk1yr9yll80l0GX6PVUrYoQYmm4+oWG0A+5XGSbr4Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blnSCtAxIv/hD/WnY6GQsuf2E2qv+sqJVJgU2veb4z3ENYGZNKyfi05bIeROjHGzfD0aI8pNHUrwZetxKF1b672VU1PaLzQ5ZVVKv9KjCajdUJSuvEb54U2wzBpBamnQDES4dgWUXiEOHwRrzpBRU0akB289kRWBFAfrVBFF7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=z7okr5+t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="z7okr5+t"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-218c8aca5f1so32303785ad.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254105; x=1736858905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B/uoyeuY57p4F5WrCZvdn0Td4esItXL4IJBDCfsGf4=;
        b=z7okr5+tqDtV+v9bdq0vE18Zy3LyUruKMt0cWwWO8dkqrH8JwUm87JTqnjtw6ACw0k
         6xzg63YUGV/VkeXBExB2kRAkdASS71jxlQ6WJ4y2U9mH77ce6kg6SbjunKXe6p6jdFsN
         6uSCqns3eiQCSvg3AicdEzSX/Bb/SE5bTTLPNxxPRn2jC2u2w8pHASdBUK94HXK9R9z0
         JtJjto47vbAZklcIisbJmdXy17zwnZrvaRISrf6DQotkQnV2cvArzDdPZNS9KzQkYipb
         lSbQSxgqvEFCtqchRXxF1orWGzVQmh07aGcGrg5JbCSCHrRdl2rqK/Wq+6CYlfrxj6iF
         Xx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254105; x=1736858905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B/uoyeuY57p4F5WrCZvdn0Td4esItXL4IJBDCfsGf4=;
        b=qtyruhEXqCjvj5OuAv9tWj5S2rYeTSW8uRBQZFPb0mDZj5MF2nac8FAf1BFgoBTl1K
         5eSjK4xJF5VENkdQ23zP7WiuTK7+2rZtoY2NhWLKPTGpz5165WzXCDBQ7QFRzTNNRMV4
         FlNQPHCuC/k4jniet2XPfxE0SRYcYx7LqhCEP6V77Q59EG5PWTgDfh0E2SahZGI1wDZ5
         cRIfiSEmwhHYTx2VEtgRKKRb641K2u2RVuFToHj6GIICtuRT/bwRQhOT50ojnqSNtIkx
         HVY+XTWVrO7/CPU9wKq9gaGyn3ZM8TYzRCGpo6eOQiOUNhmKx5jyiKK3fLOIrtX1Nwga
         Cbsg==
X-Forwarded-Encrypted: i=1; AJvYcCXCY5SmDYSILX3RQ6Vy8hKEpblyS5HAHkjsaVAcOS0m/QBRESXMo3y3TS/whqjAAcb5NZyfsOi30mpx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+/ylSfdVAiEvsC0IwNOCUmfkQoLvBjt1RG0Of8G//EJ3JPpg
	55w1b0vbcYSJszkOONc5o3D7TNrgXvS5kjvZ0w6VZyoAe94qsSPLs2ph4f3Zhrk=
X-Gm-Gg: ASbGncutbbx6/BM9gRUo8M/jOTm7xcd+24RmgPEAsL5beTwcSw9TkgNps8JLoM19tWE
	JJrvjL3ehS7Aj1bELBwDusn1B6qVwJrPWU44BScfNk/zDHqpWqALiza50IAKlw48j2o/fArkYqx
	IrjV9ahwtm1MolbTN7//njrUi1ef5zDHl5Adyat8kxuX0IryHT/q3SCKkcJ8+dMsIvIOcenXIxc
	HChEvV6LqSlOwNs6GzSe8XemO2LS1KSTDy5pMrPnoZTshhBj4OMXHpggn0=
X-Google-Smtp-Source: AGHT+IFrm4rj/MLEj5on8APad3buiaiqCoLZIEAZ2AeMT04ViEKVqkKOmnPzjy3rlA6C6aSb7vkHeg==
X-Received: by 2002:a05:6a00:f96:b0:724:ed8f:4d35 with SMTP id d2e1a72fcca58-72abdedda5fmr91700514b3a.26.1736254105569;
        Tue, 07 Jan 2025 04:48:25 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8fd7b0sm22424647b3a.139.2025.01.07.04.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:56 +0900
Subject: [PATCH v3 5/6] s390/crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
In-Reply-To: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, Baoquan He <bhe@redhat.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..6359ce645756 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -248,15 +248,6 @@ bool is_kdump_kernel(void)
 }
 EXPORT_SYMBOL_GPL(is_kdump_kernel);
 
-static const char *nt_name(Elf64_Word type)
-{
-	const char *name = "LINUX";
-
-	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
-		name = KEXEC_CORE_NOTE_NAME;
-	return name;
-}
-
 /*
  * Initialize ELF note
  */
@@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
 	return PTR_ADD(buf, len);
 }
 
-static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
-{
-	return nt_init_name(buf, type, desc, d_len, nt_name(type));
-}
+#define NT_INIT(buf, type, desc) \
+	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
 
 /*
  * Calculate the size of ELF note
@@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
 	return size;
 }
 
-static inline size_t nt_size(Elf64_Word type, int d_len)
-{
-	return nt_size_name(d_len, nt_name(type));
-}
+#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))
 
 /*
  * Fill ELF notes for one CPU with save area registers
@@ -324,18 +310,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
 	memcpy(&nt_fpregset.fpc, &sa->fpc, sizeof(sa->fpc));
 	memcpy(&nt_fpregset.fprs, &sa->fprs, sizeof(sa->fprs));
 	/* Create ELF notes for the CPU */
-	ptr = nt_init(ptr, NT_PRSTATUS, &nt_prstatus, sizeof(nt_prstatus));
-	ptr = nt_init(ptr, NT_PRFPREG, &nt_fpregset, sizeof(nt_fpregset));
-	ptr = nt_init(ptr, NT_S390_TIMER, &sa->timer, sizeof(sa->timer));
-	ptr = nt_init(ptr, NT_S390_TODCMP, &sa->todcmp, sizeof(sa->todcmp));
-	ptr = nt_init(ptr, NT_S390_TODPREG, &sa->todpreg, sizeof(sa->todpreg));
-	ptr = nt_init(ptr, NT_S390_CTRS, &sa->ctrs, sizeof(sa->ctrs));
-	ptr = nt_init(ptr, NT_S390_PREFIX, &sa->prefix, sizeof(sa->prefix));
+	ptr = NT_INIT(ptr, PRSTATUS, nt_prstatus);
+	ptr = NT_INIT(ptr, PRFPREG, nt_fpregset);
+	ptr = NT_INIT(ptr, S390_TIMER, sa->timer);
+	ptr = NT_INIT(ptr, S390_TODCMP, sa->todcmp);
+	ptr = NT_INIT(ptr, S390_TODPREG, sa->todpreg);
+	ptr = NT_INIT(ptr, S390_CTRS, sa->ctrs);
+	ptr = NT_INIT(ptr, S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
-			      &sa->vxrs_high, sizeof(sa->vxrs_high));
-		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
-			      &sa->vxrs_low, sizeof(sa->vxrs_low));
+		ptr = NT_INIT(ptr, S390_VXRS_HIGH, sa->vxrs_high);
+		ptr = NT_INIT(ptr, S390_VXRS_LOW, sa->vxrs_low);
 	}
 	return ptr;
 }
@@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
 	struct save_area *sa = NULL;
 	size_t size;
 
-	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
-	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
-	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
-	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
-	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
-	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
-	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
+	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
+	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
+	size +=  NT_SIZE(S390_TIMER, sa->timer);
+	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
+	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
+	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
+	size +=  NT_SIZE(S390_PREFIX, sa->prefix);
 	if (cpu_has_vx()) {
-		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
-		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
+		size += NT_SIZE(S390_VXRS_HIGH, sa->vxrs_high);
+		size += NT_SIZE(S390_VXRS_LOW, sa->vxrs_low);
 	}
 
 	return size;
@@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
 	memset(&prpsinfo, 0, sizeof(prpsinfo));
 	prpsinfo.pr_sname = 'R';
 	strcpy(prpsinfo.pr_fname, "vmlinux");
-	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
+	return NT_INIT(ptr, PRPSINFO, prpsinfo);
 }
 
 /*
@@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
 	/* PT_NOTES */
 	size += sizeof(Elf64_Phdr);
 	/* nt_prpsinfo */
-	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
+	size += NT_SIZE(PRPSINFO, struct elf_prpsinfo);
 	/* regsets */
 	size += get_cpu_cnt() * get_cpu_elf_notes_size();
 	/* nt_vmcoreinfo */

-- 
2.47.1

