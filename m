Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E01CD1E0
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316898; cv=none; b=nFg6+3WWUNpyNJwLUzr9NuWIXefqcnqQ7BT97fe6e8XzupXTvsFdjibzRhDytW6NJi393hwnDwPpsLWvcOAKBgMDclLUI8KTEQsK22vwuiyQqb4XXsXHPJ/UxXGmdFs7aCGbNl8fl7TAL3EpnrNTV17FcMTI6sXiGIebnIvCETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316898; c=relaxed/simple;
	bh=WdYleG7wq0/QsvZ4l+B0SUHHNWJZ0MpP6g4l1w+mx3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC9+jMKb+zWhJAqVpINFSHgV6H/XTRx9euxwMBucnxE8KP46DQHyNTGYnR/mN3VVCM3yZ0bPFJMce3X7hTNI3CliOSDoJYSws4/G1O5vb37HdESJfiUkrFBL+RrZgN+JwhB1EoFvOYu6oAkWQLYgIoM42VbYujMOruUPetPA63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry8Lvbc/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry8Lvbc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
	b=Ry8Lvbc/4A4t3QfMJ38n0KwNzqGE8sqEgxZUzMqcUIR856SBB9KaNUTZk6dY8yD7Ksvt38
	uAPawgoAUof7gY/71uQ9uCUd2Tjp5K5K6+JsC2pBIh7FzS/oe65T+alQ6AtubrnglQ7DdE
	BIhpKIH0IQ9FhPgdGSJSaf7XxCyMVoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-idR9mGsdPgupP99vtDnSlw-1; Wed, 04 Dec 2024 07:54:55 -0500
X-MC-Unique: idR9mGsdPgupP99vtDnSlw-1
X-Mimecast-MFC-AGG-ID: idR9mGsdPgupP99vtDnSlw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so379792f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316894; x=1733921694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkAK23ba+nOdc62V3txwBduSNZiyWl3c9gCUE/mLOOA=;
        b=bQ6lDho4G+to6t1BAQ0B2u6bwo3nd7qg1OhH+TwAFyPd0+bIwYXM60t2lwSeYI58nf
         BK9rUYY5Lu+ONQET6t6EjK7PD5s3iNAtHBz9HlnwbNuZ4/rcqIr43oHQ/kbFZp9K3ms6
         Py+SfqNDf/eHSviQVKFGfK21EpUFTEHc+1wV/khrxQ+nCL/9O8tKz0Jh/quIPPM7vzPc
         jdY/ybJtoqzqMZOjiRU/8pPYX7RONUId6c/7RjNRNe0/TsUW07UMXTGimqYuQTGHFSTN
         1JmkliievsMobuMi+FSKq5B61jL9Sh+bmHdRL8rN1CFooUMCNzkX7AnRCbjlVAb/HVc1
         OOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgSA5orTZ8MjYOymJhPrpBY9wEo99qVMEITTOlbTnLaYzmvuV/CiOfktBdF3d1yKLok6milIKFWe5Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDYn3hXprBBUHViIjk+0/23qfvvBWu9rscOCv7Lq6QoC/C/A0
	ljPnEz+6Bt/L5em0ZiG5LCl9NluVKDGXcQ0ZjLVQL6Gp99dSdOv03hIyDgUIZBecLmUJ8htfNqd
	eY9USRav6U7lhDUhYnpvL4Rq5L7HSqTwRFqqKvsWYqdcBFjJ1idG19kn5nmk=
X-Gm-Gg: ASbGncsUIopflAeGTdkW2nocptvW3LsIp1eZkqZICnL1svZcvv6+HaNo7GR1AyioRpI
	AyoE7FFwcqyTHxWFV3kWD0Ov3VU52JpQOdskurnuEqPcc999H3oKlU7uhUQKBT1sodAPYqex8on
	iuepBn35QDLvRnYNQeotiskd6Gyy5caLNDGMl/qpEeUC0jaQriuFPSrovy97YbLsyWPaqJRRAeU
	RsomuyGV1HcAUDNHrUmDT6OerqlRwaVoS+cSuwIDPggnnW5pQ19OmCGFyP1EFwuKHppa976s1Qn
	csGRn45de7sHE4zt2aowjUxRQK4Bylv23y4=
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400379f8f.33.1733316893955;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvdtkWkEwxi8mpcTLDx5Tk+eqhyWjoc+BX5ypLCUE7CH8mOKCeowIphEqt4hXFtq1npl/2WQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5400356f8f.33.1733316893544;
        Wed, 04 Dec 2024 04:54:53 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c12a4sm23880495e9.30.2024.12.04.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:52 -0800 (PST)
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
Subject: [PATCH v2 02/12] fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
Date: Wed,  4 Dec 2024 13:54:33 +0100
Message-ID: <20241204125444.1734652-3-david@redhat.com>
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

Now that we have a mutex that synchronizes against opening of the vmcore,
let's use that one to replace vmcoredd_mutex: there is no need to have
two separate ones.

This is a preparation for properly preventing vmcore modifications
after the vmcore was opened.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 586f84677d2f..e5a7e302f91f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -53,7 +53,6 @@ static struct proc_dir_entry *proc_vmcore;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
 /* Device Dump list and mutex to synchronize access to list */
 static LIST_HEAD(vmcoredd_list);
-static DEFINE_MUTEX(vmcoredd_mutex);
 
 static bool vmcoredd_disabled;
 core_param(novmcoredd, vmcoredd_disabled, bool, 0);
@@ -248,7 +247,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -269,7 +268,7 @@ static int vmcoredd_copy_dumps(struct iov_iter *iter, u64 start, size_t size)
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 
@@ -283,7 +282,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	size_t tsz;
 	char *buf;
 
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_for_each_entry(dump, &vmcoredd_list, list) {
 		if (start < offset + dump->size) {
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
@@ -306,7 +305,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 	}
 
 out_unlock:
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 	return ret;
 }
 #endif /* CONFIG_MMU */
@@ -1518,9 +1517,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
 	dump->size = data_size;
 
 	/* Add the dump to driver sysfs list */
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	list_add_tail(&dump->list, &vmcoredd_list);
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 
 	vmcoredd_update_size(data_size);
 	return 0;
@@ -1538,7 +1537,7 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
 static void vmcore_free_device_dumps(void)
 {
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-	mutex_lock(&vmcoredd_mutex);
+	mutex_lock(&vmcore_mutex);
 	while (!list_empty(&vmcoredd_list)) {
 		struct vmcoredd_node *dump;
 
@@ -1548,7 +1547,7 @@ static void vmcore_free_device_dumps(void)
 		vfree(dump->buf);
 		vfree(dump);
 	}
-	mutex_unlock(&vmcoredd_mutex);
+	mutex_unlock(&vmcore_mutex);
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
-- 
2.47.1

