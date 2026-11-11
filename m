Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425001;
	b=nfIRbwXgLx1HMO2t0S+yTB8kWIkVXjPOEPk2X1hPIjHTSoDQmAda5TGxGBDPURKZTVQF
	 2vF3zqvcYyhruUCHMcjPMcvLuaj1a6ELSSMTaPWUu1jKnWwcodjGXG/yFFsJxkeKvKPIH
	 fZ1NMPSNZaW882IvaLbQCCeuXLkPLdUsM0PUVWjhXO/bOdU+DcvubbcEZ4yPTgSdrE6pF
	 WmgAfNilkP+K33PtLtrOVq+WuKHPPJkY7TwyMxgF5YdWk+c7mwYRuxL5HA659cbrKxS34
	 9v1xFxErmVKY8qAG6yiy8+l3ahj/cJzfSsoYO039kjZ7whoIk4PPZT6kZJFLv8WwyRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425001;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4FwtvuIAIzzf1W6DoLcxSMo6B2sr2GRT8crxL/9cXAs=;
	b=jtOd1/pROe8OgXHS7jKVpOEtpP7aZvGJQgRbA/ROYZ10MowfGrhbU+656TQ7Ja6mc7QA
	 rOaTGbsJ8vUSIDqhtBBzxQq4NhXlC/H7y1R9Jyk8swjpqcOr/KdIaxVgLHsgtzH5U4bJU
	 eLa0uuLLKTIOONBySFrBmoHch3+N82KBrdd0hlkS7RNVd7y6+jLU234bl0LLVO+xZpkhJ
	 LfKRbD0AC3XxjDEInDTeFUp1Fyco22AU0+55deNEQFjhmrqDtPBeP9zd+pZqa8oWnVhLh
	 tJ12ERNww2iHk0CtQOpqDX+JUC/mgaq4XRcfrlQLp4PE8H6DB5UtLt4MIFbqAvUD9FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UruHoQTi;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C101606A331;
	Wed, 11 Nov 2026 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C101606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UruHoQTi
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIiH601828804;
	Wed, 11 Nov 2026 19:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4FwtvuIAIzzf1W6Do
	LcxSMo6B2sr2GRT8crxL/9cXAs=; b=UruHoQTi1Zml4HT/s7XWPQxtkJoSRpNz8
	At7m3yaRXOqhkS3xqkr5OW6ZTztz4J0g4xRLVtDagwTh/wC1gG83C0spSQKf0RSq
	Gegf6ZI0HF4vc3i3yTMhJC3/vW7a1+g4ZDyTeNAc/YhucjZ0jyMM4pP7a5qlwgud
	fa9yhkZIS2HXWjuopI/taF97XXRV4zGj48Gkc4uEJ6UTMBAiGi9CBGREGxhUFjYJ
	AGSAwh2plEPhYtBPSlqc+ds1qtKbXxOkwhoZ3fnvyxL4GvQV04X96rHI8bOkRJip
	WH+XLgaKGdS39EIKyzUq44bgDXJZzocPk9CylR3gOiFESkfuvAbcA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkuux2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABIZ2U03727798;
	Wed, 11 Nov 2026 19:23:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309nueu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 19:23:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABJNBIh32309986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 19:23:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2ACE58056;
	Wed, 11 Nov 2026 19:23:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8F9458052;
	Wed, 11 Nov 2026 19:23:10 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.182.62])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 19:23:10 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v13 01/14] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Wed, 11 Nov 2026 14:22:55 -0500
Message-ID: <20261111192308.2585984-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4c0a2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX5XpHExEsr5C3
 G0OLIKz9gjLXlzZHz3TsOKZb1u+uwKRkNouCT/SY1AIw3u5D0O5PIXbsV+frpakqiD8RCqacyO+
 usr8J+LMwPdmaa5DHLcmO2amf/JZjO1K9YU+rNOUu/QjM4HNgjCXrqvbrMGdm72BTld8dWsABp3
 b6sWUBMpLi9LigcWBzFDdrzFqRsqXGFz+hlUrzhk4TjRG7sOhjAkhczm3xYkTxPIJ2ee0U72gGn
 wlhubodd5BIUREqxiz22PutvtpgXX/3zvqX0P8Z6H11EHEQmZLDLhMI6kUzYRqw3EJS3BZI2F7t
 xDluerCI3Ccdgoxa8s5U4EGME2paOP6SUXt3KHQGLXcdDxcJKo7lPKBQno5krWXq9/h6Nw5aTBe
 uWYJJW27Z1mR/w4pF5UZ0J8uDfG6R5nzWLzwbyqYR24c+JLBGjhCkQw8Cawr36Yr/6cVQPHHSdy
 +jWXJFlT0lqivBQFQUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3NiBTYWx0ZWRfX7f4EjvUOQw8j
 +/guf2j6xbaaZXSLZ/sWVhopZefJmesVEm3maop7vr68IR3hEQZtT75WtmDvhNyWXGjxmw0qO+T
 WVHSmUrzh27m5RiNhAN0nrJdlgzEZkA=
X-Proofpoint-ORIG-GUID: Wizml0ARuq5qWR-CxFYj_iOXQBLmIzxC
X-Proofpoint-GUID: Wizml0ARuq5qWR-CxFYj_iOXQBLmIzxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110076

Provides a function that returns the number of queues that are or will be
passed through to a guest when the mdev is attached to a guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
 drivers/s390/crypto/vfio_ap_private.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 373ce574c431..83ba4193bdc3 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2113,6 +2113,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
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

