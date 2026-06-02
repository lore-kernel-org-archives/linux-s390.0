Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3043EDE57
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413931; cv=none; b=BBiM6/QWRaw4MqFvOokGHVTMefqfi75hUtEdYBlbbhhXfzBff43gNV+BEajxLG8m3Enmg/VoVdlb5RWMSpkkpf8WnYlhlnD9t3WXx2IU/GwMOcpjD3vn1PIRmj0f+ZvaLufQCo69IY5TF/6wEENnha1kTUks14u0JK/h8pGMJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413931; c=relaxed/simple;
	bh=N60q5hQpJzgcj0gMAcG8lAo3SHZ3TJCXTm5Qt0ml33o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/9Oc9JtSySgv4IR0dHgu5Te/u1mN/v9soNhKmVSa73g//CVFZs9petIzaqezfZdK6QEqkwnZeV0MYvP1I9v89GNP/oBxDdAdnAz9jpFqpC6dBPNVqyCONRBeE08GR1voPiRocUy9aRndE+rnHayUwQmZ+WuXoR+IjDyV81nDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSuV75b/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSuV75b/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137d4309062so9543158c88.0
        for <linux-s390@vger.kernel.org>; Tue, 02 Jun 2026 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413930; x=1781018730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fn3ycVGPkqm/HwQfVKkDuGLWZA0DVIOGZWD1+VZ2w=;
        b=gSuV75b/Gj26Caqgr14V7fPCPCz6vamEemDAnVy176kYqNSxbxuLculdIER3NXZ/RM
         C3LD26z5iUhPUUQE83XSg+XPqxmw4Z4d4Ei55pR8yyU191VsdBBmzEF02FwcrlMMgLSa
         74dOGSG/RTxWpaDnYwRdoPK6fMNZlZ7A6KbpQ6+89i7MfIP0+FZI5AOtE9x2lCPnV2xa
         NpV8fXAdy99GLIacVyv5e5IuosKSmBxFWMC9Sa9YY1QYrYgBR/k8/hwQx0u6pytefqXf
         sIFoIc7xDG+gWiSxpowBa72BYSa9GzwpQDwxaYYidCYzzakrE49QMi9VT1tAKOheiaC7
         zPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413930; x=1781018730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6fn3ycVGPkqm/HwQfVKkDuGLWZA0DVIOGZWD1+VZ2w=;
        b=jMq2SeCJ4ds7NiJB1i61IWaGJA7B4VgaTC+DysXt8uutlVXg8NPn6jgIj00TH7sdYa
         q0tzKPuyPdfbDdAiNnP85dEJL7cK5g/BH509/fhIoxZoFOnJl46dbSGqm8RaA50oIc3L
         pTheID0gvaouoNVOUm5SfoE4RmeO33wkPpeX38JFrKks7CzhXYB09DrUOHrtBFlSn2x9
         dhacU835GLosxe+PHdR1hJ820KdlvE55Pi48rpBzFG0DL/exrmZxjmpQjOinrs4zkuKF
         qnl2aVLGcelgqkZth7OZkt106x7XYRTqSiDGjzJ/HZ4jr66eJkdvUMLzjQ0ZGC+pcgwc
         NqjA==
X-Forwarded-Encrypted: i=1; AFNElJ9CN2GBMxOMUvqrZq5RNrLC1p/R4UdYpnn/nRirXkJEt7evFMecCegWYducHtGY9gENdPlCHb2+xQXn@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0XtG4YLSu11dPkFyFObpcc6s5IjE3xuaVY9FDQ+SW5EGxbGe
	PqQcgnEEEiJH6rVB3TPUsQuHwByfSkyn0YtEncV+KnhotxzAA/RY33D9yoCzT4EdEquGL6TML4a
	E7b9/RCPSGw==
X-Received: from dlbut14.prod.google.com ([2002:a05:7022:7e0e:b0:137:ee55:b187])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:11f:b0:134:d708:1a24
 with SMTP id a92af1059eb24-137d412366amr7692863c88.17.1780413929669; Tue, 02
 Jun 2026 08:25:29 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:24:59 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-3-irogers@google.com>
Subject: [PATCH v12 02/19] perf tests topology: Switch env->arch use to env->e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Some arch string comparisons weren't normalized. Avoid potential
issues with normalized names vs uname values by swtiching to using the
e_machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index f54502ebef4b..bd7b859dea66 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -11,6 +11,7 @@
 #include "pmus.h"
 #include "target.h"
 #include <linux/err.h>
+#include "dwarf-regs.h"
 
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
2.54.0.929.g9b7fa37559-goog

