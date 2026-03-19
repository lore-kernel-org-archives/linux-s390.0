Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B907126BF7
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898780; cv=pass; b=LwFVJsfWZfmwu3Cs57XCSFjoIeArpmgoXoXIRceo4pvZ6pyRXABg+Xz2+FCOhG77mX3RqbXU5xboBEtE0wd1pvu43/O6lvFW6ajxkGJEmN9cJsKzS+A0fMaWELv7gO59c7nnW6rwPiXmrLyR0trA70YizqP2ePE88PLF4DSYINw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898780; c=relaxed/simple;
	bh=d4dtVkzoDU7q1gZU6EzIMD9MaBklkUv/FswCZinMFrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VT2hip6XPRoVHDijE5XAA/n0VevFD39POEWVvDJDU1f2C5rp1grzf5HyQ8+WIb8dqh3obpJZTFgnZhsKRU0TF3kjwroZ/4VZsd4YPVA5gHICgJ67sTnz/YxR3Nz4TaTJOVERtPrBZiDTH9n+oC13a9gZe7aeQta3HdE6AFDrHDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nv0pbSd+; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nv0pbSd+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so51895ad.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 22:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773898778; cv=none;
        d=google.com; s=arc-20240605;
        b=M/zHsry2zYft7bT5chey6l66u5asWS0GnZDpuvFn5e0u+W3YaQjXYJm7N+MS8iVjC8
         +ntR6NQY4EJkNmKrESR+BW+Os6cmx86v0IiXS/JaGk7bDI3s2r+5hQQrP4PcI//JvU9L
         G92c3ifvu2Kkox61NJTJMIjxFVlKEbxTEPbpb05vMtK8CY1TWuu/jmpufAq8Td5KnJR0
         MEHblacbMMWQPS3l32Ivao510iyFtZC1dnsUlAxcDTb/T9NLEp64cKStTFsDUdHK7nYY
         TOH2bwhH4iYh8yJqm74iSotcHMkOLwlqeihXLLotTZZmnDdxtytjkjzTdxO+py/OY8fv
         Ct/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        fh=N1F/NEZWfjlBmb6YIBLugVhWF+mJpJZjBNi2PxqC2Hs=;
        b=kLOMKRAU4t/AtFWx8C4KY5cn5r171uwXoMMbG2CNManavOJz6NnpDW1oehIqvP9epZ
         6/GAMQ2mX7MCRJfUyapgFU0ZhSJJYm6qn4qQm5idCtU1rs0jEG7vCnfUhgg82ARv5ICm
         N4OHD9jVpEemR2othB0VVOVCgzl//ABUzH2mOssOmYG7N/8c3DYGIWTPfXeP6jAKD9Tj
         vkgzJ+IFDdmUh4deZQb7RIHID/JYMfn3bEQdO3293grg98MKenmFZkQQYxOW0DMq97U/
         3YZqOCjXe4+ig4gqOqGnxLg/uHVJwW40+ymubvxzDhMKU+x3l7u0GNpUXYhb5gxYnjnF
         mAYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773898778; x=1774503578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        b=nv0pbSd+2iBQIC7nQaqMuASk3syFc4reKpcfRtC9L56aFW9wCKZ4Hbxqd0wYdzyr4k
         Jc68bA6wp3VwCfCDEibIIUeEdzuBHywIbwwATiPPBtIVMVwQNDnA0yuOMV2D2zuXkEsC
         VnNNr0uIJnKtkBXI/6+FZ8W3Yr+RxDKzPvsHtpdQml7tC/Mij7xlDt56MJ9LcGM4DxuM
         cR9saf89N/kyXxFgoBCiGVslnJ1BxgvW++aog3PCbOXw6NW+7YGVhGVd5rXYrQ/FAryJ
         NaPpLM8vfOk7mh/9ZecRsDKTcqnq/ISdDVYkvgMo2TtLooLEj+MNZxjZefLVL9+YJvA4
         w77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898778; x=1774503578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htjlOO4XkJQ4ehd0ipRSCdZaVjN/ob14rEkSLMPLvzs=;
        b=l0ZGK1UXkYWC5HQP4956CInM6oqD0fnqBdNBWgHUs/6n0AglMTPgjW7vLtxvjQiaXe
         KTSr9UsRA4iepRLqehZ4e9Mdry3Ajp3NqAOj9oOiHP8VCxonZVW0GHeXIV33+7jfjDof
         Adms3Adpk7J4H5hmYtYIu/N8jHwHuZO+j7rbyiVuOAbmZL42vWWj4+KSpWKMFubXynaa
         x/E8fy3PVRDM/SP2co1nVQYtNRrrrgjbDiCnSLYhAsIjbYhpsUemNo3qd1FB/xZSFyaq
         AKHt2dibyuGP3YBDq4n3Sp+fwD/2L+UbAoLqxzeBoojkVIcBu8LlvXNUCyVGEKULq5VH
         oZNA==
X-Forwarded-Encrypted: i=1; AJvYcCXRlz+Y5m5h2NUPolfQLJZG1m1BuUd1ADQ7oRzAwMYkuEj3Y5PXxjT5c93FCcGiApzCAMWhEDJiO3gV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58ArUOGqibheSR5AYz9IA+am6inSpC8C+afItmjQY8AI7733g
	GIW2mkoCtTjosFS3/bgjWcSyn0gZmUcAJ6F1trkxBXCm92ibZT4K2uS8xJ3uj0ROwDmNvSlNeOb
	Xp4mziVjVB9E6l/e1g7lHx2P8mMINNO/uKw9c7NP9QRvvLZJSyMxAQMOdyNk=
