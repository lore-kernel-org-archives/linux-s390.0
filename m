Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81E468C21;
	Fri,  7 Aug 2026 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141139; cv=none; b=pNywtWjuC+zrsbQJe1rlWoCHsjdIttvn1+CKBpDoSm+MfCIAxEevPbiDxpX6Au+RqYUxaKQ1Qge6dv5Hc5JJAfFvfG5NLJ+h2ZKLftdxEPvMvEq76dSkMxjr6R0FCkARhRO1isSD1AIWSohlmwVLrbsLwHwOQgmpAV41GKRLlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141139; c=relaxed/simple;
	bh=cjS+DmmkbdSDd/OoPGo19PQXqpl/KKvEG9NpUw/tbs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBWOxGkg9+En6BM9aqvz+kbtkmlWHFji70VO913aKVbUKtHwewzzKwlB2MBAKSKwdyUFQBdsHLRrEibGqrwc7yxoW6PZ9qdUtVK86kC8A7WL1aKbUltPLAIl85/io+DJDYtVnfbiE4LxFJ3MmT7HRwjthQhWoA6pLjcwBimSNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WjsYRxN5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WjsYRxN5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677LlZCX800087;
	Fri, 7 Aug 2026 22:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BeM3b0I3Nh+4SiEP7
	f0kPJXK7Y6kmE6qyameiqU3QZY=; b=WjsYRxN5bbhvHg4tBNtN5Dw+TSbCtxlKh
	MBETKsmMNyssJc6aMJIrtNLzikr7gZaiuH8H7p3+QT4tfk7Vty6d2GZ/D0V1rheE
	2tOYHISm6wSNbKOdev2eHsQOKri6Iv4xwGCGCC7d96eelxVsiBzHQnJp7MvYw4va
	QylTIvfiHI9j+nc0YVGK+9rjx+ThB8BayJMDaY9PEuyYZC6efqUrnkrEoLNqH4E+
	epfkDGXbMyG7+a9uYKO5nLdm/6U4yUlHMKNO+K5hNSTh018aEMigbsL9Un8LdAga
	f6MrNCG1FkuMPzCKtUgig6/oQn0/BdtlzfNIdldmOIOu5CyE/jTwQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01p7xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBZeq016726;
	Fri, 7 Aug 2026 22:18:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r1t4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIlfV30343748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 164B558057;
	Fri,  7 Aug 2026 22:18:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0274658059;
	Fri,  7 Aug 2026 22:18:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 10/15] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Fri,  7 Aug 2026 18:18:29 -0400
Message-ID: <20260807221834.562851-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221834.562851-1-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uRVXnhU6750caVqJT1wXyuzMhgNXKftn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfXzmbdZ4gTbG/C
 Om0xQEzDYZ2btjo9+NcvrrWaJyiejuZyn6MdXSYoUQomKNc2kstu01bnQW2fW+ocNl1ZJHTeaJj
 W0dZnAoies8AEOhbhPgHgDyDnQpxUtg=
X-Proofpoint-ORIG-GUID: uRVXnhU6750caVqJT1wXyuzMhgNXKftn
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a7659ca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=G6nV3_XTBjsC8oaNh7QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX5F5HHY6Sdxcm
 Fd/oSh84prJJm1L7dzzq9gIzypJaROdmwj2h6QRa/ArYGdiOnK8Y8Y8XPJUSj10NU4SF31oS8h3
 juiocCvtfvgpz9kQCurFh9DUacMpuJA2ljBXMh0ZRwuoSDGx5jJGk6t+CaafoOx7H0d3iVfFEsY
 dI/+JJOCH4eKLq0mVoSOroz1ImRWTyVSnj2WP6QeKsR/bjVUfHE1ddb3WAsBUXAa6wj24mWoidg
 SjAbNkdzMMfrH2gYDD/xT3KLI9IICA+pHHPttBJpQxVVsOWic3iMmMf/gbIkvbPoZuLG6sIrGlv
 fpR+tECnT+F2dRiJc+oSxmAHZzjGkG45gfVDjuweHpevFeYLy75PPJZ2m7wwufJACNTFvyyztdy
 Z5592jI22S5wgT/50H6nwoAoY4/OBkydN4JwtZ7IJeVnf63I1M+EpDn+p1r5rx3aRH6QOhefR18
 /kdU4ICQ6iorY8EK77Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070175

Implements the 'write' callback function that was added to the
'file_operations' structure for the file stream created to restore the
state of the vfio-ap device on the destination system when the migration
state transitioned from STOP to RESUMING

The write callback retrieves the vfio device migration state saved to the
file stream created when the vfio device state was transitioned from
STOP to STOP_COPY. The saved state contains the source guest's AP
configuration information. This data is copied from the userspace buffer
passed to the 'write' callback and stored in the vfio_ap_config structure
used to set the state of the vfio-ap device on the destination host. If the
source guest's AP configuration is compatible with the AP configuration on
the destination host, it will be hot plugged into the destination guest.

In order for the source guest's and destination host's AP configurations
to be considered compatible:

* Each APQN in the source guest's AP configuration must also be in the
  destination host's AP configuration

