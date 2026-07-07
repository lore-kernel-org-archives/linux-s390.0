Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CE3B0AED;
	Tue,  7 Jul 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414972; cv=none; b=GHExU7Vp/bGa65bkfrIBRnALO5lsolYPIETISPhP4nv4o31NNJDDWghmlnBA8TmWwNiCWfPEBqsW//rgIiwCnxcCD0hYF3uEqUO2u/YlaOf/6mjrghwx+/dDoq2YW9SfRgnLxaW3hCY0N1l6gZg6MxU8g+skjfiEGtyvWg/IVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414972; c=relaxed/simple;
	bh=GwE+CVvlXobYXM/q3fB2uYxL+pG0ej10Auu/RBIRxZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWkKU8EZgZJ9R5Yu6otlviY4By7A1sOA+gmPzyAP8GUUkMXTYACC/wbyPfUSrpuMoXTABYRXGCm2dbZyLcIEz6y7BVylnbzKkg44SkajS31+vWGJABV/aB/jQfdA3KMUFo+DwJ/hSMLPW2BvKZ1Hf/EzjY7TsK2bKd9vqINf/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R1KWwxLc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R1KWwxLc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IJeY3129795;
	Tue, 7 Jul 2026 09:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e+8Sfrg4GzhUT+kWT
	LZt5ZJb5d1nCN0rXCZg5dA2PsA=; b=R1KWwxLc8ytM6HTbRyhsk7XZzdF8NqI9r
	t2nJNa6c7JEjIEsoKsBxRuRCnuxHUa7wPjHMLSFTmFdSngHPEG+IRL8uaHcwv2Qt
	C8VYik2LoAOhlPWNy/13NNEQiySnp5oQLOsQ7W/OOo2Q1NSsvWZrzG6ArjN0X4Sc
	D7zF/PF5VuabimLg6sRm15F3lWzaO8wLHXlhTQY08Nk7o8S2ggUox3Ivs2hfC1WR
	AeiGGC3WZWDr8UDrrTNAfSNpNNlT4bq74kO4wffQcnyIiK8MYm8khbM901PTQiWW
	qeJTZrKlXPs3SoI0cXQKD4sgBTGJS9SZPosHVfBGi1dsXgPeixj/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkne3fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678nZN8028874;
	Tue, 7 Jul 2026 09:02:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg1q3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792fw757278854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 026E15803F;
	Tue,  7 Jul 2026 09:02:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0CE358056;
	Tue,  7 Jul 2026 09:02:39 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:39 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 10/15] s390/vfio-ap: File ops called to resume the vfio device migration
Date: Tue,  7 Jul 2026 05:02:12 -0400
Message-ID: <20260707090226.3206695-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4cc0b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GEAJ19QpEjkSbycx4e0A:9
X-Proofpoint-GUID: Jfp1B2vnxyuRtvn67vj0SWyc4tYZ1SWO
X-Proofpoint-ORIG-GUID: Jfp1B2vnxyuRtvn67vj0SWyc4tYZ1SWO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfXyG74nWd6oAIV
 LkUwEnAwhi8ofoVRY+t6M6Z3dhUTUx1533IPOS2SSrTzW599QXt/4ekb+aOOEuCG/iKuZggPpIz
 NotJuH0EyUzU2og0cuUDOdTxKZQOe6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX7yyx6NY6oX2+
 nZ64fsKc4hwo7I442FSOc4CeXKv4QUkrq6Pzg4EXRjQQDtwrmVsKrFqJ1qYxyJvOgU8a9pbhWzz
 XHZV525Cb7BYiB3xL15r4Dum87BlMMl9ez5EfB9SNzIJUZs7yji7ieTCFrhtSxJpJGz1L+0YM9a
 yucTBZOcNphZAndvLJJk90xeIN+CVnUbrkwNCuHM9KV+PjS8vdDcmTV9+NfEhAUILvL7b31c4t3
 TvhEZ78vMcfTnIVInx5LdC5nU0Mw5/TpczfY4cWhsEUeu8al2Z8gXkgdkhbO5eFsa4zUvhBDAU3
 OsoWY5Ouflz77/Va+eE66IG3te6VnR6JeSiiSMjji4mznmacYUh79TFWPPwdx3iZLPyH/Fx1mUG
 Kx631lsjTxDlqBVWUSIWWrFRWREHx5suZTSS2rovQy2tKEIKDVtoIz7amMo1QrZPdhI5scfmvq6
 mAYGTOVryQuBOPH/Z2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

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
 drivers/s390/crypto/vfio_ap_migration.c | 785 +++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_ops.c       |  68 --
 drivers/s390/crypto/vfio_ap_private.h   |  56 ++
 3 files changed, 829 insertions(+), 80 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index e917cc995d35..9cd1e7a3f743 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -9,6 +9,40 @@
 #include "ap_bus.h"
 #include "vfio_ap_private.h"
 
