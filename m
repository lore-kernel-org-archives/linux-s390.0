Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27705439004;
	Wed, 12 Aug 2026 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535520; cv=none; b=hx5S9P8QQE6yglA7PJ43nZWSvX+ykQDx8rBMRT35Y0cigXUWP77LY24ZqYVa8UmrjN/Tz+qF8fDdfrvDNbjurivBKjEwi/hrdnMWqsd7hgWU3qVd+3ff+gL3EZBksD8i+kdq+67lvvjjArqdLgWSREd4dSgiR6h8P3iAZRbSNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535520; c=relaxed/simple;
	bh=89X9lBVJkrEtQNYhrB11Xha54OaOwKBksVJ3c7tDCcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjoqgT7nIp2sXDXTQFGdrHQ94mbYrMmfvvJYJ2MLmsxnLlw5a5eplOl6QNjfp+qZ6r9YVzD2lhGyWw0kZfyo9DEn4mooRd1mN3A9X0LOQcrcYdCpdUAP7a7KXqyMOkVh1cy5XAi9TQsfbhEcMlhQf8CZ6ITMHJvpZwcVx6jjRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G5QNBmk6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G5QNBmk6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB41JJ2205708;
	Wed, 12 Aug 2026 11:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rFapEubsnjwGtU3Ar
	h0+/W2yhsuB69iyi1GqmPDY61k=; b=G5QNBmk6lm7yC9ymYeitEC6bVHUpxjO/F
	utd2Qj3GG6GthimcSoybCp5SQXW5bj/Uket8pZaFmyAgGIPKWQbbBsPWVE3aQZnW
	4aW/uyYvHL6BEGzncRmO4T+8f9PgmzinOjPBEkI9sF1rRDkO48dSrOs6wr1WyLAl
	qnoU/wwQfCrDD1KqL6xYsRN5K6aw4H40evTRFmsJXCTt3OV4yITNFE5CGaCuFvCA
	ZcqEKLfpB5f4Cb5tDw/+5UGNIV6fQdJsH2C+63GDT2vGpBF9Q1kcfdQA/eoKaBe8
	4GhckKKPUUSCINXbKJvF1wojAKiA6fPBe5vS8UIhJut6sL0Jt3vWQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23tsnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBfIcv006387;
	Wed, 12 Aug 2026 11:51:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy5kxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:51:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CBpop326215076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:51:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2A9358059;
	Wed, 12 Aug 2026 11:51:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438C45805D;
	Wed, 12 Aug 2026 11:51:48 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:51:48 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v3 3/9] s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
Date: Wed, 12 Aug 2026 07:51:33 -0400
Message-ID: <20260812115139.576303-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812115139.576303-1-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c5e59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=A59ciYRgiFgMSmRGxjkA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX7nCs8XA5mT0X
 8I6f216k4JfxhMYCzeCkkK2z/FB7kSpa86VuV7rupvQ3emoaZVnXk9qi53KtIrV6TjyyZe1eYVC
 OQ6bt6Bbn85p8PH294SCzVqhdMamTPOUg19jpve73i2x/cwtVXiuiLE4ni9oV4rIvxYY8kBKzRw
 +nVOf+YabxTGrYYXu07rQEOqY+jWzsbJIz8Onpcv7czaT5IMLJoQreDyT/G+9w0UJCit5G1l+vX
 0itHVZKJMTlCt6ZKZJ79DcGxHC89YlNNCuy9iW5FAWpeRIBAMS9Oo+75fFnyVxtCT0qAdNhtLdd
 vr2nwMvp/dRIAJ6A+/eEJOJ9q6z1kdnlUvcaqii8uRvTKRmxZUZWqcwiKnS9CAFN+h5KYYbxp1I
 jerz+lBInCGav1Q36haSucWvwQ0zcNA4WlLFPx54wakSX3dYuZuSSOP1IRSWJu32x8qcU29jHPF
 ED/kARWN2E1mQ6CbFhg==
X-Proofpoint-ORIG-GUID: VMwSnsGx7ST3pqE32Jqw44tMwf4MRacq
X-Proofpoint-GUID: VMwSnsGx7ST3pqE32Jqw44tMwf4MRacq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MyBTYWx0ZWRfX98GaJUkij5Hi
 0TSHG57+ds2A1mHcySLP6QjF5tVZKgnD6FdWeqO45v60dJxFPFL7CtoQlvdjbOYlm9Nu7jozcPA
 GkiEeJC+kWR0jPKlBvm/8/ENzsR/OAc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120093

In order to traverse or add/remove ap_matrix_mdev objects in the
matrix_dev->mdev_list, the matrix_dev->guests_lock mutex must be held.
There are two functions that access the list without holding the mutex:

vfio_ap_mdev_probe function
~~~~~~~~~~~~~~~~~~~~~~~~~~~
The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
mutex to guard the add of a newly created ap_matrix_mdev object to the
matrix_dev->mdev_list. This mutex does not protect list access; its purpose
is to guard against concurrent access to fields contained in an
ap_matrix_mdev object. This could lead to kernel memory corruption or
use-after-free if another mdev is created or removed concurrently.

The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
is now guarded by the matrix_dev->guests_lock which is the correct
way to protect against concurrent mdev_list access.

vfio_ap_mdev_for_queue function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The status_show function that supports display of the status attribute of
the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
function which iterates the matrix_dev->mdev_list to find the object
representing the queue device whose status is to be displayed. In order to
traverse this list, the matrix_dev->guests_lock mutex must be held.

To fix this, the guests_lock mutex is taken prior to taking the
matrix_dev->mdevs_lock mutex in the status_show function. It is taken
there rather than the vfio_ap_mdev_for_queue function - where it is
needed - because it must be taken prior to the mdevs_lock mutex in order to
adhere to the proper locking order and prevent a lockdep splat; also
because the mdevs_lock is needed there to access fields within
the matrix_mdev object in that function.

See the vfio-ap-locking.rst in the linux kernel tree.

Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e382e5a1cb99..5c14ded4fd8e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -803,9 +803,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	matrix_mdev->req_trigger = NULL;
 	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
+	mutex_lock(&matrix_dev->guests_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
-	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 	return 0;
 
 err_put_vdev:
@@ -2297,6 +2297,8 @@ static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 	unsigned long apid = AP_QID_CARD(q->apqn);
 	unsigned long apqi = AP_QID_QUEUE(q->apqn);
 
+	lockdep_assert_held(&matrix_dev->guests_lock);
+
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
@@ -2316,6 +2318,7 @@ static ssize_t status_show(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
+	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
@@ -2343,6 +2346,7 @@ static ssize_t status_show(struct device *dev,
 	}
 
 	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 
 	return nchars;
 }
-- 
2.53.0

