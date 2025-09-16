Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F472E1F1F
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998136; cv=none; b=AkWeOoqZUM/icIzrqZEW7+FcZvC982tJEmfefwRwdzhFLq6W/QT5lFwQF0h01ec0WJs6w34Jsu0cGGGZfLx2TLPjTPs0tGIX4946eBDwdEjqaoa8ccbF/V1jMOgsxGObvQuzLr9EBWWhaYB7PdvtvfxlUAlIVjObCIRpP3+k7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998136; c=relaxed/simple;
	bh=p5MwokYTH6tczJBsI6u40p8nW7EOrH93nmvNjBcj/D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odbBUcudNmkiuueiDDJelItHazcotUvoLpQzGSDatjXRIgGe+IHwbbdFCpak+M34KQQlz106WCBvE9S5uNHS/BlEL9TkNcxN+aoe3BnBrhdmdSuDnOyZskxcOF9vusx/WuoRpciLN99vrtRx9a/Jatuyyq0EdXqkMS7ryejXkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCCFjF93; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCCFjF93"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580523a0so50861975ad.1
        for <linux-s390@vger.kernel.org>; Mon, 15 Sep 2025 21:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998134; x=1758602934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=XCCFjF93gE03XoD5txrRGrVa2Cinpuf9dfznUDiyWczEqJ/NViO8aFYCASV/tcASm9
         f5KFOsk5PZCVrn0wGqzSUFpGQfS2TXroxKwY3fjm5v8H0MZrmvPS3Gk4K4/flnFXJz9M
         N61WImCcsaO7sx60jDVbpP99sDm3mPAR0JjjBMhWWqCwEhxevWM57VQoKx0jUAuys6Hg
         BSa0+ecSoJQrp2zy0poaIzuSEu9xGk14EO1YJKRLVH06V0aibh7cAHh7R7d/mz+iRgA4
         YlgOoTc5CRsv4uXdgCGLuCJsLNv7Nmpo4RhwTjSBaWgkf6NtdAf5g4bFqPqF54kAKrDj
         Ni7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998134; x=1758602934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=RwVxnzb0uZdKv2lLRTfvFT/zW2s4wEEFy1sOb21/d3maEI/E9E6DL9GY5hL3SYdkFl
         mzQuRzHlf5D7PmKY7haHcX7AUpgz0t2sj2BOiIE+kbYbrWGNGBLBfsfBnMkdxuhyTXEm
         GWojvIdLy99NphqEqSkoEseX5N+ixXDnsTp+FetzJlXvvYvLSQ4S5Q0cRBzxS9lEZRqp
         mLPX/QShQpqK9RZ0EzrCOOVnfMoI9uJFXXE318MvQGoGswdyA3Iqxt9rOFeVaPmX+lT9
         ckogUYzijVnJN/bw5DXoqSXzuGMFsvnPcsYKBnwsdWvSJJhBj/QY+Yrq4BX9cNVHMWGU
         7Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCVgCa2jsCrKbrOknodX/s4K5GGepDdCpqoVF8xdRdQp6LFywvry5Ll6PQL1haa4epk9OzvFWWWqq5Nr@vger.kernel.org
X-Gm-Message-State: AOJu0YxUetVlbSyWs1NlLSKJzuERKTXvjmQZHk7MIlmRiIFvQYHlmJhw
	3H9CqZWs/5hJ991Ojaa2DlbX9gmdBmxP8qdwe07giplo0GS7NoO7r3Qy
X-Gm-Gg: ASbGncuX+hmn/p2rs6SvxGrQr+SVhtoLpzDroE7+DQFZnrrFpZg3ZvEd6X04Qk6dtIS
	mz0RcUqYWqtUPjIGhOgM77ImckL722H1bZAaZ0utkgaSw/KBFRmpqqDbuN1xDyVQBMzbgvjAGbu
	1NBtXoPUYvKtEdYGMw43DLaKAc0YMB45ySfP+Zjraa0+se3GiuRsneWXRmopmFE3teT8niaPwvl
	rf2yDhC6J7qBhNYYh71+HZjisWiewCL7S29uPXEyv4tj0DuLyPWKIQMr3G6NZp9chDbkeSqlTkJ
	c+C9XXXLcdSX3v1uQZR//4vN3MC9kiUay3B7qRuuBUAtp5Sa7WzRdi45JACTFe6H6h+WFXjF1F2
	2yFfUf3ifyWIrpqzqBUTJcUVgLak+6ckQEBWbtT8Q6A5HfNyhdw==
X-Google-Smtp-Source: AGHT+IHsN0GBYzT4MMuIYjW4jOX+BASz3i1Lsko5ULcFSIEXx1CyBAF2xoChVB4z7RicwE9rHAP4nQ==
X-Received: by 2002:a17:902:db02:b0:267:b357:9445 with SMTP id d9443c01a7336-267b35796d4mr43637625ad.28.1757998133829;
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
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
Subject: [PATCH v3 06/14] ipc: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:27 +0800
Message-Id: <20250916044735.2316171-7-dolinux.peng@gmail.com>
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

Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 ipc/msg.c  | 1 -
 ipc/sem.c  | 1 -
 ipc/shm.c  | 1 -
 ipc/util.c | 2 --
 4 files changed, 5 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index ee6af4fe52bf..1e579b57023f 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -179,7 +179,6 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	}
 
 	ipc_unlock_object(&msq->q_perm);
-	rcu_read_unlock();
 
 	return msq->q_perm.id;
 }
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..38ad57b2b558 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -579,7 +579,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	ns->used_sems += nsems;
 
 	sem_unlock(sma, -1);
-	rcu_read_unlock();
 
 	return sma->sem_perm.id;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index a9310b6dbbc3..61fae1b6a18e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -795,7 +795,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	error = shp->shm_perm.id;
 
 	ipc_unlock_object(&shp->shm_perm);
-	rcu_read_unlock();
 	return error;
 
 no_id:
diff --git a/ipc/util.c b/ipc/util.c
index cae60f11d9c2..1be691b5dcad 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -293,7 +293,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	idr_preload(GFP_KERNEL);
 
 	spin_lock_init(&new->lock);
-	rcu_read_lock();
 	spin_lock(&new->lock);
 
 	current_euid_egid(&euid, &egid);
@@ -316,7 +315,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (idx < 0) {
 		new->deleted = true;
 		spin_unlock(&new->lock);
-		rcu_read_unlock();
 		return idx;
 	}
 
-- 
2.34.1

