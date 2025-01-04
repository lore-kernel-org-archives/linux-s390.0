Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DC1C9B62
	for <linux-s390@vger.kernel.org>; Sat,  4 Jan 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001551; cv=none; b=S+hkHAunEEA6gh1oeQgsoeQ0tnsIt5maFhBv1USEcqmdyUiLuZ7UfY6Qa2On3QEr81rgEAJ+GoP/duuC6k+5+J8re2EQF90y9ElvlMsj2hKlBgJWT5K7vGJ2082gSgfX3PCTtnujRBLvnFuOgfHA1yQxgbLpOgVnWE7c4dVOR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001551; c=relaxed/simple;
	bh=wCQpl7cAn/vCUbH0Vn+YujxXIXBJJFXyKJRaUtyuXrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2FNZzBGjyd/LbMjJUay92G/zKADJ655k80svlI+hvYLpHmdhaxvIAu9rUN0VGplxK2XjHgQUS0WLCyPrG8K+Rj1p2JhWosxBavD6WLtsQ/GFczCA4Ve5TXKqPWUsLm/r8Ghp2xK1Cf0JIkAJYdIVElnM3fROH9PLLbZCGLvLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Pv3nLWhB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Pv3nLWhB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165448243fso219670785ad.1
        for <linux-s390@vger.kernel.org>; Sat, 04 Jan 2025 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001549; x=1736606349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYIrxPsAVLm9525H8KmJlUUcKlEHI39WEeyICf7u0AY=;
        b=Pv3nLWhBe3mqTr/LfUcL72rzoWqsQ4Qs9vRkKkQ1qRIqLUa3KU75VqwJYjQ62jt9sH
         tA2TSAciVDlbzbss/JU2LbeODM1Wb/itAUzqKb2xZEN/4EhbdFQ1wpof2tDLWTnl5oHI
         o9rzZbQCmv+LVyuf1vFAdNfmm932DIRh42ypGMWCnb2f4DmHiYeBRJLfUBiGXLt66D6F
         sxmOr7GQvqrKaxkR7W20wqMDPODyPpowbWHpYngzoINqpmvHi1nwBw5M+TQB+nVDJF0U
         NtRIE2nY4pIZkr3LZLdA8AgK1eOk2uWhFWPfJypt/GyU6Cdsg9NFsEmAZIrYDoQO3lgu
         9aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001549; x=1736606349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYIrxPsAVLm9525H8KmJlUUcKlEHI39WEeyICf7u0AY=;
        b=JR/u18EIZlVZbH6ZkWyHE6Z/OD0Nd0bf1bjR9/PuNpggxIV9hNVB6bjOeWjfyA8JV+
         KpEnKBe2GQ2TwI+yi1FLYTw73rQun1YZjrGk6MIHyhoFbg6M6p3V1BcViWrpcyYxKnBx
         pRJvkOnsbSjOzvv2Lyd4jXBH+WatQ5V9PUQPy0y9TBuQk4UJshPcDnyleos+ZU2tjci4
         ZP96KS0TXmyhELAhj8Lx4nJSPTccXko7RBXgpzLZar0m0EHw0otZo9QK+twZwcSQbGFX
         G75cR9agaZESck5MJ8ST8FIQsR4Z3cNEll0xPFb2OTjdoNYJJ77wS7767Wgz6haZ9iu3
         NmXg==
X-Forwarded-Encrypted: i=1; AJvYcCUADR7kX5gD6fAaPPI7cQOqZri7HML2M00y1WjbAbaGmoeK76HWdjo7Vz866jurQgwWltqlE9qjBenR@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgxQV6broDxCkh36p4LZLqteX0NkfYjwk3n/KlOvfV9zXe5fs
	ydSbuV3crYNm00RC52AV2r3WeDthviTuyzuQCq4MJB5MOru8SA1/eiFr0f27t0I=
X-Gm-Gg: ASbGncsp3kp5vD5VxbzkwQJiUI8ui481/ir9brRV332SpPb2lE5Ly+7gRG44efSrgbp
	7JGAqk0Uo87dNd5f7oFQCsCAgf0Gn5QdNMlWXkxhx4bi2r1pw2I9tggyZMhUgNQ1gl44oFS9axJ
	y/Tq5lZXmcuWIvMZcqVea4fDZj3wb1GDRYI8aNPoveAdcG1IbSEVMVJoyiaTL2HCiGxY5AXa3Pe
	0LH0JXM9bLfV0Slgcp1dNXHf0dtm1ds19XvI3WLI01AkLjtPsthWEdhvmugjsI=
X-Google-Smtp-Source: AGHT+IEy84cJ3h5ytJvCxSHHyFyZN9d/gzxb3RlphGjioGS1LvEPzNOYZA2OsynrQSHDV4AjG+98tg==
X-Received: by 2002:a17:902:db0f:b0:215:4362:bc76 with SMTP id d9443c01a7336-219e6f29827mr814402335ad.54.1736001548953;
        Sat, 04 Jan 2025 06:39:08 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc963103sm262510765ad.52.2025.01.04.06.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:37 +0900
Subject: [PATCH v2 4/5] crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-4-77dc2e06db4e@daynix.com>
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

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 fs/proc/kcore.c             | 12 ++++++------
 include/linux/vmcore_info.h |  2 +-
 kernel/crash_core.c         |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e376f48c4b8b..e5612313b8b4 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -34,8 +34,6 @@
 #include <asm/sections.h>
 #include "internal.h"
 
-#define CORE_STR "CORE"
-
 #ifndef ELF_CORE_EFLAGS
 #define ELF_CORE_EFLAGS	0
 #endif
@@ -119,7 +117,9 @@ static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
 
 	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
 	*notes_len = (4 * sizeof(struct elf_note) +
-		      3 * ALIGN(sizeof(CORE_STR), 4) +
+		      ALIGN(sizeof(NN_PRSTATUS), 4) +
+		      ALIGN(sizeof(NN_PRPSINFO), 4) +
+		      ALIGN(sizeof(NN_TASKSTRUCT), 4) +
 		      VMCOREINFO_NOTE_NAME_BYTES +
 		      ALIGN(sizeof(struct elf_prstatus), 4) +
 		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
@@ -444,11 +444,11 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto out;
 		}
 
-		append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+		append_kcore_note(notes, &i, NN_PRSTATUS, NT_PRSTATUS, &prstatus,
 				  sizeof(prstatus));
-		append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+		append_kcore_note(notes, &i, NN_PRPSINFO, NT_PRPSINFO, &prpsinfo,
 				  sizeof(prpsinfo));
-		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
+		append_kcore_note(notes, &i, NN_TASKSTRUCT, NT_TASKSTRUCT, current,
 				  arch_task_struct_size);
 		/*
 		 * vmcoreinfo_size is mostly constant after init time, but it
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index e1dec1a6a749..1672801fd98c 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -8,7 +8,7 @@
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
-#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
+#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
 
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 078fe5bc5a74..335b8425dd4b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -436,7 +436,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
 	memset(&prstatus, 0, sizeof(prstatus));
 	prstatus.common.pr_pid = current->pid;
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	final_note(buf);
 }

-- 
2.47.1

