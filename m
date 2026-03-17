Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F537FF65
	for <linux-s390@vger.kernel.org>; Tue, 17 Mar 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726825; cv=none; b=jNhOo0BVcf7fsrxkzL9n2RbPhwiE+oB72QNCPBQd0pGB9HEZlTLEWUHTBhZWo/+zy3KjmWMaQDPHkYU2juN89uCjaF4SW/00uasv4V98ae9/cwTXdQ/EELBGM1oXV7a24py2JXthu/VGhdpU4gfZ3DpfNJq2WMwKJMBzuDdWQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726825; c=relaxed/simple;
	bh=4mSJoDt19c1s52Ar2qiFo/PGbNpyNgJireRDLID11TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tmd106+9KdrL72FBloIyH8WNZRSc+DdpkdYCSCChjnmLR880VZHrnWZkzmBR5KFQckNQduSENxhrPv720xNhhWPGkRcKBec5drF0n8EJ4fI7KvEIR+bivbNWtEOQTQEUoaVB9xEm+hPfho4JW59+k18FqKcAzJsuG4R741yO+68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2jppqV2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2jppqV2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829a535ad50so2725901b3a.2
        for <linux-s390@vger.kernel.org>; Mon, 16 Mar 2026 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726823; x=1774331623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=e2jppqV2bBUIRMl1d+AbvCcolwtdLSX0AOG2FdGsjQE8e3rgmk1H/inwS8Ziq5DBxx
         9ab6UF53qr73utPneH0bCbPXZfGpBlNuf41imZ0/xJW6AuOKYC+4DgAWIayFlZ8yAMx/
         AiojvGIaPzfzRqlgmfnJF9QVsi0n470bu2uuLZUCe+Y372vjYLF4B2sNC7QSsDu+sUMm
         H4f4T+58a76p7ENqT+lgl0dw1swTsOX5x9WozmCbcdEreoWjNGHhK4QWGOpdLucvf6++
         dnoVdNLd1SFnlChPeirJdaIvU0FGF384MEdUP2vh1JK3L9NntgFtk7nliJkA87nQu7hX
         l+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726823; x=1774331623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=JdVpKjlUN+gy8lp30KYUnRt9sSfIA3JP1KsWOSgd4MYDIKl0xzFPm7XcZK/TX0rIsY
         ErwfCEX85414UMRyuRubrZAch6LfHFL8dCcZqSOIZSC7j+7+fv2oBUSYMUcbeO+N3ye0
         WpDgpZvx/T687pbUpljcEgNyokjvP9NGE45djfh3HzzmlrIZBCzPIn6g+GGkespehKvl
         0+m7CdSecHtSuB5rIIz/RXP/qSHr5awQTmgW+F2+AUEgojK1lHcDdqXkcVeBX71R52hE
         KgJneetgawLjR6wV9x7i1MeE12AtkR1xf7BQ6nGtZOtbmgIa+sWxV3VPXYrFOfos2Wxq
         aiaw==
X-Forwarded-Encrypted: i=1; AJvYcCUmBrnx0MA6r3ST9WL+TXQLvgT1qznu6g2UMOxLTsdzJG7zaDgRYJt5FT/Hujbk/oVx3siEkzlgYgtp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3V/Gy1snEmD7LSZJRSboId+Cq8n2rFQtlYfIZ6vbDGYt/VUW/
	fh80SuzjQi/IeETBt3Hj7KgsgeV4V1h8grJkTM8wBoQnD63hpZnvJRxLLf/zRaIk0Q5DvFbLxAk
	LexmxxBcoEA==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:824:a502:8fea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c4:b0:827:2f87:ac03
 with SMTP id d2e1a72fcca58-82a198fb8f3mr15205658b3a.43.1773726822422; Mon, 16
 Mar 2026 22:53:42 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:31 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-3-irogers@google.com>
Subject: [PATCH v5 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
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

