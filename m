Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43960446823;
	Fri, 24 Jul 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909670; cv=none; b=BLRYiriGUNh6GdQNILdd+O56POUUuQX6vXSw5f5/9fjHen5+WXPu8ws886VIRK7RimR8NWh8VK82Gzl0food+s39EOl1iiZWZWKkYjkNwmCQ7mHGA6Ip9QV03jMqmZG/XXPc2ywwlFXowQ1V/Zyz6Dr8r7nTEcjWnxMIaKRvimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909670; c=relaxed/simple;
	bh=WnfhDQrigzzu2s0wxYhtHgqIwjB45QseGEGDpb/t+IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxPoQ8I8xmU4Wy+7549xuxhWe/ry6D+/UXZ0LbbqE4jzLQDVA1RD4psdOp0hl69EvzexYvU8jWtNeKV4fvxbybWxGC/Ge24g8Zro4/BB5hEZ1mx5V+eL+gn5B/9sNvjki+QXyYzWDGUBq8uiC+zYpUAYdRqcRoq3MA0K5iZl5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZemeS2YB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZemeS2YB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfnjE1869258;
	Fri, 24 Jul 2026 16:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aoaX9VEI6UyC9mH8S
	WFVjb0z82tG2tTVRFFnTceFu8E=; b=ZemeS2YBbSgmHJoLUZylBsMeM2f7FmSKV
	VuIHULcpWmtndkRascxP0BiqmGMqr+BUES2Jb9J1a1xe6XlFcJ0W7aYiogSdcVnk
	Ec6HFTqP0iBufXavsNl+DTbfi9tbPDzb3agQ6ovv1mC4LT0UI+Idb7ZVl665zA44
	kq95rXEUqQBuaxjCVDzbeWDVB2Ks6XZr6tlMUiswTe4d9qsTW+WW+HQtu56maJEZ
	6KF4TpVeoXkK3d/D1y4U3QvwcJ6x1nWVn0AKu3OawNNT+6GbSFSfC8Fkz/dfLZtC
	J+aw9lPyI4mEyRgAG5r7YdF+54JzAtgR3vJ2TqzmS/0ewTB0WWC3g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmvd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OG4h2A010743;
	Fri, 24 Jul 2026 16:14:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gsf8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 16:14:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OGEB9s2818710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 16:14:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6355804E;
	Fri, 24 Jul 2026 16:14:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71EC5803F;
	Fri, 24 Jul 2026 16:14:09 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.50.28])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 16:14:09 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 10/15] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Fri, 24 Jul 2026 12:13:46 -0400
Message-ID: <20260724161351.1802644-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX+K1Z1U1veqNo
 63GRw/izL2hVC9JzbhmlG1FlRyMbVlmRj/I7U35/70d3PB38phEqu9Uujwjf4hMgBpMoV9LQgF8
 0Ykvz5xdG+JNxqyyGTE2J7TAHRIJzpnZdYyEv6sI3vVKRVOaS9NmFRNv243p4iCDyh0BDw8u6v3
 9fKQExg5BFZkssXlZAZjAUsM7z/ZI+ZhGnAlbxLTyhDPBemKKf6bGFkteFfR0Wh0B3K9OrNfufN
 O3i6MEhTzr86/7P2QGQwhPHVNUxWISiyQXo4bjLPylqVz78V6Vv55vWRzhGQXOQUgdC6d2qPw/K
 zzUY7ABKqzvkiwJQOgT9mtIXeWkFUYN95cYFiqqYouYVANy3qCXlTYaBT73hGq5BgtjcOpfAfzJ
 RYPjBcH8GWG+5maDlzKxpeYj+dQSL2auvUqdrYAYf7Llo7hnISXELiaV5s8rFFF3R7XG2GJrGQ3
 QfkltIStx36isGuXhrA==
X-Proofpoint-GUID: udDULVX5dI33-QoZv8XxTOISFrBrnzfl
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a638f55 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dAFWD2Np9BBlLd7oX9IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NSBTYWx0ZWRfX+YZ1lHYjfsNf
 fVlogN5QliwZb+tJjM8BjRuOqsMlN7Tiy72+yqo5HFj0Bx0YZ383PgA2KGnxd1IHYusJpunHBH7
 94F7eT1h0EqesSNzG7NpBlfoIAZOc4Q=
