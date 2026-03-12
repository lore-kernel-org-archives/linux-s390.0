Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAA238D54
	for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296194; cv=none; b=hLBnSNFIH/Vt3gUgSyCWx3GBXKQyoKdjr29HRc864uXTopnnVcBzsGEKcahd6qNRVmaCLbjg7VeTQtsGkeT4CtsBOL8c93l4UVgrHPqlTGkMR+ZU6Qj53HPkiOYOOVP1C4ADLUKI7ZlrRg2LL9wmJ1imdTA1g4tA/PaJspVboNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296194; c=relaxed/simple;
	bh=ESo8adYL6QabyJApQ4LPsfXjKpfgqwShaS5GxF/euyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LRNgPWt3aEwyF2gbd9+SHPPvfFAZUL9MkMvyqx+2ycduWVnke+g/AljEDsLUQD6jPs9uMRhZjfP19pLbFSycuBGlwMINR90FhecX5s+vuypID1fjUeMKpDW8PzwCGOzt6ycurFWRFqoDQb5zJrmEurJvZ/tpoepo3k58Y5cy8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tyukg6GC; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tyukg6GC"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be21146933so977519eec.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2026 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773296192; x=1773900992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ER74iEy8gUVJnZ6jeSlc8bWwSBKIum0sBcnkXAXKwV4=;
        b=Tyukg6GC85AfO5gvLo7oatYgHryFBWK4F9SldL4OgJk9veS5TdZGOgIdAoegSipM2U
         MsU27XilwdN2xtBmWqc3i9kFgWnI8Y98inG4a3Wz5zpek723D5kO+GEHrPBCCpfofuex
         L5dCXDcpUxcgI9UvDa3tTPMGjdcpvoXGwQkbPZ0QGVSAnPtJC1pvGZCn19ZcEpeXkyyS
         AuQdN7RGGfFvorAVqaF/eHg6fmNqK11hkflysPVgtYfBMnyCO84dNMPNwQ4ubRpBQ1Wv
         z/022vtBFyHp/HQWceIuelUZD7Ai2bb0/yrK8jd7MJTyDlC7BHxY1z0gDso/9293n+ju
         1aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296192; x=1773900992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER74iEy8gUVJnZ6jeSlc8bWwSBKIum0sBcnkXAXKwV4=;
        b=nHq08WnvFhJYDvPJ9MbV3oRLMFwA/pKj9d8mTpXg34T9LhxnHS4b3eYwFh0owklS4s
         Z/MzbNZgG3/kIvmHj2xXl9sObaogpqJ8o+HYC2pwniYDj4PXlKQrTmV8YrdHFrAx2frH
         rDLit3tlAjlu6wY60Mrkn0G6ADjnSoMt8t5CzFQ+zUR56XYjGjARfN37N9JrLSCTNmlF
         jkAhA1XW9Wv8gjc62RGSU58k7flIRe/niFR+VsE9/aXFFvZajJ1+Ssqek5+gvX1JK8mD
         XAxoEgOnJh6YdYc1zgwzNAlWxaIZlL/bKuuUNJ9QeZfV9tzpUqxTS1QqFG/UVaWbL42e
         +sLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXweE08xLmJyoDaClOsDCLR0BEn25ebPXDXGZoomaP2CQxyhO4fZWuPUEjGE44jN/cVrZczk1J18PGl@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnfHPs4XLnzLW7i+Uc+yAtWJsJN6dECLH82pcPo8sFp6VTtRD
	XXcrQr750FLW8R+KpsGgCLmhXJlXZFZ/Oto7QBpUYuOFF61LQGcedwQDsM5t9SX3qe/DK2kirpQ
	mBpDiDtOxQQ==
X-Received: from dycnr22-n1.prod.google.com ([2002:a05:7300:e9d6:10b0:2be:73ec:b506])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5784:b0:2ba:6fbb:5e7f
 with SMTP id 5a478bee46e88-2be8a52f0bcmr2052812eec.35.1773296191280; Wed, 11
 Mar 2026 23:16:31 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:16:26 -0700
In-Reply-To: <20260312031928.1494864-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312031928.1494864-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312061628.1593105-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf evsel fallback changes
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

v2: try exclude_callchain_user for s390 rather than fully disabling
    the callchain. Fix a missed clearing of is_pmu_core if the
    software event fallback.

v1: https://lore.kernel.org/lkml/20260312031928.1494864-1-irogers@google.com/

Ian Rogers (2):
  perf evsel: Improve falling back from cycles
  perf evsel: Don't configure framepointer callchains on s390

 tools/perf/util/evsel.c | 51 ++++++++++++++++++++++++++++++-----------
 tools/perf/util/evsel.h |  2 ++
 2 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.53.0.851.ga537e3e6e9-goog

