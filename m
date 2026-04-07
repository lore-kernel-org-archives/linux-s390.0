Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF71343D72
	for <linux-s390@vger.kernel.org>; Tue,  7 Apr 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584781; cv=none; b=kxRHhYWB2ZgQha8pL4CAKJYs5rFGF+lB23jt8SZ4qjvBR97sWf6Appr7rDHuRRw7OoBu/vABBNLB4oIEMS/j0Wy9j5yDe9/sI+wMtoZsCKzfCW0Q9YlNzxbSWpvEJYY5Fx9twmpH8wXgDmBmMFTRozpP/DgUnAKPPtq0whs8K+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584781; c=relaxed/simple;
	bh=JkxrRGeUt903Tkb6jtekbiPgeO+F1zGmN6rhH/iL+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1NePLztOumPKn6quSJVZ0WUo8YSOH3rWrK+9AAK07lkVgChxGbGhbE5zLikrn8CkAN9Mj1d4oqtEYhEFUEo0F9TyfY81mLwHlf59o0cbqHzmM6/0YcEAw/0Xk8U6SL3qP6qVuXQEmQLvopVh/IAK55n6Hu6sTKPkM3RQVaUS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuHn2wDy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFU2IdMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuHn2wDy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFU2IdMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
	b=iuHn2wDyr3V5REPWCY7zNqCK596SkZy3dk0kOw1cBfIgnDiYhyuFsHIPVuNlse4oKYmHrc
	5uNCJ09zHRTOgXOuny/iYstsPyCNvyt4HY+rLHxbtTSfu7A8O+IDcty6hAsQ2bcrOfGTma
	9pU5Xc9bVNFGaAM9kgG7kfuwZlF2ecQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ROMjqNtoNwaKKzm-69pVXA-1; Tue, 07 Apr 2026 13:59:38 -0400
X-MC-Unique: ROMjqNtoNwaKKzm-69pVXA-1
X-Mimecast-MFC-AGG-ID: ROMjqNtoNwaKKzm-69pVXA_1775584777
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf6758644so3312568f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584777; x=1776189577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
        b=FFU2IdMU1jqyF4YdCBluIqJ4kOtSBjCeDiNsUQnx3BDlHH0kMAIUuMG8k9BoznJ5t2
         W8MKmNPeAZfL8MLWZs9IcNjIpudcH8wUXwoOyawaLx+4btX9JORLoNVj6a5G3tFpvQJ4
         hxI7+QSIxVrdQBvbcLd4cvifTYTnW+Li22qKV3q33A5dnpVmLdgmcYJW8lvzlYaqsuNp
         24BqKDj6qXXjaQnjFDJoeu4CiWdyQX5oq12n7rzAsQkGU7OO4Qw6zSh6cpl3aTI4b0hi
         615x1cEMLDA5S8B64WzhPAMAXtZkrjUOZelrCnS9qYaV2gdwo8Ns3HfYCOdcZJujx8WG
         BvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584777; x=1776189577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
        b=bkqVsa8X7xI+no2NSVAyMB/SkPry2755MK2Q4Vuup8yXM5PbDD3eKwSHU72jRX0NPr
         CQAEVUj0GOwwiEKnbydTKwNgtPNNt4bCGaZadGy+PyE2cga0UL8vU5ymk2V5fB2avb6I
         vwk1K8ROE5rSXkcF/H9ZBKfK7zz4iH9u2EJ8sPcYGKHa3qSiofBQzq8m+CVUidMALoQI
         Lo+r4Ibv1E/Lb6D0BOkZSv5IWScGZ/FEb4DTsPHdyaV/D0E0XKp1BpYc3wXXdAFcbsFM
         h3vAOQHFjVczR6xk5V84kjVOQtozJRB+z5G0a3Lmd+JkCkXIq6rSgnWACfE0xKYjkT4I
         eQCg==
X-Forwarded-Encrypted: i=1; AJvYcCUynWNsgWO2f1jjkzyxYs/0nCrECwpG4db2Hbl13ggyhfJ0LqhqyX3eribX3oC86AgO5olEVfi/9Bvd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhAMkpe8VaogKu8JKesBJwoFXZMnB/A5POERU50WnR6uVr/Do6
	qotg3YLKjo9eaZ55CyUPZFu//R8zF52otAwou+wtxfHS23W/vtBLkCimnxbEZtTD9nWTtl7ziEz
	LwKj1lK/jydkz7SugwNbOV4kmAzkjzTD5WDB4tPy+lrZ3Ub3Tv1hbWK0JWchJA54=
