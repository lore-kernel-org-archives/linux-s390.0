Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A41C861A
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427195; cv=none; b=Kl33ltRkgWxMs6A6jAmmbEADu1jecMmVzCWmxJFSsIq8zOP9s/0easRD6voLYIr4whJO++EAr1+5reaajc+UAaSXSbJ4jh8KRVusHiSPfaibAqVWm2Vo4Mo/IG4oXuOoYgTX8wA4Vm8CeqTLpEULEjB72QQuREimY7jGU1pWH84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427195; c=relaxed/simple;
	bh=etp4AMH2OQmob84q8bUOs7G4hi01cPhOKCQq5Q75efg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVmAxhVpQauZExLlhJ5skGNhGyXyIdZnjETETf/hrmF9rPDbpSMYxkKboXMxIQ0PJ5nk5TzOe7ekONpgM6wWM7Ed4dZBDFFiEA9esQkJuqoyw/3iFF5lBB8Dld5HG5ZcXm1ii4HrEgBdfxr8HSLqY7u7tkTiVFaAGUK3kJmcKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=yCipCt6V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="yCipCt6V"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-299e43c1adbso2068855ad.3
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427193; x=1764031993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91s7wPZYsCFfnXF0eFI+QzjXw5p2I5wMgfHJ2UFA8aM=;
        b=yCipCt6VY9PmFwhYoBO+3v34E+oMOOlurtgwioEtGnT0UZXbmruM7tnUBKZQkUxPBn
         2RN2Hj4fbmHfGeqNJilarZOLfmsQHXbQyX6lci8DO5Z90BJ612e+qn80y+stFc04RCRw
         xW4xDrVxF/CC0M0MdxNr5jPQU7eq0Ujno0HeSYwGRSFhkZW1gX5qEd6W8cEe0s67KPhZ
         8gs04DrtKbUm1ipltWEnreFvrf3G4z5O//O1c/TJXoxdKb5VsbtYK5G0apJHWpW3qJUM
         lzV7Y2P9hs4POzyGuT2O5HDemQOaLty2Z2KsEs3Qx1CS5wJ1LJjVlQKkUtXkBQDtT5Sg
         q0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427193; x=1764031993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91s7wPZYsCFfnXF0eFI+QzjXw5p2I5wMgfHJ2UFA8aM=;
        b=xAuECOoxKIUYijHwHd2pUwf0vNqii1T+G5cZ+P8SYrvjZHcMmYXPxRsFNBm6QGEJYq
         00yQVVYWE+Yx6rObKrU7W2fuj4oqM4SWxLR083kdJWzrmJTVU93NPTGT+5VL+neCaSgV
         wdAHeD3PXFLYr8by8JTveHj0LH5xFvTbplrZGzUCF6FxtrE1z+hNuwZ6WrnabbAfgkUZ
         OrODzsrPobWNG2wzSWvoZDjLHT/W8irPI+VUCbn1r9WhtD32QLpw9ySxA6rbGEnYwlva
         YQie2Cr2iAAmoi7dy77poAuLaGsCho4W6pr8TOwBDw98XuwFDr4qJU9GV/UhRG1IgEUG
         nScg==
X-Forwarded-Encrypted: i=1; AJvYcCX2yVXmBkE7OK0P4daVw0y9v2z/U9fKuxBiu9gBway9MxM+NzzdFRMxQg9DHCwR4FXDqWomi0FUIdVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZhFRW61V8WDfCGkhLu3/bUyeBMVfJ1EqsE8cGubgbOe5G4eQ
	u4wBEacP4pkklxW7oy9IZrebczFrQ/6af5lYwTufThQskdIyuwhEwS9snLCq1FLFu2Q=
X-Gm-Gg: ASbGncsOweuc86I4m7K9l1q3Qtr2Law53MOIsWumrHC4yvHX/NioRD48Oe7tdqudt5e
	5mgYx1VnneWHJX/X1OVf+jM9lV6rJOU/ahpBFJFd5gdjOpZ1UfQ+lBdBswaFDdJI7PewKcZNC5F
	fThfACzjpcxmyD0jHxF1MSwbKmHRtRHPfEyvXIiVyI2S5OrO5Yiml7g/dirExjUS0LfSsfYWs8B
	IFh5CXvlq4cqdbHAAZ1YldBIhoRg7Psb3IWu8rTyXmiSiREOQ4bLOxkso1H/cfsuu6JWzh+JETc
	h7KktR8eO9/DzZU+oKwDDPabDC4Tp6VNeYD4MaxS+Hw2XA8d0XvHdMRQV6lQAn6CQJmDEQGARcm
	Rg0qBqc2tA93vDCh0XF0YVKQ9S/6OtWF/qGQ3mr+06BzzPNpSrFVAbYYoxp9uSQyQ
X-Google-Smtp-Source: AGHT+IH12IkveR/gco1bqwDQB15yRJ3JRqgOk92225QmojU5hVd1CdeAFKQltQrwcUzwsCCpadEwxA==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474659eec.2.1763427192879;
        Mon, 17 Nov 2025 16:53:12 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:12 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for bpf_tracing_link_lops
