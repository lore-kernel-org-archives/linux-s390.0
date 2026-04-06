Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7331A9FB7
	for <linux-s390@vger.kernel.org>; Mon,  6 Apr 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495822; cv=none; b=JlEtLoQxT9xTRaVQiu5WkCHc4MdXdDd9UXXAg6+WOfJ2hyXLSCNA6DJHoqLcw6F3TuyB5wIIhS2vyEr7iB/21PPwvLaaI60mi3vRwZWzhUjLzYiBX6EAYA32ay7zzTU309XJqKWqOYmYDec9RYS/lSwimli/bD32YUk4VuWW/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495822; c=relaxed/simple;
	bh=DsenSwK/NwNsVQofpl4gtUWjwJhYnStVDFl38jee1hU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Orftun4gFIfCUkkIvLX4L4a8ZI5TEHXhnr+/VoaFgRSiwo6zRxXZEkS4cfuG/j4UWmZqISoabZa95TbKL2Ip6nP0g0KYreAeJh88jtWJabyEXBezxz5HjNloCgJa7BJQb0Q2ELgj26R96Fw9jAZS21sGGRyYwtmgEiRE//owhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZO3LR+t; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZO3LR+t"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c895e7de52so17220658eec.0
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2026 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775495821; x=1776100621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMCKiIhN9/73e2LsQXZ6rcdnXOer2akl+Pj9NWbWVh0=;
        b=BZO3LR+tT7ZF7U0Ir/JgTcKvkbYV9PskhOPWxrW50U/iaNfsVKoWASc+VAblix4F7E
         pBfAqpSW6ChtfgF4Mjn60tGlGGxF2p/biOIuntykJ1n28rUcXZ3Lh3pafxjU6gZLJyU8
         xVFqR/zvLhrI2aFT3oySPRysdOgPA+fBt1ZyNsCWpzte2BQ5AfgHAaY9QDmkThueY1J8
         8AyBBf/JEr1d+zMGMwL1PxQ0mOjFKExs4NDygcms6TaSj08aZT3DSEB2/PhG3KkVupTV
         X3XvSEqv64PoxK+l3l9eLf7WmG71zrXx3kOBrhbA2GYM+RtP3++FyFo+uDBP1bKRqjRH
         1RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775495821; x=1776100621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMCKiIhN9/73e2LsQXZ6rcdnXOer2akl+Pj9NWbWVh0=;
        b=GLJ6VvAoj1M7Qs+e9JoLONknnwyM/LdrZdLHrnY7DxSX/xl6W1/xwID9pfMK4rOa+A
         Q5/kmxTYJaNe6ltLAT3Bc8lAG0rsBXZpDr/37jukm+scuez+t/FS+VcXSE93QoGSCHxR
         OGniMU7Zc4rMDVJRle3G0iUP8mxaaUQSsQ2YVmu1dxMiLeT2aLyl1KHE6YBkCr4FKvfW
         qz2DwEDoX6MFmAVmb5i/ebV+AIJvLHOTepJuua0VGPUR7j0FdBw6uZz8Nr3waj9P+uyo
         T+XTw00GjFxR0Wm0vAHxuS+0Ft/z0Yz/AVW0JVTH/5DjtkEa3uUPA5XyP7u1MjAnDbPi
         lGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDEl1A8Z9omAfWhCscaUW0x2kxvrkxCLhLd2ST0zifRbB4P2sP/zyEsxWcLJIpUivpp26ik7p21eMO@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3z1Tt3ablvDlM0yeNpuODq9Hyd4ucTWpHCqRgjXdEhXEc3kg
	z834gWnfBYDexXtTcTjUTJuIsR4krNXHBJsk0zmxmpuWypcCOTeQAEczFnMemiUj5iQHT6LVYkc
	O1vRziymd+Q==
X-Received: from dys23.prod.google.com ([2002:a05:693c:8017:b0:2c6:fcf:21bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4090:b0:2c8:6361:ab58
 with SMTP id 5a478bee46e88-2cbfaaaaf92mr6467000eec.13.1775495348644; Mon, 06
 Apr 2026 10:09:08 -0700 (PDT)
Date: Mon,  6 Apr 2026 10:09:02 -0700
In-Reply-To: <CAP-5=fXxa2rvxMqZoD5ayETiPjS8cf7A49TdVwwt+10uPu58Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXxa2rvxMqZoD5ayETiPjS8cf7A49TdVwwt+10uPu58Pw@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406170905.2614260-1-irogers@google.com>
Subject: [PATCH v5 0/3] perf symbol/env: ELF machine clean up and lazy idle computation
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, jameshongleiwang@126.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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

v5: Add perf_env os_release helper (Namhyung/Sashiko)

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
 tools/perf/util/session.c         |  14 +-
 tools/perf/util/symbol-elf.c      |   2 +-
 tools/perf/util/symbol.c          | 107 ++++++++++------
 tools/perf/util/symbol.h          |  15 ++-
 8 files changed, 264 insertions(+), 90 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog

