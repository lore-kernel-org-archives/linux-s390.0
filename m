Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874D25743E
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557208; cv=none; b=VhQ3Q8UPLYRAtAMHxxb5KlTYUeyIcKdvyNTo4bpvyoJE5dufAgCV1NVQG19Z9RVM8FkmuuYWvAAziSkqiWiQLag7TUvO3jZbkn/YT315rlGxlvVTC2Qqu3UtNdAy1k1wVc9kgXghszVNlFBHFFNyWL0s9FSRyKk0SZmmZGA4xkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557208; c=relaxed/simple;
	bh=6LGtEcNOSPo2DoHznVZ3dUZFP79Eew/LCbvwQtOKmHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ikQmMB0tT8oAXA/4dwLFqZLTVR6A2sZmZSaMy3J25g5YlqShwo9mf9zjPdNPlaIcD9crvpqS3Ew6gbnvniMAkCoZ8abNeOC/Zt2ntjoT5ocfXxU2+Xi3tdAhJZWL/MCNjAd6s4/3qHvb8B2VXSVygvbtQqadtTVtJedhiL4BVYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zq9OksZ/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zq9OksZ/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c7227d7dso1055684b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557206; x=1749162006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6ecWAsuLWk8WolZhf3FVD8zH2KTmGRghOSDHe/J8+gA=;
        b=zq9OksZ/8SVxe57LU34jqP2IIs0WLmDelQONWk+0aPHuvxdxPWCZgt9WhW832QNHcJ
         8JVpC8zZb2CoQQ6JgX8agL3uG2Tew7g6eEz2NUpQ6BRdD3VzElI1rlDs15S0ugvSJWQD
         +aHXUBBXt3K/nYhJQJ5Tapth0Js4GSzcYxnM8BNyDJTyWmeaS72XZj3O7EQzjeOTqTbd
         ccZig3xL/5MEEqK7Eqac8RqgHGien38qjnl3kbghQhllF7Pgv7ZexnrSSTUCIJUm5Zyg
         o/oXtzjuDyJcgHfyBQ2HSJHd2XSgbEoYW6UNhTdtJtO15A1bk58jJiD2kwvIikOFt4rj
         nXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557206; x=1749162006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ecWAsuLWk8WolZhf3FVD8zH2KTmGRghOSDHe/J8+gA=;
        b=a0uc5pmTVdDRUfi+9e+WvvQLM7j7RtBQtThK4U0QGFZNo5A7GkrKvx5aAIlWnfM/H/
         /1rOvNbpr5/9fgMUtb2U38ZmX8AXyxDxTxZT/ch4osAzzWv3MvFi+/Hj4FhfDWTZO0SO
         zrTOGRmXllprLB5tDLRg6Q9eAgVRG2UDxt0m95PxcinNeJitq/KEOpiTs9FFsXXvQX+H
         BlcYUTd2RqYgtk3NkJkC6dOK24n6UtUoQdnyuiFii2EA6Xt11yYgv3wHt+RkpWVOIIIl
         A0cchIHAVSjJMypnB0AbXE6n3t7eNcaiVAwzdW2O2UAAur/Dtu1L2NcWXNg6PWctepgP
         YJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWlqRmgi00d90sU+UvNiosRBv79cqgvARfoMhbc2tRXTePEYkb2kiz05rwUfFFmlOq6EKdLhme826yV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Aj3YQXggmjS7x73y/NwWZ789jtAybc6ekADzw0TnuCpT7mn/
	4+U5TxvfN8LBS48wajoG+Nk9KT3GxI5inm/qPkzxQTHlKhityOq/Rd7U7bt8qhhasDheFTis6jX
	oNuCX+Q==
X-Google-Smtp-Source: AGHT+IGqdlQWraG/z6hu1nUR7A5tPeMrZxdUjf3SOgtsQ8w8e/wxZYYVtAEj8FDmoGPeh69VqlnpQFBPrIg=
X-Received: from pfly12.prod.google.com ([2002:a62:f24c:0:b0:740:5196:b63a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d03:b0:73f:e8c:1aac
 with SMTP id d2e1a72fcca58-747bd968a6cmr1447650b3a.2.1748557206151; Thu, 29
 May 2025 15:20:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:28 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-16-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 15/16] x86/sev: Use amd_sev_es_enabled() to
 detect if SEV-ES is enabled
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use amd_sev_es_enabled() in the SEV string I/O test instead manually
checking the SEV_STATUS MSR.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/amd_sev.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/x86/amd_sev.c b/x86/amd_sev.c
index 4ec45543..7c207a07 100644
--- a/x86/amd_sev.c
+++ b/x86/amd_sev.c
@@ -19,15 +19,6 @@
 
 static char st1[] = "abcdefghijklmnop";
 
-static void test_sev_es_activation(void)
-{
-	if (rdmsr(MSR_SEV_STATUS) & SEV_ES_ENABLED_MASK) {
-		printf("SEV-ES is enabled.\n");
-	} else {
-		printf("SEV-ES is not enabled.\n");
-	}
-}
-
 static void test_stringio(void)
 {
 	int st1_len = sizeof(st1) - 1;
@@ -52,7 +43,8 @@ int main(void)
 		goto out;
 	}
 
-	test_sev_es_activation();
+	printf("SEV-ES is %senabled.\n", amd_sev_es_enabled() ? "" : "not");
+
 	test_stringio();
 
 out:
-- 
2.49.0.1204.g71687c7c1d-goog

