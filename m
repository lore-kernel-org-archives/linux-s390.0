Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F97187FFA
	for <linux-s390@vger.kernel.org>; Sat, 11 Jan 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574565; cv=none; b=dC97N+zseeLJTAtNcqsJaoDBK0E7AfVw/8h7tiTAebVvTUEGYzsvOqkcu3HGub3a4ff4/YaUW361nRvct0DPO/IxLtMQIRz2l9FTnkXumgjxM8w9AQfvrmev3xch7xfqUotu8bu8tIIGwOn4E6J1wKftGPhnQCy87Dikex4Q5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574565; c=relaxed/simple;
	bh=N4IhUv6S3uRsh7HsLEUL+nZigf4kpss6dQVVVdHm5r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQbF0jGMnaQBLpRcpk+jxqFS0JgV7r2cj0N5IL9HGgTaoM8dymSWscdXFXoK5w9oM/ER94+L1p2LsPQ/CFH4LlvqfLKDaB/DQ3eEu9zBEL9iHkB1RSrr4+33Mnl9gtI0qkchq/youPzZop7gR20eJYQcJTME5eGn6oZdAVokR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FEgyz9Dt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FEgyz9Dt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2164b1f05caso47690135ad.3
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574563; x=1737179363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=FEgyz9DtODnl0e6HhVqYMvEaT0H0YUBQOSrlwmoJUlYgui/TH6daaCxK0ukBDljaUv
         z8o1YHFTNvOKOrDEHDoJyvUCsGiqtCGJighvZoaXBOTpzxnC+zUTYd2A7H8udk7jOANU
         ITFWZoo1yeTFbQUphNh+zrmLKjZ77SyyNRrYyLHBOp2pFM6ueRDFLecFd8ND44RSvQT3
         8o6ZJNTqymu9q6L/JPkn2qNckQsFzFpJgnUOOhsFpVXibSbQg/VVRiBBS3NykyhcLq2F
         VLLXOc89gpj++SRicjB2A06BVdlCq3WxmXz3SZO8Pza8+vQWe3jE2Kolvf0zVKZrmr1K
         Dbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574563; x=1737179363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=LnWOH2J8GBrWA+HBS32AtveSpavhHP0VaueGxhT+bnpjwIut4y27/NWGV+EKwVk7KO
         L+i0r0FdhLXhc8Tnvkxj3esVhnTw3VMk37/ngyE9+EYURE07dnptrn87vG1Vzzm8jghM
         d30hyaTcSIjwfilv5mv6ToeFbADzjIutQViwoNMNdZhx2xIrMNuMWNuZE59ilF+0QOT3
         MgSiYh8b5HHedqgs16Obo6jG3Y9+eG8ec+4V5Ci1X55WTT/Dx/FO3hVUp+JXGrK5EWvz
         ADlFbCbPU+d6s4jC243JBymoADojvvE7Q+Ev7iUkic33foW1c0sEtY2K+Qiv5swZ1k4I
         kq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd/XSGB/PFGxEmzxtzyrZgiZ0HdI1Tf8jT0IYwk5F9o2p8MtFyGNkPu7+oc+x6uSyI/jYKe5H2YEXe@vger.kernel.org
X-Gm-Message-State: AOJu0YwkM99732TXaUtoVYrJOF02J4gAPqtgSA+ZqG7eIbKLGxIsGMa5
	XdeXWZREL4kh94w3QibBRqGs/TY69/AlwV8WzIW80ONvLuwPJRgrpBoXRTYcH5Y=
X-Gm-Gg: ASbGncvUMM0XHh5QdaJbXDSU2CKQMZHaChKKeCsqCtpWlTJOPi0LRhbqoGHcdcHNDgx
	mKn130QJi04yFNFeW2Zb8QHKMO+zTSRo9wGhaH2DvRdNqMFu1PoKJeoSu+/rQEK7A/WMVdcnMBq
	0Zon01SIavLkHmPvaMdX11rZjLj6HNQGOKgz7PiL7//nGnhDnrZ4L90ZIrZzqgu6CpdDiVKqrUJ
	ohvlsfYUdHmHVma1LJFmTA2N1voquH78Ol9s92wM79KoUM0MxFgsnT/EaI=
X-Google-Smtp-Source: AGHT+IEOaK6BOPAe/MUGiXyl+EyGiYmhbaq4qeXiFxMDU90Px7X9OtnxNRV5Ifu8FHX6K2PPpo86xQ==
X-Received: by 2002:a17:902:d4cf:b0:216:3466:7414 with SMTP id d9443c01a7336-21a83fcaafdmr208931985ad.44.1736574563492;
        Fri, 10 Jan 2025 21:49:23 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f22d0fcsm21166295ad.161.2025.01.10.21.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:47 +0900
Subject: [PATCH v4 4/6] crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-4-b3841fa0dcd9@daynix.com>
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

Use note name macros to match with the userspace's expectation.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Baoquan He <bhe@redhat.com>
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

