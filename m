Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606A150994
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482551; cv=none; b=GtKvwphgkkIWN/O6oz+DtY1xW9FkKx+mhPTmugfxdG4JWD0NkXyHxR1iKVAUXdKZok2P4BUsXZjQRs6Mcol5M4wCdI4ABRSkqvOJvM2Rp09CVX/kiEvdQNC0jHndCOzzxwND/zReYeI1038spC+lBzacXZV6GMl+ZzXlcKC2s1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482551; c=relaxed/simple;
	bh=DY32o9P9BJrjFnl8SkC7+4pBAbM3HVwNyOI1WxXRIXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/rUeFGeMhD9KpN2B5eD6q5oJbnhj8Hguy5d/eEWx697fgXO9rO5kG0ppZ/eHH+7aEhZkAX1Nct+beP04aB08DdnyEFJUWOHQfOMVxxLOkziZcb7lnmLCHSqzP3iA7TYAJZk8lOOAr74VqhFasvWpKtOKD7ZQMXpkPi3ci+nPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxcEjTfE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxcEjTfE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6c3982a0c65so159828327b3.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482549; x=1726087349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF63B/qB2C2mWkkN7Sev/IpM9OI4DaouC6axCITdljM=;
        b=JxcEjTfEmXL8LDwcso9FeTdZP2ku2SAaS7K9LjcmXdn604RHtDpfRrM4vFW5VD3bWY
         Wq4wzjEDdc/loHpKYqY2cpnnGVp+kfH+w0bW5aOchxLBvrZ4XGRwtHcy2kfQhYRIrUtI
         pWIt1D+HngAwOdwkIGhyGDma+2eGLgFCrUj+PPy2Gqdpn156axWG8pb5RIZl5MgFpGGd
         4A+SYWn7LF+evLt0X0CMWaJ2vbQi58nxTgsvg06sbbQ+hw9uyK4QI2VvJ7vntkFP+JDJ
         UvEoEl+516NJYwldsgV1HhV1mVxmX1lYmv0Dd4uK8PXHzBPYEIxr475r1aFAg6rVeywX
         ezRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482549; x=1726087349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF63B/qB2C2mWkkN7Sev/IpM9OI4DaouC6axCITdljM=;
        b=WOXx25UkKksA4A/2qeqarqaH8c84Q9rHUjljh94yu9bb8mmswcjCf57NVIDp2F/ST2
         fKs0A76B7VpoMtuhxbjdpR7r4a7htfXbZ38ZhSWfwG0ThvsU0fdnG4qp74i52LHpgzbT
         yo0twHoMy7Ja+Nzb+Cx9AX89+g2eQAgsvwBMk90fQ35k2cZVBBv/zIYVhxzbmFqxZYLk
         zopqhZ6BUsrDsBzrENpokmAkLRJBe0iDxRGcFS034E5FrmQbeedXPGQq1gD7KJBo2ilY
         UE/osmFYOcflHOeVPtQgaLv/EZCqXgC0QhBxvjNJc2nXW2zx8nfRPoxi/HJblVseFkEO
         nMYA==
X-Forwarded-Encrypted: i=1; AJvYcCXBF/fLGCqVXyQ0v3vATiKOcUqlq/j+MuwxGmqqCNeTloVObvUmonb9dGsMZrFAnayD/T2WB4+PsF61@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhxMMEykJAMfIvIjhYzWzy4uRlN601x3L5+VRECL9s3S5DNQk
	BXdzzdqrPn9Zw10uB+JrhE5EGChFPBsYfjgECUQdLXl8uJDyIU6ygLkXyVVM+bWihY082sjX8Dx
	cC4s4v60UMSj6IiSkVl1jVg==
X-Google-Smtp-Source: AGHT+IHnCAVHhUCP2jsg9QIrX/diUprCN0SQ2aen+GiK4qTsvqjsoiEZxfc39AEm13a4QPmtILTk2j9/pAbTWP98xg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:b612:0:b0:e0e:499f:3d9b with SMTP
 id 3f1490d57ef6-e1a79fb4d7bmr28585276.1.1725482549203; Wed, 04 Sep 2024
 13:42:29 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:31 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-4-coltonlewis@google.com>
Subject: [PATCH 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure powerpc uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/powerpc/perf/callchain.c    | 2 +-
 arch/powerpc/perf/callchain_32.c | 2 +-
 arch/powerpc/perf/callchain_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434dd0ff3..26aa26482c9a 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -51,7 +51,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, perf_instruction_pointer(regs));
+	perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current))
 		return;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ea8cfe3806dc..ddcc2d8aa64a 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -139,7 +139,7 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 488e8a21a11e..115d1c105e8a 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -74,7 +74,7 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
-- 
2.46.0.469.g59c65b2a67-goog

