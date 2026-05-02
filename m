Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C852FD1AA
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705198; cv=none; b=Jy3ZwAjNB5oCC4rH0jGkoSfp1w+poIraJCx9+PgOEs5mKWCWIXM3ECrFfwqSqlJnQpIGetHAprGCrZ5qvIMu4xH7QEy5o8Uyzj13kpGGq/8MO/2ZQTY/1pkeCQLuN3Pb1rhnXfTr/HNlePkURPRsci1qo8V7bOqws1by7HVInd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705198; c=relaxed/simple;
	bh=dePQroO1x6u4W4p4OjprVA1y6YkSFx4TAjmbutXcF6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VTDGsj4HMsbeu5vLXaQDQu/RYqeQqUi5WlnhONoIU83pXUetBKlWrKYQbTjZx7rcqIeY7iDkxecZOJHPmr36VK4KeYZlpii6VjOMDRvW4Ut4h5bTq9aOeEfOQD13X2t26dDBHNaXuIoI3POW28IenMtqRc9nd6k0pecYdnlaKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThjHX8Xc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThjHX8Xc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c8ccc7593so1694913c88.1
        for <linux-s390@vger.kernel.org>; Fri, 01 May 2026 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705196; x=1778309996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bU3LlfHduMRXriJM/lVN2ewJoBx+eB8b+i1D8BIsU=;
        b=ThjHX8XcL/ZOdnFE9kKFgK219G5okeqhE2DKv5DJyPNrf01543xtqu/WOYsTRi0BQP
         UX6ThB5Xdr2Ki00rYsBuX/E0K/ap+O/O2TX//CsPxZLiLW26dKsAt95TaQ1c76t0vCXd
         osugVWI4/ElyfBYVjr3XBgPNzeuOvU48gnziNDmki8HbYko4HdYcXiygK/IvicJmt5tt
         YMd7/oSt3daP9d8mXRsRbNmFH0xAi5CJI0yMpSaokNTIonsPBmsVc2cDpetZzM+Dx0Sn
         IiJLtcvfLyW/j1ruGYuEenpnqV54goutDRnQWqhYqgBrRmOO8A+LmOCH0hSWX5MNmF0E
         1BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705196; x=1778309996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bU3LlfHduMRXriJM/lVN2ewJoBx+eB8b+i1D8BIsU=;
        b=Ojhz1m3lBL6OQztbx3T/ld5XE/WqfSxDcXv5LNiYbECmsGNm2T88KccUuwd9M6bwY8
         D5N0a2qWTZRoJgwCJYaZRoaxikV4bifkEcNlkbyq+Bq5xuUz9HrpeAoc8epaxPXengSE
         2sghj+Hm2miORQExulXzg+rI0XapWzzsjEwJCtmMInvuCSevJ70bHqn2ufcPQEgLs1xW
         vk/HC8cSnNlfKswGqL7LvzvsRonN6uoCK/gMxoKHzCZ6TwGE6TqT0DmamFyy8x4zy2Dx
         yIZmV03C8el8LDi55IqWpz8bPgk0HzPQ6IMTp8MxJGSXIQtdkoAmcp1ePi1PlAkVAl/R
         CIkg==
X-Forwarded-Encrypted: i=1; AFNElJ89p4cVMunmyA//qyAULtezpsjOw+wHsXL7g9WODTd5be1zWjzRnDssfoUb3SoJG/QMCfj3ulelE6OM@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhIUeeUDVXdOtIUyOUMSKJ9zEpVSWv+ZZXrTLadCNX4K5ct0C
	AnswyYaVcsRPaPyRxURpZKYnMlLnxU3RCWqIH0twKuGv12YVz9pl6+zlRbneaAYsqH1ceKHDRnq
	lGVKJ6sx5zA==
X-Received: from dlea17-n2.prod.google.com ([2002:a05:701b:4211:20b0:12d:b7d3:3e31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:102:b0:12d:de3f:f3e0
 with SMTP id a92af1059eb24-12dfd858799mr978909c88.42.1777705195974; Fri, 01
 May 2026 23:59:55 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:20 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-3-irogers@google.com>
Subject: [PATCH v8 02/17] perf tests topology: Switch env->arch use to env->e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Some arch string comparisons weren't normalized. Avoid potential
issues with normalized names vs uname values by swtiching to using the
e_machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index f54502ebef4b..d4c5c330c679 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -11,6 +11,7 @@
 #include "pmus.h"
 #include "target.h"
 #include <linux/err.h>
+#include <elf.h>
 
 #define TEMPL "/tmp/perf-test-XXXXXX"
 #define DATA_SIZE	10
@@ -74,6 +75,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	struct aggr_cpu_id id;
 	struct perf_cpu cpu;
 	struct perf_env *env;
+	uint16_t e_machine;
 
 	session = perf_session__new(&data, NULL);
 	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
@@ -101,7 +103,9 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 *  condition is true (see do_core_id_test in header.c). So always
 	 *  run this test on those platforms.
 	 */
-	if (!env->cpu && strncmp(env->arch, "s390", 4) && strncmp(env->arch, "aarch64", 7))
+	e_machine = perf_env__e_machine(env, NULL);
+
+	if (!env->cpu && e_machine != EM_S390 && e_machine != EM_AARCH64)
 		return TEST_SKIP;
 
 	/*
@@ -110,7 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	 * physical_package_id will be set to -1. Hence skip this
 	 * test if physical_package_id returns -1 for cpu from perf_cpu_map.
 	 */
-	if (!strncmp(env->arch, "ppc64le", 7)) {
+	if (e_machine == EM_PPC64) {
 		if (cpu__get_socket_id(perf_cpu_map__cpu(map, 0)) == -1)
 			return TEST_SKIP;
 	}
-- 
2.54.0.545.g6539524ca2-goog

