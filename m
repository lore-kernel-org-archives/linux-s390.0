Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5D185933
	for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854471; cv=none; b=Fc0IF2oBTFJnhYPzafFU782d2W/mDEXAoc3AmJAxSJ6zTcU3gbiLWsvoRXuhi6pvJwNM1IPpbxv4OgjSS6uLB+JKaS7V8IB9mVNrBCl46j6hx+6SLsHnzpDoZp8l5XVwzWa0MWxsaqvIaPj/OQIg72X3lKbgwMjENuuF32/YEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854471; c=relaxed/simple;
	bh=nOGTMAQagWkUZdTqcYtpFuhJmVUFEuPWvMTzi18KweY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZj5Dv1/BZyIVm3ePKaNTrA3phB5gXPOdg2LdHoaUlHcql0925Tl9fUCFrJ1kwpEsPeWtSPDS1zWCvXJ6uipGhh/3BLYb7t3ZwTY9/R2Iadl3oAApOEDBIw+hUTNsG+bmUH2nfTRfX6HY0EjKsWdGRTFrDmsDoaSxBwcSQBUPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEE8QcAv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEE8QcAv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d683cfa528so31007367b3.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726854467; x=1727459267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Qt5np/Ap8e8S56AX/TaOyn++MQC/aFN8Qv/OewSh4=;
        b=qEE8QcAvyFTbUD9zHm9xR25wRUlLp1UucsNRGoYCR0MLwnzqk18uz0Vk4S6WwjkWEr
         /5+0Q/FJ3eLmx55mjEoV7S9xdXR2TS8UXrG54Wt2N9nLSLoSI3cWzt7JgrYhXjD8ol4c
         uf5JWvUJg1PU9no+OEc1eDEyebpHANKL9zh5n4Z3ohOLPafmu2t1eLSwm8cwA9ida6OE
         uRkLfeU8AxhMlkaNp7QN9FqkaWsu0ALTkB2fYmkNi0qFInHB5QGjckA9okpQLer5s8lX
         W/1OLiXNacqZmIXMSk1W7vyME7HIDB01ShlPnFVYM3vosXVbLNcSyQIVLezQmooE3MH3
         SFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726854467; x=1727459267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Qt5np/Ap8e8S56AX/TaOyn++MQC/aFN8Qv/OewSh4=;
        b=SGFZkOYesgoO6LgtArBpODBOJyEoyE8w9FBFOW1feMj3bPTEA1xp1RXmYvnqumg6li
         kxGNI772drCTxFlp4hjq+stwpnKdycmVc8J725uMmlIaxbt8pzvxqEvgQAPgKdVnKczF
         K4poAbiSVnR7jCA3cb1uswdhvXGvOF/F5yBH1+UQyNpEhqbZqVDDy4U4w3JYkI943igK
         q6rMbZuOx5gZMdO6x4+ju57hhzHZUVKPIGKHaZpS3j7zZZOkVTudJBIbpOJIhhGw/3En
         gqS7io2uxH17DzX0EKo4uYiQenFZQikup55Z6iQd/RtOhn3fKa1NXP7NLHYuT/17Ft05
         6sqw==
X-Forwarded-Encrypted: i=1; AJvYcCXPYc9CzDl26++xLT8eElrgXoz/+78NQYBQsQ0JF1tPXDdUWlsSBgfAZVShV4WNwd7Xa0O/JYdcC+N+@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmzsdk8PjgWI4IDj6I5GGZaKpkmwOeeoG2D9Nrup1mN1joJn7
	FI68f9r+0J8nZI6Bp9VPYg8Lt8nWDZXjFDebuTMdf3pLdWthnHvwtW0v5H4VVLQ9bmHdEISAqQb
	MjETPO6grzaC2x1AWg08iOw==
X-Google-Smtp-Source: AGHT+IHbJ+HRIEkO5u3cDhpGgKAhQ1szUZlm5tAMnmYkXHJJtXJeplzJtZCUnHcEvMXwbAUs2nrn0eCuaSMxzmED7g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:c803:0:b0:6dc:97eb:ac51 with SMTP
 id 00721157ae682-6dfeeece207mr233927b3.3.1726854467532; Fri, 20 Sep 2024
 10:47:47 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:47:38 +0000
In-Reply-To: <20240920174740.781614-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240920174740.781614-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240920174740.781614-4-coltonlewis@google.com>
Subject: [PATCH v5 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
2.46.0.792.g87dc391469-goog

