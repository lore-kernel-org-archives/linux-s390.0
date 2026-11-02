Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632573;
	b=hp3+h99mce1jsrkOjOR6cGNzjEw5hu6rCltx3sfH9BAIzPZj7kn4hl38Xr1FkvDi88JX
	 r3g4WP5CADUistd5q3XPCaWrWdSxLLOcauL7JOimo4CnJMQw31FQ0hbOKDftlr75N1m46
	 yfnPrg22FMe7r40WR38B+4XSj2XrvdWBRqSQm8kwqOMGVl7JOP7I+9AunIP1jGTKUkhtZ
	 TPnzYbiSIBBszD9bK0B/pW5kD+gEwpqLM3qkWwd+iW80AKKaJT68SS5hRsOhWPc/RPPkS
	 8NPkQT9GFHABT8LHR0TPTHsuFoBdQcwBNsK64w209iCqpEc+wSgQyG3q3Imt52SQQQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632573;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4FwtvuIAIzzf1W6DoLcxSMo6B2sr2GRT8crxL/9cXAs=;
	b=RuPiDwg5YhZpz9vKIgkOSTZq7ocBHqK1Kklz1wNM5O/rp5DPA6AldaJOq4LpwdjAvNQK
	 kj+9ydZ0TPQbnU869Wz/QNa2k1QS4zzLlRz3XMs2XV/YDbSRUfxhcXX3ygJrlCNKYbQGT
	 DUFxH7EBq/RoDas6G2xZw5dPiVkZWhx1M9OSpXO73HhzO5mWcKDG3jrFTJUUL6k/AjuJE
	 Wti+iwqtkAlDfaoNyGB+P8LwFno/2jNblqc1WF9I/HlMbFPZQUOqSEMAtLo0DJVCsC3tY
	 j97glDiQoYnCG9+JzZ/8NYzdcjAnv+lKXtDUxquXYYxNzX+Oqx3laERNTFSwfW8pRGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B8XxKZt6;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB9607B46B;
	Mon,  2 Nov 2026 15:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DEB9607B46B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B8XxKZt6
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEgfh1950773;
	Mon, 2 Nov 2026 15:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4FwtvuIAIzzf1W6Do
	LcxSMo6B2sr2GRT8crxL/9cXAs=; b=B8XxKZt6nTCaYPBYmTv9RR7Oi3FyNYWWM
	1oUdmMN+yi129AS30WU17SK9ZAiIiXCRc/ubtXhBkCmt+eonyIi2pAxPz7whuezr
	tkQKHafTvtefMAJ5ILhGpY5L/VOTql173F0CcFJY2VUOB9imHUO8vBemCx4pNrLg
	XlBLvGvZkvbLpb2zbi0LgO7ujVgnjUvTQA0Mx8nRFKJjBaERejwyZaAbtMKXhva0
	81z2RRSEDBYLgEzt9bLHlbaz30dnc1YhdmhK7/rCqjkq8lY1YWxTzImkYgoAE/0C
	62loAQydu1i+uC4UmSbDtiIiQbFhqtlwYwic8+UHHIaofF5pNypnA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd19e6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp8MC932246;
	Mon, 2 Nov 2026 15:16:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxf4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:16:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FFJMq22741624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:15:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A96F75805A;
	Mon,  2 Nov 2026 15:16:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 720825805C;
	Mon,  2 Nov 2026 15:16:06 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.57.150])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 15:16:06 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, freude@linux.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com
Subject: [PATCH v11 01/14] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Mon,  2 Nov 2026 10:14:41 -0500
Message-ID: <20261102151604.2150055-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-GUID: xpYKbzNFAAmSo4fXS5gIO6Srwvxfs-VX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX8zm2Iq6gb1uG
 gMROOw8P9GmMnzLw95F0aQ9eL+JZvyKJl4kOfgkL0CzlyW2osV3Pxt2Wzu5B+UfceM7LE6Ap5uM
 KapjD5YxMnrsJ3K/WqYjPcj0RJmb1bcsEz63Zy+ey+/mysDLGWyO9UzBmvKxP29tvhiJAE8vNTZ
 DyhJzrEUmc+QIYuF/6CgSEZelGDiApqAb0pOmE68srmjf0Ot13/VLrfPskXIFgsS2ys44ba1vUf
 gt90LQuAZ6CH8dlQD3FypKrcH98/bH0WyFS1VAWp2NC0/cewBnKAbvaELD1a/bRehUVE5E9i4CK
 g6hoip2vZOnMaKx4dZ8pdviOZGEX/DKNtQBe+Yv3jOshZLjHTZRiFNQpPM0QcmLjYQxg/Kj8fCp
 6lXqDoFIysZVsi2LERqqesCu2YG9eDdukhfFM8j85Zl11t2ABSOcXLPVa2bTTMGp0002NjjWwNp
 TGuRINajwLf58bzjYlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX2UPOQo+ewdtt
 CgDXOsoHZllELMu9fzfdbINKTa+Xft32qntVt3dj10cisiafAPpXxedzMJz95bj68B8/yq+Tx7S
 shoqQ+pAdAhn+ccZaNXr7B+XpHvzQQU=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8a939 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-ORIG-GUID: xpYKbzNFAAmSo4fXS5gIO6Srwvxfs-VX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020060

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

