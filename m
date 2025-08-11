Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38421C160;
	Mon, 11 Aug 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936865; cv=none; b=qnOdHf6IOZeq6LhUKZq/P7N5V5cI4z2WnLfuwE4bHiafXO/SJZAJ66/yhjTiiw18rrxW4vGDMk6t0tskWytzREqC0m5km/9r5J3Hm2CgrQtRHig5ecjDX8ETZ0LhNYT4LMC93ZjmB9UFl2+ecLcqoGnu6eBd1FlpaeaseMKFoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936865; c=relaxed/simple;
	bh=Uem05OPqqRcTueaZKqOm5X0mvYPisWsdgByf0rFilY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnc6mJcF78TTdhFwo23rkatsybBcvxf79BfqgpaswpZdqaiszB+fnRBUlnkXT7J8XSDZE6yZXmEtV1VTQDsL4Zse3FPTuxy1jCwXCSzkXf0oJGF7jyW94f+ZGU4+FozGB8CwWbvvecNAalVMmutmCS+u4EDCxc5c9CcxZgsxKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoSfNRy/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoSfNRy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936864; x=1786472864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uem05OPqqRcTueaZKqOm5X0mvYPisWsdgByf0rFilY4=;
  b=SoSfNRy//NTQbWJyV4cNj3/tAveN+fcvaZ9Hf4BEPEicmFrew9cuyFbB
   8aWj7oLXH+vVNR5cSTlXdhn2X9DO0Ci0T0s/naN5RH6Qastn2pDiRpxcj
   /rt1Dc6CKrWqkMwZE8aEMx9FiKaUOjGs5mQ/w++TiLzTLcnzE/MTj3ZxL
   4HxeeWBBj3msjivR6OlOf/TbzoAyl04Z0u7FkxnjALmx9CkhLRv/hKmWY
   wauEffJCwMmUo/qLcFHIjo3yqTB1DMLPy/6TQWHzqJUfqgERXW9b90Jgg
   ZR9BxseJCcGRBXoB64IfCFQhLf58tmwrA2tOFh3h41ckvkvwM5Lypn3Df
   w==;
X-CSE-ConnectionGUID: xzWdPOTMRze5h4GlwR9LAA==
X-CSE-MsgGUID: eNtMGWaYS1GJz7SHZoK3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57279830"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57279830"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:27:44 -0700
X-CSE-ConnectionGUID: GHFwvyOKQnuOlpTcv+/xeA==
X-CSE-MsgGUID: 1JQeJa6fSo6JlEu+sksadQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="189658378"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa002.fm.intel.com with ESMTP; 11 Aug 2025 11:27:42 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH] perf: Fix the POLL_HUP delivery breakage
Date: Mon, 11 Aug 2025 11:26:44 -0700
Message-Id: <20250811182644.1305952-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The event_limit can be set by the PERF_EVENT_IOC_REFRESH to limit the
number of events. When the event_limit reaches 0, the POLL_HUP signal
should be sent. But it's missed.

The corresponding counter should be stopped when the event_limit reaches
0. It was implemented in the ARCH-specific code. However, since the
commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"), all
the ARCH-specific code has been moved to the generic code. The code to
handle the event_limit was lost.

Add the event->pmu->stop(event, 0); back.

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Closes: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com/
Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd8cf3c7fb7a..ec19c456b66d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10378,6 +10378,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		ret = 1;
 		event->pending_kill = POLL_HUP;
 		perf_event_disable_inatomic(event);
+		event->pmu->stop(event, 0);
 	}
 
 	if (event->attr.sigtrap) {
-- 
2.38.1

