Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6601DED5B
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767779; cv=none; b=tk1XHW0s6GOruMEuDDD+wLnsnLiGMnZMOxqa7gbvXRGiLB3xGg2JkkWC8cDMLS+bP4EcHKxDQ0UrEsdMj/VSinCHQfq2RKZSyBQmBLum1Y0LX39WE6cUVf9VcT5Jz25fhCLQ+9puOV8n83x4pMlz2FoU74GDslv6TTbhiw53rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767779; c=relaxed/simple;
	bh=dePQroO1x6u4W4p4OjprVA1y6YkSFx4TAjmbutXcF6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfFNTdfLph2BCYaBVnprgpOvE3nGWXJ0kTKf0nztqsoZnKffJovOpJnc7O7PkIxKBBiuGqJibegSktBqbhATEUNZOKdPk/Ul+rhds5j6SdrnAcQp5uFDuYRsMEQhlzitIbEzFhkW9gmm06gMzhHNYQwsqQqgc2TwrU3CBD6DLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0Y8DjzW; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0Y8DjzW"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so4566289eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767777; x=1778372577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bU3LlfHduMRXriJM/lVN2ewJoBx+eB8b+i1D8BIsU=;
        b=S0Y8DjzWxBUJAh0cSjPL+2V2ZYSceL7ND2E7C0tqWv7YSInah4w+tsXB/SLuTX6Ylz
         /BjRnEU0pR4AbMknisl007RKX8qccuCyGgLHDn5MQ0YEGYdcM5fQ7RB3uGhvdu2ZtwFH
         M/EyDxbnYtxP6CmHm2vLZXvjppmaa5JC3AlA7v0RRKic/KR1Ie1RqnKoHJkMSroDiT3M
         p8+dYW/t31arWo65qt1uIE5DYVtnDCRxo9n0eFFgZH7Oaky5evNU/o1R7S5zcNPJEYH0
         QM30H6t/hrbFHFh4V23C5UaZVGjtQV9Lql2VkiuZqXnDVZo2+XmpTN54/VDizGPAocI7
         QBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767777; x=1778372577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+bU3LlfHduMRXriJM/lVN2ewJoBx+eB8b+i1D8BIsU=;
        b=aBmHYh9Iefpn9qhmpP3MgT5QjaS443vhVrqsnAPiSi+nFgyUxwWSsNBfvhqnbsfhzn
         93kQTKMg+5IBEUHBElPeLoo/DnvlW5nCwUnmkKCDrPQ2zymEXRPO0GUrCy60eMtzkRIA
         5rYELb3lj2U4iy7bCoOT/+6v8pp9BCzQawx3OejKqx1LO2e7WXGMMqv2gjr7yh/fa9ae
         0lycS/QOTDavN1/noHe8HT0fV4MaJX7m/Uy8Igdec3XZfsy14thRzTBhuEWVIziH1HCb
         TPgr9mDBulTIVYwQN78IQk7MxNpL4seVCnyWS5UyFI661bPS6Qp5YX1vcUNCGfmEYjNU
         RZ+w==
X-Forwarded-Encrypted: i=1; AFNElJ9XRYVhWRaFCoQGsrLTF/Mc7CXVfU3Yp8KvsXWXPi9C1hRbwZ9v2eXySCwKJM02WnDcvHeL8gd3ZG90@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYhXYfQxYHQQz/PX8edF2Tg3PQvJETZs0RgfdHSndAaHmJ0JQ
	Hz1ncnFZ7hKJCRJmdyVtSmUw2K8Dk7VB/fO+8aL5+lMXkXa6EG/vLg6Racfs5JFmbXfAUG8GWto
	ZYM583bfPXw==
X-Received: from dycue4.prod.google.com ([2002:a05:7300:84:b0:2e5:fa99:f6e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5712:b0:2de:aafb:feff
 with SMTP id 5a478bee46e88-2efb8b96397mr1802106eec.2.1777767776760; Sat, 02
 May 2026 17:22:56 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:32 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-3-irogers@google.com>
Subject: [PATCH v9 02/18] perf tests topology: Switch env->arch use to env->e_machine
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

