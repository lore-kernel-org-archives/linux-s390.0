Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D891BBBF1
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316897; cv=none; b=doyjQCIOQLzEstQdhtVNesxRartyuTNzFaAupZifC09zkKc9ykh6tljJXkYBaq2CNefjQ/isNkHnDDcYg40xvik6SaffFrulWwqtaCHodyQBqyf82IaODeXRkb41nvDYqp69YkFt3LymucWukGtFKFRASyHeyMmYUAB/ojcLy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316897; c=relaxed/simple;
	bh=DemhL4cc1sp6Aqy2pgRkUydsYoG35xqCQwkgVd3ioow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiY3xXWxrKO8cZ3OQv+Xahmxl1EZd6nOiehoGeUCLGPpnkps9y2PHQFH3wlLUL20zpXxaD1rEn/3O2YEOgFYwaW8PBwnZMfgdbtBFmwCE7XTrrKzMtOHlJ7Vr8+tqlRhLH5RyO6+6q4S7sKjkDVb3r5B5AESdupIjeJ8TY92WxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Atyb2NQW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Atyb2NQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
	b=Atyb2NQWNWizwui7xN8ajltan6FBuyq7UlO65Ufv4ko++YRnx8roJ8zGNfD+AumLy/S7XG
	N9KUc6KW5HyWkqYu5kT4L5sVuIPDFOYjoxOvfPIGCc4kGxuGN23Kstd/2LHZZz0n2gwJtS
	BRDm4RUoE61rgSo3WvPlfKjdJ2FVXzM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-4hUMctOPNfyl3jcHaL7B3A-1; Wed, 04 Dec 2024 07:54:52 -0500
X-MC-Unique: 4hUMctOPNfyl3jcHaL7B3A-1
X-Mimecast-MFC-AGG-ID: 4hUMctOPNfyl3jcHaL7B3A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e173e8d3so1878326f8f.3
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316891; x=1733921691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXGsdvv3AOb25EXWN4EjEJfR5qBP9EzuVcsjQaH9awM=;
        b=PXBx+nrz5IO1QBtEMowgpaIIzp0qQE6OKcHc4DIqMMi7MkK0Vt3xQgmCrA12YgfHft
         t3siAXPXcnX/t+aC+S8UKFnzE4bi3jEn2k6lo8GJ0kmVgbTR8xPreG6c8CDIoEYiiCgQ
         7XZmjZ3x8ZaNQEeMEPBnjIaS+CZfrqNXqzEZtf3ilDZ5qeuDVcgWp14x6+a2a3tJzGac
         5Yy3NmBMW+KXLMz5vn+ti6UJzGbYfauyaggzrrZ4tJhtLe2vZEWO5QXT6bH7mZDoX37H
         O7X/lP8IAQC0PpL9LsTRApzRd45vCX9npZOn+YkVG/wuvj1kkuJWx2vEfuZckblDcqOW
         H3AA==
X-Forwarded-Encrypted: i=1; AJvYcCXHQ42Hb63d5xUggKIJLW+eg6vLz4dyeCjfo7byxRRpAwy6wDdphCUrumCVbuBmHMA91ogHOmXLZwn3@vger.kernel.org
X-Gm-Message-State: AOJu0YzuixS7bwkmDDsw5bjG4FkDx1uU2QY813FwDL4xl2jM9kSrjago
	rg1Kh5qqAuExNoObz6wSbRXrl9LiCJS5hukFYj/sIVLBu/8fDWExBmhr7Uxs523/c5gokyHZSCa
	i0MFw4pEpS4kUK4LyVToH3hGXKrIoWNCWhFZprvBgqgghSBEiGLfM6rbkhDc=
X-Gm-Gg: ASbGncsMQPyX27jYfHKZmeZO8q8rm1/q8qVf6/LfG4EflFUm6+Dj+rBk6+PEwMIPqa7
	tI2bo52cE7Fldlm4CDMUgdS4OTavdVBkeQU9hs/mfdUQT6VdCMcwuscAKDMjDZJ6EnLk2KaNfTk
	l8b9qVcL53r0RmSdOw4Ov7747MKF9InJpgVVDkYvO1kGPwJgLQg9hHQWjiqfesfKyX4HJUSYF5Q
	nOW0sg45jcHBTGz2RL6bmoHQkE//2ygIdYZnyTf3cemGX0fxjx09OCoRC8VzVzVmngrpQ7n3sw9
	NU6lMw87xT7k24YNGFwYa+O5MDbJMFHdz9Q=
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360084f8f.37.1733316890953;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGOcFoEjkEw+PoNC+LLaws3waLwovX9iW85k260HP1nxTmH4H7ZaUgV85wmWvqw6YlLZ08+Q==
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr5360063f8f.37.1733316890620;
        Wed, 04 Dec 2024 04:54:50 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ea9c5952sm11045422f8f.67.2024.12.04.04.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:49 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 01/12] fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:32 +0100
Message-ID: <20241204125444.1734652-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to protect vmcore modifications from concurrent opening of
the vmcore, and also serialize vmcore modification.

(a) We can currently modify the vmcore after it was opened. This can happen
    if a vmcoredd is added after the vmcore module was initialized and
    already opened by user space. We want to fix that and prepare for
    new code wanting to serialize against concurrent opening.

(b) To handle it cleanly we need to protect the modifications against
    concurrent opening. As the modifications end up allocating memory and
    can sleep, we cannot rely on the spinlock.

Let's convert the spinlock into a mutex to prepare for further changes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b4521b096058..586f84677d2f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -62,7 +62,8 @@ core_param(novmcoredd, vmcoredd_disabled, bool, 0);
 /* Device Dump Size */
 static size_t vmcoredd_orig_sz;
 
-static DEFINE_SPINLOCK(vmcore_cb_lock);
+static DEFINE_MUTEX(vmcore_mutex);
+
 DEFINE_STATIC_SRCU(vmcore_cb_srcu);
 /* List of registered vmcore callbacks. */
 static LIST_HEAD(vmcore_cb_list);
@@ -72,7 +73,7 @@ static bool vmcore_opened;
 void register_vmcore_cb(struct vmcore_cb *cb)
 {
 	INIT_LIST_HEAD(&cb->next);
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&cb->next, &vmcore_cb_list);
 	/*
 	 * Registering a vmcore callback after the vmcore was opened is
@@ -80,13 +81,13 @@ void register_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback registration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 }
 EXPORT_SYMBOL_GPL(register_vmcore_cb);
 
 void unregister_vmcore_cb(struct vmcore_cb *cb)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	list_del_rcu(&cb->next);
 	/*
 	 * Unregistering a vmcore callback after the vmcore was opened is
@@ -95,7 +96,7 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
 	 */
 	if (vmcore_opened)
 		pr_warn_once("Unexpected vmcore callback unregistration\n");
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	synchronize_srcu(&vmcore_cb_srcu);
 }
@@ -120,9 +121,9 @@ static bool pfn_is_ram(unsigned long pfn)
 
 static int open_vmcore(struct inode *inode, struct file *file)
 {
-	spin_lock(&vmcore_cb_lock);
+	mutex_lock(&vmcore_mutex);
 	vmcore_opened = true;
-	spin_unlock(&vmcore_cb_lock);
+	mutex_unlock(&vmcore_mutex);
 
 	return 0;
 }
-- 
2.47.1

