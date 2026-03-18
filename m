Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699433603FF
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856707; cv=none; b=XCzd5iFXTh0C1bbxbITbe7NUbryZNQJjnCTWiwVuRlrjd8UMp5Cy5pBtq1/fMKFiMZ2XAO/vtMqiCyF7Bu+qmd0ybqg8Gon7gM5M6ihLrM6kIVIk1WoQBz23IwKPp2OE8AkH9MmMIwbFGuojVbJnUXZu9MTlcW6W+EWZQPDUiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856707; c=relaxed/simple;
	bh=AT0BGB6UrGLZA1M+tVNdNXzlDjYmvZvAEkPOTSTH+IM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DyDMnSKybprId3MTmUdkSDdDcgyuDOrmIl97MbUFMKTOZYwC5eZsUL3d6ysFnXNAwTXeOfW3Yu8chHLg/rJM4i7zNhO3we7YRamQhYkJenohD2Frzf1qdt1V8EvI4Lx7cl5SXw/vmnuXrzyQRB438AJKq0VQS9qhRdh36yXRCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwCV4fkN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwCV4fkN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso242498eec.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773856705; x=1774461505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=jwCV4fkNEnk+dEFsEY+7zrPvvWdEtLNbQ70Ei/pMghHmkixqbc5UUEicHoB1WfMSqu
         XeX1a4/02FKBsjbnVEvuefAxjaxI7oC19jD+An8QtIJgVT1X6JnQSPh32YyQLXHQ0NEG
         AUV/nM21B7mKlhiqc91CQuLH6r5JT3CJqaTGGsRUjerrXoUPYBbxiP7YS22iWyAsjpxU
         Ir3AXUBYVN61mP4zFGZm/27gcPKuk9kHJ2+beC8hoqpH4mTMh4KYvyK1c+wML3Z1k5Yr
         7mXecclzNTdmBLy2v4NJiGSu55LgEki7f26mU3Xb4EIcuvheIL2GkOGYiRIlLKZ5pF0H
         /MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773856705; x=1774461505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=Vo1Lf6YaGOaOc/Il7Zq8uRxHu6cfMQoTSLUVbDBxGAYsra9N5Dv3OOTj+a5X4jmR3l
         C+DtTPnpsIzb1j8675H+nKwXt/VXq3ZifzsTq2CPk/+5nizYbt8V21J6uPv06f2h7lJh
         B3ESXXIxkjgjxqbxj0ZDhf5UaSv9feUzGOLQl7PXWkT7elMF2RZaNbUB3BJDHmFoKmse
         XudxMzFJ3+W0FmZVVq7Ok8yyp4O/q7xbKMF7hbEC+0JICDFIq3F2O/X1v/eDAJZ2Qva7
         D6iRZOHNM9FpxNyUeREsiZ3VQUw93hsA9etpkV6iUAW7Cj8Ctn7t/tqQULYRrxJp36vG
         BPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3J47W2b73uEZPWrlVu9YixIZ2wys5SMIvWAsDaSgG6rqKFbpmpz91wlgU1Rd/crZ2cjJebWR/Q+Oj@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkuTVR7XJ2XfuNKvwyQgmvLTS4XxHLKzwEfTFJsw7usdEanT1
	LqkAfyVreF/1PkdjOiHktxrItoutt9AvA0QODuf2hWS1buZ9KpYyzbKp7tX+8k1JHoIyKOK1Roo
	nBX8E5YGl3Q==
X-Received: from dycrm13.prod.google.com ([2002:a05:693c:2a0d:b0:2c0:d104:830b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc91:b0:2b7:fdb6:ccf6
 with SMTP id 5a478bee46e88-2c0e4fb8e1dmr2171218eec.14.1773856704365; Wed, 18
 Mar 2026 10:58:24 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:58:05 -0700
In-Reply-To: <20260318175808.582009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWCf1TFMW8epW8moOcUbMuzRjrG1r38SWFevH35mqR0+w@mail.gmail.com>
 <20260318175808.582009-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318175808.582009-3-irogers@google.com>
Subject: [PATCH v7 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/target.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 84ebb9c940c6..bc2bff9c6842 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -49,22 +49,22 @@ uid_t parse_uid(const char *str);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
-static inline bool target__has_task(struct target *target)
+static inline bool target__has_task(const struct target *target)
 {
 	return target->tid || target->pid;
 }
 
-static inline bool target__has_cpu(struct target *target)
+static inline bool target__has_cpu(const struct target *target)
 {
 	return target->system_wide || target->cpu_list;
 }
 
-static inline bool target__none(struct target *target)
+static inline bool target__none(const struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
-static inline bool target__enable_on_exec(struct target *target)
+static inline bool target__enable_on_exec(const struct target *target)
 {
 	/*
 	 * Normally enable_on_exec should be set if:
@@ -75,12 +75,12 @@ static inline bool target__enable_on_exec(struct target *target)
 	return target__none(target) && !target->initial_delay;
 }
 
-static inline bool target__has_per_thread(struct target *target)
+static inline bool target__has_per_thread(const struct target *target)
 {
 	return target->system_wide && target->per_thread;
 }
 
-static inline bool target__uses_dummy_map(struct target *target)
+static inline bool target__uses_dummy_map(const struct target *target)
 {
 	bool use_dummy = false;
 
-- 
2.53.0.851.ga537e3e6e9-goog

