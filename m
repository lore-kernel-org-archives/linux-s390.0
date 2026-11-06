Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978592;
	b=Etb0863qxxCoBSJ3WvA/wlutyPR3Y4cZaH9mbNKGKWlEGjWiBMlM3bed2RVA+FJMI506
	 js+fy4el3o+iM3Q7AysvyrADlZSc+tMfWcjrVudFum/o6r8FkS7XfFJ5Cv/Oj7GqY0qv6
	 TmZ6JvPYg9FwwUA75SLs0hIPnH26pXTlx9h0GxZe94H+izphcriJ2pn2hyvNFemAkzFcM
	 EynkUAaVhid86AfpRYf9OQko2l2nNHTxfnStQ5QapxaTjXidh22d4IHEeA95UhbSX8/ck
	 2PVKOwUhnrN7YORHCU3sJU30XSzlGpZTOdTZx3qdkRHAxb4rgwL7U9X2CPxIfQXRU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4FwtvuIAIzzf1W6DoLcxSMo6B2sr2GRT8crxL/9cXAs=;
	b=vpX2JgXfnnOxJXWJwucA6fH+eOWmQ+bhqkOGmyrZ+JaiNb0pv8KMnBpbuTGjlwBrbcir
	 IFvvU2gpquQoMA95JyM76iGvtHKrLbC3HQYyUSCoB9YVJ6VZk37z3MiMLll5Lo60aPe/v
	 bVtOB8qi4+d+6xk2UXlE9CgaQedtUBHQfcG15enTUi9LLAZd1PbJxdOhHdMsGUFtVLxSZ
	 4EqJiN/Y8phEfiJFNyweUfncwQNKMS19dlhukLUmYMbbc/6fyUw9NAmhHg3V2B0lPZl3d
	 D25nKbvaUVfcg3xtYHTcQ2ysiRKBUtBW1k4xuOnU0SvjAegoOdWttVI1GPHlrL6FZxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CmZrT0JN;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B8606A326;
	Fri,  6 Nov 2026 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510B8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CmZrT0JN
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEFgN1544360;
	Fri, 6 Nov 2026 15:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4FwtvuIAIzzf1W6Do
	LcxSMo6B2sr2GRT8crxL/9cXAs=; b=CmZrT0JN/IS7Yh+cvqVCy7fRAGC8PjxJb
	B3RZkrR5QHSzP4fzV/WvPFd2UfxGw34dfRE+7ABn5vdNlXtOOE2kUbYLwKvHjC/1
	zi8Dliju+HiTluMColXVfpE4dVg4awB3fMDK/Wq5lrx/e5yDVAD/K5w0xBsI4hyV
	ZcmHAkVzhYDesVk0XH31sfeeGIerG+UKchKJr/h3m3gkmoYyRumAY0n3G1x/uIX/
	cAI4AiOpIg1x/YdiH6t+UMDtEAhNVwXa4P1a78P2z/yqp/MRZpCyKo3zLmZbraJD
	CCbDitjZhE1GOrLiShS07G9/tIaxdkW9W6Cke1oS+V9ymgQkC5+BA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbw4jn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4uH73538281;
	Fri, 6 Nov 2026 15:23:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9msu77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:23:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FN4Ie41550518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:23:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20F9558066;
	Fri,  6 Nov 2026 15:23:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7283A5804E;
	Fri,  6 Nov 2026 15:23:02 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.114.69])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:23:02 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v12 01/14] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Fri,  6 Nov 2026 10:22:46 -0500
Message-ID: <20261106152259.1360651-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Y63c_zVQpyg3HPWLMWN4ZTATFrbitWny
X-Proofpoint-GUID: Y63c_zVQpyg3HPWLMWN4ZTATFrbitWny
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedf0da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX8lqxMsh27JOw
 cm0HLUVUpS/HPbKWb90npQW+TV7LtFZ6mPr/6uHhFlD692cXEAep9l1iHprvL2GBkwXdK0ezM37
 W2DvZewMnJp3XQesojeakn6jho9MX4Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX84imP+G49/8+
 lsU6h2F4fwfShoPm5ZIs+tIjW+gWWNiFJdrPoC/VcCk/YfFEq/s6k/bLmu5YzzU8bnxuewDpNL3
 /P6tFzOw5Kt0Tf7F5lOgcqLwMLobjjg0IH5vnkDRQEJaNquCI31WejOyefx7ywWEtDvrYNASHkw
 4vHA3xAhCV8xDXlEBYkkeZaywKwkd2Eu7FdSUHJMyBS6rNXzY2HxziNihf9KcVNZs1FEFUpPMlz
 QRhmQBRu9J/+v0owQ8ZzthjEDDwAu2V9/eyMeTY1+/ZTbni2igrbjgkQAyTjylZN0SZmQxKVKxQ
 wTBXSIlFL3vYjxWGZApJx4r3C6dHxbPMt1weHCQikLnRvPaFz69ijyRUT9E9Jubd70RWuxnigRz
 TOV5ywjDSkndsKtZI/LI0BZ1HxZHJouPXqxaHf0bkC1HhK0ZKQWY4yQmnRHG/qvhv2YzxuQXiWO
 mMrJl9w7FUvIuUInb7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060060

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

