Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA240759B
	for <linux-s390@vger.kernel.org>; Fri,  1 May 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659629; cv=none; b=nmuV6Gxnej0IX+GXK8Ldmo8UFRimCPrbiaVqVfaabVGhJYVtA8azAp+RPHy8ZwsSXWqI6SmL1YsYbRCC3HGZIFmOwx4TNuB0b/kWrxJf6qC3GiuBDS/ix2SbEBVFdy4RPE+z6aF9CCFtlFU8UORo088jFCFMzOhTEGLnJn66xnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659629; c=relaxed/simple;
	bh=GRIc5DWIBKNP2dUCIS6c88b3pNLwafPvLlzYk9vd5p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rmhStnfDWgOYbHxe6os6evBuREjIHviCbHw16+hZ7iHvfXcl5bFba7NsMaA5jxcNLxIoZGr3c4kJnWYZfTV8UK39FDzp8f/9gn7fdB/+aITbR2CzIHIB+c/9fftny6SeekePh3+5o5h61vRC0nskQz/1cmKKHZLf7MOZI6Fx65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nz3p95ta; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nz3p95ta"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfdde7ce7so58622c88.1
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659627; x=1778264427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Csf7jU5ksl6iUa+guEmov8KI+GuuZCpIFE4ID3YpAMQ=;
        b=Nz3p95tayjNpaAeIG1DoPoGVFuUcL/ooG7DlMPPSUdIBFKYWhLOtjXg04KEr3YoJl+
         79ipzpjYCXv+X48/c0+LHBHaH4qD1OB3MMVdMcD2GK86fJTxCBZOJTuvKTuSds6NQlvI
         mURzWrr7cAQuczH9Y6FKYHDEzslZx4KlGmd5tN/D+FyDoXRtEFIt0QQrUq88oO7MpG5/
         sAyLJK2cyknRa9t9zcRks9ZPolFz2JkYyorhaVfM9xLl2vO9N4sbNDk9+XxQx61rQ/E2
         /A/r1hF4eOr2xKuGm2d37O8RNR1CChDvL+L9GDsIgu/87FX3pMPiZPNxiqXpz1PoPp2Z
         HmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659627; x=1778264427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Csf7jU5ksl6iUa+guEmov8KI+GuuZCpIFE4ID3YpAMQ=;
        b=qdczMZy4+7Y3ZOUm2Kwrn//lFP3YsBjYVxky62XVFq5uvfNN7+xEahrytZXodggA12
         K8VgmE2iUtGjwgCQek7hqjmMCK8rTHgcGpAnHi2lOXqe5EkJKEwFC7V85ftogONkCZ77
         QICPQz7BVWtDMa5H3MqMTA9lv94HVmtt1QQCpufhNm87qd5KNx6fsIGCG7FCYQGC390P
         fOpxCVfjx6pPXwekzK63oEMjSWmIQfEi9jSYGqivWJALBNix7C3XUbdT4kge1LO0+EK1
         RFYqO/aTj9o+LFZEOula0jJQWGR67NxR61sI8C0KSAPk6wDXNACKyCf/QXVs4GUeJlEX
         mauQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dsmSzYbN6rHX3gytrkX5KMiCMKELIQXiaGRjRNldTKtcwqBWkRU6M3kKVa4SjYTIZjNY0gz6pSZx5@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlvz1buZ4l/YQvIanNqlKgdGJUdLTcz/sdS7T7wL3knbcDZr8
	ljlzEVdwMcicX0z4ah1e8dTcui+6ypJfTJEetdJ1k/llWYXCn7OMVMNw7hibwPHTNslV/LO0cU7
	oKQkVJ/ZqKQ==
X-Received: from dlrr17.prod.google.com ([2002:a05:701a:c951:b0:12d:b6de:8dbe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c94e:b0:119:e56b:c75b
 with SMTP id a92af1059eb24-12dfd85eb0dmr136171c88.32.1777659626742; Fri, 01
 May 2026 11:20:26 -0700 (PDT)
Date: Fri,  1 May 2026 11:20:17 -0700
In-Reply-To: <20260409230620.4176210-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501182021.3651851-1-irogers@google.com>
Subject: [PATCH v7 0/4] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper to perf_env to compute the e_machine if it is
EM_NONE. Derive the value from the arch string if available. Similarly
derive the arch string from the ELF machine if available, for
consistency. This means perf's arch (machine type) is no longer
determined by uname but set to match that of the perf ELF executable.
  
Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
perf top. At the point of use the perf_env is available and this can
be used to make sure the idle function computation is machine and
kernel version dependent.
  
To avoid concurrent update issues with bitfields sharing a byte in
struct symbol due to the lazy computation, introduce a global lock for
updates to these fields and use setter functions. The reads remain
lockless.
  
v7:
 - Address better handling of strdup failures with arch in the header/env.
 - Address concurrent update issues in  struct symbol  bitfields by
   introducing a global lock for writes.
  
v6: Ensure arch is canonical by going to e_machine and back (Sashiko)
https://lore.kernel.org/linux-perf-users/20260409230620.4176210-1-irogers@google.com/

v5: Add perf_env os_release helper (Namhyung/Sashiko)
https://lore.kernel.org/lkml/20260406170905.2614260-1-irogers@google.com/
  
v4: Fix Sashiko issues where an array element wasn't sorted properly,
    the e_flags weren't returned properly, the idle type is change to
    a u8 rather than an enum value and the s390 version check for
    psw_idle is slightly reordered and tweaked.
https://lore.kernel.org/lkml/20260327045025.2276517-1-irogers@google.com/
  
v3: Properly set up the e_machine coming from the perf_env as reported
    by Honglei Wang.
https://lore.kernel.org/lkml/20260326174521.1829203-1-irogers@google.com/
  
v2: Some minor white space clean up:
https://lore.kernel.org/lkml/20260325161836.1029457-1-irogers@google.com/
  
v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/

Ian Rogers (4):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf env: Add helper to lazily compute the os_release
  perf symbol: Add setters for bitfields sharing a byte to avoid
    concurrent update issues
  perf symbol: Lazily compute idle and use a global lock for updates

 tools/perf/builtin-kwork.c        |   2 +-
 tools/perf/builtin-sched.c        |   2 +-
 tools/perf/util/annotate.c        |   2 +-
 tools/perf/util/data-convert-bt.c |   2 +-
 tools/perf/util/env.c             | 218 +++++++++++++++++++++++++-----
 tools/perf/util/env.h             |   2 +
 tools/perf/util/header.c          |  63 +++++++--
 tools/perf/util/session.c         |  25 ++--
 tools/perf/util/symbol-elf.c      |   2 +-
 tools/perf/util/symbol.c          | 134 ++++++++++++------
 tools/perf/util/symbol.h          |  17 ++-
 11 files changed, 357 insertions(+), 112 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

