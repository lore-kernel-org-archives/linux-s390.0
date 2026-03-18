Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA29344DB0
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856703; cv=none; b=NQoebatS8aCvhbmHvZZbk9DrTdylPLaEueAol+Znm/ne9ICmYNVgutiGezY4BoKtEAa4qgux7OCgDjeSJrOcVyzJD8GYDZeIWLfr8wHCRVCcj5dDJXW3MFswxgXF2uUeDJYVg387kMATBxuMLpbbJyCIo12j3I1h4eM7qU44lTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856703; c=relaxed/simple;
	bh=ZpK6CKJsDbOnPAg3YXsq7tgG2zZrtxpd2sZAgYLnyGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmoiYKmoUpVYu9uqzXIvDK70pYIz0cXhOGRyWC1XaMrn9BR1HCXZcvnbGcBCEcCRD3Yino4UaBr4Zv+7UKQ0fi5lGjgWhIATALOdTnJ9/dJs4WjYcVks3z0kAYdy59UWXYZjPyyf/sU69ZwVBmBFr392x5wu7YUkQFtYbIYz72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUa5UbaX; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUa5UbaX"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so3091235eec.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856700; x=1774461500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AnGKLblK8uax2PBs5wFUtXw6nKJjj+Co6nxChtXrT3s=;
        b=QUa5UbaXoaJF8kb03VsrpYV5WhgWp367c+qXyPKKeCF40p6u/KaR9eWfWqr0OI9XBL
         7jHM4qjibv/hgPS2MOcrAQEv2bt9gfYlyDGJ5dXmzUfMO4okzqYWm65QloA8BKbexCul
         ZKwl5UGKTIgnRGxI4hObwRcc6zxLtpfAH4d2+Fs71oBCs1i7NjaNLCmY6qXXuC1Kk5LZ
         urTbIHDaARSBlMZ2G9zjxPXFgy/LjJlXHxLLgNg66aM9cBvpJDrYalscMGa+OweXbNRX
         ALqM+GI/JZegIYdJbqPVqKTtBI1qnwG8Kha0sSQ+BrO7ynKCVgerRZ3S7OyS1txy8cXU
         pHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856700; x=1774461500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnGKLblK8uax2PBs5wFUtXw6nKJjj+Co6nxChtXrT3s=;
        b=iLpTo4/vZHvXWOkUHPitTPObpfWIXhxZeqBf51jXw1HPlocbph6boGA3XkVUHnIq5r
         OhBkf3hmPPS+4mt4ub55eRstM4jhNRVN8IcK9q4mucmHqAnIdgoD6XcsCFWj2yI28tst
         b3a/9RmIn2SRUY8gwQssuMvCLW1L0kR6a0REl7rYptqscSW4Nfvp0oBJIoJFcBKSHj8M
         iCBq1Xk/rC5g6+UcqL1ox0nC7/Qr9T1z501hqpYOVMCCDlmyEhd8S0NE6xqMyw9RNprI
         URu2qO+/6g29Ly79ZZXVwx3Aqytkqi6EtPsAZerSsvEFQpfV56HsQTIpQwyaYdrtpdaw
         Xt8g==
X-Forwarded-Encrypted: i=1; AJvYcCXXrRzxnlzbJ2S20xo7wuFDgf0F7T+5wFLOPJf0ElRsuKz5hlS0QYl9g4KJ5116y3Xn73ePuss/ebzK@vger.kernel.org
X-Gm-Message-State: AOJu0YwzoRJwze5Ja8YbZNaDpH0vHcM+vxpNgXRcqXd0tdeeQkXtGZLF
	tDWJ92o6SaCR/k2NzwIGjPqo6wCCthJgbf0GSlANARAQ1Wpf6m/PusdDeGq6623hBCZT+6JM92p
	qkf+Zk1Tyfg==
X-Received: from dyblf40.prod.google.com ([2002:a05:7301:a28:b0:2c0:e2b8:48ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7492:b0:2be:37d:3d6d
 with SMTP id 5a478bee46e88-2c0e5129247mr2208859eec.32.1773856699779; Wed, 18
 Mar 2026 10:58:19 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:03 -0700
In-Reply-To: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-1-irogers@google.com>
Subject: [PATCH v7 0/5] perf evsel fallback changes, better s390 defaults
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

v7: In perf top, move the target uid handling back to after the evlist
    is setup. A regression caught by Sashiko in:
https://sashiko.dev/#/patchset/20260317175642.161647-1-irogers%40google.com

v6: Sashiko noted that target wasn't fully set up when creating the
    default evlist in `perf top`, so move it earlier. Fix const char*
    casting issues in __parse_callchain_report_opt. Make '-g' not
    override the .perfconfig setting again.
https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.com
https://lore.kernel.org/lkml/20260317175642.161647-1-irogers@google.com/

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
 tools/perf/builtin-top.c         | 41 ++++++++++--------
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
 14 files changed, 204 insertions(+), 142 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

