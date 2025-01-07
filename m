Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821441F428A
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254090; cv=none; b=sgfrjmnycdJT8krzmOfSxTNAcNKDf5ZcOctkkvoKMJLXK1w84RRe/9orHWEwVDy/hYEiBhPrkNAghEHwNWD6Y0mr+hhXQovyuCALw1pBB/RY3JZWsfaVO5QYcf589/nH2TWGWbBpVnH176cRebmrtREdnGaqzAy2qRy9lUDFr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254090; c=relaxed/simple;
	bh=nHxDNiGj0kP+OrAR/r8E7Aht5XhcJNfHXGmXX9sgsJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tiyk7mojnVWEWajt1fCnwk68/LmldW1sBMUDa3IbdPsxCwh4fff1PFqa5PXxwoX40gs2Ftwq0JfYarVN+Nfp28/Okiy6+OP+Kp6m5usvIppuxSnEp8PLK+uzU0iZJyI3fKPYm0RIPpwZmGiUMPg0cyQuBrgmqlGeN9Po0iTf8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xEfMgI5k; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xEfMgI5k"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so22989894a91.3
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254086; x=1736858886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To6WceQOVEAdrv9VIwdrgLUfIkfIZojfYpt2+tcFAZE=;
        b=xEfMgI5kbkTVeGptLFiLR+4f5wt4CNNS6VvNfdh6sYspAneYv8nQK2pVIu1l58htvp
         gLIKKe9Nypr2eElu2ZAQqFKgypPZ1thVz177hD/K0gDeTA/RqlQFmQl2D1eKw7iKUrAY
         u5DGBeflXwx30ewPWSKNknbvkWgMqf1m6M31+bJ9Ap9amST/dWsaOaTq/j+UvfD6Hq5P
         K5XDeqTlLJP7daD2WG+k08CpwaqOvDjhrJxBpYlzB/rhSHIcuTd+bjtlYnFZjRgWgz4P
         ysN2q7zBbzj6hG/gDDKs63K9ExIYe9t3DxxdeVL/OWMA/nFhdshscjsKWDA/7DjCddls
         8mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254086; x=1736858886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To6WceQOVEAdrv9VIwdrgLUfIkfIZojfYpt2+tcFAZE=;
        b=QjDjOXCofPTPZdPsXmj6CEtvrbicvYCTsH5hEPknOKgmLTGh91j3t6PB+z3WnARQ02
         VR0mWtOrzK97DLwrXjZWyWN7c/bn7QcmnOO0f73k7YSc2eNovTp3e2TrCmbmN6CbUftp
         /LM/vpFuRItTHE3Kei0MM8KXIrLTGrRQjQaYgHteu/PXPyGAhQsYBZVoBQtABiLWMZUL
         SsKPJzot9Zv8wA6vYqPLVeGoMk9qSDuLFddjrnakXmnKJBByMGIbmBl2Gb+VE0Q4fmE0
         +k7x3G0vKe9zDQ+6cFXvtzGkQhE37UdviBHO80y0YutHgsMSTkD9AbiH15AUCXLGQ8dA
         zynQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/lfHuqFh0Z0f1yHXwSW1C+m79ZRwwfY00SaKFZLlon8Szs4UVE1Uq33hQloHmlRwFbRS0nqHAG7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBJ+3lywNFRE3t3w8Ke8CWqBrQE4toBk3/VJkDJydZg5cVyGw
	wqdesHLOWGgkhdtERqdQbqSArNvpmB8wM7qMAa3X1mYYgQmsHDwh0y7fayDipg0=
X-Gm-Gg: ASbGncsCzbhufAw/cvnlqvqvCeZ9S36O2zXMTvMCp83CA4xFefp5/V2tP6qcetZmTZS
	YezgmfhqkMwBfiLBJaAoBTlhgqjnSiGcospVHKbF5hIx2t4Qxc6M9t3r499tkkFnHqcg82W2RUK
	Z/ATT4x2VDFfaW+vdWQ75Sn0D84BQ0WilP/27BUl5fqA6C9EtB/JgjwKJD8FgiQ28i8Ik+7NSXM
	rFjSH95VgaY+2clna0eb8gMvq36HY5bAo6LhdMgoakme3u6IO4Fit4fngg=
X-Google-Smtp-Source: AGHT+IHmQrtd6DArE28HS9MI+ljcSHS0URGz6WZZfYPdopYVfnKvqXeHpkFOcVWEZed1yb1h138/0Q==
X-Received: by 2002:a05:6a00:22c2:b0:725:ef4b:de33 with SMTP id d2e1a72fcca58-72abdbe4de8mr79321688b3a.0.1736254085564;
        Tue, 07 Jan 2025 04:48:05 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad90b338sm33355957b3a.174.2025.01.07.04.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:53 +0900
