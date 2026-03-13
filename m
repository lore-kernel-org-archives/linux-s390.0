Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66D38737E
	for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433698; cv=none; b=moHnDRbE/8ZIj0iwJGkoYPzp20EU9f4/cpquSKJEw8O5Ro5gKBKmczjkdMp1PcRGN1gRihxKceGr4fE2TL8e/XgatgJcCRKoRaBWBmuWNcJLXygtPx6NpuPr5Gs5pU19HpT7pW0K5gG1aP13yCaDj3JvrpLJwuMbiLoMT6ObXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433698; c=relaxed/simple;
	bh=p0QB7i1kkAORLugI2W2DNBp99Qe0z0Gl8n2InIrqxlg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvQPycNm3jUceFwNgmOp2+/w0708eW+kAqjwd45fPdFXx6beeo3fYVn64Pq1BPk0bCiulok3+Y/56PYnvkaA4AHUBqNR0Y26KozP5VWkk38WB+UMWM8eMTizdCoYQJccrScZYJULogDdPBm+LNfF7CuZ6GTAnoAW+mJvXu0GcLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdwK7iBw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdwK7iBw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so3727644c88.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Mar 2026 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773433697; x=1774038497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OqHPl8FyipN3HV3Er9nUjJNDHkPYXhVyA/wImOLSdw=;
        b=bdwK7iBwkasF+H1ybcsiHHWjT6LXb0WKYMWPB2AIM7vSonfdCL/LvIt/ad9qhz1S5l
         cJYfKjuWmeTArJ2HbhUFDU8jgwI5kv+mhCISb/f5JQV5DePs5jzu5NCAFRwKbCyEgnsm
         obeDBAwi3aQCms+EtTgm5uTTE6hwwmacWuU6dKxdn34SjTAyE5FqnKgVMN8WKkDWiY1O
         bU6e6XG2esKNWtZX+3CS7OAehatCvA9krBjxG2gnp6wotlzUpuZ6MgAfTwWBeCPJBHVT
         E/caBC12a9cTE9lHKtJY7Ug+Lm/3p4UJRGK7d2eop+Fnw9AojQuBcmDIZDwrwmA+SdTN
         hR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433697; x=1774038497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OqHPl8FyipN3HV3Er9nUjJNDHkPYXhVyA/wImOLSdw=;
        b=fT/QUzT5FaYiFZ88eReN5i7XXVzm2KtPvpxR8PRZos3cUSZ4CSgmQ60i8m/CvPyRaj
         KGEFGyG9W8bXe0e9mcfrSEvDnQ+gwccUXPB+zu0cjHt9BQcc4uH5xtHrvuQ9c/eusXjF
         g35iKzaxDc0Ig4VVyJQxp6HTNsbYmtOROgJKmZuSJXhk/YA83kr4lcVAcHfj3gAu2Y5D
         b92ogz0peRnz/7SCs55krHSpahaHbkcU8sGOqKTy0TLart8QCWCSuN9HgEODMSaByqTY
         +tuNLmCKC0y/E1AYfsljHGVMyLSbUnsQCGLoVEbMz0GB/HfJtoTauoEUfkbxPiXOSV9T
         jLWg==
X-Forwarded-Encrypted: i=1; AJvYcCXl+YL2JR+CY/amiRcQzMFL6Omqsh/60+5iDroif03cqVinzgbMYdUsQAkDqi9LfHkpxfW8bdJHM9F+@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7064z/yLhr2VBSYNPYvRxE6pwidHEA2djVmHTjZIXVLUJOBh
	H77iI0hzcpO0zLJo9oRwHx6WMM9YVRigkW0R0aK8fkrjszK2iMH7ojtcKDybCfDFk2cOXGtOIUO
	8de+dMHpFhA==
X-Received: from dlbvv17.prod.google.com ([2002:a05:7022:5f11:b0:128:d41f:2c06])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:43a9:b0:128:cf86:d1e5
 with SMTP id a92af1059eb24-128f3d36670mr2319296c88.16.1773433696351; Fri, 13
 Mar 2026 13:28:16 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:28:08 -0700
In-Reply-To: <20260312061628.1593105-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312061628.1593105-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313202811.2599195-1-irogers@google.com>
Subject: [PATCH v3 0/3] perf evsel fallback changes
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

v3: Incorporate feedback about event and callchain behavior for s390:
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.
https://lore.kernel.org/lkml/20260312061628.1593105-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (3):
  perf evsel: Improve falling back from cycles
  perf target: Constify simple check functions
  perf evlist: Improve default event for s390

 tools/perf/builtin-record.c      |  3 +-
 tools/perf/builtin-top.c         |  2 +-
 tools/perf/tests/event_update.c  |  4 ++-
 tools/perf/tests/expand-cgroup.c |  4 ++-
 tools/perf/tests/perf-record.c   |  7 ++--
 tools/perf/tests/topology.c      |  4 ++-
 tools/perf/util/evlist.c         | 37 ++++++++++++---------
 tools/perf/util/evlist.h         |  2 +-
 tools/perf/util/evsel.c          | 56 +++++++++++++++++++++++---------
 tools/perf/util/evsel.h          |  2 ++
 tools/perf/util/target.h         | 12 +++----
 11 files changed, 88 insertions(+), 45 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

