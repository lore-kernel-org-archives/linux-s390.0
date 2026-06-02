Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9803A75B1
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381544; cv=none; b=IIy2Pto45VBbDtgVlTl/YyzgEQsIjPCTEr/3u1t1IdoipnHi3XU9FiVcCQXzOwGxj7AymutFolKmbvFnwm6Ezi9wNrDLQDhPAbxJISwwfnIuTJSfeKAwmeMK7MzKfZeuQJrOjOGipDSzKyj/Bcu7aQ3y1Mq+gFcRLffXM4ndxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381544; c=relaxed/simple;
	bh=+HWu3kknbAU6zmq4lRWiOai1xYxbk6BxTlgjRcQiUOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAGMwJRHnD4uzGKNkz17ctw2HPu78fzix/dIdabtTIkVm7tC8O4UpOcVpl42lK710uagBRr556adC2DnLAQgi8XowEK3BgCL6rtkXQ7Hih9xd7+MZXng3+096pd3GH1HNuz0tUh+MIYcl+blCDukP1OgL/et5VpE18EAcoGbeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuDnb/3u; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuDnb/3u"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd516985so3698669c88.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Jun 2026 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381542; x=1780986342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkWPJsl54oiAo7QwOctwflOU3eh1lLgDAtP7+GmkHCE=;
        b=VuDnb/3u4hTpBZlzHl/Paax+nkqp9sJE9qg5aNeJ8yAOw9bTlt7LfIEOcpZZb7oxjJ
         6DNlBVa7hsfH2lKKtlyVNvPskbCoUEsJzETmLC2ZODvJ7DJXQYf9jO3Sl7d9NERVSQT0
         /yN09O+0X7NS/pu37XkW6xzqzG9y7lQ9KoVNy/dv1Ex6QBV2dYvKrw2je7co/aNhCgX3
         3m13gmqDDlQaIseBLYNlbUCyMjVMdPfch0gC97EkWoyCc5Ohu+y1iNR+cTJjNKF6B6Kl
         DakwzYoax+vCW+2MsqkrV7HxJsIM4e5ss085X5mTIFjOekju1J+ng9ZFzWvzk5TltJEz
         xpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381542; x=1780986342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkWPJsl54oiAo7QwOctwflOU3eh1lLgDAtP7+GmkHCE=;
        b=nvn9ht5Xss5gMc6BPpm9VXyybLPUTYj9T4q4lpbQA7DZ1R+3t63effkszXLKJQo5L+
         LLRYMKBTOesiY2ExzsAH5KIjX5XfhvT8CM6u6E17tHaxaqprrGhXwdv6aIEHSSU20YPY
         cj/h0z0IVW0InbYVD8R2PPps0P2uzJeYpJ1WnadmJ8698AS/7UxCz2//7yl65h+oSZtD
         QT+fCr6lxDQKy8LyXEG325wnIYVld6kt1jHimZYiK7A11/IffPuzxNee1INx+EAGtfum
         XsPLk/44wS5pch4ZsAIANJhzf8mhEy6u7cyLQN776khb72a6vZ5iOCXrH6ZVAXwprdz8
         Jxfg==
X-Forwarded-Encrypted: i=1; AFNElJ+7Ew1DfWeYCp/8lK5aLCLJNnawwIvBjKfSburhZa5Jqr53+S+DJYeNU/xpZuC3tBU/Lr3ur2eCCTpQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAu1gTowxP++xUVpVqlmWWtkrPK4OKcqiGtE5pQaC5gdiJ/4a
	dNDO5+H3NA0hs4KGRk0niAq5zuDeWA5huBtziQqOgcBWJviowBoLqzoxqQv+fIyg1VdTXEy/6qX
	gkDklcrH+wA==
X-Received: from dlak23.prod.google.com ([2002:a05:701b:2917:b0:135:e116:73ce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6ba4:b0:137:eac4:82e4
 with SMTP id a92af1059eb24-137eac4897amr2386077c88.17.1780381541777; Mon, 01
 Jun 2026 23:25:41 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:48 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-17-irogers@google.com>
Subject: [PATCH v11 16/19] perf env: Add mutex to protect lazy environment initialization
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Introduce a mutex to 'struct perf_env' to safely protect lazy
metadata setup, such as os_release or e_machine resolution,
preventing concurrent initialization data races and memory leaks
during multi-threaded profiling or symbol loading.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/env.c | 3 +++
 tools/perf/util/env.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 28c54c58193e..4de07cc7ef5d 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -250,6 +250,8 @@ void perf_env__exit(struct perf_env *env)
 {
 	int i, j;
 
+	mutex_destroy(&env->lock);
+
 	perf_env__purge_bpf(env);
 	perf_env__purge_cgroups(env);
 	zfree(&env->hostname);
@@ -307,6 +309,7 @@ void perf_env__init(struct perf_env *env)
 	init_rwsem(&env->bpf_progs.lock);
 #endif
 	env->kernel_is_64_bit = -1;
+	mutex_init(&env->lock);
 }
 
 static void perf_env__init_kernel_mode(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 83e74328798f..6aaf80c640bd 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include "cpumap.h"
 #include "rwsem.h"
+#include "mutex.h"
 
 struct perf_cpu_map;
 
@@ -156,6 +157,8 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
+	/* Protects lazy environment initialization (e.g. os_release, e_machine). */
+	struct mutex		lock;
 };
 
 enum perf_compress_type {
-- 
2.54.0.929.g9b7fa37559-goog

