Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6F1C5F10
	for <linux-s390@vger.kernel.org>; Sat,  4 Jan 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001544; cv=none; b=MJcpynQNUuvHjtnpbZQHemY/jALChBJpW5UqOJVYhScKoP5bpbz+4e+iL8Xzgl/SgfjqvRY8e6zr0ckWXHqqEFMLbJqunG+7cQR10+zdVZlSTaJWBEXuYcUL+Jd/82y6XIdS5HZPerSl46YUyx0t4bWZ4k7GbZC19bLng1jttjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001544; c=relaxed/simple;
	bh=n4yUt/8CTfVsdNp2Y/HwcFzJG4NA/osFdZPQ2b8qMZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQsHzwrtKhsdrvRLP7+/X/BVjzdAatFTh46XbsjMnSevJyeJvAYP25K92WvOlokXI/L3zQKbjuV//yWEgmY5EwR7Uw9ZxqG+h5MOIjemH4caPvnDh5tUPxBG7yHjjG/xFgNLkP33fto92R3FQUS/BZ0HABFgK0pHi0PiNQubxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=vmT3w0L0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="vmT3w0L0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166651f752so214486705ad.3
        for <linux-s390@vger.kernel.org>; Sat, 04 Jan 2025 06:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001542; x=1736606342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffgGfa1tRdbMu1hKTw9Yyv/ZhjBJNeWsWiWpVjLRBnw=;
        b=vmT3w0L0b/G/aGrEu4xHCDL3ZPfvEuzSd5PypOgAVXO/JFqHz0TKuLofE4tB27HhpI
         97ronqBXzNKs4KfzEHEN1rpayJQqK1cBfJMKUTBF51mJCjLm92ld5WhVj/gm5c1Dzva5
         Ik/WufXQ9qzeHtw5dqQomCruzMftsxX96ukgmXpYNvIP/e/EPnswwkuU03W3nJg8T4Cw
         ObukW+rhX7l0EeT6khxSnyLC2iLh66i7DgMrl8LYzzzTxBnF/MRwGhZNjy180eW0xJbh
         HInEY0fyDVGmRPuSVQve3ToWz25R60EMY1FLWobKYKbbHj3pA2UaRY7NCXGKs4QewwRS
         qBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001542; x=1736606342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffgGfa1tRdbMu1hKTw9Yyv/ZhjBJNeWsWiWpVjLRBnw=;
        b=KZoEe3V+UnYW8ZhvqoBVj9yth12TzX4u2RaWOCY4tb+UW1TCRv4c1A8RKNKnKPwCFS
         ywZ/MBA+mXipH8+y4Ir3lRNpJQuhtNwEGDTyyjaLcvVFgCeNtrCmv6BIGXE6lmWFitcv
         1/uf3E7ndokEoyxgFW1/czuFB8wCLRjHHal9274YyftUFY4aQFknAJoQf9eY3MTKNos0
         +JmF/CiUbSnR4Cvx7YDB8u05bW7pqMp4PGOL7ay64aNQj9r4s3LfAWE/attESAjTBxOB
         Jx3ubb3Wzoz0pc/WU+VUXoCz4wwxrjM+5SMqa+Hxlx6PLXlDFJUJN5vF9fh9P9CO1POu
         iatQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4GycvZ9HOewMTxvyXLEE1/J+dLB3HJzGcmZkaNf7C0+sWEmdVpX/gwmHlhfIIFqZxMc7zq1lFWwqJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcYgMING7YJiitpQnefRjEg/bCHsiF/BAp1+z1IdBkXEbzXyL
	0ITrUI9M9jTwYmZAdWNFMVng6XMOlqLNjg5SLnBuIWrrVD1GvfjM6BCxgd4dN5g=
X-Gm-Gg: ASbGncsv2YsHFlKI9aNOS3mA1qYh+hH4ye0+P3iu0io5btHumHwOEp2Ambf6m2G3kTr
	q3ab6ZKZj1C2KXB9xghE9QoBb3L7CnP5ynBkDqdx3rKVNPK+fkBo3l76wbM8UOnHLmvJyIKxBaS
	qsg1gUF0IDAGhdolc3rbFNk0Z5XItLhOlHnTwaezxv/jWdisXNXd8L0OwGcXkwy3pStc0EdY5Ni
	SghHTkDqjUwTOtf7/NxuRrCkFsXbaDvBP3RuT3LcYLKTAyfki6AqNZhQIdFVsE=
X-Google-Smtp-Source: AGHT+IFOWxSlU7LboQeYrGu1ZapBf19hzzItaS6bjgdVpBMRFBzVa4lgIENsB6ZfRDlcb/evlyTHrw==
X-Received: by 2002:a05:6a20:2d1f:b0:1e1:b1e4:e750 with SMTP id adf61e73a8af0-1e5e04717a2mr77843013637.18.1736001542441;
        Sat, 04 Jan 2025 06:39:02 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8fd7b0sm17288107b3a.139.2025.01.04.06.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:36 +0900
Subject: [PATCH v2 3/5] powwerpc: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-3-77dc2e06db4e@daynix.com>
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

