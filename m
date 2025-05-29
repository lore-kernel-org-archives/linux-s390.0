Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E5255247
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557201; cv=none; b=lBrBaO38R8giUi+dTuvFBHnRhVjM5CdXoflbIQQS9OF3wr8+nPj6lNf6i66dKqDqhAeOBZ903K4HvYXpD97qWkqE29sLhsdXEpF1WrCAK7IGSCotUcTuKBvZ4/UGhoQ8eaYl8gOLOKpJqdSvul6gwvXwvobTOx/2DfbOIMPcyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557201; c=relaxed/simple;
	bh=JaRtMDrckRIM9GKsG3ny5EBLbnUB42Im79NyGfAJgaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emrn2hU33CFytvZYkHfyY+SOePRUv43aNxy3ita0+MZoIzU/7sYV+pxYXF23PTri1o8TLoKjaNn4ZkaoCTKjcxr/ItMQeAcp5j0SNLhlaPxSIXtVIlCJbK1sofEKxyZzhy+S/xg7zRA+fd1C8Y2jpG7NYym3QwaQLjQDWUlbeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bv8zU7Jo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bv8zU7Jo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2326a6d667eso13350505ad.1
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557200; x=1749162000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F38+KAgpKihumolRGdL78BPKTYJ8ucUVHkNHVQ83xHA=;
        b=Bv8zU7JoQat6ZTqAOKCxskcOmrBq4cxW60dxRv/gwKDmfzUn4E+JwQPLL/lnkSRlmX
         oKlpRH+I/kt/VCOap2lC03bsAYAI8C/EvupnmOYr8hBsuAZz+CSl0hxaFzI0PJGcctF5
         VYkp01f3n2275iQIBZkKMdpu0aCZRYRXHnaO4GiUOmPNsSqctEMv0HYcRPp57s2M/Hbp
         wr8iUhuOwtKuC1MjxAa7kAd5xWdGWsT74TQMAtNxc0nA4yB2CPA5NuZBeqzUPsGYM+mq
         TyIte+a/iSnin/m/v6rWRqOJx77gl7N4+bZnGMJL1cxSST4lJGfI0bbiDgshmDT44U7F
         dQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557200; x=1749162000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F38+KAgpKihumolRGdL78BPKTYJ8ucUVHkNHVQ83xHA=;
        b=AFAZdO3zNebCEB9vMYBv+qr71HTeTWvyR7mszVCTFfE+1/XqcDBEGt79o6DmcbHYbh
         oHETkE3dDrBpjIR9pPFC2cFpwRxxSmZT6s6cyeJ73n0GeMnPGUCIFJe9I/O5xPM2LHo5
         PiHqZRlWPPq1u81XfZ8bDFZNq2IaaNbDTF4kS90rq2wZlJGwnAhDTU4uXie6baHX6YRO
         OodlCrMvl6AxcyKPrB+4To0PEYnkjXjwL0eh+Z7Z2mxNbTtv6sYCKvq2zIIQIQSIbW6g
         mw4K9aeOnO+O8TpDMrOSRmZ0TC/j79Dmls5DrLHRYe2lY6jNmxejpqHJ4ka9xj+dzXeA
         N+xA==
X-Forwarded-Encrypted: i=1; AJvYcCVsCMnRVhKBVxeYHD4Ck1DkcU1NsYhXRnwwNobWnplnRXbaNRYpkNG9f+4TZ4K7ht9GV7b37JGEzn9M@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhiNnryol3KZR6q7GOFzYjqZ4H2x54lVXqc//QzE7f0iGe3ev
	f8/3N5Eilfk0mlHO5OZp+trKENyqiK7WnP32oBWD1F8Q8eJGq78lWNolqZynB8sGP5vvA6oI6ie
	P9Fx3fw==
X-Google-Smtp-Source: AGHT+IFLH7+ndNiW16k0m8bZig1m+3YmdXN8wU8pUnGfkU01dcr6pQf/olLFZd/rzUJORoXz3AV9rcYLfE4=
X-Received: from plblh14.prod.google.com ([2002:a17:903:290e:b0:234:d2a4:ddf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c5:b0:226:38ff:1d6a
 with SMTP id d9443c01a7336-235289c81f8mr15314225ad.7.1748557199757; Thu, 29
 May 2025 15:19:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:24 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-12-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 11/16] x86/sev: Use VC_VECTOR from processor.h
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use VC_VECTOR (defined in processor.h along with all other known vectors)
and drop the one-off SEV_ES_VC_HANDLER_VECTOR macro.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/amd_sev.c | 4 ++--
 lib/x86/amd_sev.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/x86/amd_sev.c b/lib/x86/amd_sev.c
index 66722141..6c0a66ac 100644
--- a/lib/x86/amd_sev.c
+++ b/lib/x86/amd_sev.c
@@ -111,9 +111,9 @@ efi_status_t setup_amd_sev_es(void)
 	 */
 	sidt(&idtr);
 	idt = (idt_entry_t *)idtr.base;
-	vc_handler_idt = idt[SEV_ES_VC_HANDLER_VECTOR];
+	vc_handler_idt = idt[VC_VECTOR];
 	vc_handler_idt.selector = KERNEL_CS;
-	boot_idt[SEV_ES_VC_HANDLER_VECTOR] = vc_handler_idt;
+	boot_idt[VC_VECTOR] = vc_handler_idt;
 
 	return EFI_SUCCESS;
 }
diff --git a/lib/x86/amd_sev.h b/lib/x86/amd_sev.h
index ed6e3385..ca7216d4 100644
--- a/lib/x86/amd_sev.h
+++ b/lib/x86/amd_sev.h
@@ -39,12 +39,6 @@
 bool amd_sev_enabled(void);
 efi_status_t setup_amd_sev(void);
 
-/*
- * AMD Programmer's Manual Volume 2
- *   - Section "#VC Exception"
- */
-#define SEV_ES_VC_HANDLER_VECTOR 29
-
 /*
  * AMD Programmer's Manual Volume 2
  *   - Section "GHCB"
-- 
2.49.0.1204.g71687c7c1d-goog

