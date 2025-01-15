Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9722FDFD
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920133; cv=none; b=UumhEAB//E3ecy1+D7hzyM4vQQDXdk3k7J55KxKzrz5/tQ80rSOKdqybV5ubtA51eTGElziJ1+hR8lP/t/ncdGfQFJ3b9DKna446/mtBxZq6QEGbI6QSyQSvXb2w+hwfrGB00OvnrOXhc9ux/qYQv+Wh5K5Wc+xKgnGQuxVtU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920133; c=relaxed/simple;
	bh=OznTh8CTSKljoZuFx8Vgv0i+Bhff7ONaPIhGZUma42Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+k/Teaf+c11rBAHlOAK2nDyjj4kYWApO0dqnkcBZWVBBLca6cMdcR8B2mNl5nc54x9/f4HQ1D7wyDmXD3Gl58YKzROhkpl3sxRASzqgtm+sd1NQWVpPhxs+hrxMotxEGCk+TTZxdPMfbBB2lKeJ5h1Jne3X+C5lG7F2PMWdQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UXiMGbGN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UXiMGbGN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21670dce0a7so137012745ad.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920131; x=1737524931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHzEFJeIZDo3f5k/3U0rvOC8rXQluzySCipEOCSBJIE=;
        b=UXiMGbGNBKqtjkRYNcPYLsYORGzkJtiUyvztX8o0vJie/KV0ViDtiDnUL/PkhRaUvm
         tPNGzmmruqAF7QGZ2jJV8KkC3ojFD5Q844WWxGgXFjJXmm2ml+MhnzoT58XHOakhxFc5
         XywETxzrRg3z9IDi8Cihk09N39Kc2pIOt81GXNB87vxor7njkVBxRNAno0gvZphwaLtT
         1ulXqgEJVkb5iz+JBsJ8KhJHkTbKw0XOTLU5RmIz8+D+2uF2Etq0PGBXY1bqd0wQwqeP
         hxG6d+O6DXvOrGQn5cjOWPV5iHLbVrqT+6tO+pDPrTUbeys/LxgqnTuWL3a1HmF+pcXz
         iKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920131; x=1737524931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHzEFJeIZDo3f5k/3U0rvOC8rXQluzySCipEOCSBJIE=;
        b=ptJTRwuHuZ+J1AzQ/mCSD5f4gsLNSfYpqj35geGiR/ckkMb3unsr6JJXlGOYQHCqbA
         oHRgnLaOSz6X4jo8OjuJ0Wb4bentCBd5SM9WKnn96fYATCZpoTcfhDUdHY+SlEsjpBLb
         XMS+Ydz7w3rp1/rF8DbmOzS7BfLa8ehoKREIsOLKv3mJeQ4nL2Bt5U9moOvlKbBY2SDi
         HmB963SbTNIjz4qr/THmiYuXZVl6BeU26E0yk/u3TtxByq9oDyyzKnWs7C191FImdv77
         jUrQs3/4OdvphBDa6oLkQv7oqZ3RDbz7ZYD7DLwlJQFPKdShqhEw7wvZbhxziAmb5ahm
         b1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/5bOkoAYxocwCe4PICExsoh9c09djmOMjitzjFQXjJmnH9CzyCTTBsLnHNbgKCK6FTDJWPv1ORbk@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjNbGS526f7XN4jw0TKtnTU3vC0710mNaK6anSAizyueOeOsm
	uJ4rKmnFizBLhQA4eKo8CTqQauP2+WyhqE19c7DOZpRziPUocZonTzw9pbi/0Gw=
X-Gm-Gg: ASbGncuDv+l68qEB+pvpF6a+8Qz7lTumNiyUKut3oBALvuQIzo8q+6HTm9FCKhOFqkD
	4JQup2YjEUwl53vFXtsSRQiZ+bUGsU+grDg0tKKbVfCHio8Umz3rkdjsMlthEI2XPGsVDoDZUW1
	Jc0f5LnLz/usJX6OiTGvUylgK0u8NN9lNniZrAz8n373Aet2Kr1LHwfCsd97CqGbNB0xDBzKOor
	dJAT14H31j4+h1zwDl/nKNf3KikxeeDn0nRVJ8RtSSkpYUxhsrGENiCIjQ=
X-Google-Smtp-Source: AGHT+IE4WOueDadHkE/pTRlVlFsVpAiJG9FV/RBFhyadWkGkb4TxZaWQPSECPYbRg96If6idldoCOw==
X-Received: by 2002:a05:6a00:9a3:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-72d22033ef6mr42478714b3a.24.1736920131167;
        Tue, 14 Jan 2025 21:48:51 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72d8bda6e9asm691573b3a.51.2025.01.14.21.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:50 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:47:59 +0900
Subject: [PATCH v5 2/6] binfmt_elf: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-2-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
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

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
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

