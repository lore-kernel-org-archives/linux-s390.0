Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F93128BA
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330426; cv=none; b=C7wCY56ej+tz7lOGWkO9BzSngPSZMHlB4idgR2WAxkaTBzkZqrLCSfN6H7e9Nc4Ad+FAddAhkVMwIm0CTEoqUYenH2YluiZ5DSY2M6xKOR4d6Uwk3x02nPrReu/ea/DHOFsEa45qvcxRepz5PNaF6T2glzOWZb3dIfPvhaD/6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330426; c=relaxed/simple;
	bh=KnVSWXbsVK4WkrJooQQj95dw6wW7FkwVG7nPPpnSuYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRWyCv8NdywtoeY+ymppNQtZ8AtD6edW0+bhvOxjuf9+mEIQS7fXRjN9GwCa5NmcNRdrOmIg20PEmHCfaHmtlnuBforIYuhf4SQWT7j8SQk7ZjtRBA+uU53Y4/0ZPwBBIAdCUEYJMXFCFU29jH+tqbXvlF/x4PvvmpLhw/sUp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELlbUbtD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELlbUbtD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a265a02477so1870180b3a.2
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330425; x=1761935225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAS7HLWyE203ant0NTxx4AzsxmUZdwyOFbiZtXWA1Xo=;
        b=ELlbUbtDsipjl7iUVm/p38Tn569Sn7egwg7NwKYe1h6G8VIJrfgKtP6mXDxCNTL7VB
         d/wvRxL5zcZ2pVlJa0qzaTaXiLsaq1QxzyKEoUrGYEW7tqBXxrxUcnKhefsACtzakPft
         6p97SsJ+yxUq3JVYUuf31sigxEVkVtlrOQ/NpO7Yf7DJAMvMBblhQ6/7y8Bn4hLINEE1
         PGBihrgx+JraZJ8rgLm3JRyDLwK6fiS4XYd//0xl8mcijZCDRGuDopqbaG3xe23hzWMx
         c92eaIMi6cW1xBvu4OMKy8xDOiTEL/zdJdSH2oE9yN/y3+9VD2rvPcazxOiitE2fPMuE
         /ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330425; x=1761935225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAS7HLWyE203ant0NTxx4AzsxmUZdwyOFbiZtXWA1Xo=;
        b=XPDcm22dgF7RUDfrsslS8fOad7ok57QNd1s2T/f1qnaBSfgxQBtD1DQdWQhqM69CgD
         wyGfo30TQZlq8LVGR0zaoB1cyQ02Xub+/7VhXzm7CiwtnLfRtQmQRUU/BD3m+a85tZTI
         iyw79mtPB7vO4sps42BYkJO8C/qjCwRoXZJ8SrB2V5amzRBUg7j4f6jLXR0GNgOcdneU
         Z4AEK5SBmItVyrBoNFR6CYJd6GqOloeeCARWAg2/o9CMKSEFc99QKmapv0o/aBYDSBlK
         zHy5++Yn77aW4uPNnH88pMDYnmFhr/d9EKI72gbOzZdiD7G42+TRfdSWPACaxj9olVWB
         33/A==
X-Forwarded-Encrypted: i=1; AJvYcCXRHk92JSr4aixQjK24gUS8DSJQvRSnnBIErp7AJhoYI7uxR0CqlOuqzcqtiRcYX4g1ghQzVcqSA0og@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TQSUomJ1cGKu8B4jtZOmfbZhtzb5RtsC73AEMhgLhSzqItIk
	N9qbv/3pv4tgTlyBnxViWoKpZ/+JL2WIXcbnMlzvk5g6hxHMtRAazyfs
