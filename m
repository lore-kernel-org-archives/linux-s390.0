Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF71C5F14
	for <linux-s390@vger.kernel.org>; Sat,  4 Jan 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736001557; cv=none; b=W/aUL9l8Fe9XsD7TNxRwwa1nng+IoKl/aBLCGnqdNLh7h6MIhUfg6lKf1571t00InP0iC0lV7lhs5wHDwhfZDc/cGOuwvE9GrNEX/5y4CqZwNb4gsqSP7K2xGmCuT4Iz7Q3iAEpdBzu/ztK/GSpvHT57fyOYGTquaAgBTxMFOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736001557; c=relaxed/simple;
	bh=S/8Mk6L29yj28C/cV7bfRVgvsICVDUajAazzt112PkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfyUH9cpLH64iz6ebgsXGWf9YIcGJ7SbK2q0LkrLmYe/TaZdFj+Zh7VZlTHzJIaJQa7cg8xjMoDzYWqlxhbiBcjHofd3PHu6D3dJIzpaHZK7h8mQ0gtcbo1fV8NEtqVtWutcd0ueLyJEGMafyCT2hZAtlSuC7hnw1yF53uxAV9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=VxEghG7j; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="VxEghG7j"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so18405456a91.0
        for <linux-s390@vger.kernel.org>; Sat, 04 Jan 2025 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736001555; x=1736606355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lItEO8+vDf3ne2QEFaUdlfKMhS1868rwBEwl+2/8wc8=;
        b=VxEghG7jW+eoqNvToKT0BBQtFMH7qlpJdehP2LIV/h8Gb1bqpkexge8cVDzfkC+EXb
         3vQg9beIrG309B/tXjZiCgczChOX1/NCyjASujmi8goCitQiKWbY0RRaHgVcBqyJboFv
         Hkna+GkEX/XY3OG7GEDeelcRgqScbSClG+qWNvFTCECestv/GMFgSczQcT5yrCeZE4bT
         Fg3WR+LJ6Nb8s2WWQ+bylOWcnAbj9p9uk+YDAtrmfWnOfLrKCeJ/f7ei2AXM4z6TID0z
         hrAUC1/kwSN/n6lhy3z6njpEyqLCNOpjB8imADi8fYv3unWuwjJH8uvRHNH5C+PbUM3N
         bYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736001555; x=1736606355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lItEO8+vDf3ne2QEFaUdlfKMhS1868rwBEwl+2/8wc8=;
        b=fuZ8Vt4sAIt8Dh1D8tvdkG71R9Kzf4e1noYjJkoa2rPrrdeMqEkJlr9mwfGi+miY58
         pi26pJY+2AN8kgKmuk/VbyBBVlwv1Se9HbMk0rxwdm7MKs1avMbHUIdpcl3g1nT9jTfo
         //1UbJGfPlq2ec2LbWtv0bdU0hJ4IoxshkD2c1gz2xdhjY766UGPf6WkPG+X/T5XYvbV
         GJptpcaqOyltDxIGkNPpQKLj+R4d/VD0orI4Hq09gKxitHz15GRg+i6JPdYNjOdmrVYD
         SBI5WSwT7bO2d6zl5ITLKMnewRuhK3LdQ2k/7ZmdmEb0rpCrqJppkOHfx8TXBjRgecnC
         x3YA==
X-Forwarded-Encrypted: i=1; AJvYcCUyv8fCqWi0JfHXf2Cx5Zc6laRGjnj2GsiVof0C3Cb5UJQcZNpMAl5UI3zO5taP0UGpbzTWs/vMAly0@vger.kernel.org
X-Gm-Message-State: AOJu0YyImZKDh2x5DzxrzJ+xnbcxrpk3O21fR7x/o7Xe1elg006wQqNp
	WePkgZgvsWBqd1159Iruyb1BhEOKI2dggWdOD52wcwkrFxxQxa1b2IVXzBobR98=
X-Gm-Gg: ASbGncuMv4NoimputTwhfpD2J9e8RD3qMeO1RyWO8DMbaVf77lSomYAJfky7OJu4vRa
	KsVPg89edbaql39oI/1Z/72Ixn3mK0Yg9tSjnCEE1/+rN6M0+bohcmQXp4QXr8cnMuyZIpOMaqu
	1Q21V3Z1U9nofWo7wwKSKNzmjS4y2KxRG9+v5tTuJ6rIMgNR4sciOxnKI6ylwCMSGWRJ3M9Wdt6
	hW2h+1BvVejwtgd5642XEfunaIWdR5vuSUGtwYycCzalO5lwDXjp2jEX6dwzo4=
X-Google-Smtp-Source: AGHT+IE6l143okZ4K2hLdktIIklrvNPqE32MSRd/SLQaBZqLFpJB0ZcbHN/hLV+Lk0+UAUXZGQQd2Q==
X-Received: by 2002:a05:6a00:4098:b0:725:c8ea:b30a with SMTP id d2e1a72fcca58-72abde2ab0emr75955118b3a.14.1736001555483;
        Sat, 04 Jan 2025 06:39:15 -0800 (PST)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8f90b9sm28017661b3a.131.2025.01.04.06.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 06:39:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 23:38:38 +0900
Subject: [PATCH v2 5/5] crash: Remove KEXEC_CORE_NOTE_NAME
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
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

Now KEXEC_CORE_NOTE_NAME is only used at one place and it does not seem
to provide any value anymore. Replace the remaining usage with the
literal and remove the macro.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/s390/kernel/crash_dump.c | 2 +-
 include/linux/kexec.h         | 2 --
 include/linux/vmcore_info.h   | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..4a9817489e35 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -253,7 +253,7 @@ static const char *nt_name(Elf64_Word type)
 	const char *name = "LINUX";
 
 	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
-		name = KEXEC_CORE_NOTE_NAME;
+		name = "CORE";
 	return name;
 }
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3..c840431eadda 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
 #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
 #endif
 
-#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
-
 /*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 1672801fd98c..37e003ae5262 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -6,7 +6,6 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
-#define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)

-- 
2.47.1

