Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059C31F99D
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770208; cv=none; b=uMVtYfMcsD62WPT81NbA19pu7gugj+dewD7SCrB7llWg9iINL1FhEnxEHJEdMgSkarXU0RPk+2pQ9ClaXPo2UFZn2QqI7n+F0eds3DnqHfD6F6cDX4TX1+3iXrPP7ft23qm8MsLW0dJP8yEUVxgZj3dRfhAVspeRG8D/Ssnj4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770208; c=relaxed/simple;
	bh=lll7u5DrNtcg/YdndABUidkrE67JvweNfzcMTbj89Do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ibb7mwDfbNaVzJ+oockwDNPkCifE0eDYMSAJv7ei6pCOzDpWRrJIEdgTQUzlriVyy5d+MNA7NrOLInpnSFQOCoFGc2dUyelspC3C3AKbCae+1bZ5ACZkbdpKKS9Idn1k2hFoCyld1aY66oNEUh3NN/AB1YaSYRDAZAiANeE5TLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnq4/rPt; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnq4/rPt"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so92237837eec.1
        for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773770206; x=1774375006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzJFV04EmgPhGub4lZGa06u91dxd4UVK6+R2L5Q990M=;
        b=jnq4/rPtd9N3tkUM5vOKxwEXsONROsLMpMMzLCU2eD0IudHPZzWNLW0hRkvONgGf4v
         Tq7npxe28B/zdvgyf8xMeKsiLjsdqR/IdO8yhgbENrebYbTh28C0efkYR6yvBfO9+Qu6
         ePPH5/hlT4Qai7OwUQhxcaV9lfhLM0zAj4IgJBFb7RE3bqlUpIIgszYuRAX/eHjp1dpI
         IyZUA8BPyy4AmKiJivn9k6ufL8PXFuyYMOlHed60+1gvl5QdDVaYUNnYVUuvT3qJs41V
         hxAiBBuQONpS1dksUGIJ23GkIdcZk+nz6Oq+nPHFriNHiSD/vt2pMuMu6FhMaai9r4/t
         qOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770206; x=1774375006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzJFV04EmgPhGub4lZGa06u91dxd4UVK6+R2L5Q990M=;
        b=fejok62MVywF///+6kz3xQGcMgq4BqQg6dOKE7srsFDDXnWeemgUK7w6kCOKgOHhRV
         CNUQuEpwDgJ7AvbLsKpnjboCp5QAB1W7B2uYWIWZuLaYsZxypggyrA6tqpP9SVCgT7fO
         6WpLZ2ufPvwBtzBucFO0buyq2o5mXMRXkUx40UouhUJEjyz3XYPiplUTOyW1drS3XASH
         9/wrgKwHRYc6Z59x45G38AN7hBZwaYlIr/HJK1wkCjrwXWA1UmQGDGylv+V5xXS/fPbz
         Cl1NEW8E+Xn5xEtDuPGpjanh/hvPH9DSmLee2efwaYc/ZxsySKQ0tsHED9lIuXFDT1CR
         SrwA==
X-Forwarded-Encrypted: i=1; AJvYcCVLpJDUZebOcKtAGKX7f8//VqGegRrrD3uYKtUNYbayeTnMh02w2/zhAdhcX33vq38/LBlf9UYzew5F@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPKLtGisFGVIWAtf60scVb0MOcxzihkNKoRsdo2eaTKo34xkU
	+6/iFrazkXaPX+7iUIscDLQCLHMWzaSnVLi1A/+Fydrz+ev9IALMlcDSkSb/q0F24cN2QmDSeAd
	MfUMFcqQyZQ==
X-Received: from dyox34.prod.google.com ([2002:a05:7300:7fa2:b0:2be:268e:f502])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9f06:b0:2be:6f30:f317
 with SMTP id 5a478bee46e88-2c0e512bc6amr149054eec.34.1773770205925; Tue, 17
 Mar 2026 10:56:45 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:56:37 -0700
In-Reply-To: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317175642.161647-1-irogers@google.com>
Subject: [PATCH v6 0/5] perf evsel fallback changes, better s390 defaults
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Discussion with Thomas Richter in:
https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
showed that the evsel__fallback wasn't working for s390. These patches
avoid the problematic frame pointer callchain on s390 and fix
evsel__fallback from a range of problems when falling back to a
software event. I simulated failures when developing the patches but
they are untested other than that.

v6: Sashiko noted that target wasn't fully set up when creating the
    default evlist in `perf top`, so move it earlier. Fix const char*
    casting issues in __parse_callchain_report_opt. Make '-g' not
    override the .perfconfig setting again.
https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.com

v5: Fix the value for the top option to match that of record. Tidy the
    callchain parsing option callbacks. Based on AI review feedback:
https://sashiko.dev/#/patchset/20260317030601.567422-1-irogers%40google.com
https://lore.kernel.org/lkml/20260317055334.760347-1-irogers@google.com/

v4: Changing the callchain parameter at configuration time means other
    options aren't set the same as they would for `--call-graph
    dwarf`, for example the stack size. Switch to setting the
    callchain option on s390 to parameter parse time. For '-g' use
    '--call-graph dwarf' for s390. Other --call-graph options are
    parsed as normal, but a warning is generated when setting
    `--call-graph fp` for s390. Also fix that sample IDs aren't wanted
    when there is only 1 event in the evlist.
https://lore.kernel.org/lkml/20260317030601.567422-1-irogers@google.com/

v3: Incorporate feedback about event and callchain behavior for s390:
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/
https://lore.kernel.org/lkml/20260313202811.2599195-1-irogers@google.com/

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (5):
  perf evsel: Improve falling back from cycles
  perf target: Constify simple check functions
  perf evsel: Constify option arguments to config functions
  perf callchain: Refactor callchain option parsing
  perf evlist: Improve default event for s390

 tools/perf/builtin-record.c      | 66 +++++++----------------------
 tools/perf/builtin-top.c         | 67 ++++++++++++++++-------------
 tools/perf/builtin-trace.c       |  9 +++-
 tools/perf/tests/event_update.c  |  4 +-
 tools/perf/tests/expand-cgroup.c |  4 +-
 tools/perf/tests/perf-record.c   |  7 ++-
 tools/perf/tests/topology.c      |  4 +-
 tools/perf/util/callchain.c      | 73 ++++++++++++++++++++++++++------
 tools/perf/util/callchain.h      | 12 ++----
 tools/perf/util/evlist.c         | 32 +++++++++-----
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 70 +++++++++++++++++++-----------
 tools/perf/util/evsel.h          | 10 +++--
 tools/perf/util/target.h         | 12 +++---
 14 files changed, 217 insertions(+), 155 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

