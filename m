Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A48181334
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767797; cv=none; b=T4E5V00Jge2ee2PJ8udUWBRkrZSrUkteZcYsEE1JVdiCFwnwhCc2WSLIjNndmrPY/zyjsujIF48VZslpXGBrCSESHHrqsuJQH0b/Gq31lgiiUBbtuIJZDRZ38wsm+zx4YT+VIXD3VASH3/nAIergk5wGwP3OlwLsVoTCzB1ABbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767797; c=relaxed/simple;
	bh=NkDzTpISKGLznN8DpCYnw5FlKY6SegO9ajNHEUGCkJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TDf0BoWEG4J5NdvwzEeGrWT2HZpJnPV0I+q+yhqYEDOQjXIq3QQX/iAbaYPPoJh7ynGkeu1Mz0+cpzqtojwav7/Xgx2CviyuZwa6xIJoNpPPT2PVkmCNPindmPB/MGju3B0KgADvh80LDoTpQ7GXN0x5bGIo3Y5PwQlbMha5IDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdYTU2PK; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdYTU2PK"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dfb99429bso534299c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767795; x=1778372595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptY6oVWnZ5/CE0Bj1nWU4voD2W/pshYyEHj8eE03jqQ=;
        b=GdYTU2PKbcSzUH0ZJXIhX+sdJzJ86wlWCswF45l+2j0w/aJ5vIZi4ebKljkMoN2ZQo
         ipGYwFmX7koc3Bmfa++pWetC/9Vy9vbOW0sDhZPx3DP0mawjK3oxF7HpDYTzbYP7rZWo
         OZT35YnZoJlADwMGbnj2QAK9BEVnpMkZWe/HbOaNU375bZRAlbreSPJo+CWt8m2ogGj3
         sxAaMexHkdCQx238dtBMrXxeapbdyw6kFdiB3UlB+zhET+ymwEEQPJrjqxwcDlZFfW/n
         QKsKCJKDJmxZ0b3RRY1ShHI8szOHJGK+935QBcYOXi2JGb93wD7hv5MsqiXFE2pY49+e
         xuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767795; x=1778372595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptY6oVWnZ5/CE0Bj1nWU4voD2W/pshYyEHj8eE03jqQ=;
        b=dlThobyRAkK1tpM6hEs/aEAfrX0XEm6kukpUQnFYbaKWmp29wp5iPDBytalgFIjvzs
         XEI6ltW/NBOF6zHTOEdPR2IRPjsGniWrTO+9Udo09yEOxoiQRY7yVMoH/ASS+v8+nPu4
         L08D4CPre6J0lNiYY17r3DCYm4F7KFU8MAWVxSqHgQg6yRZUKbPAjKSohJLT+Xgb/Umn
         RhYAdslDenCsr+dAcW0Jp3GYs3ZvJc2Ty8mW6yEIfKuOZqpb7JFno0ogQH5DRrYDIjp+
         C48RgQp36fXZkLpvigXxxXkWC1q3wudv25N8jtxPZap58JKfDc0SAN9zXPRNDP4OuLop
         JqIg==
X-Forwarded-Encrypted: i=1; AFNElJ8P0BQ1KmskVTEaYx6n2VKFPtz0f/NKyJURDMem3HUI3d/sAmddIuFXFYGwRS1zDQ/NcsLTu+f1pFJU@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQPlReggVy63HnjvrS+Tmgg03+V45ShCyR1vYmlNn3cjcJTdy
	b8olkifmMd+HaLeSbyEfvZWDHRxdQh5L9i29+gKQTWcqnBbsl5ifQJFKQVhoZl8+7PAFRjn6F49
	6S7C9KxSwGw==
X-Received: from dlbps10.prod.google.com ([2002:a05:7023:88a:b0:12c:b3eb:b31e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:224:b0:12a:72af:83d1
 with SMTP id a92af1059eb24-12dfd7c5ed9mr2445709c88.11.1777767794714; Sat, 02
 May 2026 17:23:14 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:41 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-12-irogers@google.com>
Subject: [PATCH v9 11/18] perf header: In print_pmu_caps use perf_env e_machine
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch from arch to e_machine in print_pmu_caps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f1ae61392cce..bdf6c5d0fd5d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2348,15 +2348,16 @@ static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
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
2.54.0.545.g6539524ca2-goog

