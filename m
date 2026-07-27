Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4659B4229A6;
	Mon, 27 Jul 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173574; cv=none; b=gUtAGWLLiT596ltSnn0ygiUjgqsl4Cx+oe/h47n0UTNLO/JKnrt1ABkUoHQAUStGojeqPpDgj1mDW44j5qD1KkY13evQywnbE4lG2ohs7Vhc3OH4Sxq6n7bEhd5/PUIn7Tw4lqLnA6zYWlbVu+do7CJUQHW0cmIWIj46s/yL+As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173574; c=relaxed/simple;
	bh=bUMJckZOnhORmrqdoXixbtpeVMVFeiLuZKe048pkecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgLBE2F9WdoPRhgeg863svPvrjrBrJITkOROSOOPihvikzGdP0RbrVY/qv/2VZOXFETiGvGkkRVoBgRjz9zT+ND4lYWPJDGqLynQpzhomNp4GpH1bu5ebs2kvYQJ3xRkDkRYVuT1VTNjVJ7vqclXaasi5idn4mfLAxMrX7ea4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L6tyLNbw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L6tyLNbw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn37u2407875;
	Mon, 27 Jul 2026 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EgrtowuT45LK7S4Lm
	cg25PFewJgtFUWMobpWMu+BkCQ=; b=L6tyLNbw2bZSnjE6RjInUROc1j0+ooqBg
	EFio/D/Q5AGmv/KZzLrWrPkFFXsTsIIN5W+bP3jqOavIel4e2m42lB7Ow2b5NGPK
	PsiiYGr65qaASUi6h2bdtD4m4T+3WzVYIdWfpUAvFNZ7WW0t2l0ZYomyrfNz6SEt
	bmSdFqFQyu1kubSA868GICiMouVi04pya+htNEpeA3srw2edZ3SzdDapdpI1BCQ1
	MOWcLM9xpZjzrbOUbEQ5zetZgRPOzcOcix2Niq0OE56Ho137lmljYfX4YOD+aH74
	SJdudYtvgqCXgOMKxReUXXa4mudJLbKbdJxEkSJVOOl61vNUnzygQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xha75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RHQFKZ013227;
	Mon, 27 Jul 2026 17:32:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjxbwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RHWhq554853906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 17:32:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B201158058;
	Mon, 27 Jul 2026 17:32:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA4ED5805B;
	Mon, 27 Jul 2026 17:32:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.213])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 17:32:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Mon, 27 Jul 2026 13:32:25 -0400
Message-ID: <20260727173239.2420754-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
References: <20260727173239.2420754-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 85aW8N2AyDHCbXAJYlCGnZN61zIgzP-G
X-Proofpoint-ORIG-GUID: 85aW8N2AyDHCbXAJYlCGnZN61zIgzP-G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfX0fGuZaFoQbmB
 ewuz2vnXg2jApPFVvNp9B47owgosTSqOYHmMazwasE96GUeGSBTMv+8xZHs2HvHJuLNHfsF/t7b
 KeQfA8sEL3RfEYMgkU/4E7PRWSQw714=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a67963e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MCBTYWx0ZWRfXzKFd9S8ACRRc
 oM0sze9zMQi3DpObAhF7VGpxBGQ9wyrQbMg4HEZ0sZ79FB51UyJuaFS1gjwXd9Q2TpJTmtMODtY
 iV7QwK5IS7q07yOHo3cssKJ6dgZYD+PJ1c3tGXgehV6PGTqf8MWGDrFXSR/uCvbsrSw/ZqcUVMc
 T3DDjZXTEcQEoNrC5RomfSwZGk6r6090xfYxbuNqQPMzds32vsTJz3iw3K4MXn+8ZrLTi4NXD4+
 8EYvavTwmSJtA+B3qm/qIChVFsTjEv5oa2NpfTphYLPK7WWwsvQqxZIa/NQqNjCYAr3MJeNa5o0
 5JSvB9/2Zcsuk6/zVTuoUWnYpceuKjS+A6qHJY9z3c/K5f3VjW4UFJ/k9T7CFzGtYXQIfwfLl4y
 /m0muYOAw/bprOUxtCTJH8MosjZ+uVKipg8Ao5Nh1jvKPRGKXPaIf/Guuf6gQwdYPdJ37i+7RcO
 Lt3VEuisAmDyhGGIk1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270160

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
 drivers/s390/crypto/vfio_ap_private.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..36786d70a88f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2098,6 +2098,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
+{
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
+	       bitmap_weight(ap_matrix->aqm, AP_DOMAINS);
+}
+
 static int vfio_ap_mdev_get_device_info(unsigned long arg)
 {
 	unsigned long minsz;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 9bff666b0b35..9677e49554d7 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -152,6 +152,8 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.53.0

