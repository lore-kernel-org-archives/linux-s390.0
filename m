Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A54F93B8;
	Tue, 13 Oct 2026 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905553; cv=none; b=oX7Gp+53X8ES9UBgr+hpftEoyfnEOI2wflVIk68/+FGJAjij9E9xb4ZBvQjgXOvPQJF64kqPz4D5uB8xVIQRNsK5vU29/30wext1vPX+JBr87bnOvm7UdSAgYcav7nsp6RkKuPlaSuxK9b30cHEtZnrWLepez3pMRsGmBB3YdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905553; c=relaxed/simple;
	bh=8AgmqpS2IfPLLkqBrNFeSppSYnwqMoUkZ5D/Mx9MRU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svTYHqX5G27V4yrjCmUN7ozuAWQZB/Ull1fFlSt7YImC0jw/WVM1STVoOFmVfMyieDH8DV/hwZ96U73JDk59f1Z/tG2ewh1S6CcCGv88HFBJat9u1Wl+cpocPWJG0gaUyiienlj/SlYtZXAV0g0IAL6ruYvsHFpA9N3n4y0AExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f7KaHrHx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f7KaHrHx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDMo5H150262;
	Tue, 13 Oct 2026 15:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GvsXguk85R/E8jqlL
	leNCGdkBhGGMMi8sM2lGJW4Nfg=; b=f7KaHrHxr2nnHekAiOX29STCqAMe0g/fz
	CRjqZkM0wTtIPETfEFejg9G46TOUnLq4KSWc56qBCLGmmTGvem+GMgfZgy0Je5Pw
	wwJ5JB62s3hYg0gcm0tne9rfSxeDYSa+M1aNZqaHfOJTGvna9R15UXXYqNA/Knwy
	Ev0ggoJnrg2+okxf85MBpSNALcR1QMKQzi+IRLRfm/ADGXwCFLCwI5Nf/usIGZC7
	jV9GKyXi5NUg6OnMTxuOyJ8XYup/H43vsL4+D/B+GbKm7CJRsHf+NeMaXjS4HeNc
	YEdQNlZSApC5aa+vez6SgZ7uaZKMV2sCxd6Lq2H6QafamzrB8Vhqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhf2t0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DFTXZv3303971;
	Tue, 13 Oct 2026 15:32:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb6r0k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 15:32:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DFWNJr30409436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 15:32:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D781758066;
	Tue, 13 Oct 2026 15:32:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 481095806B;
	Tue, 13 Oct 2026 15:32:22 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.17.246])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 15:32:22 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v9 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Tue, 13 Oct 2026 11:32:05 -0400
Message-ID: <20261013153219.3534306-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX1BGoU+F1SYy8
 WZnNGGUnOyHyrVt8pZmWjH6RavCXpMbbSWXpgXivhzJnb50vdXt5uL5xYd90Ncto9k+yeTj5sVB
 cRtIGRQHTO+OaL/07X8NL8ikfNaSOYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MCBTYWx0ZWRfX617qX3pbMrZ3
 uDqD5W8RTwsUS0z1Bls9X9bSm1kBlx7UMDlY8IWt6XTM1U4OCzyCMLwl6ogmjViZ+ZdE5Zfl69o
 CnM+Y5xEOubDbWoU0CNl7w8+cd45hXao8lLmimUyz7YjwsQMwgXMCJcN7Bl9M7Pp8DhbozqW/ya
 k8C8Rj6uaDnOYiw2fFruYG/ugsAFY2MEgXKtE1E1ZMvNfKwiC9doTmhLM1hgE+mOLTrMe+cKhph
 YW4T6flVKb+j7Rr8BcfLEhzvqOsq1zPrAqJMUGivh9kCmU9LnsGSd06IBdn97pdwRGId9Asu3WB
 BMAPK61v4paFBwJspj8/Pbakf10Wg2BujjHndjkkCGcTmW3H79KCVbWxCggYknov2+1Gut+lEK9
 tUfi2eVEMcxsd7fFr8ypUjOR/BaHnixOwURxlWIRFEOVrE7W1lP31SbKl+M9qG5zH+K+bBC2I7i
 vKSvotU2fXAUErc+avA==
X-Proofpoint-GUID: UZg0i5kd2O0f7svxdan9_c1ccyVTPYyW
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace4f0a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-ORIG-GUID: UZg0i5kd2O0f7svxdan9_c1ccyVTPYyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130060

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
 drivers/s390/crypto/vfio_ap_private.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db878c18f41..345c52a328ad 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2105,6 +2105,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
 	release_update_locks_for_mdev(matrix_mdev);
 }
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
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
index 9bff666b0b35..12d7d240addd 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -152,6 +152,8 @@ struct vfio_ap_queue {
 	struct work_struct reset_work;
 };
 
+unsigned int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix);
+
 int vfio_ap_mdev_register(void);
 void vfio_ap_mdev_unregister(void);
 
-- 
2.53.0

