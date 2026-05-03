Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7572248A8
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767805; cv=none; b=MG3ls3f+uAWmw+ic75rdr75ojAt8E2+FqzEhyTXr15WhykE5neAuad4kb/W540qulXmWtcNW7npTnsbLfR+1HU+lQTiUYjn3OBO75ncPFubiPyEEg6UjW5VlJqPICEG2T7wPviLRly8vL+ss6TvKhFp049bTZGTT6Lb7jpYmCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767805; c=relaxed/simple;
	bh=oPhtIYTZ3hsEu6jjU4s7MOVLcdebH8MFtbow08cDcec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hghQ7kdHv6nhxOD7LFFKUlqkK4RJk7fGO5yQxqKBN8s4uBP2wkavmKiVkcRHtQSE+JLj3OeMX1Sgu7v2Ni2TaSuYGYn3b8+6TA8L0Tk2UpjUQkppniMoZwYjdBHSGm7iNN8PyF5V+3fQREi2A8JsFMc0gIwMXPSt4YNYFplPa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seTRxAm+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seTRxAm+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso2635415eec.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767802; x=1778372602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNEOtAMR5QCvXyZplIv0gRH0b0eemE/yfoOhcH4gY8c=;
        b=seTRxAm+PXXk57IHi0xp6FUtTD8iXSUWiuDHAdwVSIApNRPBNXFjZuKPW2Q1pTwPv8
         5OJ8BlWYHEMXYb8K4ibOdmHrr7fs89WVt5qTAG3biPwTrZi9UBAYR+VLTyut1QVbaPET
         HDecS/pjCSPhpRwJWtF6KC8eeORE+e0zI1dGNYLd1NpwoDSVB8+meodRedvwizgz4l93
         akRRsms41myoNnvN82Qa9rzjg82JvDUnJaYBPIy0uDHAePA2JWcVgWiRN68EWRY8aS8O
         n3x4GWcel+DD4AR4s3473ichokk5h0T2LMHlnVT9WLPCOXfvCv3xKZe+EdkT9rs6sIU/
         L1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767802; x=1778372602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNEOtAMR5QCvXyZplIv0gRH0b0eemE/yfoOhcH4gY8c=;
        b=JX4vUAFX3f5hCOl9AY/ZIQ+STC18WFAc6KOdVLdFrNzh7bG5GRTBuZkBmyt+DZWdLq
         gfDZZpUmu2BV8vo0gNrMSpGkpHr7unBhswzNH9wdSvEWeqtghv6spqrGuH4cOG92uIrW
         xcQixWhL3zGTWgzrZ/rNxR2IP0/yRA9WHqc+5g2Tz44KDUHf9V0xSJ9f1i9s3FuR6dNh
         yNjshlNy1poUtqOcLtNCIkuEteFy/b9ehQDCoqaGAxVCxHB8hfuouZwOZ6n5FJVZItSc
         ptBiVkIMXreaKXNvQKZOuqUcWy/DE0/wB0/u2mi8aK/zNDLvMe2mw5RoXOER61491LVg
         vf1g==
X-Forwarded-Encrypted: i=1; AFNElJ9B9eR7XG8RW0xc+TLjyUrV/7p8031m5F/VvBr2yYipETyTd1CELFqXW9lpWrkFHY0za9E7KRKkgLyg@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0tBPIeIX7RB5ioOoXCoh4+cx/LHsKfdT7832m9451Bw0S8ME
	T5Juw3tLP+wXIFUfWlzMkmu7Gbz9qHtDDZ9v5HX5/4RYJ2n2QNRzYlMKZGKpDiVK55h7QnzBXpe
	yp8pJbWCG/g==
X-Received: from dlbtx10.prod.google.com ([2002:a05:7022:fc0a:b0:12d:4be7:8b60])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:78f:b0:12d:ca32:59f
 with SMTP id a92af1059eb24-12dfd7e5bdbmr2156723c88.11.1777767802181; Sat, 02
 May 2026 17:23:22 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:45 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-16-irogers@google.com>
Subject: [PATCH v9 15/18] perf env: Remove unused perf_env__raw_arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The switch to using e_machine has made the perf_env__raw_arch function
unused so remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 18 ------------------
 tools/perf/util/env.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 8ac7aff0b27c..29d5fe37528b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -463,19 +463,6 @@ int perf_env__read_cpuid(struct perf_env *env)
 	return 0;
 }
 
-static int perf_env__read_arch(struct perf_env *env)
-{
-	struct utsname uts;
-
-	if (env->arch)
-		return 0;
-
-	if (!uname(&uts))
-		env->arch = strdup(uts.machine);
-
-	return env->arch ? 0 : -ENOMEM;
-}
-
 static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 {
 	if (env->nr_cpus_avail == 0)
@@ -594,11 +581,6 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 	return ret;
 }
 
-const char *perf_env__raw_arch(struct perf_env *env)
-{
-	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
-}
-
 int perf_env__nr_cpus_avail(struct perf_env *env)
 {
 	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ba51b871c401..bc4801d8399b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -192,7 +192,6 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(uint16_t e_machine, int err);
 #endif
 const char *perf_env__cpuid(struct perf_env *env);
-const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
-- 
2.54.0.545.g6539524ca2-goog

