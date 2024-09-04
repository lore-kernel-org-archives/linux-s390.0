Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836014883C
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482550; cv=none; b=gwxX030pIgunsnryhfphFo/SeoxwzbWteeY8fTL4hZoeSNiBThGedr1iMmahHQJNXuZr9y4lmPBtkZNk4Nq2ENMZuy2yEei9go9yjMqwqQXBCp5OT7rOQOvXfNm7gW0xonx5LUwdTB4+CmffOB+K3MMKls9/JKJw1AtaFXkY4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482550; c=relaxed/simple;
	bh=Bc+G/ABmIxicp+Ktu0Km0LfXC9Azpt75Q+13cZSyLUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=en2md0Gy+YVhMF20xarq+XqQzuiHjMIH6cZRsNpjkg0gWdAngxmXIN7gKC39n9YqCRFEfk7adeHZDzwmOgl4oJAtFyL1sD42z0/wBGWzuOql5jV8KXh3XVz5rSbrvQ4G5a/sMmc7a2j+JOdoz8D/FmZW5YdIljBU85Qi20awxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRVjl29G; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRVjl29G"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-82a2109c355so869694739f.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482547; x=1726087347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=da1VGWoVEM0srL8pak+5iYqVi4U1+WdMmmo+Uby7jLQ=;
        b=fRVjl29Gbc5EuZdxjwe6FzYonommB2vGrzHkHMwvG0ziX4Sk1vvXALNeZf6ivORasQ
         ox7wzpm46qKqTIc7W8zvBWgV2as80ZtZ9Gzggr05PWUOv9Zo35Ld1C6W1njrJtyKftC2
         5pX6lz7IlIDxRx95LpZ1s2q5mJ0b1kVN7JJB1Q3HxWa6a7m0aYi4E3jKct7dj8vo/+dg
         VPRdLp6dH3MQFeR/Fn7cyAmKeMnPevOpnZsA6rf3sBcOznaZmOf0ZJEwvsU2XA1CEspS
         vN/Y3dGFlkzU8+pnBrq1G6INbnSEJGHqw4/bPeK/XpFtdU/pCGSQkos2istE+DnJGoOM
         uHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482547; x=1726087347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da1VGWoVEM0srL8pak+5iYqVi4U1+WdMmmo+Uby7jLQ=;
        b=f/kDgxaJty3ddVVYtJg1nND8CAPe6M7dHocmRYXOFLRDzHDE5Jzb2a+5VwhAa5IpsF
         /wzEsFJvxizgx7purQVGkRFPWyNuQIsjCi8IpDacBh7pXyhH4yzE+2RyP8D1qUBqqvUP
         PPFspBX4vPjSxCx33rA2JH3srNXbc36X2fkhnyM9IsyLrZGC/0J5KbzKJDL8DzgwkUvf
         adiAZpqviUTALZKWfv7OSS3CHKdja+LtTeOggaxRztxBugavrxOsiUmdo+mEzkKx6X1C
         xZMR/cgkU3kRA2gA/DlqrA1oZlzWWZOdN7yW2boTbe62AobYC0HFU78lcaAipfrmGEY+
         KiSw==
X-Forwarded-Encrypted: i=1; AJvYcCWwnHdQAsdpL8BeCz1Hutogf2WyDC/Fj37aVmqRRGmuDLthb0EgEYvimIsW70YsARclQOt0y7ROwC+Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiyCeQ/FnrcN0GC5z+x2PrParjEA8CQxgpwTdu49vcnS1IepA
	sPAXmHQLW8c0syorB7HbIM9MAOaD7X4ld8AHF8PShGVrVWaXWvxLt4fBBU1ScnRBR3GIhSHK/uS
	pBIKRSpqfHWik/lOf3xGyFw==
X-Google-Smtp-Source: AGHT+IF5VwhfDwFkkz0RNP4hdicHfuNY6pJqQwTSSeUmfbLEP1/IRR0I2ApAClPpKugjZhskT8IDcbh94c8otLZ8KA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:2396:b0:4c0:9a05:44d0 with
 SMTP id 8926c6da1cb9f-4d017d7b001mr570237173.1.1725482547230; Wed, 04 Sep
 2024 13:42:27 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:29 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-2-coltonlewis@google.com>
Subject: [PATCH 1/5] arm: perf: Drop unused functions
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

perf_instruction_pointer() and perf_misc_flags() aren't used anywhere
in this particular perf implementation. Drop them.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/perf_event.h |  7 -------
 arch/arm/kernel/perf_callchain.c  | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index bdbc1e590891..c08f16f2e243 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -8,13 +8,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->ARM_pc = (__ip); \
 	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac9d0eb..a2601b1ef318 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}
-- 
2.46.0.469.g59c65b2a67-goog

