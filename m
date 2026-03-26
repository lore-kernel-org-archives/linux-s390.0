Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE374735
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547127; cv=none; b=KfA1NIHu4uRZNkSzGOSLXEx1aDYdGl5Zj3KNYejy0FxgniVpE/Lyqk8wKftRyFXIqMEStYIbWpzpPdvo6Z05I7z+6VttQP8MQB0blJBJIAvCpK2nr+GdU5WHxUwstUXovIMKTKWHirLFj+0XnwGr0ZeoabVmsJ1uFUdwH72cOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547127; c=relaxed/simple;
	bh=wmcfMJpAf9cAklazC7SsR15lg35pextNpvdKomyvVMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sp3lP2/aGH0EDCkG6vmFHeWEhivigkXMOAdOXFBNx+MddlnOwnft+ULfDHHBd/BcJjErW0W6S+oShAnTEfb7pdZQ+oQGWx/b1EHJzwJxYGFK1YO0A0sjFmUd/HxubUrGEnM/EPTtxuu/OrOnvX0bfLk5fp0aLvyNasf80k+RBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AN1EWmDz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AN1EWmDz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c1631e6189so8601672eec.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547125; x=1775151925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBFjyDPSdsg855fL+fMEtLIcnhl2jbnVzYsOsLzd26o=;
        b=AN1EWmDzd+uoA6scZFnGs4S4DKChNM3R1dRLH03T0r0P/IWabadiL7ybNl9kfEs7qn
         5CMKBCMjD/jE+hRYkGr48A9KzPhA0i/RVmtOsZhi3yhqlnPiUM5HP+du7uPTW/vHpb27
         ySMrAvifr8Dhp1i03bCS5gGveiPIBh1GJ2abp+1XomT08paFKDVHLiBa40+FP0kqwd2Y
         RhzH1R3xaVJPAI8TurMc2US7pYa9EfqatTJRq75MDctL0WlMN50b5/zPM2eWbkQnPKPv
         /0b3Vu1lz6Ur2EQKmkXlW1HPO1cym3JmYiE1ACHupELvrGCi6WzR8Bl0JtdonqCnTQh4
         0wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547125; x=1775151925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBFjyDPSdsg855fL+fMEtLIcnhl2jbnVzYsOsLzd26o=;
        b=bSNEsSA8JloT6/goaraV6F3tCyMAyO2w3Qyxm0i5d2kB/IuaWD/PRhxBGlvqE6/uMb
         QATK58WD/8EwyiLfuY2WaSGOGTjCtvCkMcGlAbTuMkdxNNrMi8/ziS8yhhkUYIXrgF0D
         WY57qlXGi7mWYhTFGj87lPhqauu3P8Z/771OtHFTVFmvDbWLxg3WdoV2g/EyZnvHvaNn
         dQ/lsz6xBHo+o5LGK8tf3w/7WwvBlgWCfk8h9d5Oy63JEiMHskiTPU03caE4g2iCHc+M
         SfSTBk9NwtuDiUb34DYFuLLHu7leRZbZsWc3PzWBOX/toWpOE0AO6aL/KNs0+PDtFyQn
         JFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX40/41l4BrrQwKZ80MP7puutHDiLknImLetzv+K1PyVvJiPBlgSpCu2ZFaDFnRmBiFmk+wQtXKxXCa@vger.kernel.org
X-Gm-Message-State: AOJu0YygAx1TEW6t+bBRMRcNf5AWznxCkVAvLdXUAL3J7tDmrEjJCANF
	yAeUgTVXpuVh64u4KdDgk6cdmYj80A/UH/vSeo2STbVdt6PcysLH2BUwx5JSk489YJ7+Dihulml
	SwYyGo2zyZg==
X-Received: from dybuz23.prod.google.com ([2002:a05:7301:5097:b0:2c0:bbbf:3af4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ac90:b0:2c1:2706:b3f3
 with SMTP id 5a478bee46e88-2c15d49e613mr4480475eec.35.1774547125078; Thu, 26
 Mar 2026 10:45:25 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:45:19 -0700
In-Reply-To: <CAP-5=fVJVc8uvPssSnUyTdO9PSbKy9qb0PrrE7VLUurwTa6MpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVJVc8uvPssSnUyTdO9PSbKy9qb0PrrE7VLUurwTa6MpQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174521.1829203-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add a helper to perf_env to compute the e_machine if it is
EM_NONE. Derive the value from the arch string if available. Similarly
derive the arch string from the ELF machine if available, for
consistency. This means perf's arch (machine type) is no longer
determined by uname but set to match that of the perf ELF executable.

Switch the idle computation to the point of use and lazily compute it,
rather than computing it for every symbol. The current only user is
`perf top`. At the point of use the perf_env is available and this can
be used to make sure the idle function computation is machine and
kernel version dependent.

v3: Properly set up the e_machine coming from the perf_env as reported
    by Honglei Wang.

v2: Some minor white space clean up:
    https://lore.kernel.org/lkml/20260325161836.1029457-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/

Ian Rogers (2):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf symbol: Lazily compute idle and use the perf_env

 tools/perf/builtin-top.c     |   6 +-
 tools/perf/util/env.c        | 179 +++++++++++++++++++++++++++--------
 tools/perf/util/env.h        |   1 +
 tools/perf/util/session.c    |  14 +--
 tools/perf/util/symbol-elf.c |   2 +-
 tools/perf/util/symbol.c     | 105 ++++++++++++--------
 tools/perf/util/symbol.h     |  15 ++-
 7 files changed, 235 insertions(+), 87 deletions(-)

-- 
2.53.0.1018.g2bb0e51243-goog

