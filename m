Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453938F94
	for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149701; cv=none; b=bYVfO2FUgLFJ512YTdNOdojc2lSTUjoqMQMcoz+b0xKxS1V8E+F1dSnGJchA5+vGHAFmY6Z+pct77Ip9ZiveVLewFJ7unN5WYPnXvFAgWnfjQ75ih5Kvz6j7FWCoDDwGJtAoMILLvH2/JOOTUVDzrFxbpoYpxvXG3v2QocHwoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149701; c=relaxed/simple;
	bh=TE0qpmdPB+wes4LW3PVEl7Os9qDezEyQM77BodsjCrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJhm3pn71q/pN1eRj+T9zNWyaQ1Y3F0CxXGKeAhnXiHKhGaD+JNvfWlgRW/4R4/8FF8oNJix+7Xnx7oUtz1T1XBOmbhXF9n6K0w6LAjasSy76wkOOM+alW15zBr9kx9JQ+Q2YSQ3gAFfaoWvosdwdnGjQs9Rm78bV4w5aVCyTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=adpl9kIe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="adpl9kIe"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so1585803b3a.0
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149699; x=1710754499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQHWXqakG53bwp/DHGcig31BilBtYFxqqjfUWdtPR6g=;
        b=adpl9kIeZoKs45VwHW8g6CUq/VGzVREUPqjUfsVt7/FJN2vEnM8n/ShhzcJnC4rNrz
         0IehkKKhiHwR+f1CEoQkIMfD8bFCQ9Mc8Qz3YyHqcyt4+jwsBUONCAL4dcRcix4xK9ei
         7XqXA1FRABEGSyWGJGB5ZdPu8yvuUNq7kNsEVhFlSKrQjCEMSvzcXg9JOP+XitxZva/Z
         DXUjXG9ekOBe71+TZng1vW4kVf0wTRluMLo+Yc6D12jY5nXVqXEFAjuC5xo4OT3JSDHN
         1Kw8IiwUHDogxYKBFj/1gxH4phK2gyfH4Ho9yALQK88PnPSqT7YVJ1h3/JrAaXL/BY6q
         incg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149699; x=1710754499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQHWXqakG53bwp/DHGcig31BilBtYFxqqjfUWdtPR6g=;
        b=qWOPuZVLmt+k0m2SjT5pOVrkRU7PD2lj7gOW9Lnn+O6Zdxwahn/alZTjIvg5nWeBkZ
         kiPnpxwr97QpJycN0Ydf08Qhdx9tMq6KRJVRswfaIdY/iYfOXj7oYnAqFL1bBFThWTf8
         efqiJF55AOWzVGe2NoDe1DQRd/pkPoqVt/gMBBVQR48YwABNiXMwp9hMufKprHXKJvYD
         KtVZSDzUU6qFRvxnBpNJbol55BSAM8ytXTJBuINi2CznWgUZShzjQ31wk6nKCze+u0cO
         t0C2uz/mxUoO3Hma23Q7IBKEq8LvN4q41AKesmDMzEXGrG+bMP62uHsklCZQAqDyxxsQ
         sIUA==
X-Forwarded-Encrypted: i=1; AJvYcCW6Mk6Nvi7miL3Sdug4JfT6ENuRocrprXFg0Rinp/Y0KLB0UjLO96DGj8q3LRK13cG2e9yb786unNv0eVorhEeARbC+c+2/d6AhOA==
X-Gm-Message-State: AOJu0YzxG2RqTsRVgfcWejrccncPifbplHP8olOlSNRsW68Sj+kN+znx
	AmhqR9N35AqBsbgmybAsMkq5ya3z+RQmdb3gtmG8aMe15S66+qiBsMjDgeRpUTk=
