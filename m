Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B35281538;
	Tue, 20 May 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765040; cv=none; b=gmAeJ9ifM/uEF8r/E/yPK/u1z/2Qnhb8qFunTDIgcgKWZ8EHucjQLXLsrSwNzo5dOyBQDAn8xY41CVelrc8RM7efqa00tvmEOiEQ7YTDoYMRrtGtNSr7WV9eqRXV9ZDXJdaQHSJZafBGdHgRkgY1P9Yo3Pim94CUYWc9nobF+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765040; c=relaxed/simple;
	bh=JYonQVJrRjxKJDpe7nXWSwniUE7wi5IkJhEj5Hcl77E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGSP4PH97TyPuCiIsyeasYCG6hYVT433b5xShuLrWYgFRL86AIosMPcqP8aZYWRGfnbpAliSDSI8pxYF/z7IOYHzsIpUkTet/wbNDV1OBtEUfISOWkr7pULjvkFFSyS7YSgdO5oLLT7fGag7LgeYFtjRZc+Gsyvg7dR9p9Xu9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5Fpuxck; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5Fpuxck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765039; x=1779301039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYonQVJrRjxKJDpe7nXWSwniUE7wi5IkJhEj5Hcl77E=;
  b=c5Fpuxckm9qxt4ljKobP0rWto+JGH4dC5N/2NVC/7ZhFAsmr/bX0vpDI
   sNK56JIrfg5w/9PQjYmb+4AS4RRi+apuoT6TogayEIvfv1OCmhCbwrMXg
   Vq8I3ut72nBDbo9/nclOK9uCyLFI4DbDuOl9Ta0wMCNqvANALxlAE6LWN
   xvbHKa3GMRGu7zKrsjgLWuG+v4GCn1cMWneUm+kLYd3080Et+4jX1sZzT
   A/tPe5ieTj4Lp4m2PRYDdnqByYfpqn9XZsnCJD1DPX5hnAqTc4IJ6LqX0
   DBwLSyLNcW+niJtgBEG6BEV3tunf+PzWn1/LWXVTWU0mee956iDna9TtR
   A==;
X-CSE-ConnectionGUID: 5ecEAgWFRum45LOX8CNUbA==
X-CSE-MsgGUID: VMr36PTHT56CQCALSnXD1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847993"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847993"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: z2iBAAvTQQ6sHMnRBlwfbg==
X-CSE-MsgGUID: +jvUbKMnRLGCJOj+xpoImg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514712"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH V4 07/16] s390/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:35 -0700
Message-Id: <20250520181644.2673067-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/perf_cpum_cf.c | 2 --
 arch/s390/kernel/perf_cpum_sf.c | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index e657fad7e376..6a262e198e35 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
-	if (overflow)
-		event->pmu->stop(event, 0);
 
 	perf_event_update_userpage(event);
 	return overflow;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index ad22799d8a7d..91469401f2c9 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
 	overflow = 0;
 	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
-	if (perf_event_overflow(event, &data, &regs)) {
-		overflow = 1;
-		event->pmu->stop(event, 0);
-	}
+	overflow = perf_event_overflow(event, &data, &regs);
 	perf_event_update_userpage(event);
 out:
 	return overflow;
-- 
2.38.1