Subject: [PATCH v3 2/6] binfmt_elf: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-2-99cb505b1ab2@daynix.com>
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
Acked-by: Baoquan He <bhe@redhat.com>
---
 fs/binfmt_elf.c       | 21 ++++++++++-----------
 fs/binfmt_elf_fdpic.c |  8 ++++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 106f0e8af177..5b4a92e5e508 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -762,8 +762,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 }
 
 #define NOTE_DATA_SZ SZ_1K
-#define GNU_PROPERTY_TYPE_0_NAME "GNU"
-#define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
+#define NOTE_NAME_SZ (sizeof(NN_GNU_PROPERTY_TYPE_0))
 
 static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 				struct arch_elf_state *arch)
@@ -800,7 +799,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
 	    note.nhdr.n_namesz != NOTE_NAME_SZ ||
 	    strncmp(note.data + sizeof(note.nhdr),
-		    GNU_PROPERTY_TYPE_0_NAME, n - sizeof(note.nhdr)))
+		    NN_GNU_PROPERTY_TYPE_0, n - sizeof(note.nhdr)))
 		return -ENOEXEC;
 
 	off = round_up(sizeof(note.nhdr) + NOTE_NAME_SZ,
@@ -1603,14 +1602,14 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
-	fill_note(note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
+	fill_note(note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
 }
 
 static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 		const kernel_siginfo_t *siginfo)
 {
 	copy_siginfo_to_external(csigdata, siginfo);
-	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
+	fill_note(note, NN_SIGINFO, NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
 /*
@@ -1706,7 +1705,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 	}
 
 	size = name_curpos - (char *)data;
-	fill_note(note, "CORE", NT_FILE, size, data);
+	fill_note(note, NN_FILE, NT_FILE, size, data);
 	return 0;
 }
 
@@ -1767,7 +1766,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	regset_get(t->task, &view->regsets[0],
 		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS,
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS,
 		  PRSTATUS_SIZE, &t->prstatus);
 	info->size += notesize(&t->notes[0]);
 
@@ -1801,7 +1800,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		if (is_fpreg)
 			SET_PR_FPVALID(&t->prstatus);
 
-		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
+		fill_note(&t->notes[note_iter], is_fpreg ? NN_PRFPREG : "LINUX",
 			  note_type, ret, data);
 
 		info->size += notesize(&t->notes[note_iter]);
@@ -1821,7 +1820,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	fill_prstatus(&t->prstatus.common, p, signr);
 	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	info->size += notesize(&t->notes[0]);
 
@@ -1832,7 +1831,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	}
 
 	t->prstatus.pr_fpvalid = 1;
-	fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(*fpu), fpu);
+	fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(*fpu), fpu);
 	info->size += notesize(&t->notes[1]);
 
 	return 1;
@@ -1852,7 +1851,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
 		return 0;
-	fill_note(&info->psinfo, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	fill_note(&info->psinfo, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
 
 #ifdef CORE_DUMP_USE_REGSET
 	view = task_user_regset_view(dump_task);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f1a7c4875c4a..96bd9d2f23d7 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1397,7 +1397,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
 	regset_get(p, &view->regsets[0],
 		   sizeof(t->prstatus.pr_reg), &t->prstatus.pr_reg);
 
-	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
+	fill_note(&t->notes[0], NN_PRSTATUS, NT_PRSTATUS, sizeof(t->prstatus),
 		  &t->prstatus);
 	t->num_notes++;
 	*sz += notesize(&t->notes[0]);
@@ -1415,7 +1415,7 @@ static struct elf_thread_status *elf_dump_thread_status(long signr, struct task_
 	}
 
 	if (t->prstatus.pr_fpvalid) {
-		fill_note(&t->notes[1], "CORE", NT_PRFPREG, sizeof(t->fpu),
+		fill_note(&t->notes[1], NN_PRFPREG, NT_PRFPREG, sizeof(t->fpu),
 			  &t->fpu);
 		t->num_notes++;
 		*sz += notesize(&t->notes[1]);
@@ -1530,7 +1530,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	 */
 
 	fill_psinfo(psinfo, current->group_leader, current->mm);
-	fill_note(&psinfo_note, "CORE", NT_PRPSINFO, sizeof(*psinfo), psinfo);
+	fill_note(&psinfo_note, NN_PRPSINFO, NT_PRPSINFO, sizeof(*psinfo), psinfo);
 	thread_status_size += notesize(&psinfo_note);
 
 	auxv = (elf_addr_t *) current->mm->saved_auxv;
@@ -1538,7 +1538,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	do
 		i += 2;
 	while (auxv[i - 2] != AT_NULL);
-	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
+	fill_note(&auxv_note, NN_AUXV, NT_AUXV, i * sizeof(elf_addr_t), auxv);
 	thread_status_size += notesize(&auxv_note);
 
 	offset = sizeof(*elf);				/* ELF header */

-- 
2.47.1