+/*
+ * Masks the fields of the queue information returned from the PQAP(TAPQ)
+ * command. In order to migrate a guest, it's AP configuration must be
+ * compatible with AP configuration assigned to the target guest's mdev.
+ * This mask is used to verify that the queue information for each source and
+ * target queue is compatible (i.e., the masked fields are equivalent).
+ *
+ * The relevant fields covered by this mask are:
+ * S bit 0: APSC  facility installed
+ * M bit 1: APQKM facility installed
+ * C bit 2: AP4KC facility installed
+ * Mode bits 3-5:
+ *     D bit 3: CCA-mode facility
+ *     A bit 4: accelerator-mode facility
+ *     X bit 5: XCP-mode facility
+ * N  bit 6: APXA facility installed
+ * SL bit 7: SLCF facility installed
+ * Classification (functional capabilities) bits 8-16
+ *     bit 8: Native card function
+ *     bit 9: Only stateless functions
+ * BS bits 16-17:
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
  * vfio_ap_migration_data - the data needed to migrate a guest with pass-through
  *			    access to AP devices
@@ -147,7 +181,7 @@ static size_t vfio_ap_config_size(struct ap_matrix_mdev *matrix_mdev,
 	return qinfo_size + sizeof(struct vfio_ap_config);
 }
 
-static int get_hardware_info_for_queue(struct ap_matrix_mdev *matrix_mdev,
+static int get_hardware_info_for_queue(const char *mdev_name,
 				       struct ap_tapq_hwinfo *hwinfo,
 				       unsigned long apqn)
 {
@@ -164,22 +198,20 @@ static int get_hardware_info_for_queue(struct ap_matrix_mdev *matrix_mdev,
 		/* For all these RCs the tapq info should be available */
 		return 0;
 	case AP_RESPONSE_Q_NOT_AVAIL:
