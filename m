Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23F2F83A2
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705202; cv=none; b=jjXL5q46scxZDWBrSEtyzfduCRbWHGBMFziBi30WEW3VKHNzAGwtvdmlZhEH+rsq+pXBvrg9EgRiyfOsoAoobNyPiYS6eO8yOKrHxK4jIi+YcWqo1rTEbO3J8g1kvqoyLXOjJ1s6jMZ6PdwFjLC+Eksq+w+qD6efY0HewOWrIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705202; c=relaxed/simple;
	bh=+Dwduun+tmVj+ZELsZc9j2WnUnKWnNcSWbU5YGl2oTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3nUMOqt4gIXL4Wq7YI4XtThU96RyBJR//fDd1cKpL+bReTFqveyQdcsam5se4tNwK+ZpD37ROk2FeKl882GEPk+5sYVz0G7o35vVeVrmPmLJadL/rxfmxaP8omJK01FCeCy5gGViAjMqu/Fymo6kUSZz2e9bgvlTuPrnvf1OEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn4X0kzA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn4X0kzA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so1753295c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705200; x=1778310000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nq2EPpcKxJGq1ZHta1JguJ9mMsz5mvveNgAQQT6Szs=;
        b=Hn4X0kzAA3HCch/xtWfoa7eE9w7THRp5oLjeF0zeBQPWvtotjfDPoxsRAA4COpd5U1
         FPUIlUA3hStxsuz58FfA4RdBdYAIBbUEv+lU50rAgIre929MMKUhci9nbw8K4LflfoTV
         0NW1w9M3Viw5ilMmz7Fih68LAN4fb26X32LUKU0lDVwr2gm/UsrrWcH5pFbYeww5+ZoR
         QysAs2o0V9/bBQzkxMvp8ruXZOoCSQxzrmOz0b/i3OZ2xOL1tyhJ2sK+zQ9y5Q3XRIYu
         GPVrppytoDGGQWv6rhgTn8RaH72OHipbLcInJAwCtwcejIXj76c+39VuRSdDGskKXf0S
         efOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705200; x=1778310000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nq2EPpcKxJGq1ZHta1JguJ9mMsz5mvveNgAQQT6Szs=;
        b=eVAoefNqiTgbAfu5JzmvTCqF/XUQW5ZvV4u6rcGv/9BDTfiyoP8+eoGGxQ6lo8ESw9
         C7znapdW2nBvP8Jtb61ENvGeTb6/2+T4o0TaJvVKHXuxyyocA2BjQTo8Sid4a339Qyow
         I7JCpPdmCkDgXnIWeuEIIGlNQ2mOnD2z/nejNBbaViVrreezAYqykS8zqscPpam0RtO+
         uj+2DxI8hc6z4c0sTpksYWw1DE6IO5izvTlNUrIsYx93sT674gw30EhXS4oZEe2ouUGp
         xJnpzV3WjARDBhaihGGhoy1XM78TuKfHisLX2BCWJIVDxCAj6QMopruqa8MTRib/e/S8
         8mUg==
X-Forwarded-Encrypted: i=1; AFNElJ9rKb3AXgL0vPQA9qGlg+Sh25WW5UN/+sVPHIjYKvejWDNHreb9a7WlH9l7ksGhctgDZMzecbgMCPoE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiz8oPmAmgKWE5OhlUkw9f5Off24R+5Ugl0Cn3RmrZKDWV7nn3
	tqzApXwMAw5VvRJhWWlTHopCk0sjif3RZKZ9W/9Wu0ePSU4+WiWJ/WhpLePBZYewItbGgiwyCit
	8TiF+yu8rHw==
X-Received: from dll26.prod.google.com ([2002:a05:7022:21a:b0:12d:b48e:8597])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:404:b0:128:d494:a1ab
 with SMTP id a92af1059eb24-12dfd7c9fc3mr833194c88.15.1777705200183; Sat, 02
 May 2026 00:00:00 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:22 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-5-irogers@google.com>
Subject: [PATCH v8 04/17] perf print_insn: Use e_machine for fallback IP
 length check
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid string comparisons with perf_env arch, switch to using the more
precise ELF machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print_insn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 02e6fbb8ca04..5e36344174d6 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include "capstone.h"
 #include "debug.h"
+#include "env.h"
 #include "sample.h"
 #include "symbol.h"
 #include "machine.h"
@@ -17,6 +18,7 @@
 #include "dump-insn.h"
 #include "map.h"
 #include "dso.h"
+#include <elf.h>
 
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 {
@@ -33,13 +35,13 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 static bool is64bitip(struct machine *machine, struct addr_location *al)
 {
 	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
+	uint16_t e_machine;
 
 	if (dso)
 		return dso__is_64_bit(dso);
 
-	return machine__is(machine, "x86_64") ||
-		machine__normalized_is(machine, "arm64") ||
-		machine__normalized_is(machine, "s390");
+	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	return e_machine == EM_X86_64 || e_machine == EM_AARCH64 || e_machine == EM_S390;
 }
 
 ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
-- 
2.54.0.545.g6539524ca2-goog

