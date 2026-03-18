Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379C3E0C6E
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851361; cv=pass; b=fDNGx9Bt7VX5eG40PIJIkLHTNUBnS62Fn2pkGta4le8HBqLQLw1pjQkRo+dkWpF7KpLhZwNYyFcoesNCP1EOC0hznP/8um/sTM+O5ryajD/6eOZqZ/E1Kr0DfMT0ATtn9NQ20OpmUqj+8r3GhtLQQd01UJV0YHg3xm8I/4DDQgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851361; c=relaxed/simple;
	bh=CGgxIxmXNw55BQSjzk0SdpCcRauEqFfgu6PDtbvAlT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFMtg4bTeKI50+6LWRqE6HcZeKizRkj+bZl6HEXzfMdKfWvS74dBEVqACyC/uxdWTbao167reQcjJ+4QBw8QbotKQ6ConPHndjcgL0tXvnDLHlmxCGrWlBKCenJr4yzrV099Q467Xk4ePvjgqNB6RAMdVO8cHf0m4s0oLhrt6dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNaigJFT; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNaigJFT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so106935ad.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773851356; cv=none;
        d=google.com; s=arc-20240605;
        b=QHqTXVYmq8rk3o3VvA4CCrbNX/Db5HFaRoTSTSkJi1R5klw4Sl9GE2MB++sC61rIen
         Z/9dr8R84rvKsc6MDAQT2cxfj1F6BeFV0swv7j53ukvjZodyNIcotNPzJxBB08RY/cVE
         0iue6BHD3aeBKGJgqoRnalC3Z2LyhcQDUi+bvwzluOY2S3Jh7VBXupeysfKFtQ6eOtQQ
         lUImSdgBpSlacgFQ4F9Lyq9FtGnT+AawcBk+YwOLFJMGcATWDsxmAcdWbZSp+AdvdBcD
         x0Zuro/lmHqakN4TOTgoBdvoX3nqCPUk7npjqsr0XPBXI7ZkFqGCO3tYlWXySLoFktWT
         jL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        fh=pkndsCPpqoS5IpytaUWZ7aWXzrEe0zElfyIaIIWaivE=;
        b=TvuaiDN9vddPffq02KaHzOfFOP+KMTwgQsTwoCeQboajts84auBKHQyP1U1SRuje37
         0UG/OgZxR7MaHQdmT7TLsSoSZs9zNZ9qaXoaAortbut04HFT6T1dCWFZjIS/FY9P2v0I
         Yr66vfjnZsMonyAeHWpTaCVgcUOx3xQUJGyEL3WaSNjYMTuu30SadDYvU/kR6Kjc19mV
         itukUicsJ+i4arY8jE6CO/Pb520XAy6El7cFmtOTLcBXERp9F/AHbYMsvJimQMIamgEU
         DpfcJzRKxmIFJOBaH4+vhptFJbr147nx5hR4HaN4i+HXa2oxGvbfgM+Ccns4iwb4/O7T
         tBHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773851356; x=1774456156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        b=SNaigJFTPn6J/8lUuLSXfYs/ep+YmSz0JEte3M9CkGJgpH5DtQG7V8Z4iIExvUbSvb
         UwPQWSssjOC7CxRTD509TGBQyxFNz0Qs5JvoNlDcsX5qIxAQahKVY3U/a8UqKd0TnrCp
         sj8IwXamAY1T34BI6q+lQLfWZH/AZlEUwjWos4m6C5VwdCNzTjiwLfrqHNFRhTTGx6IG
         J1N+LOg32zC2dGEhG/O3LXcBCRmvFli6/uLECimYut2ymHEXfRJSj+lophC/e6NWjlEQ
         ks/SW6rdNRdF8rhO4UAdVEIE14FOX20875kSsIn1+qOWwAoGC68biVqTeJSEUHjpTJyI
         MKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851356; x=1774456156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcnFhfYoFXBBKtYjtjHUJaJIA0VnBP/0Xwihg0OjT8Y=;
        b=XbgeAJm0Exwojk87EJzKVMQNOfWvqdw7jW6RZwaRSlt/eBTdyOA5XMQpYRoSegXRIP
         DkOKklE+Wa6eDRcwjKV5dAL0yl02pCz64B6xat4jfimE1i6BcH0pFAyYXFQrpqfel0ui
         AtRIpCoae6d+HlsDrCtlxWquakbg6sz/6+Id8gmGvrEMH9DNqpJX/NY9Gh2CX+UiG3DZ
         xF8aHdcoI8SRB5yVMl66WyO5LV0GQZR9Q/1d19yqds1G2mAKifMvzfJeJmJxfp1/ZVdP
         t3/kBzpKzGiMHh1qY2rBwn8OhzAfFApaKFe7OQwv39FeVHvraobzn1vD2EDaY2yoP5pe
         ezbg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZDUrY7NFVgB5Tt6//7DSeYxAoreIj08HRdpHA1qpnyw+ZZGSqLM2uMbVKpP822xONRyDLDn07ehK@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmw7QwPDAbgv4jvbyB3hHbU4th1qANf+zrbJvfgYvrKdDCFGS
	Nb8mxCzwphB8OXLu1Y+hO+disviISzrYrq3ttXdIzyGULpa1kOClXd5SPLC4k0IrkKewW0q/kei
	B80syPpqkEsn9e/UwoA6M11lSGH5J07GK7N0mPQAU