X-Proofpoint-ORIG-GUID: udDULVX5dI33-QoZv8XxTOISFrBrnzfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240145

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
 drivers/s390/crypto/vfio_ap_migration.c | 830 +++++++++++++++++++++++-
 1 file changed, 826 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 4a489a7a05ff..7a9a8f63a76d 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -8,6 +8,54 @@
 #include <linux/file.h>
 #include "vfio_ap_private.h"
 
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
 /**
  * vfio_ap_migration_file
  *
@@ -204,8 +252,6 @@ static int get_hardware_info_for_queue(const char *mdev_name,
 		       status.response_code);
 		return -EIO;
 	}
-
-	return -EINVAL;
 }
 
 static int vfio_ap_store_queue_info(const char *mdev_name,
@@ -409,11 +455,787 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
 	return filp;
 }
 
+static int validate_resuming_write_parms(struct file *filp,
+					 size_t len, loff_t *pos)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+	loff_t total_len;
+	int ret;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	matrix_mdev = filp->private_data;
+	if (!matrix_mdev || !matrix_mdev->mig_data) {
+		ret = -ENODEV;
+		goto done;
+	}
+
+	if (filp != matrix_mdev->mig_data->resuming_mig_file.filp) {
+		ret = -ENXIO;
+		goto done;
+	}
+
+	if (*pos < 0) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (check_add_overflow((loff_t)len, *pos, &total_len)) {
+		ret = -ERANGE;
+		goto done;
+	}
+
+	/*
+	 * If the ap_config has not yet been allocated and the file position
+	 * indicates this is not the first write, or the ap_config has been allocated
+	 * but the file position indicates this is the first write, then this is an
+	 * error condition.
+	 */
+	if ((!matrix_mdev->mig_data->resuming_mig_file.ap_config && *pos != 0) ||
+	    (matrix_mdev->mig_data->resuming_mig_file.ap_config && *pos == 0)) {
+		ret = -EFAULT;
+
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	return ret;
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
+ * @ap_config:	The location in which to store the pointer to the storage
+ *		allocated for the AP configuration data.
+ * @buf:	The userspace buffer containing some or all of the source
+ *		guest's AP configuration data
+ * @len:	The number of bytes of data to copy from @buf
+ *
+ * Returns:	The number of bytes of storage allocated for the config data or
+ *		an error:
+ *
+ *
+ *		-EIO: failed to copy data from @buf
+ *		-EINVAL: the number of queues specified exceeds the max allowed
+ *		-ENOMEM: the allocation of storage failed
+ */
+static ssize_t allocate_ap_config(struct vfio_ap_config **ap_config,
+				  const char __user *buf, size_t len)
+{
+	struct vfio_ap_config tmp_ap_config;
+	ssize_t config_size;
+	size_t copy_size;
+
+	/*
+	 * If the length of the data sent exceeds the size of the vfio_ap_config
+	 * structure, then we will copy enough data from userspace to get the
+	 * number of queues which we can use to allocate enough space all of
+	 * the queue information.
+	 */
+	copy_size = min(len, sizeof(tmp_ap_config));
+
+	if (copy_from_user(&tmp_ap_config, buf, copy_size))
+		return -EIO;
+
+	/*
+	 * If the length of data sent includes the number of queues
+	 * in the AP configuration, then calculate its size; otherwise
+	 * set config_size to the length of data sent.
+	 */
+	if (len >= sizeof(struct vfio_ap_config)) {
+		config_size = calculate_ap_config_size(tmp_ap_config.num_queues);
+
+		/* If the calculation returned an error */
+		if (config_size < 0)
+			return config_size;
+	} else {
+		config_size = len;
+	}
+
+	*ap_config = kzalloc(config_size, GFP_KERNEL_ACCOUNT);
+	if (!*ap_config)
+		return -ENOMEM;
+
+	return config_size;
+}
+
+static ssize_t reallocate_ap_config(struct vfio_ap_migration_file *mig_file,
+				    struct vfio_ap_config **new_ap_config,
+				    size_t len)
+{
+	struct vfio_ap_config *cur_ap_config;
+	unsigned long cur_cfg_sz;
+	ssize_t new_cfg_sz;
+
+	cur_ap_config = mig_file->ap_config;
+	cur_cfg_sz = mig_file->config_sz;
+
+	/*
+	 * If the current configuration size is greater than the
+	 * size of a vfio_ap_config structure (i.e., contains the num_queues
+	 * field), then there should already be enough storage allocated
+	 * to store the source guest's AP configuration. Let's verify that the
+	 * amount of storage allocated is what we expect based on the number of
+	 * vfio_ap_queue_info objects that must be stored.
+	 */
+	if (cur_cfg_sz >= sizeof(struct vfio_ap_config)) {
+		new_cfg_sz = calculate_ap_config_size(cur_ap_config->num_queues);
+		if (cur_cfg_sz != new_cfg_sz)
+			return -EINVAL;
+	} else {
+		if (check_add_overflow(cur_cfg_sz, len, &new_cfg_sz))
+			return -ERANGE;
+	}
+
+	*new_ap_config = kzalloc(new_cfg_sz, GFP_KERNEL_ACCOUNT);
+	if (!*new_ap_config)
+		return -ENOMEM;
+
+	memcpy(*new_ap_config, cur_ap_config, cur_cfg_sz);
+
+	return new_cfg_sz;
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
+			pr_err("vfio_ap_mdev %s: Queue %02lx.%04lx not available to vfio_ap driver on target host\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+		if (!ap_test_config_ctrl_domain(domain_num)) {
+			pr_err("vfio_ap_mdev: %s: Control domain %04lx not available on the destination host",
+			       mdev_name, domain_num);
+			available = false;
+		}
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
+			pr_err("vfio_ap_mdev %s: APSC facility installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: APSC facility not installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: APSC facility not installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s APSC facility installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->mex4k != target_hwinfo->mex4k) {
+		if (src_hwinfo->mex4k) {
+			pr_err("vfio_ap_mdev %s: mex4k facility installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: mex4k facility not installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: mex4k facility not installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: mex4k facility installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->crt4k != target_hwinfo->crt4k) {
+		if (src_hwinfo->crt4k) {
+			pr_err("vfio_ap_mdev %s: crt4k facility installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: crt4k facility not installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: crt4k facility not installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: crt4k facility installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+			pr_err("vfio_ap_mdev %s: Coprocessor-mode facility installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Coprocessor-mode  facility not installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: Coprocessor-mode facility not installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Coprocessor-mode  facility installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->accel != target_hwinfo->accel) {
+		if (src_hwinfo->accel) {
+			pr_err("vfio_ap_mdev %s: Accelerator-mode facility installed source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Accelerator-mode facility not installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: Accelerator-mode facility not installed source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Accelerator-mode facility installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		}
+	}
+
+	if (src_hwinfo->ep11 != target_hwinfo->ep11) {
+		if (src_hwinfo->ep11) {
+			pr_err("vfio_ap_mdev %s: XCP-mode facility installed source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: XCP-mode facility not installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: XCP-mode facility not installed source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: XCP-mode facility installed target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+			pr_err("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility not installed in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: AP-extended-addressing (APXA) facility installed in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+			pr_err("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+		} else {
+			pr_err("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) not available in source queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+			pr_err("vfio_ap_mdev %s: Stateless-command-filtering (SLCF) available in target queue %02lx.%04lx\n",
+			       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+		pr_err("vfio_ap_mdev %s: Bind/associate state for source (%01x) and target (%01x) queue %02lx.%04lx must be 0\n",
+		       mdev_name, src_hwinfo->bs, target_hwinfo->bs,
+		       AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+	}
+}
+
+static void report_aptype_compatibility(const char *mdev_name,
+					unsigned long apqn,
+					struct ap_tapq_hwinfo *src_hwinfo,
+					struct ap_tapq_hwinfo *target_hwinfo)
+{
+	if (src_hwinfo->at > target_hwinfo->at) {
+		pr_err("vfio_ap_mdev %s: AP type of source (%02x) not compatible with target (%02x)\n",
+		       mdev_name, src_hwinfo->at, target_hwinfo->at);
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
+		pr_err("vfio_ap_mdev %s: Full native card function available on source queue %02lx.%04lx\n",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
+
+		pr_err("vfio_ap_mdev %s: Only stateless functions available on target queue %02lx.%04lx\n",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
+	pr_err("vfio_ap_mdev %s: Migration failed: Source and target queue (%02lx.%04lx) not compatible\n",
+	       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn));
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
 static ssize_t vfio_ap_resuming_write(struct file *filp, const char __user *buf,
 				      size_t len, loff_t *pos)
 {
-	/* TODO */
-	return -EOPNOTSUPP;
+	struct vfio_ap_migration_data *mig_data;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_config *ap_config;
+	struct ap_matrix guest_matrix;
+	ssize_t ret = 0, cfg_sz;
+	const char *mdev_name;
+
+	/*
+	 * When userspace calls write() with an explicit offset (pwrite), pos is
+	 * non-NULL and the function rejects it with -ESPIPE (illegal seek). For
+	 * normal write() calls, pos is NULL, so we'll use the file's internal
+	 * position filp->f_pos
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
+	mig_data = matrix_mdev->mig_data;
+	mdev_name = dev_name(matrix_mdev->vdev.dev);
+
+	/*
+	 * If this is the first write operation, then allocate storage for the
+	 * AP configuration information; otherwise, reallocate the
+	 * struct vfio_ap_config object used to store the AP configuration data
+	 * sent from userspace.
+	 */
+	if (*pos == 0) {
+		ret = allocate_ap_config(&ap_config, buf, len);
+
+		/* If the allocation failed, we'll return the error */
+		if (ret < 0) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+
+		cfg_sz = ret;
+	} else {
+		ret = reallocate_ap_config(&mig_data->resuming_mig_file,
+					   &ap_config, len);
+		if (ret < 0) {
+			mutex_unlock(&matrix_dev->mdevs_lock);
+			return ret;
+		}
+
+		cfg_sz = ret;
+	}
+
+	if (*pos + len > cfg_sz) {
+		ret = -EIO;
+		kfree(ap_config);
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		return ret;
+	}
+
+	/*
+	 * We don't want to lock all mdevs while copying data from userspace so
+	 * we don't block all other mdevs in case the I/O takes a long time.
+	 * From here on out we don't need this lock because we are not
+	 * accessing the matrix_mdev until we need to get the update
+	 * locks to set the new destination guest's AP configuration in which
+	 * case this lock will be taken then.
+	 */
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	if (copy_from_user((char *)ap_config + *pos, buf, len)) {
+		ret = -EIO;
+		kfree(ap_config);
+
+		return ret;
+	}
+
+	/* Check if we've completed writing the entire configuration */
+	if (*pos + len == cfg_sz) {
+		/* Acquire locks required to update the guest's AP config */
+		mutex_lock(&ap_attr_mutex);
+		get_update_locks_for_mdev(matrix_mdev);
+
+		/*
+		 * Verify the device wasn't closed while mdevs_lock was dropped
+		 * for the copy_from_user above. get_update_locks_for_mdev()
+		 * reacquires mdevs_lock, so the check is safe here.
+		 */
+		if (!matrix_mdev->mig_data) {
+			release_update_locks_for_mdev(matrix_mdev);
+			mutex_unlock(&ap_attr_mutex);
+			kfree(ap_config);
+			return -ENODEV;
+		}
+
+		ret = do_post_copy_validation(mdev_name, ap_config);
+		if (ret < 0) {
+			kfree(ap_config);
+			release_update_locks_for_mdev(matrix_mdev);
+			mutex_unlock(&ap_attr_mutex);
+			return ret;
+		}
+
+		setup_ap_matrix_from_ap_config(ap_config, &guest_matrix);
+
+		ret = vfio_ap_set_new_guest_config(matrix_mdev, &guest_matrix);
+
+		release_update_locks_for_mdev(matrix_mdev);
+		mutex_unlock(&ap_attr_mutex);
+
+		if (ret) {
+			kfree(ap_config);
+			return ret;
+		}
+	}
+
+	mutex_lock(&matrix_dev->mdevs_lock);
+	kfree(mig_data->resuming_mig_file.ap_config);
+	mig_data->resuming_mig_file.ap_config = ap_config;
+	mig_data->resuming_mig_file.config_sz = cfg_sz;
+	mutex_unlock(&matrix_dev->mdevs_lock);
+
+	ret = len;
+	*pos += len;
+
+	return ret;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
-- 
2.53.0

