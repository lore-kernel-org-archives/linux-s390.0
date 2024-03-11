Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696912C6B2
	for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149686; cv=none; b=g3ggHOxDgQNVhA5TTmvPHZrZI/n9wTOIZefii7EJkaZS7sPW1szHQKt3rvIcuk1Nimr4gsO6U0TJ0+YuxUkiDOhCMlBGfcE/64PykGc4/SyJl2QMf5sbFrQm8nvFZ8XhBT5utm+LMqHRLu0cY4XiJ8aW903LwiXl3wwTXNCIcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149686; c=relaxed/simple;
	bh=gPSHW2/9unWuAhFncICuut3hiBk/07uto75Q0YZZP+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biJXjmZXbkD/q5aiJ3Fl/c+9HCuD3G1O2ASkMoWyx791t6RXWQ+P3KzWcYnFBBImjT8dyFCFxFnK9taUAH40JxkgwYiP4+wDkwEkY0Axh2nfVMhHEDeIhCoq0UDseoX2SeE+/s+0wnkCtwRoOCLLcUZ0hzDcX7Xu8uBVzn9Vtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fCndtFff; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fCndtFff"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e676ea4e36so1807270b3a.3
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710149683; x=1710754483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjSWV41JlB3dq7HwIpKEF4e0TQa/o2d+dOhHoSuTF7U=;
        b=fCndtFffu1Ss2NcYN91svt0lbgvg/8XEuiKcZFBYKp7qeeF+XLcmbg+m63YznekLld
         GRZI7k/jvSHxYlpUhAl51sQNowp1tN0KStmqyTY58z+irKn+wdBqUqbuygyeyIrgBtEU
         t5F747/SOt7yRqdumXdtJrM2+s7N27vDv/23Tc/kpoR86DnCGK5aM5jRiUfNM2R9d8LX
         QXoebEhGQoGQzulAGDVWHrS43KwnxkOLJvXdDsl3XESVcCGBiArmh9gtRJBpz5sElNA/
         Moey35A9/O63/cbjNgddzv+E44rO0Q1G7dbN91co4eRiYSx6W5P9WJ8/6UKao6Mbsq+6
         sEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149683; x=1710754483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjSWV41JlB3dq7HwIpKEF4e0TQa/o2d+dOhHoSuTF7U=;
        b=xMSbO7cilrNIx/YaBonqj6VzE8C7n5z9+JMi8RwdJma6i4B3An5cWNtRp41qaNcc5M
         2VG6q7ivDFjCDSBSKS2k6Kfge2/9IGgmU4MDU+SsHKJFMF5zPkYr7Z8NXiFiD3EPuB0u
         ZaMF68NeZckkj6VIS5r4y4FWN4VOVqRJqnheCD5/gjEpeLq6ceNjsxPYdFt5KDJB0NUX
         zB5i84aIHi6I6tMO3uhxVTganCNJcrokoj57oPq56/2BN0JdvuqQocMhl3F2LEJzkC3H
         70H5KxX36j+fR94JdTTxSyAb/BjcR5rIksfH7YrNQiGydXY4GELfR7mBffhggDbrtQoT
         ZANQ==
X-Forwarded-Encrypted: i=1; AJvYcCX62P7gfPanYvHiPducScCzva3PHxEzC+XC3goOIVpNnUkmZO5Oy+yQiMw5Znw1u+b9Fps9nMJQtqqtiKOPcUn3P5fe4ac6x5reWg==
X-Gm-Message-State: AOJu0YwFynhll9fSuus6AdW8VMWjwG6GzwUwo2i/HlEvA4mi28Qz1zya
	nFNMN0jTcnPKlGvbfh12PWKGoh/sykmR3Azp1peQp9eELe3P0iMsOUgE+8Ij+HA=
X-Google-Smtp-Source: AGHT+IFbj6YfcHBYvXMM2NWizkuYpniqg3bImjqE4WhHnt6u4m7Hz7unmoAwRceekSZcHEkG6VDAnw==
X-Received: by 2002:a05:6a20:438a:b0:1a1:431c:6696 with SMTP id i10-20020a056a20438a00b001a1431c6696mr4574882pzl.49.1710149683554;
        Mon, 11 Mar 2024 02:34:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm4253365plw.239.2024.03.11.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:34:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/9] bpf: refactor the modules_array to ptr_array
Date: Mon, 11 Mar 2024 17:35:19 +0800
Message-Id: <20240311093526.1010158-3-dongmenglong.8@bytedance.com>
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