X-Gm-Gg: ATEYQzyQb69GI7l+BLkLhvCTpFXOVzf+m2tZ1tJld8OnDicE8ZjGmVUrCJHqrlIy+sv
	jU9zenCmCnXapec7SFsGxMxOf5LtyXiK51eVz7y6g5ynjwqF7vFdJuG16KCDci1+fedzoRdCjwU
	1AS6miyAHHrmeNXV21zNrBPLAwVI66MtyXx9wMRBQAhN87nuHKKsEGUrUxEEAFYg4QRk68zILC/
	5tcBdp5ITQTP9HeVr8u52c95ZrjqdFI8dXA5XI3Y3vlUusQoDTsOCbomcaq6qvfUzBmB5vHLBn7
	xyzexYLE
X-Received: by 2002:a17:902:cf0f:b0:2b0:5683:1cf with SMTP id
 d9443c01a7336-2b06f851110mr2736005ad.13.1773851355100; Wed, 18 Mar 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
 <20260317175642.161647-1-irogers@google.com> <d2396ba9-1859-49d2-b8de-94e87241a6f2@linux.ibm.com>
In-Reply-To: <d2396ba9-1859-49d2-b8de-94e87241a6f2@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 09:29:03 -0700
X-Gm-Features: AaiRm535Ic6_pS6RQwsVfgPObwsbrDdKOU3_lStKlZ7TQDGaHTJQxbIRI75Sv-g
Message-ID: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] perf evsel fallback changes, better s390 defaults
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/17/26 18:56, Ian Rogers wrote:
> > Discussion with Thomas Richter in:
> > https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm=
.com/
> > showed that the evsel__fallback wasn't working for s390. These patches
> > avoid the problematic frame pointer callchain on s390 and fix
> > evsel__fallback from a range of problems when falling back to a
> > software event. I simulated failures when developing the patches but
> > they are untested other than that.
> >
> > v6: Sashiko noted that target wasn't fully set up when creating the
> >     default evlist in `perf top`, so move it earlier. Fix const char*
> >     casting issues in __parse_callchain_report_opt. Make '-g' not
> >     override the .perfconfig setting again.
> > https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google=
.com
> >
> > v5: Fix the value for the top option to match that of record. Tidy the
> >     callchain parsing option callbacks. Based on AI review feedback:
> > https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google=
.com
> > https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com=
/
> >
> > v4: Changing the callchain parameter at configuration time means other
> >     options aren't set the same as they would for `--call-graph
> >     dwarf`, for example the stack size. Switch to setting the
> >     callchain option on s390 to parameter parse time. For '-g' use
> >     '--call-graph dwarf' for s390. Other --call-graph options are
> >     parsed as normal, but a warning is generated when setting
> >     `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
> >     when there is only 1 event in the evlist.
> > https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com=
/
> >
> > v3: Incorporate feedback about event and callchain behavior for s390:
> > https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.co=
m/
> > https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.co=
m/
> >
> > v2: try exclude_callchain_user for s390 rather than fully disabling
> >     the callchain. Fix a missed clearing of is_pmu_core if the
> >     software event fallback.
> > https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.co=
m/
> >
> > v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@googl=
e.com/
> >
> > Ian Rogers (5):
> >   perf evsel: Improve falling back from cycles
> >   perf target: Constify simple check functions
> >   perf evsel: Constify option arguments to config functions
> >   perf callchain: Refactor callchain option parsing
> >   perf evlist: Improve default event for s390
> >
> >  tools/perf/builtin-record.c      | 66 +++++++----------------------
> >  tools/perf/builtin-top.c         | 67 ++++++++++++++++-------------
> >  tools/perf/builtin-trace.c       |  9 +++-
> >  tools/perf/tests/event_update.c  |  4 +-
> >  tools/perf/tests/expand-cgroup.c |  4 +-
> >  tools/perf/tests/perf-record.c   |  7 ++-
> >  tools/perf/tests/topology.c      |  4 +-
> >  tools/perf/util/callchain.c      | 73 ++++++++++++++++++++++++++------
> >  tools/perf/util/callchain.h      | 12 ++----
> >  tools/perf/util/evlist.c         | 32 +++++++++-----
> >  tools/perf/util/evlist.h         |  2 +-
> >  tools/perf/util/evsel.c          | 70 +++++++++++++++++++-----------
> >  tools/perf/util/evsel.h          | 10 +++--
> >  tools/perf/util/target.h         | 12 +++---
> >  14 files changed, 217 insertions(+), 155 deletions(-)
> >
>
> Ian, thanks a lot. I tested it using the same sequences as for v5.
>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas! There's a Sashiko review that moving the target
initialization for `perf top` will cause issues, I'll do a v7 with
your tags. That change shouldn't impact any testing.
https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.com

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
