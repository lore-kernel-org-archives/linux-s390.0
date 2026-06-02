Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3943A6B6A
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381535; cv=none; b=BOX4mMc3A2u/bi7kZJdmEgtylWQdD45hwb5tXRQmVeaCt2TOQFts2Sdou1VksoOysmCUC5DERWxYjIGbuHkIrVLF3CKWxYr9lwSFnCTD4f/Gb+LeLO1tnXwjRph5odo/huoq7YA6avA0Voer30tJjHy19mGDS3H1RtMY/AWEeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381535; c=relaxed/simple;
	bh=1vKpGyCR08D55Ms8rIa5echQivY8IcjS5P3lKw+8Tnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mTGLx17U9BqstnbXV0MXjfd4mkY09qLoSojMz5sdDEcORg2Jr8Qc3eZK/7dQofG2OoXvsTswDbePsZkY011cvLy2y5fV2bf5/iQ43wwqFvERnhVrLE2cY3DU9oJv7qOTwU5nh6nwT2My8hl+ddN/2uWHyz7HdB0WSHxIJ3Jxla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=en9U/efh; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="en9U/efh"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137f2083280so51548c88.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381533; x=1780986333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4kzHtgoNcTXiq9f50i9J7MtKzWtq9qgg2LJuweT+II=;
        b=en9U/efh9TZRuMMp9aSK8V7Xyxsu0tFIfrEPl5LH2kvUHZ3H8SPLPWzl+ljAemfkPz
         z/Hgc4EO5Jn+1rc1lFZqGOPVPTinkZ08fwo93zpxvDCx6NS0xs7xfrZq2YbYnR+LecjH
         1zKwfOc0oWQldTqWdQvwNEO569PeiHC7ygkwvJtZTd1E9aRz0uAfyefRGhqkZklGvV9e
         MaAbsyTUEwD7mi6cvhppxsq0HWXf4GbZiBMc2uIRvF+wgNj23Zj/4CM2bjPovsEKaMD6
         aQMuj41a10aZu1fdLVpUKyuj57Gt8kgKihisXM6MpejyQ096kgACYP0I67IZm1PH3qVz
         1uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381533; x=1780986333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4kzHtgoNcTXiq9f50i9J7MtKzWtq9qgg2LJuweT+II=;
        b=NrXt6VMyq+CDiTYrArUFYHSwqaSBgqLGf6jSIVvxBUGrRV/frmjXwiYLkl4I3kqagc
         yrC75BTRP1UqsLXJnGOwdTTqlZgPtkh26kZrBXcNfu/58LwoFkAzPPhaX5wxdrs8KfLi
         Sfj+GvBTGXGWXznEOc6unQG1nMQdIrQa3nh7ciBRN4RU2b5Xzm37JkB5Y2Y2pG8qJxNv
         tOueofNMdkoPlNOO4D4YWrT356AqqWZ2ImpbenNrvIAmZ2r3fJrdLHJCt+IkwWYhvzZ6
         zKmm016hNTisNQquRulhKwtyx4nUdIA6iRQcvH1YijzR1xIWSjNXn1tqY5vu2uUt0ZNR
         MtZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PLeMChhAtQwWAKHdKrH7LIZT/cPrw2a/g3/D8xW0hCvqb/+CrbP4GLIj09k9Bt080+E0666Ngseva@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mCrpX8yhU8VeYlXSJY310f0H/eV7TDjRD9/SS6sEW4N1/0B8
	ovKbco/h+Y3iv/ioUTPQOrDW+xoCaPq5GkLdpTJ+eoG8Z6Jyq/ZHnBXfWXq3NbgDFbocGv6SmnU
	HvJ/Wd8L7Dg==
X-Received: from dlbsj5.prod.google.com ([2002:a05:7022:f905:b0:134:b02e:a831])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:503:b0:136:58eb:a486
 with SMTP id a92af1059eb24-137d3d09851mr5747955c88.1.1780381532714; Mon, 01
 Jun 2026 23:25:32 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:43 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-12-irogers@google.com>
Subject: [PATCH v11 11/19] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 220e7720fbdb..ecdac427d9c4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2461,15 +2461,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_env *env = &ff->ph->env;
-	struct pmu_caps *pmu_caps;
+	uint16_t e_machine = perf_env__e_machine(env, /*e_flags=*/NULL);
 
 	for (int i = 0; i < env->nr_pmus_with_caps; i++) {
-		pmu_caps = &env->pmu_caps[i];
+		struct pmu_caps *pmu_caps = &env->pmu_caps[i];
+
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
 
-	if (strcmp(perf_env__arch(env), "x86") == 0 &&
+	if ((e_machine == EM_X86_64 || e_machine == EM_386) &&
 	    perf_env__has_pmu_mapping(env, "ibs_op")) {
 		char *max_precise = perf_env__find_pmu_cap(env, "cpu", "max_precise");
 
-- 
2.54.0.929.g9b7fa37559-goog

