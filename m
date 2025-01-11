Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E91170A23
	for <linux-s390@vger.kernel.org>; Sat, 11 Jan 2025 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736574561; cv=none; b=YWMv0uowBI1LR0gjK8vi6CcomObqcwzfTljMGOUX4Tw6Akv/Yy772fxarEoguNSzrHbvYLOu7SPzF/7PHxSVgG7hTCwOqKQtjKK6VQ+PHhO2H/WQn2Xcl6lZ1WObN+BS1YsyHvxTX384ewhagFpgS6GCp+Z/bZ3hO6jAiFNFfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736574561; c=relaxed/simple;
	bh=+dyGO7LzstjjCAGXXiQqnw5sSHzhUQEkL0tM4qAP1Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LP+VLv7FBrzm71QOODVpA5ZHlALEZtLRnuilBfFsFAER97aBJ5g9YZMm3nB5C+Zm9i39QQVAtEhc848JOD4BHerC4X8QLzVZI/qQFSh94gmh/VLjPQFsBa8P8b8VAPuvAaiWYJXT6GPneHw9jrAqrcyb6DkkYN1HQ0cB2HmeCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=tXwd+pWj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="tXwd+pWj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2162c0f6a39so67362555ad.0
        for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 21:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574556; x=1737179356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=tXwd+pWjozTqOQcy0akKciH9bt9+bmifQY/TKv9s2vIFlZz0rZv0pN2fabzAYMkVfX
         7JcZxKzfGn9KcvSsT51kRpCiKzkieWLT1IkHpJD2gtK029bcwBOjXlwdX3In4HvIY5eD
         EQox9Met1nRv6AgAuKiNqa94evenJ985F+3BPfSuVcCJJqQKT73yFftthZjK7KNIjpYJ
         PDydYSVJteGcRnVrcgrihjGxRpskxHufsfhqfQB2/4anDj6aEmLwY75Vezc6ovXACeB4
         dxVxKo9o1mIo2uMFNeVsm/iDlNmbF6UeiVMJ2eZqI69GEqqUyeXXxKZ5U277ccVs2IJW
         oOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736574556; x=1737179356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=O/EhjeUbOvmHgXmSFAm1T7i78rCLgY+OcD++zTdAM6bTQObsIE/Bo352camAi6bX6f
         BOkFrABfddbZzKHtcOg8rzOxvscVaXq1mEw5UR6a4zMapr0knD2s3ixeVIhYjTN5t0RM
         Ltk+lm3313CFNQ85SGhgy7Fi+5l1mwWpmqc/x+XXUwNSZ5oMoLzgaH4gljohyI0GT1Qb
         zsA4eSPoW4jkHbaEF752/fr3Pzy42zu54ClUohFdp0A++CY/urMHQpXDWdlDK9QkinFc
         6Mv9ot0/g8h/sJaxAK/NtT85Ql9tuEuYUQraQaOCYd97vcLuKAAsv46KbVNCA6BjGmSE
         vfUw==
X-Forwarded-Encrypted: i=1; AJvYcCXxXbnMxpw/9PhB4x25AKIjuUPzgDYjI9nIU3td+0TPdgj6MYn2uLCUCms42nvHeInFt8o9Drvjh0Ur@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFff9nZxtf1NtMZWubAhj8tgie0BRX0yJtUSMijENNWEqUFNt
	rm4lI259ND7vj0GpieFzul5+DAmNxP/9Yf4qUsAJenhr54Qf5e+gTR1yaGFzxMc=
X-Gm-Gg: ASbGnct+DhkkfDhzandshlfJ3IBYk6DiMfbQtT5GZDiwWrFOGXc8A7gqVBvEft/GMLZ
	8+hg1IX1O1LWOWNPHcKxHLoXqcQj1dBOSBwR5NTCf+JQpaQeYkswxS/pocYDj0vEnVkuaV7Dvwn
	drdoxZ6UwOH9F04keOvu31eDKgMZ0E+n18xMOiJQztQyQD49oZ2JksupS1Kthp1xN0PvUUR45O3
	AmbXOUZl4R1cuoysorjowIGicSYOWIUIH7WvE9o0ZudFOhgq0/5U3lkDmw=
X-Google-Smtp-Source: AGHT+IGYDl29OCGY4z1owZDP0XWbhTx09xSMaaJapB97QNqOQhHfEZ2TmztXqViOu57Hf/bAEePhOw==
X-Received: by 2002:a05:6a20:841d:b0:1d8:d5c0:ad74 with SMTP id adf61e73a8af0-1e89c89888cmr15576349637.1.1736574556053;
        Fri, 10 Jan 2025 21:49:16 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31de806694sm3683573a12.69.2025.01.10.21.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 21:49:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 11 Jan 2025 14:48:46 +0900
Subject: [PATCH v4 3/6] powerpc: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>
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

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/powerpc/kernel/fadump.c               | 2 +-
 arch/powerpc/platforms/powernv/opal-core.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4b371c738213..d44349fe8e2b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -751,7 +751,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	 * prstatus.pr_pid = ????
 	 */
 	elf_core_copy_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 			      &prstatus, sizeof(prstatus));
 	return buf;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index c9a9b759cc92..a379ff86c120 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -149,7 +149,7 @@ static Elf64_Word *__init auxv_to_elf64_notes(Elf64_Word *buf,
 	/* end of vector */
 	bufp[idx++] = cpu_to_be64(AT_NULL);
 
-	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
+	buf = append_elf64_note(buf, NN_AUXV, NT_AUXV,
 				oc_conf->auxv_buf, AUXV_DESC_SZ);
 	return buf;
 }
@@ -252,7 +252,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 	 * crashing CPU's prstatus.
 	 */
 	first_cpu_note = buf;
-	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+	buf = append_elf64_note(buf, NN_PRSTATUS, NT_PRSTATUS,
 				&prstatus, sizeof(prstatus));
 
 	for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_per_thread) {
@@ -279,7 +279,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 		fill_prstatus(&prstatus, thread_pir, &regs);
 
 		if (thread_pir != oc_conf->crashing_cpu) {
-			buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
+			buf = append_elf64_note(buf, NN_PRSTATUS,
 						NT_PRSTATUS, &prstatus,
 						sizeof(prstatus));
 		} else {
@@ -287,7 +287,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
 			 * Add crashing CPU as the first NT_PRSTATUS note for
 			 * GDB to process the core file appropriately.
 			 */
-			append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
+			append_elf64_note(first_cpu_note, NN_PRSTATUS,
 					  NT_PRSTATUS, &prstatus,
 					  sizeof(prstatus));
 		}

-- 
2.47.1

