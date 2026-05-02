Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB2310655
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705217; cv=none; b=skfGfSLgfEHaQ1QeP7L8585S4FdcqZT3EJbhlbKoKNkzdT4UfzFBJd5tYqHYf8IIGsHG+OhtpGTHiKKta7NlklMR29UMqf/2JQRS8FNBzOJAfJDn256aDPsVGVOrFmxUMcMIbiT7tGcZBXDTMC4MNQTrX9jcWT8Qj13fJLmHb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705217; c=relaxed/simple;
	bh=n9VDThrjAF8JIlTeywhHsS3R1i0arT9zN25KGhXQdsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7Rq/SAYuwJKlbVuV9GV1bmBwEu/UvFgFt5fiMwYu3hwY7tidzXQ1nrYE/3OhubwQ7zMUkcu/t5Fd3dC0yn30kgOqOh0KEuw3KU3UnT2cs3vCfovZb4vpBSX5+mb+1zJEJbcA2ldjDY1HzOEcJtQoBVEFx5AIoGq3vvsLZcwSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpqLsl/V; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpqLsl/V"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so4620799c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705215; x=1778310015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PPLRcE8lM1cGyL0UzecFUi3MuKZEhavOiWIiPFqzM=;
        b=lpqLsl/VjjMNK4dMEviU/+HZb/AWjZvAIZ3FMbofIiwfPBJ3kyxOclpLzu1aO6iDgC
         yTFpsq/wKTErlVI92wvVOf4hHhomj7WtjFqfmInWvlOBSPccuntpxjnS7LOMvyo7Dxtl
         +1Q75qqNpfE9d8jM3s6yfaxIVxXyVKu56YkcXwFOb150ZJmqIx80StEj5rFaoW8L/6/b
         EfzrnZ8ym6Ta1tKe28z8V0k0oO2JgBTa7b3Z/HzHr7gkerGNYcCgXyP7k5Tq6vUPy3ye
         HaW0r0Yfo7+wmVD5mwz+VdcPRRGHyG2tiXDnji8sQ6M0Pr1V6PhyLuxqhWMST3U8WHpG
         Uu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705215; x=1778310015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PPLRcE8lM1cGyL0UzecFUi3MuKZEhavOiWIiPFqzM=;
        b=lypeBANWxkKgNTi7CVv0XGTQL2yNBqPwJpzVVFMGf0tjldnSJlJCMfK28UzLmKMJ8K
         b5V/X0KOXoELL8E5SjORXQm0pQCCEfNapICnYNPcJX8ky+gLpOm/9usbQe+BTlHK0TbT
         ISoSKYZBWduFkAXAd3hSb4rFX5Ohd2TacKbvQQxrdeqc8PJMm0pj8JrFRtrGDa5b+xQ9
         MdjPqzI7DATfNEzyDsyAHRC3GLQLiXJom7eevrHwGTYqutR2djzwhX+XsKHocbiQGZJR
         8meUXEsNfNFyKFfS7FfWYDeaB6grafhONuansdLbgfoDYGZyC3RLPkTSvfMM+iwvvPsi
         feHA==
X-Forwarded-Encrypted: i=1; AFNElJ/BeD3v9jB6oPJ13n6YpjAL67kPRL0HkAQb20rNCUKs2mE+bfpmi0Wy0wje26YApSpk9O2hCtZfXtex@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZVOAiBRMayeXGfQniWBiNzZrNhfx2FO034/I7ZtUXLJhqFpg
	vYF0SkabWxw1j0DF4gz4qGUBnp26iI846NIN+2pL12ftPWCcROrZ6DMNT0/mEkgEKxHOFcgig5Q
	7a8TZPIRUig==
X-Received: from dlww3.prod.google.com ([2002:a05:7022:ea23:b0:12b:eb91:8863])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9e:b0:12a:6fb7:87e7
 with SMTP id a92af1059eb24-12dfd70c736mr1018157c88.0.1777705214884; Sat, 02
 May 2026 00:00:14 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:29 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-12-irogers@google.com>
Subject: [PATCH v8 11/17] perf c2c: Use perf_env e_machine rather than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for AARCH64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 72a7802775ee..09c8352a922c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3202,7 +3202,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	 * default display type.
 	 */
 	if (!display) {
-		if (!strcmp(perf_env__arch(env), "arm64"))
+		if (perf_env__e_machine(env, /*e_flags=*/NULL) == EM_AARCH64)
 			display = "peer";
 		else
 			display = "tot";
-- 
2.54.0.545.g6539524ca2-goog