X-Gm-Gg: ATEYQzzIx3Be7THpo+1RcO8qQIXa6NQWbqD/twXUJ7XuT7W9+rTrhdH+Pf36xeyPQBT
	A319jHdGvqxPLNMIq0OwIJuyLkr194Em31qEZqGZjUeO6XaP5j9K+OcHumgCLLo0fVI4PzEEDXE
	TouP3Nh6yjogmyjwlt1Ev0+K3N4+8nwupFFQtacgwp+e2lQP6mrpT1rYqRKxfTw3jJ1fy+IY5te
	oJxtWTgxTmU8Twzp1uhtHD3tj6GoQ/pVZZK90ynLfO0taiQ5cw1qXxF4qbJEqgOS1E3ckrVVx3v
	ZN1kKNnhW7f11Gf7+7k=
X-Received: by 2002:a17:903:46cd:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2b077e8cf17mr2042765ad.22.1773898777982; Wed, 18 Mar 2026
 22:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 22:39:26 -0700
X-Gm-Features: AaiRm51WVkEbo2yRWjczdr_OVf_mYCmnDxfH_HvwH40cuXXVAtHg9_DcyaGADP4
Message-ID: <CAP-5=fVWNP-fpD6bCWBKNDnwcMkYwZcvkBgqGjTJJ0fFQko89g@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] perf evsel fallback changes, better s390 defaults
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Discussion with Thomas Richter in:
> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.c=
om/
> showed that the evsel__fallback wasn't working for s390. These patches
> avoid the problematic frame pointer callchain on s390 and fix
> evsel__fallback from a range of problems when falling back to a
> software event. I simulated failures when developing the patches but
> they are untested other than that.

I think at this point I call it a day. Sashiko still has feedback that
could justify a v9:
https://sashiko.dev/#/patchset/20260318234600.730340-1-irogers%40google.com
Specifically:
1) software PMUs may fail if sysfs isn't mounted. This isn't a real
problem as "software" is a "well known" PMU that we create even if
sysfs isn't mounted.
2) the handling of callchain in .perfconfig files isn't right, but the
patches aren't making it any worse. I worry there could be several
more patches if I start fixing things wrong with .perfconfig.
3) the possibility to add another NULL check for safety exists, but
the code would already crash at the same point.
Apparently, the tendency of prompts to generate further refinements
instead of providing all the problems at once is a known limitation of
LLMs and the current prompting methods.

Thanks,
Ian

> v8: Address sashiko review that target wasn't fully initialized for
>     `perf record` with '-u'. Ensure the callchain is enabled with '-g'
>     and a .perfconfig setting. This don't impact testing so keeping
>     Thomas' tested-by tags.
> https://sashiko.dev/#/patchset/20260318175808.582009-1-irogers%40google.c=
om
>
> v7: In perf top, move the target uid handling back to after the evlist
>     is setup. A regression caught by Sashiko in:
> https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260318175808.582009-1-irogers@google.com/
>
> v6: Sashiko noted that target wasn't fully set up when creating the
>     default evlist in `perf top`, so move it earlier. Fix const char*
>     casting issues in __parse_callchain_report_opt. Make '-g' not
>     override the .perfconfig setting again.
> https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260317175642.161647-1-irogers@google.com/
>
> v5: Fix the value for the top option to match that of record. Tidy the
>     callchain parsing option callbacks. Based on AI review feedback:
> https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.c=
om
> https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com/
>
> v4: Changing the callchain parameter at configuration time means other
>     options aren't set the same as they would for `--call-graph
>     dwarf`, for example the stack size. Switch to setting the
>     callchain option on s390 to parameter parse time. For '-g' use
>     '--call-graph dwarf' for s390. Other --call-graph options are
>     parsed as normal, but a warning is generated when setting
>     `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
>     when there is only 1 event in the evlist.
> https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/
>
> v3: Incorporate feedback about event and callchain behavior for s390:
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
> https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/
>
> v2: try exclude_callchain_user for s390 rather than fully disabling
>     the callchain. Fix a missed clearing of is_pmu_core if the
>     software event fallback.
> https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
>
> v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.=
com/
>
> Ian Rogers (5):
>   perf evsel: Improve falling back from cycles
>   perf target: Constify simple check functions
>   perf evsel: Constify option arguments to config functions
>   perf callchain: Refactor callchain option parsing
>   perf evlist: Improve default event for s390
>
>  tools/perf/builtin-record.c      | 81 ++++++++++----------------------
>  tools/perf/builtin-top.c         | 46 +++++++++++-------
>  tools/perf/builtin-trace.c       |  9 +++-
>  tools/perf/tests/event_update.c  |  4 +-
>  tools/perf/tests/expand-cgroup.c |  4 +-
>  tools/perf/tests/perf-record.c   |  7 ++-
>  tools/perf/tests/topology.c      |  4 +-
>  tools/perf/util/callchain.c      | 73 +++++++++++++++++++++++-----
>  tools/perf/util/callchain.h      | 12 ++---
>  tools/perf/util/evlist.c         | 32 ++++++++-----
>  tools/perf/util/evlist.h         |  2 +-
>  tools/perf/util/evsel.c          | 70 +++++++++++++++++----------
>  tools/perf/util/evsel.h          | 10 ++--
>  tools/perf/util/target.h         | 12 ++---
>  14 files changed, 219 insertions(+), 147 deletions(-)
>
> --
> 2.53.0.851.ga537e3e6e9-goog
>
