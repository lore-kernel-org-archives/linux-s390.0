Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C21F3D2A
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254096; cv=none; b=QqWggzUZjFfuxruGvPrp+vesEj+IN51V0Pw7tKAZU7lLX/+y4LyzeOIomaeQB8Ydhmk4ANVJZAZSmlWG0rVTk40Fpa8HccccNlY4l0Z7mXqO852nagttfsqwk0QmxPK+WheJYB90F9+UhO0X+StT0sVjx4zhd5HMppuI7a/mSgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254096; c=relaxed/simple;
	bh=+dyGO7LzstjjCAGXXiQqnw5sSHzhUQEkL0tM4qAP1Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcYZgIrvct76Ocs/FJUPRTdNj/yFWvKUkZXK+D2GCIHwnKYuUEbudm2ljAzur4qk7JYccNz5bcylE3vu5utwPKU2DqkYygeLZQQ7KVyRElETKZKGP+vczkSOMa+RUZQ0Zxlhc/lkCj4qYRS5qMjfaaz9vqWd3INL3qUdU2fD+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=pN8ShrVQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pN8ShrVQ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so22990184a91.3
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736254092; x=1736858892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=pN8ShrVQC293/PxcptrwQk7u4ff/Zp0mKNFmQlcvl8ZGLxE9G4DSmyNS9V3SfrRQif
         EnxJTQA1EEZ8xQ+MfgvHr0+oryQ8kboG7NJwYftW86UYSz/cDtPjSvgHrxJVFMcRW25Z
         wwvfHgo1XqYUKWR9DzyNqrGoFPzNT3Gb4DqLKGzVgTZlUUl8Apf17eUQcYu62XF5xS4x
         toJ0xc5JDxx0WPl1tQHJxMfkuWNIZaxwfnleRkdW/vX9Cuwc0NjRSJ8cLJMLWMHhqgB/
         cT3gybpXK/K5UvC151DJmlXLbsGEBmniyGZotdATnzN4yRHTg8nS+crZY0Dn0oi/z53l
         OGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254092; x=1736858892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDoGkIZOBZADHox4rebBhOBkiub95NT2vaNCAf0u1/w=;
        b=nBVKW/lJq3j/cwPwmZxy/LAnIKi+6UFcZjkpOunlNVuiuJItrGbKOwIyiEqpaCuLSQ
         2LsGUaM2MujAD7PRa1UmrymziC1UZ9NeEgFZH9bh4+GvNGB6UXPiFXuQI59bg+0y5o6O
         BzJhytGMA1FvVNmahijx7i8gegnTNf56vnp2RRsOdBJtZYPGKk6oG599VKHlZP4j618T
         qBMI5J3QBAbAoM6QsfoVVTLo2t8vl0Wyn0n4QqBd0p1kTuekQvB5mxWZ8dkX1W9QW0Fg
         qtXZW+ThGEx6AdMT8sXKfD4JJGC/Fb1PlaBVQqEVYIorze029mv5F30zbKpWTtu+fIOs
         ARdw==
X-Forwarded-Encrypted: i=1; AJvYcCU28SoYWXM4tp9WxUq8B3wamtpv4YOqURhO75k/7iXCunDR4NgDyYme/HGu4w6GX9wueRZ44Re6KV3d@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuv8ch78jzlviO1LshuQGv7wZvtvtq/ObL30LftQihPfCSstRV
	PX9I77E1iJco9I6XPVsucMRADgxUnPjymUQGBlps/QTX6mXPRlah3MrIbmHs0Rg=
X-Gm-Gg: ASbGnctPImwNoPadCnPzv3fh3nAVqSR7o29ge0b0Vhz5mWiYxMaUq+5rkhW7xrAVT6E
	Ur+TeeZEI+MS1aagJVTFuQXoBhy0vJgWDWJDDm/cfghO++sZSTEdhFjhWqaMQhKb9AHKLVNK6B8
	bo8+GcGGimt2R5fwtCqs3PE0CtkJk1X2wXWnKQNxNqzl5wqFBCVxDYRJrnzoY7ubwkR/Rj4MfYh
	Io5ZHnwGxJ8pxrvZ2fdJENGjmExdMAqTw2OKtqx11+UEv01u3rZ9o2QRJ8=
X-Google-Smtp-Source: AGHT+IEVKBP005EvKmW5Tl+CNM3WgQ4gF7V3wiTUcNw/Hf4GbFW1YRz6KtZiTE3d5Nc2ByQmLcCTzA==
X-Received: by 2002:a05:6a00:240d:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-72abde04f6fmr85408908b3a.12.1736254092437;
        Tue, 07 Jan 2025 04:48:12 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad90c133sm34268685b3a.183.2025.01.07.04.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:48:12 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 07 Jan 2025 21:45:54 +0900
Subject: [PATCH v3 3/6] powwerpc: Use note name macros
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-elf-v3-3-99cb505b1ab2@daynix.com>
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