* Each matching APQN in the destination host's AP configuration must be
  bound to the vfio_ap device driver

* Each matching APQN in the destination host's AP configuration must
  reference a queue device with compatible hardware:

  - The source and destination queues must have the same facilities
    installed:
    ~ APSC facility
    ~ APQKM facility
    ~ AP4KC facility

  - The source and destination queues must have the same mode:
    ~ Coprocessor-mode
    ~ Accelerator-mode
    ~ XCP-mode

  - The source and destination queues must have the same APXA facility
    setting
    ~ If the APXA facility is installed on source queue, it must also
      be installed on the destination queue and vice versa

  - The source and destination queues must have a compatible
    classification setting. If the source queue has full native card
    function, then the destination queue must also have full native
    card function. If the source queue has stateless functions, then
    the destination queue can have stateless functions or full native card
    function because the latter includes the stateless functions.

  - The binding and associated state for both the source and destination
    queues must indicate that the queue is usable for all messages
    (i.e., BS bits equal to 00).

  - The AP type of the destination queue must be the same as or newer than
    the source queue (backward compatibility)

Note: The get_hardware_info_for_queue function that was created in
      a previous patch was modified to take a mediated device name rather
      than an ap_matrix_mdev object because that is what is needed for
      this patch so the function can be executed without holding the
      matrix_dev->mdevs_lock.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 1009 ++++++++++++++++++++++-
 1 file changed, 1001 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index e2e7ae8515e5..4dd7373c3d9d 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -12,6 +12,61 @@
 #define VFIO_AP_MIG_MAGIC			0x76666170U  /* "vfap" */
 #define VFIO_AP_MIG_VERSION			1U
 
+/*
+ * Masks the fields of the queue information returned from the PQAP(TAPQ)
+ * command. In order to migrate a guest, it's AP configuration must be
+ * compatible with AP configuration assigned to the target guest's mdev.
+ * This mask is used to verify that the queue information for each source and
+ * target queue is compatible.
+ *
+ * The following bits must match for the source device and the corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * S bit 0: APSC  facility installed
+ * M bit 1: APQKM facility installed
+ * C bit 2: AP4KC facility installed
+ * Mode bits 3-5:
+ *     D bit 3: CCA-mode facility
+ *     A bit 4: accelerator-mode facility
+ *     X bit 5: XCP-mode facility
+ * N  bit 6: APXA facility installed
+ * SL bit 7: SLCF facility installed
+ *
+ * Either bit 8 or bit 9 will be set. If bit 8 is set for the source device,
+ * then it must also be set for the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * Classification (functional capabilities) bits 8-16
+ *     bit 8: Native card function
+ *     bit 9: Only stateless functions
+ *
+ * The BS bits must be set to 0 for both the source and corresponding
+ * destination device:
+ * -------------------------------------------------------------------------
+ * BS bits 16-17:
+ *
+ * The AP type of the source device must be less than or equal to that of
+ * the corresponding destination device:
+ * -------------------------------------------------------------------------
+ * AP Type bits 32-40:
+ */
+#define QINFO_DATA_MASK		0xffffc000ff000000
+
+/*
+ * Masks the bit that indicates whether full native card function is available
+ * from the 8 bits specifying the functional capabilities of a queue
+ */
+#define CLASSIFICATION_NATIVE_FCN_MASK		0x80
+
+/* The maximum number of queues that can be installed in an s390 system */
+#define MAX_AP_QUEUES				(AP_DEVICES * AP_DOMAINS)
+
+/*
+ * The size of the 'buf' array in struct vfio_ap_config_buffer. It needs to be
+ * large enough to store the first three fields (magic, version and num_queues)
+ * of a struct vfio_ap_config instance.
+ */
+#define VFIO_AP_CONFIG_BUF_SIZE			(sizeof(u32) * 3)
+
 /**
  * struct vfio_ap_migration_file
  *
@@ -29,6 +84,28 @@ struct vfio_ap_migration_file {
 	unsigned long		config_sz;
 };
 
+/**
+ * struct vfio_ap_config_buffer:
+ *
+ * During the RESUMING phase of migration, userspace may send AP configuration
+ * data in chunks. Until we know how many queues to which the source guest
+ * has access, it is not possible to allocate the appropriate amount of
+ * storage for a struct vfio_ap_config instance. The vfio_ap_config_buffer
+ * will accumulate the data until the 'num_queues' field of the vfio_ap_config
+ * object is sent.
+ *
+ * @filled:		indicates whether the buffer is filled (true if it
+ *			includes the 'num_queues' field) or not (false, i.e.,
+ *			more data needs to be sent from userspace and read in).
+ * @bytes_read_in:	the number of bytes that have been read into the buffer
+ * @buf:		the buffer into which source data is read
+ */
+struct vfio_ap_config_buffer {
+	bool			filled;
+	size_t			bytes_read_in;
+	u8			buf[VFIO_AP_CONFIG_BUF_SIZE];
+};
+
 /**
  * struct vfio_ap_migration_data:
  *
@@ -36,15 +113,25 @@ struct vfio_ap_migration_file {
  * configuration of the guest being migrated.
  *
  * @mig_state:		the current migration state
+ * @resuming_config_buf: buffer used for chunk writes of a struct vfio_ap_config
+ *			object from userspace during the RESUMING phase of
+ *			migration until the 'num_queues' field of the object has
+ *			been written and read into the buffer.
  * @resuming_mig_file:	the object used to restore the state of the vfio-ap
  *			device on the destination host.
  * @stop_copy_mig_file:	the object used to store the AP configuration of the
  *			source guest for transfer to the destination host.
+ * @write_in_progress:	true if a write() is currently in progress on the
+ *			resuming migration file; used to reject concurrent
+ *			writes, which are not supported on this streaming
+ *			interface.
  */
 struct vfio_ap_migration_data {
 	enum vfio_device_mig_state	mig_state;
+	struct vfio_ap_config_buffer	resuming_config_buf;
 	struct vfio_ap_migration_file	resuming_mig_file;
 	struct vfio_ap_migration_file	stop_copy_mig_file;
+	bool				write_in_progress;
 };
 
 /**
@@ -125,9 +212,10 @@ vfio_ap_release_stop_copy_file(struct vfio_ap_migration_data *mig_data)
 
 static void vfio_ap_release_resuming_file(struct vfio_ap_migration_data *mig_data)
 {
-	/* Stub to be implemented when the mig_data->resuming_mig_file.ap_config
-	 * object is allocated.
-	 */
+	kvfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = NULL;
+	mig_data->resuming_mig_file.config_sz = 0;
+	mig_data->resuming_mig_file.filp = NULL;
 }
 
 static int vfio_ap_release_mig_file(struct inode *file_inode, struct file *filp)
