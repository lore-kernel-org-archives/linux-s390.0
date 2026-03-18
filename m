Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A53932F5
	for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877569; cv=none; b=DnQEDu90XEu691K97NC4VCYLh/FOjuK4a+KksRfwUV8N5aeVLF0s6aZ/xBFH/8a+qtuyCyxBY3umEYoPjuIL/cgeiqCpjO+BiRqVQ2IrK4sQ3h4q7IaIdzupKdxG06upoDSTIkE7/IsFOUa/zV2n3cZml7zPoBEWzglST8qwHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877569; c=relaxed/simple;
	bh=AT0BGB6UrGLZA1M+tVNdNXzlDjYmvZvAEkPOTSTH+IM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnrH1cYHvNHJ7Pbxg2cZuDBv8/pgZgahm3YcO8qSKag6CYbUNzwM85J1TjRFFUPeNI0izEjpVLcIDzOQQxpgShnAaZFnIBqkLGQMVWO1xzX7cMKRJkhGGL9UtuRuBNdAtxptkVmPemfQQMReekDgtm6VjROs/65Mc2LhyIrTWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eFFxukJo; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFFxukJo"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so392926eec.0
        for <linux-s390@vger.kernel.org>; Wed, 18 Mar 2026 16:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773877567; x=1774482367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=eFFxukJoIwm93af97U7nWY6GelLr3kLO3o8PC/hgxic/A4hEwADtw6vt8BoOVz+Npa
         aq2MeH1HdlEyIO0Y6ydLETH79WejFjlv6ODR67Um9BG/Uf6y/o8q/kKyW46pot75pQGD
         1Sac//uGc0KmOu3k5fgLGxREy6m27jJLfMNpqLVMESOVLVWf83y742JQSofwrw0as3Kd
         9QRTan4A8ftYlwSSqb7ph9YCHpXNnKn9D5mBaBmkx3wc0wosGS4FEpaKO+dtDiyazFzV
         t0QuYVyG0A271ugqIE4xi1v4igz/v0TvgEIAet14Jrmq5ACYNQ/NT+54iXFUc6OzXpKI
         +Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877567; x=1774482367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQVp2xNbIouZw2DsKLWRE3G9FMoorezshWZvQPd6XX0=;
        b=G6b1boW01Rk2rNdZzqdHlTlmcDQEudIKTNArjV4G6xWxPTci61pWaQ8XQf7Ngbz4k/
         48QXVil4icyVx8+PhjcrX3rBikCD8dX4WlyyP2m6gqrR4MA8JR6qWL3IWUG9pGB96Oy7
         npWsvqIrcvcI+jTIJK/+WgJ6Bj/Ssq8OWdoxi+NP4C6VVzynOuUwxKNPqJK6SppoXyBi
         ojqZd4I4sc6yjlMGkUO0SrnWPwotsunKDXamEbwYGNR58u2tV6C6s+JnDUkldHOgBWHI
         tUTB3CaepCAfQGxwHLbYS4oxu+UwnvGr3DAAUlc15rN2GNuV7bjTDGHbER/ObWx6VMIE
         EMeA==
X-Forwarded-Encrypted: i=1; AJvYcCUanmKui38tEjUERPdD/6m957T2bIwXMxiJYnNtkRjcGYFqOkh5gWiyDw2QnLU7HQGKQXS3YmSMwDhI@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDV9Tz6GwkmiiOFBPPrXOpsBrOdG20SAc17UaJ1LBuPRTe+n9
	668x7FSZGZ7ibsQSgniMQW8aw/srBk/aqcBDlMRDjDxxYlL7/Z+LUml3Lt+GQofyE1AKl2B83lB
	AcLNcIRJ5QA==
X-Received: from dyckg8.prod.google.com ([2002:a05:7301:d188:b0:2c0:b1d7:935c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2152:b0:2c0:cb34:7d54
 with SMTP id 5a478bee46e88-2c0e5110301mr2350996eec.28.1773877567053; Wed, 18
 Mar 2026 16:46:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:45:57 -0700
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260318175808.582009-1-irogers@google.com> <20260318234600.730340-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318234600.730340-3-irogers@google.com>
Subject: [PATCH v8 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
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

