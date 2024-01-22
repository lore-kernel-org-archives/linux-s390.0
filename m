Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA564BA94;
	Mon, 22 Jan 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966370; cv=none; b=Cc+NeFNv8VBd25yYO6nMUdahuzrkQiLasjzL/bEg/nfpIsspS1Jgrpmmc3RbfOYwQQTsBipeY6BQR6GpUO96H9rsd+2kyNaEFeQuWLVxSsg9IOLQVcKcMcpDC2kiWt2mD9ozTRBC7vZQTbLl42LAnVStQOajuJCQMpJORsvC4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966370; c=relaxed/simple;
	bh=wdogNbU04LOAOQXqJeol5FweB9QazmHCRKAJ8Y2dXfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwEO2U65fxQRFW+YYtgoOH1pnDMpX/n/ZYUH2bPDxd9+yIcFmpqqkQ6wFzLaDy/ETZ95S8iwSYpS0MLLm4rdhUI8xIt2YHEHCiU53ye7ucyzZhu4Fkz74UWTEUmRkl/3a/6t4V8fyiCKpY07gPqSDzq+bWeyKdp/UdAcBP5MLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAsQDr9E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAsQDr9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705966369; x=1737502369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wdogNbU04LOAOQXqJeol5FweB9QazmHCRKAJ8Y2dXfM=;
  b=kAsQDr9E18/GFTjXsp8pqQf3EoIAP5voG6vPDRjoCpC23WCDcB7ZfxiF
   ysuYGmW/IkFIeKPoTr8SQ4XpV/aJUAdr3SIYGCAIoZdBuAvhO6m9aJvSL
   7qtDZEMVVlTjrPk7wQ1kjz36UuBgHcqs3Sr8EcaXeIWORUz0rkZnc5WHg
   STJ9BceFxwgydjxwxQ83geU8qQEOYpTWih7eC08utZB5RYWo6vBlEo2ut
   2Mdz+hvucFEs64aujNcGN/ZKC6wMz9xWK7uFRfx4SynIFbtlj4GSxMqpM
   wP/8W1mtA8ETO0Bj+2EE+ljYHV0wJu3Lzq8ffcVXWwlF5SI3MsPnW+e9q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8032170"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8032170"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 15:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1117040507"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1117040507"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jan 2024 15:32:47 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] tick-sched: Preserve number of idle sleeps across CPU hotplug events
Date: Mon, 22 Jan 2024 15:35:34 -0800
Message-Id: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs
CPU hotplug") preserved total idle sleep time and iowait sleeptime
across CPU hotplug events.

In order to derive average sleep time per sleep event, we should also
preserve number of sleeps too in idle_calls and idle_sleeps. Fix that.

Fixes: 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug")
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d2501673028d..01fb50c1b17e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1577,6 +1577,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1585,9 +1586,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 
-- 
2.32.0

