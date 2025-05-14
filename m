Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA0283FFA;
	Wed, 14 May 2025 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235690; cv=none; b=igpA87xSGX5n2q5hPIChZ6PU8UMtJNCvbvq8aLOVKV02Vs7AIWlc9iKsqcdPcgA1k2UKURru7oePDHquHu/P57kXKrFv9pgEMQHp0ejBePiI6eUpX8mXrdIXeKLZDm/ayOZOsNbnEECIW7ywkTdLwYB/bkLvG9owwggnyGiN1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235690; c=relaxed/simple;
	bh=L2nENQRMXr7cm7P8wvgZXQuelIQ1McOEGuf1n8wrLNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M24STAt0c0bsjwjPiBYA6QdrjkILkkTMfLUZGEM1Ft7dAEdfZIs3aS29Y/M/tzLsU3d+CGXaAODAvOWaQ0UKkPZf6IW8y2SD8T4PyE9hnCnTVs0pa8GRqHJ7pfovBZAdw3HvIQ9jXKPDqgmQkHKBz1pJE9NhZW13Ue4syPSd6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwUfkSAi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwUfkSAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235688; x=1778771688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2nENQRMXr7cm7P8wvgZXQuelIQ1McOEGuf1n8wrLNc=;
  b=VwUfkSAiNWGNLDIyIFrgNr1Tfe0KLo2Q8+9linaeff38XkWtNjDbjL76
   Z4m02f947RrfL0egx7x8PFJbbztPLu9WT99CfKwjPrgUqU8rKR/UDnsew
   C9dkwW1eyl67qPDRjxBoJw5BI+5ZWg08zQgGkRgTBG11ChIeY58ME3xBf
   E3BydHVcm+onYRqfnQrzDXeVOKawbapR6Tgu8X5rjx9ZKals4zgCVwVCv
   nGyD+yo6HfBRyyujUwtTka7SLwu4phXStAyT6SWe5jPikuRXMgMZxtIyj
   Usm9ICWDfqzFS73YUUY6bXJLhRe52omw4MtGtzKW6jDDMlXh/rXSTGOk7
   w==;
X-CSE-ConnectionGUID: 9aPlbFMYTM6iOgWY1XYODw==
X-CSE-MsgGUID: busp4fLUStieOAFn3xRHOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072744"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072744"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:45 -0700
X-CSE-ConnectionGUID: j1d1npWEQYK184NLh4CAxQ==
X-CSE-MsgGUID: gYZgcIb6QBuZVSdGR/Edug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939167"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:45 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 06/15] s390/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:52 -0700
Message-Id: <20250514151401.2547932-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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

