Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BC2DE6F1
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998117; cv=none; b=m1pQ8vxxaMDKF/w3bM2dfd8cNNoMsyTbOwSkgyZAvxMBiqNI8An+OKhrUP/WOaY+QeuBBpsHtNCHgHC4RGKiMppW3mKnI+gzd87ByTh0ipoKBV8CmIRFrCw35bV55WT5J881E6az/Fl70H47d9rvPMglDkzOsn8RpZmR427N6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998117; c=relaxed/simple;
	bh=ivk1kCPJFe/BzZPF72WSq3DpdkZ7hkdmk3r9ydq31tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrcD0l3MbQ7AP8m0/0cynRL31elq8I2/9JBF/dq72Pm7Uz1m84x8Z2+YK7qFgK9WMl7eFOo1MhfNq9aiuLCQSEK95y3x0ukt3tw3P4bWkJLXuC58AS73yWAGgr6rCiuomyNfrm2r10ZDC5m+WOUECXaWY0HgoLK5lp6dftgh48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldcgaDct; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldcgaDct"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54abd46747so3493209a12.0
        for <linux-s390@vger.kernel.org>; Mon, 15 Sep 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998114; x=1758602914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=ldcgaDctXOfgSLf64W5XTkXL3DEk6cNTh/hZtEwwAoIMEXJ7nBBWetX01vNPBw3b9W
         jZDo/ihzinvGc71TxgSzbCWg1MkINwXVj+isFkr0JB682qWP40CLk9GcO4jjh8/pDWu7
         KuRU9hXBGyaKtbD3e/8dqL4Vb9A8A1Cl1Ci87LIjq6sFmpY+k+tnzg67+pGgYhPjGDUQ
         ++nwCK/Qi6G1Yem5BVlYpjZZKxqRdvGMMs6FpSW/SQlCGwMbnWL0p7yJ4CdB+XR1KlBY
         zgLgJHEOAdHxuTL+O/NFH4O8mWv/mnq4ZzNT2O8rhaM3p0qyK/3C9A2C2JE/av0S2fQt
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998114; x=1758602914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=Ju9pKNHyAcR0/0/I8lFyGgTVuiyVb1R9IH/OfsaMQFYKmptBVQ/gizfHAIw3Oq4naD
         iJIBVdOwUejrTPWcBEbyDQYunGq4RI+k3Paj8eVE3jaFGopcBgvnkRomyo5yU/dhwzpl
         n4wkQQHK2xOoIYSVwrTTNbMRE2jJr3aaX9wPsxmR6ZmvDR+HPJGrw7kSVI00e5VaAp4g
         cJYXTFfpGQpneOMRVKn4PCabaudMX3b61IX3+HOpKNedFBBNLZJPe9i0v8/yr769RNo+
         UMA1sYKhiDqwjWYJRHvn0RT8SES19zvYAsFMHDDTYf3cgI38/UZ+atILvga+qL1oFCQV
         zPCg==
X-Forwarded-Encrypted: i=1; AJvYcCUiMt3wwJCNamjUcxXLccFY75DpdHe+nbpqebmKc3kSXc7G1DkNbK5kJk4mPPnOU6dhlWAaEijjAnsc@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjN5Mz7/DohY7WlUNKDIukPkH7eShmu6bhFnmyy1UMph5w0du
	7nXTzXuKTot/TQv4tjGg1uFiXwp9Z/jKqV9O7swnW7jwoSO+xErF1MA0
X-Gm-Gg: ASbGncs4nSAirgLHaVAEMIoCdnb7gBiGJVYDM2ciCzl9TQtYt2pxYpVqTF07i+aXRyu
	kjUcQ9xi8FMwikPFh6v8gNfvgNMlEPulVM8WfCz1opZoOitrb8ZFCHbHxBcbcZGDGVzgesjlr9P
	Kd8qSxZlHmf3Hc2LeO0aAnRVUndONPf2LCiHpq8Xr5SxfBARq173eNNDZPqX2+EH7zpzfMDmNKR
	9Subu8WvZJ/Kt6d/jTAf2prY8yNeLZZcwuRNwFR73e/YHDEmyI0jHbdmynXoK1+PeiVS0iHdXdf
	W+SlenSR75pV9C4+7sH66GruiY20CD7J+8w196eQAX1h8UGKdMjMvkBPUEu/V9pa8//r62Pxlg6
	ifb+wSz2f1IY4MlyWiV6m2mzGSF9UYgH2SYsHcp0=
X-Google-Smtp-Source: AGHT+IF+n/WS6RKuYlQuLpfTYPIbA2M/p4imTXrTMvTksxJg/G6gJFeTxjjE/2igpzRcFyrC5Ibdeg==
X-Received: by 2002:a17:903:3585:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-25d2771f4admr137080665ad.61.1757998113981;
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 03/14] fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:24 +0800
Message-Id: <20250916044735.2316171-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
-- 
2.34.1

