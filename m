Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A130214B
	for <linux-s390@vger.kernel.org>; Sat,  2 May 2026 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705219; cv=none; b=ABUYv0jKEAFBv6KYIAtTBbuYjUbW7Ow3BdFW0dRDzNagIIwW9U5BHKDYsH4kij9JTLWN8+LoVS1eD80impAu6deMVg3uX7fv85pd4YzHZnWUbp231PflabNqAe5m93X7Anbkc4lM2ogyaN09lYXEBZ0kaOCWp9bpityNb6r0Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705219; c=relaxed/simple;
	bh=uvhPGJ8aFyrj8sz3RY0F7uCaw7UwOHqluJDNG48CN5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXnZD06doUHoV3btmSe/UVE/05OQHlOZa8oXXpjKg+LnOacNq7G9t3bc0f7WGDRDpYxJyG8KldP8z5X/pFK3FUIB5y18zpm5webnFU14In+nQk0XboAIJaehZiMqKHbxE6Sq4P3mRblYTulKOj7kY516ffTaHqoTx75SrTISyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNLUG3Im; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNLUG3Im"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12e683ca86bso506882c88.1
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705217; x=1778310017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5+XfQfSgM6vL4wGV0II5aik5OsLQWVkexovkX+K6RU=;
        b=MNLUG3ImQWCDEYoLAnymKNYIql4iNHWLkf0lh44Tq2mmtKK8VThXScJpVy/Sop4Syh
         PQJmqLQw0y2E9++g2v2IhF3etQIQYYFuxpviYVqUQuLR3zR6BFHnREW3J7bTA2q5Q7/8
         7zWSRyc6hir6Vcow0k3BmWoKA3i27TQHQZ3ane1TnxZd/0cz4BQWSQz6rg0DKUz3tuNc
         biRd6bR2lJcrvB3tSdJZ9JBuXTif4lDlvB9s6FWDlbO01MyigBKRXQnHwCGDWPNGURHr
         90Op+SkjlNncACKvZl1uMzhaZ/bh4mBXGMVuLdd3P1ZXT427uYnFbVT6VriEUSka9ZNe
         5EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705217; x=1778310017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5+XfQfSgM6vL4wGV0II5aik5OsLQWVkexovkX+K6RU=;
        b=IxNV5cyvVdJJndXhD1TsH+ZBJy43mtHjum7FfBMcCpFl4WKGxX9EwknLQMGipytU8w
         Tm8Xozr9QIhfhrAVHGlYH2Lt7jLa9UAr6V7EavcYc2dGTMGfl/gU1mnbsQAbtzdgD/MB
         1OIpgnsPAkG9qP18co7XQwK72tJkf2h6lVTc6kgEXZUnC82GyTO9jhAFF2rKG9iFm/42
         ARQvB3b0GDqpm1eRPkjROpngOmXysNv//H7QUKhQJfGj/EiTBRohPho9jfgkVHTpbtnw
         5XhI4v5lgNYr7Eyf5qyDTSGrC56sGkefSHdOhDKetnRFe9PTfXWaYm1aaINo/ziOgmfk
         MyKA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q4iVjD79nRiuHwnIE/B3O0irpD0qv5qQ+zh3L5Ox/mhMEcB7mOU6XpgbYVsNdVleiyRP4zE4Mk7aq@vger.kernel.org
X-Gm-Message-State: AOJu0YyyoDp/X2IVUDMCZmnC/zOpQjROKPgdaV2PmAfktXRtfUnWfias
	TMqImS8fnELFDiW4RKL2tvXdlZMgU1U/YEr23v0vwbrn3Wq1s/0r5235Pd7TmWuA9erCxT3+hOt
	akw9AN7sv/g==
X-Received: from dlae15.prod.google.com ([2002:a05:701b:230f:b0:12a:7182:6cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6286:b0:12d:d972:b96e
 with SMTP id a92af1059eb24-12dfd81a804mr1102945c88.20.1777705217082; Sat, 02
 May 2026 00:00:17 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:30 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-13-irogers@google.com>
Subject: [PATCH v8 12/17] perf lock-contention: Use perf_env e_machine rather
 than arch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Use the e_machine rather than arch string matching for powerpc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/lock-contention.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
index 92e7b7b572a2..119a7206f3cd 100644
--- a/tools/perf/util/lock-contention.c
+++ b/tools/perf/util/lock-contention.c
@@ -104,7 +104,8 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 	struct map *kmap;
 	struct symbol *sym;
 	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
+	uint16_t e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	bool is_powerpc = e_machine == EM_PPC64 || e_machine == EM_PPC;
 
 	if (list_empty(&callstack_filters))
 		return true;
@@ -125,8 +126,7 @@ bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_sta
 		 * incase first or second callstack index entry has 0
 		 * address for powerpc.
 		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
+		if (!callstack || (!callstack[i] && (!is_powerpc || (i != 1 && i != 2))))
 			break;
 
 		ip = callstack[i];
-- 
2.54.0.545.g6539524ca2-goog

