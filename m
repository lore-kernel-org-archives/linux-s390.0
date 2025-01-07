Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7931EE7AB
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254103; cv=none; b=AQTYuuFv3hVLAKm7OBjJKLgf2Pk0UjiCB99R9mGiXpuOhn6MvDx/Duec+SM84RrfKSAhCI2UW1jhe1guTAcjGLhIiRQDvSiHUqt4Yw1vZ4YnjXOAIK9bSOIHeTrGvOu3IaJMre3BEbMw3cBaDPklVkLGNdEsKL+ReZbOV4QDujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254103; c=relaxed/simple;
	bh=N4IhUv6S3uRsh7HsLEUL+nZigf4kpss6dQVVVdHm5r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELMRUKL15wuAnVwLorEPSs2EPxu9wZ5oQfpbX0va4VhFNpPlXh7TpdVmD4SmYnn0CIywJ06xchynBX1ikaog6AGEnbLznueF2RTR+zyEwsUxMDzwUNm8IZTvAfJmvBADrqXUEqOD03+NgVgpwSIg0LQGxxHjHpVfEVsLl9U/OYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yT1DaOMY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yT1DaOMY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso18420981a91.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254099; x=1736858899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=yT1DaOMYXYXho1Dgdarxic59MDRNyJWnNROjN5zdAe8oM/j68bk+VphAlYPqNWM1u4
         3P+Nq3mJrlLqiLpL/JO2pM77R2bDMjCjTFiytf8gdXsM93duJDm55oL+B+gcGH7Cd/8I
         Lu0UIeJYD2dPLNOgyE4iCFmNAHKrpaqmDVeK0iMuDx/cRddF5Ugd7PmPz8vNQ1Bw939u
         aAvt+RfuzGksTvFS4u/YIxxN8Le+tAgMORXhVkOlu7D1jcbTWXZsPDJw1tOOCQ3BRRdx
         l5894nUJqc4slOsbeOrHrJedEdXIcUs9L4jvalx6+aAuHNDCIrfB+4kSB5yyZAjw92ti
         3blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254099; x=1736858899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5w0df8A0RGvduNGo/n7gECMAUl7ttjM0kfw51R7kHo=;
        b=AdgUewXlYxvfjmdiBeC4RXZi8PiMN+QsDe+/F7WM2Cfz2oEOSmza8a2ky8Td+UH39s
         0yMzVncXk7RTAQHzaLCpBSYEGKc6lfP3Epm9n1+iz/lt5yclq9ql1xj3cc5tjgFjwN8A
         G6fgTl9X7RWeQLcDtMvFnSG/vcKH99tScX1pehyQ6lHOaACtJfNCMJTXss/QRtdNZugD
         D5MyPTaOlXVd2yvvp7Tos0BKERp0aCaSd6TgT9wOG8td4Bqz9gfAfVijIr9Bi7gwtbgR
         5m8dvdZLvVVgxPbTVfZSpLJMujNZg8i9cklR4MEgs2eJ1g/LCplBQq3qYIsBbMVu5DMK
         aUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo4TtPKneqWKzr12qQ+eJucREivjPDQRhCrL1I38+c542GZmSUKyMFqzfg7esiT+lX5jIIGDbAStHo@vger.kernel.org
X-Gm-Message-State: AOJu0YyyiHbv0sXh4hHob7zUMiNv5AjFYSC8rfhULiZS0A6WwpoPfley
	DOus9kRFRYXQN3FuuTv6h2aXitOZFq5801bAwMpTzhCbq7UwS1wyBeOSLyBrYlk=
X-Gm-Gg: ASbGncv6aMj8SYHK9toaTYYxvxobQ7U6+pii8gYVpjDVKz4qDoYhGn/gtH9zlWNMyW6
	kBfmKKONPDrMP0VNI6pz1MtBLKyoUGGd5kHOgfzGSw9BwvB+aEc34jfOuCy+a8xuWwNKDkGk/rU
	G3fzzcMS3M1sgnsjSAWdZG3L9QrilViQdKJg1DSa/dH2Kpx/rYejsLWrADEy48Va2VxJ0LeCgR6
	U3e7+i77X/n+s8kb4ZRBanRUJK0/x1/iG7MRIUycqXEur/lS/vkXLfw5V4=
X-Google-Smtp-Source: AGHT+IF4unLvSG3ozl/K+xZg50qJ9RhkOXYw+z5VR9QTjd55CxK7F8LQeDMLqnNt5CS4t8mxmL2QoA==
X-Received: by 2002:a17:90b:534b:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f452ec6d35mr81063623a91.23.1736254098937;
        Tue, 07 Jan 2025 04:48:18 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2ee06dd46sm41574100a91.36.2025.01.07.04.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:55 +0900
Subject: [PATCH v3 4/6] crash: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-4-99cb505b1ab2@daynix.com>
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