X-Google-Smtp-Source: AGHT+IHwrlcPzEPWwJhB9wbDVFgwEUaTXK8PIDDimv1XZruHWD6zTTqAqef2QwBY7Qc+7bmyEVvx+w==
X-Received: by 2002:a05:6a20:6f8f:b0:1a3:1d7e:342b with SMTP id gv15-20020a056a206f8f00b001a31d7e342bmr631985pzb.48.1710149698990;
        Mon, 11 Mar 2024 02:34:58 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:58 -0700 (PDT)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	quentin@isovalent.com,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Menglong Dong <dongmenglong.8@bytedance.com>
Subject: [PATCH bpf-next v2 4/9] bpf: trampoline: introduce bpf_tramp_multi_link
Date: Mon, 11 Mar 2024 17:35:21 +0800
Message-Id: <20240311093526.1010158-5-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the struct bpf_tramp_multi_link, which is used to attach
a bpf_link to multi trampoline. Meanwhile, introduce corresponding
function bpf_trampoline_multi_{link,unlink}_prog.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h     | 14 ++++++++++++
 kernel/bpf/trampoline.c | 47 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b5cd6100fc4..4e8f17d9f022 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -57,6 +57,7 @@ struct user_namespace;
 struct super_block;
 struct inode;
 struct bpf_tramp_link;
+struct bpf_tramp_multi_link;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1282,6 +1283,8 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 					  struct bpf_attach_target_info *tgt_info);
 void bpf_trampoline_put(struct bpf_trampoline *tr);
 int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_funcs);
+int bpf_trampoline_multi_link_prog(struct bpf_tramp_multi_link *link);
+int bpf_trampoline_multi_unlink_prog(struct bpf_tramp_multi_link *link);
 
 /*
  * When the architecture supports STATIC_CALL replace the bpf_dispatcher_fn
@@ -1614,6 +1617,17 @@ struct bpf_shim_tramp_link {
 	struct bpf_trampoline *trampoline;
 };
 
+struct bpf_tramp_multi_link_entry {
+	struct bpf_trampoline *trampoline;
+	struct bpf_tramp_link_conn conn;
+};
+
+struct bpf_tramp_multi_link {
+	struct bpf_link link;
+	u32 cnt;
+	struct bpf_tramp_multi_link_entry *entries;
+};
+
 struct bpf_tracing_link {
 	struct bpf_tramp_link link;
 	enum bpf_attach_type attach_type;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index cf9b84f785f3..2167aa3fe583 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -607,6 +607,53 @@ int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampolin
 	return err;
 }
 
+static int __bpf_trampoline_multi_unlink_prog(struct bpf_tramp_multi_link *link,
+					      u32 cnt)
+{
+	struct bpf_tramp_multi_link_entry *entry;
+	struct bpf_trampoline *tr;
+	int err = 0, i;
+
+	for (i = 0; i < cnt; i++) {
+		entry = &link->entries[i];
+		tr = entry->trampoline;
+		mutex_lock(&tr->mutex);
+		err = __bpf_trampoline_unlink_prog(&entry->conn,
+						   entry->trampoline);
+		mutex_unlock(&tr->mutex);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+int bpf_trampoline_multi_unlink_prog(struct bpf_tramp_multi_link *link)
+{
+	return __bpf_trampoline_multi_unlink_prog(link, link->cnt);
+}
+
+int bpf_trampoline_multi_link_prog(struct bpf_tramp_multi_link *link)
+{
+	struct bpf_tramp_multi_link_entry *entry;
+	struct bpf_trampoline *tr;
+	int err = 0, i;
+
+	for (i = 0; i < link->cnt; i++) {
+		entry = &link->entries[i];
+		tr = entry->trampoline;
+		mutex_lock(&tr->mutex);
+		err = __bpf_trampoline_link_prog(&entry->conn, tr);
+		mutex_unlock(&tr->mutex);
+		if (err)
+			goto unlink;
+	}
+
+	return 0;
+unlink:
+	__bpf_trampoline_multi_unlink_prog(link, i);
+	return err;
+}
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 static void bpf_shim_tramp_link_release(struct bpf_link *link)
 {
-- 
2.39.2

