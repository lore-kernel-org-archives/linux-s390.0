Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD2939E184
	for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775990; cv=none; b=jldkNqzu5zcgZu8pvt14XHPFR1E8iKxp+dVNxeJU2MGhLWCRC1zuIgCmJytDZcnL7KOSVVv00y0CvilmLWpbTPlA1tC9rb+inny0uJgs6rFT78p6fepm8lZHlebg8giP/Gd8jleYdg3ONhEBYDxV2baSYNmjPKzxIT3cOv0DH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775990; c=relaxed/simple;
	bh=DB/JCvQuzg0uvlhXm+oz0eVsqbSIkaRHhQAFtbMAapE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BIKwytE/JOzx5Ln/CQqu4tSs/AbOs/4ixc/q4/xY7QV0HTICw/G5vy+5vUTe6IjLFggLDtQ5KdJWjhq7rS4vLGGnAfx4yKIZq5hGyCAF318z4oENVC/dkeF4zL6W/tsqcRfmjLv4O8EjXAippD7rbXN3aAhb88wGsT4B8lfxSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpCouREx; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpCouREx"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1276e71652fso2071174c88.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Apr 2026 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775775988; x=1776380788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxVDh2eRaCzt/S7N8luyaTOnSvmjRTK+RZcJFsYtPbA=;
        b=ZpCouRExS2OCZoV2uDXMJtsUjeHV1yK1L3xP6Xz5GqYeWznF/ae5sbkUT0NEjZiJVR
         HKm2wsTcVPjR9rzfHypOpcJr6/EUfZZVDpf3KPOMx7HikKRGJEx3lfCfDuC5szAs5+h7
         iXWg/jtGH7MVKoO1OLJL3w1mYBhFm+GTts9kX/TIM/xtHq1m4NXtWH+veNvu7/RzEAI9
         tvfbGwunZCA+a8XeescJ2AlNRdovYiXpgkpgMgH9YmnCfOyKrBN5d/ZHbcFvcaZgt6yL
         6qKmUlvPx6weOHZ6RiXeHiN+0lY3MNRzh29chTUOKVZnj6knqXQuJ6cfc26KxGI3FRSq
         enTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775775988; x=1776380788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxVDh2eRaCzt/S7N8luyaTOnSvmjRTK+RZcJFsYtPbA=;
        b=AeMSyHdwis4oqyGnrKc8ZkLLqniVGyC5JsWwGNpjEJgE3ozkYDC+1GZKE3JefO0Xl0
         iumXu+oD+lSagu97P5vQYAAJkwcvIEFPbjjKir+vwLWsw+JD3dL0mYXkmVGB/wBev1Nc
         M+PzzF6ikxQSnO5bQ5dWMhBMcwlW3nvkHNrqyYPjeEaTh6u5MbSWk1uPTHooybH+Yl3r
         E07xD8JBAl1Ukky0o3MYUY+0wtd/AMJ3wpgFRS0gScCozV3th59h2NFoz65cHEvg+n+s
         WV1U5mf8n2iI9fUpkPPJn1PcnQzOqoe479w9IOWp+sRpJg8IFAZ42UbLRBz3fNbL0L9P
         lA9A==
X-Forwarded-Encrypted: i=1; AJvYcCX57TeOkUds2tL8EPQGnRhnrprRR5mcSAjyADzWGFBzwRwoT7Y2T4heqI07r2QaS/qDK5Yb1NqFVc9D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+T727GgzDG+fyu+Ds3qd1wrmKpjbmcGb5tIL98xg+4ShUKGrL
	Y6HhnH1XF0WpnfoYMrHwJbzkMDtYgHSnZzMgysV2ZPjNDfQvcptaGKXkNYXdhKOf/5wZr+JCIBN
	ezjjZ23IFRw==
X-Received: from dlbrh20.prod.google.com ([2002:a05:7022:f314:b0:12a:c608:a29b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a2:b0:127:9ece:c47a
 with SMTP id a92af1059eb24-12c34f160e8mr452729c88.36.1775775987959; Thu, 09
 Apr 2026 16:06:27 -0700 (PDT)
Date: Thu,  9 Apr 2026 16:06:17 -0700
In-Reply-To: <20260406170905.2614260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406170905.2614260-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409230620.4176210-1-irogers@google.com>
Subject: [PATCH v6 0/3] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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

v6: Ensure arch is canonical by going to e_machine and back (Sashiko)

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

Ian Rogers (3):
  perf env: Add perf_env__e_machine helper and use in perf_env__arch
  perf env: Add helper to lazily compute the os_release
  perf symbol: Lazily compute idle and use the perf_env

 tools/perf/builtin-top.c          |   6 +-
 tools/perf/util/data-convert-bt.c |   2 +-
 tools/perf/util/env.c             | 206 ++++++++++++++++++++++++------
 tools/perf/util/env.h             |   2 +
 tools/perf/util/header.c          |  60 ++++++---
 tools/perf/util/session.c         |  14 +-
 tools/perf/util/symbol-elf.c      |   2 +-
 tools/perf/util/symbol.c          | 107 ++++++++++------
 tools/perf/util/symbol.h          |  15 ++-
 9 files changed, 309 insertions(+), 105 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

