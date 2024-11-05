Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D3215F42
	for <linux-s390@vger.kernel.org>; Tue,  5 Nov 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836597; cv=none; b=t+0mOmZlFwg2aNcCrFIcQ1jrze6mg3b22n+fn3P56psvn9WgHwkE0vfSXrp5siKrc00GqvmlAioKvMgtVBsOzneKWtj/2vJwX0pe0Nfy8kcQHL/2beT1ThRO1/hzBaLGolfx9kU/+V0C5WYm5m0ymkuUWUVFsm/uVSo5nM1YvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836597; c=relaxed/simple;
	bh=L5dg5GAs/HO43xeeUw0eVVB1COvg02FxEjYWig5XfNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KgISbC1c4rQXU9IzUcwWP8qESG9V9hg+Jh0a42s+eFW0DKVlLLrORsBgClVbHoM0c18QaaMLEAOcOdNxnJ7y5+AAqd6ivCx296w2MFEWa1UJ6dnKmvXIFy3olu60WheA1FQzWwGB01SQWJN3qLR8K7RCE/IPnfuNzexT4tgeMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCpiLJSD; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCpiLJSD"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-83a9bd80875so574696839f.2
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2024 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836593; x=1731441393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+A/E6dh30+B+DuVgwcV18/qvNhG5j8MCeVP9K0OnPU=;
        b=RCpiLJSDRAnKCYCgYmtr5aFffKKqzBMFps5OWsprH430AJEXOmBRpUZ0KcMvAngKd7
         3pgKqRMpdHGqpY1xZu45ttA6AtdrKEJ7nwIZR2rzSMJOX2Sa6cyiIKKiddgwLiIs+hG4
         poG5XdRTT5K+4i+s2B6lA+HFfVGUqpOQkOpekcZyNo3ljbCNQeJ8EP9iRSZNvduMWxso
         MQeJAQpRbKyZpBEpx1L9j44VDce99yUYzUGG+yexEXSiyTlUY9krhYEiMjLHGcaTd3Te
         MyuxTH+KXdc9SQfLHSB9MJhdBG6R7VH30iNMX4UwwxSmF31QJ4BZxE0tO3611jWXNxW/
         Zt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836593; x=1731441393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+A/E6dh30+B+DuVgwcV18/qvNhG5j8MCeVP9K0OnPU=;
        b=ZJWcO4W1M079cheLr8bSelssNb8b5Lobt+uFOFYeMNbXW4GEn3fYcX6ySQY88mI35I
         jeXRSF+6kjdvdkT7oWCsnGn1QMRfl2wPe7oINEu4Q/WCEfqwSgKGTCuwlk6vlnv9CSJ0
         7fziGSyYg7bhZs05odpLr51iaBXwLX8Fnz4Yt/yUJde8JwDluwtQNI8/ZxZCFQkpnbaW
         ygYKqM8RsUJS7PlROZQOM3TNJmyaeyvFZTVwTuNJX0Opws9KjGJ/VFKgErGp3Hn2OfIa
         Da1A4sB/TivN6XRNcdqdu9bOJZOOWRIEmpO/HIzvU9WfxhIv1Np/RZEvsyBS2sNMxO5z
         HcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVasSNjj+KUL9KDq071fuePXaQkj1H+mt6lkpvt7btSf10vda656rD0BYAqo2g1vM1JCYOhWAD0FDMT@vger.kernel.org
X-Gm-Message-State: AOJu0YxukOIrOuiYMzJknDIo/yjUZhuRbwxVCsxYP20KLDQpu2ThAod0
	7ujkTVwumfqrdXLYyWjYUiEffUcudpvQw+ijif3AqzI/bzBoO4KCkBJYX5M8EsxU/TvnoFlmOve
	T/buv2tZCxL1HsF/NqviWmg==
X-Google-Smtp-Source: AGHT+IHwq3hF4ElsT4RerqS5KSh2j8l+o/SOi33LC2KdnD9j/u2Nkb6pf++GYEETuSfSuC1nI4Yu4HiUAJoPcaH3GQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:210d:b0:4db:e5f0:ceaf with
 SMTP id 8926c6da1cb9f-4de0257ba11mr134988173.0.1730836593213; Tue, 05 Nov
 2024 11:56:33 -0800 (PST)
Date: Tue,  5 Nov 2024 19:56:01 +0000
In-Reply-To: <20241105195603.2317483-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105195603.2317483-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105195603.2317483-5-coltonlewis@google.com>
Subject: [PATCH v6 4/5] x86: perf: Refactor misc flag assignments
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

Break the assignment logic for misc flags into their own respective
functions to reduce the complexity of the nested logic.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/x86/events/core.c            | 31 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d19e939f3998..24910c625e3d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3011,16 +3011,34 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
+static unsigned long common_misc_flags(struct pt_regs *regs)
+{
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
+
+	return 0;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+	unsigned long flags = common_misc_flags(regs);
+
+	if (guest_state & PERF_GUEST_USER)
+		flags |= PERF_RECORD_MISC_GUEST_USER;
+	else if (guest_state & PERF_GUEST_ACTIVE)
+		flags |= PERF_RECORD_MISC_GUEST_KERNEL;
+
+	return flags;
+}
+
 unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	unsigned long misc = common_misc_flags(regs);
 
 	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+		misc |= perf_arch_guest_misc_flags(regs);
 	} else {
 		if (user_mode(regs))
 			misc |= PERF_RECORD_MISC_USER;
@@ -3028,9 +3046,6 @@ unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 			misc |= PERF_RECORD_MISC_KERNEL;
 	}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
-
 	return misc;
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9..d95f902acc52 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -538,7 +538,9 @@ struct x86_perf_regs {
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs);
 #define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
+#define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 
-- 
2.47.0.199.ga7371fff76-goog