Refactor the struct modules_array to more general struct ptr_array, which
is used to store the pointers.

Meanwhiles, introduce the bpf_try_add_ptr(), which checks the existing of
the ptr before adding it to the array.

Seems it should be moved to another files in "lib", and I'm not sure where
to add it now, and let's move it to kernel/bpf/syscall.c for now.

Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
---
 include/linux/bpf.h      | 10 +++++++++
 kernel/bpf/syscall.c     | 37 +++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
 3 files changed, 54 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0f677fdcfcc7..997765cdf474 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -304,6 +304,16 @@ struct bpf_map {
 	s64 __percpu *elem_count;
 };
 
+struct ptr_array {
+	void **ptrs;
+	int cnt;
+	int cap;
+};
+
+int bpf_add_ptr(struct ptr_array *arr, void *ptr);
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
+
 static inline const char *btf_field_type_name(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f63f4da4db5e..4f230fd1f8e4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -479,6 +479,43 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
+int bpf_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	void **ptrs;
+
+	if (arr->cnt == arr->cap) {
+		arr->cap = max(16, arr->cap * 3 / 2);
+		ptrs = krealloc_array(arr->ptrs, arr->cap, sizeof(*ptrs), GFP_KERNEL);
+		if (!ptrs)
+			return -ENOMEM;
+		arr->ptrs = ptrs;
+	}
+
+	arr->ptrs[arr->cnt] = ptr;
+	arr->cnt++;
+	return 0;
+}
+
+bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)
+{
+	int i;
+
+	for (i = arr->cnt - 1; i >= 0; i--) {
+		if (arr->ptrs[i] == mod)
+			return true;
+	}
+	return false;
+}
+
+int bpf_try_add_ptr(struct ptr_array *arr, void *ptr)
+{
+	if (bpf_has_ptr(arr, ptr))
+		return -EEXIST;
+	if (bpf_add_ptr(arr, ptr))
+		return -ENOMEM;
+	return 0;
+}
+
 static int btf_field_cmp(const void *a, const void *b)
 {
 	const struct btf_field *f1 = a, *f2 = b;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..791e97a3f8e3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2873,43 +2873,9 @@ static void symbols_swap_r(void *a, void *b, int size, const void *priv)
 	}
 }
 
-struct modules_array {
-	struct module **mods;
-	int mods_cnt;
-	int mods_cap;
-};
-
-static int add_module(struct modules_array *arr, struct module *mod)
-{
-	struct module **mods;
-
-	if (arr->mods_cnt == arr->mods_cap) {
-		arr->mods_cap = max(16, arr->mods_cap * 3 / 2);
-		mods = krealloc_array(arr->mods, arr->mods_cap, sizeof(*mods), GFP_KERNEL);
-		if (!mods)
-			return -ENOMEM;
-		arr->mods = mods;
-	}
-
-	arr->mods[arr->mods_cnt] = mod;
-	arr->mods_cnt++;
-	return 0;
-}
-
-static bool has_module(struct modules_array *arr, struct module *mod)
-{
-	int i;
-
-	for (i = arr->mods_cnt - 1; i >= 0; i--) {
-		if (arr->mods[i] == mod)
-			return true;
-	}
-	return false;
-}
-
 static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u32 addrs_cnt)
 {
-	struct modules_array arr = {};
+	struct ptr_array arr = {};
 	u32 i, err = 0;
 
 	for (i = 0; i < addrs_cnt; i++) {
@@ -2918,7 +2884,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 		preempt_disable();
 		mod = __module_address(addrs[i]);
 		/* Either no module or we it's already stored  */
-		if (!mod || has_module(&arr, mod)) {
+		if (!mod || bpf_has_ptr(&arr, mod)) {
 			preempt_enable();
 			continue;
 		}
@@ -2927,7 +2893,7 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 		preempt_enable();
 		if (err)
 			break;
-		err = add_module(&arr, mod);
+		err = bpf_add_ptr(&arr, mod);
 		if (err) {
 			module_put(mod);
 			break;
@@ -2936,14 +2902,14 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 
 	/* We return either err < 0 in case of error, ... */
 	if (err) {
-		kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
-		kfree(arr.mods);
+		kprobe_multi_put_modules((struct module **)arr.ptrs, arr.cnt);
+		kfree(arr.ptrs);
 		return err;
 	}
 
 	/* or number of modules found if everything is ok. */
-	*mods = arr.mods;
-	return arr.mods_cnt;
+	*mods = (struct module **)arr.ptrs;
+	return arr.cnt;
 }
 
 static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
-- 
2.39.2