@@ -221,7 +309,7 @@ static int get_hardware_info_for_queue(const char *mdev_name,
 		/* For all these RCs the tapq info should be available */
 		return 0;
 	case AP_RESPONSE_Q_NOT_AVAIL:
-		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
 				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
 				   status.response_code);
 		return -ENODEV;
@@ -233,7 +321,7 @@ static int get_hardware_info_for_queue(const char *mdev_name,
 		if (status.async)
 			return 0;
 
-		pr_err_ratelimited("vfio_ap_mdev %s:Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		pr_err_ratelimited("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d\n",
 				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
 				   status.response_code);
 		return -EIO;
@@ -288,7 +376,7 @@ static int vfio_ap_get_config(struct ap_matrix_mdev *matrix_mdev)
 
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 
-	ap_config_size = vfio_ap_config_size(matrix_mdev, (int *)&num_queues);
+	ap_config_size = vfio_ap_config_size(matrix_mdev, &num_queues);
 
 	ap_configuration = kvzalloc(ap_config_size, GFP_KERNEL_ACCOUNT);
 	if (!ap_configuration)
@@ -451,11 +539,916 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
 	return filp;
 }
 
+static int validate_resuming_write_parms(struct file *filp,
+					 size_t len, loff_t *pos)
+{
+	struct vfio_ap_config_buffer resuming_config_buf;
+	struct vfio_ap_migration_file resuming_mig_file;
+	struct vfio_ap_migration_data *mig_data;
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t total_len;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	if (!len || *pos < 0)
+		return -EINVAL;
+
+	if (check_add_overflow((loff_t)len, *pos, &total_len))
+		return -ERANGE;
+
+	matrix_mdev = filp->private_data;
+	if (!matrix_mdev || !matrix_mdev->mig_data)
+		return -ENODEV;
+
+	mig_data = matrix_mdev->mig_data;
+	resuming_mig_file = mig_data->resuming_mig_file;
+	resuming_config_buf = mig_data->resuming_config_buf;
+
+	if (filp != resuming_mig_file.filp)
+		return -ENXIO;
+
+	/*
+	 * Concurrent writes are not supported on this streaming interface.
+	 * The write position, scratch buffer state, and ap_config pointer
+	 * are all shared state that cannot be safely updated by more than
+	 * one writer at a time.
+	 */
+	if (mig_data->write_in_progress)
+		return -EBUSY;
+
+	/*
+	 * If the vfio_ap_config_buffer is filled (i.e., the 'num_queues' field
+	 * has been read in), then the vfio_ap_configuration should have been
+	 * allocated and vice versa.
+	 */
+	if ((resuming_config_buf.filled && !resuming_mig_file.ap_config) ||
+	    (!resuming_config_buf.filled && resuming_mig_file.ap_config))
+		return -EFAULT;
+
+	/*
+	 * If the vfio_ap_config object has been allocated, then the 'config_sz'
+	 * field indicates the total size allocated. If the write operation
+	 * will exceed the allocation, return an I/O error.
+	 */
+	if (resuming_mig_file.ap_config) {
+		if (resuming_mig_file.ap_config->magic != VFIO_AP_MIG_MAGIC ||
+		    resuming_mig_file.ap_config->version != VFIO_AP_MIG_VERSION)
+			return -EINVAL;
+
+		if (*pos + len > resuming_mig_file.config_sz)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static ssize_t calculate_ap_config_size(unsigned int num_queues)
+{
+	size_t qinfo_size;
+
+	if (num_queues > MAX_AP_QUEUES)
+		return -EINVAL;
+
+	qinfo_size = num_queues * sizeof(struct vfio_ap_queue_info);
+	return qinfo_size + sizeof(struct vfio_ap_config);
+}
+
+/**
+ * allocate_ap_config:
+ *
+ * Allocate storage for the source guest's AP configuration data sent from
+ * userspace.
+ *
+ * @ap_config_buf: Buffer containing the bytes comprising the 'magic', 'version'
+ *		and 'num_queues' fields of a vfio_ap_config object.
+ * @ap_config:	The location in which to store the pointer to the storage
+ *		allocated for the AP configuration data.
+ *
+ * Returns:	The number of bytes of storage allocated for the config data or
+ *		an error:
+ *
+ *		-EINVAL: if num_queues exceeds the maximum or @ap_config_buf is
+ *			 not filled (i.e., does not contain 'num_fields' value
+ *			 of a struct vfio_ap_config).
+ *		-ENOMEM: the allocation of storage failed
+ */
+static ssize_t allocate_ap_config(struct vfio_ap_config_buffer *ap_config_buf,
+				  struct vfio_ap_config **ap_config)
+{
+	struct vfio_ap_config tmp_ap_config;
+	ssize_t config_size;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	/*
+	 * A vfio_ap_config object can be allocated only if the
+	 * vfio_ap_config_buffer is filled, in which case we have the
+	 * 'num_queues' field which is necessary to calculate the allocation
+	 * size.
+	 */
+	if (!ap_config_buf->filled)
+		return -EINVAL;
+	/*
+	 * Copy the content of the vfio_ap_config_buffer so we can get the
+	 * value of the 'num_queues' field
+	 */
+	memcpy(&tmp_ap_config, ap_config_buf->buf, VFIO_AP_CONFIG_BUF_SIZE);
+
+	config_size = calculate_ap_config_size(tmp_ap_config.num_queues);
+	if (config_size < 0)
+		return config_size;
+
+	/*
+	 * Use kvzalloc so that large configurations can fall back to vmalloc
+	 * rather than failing a high-order contiguous physical allocation.
+	 */
+	*ap_config = kvzalloc(config_size, GFP_KERNEL_ACCOUNT);
+	if (!*ap_config)
+		return -ENOMEM;
+
+	memcpy(*ap_config, ap_config_buf->buf, VFIO_AP_CONFIG_BUF_SIZE);
+
+	return config_size;
+}
+
+/**
+ * qdev_is_bound_to_vfio_ap:
+ *
+ * Query to determine whether a queue with the specified APQN is available on
+ * the host system and bound to the vfio_ap device driver.
+ *
+ * @apqn: The APQN of the queue device being queried
+ *
+ * Returns: True if there is a queue device with the specified @apqn installed
+ *	    in the system and is bound to the vfio_ap device driver; otherwise,
+ *	    returns false.
+ */
+static bool qdev_is_bound_to_vfio_ap(unsigned int apqn)
+{
+	struct ap_queue *queue;
+	bool is_bound = true;
+
+	queue = ap_get_qdev(apqn);
+	if (!queue)
+		return false;
+
+	if (queue->ap_dev.device.driver != &matrix_dev->vfio_ap_drv->driver)
+		is_bound = false;
+
+	put_device(&queue->ap_dev.device);
+
+	return is_bound;
+}
+
+/**
+ * queues_available:
+ *
+ * Query whether each queue from the source guest's AP configuration is
+ * available and bound to the vfio_ap device driver; if not, log an error
+ * message.
+ *
+ * @mdev_name:	   The mdev name to use in error messages
+ * @source_config: The object specifying the source guest's AP configuration
+ *
+ * Returns: true if each queue identified in @source_config is available and
+ *	    bound to the vfio_ap device driver; otherwise, returns false.
+ */
+static bool queues_available(const char *mdev_name,
+			     struct vfio_ap_config *source_config)
+{
+	unsigned long apqn;
+	bool ret = true;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+
+		/*
+		 * Find the queue device bound to the vfio_ap device driver. If it is
+		 * not found, log an error and continue so users see all problems
+		 * at once, not one-at-a-time through retries of the migration.
+		 */
+		if (!qdev_is_bound_to_vfio_ap(apqn)) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Queue %02lx.%04lx not available to vfio_ap driver on target host\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+			ret = false;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * control_domains_available
+ *
+ * Query whether each control domain specified in the source guest's AP
+ * configuration is installed in the host system.
+ *
+ * @mdev_name:		The name of the mdev to use when logging messages
+ * @source_config:	The object specifying the source guest's AP config
+ *
+ * Returns:	True if each control domain is installed; otherwise, logs an
+ *		error message for each unavailable control domain and returns
+ *		false.
+ */
+static bool control_domains_available(const char *mdev_name,
+				      struct vfio_ap_config *source_config)
+{
+	unsigned long domain_num;
+	bool available = true;
+
+	for_each_set_bit_inv(domain_num, (unsigned long *)source_config->adm,
+			     AP_DOMAINS) {
+		if (ap_test_config_ctrl_domain(domain_num))
+			continue;
+
+		pr_err_ratelimited("vfio_ap_mdev: %s: Control domain %04lx not available on the destination host\n",
+				   mdev_name, domain_num);
+		available = false;
+	}
+
+	return available;
+}
+
+static void report_facilities_compatibility(const char *mdev_name,
+					    unsigned long apqn,
+					    struct ap_tapq_hwinfo *src_hwinfo,
+					    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apsc != target_hwinfo->apsc) {
+		if (src_hwinfo->apsc) {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: APSC facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->mex4k != target_hwinfo->mex4k) {
+		if (src_hwinfo->mex4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: mex4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->crt4k != target_hwinfo->crt4k) {
+		if (src_hwinfo->crt4k) {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: crt4k facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_mode_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->cca != target_hwinfo->cca) {
+		if (src_hwinfo->cca) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Coprocessor-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->accel != target_hwinfo->accel) {
+		if (src_hwinfo->accel) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Accelerator-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->ep11 != target_hwinfo->ep11) {
+		if (src_hwinfo->ep11) {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: XCP-mode facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_apxa_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->apxa != target_hwinfo->apxa) {
+		if (src_hwinfo->apxa) {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_slcf_compatibility(const char *mdev_name,
+				      unsigned long apqn,
+				      struct ap_tapq_hwinfo *src_hwinfo,
+				      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->slcf != target_hwinfo->slcf) {
+		if (src_hwinfo->slcf) {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in source queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err_ratelimited("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in target queue %02lx.%04lx\n",
+					   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+}
+
+static void report_bs_compatibility(const char *mdev_name,
+				    unsigned long apqn,
+				    struct ap_tapq_hwinfo *src_hwinfo,
+				    struct ap_tapq_hwinfo *target_hwinfo)
+{
+	/*
+	 * The BS field on both the source and destination must be 0, so if one
+	 * of them is not, then report an error.
+	 */
+	if (src_hwinfo->bs || target_hwinfo->bs) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Bind/associate state for source (%01x) and target (%01x) queue %02lx.%04lx must be 0\n",
+				   mdev_name, src_hwinfo->bs, target_hwinfo->bs,
+				   AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+static void report_aptype_compatibility(const char *mdev_name,
+					unsigned long apqn,
+					struct ap_tapq_hwinfo *src_hwinfo,
+					struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->at > target_hwinfo->at) {
+		pr_err_ratelimited("vfio_ap_mdev %s: AP type of source (%02x) not compatible with target (%02x)\n",
+				   mdev_name, src_hwinfo->at, target_hwinfo->at);
+	}
+}
+
+static bool classes_compatible(struct ap_tapq_hwinfo *src_hwinfo,
+			       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_native, target_native;
+
+	src_native = src_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+	target_native = target_hwinfo->class & CLASSIFICATION_NATIVE_FCN_MASK;
+
+	/*
+	 * If the source queue has full native card function and the
+	 * target queue has only stateless functions available, then
+	 * there may be instructions that will not execute on the
+	 * target queue. This shall be reported as an error.
+	 *
+	 * If the source queue has only stateless card functions and the
+	 * target queue has full native card function available, then
+	 * we are okay because the target queue can run all stateless card
+	 * functions.
+	 */
+	return (src_native != target_native) ? !src_native : true;
+}
+
+static void report_class_compatibility(const char *mdev_name,
+				       unsigned long apqn,
+				       struct ap_tapq_hwinfo *src_hwinfo,
+				       struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (!classes_compatible(src_hwinfo, target_hwinfo)) {
+		pr_err_ratelimited("vfio_ap_mdev %s: Full native card function available on source queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+		pr_err_ratelimited("vfio_ap_mdev %s: Only stateless functions available on target queue %02lx.%04lx\n",
+				   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+/*
+ * Log a device error reporting that migration failed due to queue
+ * incompatibilities followed by a device error for each incompatible feature.
+ */
+static void report_qinfo_incompatibilities(const char *mdev_name,
+					   unsigned long apqn,
+					   struct ap_tapq_hwinfo *src_hwinfo,
+					   struct ap_tapq_hwinfo *target_hwinfo)
+{
+	pr_err_ratelimited("vfio_ap_mdev %s: Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
+			   mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+	report_facilities_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_mode_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_apxa_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_slcf_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_aptype_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_bs_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+	report_class_compatibility(mdev_name, apqn, src_hwinfo, target_hwinfo);
+}
+
+/**
+ * queue_hardware_info_is_compatible:
+ *
+ * Verify whether the hardware information for a source queue is compatible with
+ * the hardware info for the corresponding queue on this system.
+ *
+ * In order to be compatible, the hardware information for each queue must
+ * meet the following requirements:
+ *
+ * 1. The hardware facilities bits much match
+ * 2. The AP type of the source queue must be the same as or older than that
+ *    of the target queue (target is backwards compatible)
+ * 3. The classification bits must indicate:
+ *    - Both queues have full native card function or both have stateless
+ *      functions available
+ *    - If the classification bits don't match, then the only acceptable
+ *      configuration is stateless functions for the source queue and
+ *      full native function for the target queue
+ * 4. The BS bits for both queues must be 0 (Queue usable for all messages
+ *    supported by the adapter)
+ *
+ * @mdev_name:	The mdev name to use in error messages
+ * @apqn:	The APQN for the queues
+ * @src_hwinfo: The hardware info for the source queue
+ * @target_hwinfo: The hardware info for the corresponding queue on this system
+ *
+ * Returns: true if the hardware info for the two queues is compatible;
+ *          otherwise, returns false.
+ */
+static bool queue_hardware_info_is_compatible(const char *mdev_name,
+					      unsigned long apqn,
+					      struct ap_tapq_hwinfo *src_hwinfo,
+					      struct ap_tapq_hwinfo *target_hwinfo)
+{
+	unsigned long src_bits, target_bits;
+
+	src_bits = src_hwinfo->value & QINFO_DATA_MASK;
+	target_bits = target_hwinfo->value & QINFO_DATA_MASK;
+
+	/* If all bits match the queues are compatible */
+	if (src_bits == target_bits &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	if (src_hwinfo->apsc  == target_hwinfo->apsc     &&
+	    src_hwinfo->mex4k == target_hwinfo->mex4k    &&
+	    src_hwinfo->crt4k == target_hwinfo->crt4k    &&
+	    src_hwinfo->cca   == target_hwinfo->cca      &&
+	    src_hwinfo->accel == target_hwinfo->accel    &&
+	    src_hwinfo->ep11  == target_hwinfo->ep11     &&
+	    src_hwinfo->slcf  == target_hwinfo->slcf     &&
+	    src_hwinfo->apxa  == target_hwinfo->apxa     &&
+	    src_hwinfo->at    <= target_hwinfo->at       &&
+	    classes_compatible(src_hwinfo, target_hwinfo) &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0))
+		return true;
+
+	report_qinfo_incompatibilities(mdev_name, apqn, src_hwinfo, target_hwinfo);
+
+	return false;
+}
+
+/**
+ * verify_ap_configs_are_compatible:
+ *
+ * Verifies that the queues in the source guest's AP configuration are
+ * compatible with the corresponding queues on this system.
+ *
+ * @mdev_name:	   The mdev name to use in error messages
+ * @source_config: The object specifying the source guest's AP configuration
+ *
+ * Returns: an error indicating either a failure to retrieve a queue's
+ *			hardware information or one or more source queues are not
+ *			compatible with the corresponding queue on this system; otherwise,
+ *			returns zero to indicate compatibility.
+ */
+static int verify_ap_configs_are_compatible(const char *mdev_name,
+					    struct vfio_ap_config *source_config)
+{
+	struct ap_tapq_hwinfo src_hwinfo, dest_hwinfo;
+	unsigned long apqn;
+	int ret = 0, rc;
+
+	for (int i = 0; i < source_config->num_queues; i++) {
+		apqn = source_config->qinfo[i].apqn;
+
+		/*
+		 * If we can't get the hardware info for a particular queue, then let's
+		 * capture the function return code and continue so we can log all
+		 * errors to aid in debugging of migration.
+		 */
+		rc = get_hardware_info_for_queue(mdev_name, &dest_hwinfo, apqn);
+		if (rc) {
+			ret = rc;
+			continue;
+		}
+
+		src_hwinfo.value =  source_config->qinfo[i].data;
+
+		if (!queue_hardware_info_is_compatible(mdev_name, apqn,
+						       &src_hwinfo,
+						       &dest_hwinfo))
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int do_post_copy_validation(const char *mdev_name,
+				   struct vfio_ap_config *source_config)
+{
+	if (!queues_available(mdev_name, source_config))
+		return -ENODEV;
+
+	if (!control_domains_available(mdev_name, source_config))
+		return -ENODEV;
+
+	return verify_ap_configs_are_compatible(mdev_name, source_config);
+}
+
+/**
+ * setup_ap_matrix_from_ap_config:
+ *
+ * Set the bits corresponding to the adapters, domains and control domains
+ * from the source guest's AP configuration into an ap_matrix object to be
+ * used to update the destination guest to run on this host.
+ *
+ * @ap_config:		The source guest's AP configuration
+ * @guest_matrix:	The object to be used to update the destination guest's
+ *			AP configuration
+ */
+static void setup_ap_matrix_from_ap_config(struct vfio_ap_config *ap_config,
+					   struct ap_matrix *guest_matrix)
+{
+	struct ap_config_info host_config_info = { 0 };
+	unsigned long apid, apqi, *guest_adm;
+	struct vfio_ap_queue_info qinfo;
+
+	ap_qci(&host_config_info);
+	/*
+	 * Zero the bitmaps before calling vfio_ap_matrix_init(), which only
+	 * sets the apm_max/aqm_max/adm_max scalar fields and leaves the bitmap
+	 * arrays untouched.  Without this, stack garbage in guest_matrix->apm,
+	 * ->aqm, and ->adm would grant the destination guest access to
+	 * arbitrary unassigned queues and control domains.
+	 */
+	memset(guest_matrix->apm, 0, sizeof(guest_matrix->apm));
+	memset(guest_matrix->aqm, 0, sizeof(guest_matrix->aqm));
+	memset(guest_matrix->adm, 0, sizeof(guest_matrix->adm));
+	vfio_ap_matrix_init(&host_config_info, guest_matrix);
+
+	for (int i = 0; i < ap_config->num_queues; i++) {
+		qinfo = ap_config->qinfo[i];
+		apid = AP_QID_CARD(qinfo.apqn);
+		apqi = AP_QID_QUEUE(qinfo.apqn);
+
+		if (!test_bit_inv(apid, guest_matrix->apm))
+			set_bit_inv(apid, guest_matrix->apm);
+		if (!test_bit_inv(apqi, guest_matrix->aqm))
+			set_bit_inv(apqi, guest_matrix->aqm);
+	}
+
+	guest_adm = (unsigned long *)ap_config->adm;
+	for_each_set_bit_inv(apqi, guest_adm, AP_DOMAINS) {
+		if (!test_bit_inv(apqi, guest_matrix->adm))
+			set_bit_inv(apqi, guest_matrix->adm);
+	}
+}
+
+/**
+ * fill_resuming_config_buffer:
+ *
+ * Continue to fill the buffer that stores the first three fields (magic,
+ * version and num_queues) of a vfio_ap_config instance with data sent by
+ * userspace during the RESUMING phase of migration.
+ *
+ * @config_buf:	reference to a 'struct vfio_ap_config_buffer' instance into which
+ *		the data sent by userspace will be copied
+ * @buf:	the buffer containing the data sent from userspace during the
+ *		RESUMING phase of migration
+ * @len:	reference to the length of data to be copied.
+ * @pos:	reference to the starting position in @buf at which to store the
+ *		data sent from userspace.
+ *
+ * Returns:	0 if the operation was successful; otherwise, returns an error.
+ */
+static int fill_resuming_config_buffer(struct vfio_ap_config_buffer *config_buf,
+				       const char __user *buf, size_t len, loff_t pos)
+{
+	size_t copy_size, bytes_read_in;
+
+	/*
+	 * Copy the data sent from userspace to @config_buf starting at @pos up
+	 * to the maximum number of bytes that @config_buf can store.
+	 */
+	copy_size = min(len, (size_t)VFIO_AP_CONFIG_BUF_SIZE - pos);
+	if (copy_from_user((char *)config_buf->buf + pos, buf, copy_size))
+		return -EFAULT;
+
+	bytes_read_in = copy_size + pos;
+	config_buf->bytes_read_in = bytes_read_in;
+	config_buf->filled = (bytes_read_in == (size_t)VFIO_AP_CONFIG_BUF_SIZE);
+
+	return 0;
+}
+
+static int do_post_copy_processing(struct ap_matrix_mdev *matrix_mdev,
+				   struct vfio_ap_config *ap_config)
+{
+	const char *mdev_name = dev_name(matrix_mdev->vdev.dev);
+	struct ap_matrix guest_matrix;
+	int ret;
+
+	/*
+	 * do_post_copy_validation() calls ap_tapq() which is a slow
+	 * hardware instruction.  Run it before acquiring the update
+	 * locks to avoid holding guests_lock, kvm->lock, and
+	 * mdevs_lock across the hardware calls.
+	 */
+	ret = do_post_copy_validation(mdev_name, ap_config);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Let's set up the destination guest's AP configuration matrix from the
+	 * source guest's AP configuration data sent from userspace.
+	 */
+	setup_ap_matrix_from_ap_config(ap_config, &guest_matrix);
+
+	mutex_lock(&ap_attr_mutex);
+	get_update_locks_for_mdev(matrix_mdev);
+
+	/*
+	 * Verify the device wasn't closed while mdevs_lock was dropped
+	 * for the copy_from_user and do_post_copy_validation above.
+	 * get_update_locks_for_mdev() reacquires mdevs_lock.
+	 */
+	if (!matrix_mdev->mig_data) {
+		release_update_locks_for_mdev(matrix_mdev);
+		mutex_unlock(&ap_attr_mutex);
+		return -ENODEV;
+	}
+
+	/* Set the destination guest's AP configuration */
+	ret = vfio_ap_set_new_guest_config(matrix_mdev, &guest_matrix);
+
+	release_update_locks_for_mdev(matrix_mdev);
+	mutex_unlock(&ap_attr_mutex);
+
+	return ret;
+}
+
+/**
+ * set_new_ap_configuration:
+ *
+ * Sets the new AP configuration for the destination guest.
+ * @matrix_mdev: reference to the object used to maintain the guest's AP
+ *		configuration
+ * @ap_config:	reference to the vfio_ap_config instance containing the AP
+ *		configuration data sent from userspace. If the reference to
+ *		matrix_mdev->mig_data->resuming_mig_file.ap_config has not yet
+ *		been set, then it will be set to @ap_config; otherwise, the
+ *		content of @ap_config will be copied into
+ *		matrix_mdev->mig_data->resuming_mig_file.ap_config.
+ * @cfg_sz:
+ */
+static int set_new_ap_configuration(struct ap_matrix_mdev *matrix_mdev,
+				    struct vfio_ap_config *ap_config,
+				    size_t cfg_sz)
+{
+	struct vfio_ap_config *cur_ap_config;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	/*
+	 * Re-read mig_data under the lock; the device could have been closed
+	 * concurrently while the lock was dropped for copy_from_user().
+	 */
+	if (!matrix_mdev->mig_data) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return -ENODEV;
+	}
+
+	cur_ap_config = matrix_mdev->mig_data->resuming_mig_file.ap_config;
+	if (cur_ap_config)
+		memcpy(cur_ap_config, ap_config, cfg_sz);
+	else
+		matrix_mdev->mig_data->resuming_mig_file.ap_config = ap_config;
+
+	matrix_mdev->mig_data->resuming_mig_file.config_sz = cfg_sz;
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return 0;
+}
+
 static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 				      size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct vfio_ap_config_buffer *resuming_config_buf;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_config *ap_config;
+	bool new_allocation = false;
+	ssize_t ret, cfg_sz;
+	loff_t write_pos;
+	size_t write_len;
+
+	/*
+	 * This file was opened with stream_open(), so pos should be NULL for
+	 * sequential write() calls; a non-NULL pointer will be passed only
+	 * for positional pwrite() calls in which case we return an error
+	 * indicating broken pipe/illegal seek on a non-seekable file
+	 */
+	if (pos)
+		return -ESPIPE;
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	pos = &filp->f_pos;
+
+	ret = validate_resuming_write_parms(filp, len, pos);
+	if (ret) {
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
+
+	matrix_mdev = filp->private_data;
+	matrix_mdev->mig_data->write_in_progress = true;
+	resuming_config_buf = &matrix_mdev->mig_data->resuming_config_buf;
+
+	/*
+	 * If we have not yet filled the vfio_ap_config_buffer, then we need
+	 * to continue filling it with data sent from userspace.
+	 */
+	if (!resuming_config_buf->filled) {
+		ret = fill_resuming_config_buffer(resuming_config_buf, buf, len,
+						  *pos);
+		if (ret) {
+			matrix_mdev->mig_data->write_in_progress = false;
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+
+		/*
+		 * If the vfio_ap_config_buffer is not yet filled, we don't
+		 * yet have enough data to allocate the vfio_ap_config instance;
+		 * otherwise, go ahead and allocate it.
+		 */
+		if (!resuming_config_buf->filled) {
+			*pos += len;
+			matrix_mdev->mig_data->write_in_progress = false;
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return len;
+		}
+
+		ret = allocate_ap_config(resuming_config_buf, &ap_config);
+		if (ret < 0) {
+			matrix_mdev->mig_data->write_in_progress = false;
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+
+		new_allocation = true;
+		cfg_sz = ret;
+	}
+
+	/*
+	 * If this is not a new allocation of the vfio_ap_config object,
+	 * then create a copy of it so we can continue filling it in via
+	 * the copy_from_user() while the mdevs_lock is dropped.
+	 */
+	if (!new_allocation) {
+		cfg_sz = matrix_mdev->mig_data->resuming_mig_file.config_sz;
+		ap_config = kvzalloc(cfg_sz, GFP_KERNEL_ACCOUNT);
+
+		if (!ap_config) {
+			matrix_mdev->mig_data->write_in_progress = false;
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return -ENOMEM;
+		}
+
+		memcpy(ap_config,
+		       matrix_mdev->mig_data->resuming_mig_file.ap_config, cfg_sz);
+	}
+
+	/*
+	 * If ap_config is a new allocation, then the contents of the
+	 * 'magic', 'version' and 'num_queues' fields will already have
+	 * been copied in; so the write_pos must be set to the location
+	 * following the 'num_queues' field and the length to be written must be
+	 * adjusted accordingly.
+	 */
+	if (new_allocation) {
+		size_t nbytes_already_copied = VFIO_AP_CONFIG_BUF_SIZE - *pos;
+
+		write_pos = VFIO_AP_CONFIG_BUF_SIZE;
+		write_len = len - nbytes_already_copied;
+		buf += nbytes_already_copied;
+	} else {
+		write_pos = *pos;
+		write_len = len;
+	}
+
+	*pos += len;
+
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_from_user((char *)ap_config + write_pos, buf, write_len)) {
+		if (new_allocation)
+			kvfree(ap_config);
+		ret = -EFAULT;
+		goto out_clear_write_in_progress;
+	}
+
+	/* Check if we've completed writing the entire configuration */
+	if (write_pos + write_len == cfg_sz) {
+		ret = do_post_copy_processing(matrix_mdev, ap_config);
+
+		if (ret) {
+			kvfree(ap_config);
+			goto out_clear_write_in_progress;
+		}
+	}
+
+	ret = set_new_ap_configuration(matrix_mdev, ap_config, cfg_sz);
+	if (ret) {
+		kvfree(ap_config);
+		goto out_clear_write_in_progress;
+	}
+
+	/*
+	 * If this is not a new allocation of vfio_ap_config, then the contents
+	 * of ap_config would have been copied into the existing object, so we
+	 * can free it so we don't leak the storage.
+	 */
+	if (!new_allocation)
+		kvfree(ap_config);
+
+	ret = len;
+
+out_clear_write_in_progress:
+	mutex_lock(&matrix_dev->mdevs_lock);
+	if (matrix_mdev->mig_data)
+		matrix_mdev->mig_data->write_in_progress = false;
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
-- 
2.53.0

