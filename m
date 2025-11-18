Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D392FD1BC
	for <linux-s390@vger.kernel.org>; Tue, 18 Nov 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427197; cv=none; b=PKM0uh0z6dIR/gDL+gfzMK0o7bFh0RcSoOUGXeW8LXuZs7iR9pOJLc8DmqTT8cgrRNKkpkqGfWHob3JN2osjGoBQ6WLHQqdijd55bougO9YLGG+TQlVyI6KvOoaCNv4Aqbo+OAFrvbpOThVWs8g9oK9BVA116eNwGOVDryi6cB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427197; c=relaxed/simple;
	bh=g1uLFslNgKlYCLYRXudOesC52+em0G+2nP7Ib2wuDMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFGCYmPJwc5UQHPn6pVEnqxpgUSPqE2iRzq1F+1JaqdDEylKbQlBrsca1y3U1Lko1F2byuzCOXgnsfU7YFrKJ61Gqd6L7YR3w0msozUt1PKVWdMp0gsdg0ml4+NKhH3nVos1oMoJehDQu1lhnYCdP3DOUzQ89bHQYAf45+tOR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=DmPqphov; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="DmPqphov"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-299e43c1adbso2068955ad.3
        for <linux-s390@vger.kernel.org>; Mon, 17 Nov 2025 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427195; x=1764031995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqtHILsF2TAT2qFB8P2xd62Q4NmwrffJGJ2M75+ke/A=;
        b=DmPqphov3TUfikh4R0SllIXXtju4Nn/vldpfeWdy8mxa3UHcduxRHzs6TqZmXehQNO
         dA8qjPrMaz+viChicnH3HJ3/qSWmFHnckay5DUDEy3biJtqWVvZK98cOsEP6SDUUmfWI
         5XDv7CWjJNwVuaIKOnNdQMKdFrR05KOz9xsUJPAsDnF54bCQVfVpDOtbl9AsF2xbynBs
         O9zWBZZFnZHcPxxnmTyq+D4e0XiQCugV88e0eoaHw/AeFHjFKC4zgzBtVqP0PlaYvvLJ
         /VWVHUSTsEnpmV1Z1+6U9/V6KVO4q+iddjCgzEusAIVMO4LRPYHhOzMfRe5oazvsI5sz
         0zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427195; x=1764031995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqtHILsF2TAT2qFB8P2xd62Q4NmwrffJGJ2M75+ke/A=;
        b=mbVXptaTH6pTu61tOjbbAdwpQxhEFXTJRR65KdFlgkcUez7pwa0FtG9K+lbAZpsg4i
         QYpEsWmVOz8ynK3rv/zaWx6WTymYX6vfv4rzwySG8TDp/zRpw7CR9wcvO6Re+YWe8zfd
         5K+W2UxV4ZzWdw1ZFXXU6T716/pHxRkjtt3ObHif6Rw2GA56mCWXxuEzjkHmHh4lkfWU
         QOHqCSduFRDwGdck9WZtsFIS1pEH5/5Im45jCKXpwrsgDBfmXE+3w3tpPRkCY4JcZ2dn
         Cco4k8R4OnWcYTfAXZ4n37amqRQrYJdSUZdEXBVETkQAh3yGxVVmhdsQHyNMEQQ349Zm
         Jl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQLksfcIP/9decL+l3x+TzqAdUqxNbQvBNYk+KctKErCX3RJGGPYmlJKMIW8pndtzYsk7El1ZPPkYO@vger.kernel.org
X-Gm-Message-State: AOJu0YyFX9vZqcss121vXWCJJaHqBrt4QeEa++MEobTeJ/L8kNDC9mPs
	jzDY3lUK7L4NnBLUPNTjEhTOVvk8Kv5x+oD2QJ0n655HY8kaj3avB7HI0XB8R1rAoUYx/RrWNvb
	LiE8l
X-Gm-Gg: ASbGnctNr9kHfx/hX3AOaP5WDiscVTEAIaAdUE0t4pMGc0VEneypjZNzDE6jnUKKrMz
	ZKNMmKKWUyUF+VgLgBMZnvLCcJdnKtSo+OAGnMj2TuRQ8MZfdtMvirSp2RelKr/xxEIXUOjObpr
	jmUfDulOLdachymtVeYUH+8GWcm4NWOp8eNYbrgntbJKx9BbOViqLJsRgO8NK3bvNg5jIphgLaj
	g7iVjHBsKxTtQEg1zJQxdOQZHV/5CrezhGis5X7Y33ikIaxxxTJYAbB2uQ3wV60/tc+3MfKb0lI
	IZkMkvZYhddyikqZ/2Q2GKXY4fQjGYzMvc0M+qdY5xuB4I2tDKVpAxkOtoI2/hcSJET6aWgs/gq
	DlCduFGj29hVS4MrGu5UH5t4q8T2vNYPLQA4R7wU8BfehKEhOj+IGboJIR9j4Q11ASZS+Xfg3X5
	U=
