Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592623099C
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920146; cv=none; b=UPzexUhwfCoWUytpZkRl711H5ss5WsXiLQEyazj9cQcUi5dYYjiPSmIJe6o4mxNNMOooEZrfMe6Ngytd+ZADWcsWyZ4kj38nPaaD3zz9aGEKWIUVxkZHnMVM6GJnXseERy+CmG1IgiOSpwz0Gsiv/4U9WtgWuAMhHi9lqsk6ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920146; c=relaxed/simple;
	bh=Leybf68felJQDMCcU0PIjLxf2dyR5XwKl+2uZ4yvwsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tc3GDE/pzZPwK8iq8LM2rduiYZuwc9uNhqntQUV1TSnm2OQN76087psHrEDZER7HFZHKTuM6LrRSAArT9OhNMIo2rkCmWLKpNegsFVlaPlBAb36+ADEL3oZ8k+ycuKM+wuEFgrJwMlSnPBRrPF8w5lJSBwqDADVLdXCJ1/LYxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=WISw5qgX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="WISw5qgX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so7914631a91.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920144; x=1737524944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7R1Z0m4AmDiEDGrwLKGXNpW3g69MQHysWRaDTZFxP4=;
        b=WISw5qgXspnR1XVd1mKZpS46lVwkSx7Stcp71Zr622f8B36Z3md187O77VUAEpaH3e
         Ku7sn8N34vhS2c09UEIqgNtgNy70LYQiV1jTfPog2RDFclpN0YpYrssGhsKL7kNSchmh
         l7mF7RV92cXi9cnMyk+rjHhoiKqUlDDBVArq7z1tlBEXfOafDzEx0eSFsFqW3inl4dRx
         CSObDygU4NXwhYmMfsQKImLqWCyocBiKFjZ0vwUoSj4QxqhL9UOITillNavAE2aoICHP
         Umhbm3x/6ns3U9UqdkRDR9tYgX5doaRuZLWyqR1f3vDHQszBEFWLW4kY+8cfJTci69+1
         hjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920144; x=1737524944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7R1Z0m4AmDiEDGrwLKGXNpW3g69MQHysWRaDTZFxP4=;
        b=IT16igpQbrEXSihesQyeAF1i0ZjPuANgQP3j5AdP3r8JVtayuALkUJiYaZ6WQapxvH
         mvKn2px8w4ZA9PSexFqWmj9z6mShCGVXhLYOMpab42Bgb4M+jD4GISDlNBPTdGncpfHI
         jKHOXBAp/bLKt7mKai1eE+LVX0bwT7fsSow2SlHuhJqBoPrradFCBwGvfZmuFwkRadg5
         ZU83BKgKdi8dqDTIStTH5xJBVh+wggEpS9CWEnql9URE633QfzCmuPf9MMbACT+RkSEc
         DxD1IYSM5+OgWtQKB+0nKKRHBfGa+FkbHJHGlIFaBbFqPDxKp+LxY0ssXnQR31GJ7cEu
         Tnrw==
X-Forwarded-Encrypted: i=1; AJvYcCUJauxbeVYNSgsZY/Q02N2Ez5qzzfyPdeq/gKIBh5tgqGpyu9RyS8l9oDT2me6N8vy+J0hMv3dST8gl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pB1D+j26ZOHrepFimSwRavs2fFPwB+6vpxZkXAn9ds5V90Bo
	rlnbh1bU1VRW+MPivKeLKAT19wu6FPmtNbUKAh0CmuFHhHdISLack1ydFBEXYYQ=
X-Gm-Gg: ASbGnctsMgz4xNJXHb8uS0atAslp/hALtsJg/MB96LX++s+YhKq9KtcghTOBjARYHDB
	nm/bHrZcoGiuvcphviPiq/7XH/42rvUzwVwSxFBS25/P70jmgswqf94tOj9WyxiL+bBiZ5HRdqR
	xJmqI+NGEcMb15L9RI8cKQavTdeTIOFDJ4cVuCr3nkXMHer3X1zuvTDPI4wPuYh+mr2gbd71Bu9
	fZo3x5KbgRqJ+xLiE5AuszujfuaNJpLvkRnuf7zxkoaCRhggxArpQzKfGE=
X-Google-Smtp-Source: AGHT+IF72SLq1My1g7dtb+6XlMl4Y+R7t/efbYmDZTCYwSHPEhtpwytSLWotlhp9pmcuYRJ5nSVCuw==
X-Received: by 2002:a17:90a:dfcc:b0:2ee:ad18:b30d with SMTP id 98e67ed59e1d1-2f548e98f31mr36439035a91.6.1736920144269;
        Tue, 14 Jan 2025 21:49:04 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f7085261dcsm1516002a91.0.2025.01.14.21.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:49:03 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:01 +0900
Subject: [PATCH v5 4/6] crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-4-0f9e55bbb2fc@daynix.com>
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