X-Gm-Gg: ASbGncv/mCel/Y9uVLMoqetC9UoiKxo8vcSIK65Zco+WLI5PLXwvpNz64QPL0CqjQec
	SgJqOEl/2VUQ2qpb3u1fyviPY/93p5ne7wFvkhty1JP5op5GN8OvKCY22Tcv5hyjbBys9FuknQ1
	ktsDGftq5IAmWcq+tlGRzGg0CEyR7fDQjokiAih9yMPQdTp5mggX4ftitDkKlVdElR3OJO80org
	qt/bxTMoOokPMsTCxBFp7fo0Ad0rAS48hQsuHHvI22in5Kkb27DunThhS0puZhby49UwNrHmUSr
	Bp42H7J8mqfPDhHaM/9n7FXiduBOMiADmAy98Rv4khMKyGQ1xXCT03t9ktls+/rI9DYOKw8Fy5T
	D7ndomudhpTFdMassdnvgiVpwlmmrnMoQ+AfgXvF0mSCaLN2Pk34RrNEBy6OtTzL905Avpb4w8o
	wRZz5eZn+m2ddNmpHV14RQ
X-Google-Smtp-Source: AGHT+IFGe6oRjXPNPGl24FfDVvabdUA/zgNZ4jI5ptDLqD482exk92jQbNg3NAgkHLmfva10Udnmhw==
X-Received: by 2002:a05:6a00:2d06:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a286765aacmr3785072b3a.5.1761330424441;
        Fri, 24 Oct 2025 11:27:04 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274ac3158sm6616572b3a.32.2025.10.24.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:27:04 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 0/3] Optimize code generation during context switching
Date: Sat, 25 Oct 2025 02:26:25 +0800
Message-ID: <20251024182628.68921-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this series of patches is to optimize the performance of
context switching. It does not change the code logic, but only modifies
the inline attributes of some functions.

The original reason for writing this patch is that, when debugging a
schedule performance problem, I discovered that the finish_task_switch
function was not inlined, even in the O2 level optimization. This may
affect performance for the following reasons:
1. It is in the context switching code, and is called frequently.
2. Because of the modern CPU mitigations for vulnerabilities, inside
switch_mm, the instruction pipeline and cache may be cleared, and the
branch and cache miss may increase. finish_task_switch is right after
that, so this may cause greater performance degradation.
3. The __schedule function has __sched attribute, which makes it be
placed in the ".sched.text" section, while finish_task_switch does not,
which causes their distance to be very far in binary, aggravating the
above performance degradation.

I also noticed that on x86, enter_lazy_tlb func is not inlined. It's very
short, and since the cpu_tlbstate and cpu_tlbstate_shared variables are
global, it can be completely inline. In fact, the implementation of this
function on other architectures is inline.

This series of patches mainly does the following things:
1. Change enter_lazy_tlb to inline on x86.
2. Let the finish_task_switch function be called inline during context
switching.
3. Set the subfunctions called by finish_task_switch to be inline:
When finish_task_switch is changed to an inline func, the number of calls
to the subfunctions(which called by finish_task_switch) in this
translation unit increases due to the inline expansion of the
finish_task_switch function.
For example, the finish_lock_switch function originally had only one
calling point in core.o (in finish_task_switch func), but because the
finish_task_switch was inlined, the calling points become two.
Due to compiler optimization strategies,
these subfunctions may transition from inline functions to non inline
functions, which can actually lead to performance degradation.
So I modify some subfunctions of finish_task_stwitch to be always inline
to prevent degradation.
These functions are either very short or are only called once in the
entire kernel, so they do not have a big impact on the size.

This series of patches does not find any impact on the size of the
bzImage image (using Os to build).

Xie Yuanbin (3):
 arch/arm/include/asm/mmu_context.h      |  6 +++++-
 arch/riscv/include/asm/sync_core.h      |  2 +-
 arch/s390/include/asm/mmu_context.h     |  6 +++++-
 arch/sparc/include/asm/mmu_context_64.h |  6 +++++-
 arch/x86/include/asm/mmu_context.h      | 22 +++++++++++++++++++++-
 arch/x86/include/asm/sync_core.h        |  2 +-
 arch/x86/mm/tlb.c                       | 21 ---------------------
 include/linux/perf_event.h              |  2 +-
 include/linux/sched/mm.h                | 10 +++++-----
 include/linux/tick.h                    |  4 ++--
 include/linux/vtime.h                   |  8 ++++----
 kernel/sched/core.c                     | 20 +++++++++++++-------
 12 files changed, 63 insertions(+), 46 deletions(-)

-- 
2.51.0