X-Google-Smtp-Source: AGHT+IFJPILg18zJQZC0TW4P7pXEkHzpuOhLWUEFhxqpAVjTKvXaGm1YV+XYqv2kf00AJGzo/HV8dA==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474689eec.2.1763427195139;
        Mon, 17 Nov 2025 16:53:15 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:14 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 3/7] bpf: Enable BPF_LINK_UPDATE for fentry/fexit/fmod_ret links
Date: Mon, 17 Nov 2025 16:52:55 -0800
Message-ID: <20251118005305.27058-4-jordan@jrife.io>
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

Implement program update for other link types supported by
bpf_tracing_link_lops (fentry, fexit, fmod_ret, ...). I wanted to make
the implementation generic so that no architecture-specific support
would be required, but couldn't think of a good way to do this:

* I considered updating link.prog before calling bpf_trampoline_update
  and reverting it back to the old prog if the update fails, but this
  could create inconsistencies with concurrent operations that read
  links where they see the uncommitted program associated with the link.
* I considered making a deep copy of the link whose program is being
  updated and putting a pointer to that copy into tlinks when calling
  bpf_trampoline_get_progs where the copy references the new program
  instead of the current program. This would avoid updating the original
  link.prog before the update was committed; however, this seemed
  slightly hacky and I wasn't sure if this was better than just making
  the architecture-specific layer aware of the intent to update one of
  the link programs.

This patch sets up the scaffolding for trampoline program updates while
subsequent patches enable this for various architectures. For now, only
x86, arm64, and s390 are implemented since that's what I could test in
CI.

Add update_link and update_prog to bpf_tramp_links. When these are
set, arch_bpf_trampoline_size() and arch_prepare_bpf_trampoline() use
update_prog in place of update_link->link.prog when calculating the
trampoline size and constructing a new trampoline image. link.prog is
only updated after the trampoline update is successfully committed. If
the current architecture does not support program updates (i.e.
bpf_trampoline_supports_update_prog() is not implemented) then the
BPF_LINK_UPDATE operation will return -ENOTSUPP.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/bpf.h     | 10 ++++++++++
 kernel/bpf/trampoline.c | 33 +++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 23fcbcd26aa4..7daf40cbdd9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1215,6 +1215,8 @@ enum {
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
+	struct bpf_tramp_link *update_link;
+	struct bpf_prog *update_prog;
 	int nr_links;
 };
 
@@ -1245,6 +1247,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
 				void *func_addr);
+bool bpf_trampoline_supports_update_prog(void);
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
 int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
@@ -1840,6 +1843,13 @@ struct bpf_tramp_link {
 	u64 cookie;
 };
 
+static inline struct bpf_prog *
+bpf_tramp_links_prog(struct bpf_tramp_links *tl, int i)
+{
+	return tl->links[i] == tl->update_link ? tl->update_prog :
+						 tl->links[i]->link.prog;
+}
+
 struct bpf_shim_tramp_link {
 	struct bpf_tramp_link link;
 	struct bpf_trampoline *trampoline;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0b6a5433dd42..0c0373b76816 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -230,7 +230,10 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 }
 
 static struct bpf_tramp_links *
-bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr,
+			 struct bpf_tramp_link *update_link,
+			 struct bpf_prog *update_prog,
+			 int *total, bool *ip_arg)
 {
 	struct bpf_tramp_link *link;
 	struct bpf_tramp_links *tlinks;
@@ -250,6 +253,11 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
 			*ip_arg |= link->link.prog->call_get_func_ip;
 			*links++ = link;
+			if (link == update_link) {
+				*ip_arg |= update_prog->call_get_func_ip;
+				tlinks[kind].update_link = update_link;
+				tlinks[kind].update_prog = update_prog;
+			}
 		}
 	}
 	return tlinks;
@@ -395,7 +403,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	return ERR_PTR(err);
 }
 
-static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+static int __bpf_trampoline_update(struct bpf_trampoline *tr,
+				   struct bpf_tramp_link *update_link,
+				   struct bpf_prog *update_prog,
+				   bool lock_direct_mutex)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_links *tlinks;
@@ -403,7 +414,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	bool ip_arg = false;
 	int err, total, size;
 
-	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	if (update_link && !bpf_trampoline_supports_update_prog())
+		return -ENOTSUPP;
+
+	tlinks = bpf_trampoline_get_progs(tr, update_link, update_prog,
+					  &total, &ip_arg);
 	if (IS_ERR(tlinks))
 		return PTR_ERR(tlinks);
 
@@ -506,6 +521,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	goto out;
 }
 
+static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
+{
+	return __bpf_trampoline_update(tr, NULL, NULL, lock_direct_mutex);
+}
+
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 {
 	switch (prog->expected_attach_type) {
@@ -629,7 +649,7 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
 		return 0;
 	}
 
-	return -ENOTSUPP;
+	return __bpf_trampoline_update(tr, link, new_prog, true);
 }
 
 int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
@@ -1139,6 +1159,11 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
 	return -ENOTSUPP;
 }
 
+bool __weak bpf_trampoline_supports_update_prog(void)
+{
+	return false;
+}
+
 void * __weak arch_alloc_bpf_trampoline(unsigned int size)
 {
 	void *image;
-- 
2.43.0

