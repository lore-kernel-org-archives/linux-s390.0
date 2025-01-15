Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DB22FDEF
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920139; cv=none; b=sWDEZqOjN1wsNOLNg3ndWwIjF1Y41695AuK2A+oab4KfxxCZTAddN2pJuraOfwUqGG4yH+G8aW73nVsSkkrghGgpAfTw/sz0XDS+tgR63rZkmhvXnp0rVXns6CUeXWiQkD8Y+HHXXDoIyusn4hKlqpmmv9dNoF8ae2zyu5v8eBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920139; c=relaxed/simple;
	bh=mz6/8u0zKO7wXg63oIjhA+TZ7CRE2siVZkZdSTOwyCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnVxPpwuUuTeKUrP/TJBLYD1g8lRrutiwZNu9kP5cPlSl05LgYzNdTIePKbTN1DmjPxAEKTIjWHC6yWViv24IaV4wENNwCZnBrIVIILqBAcde0B83T8zlGUTYVWL2KQc7dSxR+RePrLsh4hwHjfULPZKwvbNU+deay6/GTS02EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UxLprjXm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UxLprjXm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so142368805ad.3
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 21:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736920137; x=1737524937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4SRmWOkQdk58NJ10wmqwv5TrRHdqCAxdQV3fT7eobo=;
        b=UxLprjXmoGzUX6iqd9kD3is/F5zV2iSgLuVkkuEl8k+tWP5VF+kBRA1T82DpBV8t7f
         MYiukD6akMZtGzPIU0iZbMgMVmEkOvuslNaO+zlvUhBwk2UWc0PijL41Sf8JPyw0YtMU
         FAJ3QabIcohf+RnyzVE1L80FbpoW8vTkpD09cez9/RSlmOM9KVYMHXYbvtIGdsXwpX26
         cyO+9DQ+loBS3D4afNAJUFKVvL4kRWxx85dgFmoMs0mLTYuj6rkBa8U8N31d71GaBUFz
         UluXGjaOmZzcJqu4wNex3GWR+YdnPlSSu73PU70vxPZqi/X/B1d87z9U5epwOPn6Hi/r
         ogZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920137; x=1737524937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4SRmWOkQdk58NJ10wmqwv5TrRHdqCAxdQV3fT7eobo=;
        b=JU5EopLqnHA+6NRTkcTex+cqQUK/dJq0KCWJfda53n4lkriBBXaaCwFOrxdsZsibts
         jQSrM7Dm8JCRa2M2vL4gb/qpBF2G4yPSqyrBmFJvVDXqqJCawxPTizahFVWIJF127xE9
         fgn13UU4lcDMvma6S8NWo3wVquAOf6TQMsi42d2HojDI+OdYilL9iFjJecUcuoEnlTiS
         hrSIaZz1hgaENGOSWtR/1XPJqTl5C3hOsGz7Cdhs1+DqXIesgkv1vG4A7KE/e9DVaNOY
         lQo4F+1NlzvveK85V0LI/ZJusYKm/YzVG7cbM067AmuQk6NM+F+10drOXrntT3+qdHzd
         TRWA==
X-Forwarded-Encrypted: i=1; AJvYcCWuDujG179AWwiSn5Tu+5VPHQEA+cPURxLqlzew5Cz5rw7mr9U+jaVelzKrjrfyefi+VHvVhgPZtA1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0cXLDkSO1aaAjzgUQN8NG+JokPKE8k37beMZgOYCmVdtO5lM
	yXkHKWky3EQULQNZR7IvZNV8O2npNK5HYYj4jHX76seVzLs5+FoBrthw0JOzP+0=
X-Gm-Gg: ASbGncseGlbhLak+Bf3J98H7aivu82R8Dp3brUdfwWuViHoWNBh7NfY17CYULBR6Vgf
	sithSBHuHgH/0+GT98G35Oo/jRwfodL3cdClYHcMlmHVOS6BRsDmlM2Vp6NjEdpIjbhiuaGwq7l
	YIiisyMec8QpfYlFl9Pv7qJmLVemDStHAV9No/mYEpEraz51stBpRpk28l0eSY28BpUg8V5zlHU
	VSXSFjEyOyYX0YOEyYTdEXnSNG+onILHirCDc1Ga1CDu/KD+tGAlZn/PY0=
X-Google-Smtp-Source: AGHT+IELo9CjdL+yrG4BCg5jbLzJxkebkveFvc3aZpHyweclYXLk3OeSuIMKxGoccunx18mtoTdJlQ==
X-Received: by 2002:a17:902:f644:b0:216:48f4:4f3d with SMTP id d9443c01a7336-21a83f56bdfmr398040455ad.13.1736920137397;
        Tue, 14 Jan 2025 21:48:57 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f111b82sm75035235ad.35.2025.01.14.21.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 21:48:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 14:48:00 +0900
Subject: [PATCH v5 3/6] powerpc: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-elf-v5-3-0f9e55bbb2fc@daynix.com>
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

