Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684C27FB09;
	Fri, 16 May 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420166; cv=none; b=Vsmdzlm5FKwAnHcEGbIsQWjIQaFOziNFomMLSvcX5fw5pC2oFdlx7K+F5hZfuOJJHM4+/bFj3IgIoF9bbgturi+gP8Lo5mW6HjRK3Koo9rS4M+q8IZTvhlJmsqRoHmn/EsMdvENTJtmO70Nn7VXKD3P2zU3c2eraJLNF7uPqACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420166; c=relaxed/simple;
	bh=JYonQVJrRjxKJDpe7nXWSwniUE7wi5IkJhEj5Hcl77E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbbwXY5vuYUvyUSLOv7Q7J1xTo01/2aBQN6zeIPaKNMiO5ihluQRpuf8XlxQ0drVbtiK6piKlCqn4N7EgpG1PVoUxLy3h3Pm3/+PiCsTuXqdgqrMjAeBw+ore+zqRu4OAfqn7UT/RKY32JqKHict8tbZY9yGmpNdCLhTi6RmG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJCWZ5Cc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJCWZ5Cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420165; x=1778956165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYonQVJrRjxKJDpe7nXWSwniUE7wi5IkJhEj5Hcl77E=;
  b=LJCWZ5CcO8CA0o8AuwueA35xewanGVCnCJtgrvE1+P7jOrrvrgaTkTwz
   TzWT8NTbfCKQbCAiUFfag0PC4SnNKIyyQ2FT9g2wKCaUo1pQdAj616f6i
   lvc6cfUrUbK7vah58KUvTBhOZ03owS+YpwmTgwUJAp9shJakdEyXwFJGn
   1zYs3Kn7+EyOHqGLPsfieGyxnG4z3XAB/naXE9L7CfF7yYQqtnQbKLtnF
   NCVJS+aF0zU89aAGvGID3hbNteDxHltFZ4B91mtvusP9uH1PLKlUeNtox
   cH3dtUNRfp98AwGtV7Vqcw/qLt6eH1Qyg6pUFT46jzmj2WEH//s0febNf
   Q==;
X-CSE-ConnectionGUID: fcoy2zGISzig+w8RjM7KdQ==
X-CSE-MsgGUID: XHELI8iKRPeECbd6OPH2bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328842"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328842"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:22 -0700
X-CSE-ConnectionGUID: 4V+UjDLzRzCpwocAtIrbrA==
X-CSE-MsgGUID: BNyDIG5iTf+vs6e7Kc/TgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802612"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:22 -0700
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
Subject: [PATCH V3 07/16] s390/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:44 -0700
Message-Id: <20250516182853.2610284-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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

