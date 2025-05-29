Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB257427
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557207; cv=none; b=juz1B3yaLZ1c7um+ATSH/vIfmVBM7OvJxkaM4RCXeTRnn9TGfJfuNHd8mVpFJaG5UcqSVv1KXqeyOAjhCTTZ/XZTmvs3bBbjJjCp7Kw3/+CEh76o9d7NJuVckpOb/2y8cd3VkGJpB96EfKPNQQEipt7pLAbyZY/knBad1b0VRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557207; c=relaxed/simple;
	bh=N1v0QBW6sWv8xJLTlXamHU232j36EJj1wLeqdROIkTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddapNrfiDud4/Lt1abnTFZKBgJ12cDx8PwhR/yhsi4qTZvZzabw0aLjk3tbVZK8Ab+4Os+FZKWcY4Knk4+okFAFvlf8CaLvTPIauMXj7FF02/xK5L3Uc8MNvBI0phfwDCogz7LgAo/8VmtVOMQcDNiRRXtD0tJflKq7d0EhmmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2r34V9F; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2r34V9F"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e4fe0c08so1004874a12.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557204; x=1749162004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kksiwJTfpDAL7uAGNPhMF+vj8FOLnKEunyqXmWg1154=;
        b=c2r34V9FdwhPiZWiqfUI07z2Sq9IdIn0x1Ks31T5SlxF2+/00S6+pzeZ7RzpGK3Nul
         Lk1W5eBC0u+y89f+qgbPu/et20rHSAtFXgQMdlxmYfI35EJWEdxnEYeBMnBP/iEEWvpV
         78e4uU3+UzSKNPfUKDH0XertmsZlNCVQVdOLacgRwIWGqaQww5lDPwMnOUZDujfSI1yq
         FbCWmoFqN2SeMZYhcURVigVypbZ746C+is23gFpgUlKiK4hRzfRnzWCpAhCVV77vPk3q
         uDxYevoDzUcrHmgwnj7EIeBXa7kVOpoB3sb9BGYTJDQgvl/GTgyqJVw6oL2YsSj0t6Ug
         4aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557204; x=1749162004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kksiwJTfpDAL7uAGNPhMF+vj8FOLnKEunyqXmWg1154=;
        b=VGPEKrJI11Wm0uNQazr0S2oiSJi0rnsj/Pz+9QSu90TtM6F4ko1IOx8N/BLraBUNwV
         g+81JYtL57lSX6dzywrA8NP3SZqyUznwMd2Y1Ineyulp6XcgiQ/i3Gpchrm7omSgP5NP
         WZKdv06fS2FKwHkfNGuV6is44ADYkbafWH/w1Z23xA2LF2B8uLWKBVwTEeAmxx8aUooK
         8222rGx1r1jPdMdInk50obOhmFu1uA9Sh7HC/WOg8m/b8Icwjc4B/DLjdIV9Nj7EvsGw
         rylZ5m5yQJlb6fRYX5t6gbt7n+5jM4mPKBIQdH5NDlZWyB+E1utDKY/NvI9Nokoo7xd7
         pfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX56s6CWcvBqOZzeBJkcQ6sgiQDqLL0VZKoWDNwi+JAQ7Uua4TJg7XfWNxMTmLNDNYBLOTEgf0kaixN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Jb0GItXC+blWm7fbu6kk8q5veSty/AbaaCB3ptiyD5KJeObX
	u0s48q9jkjEEY46CB7d2VBqGNb1XvSTYq9KNAk9EzDQOgN4ZlRn3QpUehO4tc37Nbe0UTlYlCsq
	pfxuPpQ==
X-Google-Smtp-Source: AGHT+IHKKaHBRgZknqdVQGWWJiAz+zFT83aijCtSw3EwCIuFxlNev961CCgZ20g1aw/1KKs9yzGP7rIiVy0=
X-Received: from pjbcz13.prod.google.com ([2002:a17:90a:d44d:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:30e:6a9d:d787
 with SMTP id 98e67ed59e1d1-31241532ec2mr2010769a91.11.1748557204407; Thu, 29
 May 2025 15:20:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:27 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-15-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 14/16] x86/sev: Use X86_PROPERTY_SEV_C_BIT to
 get the AMD SEV C-bit location
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use X86_PROPERTY_SEV_C_BIT instead of open coding equivalent functionality,
and delete the overly-verbose CPUID_FN_ENCRYPT_MEM_CAPAB macro.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/amd_sev.c | 10 +---------
 lib/x86/amd_sev.h |  6 ------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/lib/x86/amd_sev.c b/lib/x86/amd_sev.c
index 4e89c84c..416e4423 100644
--- a/lib/x86/amd_sev.c
+++ b/lib/x86/amd_sev.c
@@ -33,19 +33,11 @@ bool amd_sev_enabled(void)
 
 efi_status_t setup_amd_sev(void)
 {
-	struct cpuid cpuid_out;
-
 	if (!amd_sev_enabled()) {
 		return EFI_UNSUPPORTED;
 	}
 
-	/*
-	 * Extract C-Bit position from ebx[5:0]
-	 * AMD64 Architecture Programmer's Manual Volume 3
-	 *   - Section " Function 8000_001Fh - Encrypted Memory Capabilities"
-	 */
-	cpuid_out = cpuid(CPUID_FN_ENCRYPT_MEM_CAPAB);
-	amd_sev_c_bit_pos = (unsigned short)(cpuid_out.b & 0x3f);
+	amd_sev_c_bit_pos = this_cpu_property(X86_PROPERTY_SEV_C_BIT);
 
 	return EFI_SUCCESS;
 }
diff --git a/lib/x86/amd_sev.h b/lib/x86/amd_sev.h
index defcda75..daa33a05 100644
--- a/lib/x86/amd_sev.h
+++ b/lib/x86/amd_sev.h
@@ -19,12 +19,6 @@
 #include "asm/page.h"
 #include "efi.h"
 
-/*
- * AMD Programmer's Manual Volume 3
- *   - Section "Function 8000_001Fh - Encrypted Memory Capabilities"
- */
-#define CPUID_FN_ENCRYPT_MEM_CAPAB    0x8000001f
-
 /*
  * AMD Programmer's Manual Volume 2
  *   - Section "SEV_STATUS MSR"
-- 
2.49.0.1204.g71687c7c1d-goog

