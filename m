Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F21FBCB2
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316919; cv=none; b=fRPEAsxLwenFcDBCysUxrWmfeb0Fks9osyBrHh8AQoy2WnqL4AvXjd1ZqmN7p59PYAIJjiQsReNUeTg6/e1yO5MC53XY0kH+TyCzEHadLN8CSc8F77WnS2asyJF4PNUMlM4PdnMjBVayl7kaaiZggE8WLJcU0GSAwwo3NjCpkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316919; c=relaxed/simple;
	bh=+kw0hVN/R7EKfAHQdf+parzKCkCR3tVH/e099GIq3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnnsMmh58lLcouyvtBcjTwBOh0t6u68aWTrRyW2TvXAwljzkCp+Pn4xZsdD5d8Wae8EZO0aV73ckpDIrvdVaU7At6UuOlwf6XDeLKT2an27oR6OZKnptEzp5tJ6JsdbwVsJAF+9kB2FghZSn9UH1z5OAHONjYPSyUKIaY10ZaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFomIgrP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFomIgrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
	b=ZFomIgrPWyEqZA16QxQVbj5dj3zEpDpCeIbOYVdI+NAfyp9xYxh3X1AhNtLFyvnkbmEFEG
	Ex+Ys+DGTrpYQ6Euf8ZYRt2/fYi0lk3/4jzIuFgcQGOHAubOrQFxlxz+Vmm9AyzuVyC0oH
	Ot1SRxkma+T7Dz9WZpZHjMSYaHBpWzg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Nn2uf5_DPKGnRCKJPXNzAw-1; Wed, 04 Dec 2024 07:55:15 -0500
X-MC-Unique: Nn2uf5_DPKGnRCKJPXNzAw-1
X-Mimecast-MFC-AGG-ID: Nn2uf5_DPKGnRCKJPXNzAw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af7937so55219015e9.1
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316914; x=1733921714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
        b=dAGrw625CGKTf+vV/aO8tw1djEpVbh+QLmrzWCbPq3q7bfp2oTB/NSUtTzv+aQv0rX
         gUsA1NmIAVCc8cwkaHZGzCEEBxounyCkDMab01WiOmO0oA5bPAZAKe/6HUzqbQhMezDg
         HGKfBmXWQwbj+ldGxdcfvtLpT9DNvyRVkczUwT6+k+f4ZXF5sbVjD4XE88Fg3uf8Ekh6
         SFsof+4KaXnEwslwyxYrgUDA8X0gy4Op9jB30oP5Be40aMdQc8H1yIhnpwrtlLRwHTI0
         BAoSWDgFolgfkneACww3qqOQrUyfgKq/+3jtXv5wcKp7lLXY3p76IhYA1/ocU4b0j/tB
         i8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW1xUVyt6UEKaeQbc6/7qAMa6SlC/EMGQy4sfbNVQcWmtm44+/+PsNjsi9esbJdBHp9384asPjmxDx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tG12PqdfjGrAbMnrjvFzRIGlTrtNKJx6pPrnw4kvTUE3GIXY
	v7NAjLIbdVdhvzFVtToW0sMqX4C+s6Bb/FrOUYxrlXXJUTHW0A/ivuNMie68HaDYVEq3VZ1ZCum
	t10ERJdASvr3pZzPDDm+mHD3UVgJVHTgQ/oVI6TWwy4LWFSDiKhJaIAaCaX4=
X-Gm-Gg: ASbGncusJZTrHgI3+mqI9EQYJ2ZroB2OZWatyHsAx31748M4+YFLeKKGLvocwGEYism
	Yd6p7PT6msle4OHudaQErUP/v+NAL15iMlhfylMkhmDmRediS48Z+l/k4/7KrdYHo8qMVarBqml
	sZ4fEbp6kvsOoKQD8Tx6+PcG7xU/da6G8GpL19Ua1wgIPEDgQF826FnndaWwNhC56AkRo/F67t9
	PBTUPEA2R0ww7cAnpBiJ2dDCPW0klAcozbxgyMcbDUng3kz2SW+jXhX7lmj8GoylH8jamdH21Hb
	gMXG9RL2OBbsxeEhU/inT1ZndMkYOozO7Xs=
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62644205e9.30.1733316913734;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdVB6YFjtubaQuZKYqVl7K3swrZVKNM9mWRen9YVYSXicgBrRTJ3zdugRU4fK2CCWYQJl/Fg==
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62643915e9.30.1733316913375;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385df488559sm15210226f8f.63.2024.12.04.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:12 -0800 (PST)
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
Subject: [PATCH v2 09/12] virtio-mem: mark device ready before registering callbacks in kdump mode
Date: Wed,  4 Dec 2024 13:54:40 +0100
Message-ID: <20241204125444.1734652-10-david@redhat.com>
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

After the callbacks are registered we may immediately get a callback. So
mark the device ready before registering the callbacks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b0b871441578..126f1d669bb0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2648,6 +2648,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	if (rc)
 		goto out_unreg_pm;
 
+	virtio_device_ready(vm->vdev);
 	return 0;
 out_unreg_pm:
 	unregister_pm_notifier(&vm->pm_notifier);
@@ -2729,6 +2730,8 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+	/* We must be prepared to receive a callback immediately. */
+	virtio_device_ready(vm->vdev);
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
@@ -2870,8 +2873,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
-	virtio_device_ready(vdev);
-
 	/* trigger a config update to start processing the requested_size */
 	if (!vm->in_kdump) {
 		atomic_set(&vm->config_changed, 1);
-- 
2.47.1