X-Gm-Gg: AeBDieufFCmBoWmLkjV83OWC+jG6vrDUkBa0y4JofWCoRHnHc28wO65JdfAiHTXnl/z
	7519+r+96cI1nlLQ4HMpt/WcatArjFZ1xP6XwywcpeII5XvzDb3qnzCQgd9XZEStwMslcra5YM1
	5WHKEkKFJOcZ0iPjDxLQaLoBexeRw3993DdC3yYiq1AD0PcxoEVfWOJ3oyPuxGyXHMkAMW7smDq
	P5tA/QTp4de3Rz+ZxPWSFRotk8sOW4/VKRMbW96D/Z/1E8yX/Wdmsd+tzaMGswbFEkv1M6uHtBC
	0dqBSnYsJII7HKbk+imBg777R38WAqUgDNduy5zZAcmHFBc7OzapYVyzZZq5CZA3uPjG88Lvufh
	1ryskVG8XC0WT82LUSTfw4lc1FhD5FNitkwbYOrnMNNyr0wehxT3mvQHx5I1uc0EwQffp5xy1/E
	8HJIB6UDslJ+rf1IZXFKuQWl04
X-Received: by 2002:a05:600c:3b18:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-4889970dccdmr237538675e9.11.1775584777048;
        Tue, 07 Apr 2026 10:59:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-4889970dccdmr237538275e9.11.1775584776562;
        Tue, 07 Apr 2026 10:59:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1053930265e9.2.2026.04.07.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:59:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: akrowiak@linux.ibm.com,
	alex@shazbot.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] VFIO: remove dead notifier code
Date: Tue,  7 Apr 2026 19:59:34 +0200
Message-ID: <20260407175934.1602711-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

group->notifier is dead code. VFIO initializes it and checks it for emptiness on
teardown, but nobody ever registers on it or triggers it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
 drivers/vfio/group.c                |  3 ---
 drivers/vfio/vfio.h                 |  1 -
 drivers/vfio/vfio_iommu_type1.c     |  1 -
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index eba1991fbdba..2de0560bd70c 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -431,17 +431,14 @@ matrix device.
 * callback interfaces
 
   open_device:
-    The vfio_ap driver uses this callback to register a
-    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matrix mdev
-    devices. The open_device callback is invoked by userspace to connect the
-    VFIO iommu group for the matrix mdev device to the MDEV bus. Access to the
-    KVM structure used to configure the KVM guest is provided via this callback.
-    The KVM structure, is used to configure the guest's access to the AP matrix
-    defined via the vfio_ap mediated device's sysfs attribute files.
+    the open_device callback is invoked by userspace to connect the
+    VFIO iommu group for the matrix mdev device to the MDEV bus.  The
+    callback retrieves the KVM structure used to configure the KVM guest
+    and configures the guest's access to the AP matrix defined via the
+    vfio_ap mediated device's sysfs attribute files.
 
   close_device:
-    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
-    matrix mdev device and deconfigures the guest's AP matrix.
+    this callback deconfigures the guest's AP matrix.
 
   ioctl:
     this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET ioctls
@@ -449,9 +444,8 @@ matrix device.
 
 Configure the guest's AP resources
 ----------------------------------
-Configuring the AP resources for a KVM guest will be performed when the
-VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
-function is called when userspace connects to KVM. The guest's AP resources are
+Configuring the AP resources for a KVM guest will be performed at the
+time of ``open_device`` and ``close_device``. The guest's AP resources are
 configured via its APCB by:
 
 * Setting the bits in the APM corresponding to the APIDs assigned to the
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..731dd0dead0d 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -456,7 +456,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
 	 * Device FDs hold a group file reference, therefore the group release
 	 * is only called when there are no open devices.
 	 */
-	WARN_ON(group->notifier.head);
 	if (group->container)
 		vfio_group_detach_container(group);
 	if (group->iommufd) {
@@ -541,7 +540,6 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	/* put in vfio_group_release() */
 	iommu_group_ref_get(iommu_group);
 	group->type = type;
-	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
 
 	return group;
 }
@@ -720,7 +718,6 @@ void vfio_device_remove_group(struct vfio_device *device)
 	 * properly hold the group reference.
 	 */
 	WARN_ON(!list_empty(&group->device_list));
-	WARN_ON(group->notifier.head);
 
 	/*
 	 * Revoke all users of group->iommu_group. At this point we know there
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..0854f3fa1a22 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -90,7 +90,6 @@ struct vfio_group {
 	struct mutex			group_lock;
 	struct kvm			*kvm;
 	struct file			*opened_file;
-	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
 	unsigned int			cdev_device_open_cnt;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 03cefdf99a4a..c8151ba54de3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,7 +36,6 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
-#include <linux/notifier.h>
 #include <linux/mm_inline.h>
 #include <linux/overflow.h>
 #include "vfio.h"
-- 
2.53.0