-		dev_err(matrix_mdev->vdev.dev,
-			"migration failed: Failed to get hwinfo for queue %02lx.%04lx on target host: TAPQ rc=%d",
-			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+		pr_err("vfio_ap_mdev %s: migration failed: Failed to get hwinfo for queue %02lx.%04lx on target host: TAPQ rc=%d",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+
 		return -ENODEV;
 	default:
 		/* On a pending async error the tapq info should be available */
 		if (!status.async)
 			return 0;
 
-		dev_err(matrix_mdev->vdev.dev,
-			"Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
-			AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+		pr_err("vfio_ap_mdev %s: Failed to get hwinfo for queue %02lx.%04lx: TAPQ rc=%d",
+		       mdev_name, AP_QID_CARD(apqn), AP_QID_QUEUE(apqn), status.response_code);
+
 		return -EIO;
 	}
-
-	return -EINVAL;
 }
 
 static int vfio_ap_store_queue_info(struct ap_matrix_mdev *matrix_mdev,
@@ -187,10 +219,12 @@ static int vfio_ap_store_queue_info(struct ap_matrix_mdev *matrix_mdev,
 {
 	unsigned long *apm, *aqm, num_queues, apid, apqi, apqn;
 	struct ap_tapq_hwinfo source_hwinfo;
+	const char *mdev_name;
 	int ret;
 
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 
+	mdev_name = dev_name(matrix_mdev->vdev.dev);
 	apm = matrix_mdev->shadow_apcb.apm;
 	aqm = matrix_mdev->shadow_apcb.aqm;
 	num_queues = 0;
@@ -199,7 +233,7 @@ static int vfio_ap_store_queue_info(struct ap_matrix_mdev *matrix_mdev,
 		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
 			apqn = AP_MKQID(apid, apqi);
 
-			ret = get_hardware_info_for_queue(matrix_mdev,
+			ret = get_hardware_info_for_queue(mdev_name,
 							  &source_hwinfo, apqn);
 			if (ret)
 				return ret;
@@ -324,11 +358,738 @@ static struct file *vfio_ap_open_file_stream(struct ap_matrix_mdev *matrix_mdev,
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
+	if (filp != matrix_mdev->mig_data->resuming_mig_state.filp) {
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
+	if ((!matrix_mdev->mig_data->resuming_mig_state.ap_config && *pos != 0) ||
+	    (matrix_mdev->mig_data->resuming_mig_state.ap_config && *pos == 0)) {
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
+/**
+ * reallocate_ap_config:
+ *
+ * Reallocate the storage buffer so it is large enough to store the source
+ * guest's AP configuration data sent from userspace.
+ *
+ * @mig_ap_config: The location in which to store the pointer to the storage
+ *		   reallocated for the AP configuration data.
+ * len:		   The length of the data to be stored
+ *
+ * Returns:	   The size of the memory allocated for the source guest's
+ *		   AP configuration data or an error:
+ *
+ *		   -ENOMEM: The call to krealloc failed
+ *		   -EINVAL: The guest's AP configuration size changed between
+ *		   calls to the vfio_ap_resuming_write function.
+ *
+ */
+static ssize_t reallocate_ap_config(struct vfio_ap_config **mig_ap_config,
+				    size_t len)
+{
+	struct vfio_ap_config *ap_config = *mig_ap_config;
+	struct vfio_ap_config *new_ap_config;
+	size_t new_cfg_sz, cur_cfg_sz;
+	unsigned int num_queues;
+
+	cur_cfg_sz = ap_config->config_sz;
+	num_queues = ap_config->num_queues;
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
+		new_cfg_sz = calculate_ap_config_size(num_queues);
+		if (cur_cfg_sz != new_cfg_sz)
+			return -EINVAL;
+	} else {
+		new_cfg_sz = cur_cfg_sz + len;
+	}
+
+	new_ap_config = krealloc(ap_config, new_cfg_sz, GFP_KERNEL_ACCOUNT);
+	if (!new_ap_config)
+		return -ENOMEM;
+
+	*mig_ap_config = new_ap_config;
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
+ * queues_available_on_target_system:
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
+static bool
+queues_available_on_target_system(const char *mdev_name,
+				  struct vfio_ap_config *source_config)
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
+	 * The BS field on both the source and destination must be 0, so if one of
+	 * them is not, then report an error.
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
+	if (src_bits == target_bits)
+		return true;
+
+	if (src_hwinfo->fac == target_hwinfo->fac &&
+	    src_hwinfo->at <= target_hwinfo->at &&
+	    classes_compatible(src_hwinfo, target_hwinfo) &&
+	    (src_hwinfo->bs == 0 && target_hwinfo->bs == 0)) {
+		return true;
+	}
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
+			ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+static int do_post_copy_validation(const char *mdev_name,
+				   struct vfio_ap_config *source_config)
+{
+	if (!queues_available_on_target_system(mdev_name, source_config))
+		return -ENODEV;
+
+	return verify_ap_configs_are_compatible(mdev_name, source_config);
+}
+
+/**
+ * setup_ap_matrix_from_ap_config:
+ *
+ * Set the bits corresponding to the adapters, domains and control domains
+ * in the source guest's AP configuration into an ap_matrix object to be
+ * used to update the target guest to run on this host. An error message will
+ * be logged for each adapter, domain or control domain that is not available
+ * on this host. Returning an error after the each error may result in needing
+ * to initiate multiple migrations in order to find and fix each of them.
+ *
+ * Returns: zero (0) if each adapter, domain and control domain from the
+ *          source guest's ap configuration is available on this host;
+ *          otherwise, returns -ENODEV.
+ */
+static void setup_ap_matrix_from_ap_config(const char *mdev_name,
+					   struct vfio_ap_config *ap_config,
+					   struct ap_matrix *guest_matrix)
+{
+	struct vfio_ap_queue_info qinfo;
+	unsigned long apid, apqi;
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
+	if (ret)
+		goto done;
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
+		if (ret < 0)
+			goto done;
+
+		cfg_sz = ret;
+	} else {
+		ap_config = mig_data->resuming_mig_state.ap_config;
+
+		ret = reallocate_ap_config(&ap_config, len);
+		if (ret < 0)
+			goto cleanup;
+
+		cfg_sz = ret;
+	}
+
+	if (*pos + len > cfg_sz) {
+		ret = -EIO;
+		goto cleanup;
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
+		goto cleanup;
+	}
+
+	/* Check if we've completed writing the entire configuration */
+	if (*pos + len == cfg_sz) {
+		ret = do_post_copy_validation(mdev_name, ap_config);
+		if (ret < 0)
+			goto cleanup;
+
+		setup_ap_matrix_from_ap_config(mdev_name, ap_config,
+					       &guest_matrix);
+
+		/* Acquire locks required to update the guest's AP config */
+		mutex_lock(&ap_attr_mutex);
+		get_update_locks_for_mdev(matrix_mdev);
+
+		ret = vfio_ap_set_new_guest_config(matrix_mdev, &guest_matrix,
+						   false);
+		if (!ret) {
+			mig_data->resuming_mig_state.ap_config = ap_config;
+			mig_data->resuming_mig_state.config_sz = cfg_sz;
+		}
+
+		release_update_locks_for_mdev(matrix_mdev);
+		mutex_unlock(&ap_attr_mutex);
+
+		if (ret)
+			goto cleanup;
+	}
+
+	ret = len;
+	*pos += len;
+	goto done;
+
+cleanup:
+	kfree(ap_config);
+done:
+	if (mutex_is_locked(&matrix_dev->mdevs_lock))
+		mutex_unlock(&matrix_dev->mdevs_lock);
+
+	return ret;
 }
 
 static const struct file_operations vfio_ap_resume_fops = {
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index c5eb9e4aa85c..2c4cca4920b3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -81,74 +81,6 @@ static inline void release_update_locks_for_kvm(struct kvm *kvm)
 	mutex_unlock(&matrix_dev->guests_lock);
 }
 
-/**
- * get_update_locks_for_mdev: Acquire the locks required to dynamically update a
- *			      KVM guest's APCB in the proper order.
- *
- * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
- *		 configuration data to use to update a KVM guest's APCB.
- *
- * The proper locking order is:
- * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
- *			       guest's APCB.
- * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
- * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
- *
- * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
- *	 lock will not be taken.
- */
-static inline void get_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
-{
-	mutex_lock(&matrix_dev->guests_lock);
-	if (matrix_mdev && matrix_mdev->kvm)
-		mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-}
-
-/**
- * assert_has_update_locks_for_mdev:
- *
- * Assert the locks required to dynamically update a KVM guest's APCB are
- * currently held.
- *
- * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
- *		 configuration data to use to update a KVM guest's APCB.
- *
- * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
- *		 lock will not be taken.
- */
-static inline void
-assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
-{
-	lockdep_assert_held(&matrix_dev->guests_lock);
-	if (matrix_mdev && matrix_mdev->kvm)
-		lockdep_assert_held(&matrix_mdev->kvm->lock);
-	lockdep_assert_held(&matrix_dev->mdevs_lock);
-}
-
-/**
- * release_update_locks_for_mdev: Release the locks used to dynamically update a
- *				  KVM guest's APCB in the proper order.
- *
- * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
- *		 configuration data to use to update a KVM guest's APCB.
- *
- * The proper unlocking order is:
- * 1. matrix_dev->mdevs_lock
- * 2. matrix_mdev->kvm->lock
- * 3. matrix_dev->guests_lock
- *
- * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
- *	 lock will not be released.
- */
-static inline void release_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
-{
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	if (matrix_mdev && matrix_mdev->kvm)
-		mutex_unlock(&matrix_mdev->kvm->lock);
-	mutex_unlock(&matrix_dev->guests_lock);
-}
-
 /**
  * get_update_locks_by_apqn: Find the mdev to which an APQN is assigned and
  *			     acquire the locks required to update the APCB of
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 7ae48729cafa..7f0c69f2fd9e 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -157,6 +157,62 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+/**
+ * get_update_locks_for_mdev: Acquire the locks required to dynamically update a
+ *			      KVM guest's APCB in the proper order.
+ *
+ * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
+ *		 configuration data to use to update a KVM guest's APCB.
+ *
+ * The proper locking order is:
+ * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
+ *			       guest's APCB.
+ * 2. matrix_mdev->kvm->lock:  required to update a guest's APCB
+ * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
+ *
+ * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
+ *	 lock will not be taken.
+ */
+static inline void get_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	mutex_lock(&matrix_dev->guests_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		mutex_lock(&matrix_mdev->kvm->lock);
+	mutex_lock(&matrix_dev->mdevs_lock);
+}
+
+/**
+ * release_update_locks_for_mdev: Release the locks used to dynamically update a
+ *				  KVM guest's APCB in the proper order.
+ *
+ * @matrix_mdev: a pointer to a struct ap_matrix_mdev object containing the AP
+ *		 configuration data to use to update a KVM guest's APCB.
+ *
+ * The proper unlocking order is:
+ * 1. matrix_dev->mdevs_lock
+ * 2. matrix_mdev->kvm->lock
+ * 3. matrix_dev->guests_lock
+ *
+ * Note: If @matrix_mdev is NULL or is not attached to a KVM guest, the KVM
+ *	 lock will not be released.
+ */
+static inline void release_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	mutex_unlock(&matrix_dev->mdevs_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		mutex_unlock(&matrix_mdev->kvm->lock);
+	mutex_unlock(&matrix_dev->guests_lock);
+}
+
+static inline void
+assert_has_update_locks_for_mdev(struct ap_matrix_mdev *matrix_mdev)
+{
+	lockdep_assert_held(&matrix_dev->guests_lock);
+	if (matrix_mdev && matrix_mdev->kvm)
+		lockdep_assert_held(&matrix_mdev->kvm->lock);
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+}
+
 int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
 
 int vfio_ap_mdev_register(void);
-- 
2.53.0