Date: Mon, 17 Nov 2025 16:52:53 -0800
Message-ID: <20251118005305.27058-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type and expected_attach_type of the new program must match the
original program and the new program must be compatible with the
attachment target. Use a global mutex, trace_link_mutex, to synchronize
parallel update operations similar to other link types (sock_map, xdp,
etc.) that use a global mutex. Contention should be low, so this should
be OK. Subsequent patches fill in the program update logic for
freplace/fentry/fmod_ret/fexit links.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/bpf.h     | 11 +++++++
 kernel/bpf/syscall.c    | 68 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/trampoline.c | 29 ++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09d5dc541d1c..23fcbcd26aa4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1420,6 +1420,9 @@ static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u6
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 			     struct bpf_trampoline *tr,
 			     struct bpf_prog *tgt_prog);
+int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
+			       struct bpf_prog *new_prog,
+			       struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 			       struct bpf_trampoline *tr,
 			       struct bpf_prog *tgt_prog);
@@ -1509,6 +1512,14 @@ static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	return -ENOTSUPP;
 }
+
+static inline int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
+					     struct bpf_prog *new_prog,
+					     struct bpf_trampoline *tr)
+{
+	return -ENOTSUPP;
+}
+
 static inline int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 					     struct bpf_trampoline *tr,
 					     struct bpf_prog *tgt_prog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f62d61b6730a..b0da7c428a65 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -63,6 +63,8 @@ static DEFINE_IDR(map_idr);
 static DEFINE_SPINLOCK(map_idr_lock);
 static DEFINE_IDR(link_idr);
 static DEFINE_SPINLOCK(link_idr_lock);
+/* Synchronizes access to prog between link update operations. */
+static DEFINE_MUTEX(trace_link_mutex);
 
 int sysctl_unprivileged_bpf_disabled __read_mostly =
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
@@ -3562,11 +3564,77 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 	return 0;
 }
 
+static int bpf_tracing_link_update_prog(struct bpf_link *link,
+					struct bpf_prog *new_prog,
+					struct bpf_prog *old_prog)
+{
+	struct bpf_tracing_link *tr_link =
+		container_of(link, struct bpf_tracing_link, link.link);
+	struct bpf_attach_target_info tgt_info = {0};
+	int err = 0;
+	u32 btf_id;
+
+	mutex_lock(&trace_link_mutex);
+
+	if (old_prog && link->prog != old_prog) {
+		err = -EPERM;
+		goto out;
+	}
+	old_prog = link->prog;
+	if (old_prog->type != new_prog->type ||
+	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&new_prog->aux->dst_mutex);
+
+	if (!new_prog->aux->dst_trampoline ||
+	    new_prog->aux->dst_trampoline->key != tr_link->trampoline->key) {
+		bpf_trampoline_unpack_key(tr_link->trampoline->key, NULL,
+					  &btf_id);
+		/* If there is no saved target, or the target associated with
+		 * this link is different from the destination specified at
+		 * load time, we need to check for compatibility.
+		 */
+		err = bpf_check_attach_target(NULL, new_prog, tr_link->tgt_prog,
+					      btf_id, &tgt_info);
+		if (err)
+			goto out_unlock;
+	}
+
+	err = bpf_trampoline_update_prog(&tr_link->link, new_prog,
+					 tr_link->trampoline);
+	if (err)
+		goto out_unlock;
+
+	/* Clear the trampoline, mod, and target prog from new_prog->aux to make
+	 * sure the original attach destination is not kept alive after a
+	 * program is (re-)attached to another target.
+	 */
+	if (new_prog->aux->dst_prog)
+		bpf_prog_put(new_prog->aux->dst_prog);
+	bpf_trampoline_put(new_prog->aux->dst_trampoline);
+	module_put(new_prog->aux->mod);
+
+	new_prog->aux->dst_prog = NULL;
+	new_prog->aux->dst_trampoline = NULL;
+	new_prog->aux->mod = tgt_info.tgt_mod;
+	tgt_info.tgt_mod = NULL; /* Make module_put() below do nothing. */
+out_unlock:
+	mutex_unlock(&new_prog->aux->dst_mutex);
+out:
+	mutex_unlock(&trace_link_mutex);
+	module_put(tgt_info.tgt_mod);
+	return err;
+}
+
 static const struct bpf_link_ops bpf_tracing_link_lops = {
 	.release = bpf_tracing_link_release,
 	.dealloc = bpf_tracing_link_dealloc,
 	.show_fdinfo = bpf_tracing_link_show_fdinfo,
 	.fill_link_info = bpf_tracing_link_fill_link_info,
+	.update_prog = bpf_tracing_link_update_prog,
 };
 
 static int bpf_tracing_prog_attach(struct bpf_prog *prog,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..010bcba0db65 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -610,6 +610,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	return err;
 }
 
+static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
+					struct bpf_prog *new_prog,
+					struct bpf_trampoline *tr)
+{
+	return -ENOTSUPP;
+}
+
+int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
+			       struct bpf_prog *new_prog,
+			       struct bpf_trampoline *tr)
+{
+	struct bpf_prog *old_prog;
+	int err;
+
+	mutex_lock(&tr->mutex);
+	err = __bpf_trampoline_update_prog(link, new_prog, tr);
+	if (!err) {
+		/* If a program update was successful, switch the program
+		 * in the link before releasing tr->mutex; otherwise, another
+		 * operation could come along and update the trampoline with
+		 * the link still pointing at the old program.
+		 */
+		old_prog = xchg(&link->link.prog, new_prog);
+		bpf_prog_put(old_prog);
+	}
+	mutex_unlock(&tr->mutex);
+	return err;
+}
+
 static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 					struct bpf_trampoline *tr,
 					struct bpf_prog *tgt_prog)
-- 
2.43.0

