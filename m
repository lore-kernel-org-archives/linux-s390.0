Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0003A59BC;
	Fri,  7 Aug 2026 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141127; cv=none; b=fkuiw3ECc58nldPt/wLNJoXypHRvt4nk4adEaG6mk4dUwyZxA83MaYWbn2jdTDZU7hWOnM0bt6LLuNzYL7X4UCzu0Vd7yaUFv+HJbIjJHw4XTFi5DRPIDGTa8HstWnaJ73tgVPbR06CMZuDijv1sbdGcbMwo/SVkxVLCJfJtCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141127; c=relaxed/simple;
	bh=bUMJckZOnhORmrqdoXixbtpeVMVFeiLuZKe048pkecQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL2Vjtm9/WIY1+oLROccxO38/si5j8PSCOsZ9x/IsXCsWdJtY393KtWiXGmscYCff56qOaFLy1ENEagNZBcUmhUktVIbEtBLWQpOgc8Sx4cT7Sk8rHdneGWyjXoFphjljx/g/QaEg0bup9icsTRJfMX54wh+0ufNu4ZmMvGeQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YkKBIftI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YkKBIftI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Lm4Sg2571261;
	Fri, 7 Aug 2026 22:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EgrtowuT45LK7S4Lm
	cg25PFewJgtFUWMobpWMu+BkCQ=; b=YkKBIftIQBKjM+nLIrex2HvF+AtsyTYVT
	TbKcrX/24lStpjg6rhbX6jVepkpWA2lGq7ase0xSGTzo5th4bOOVPRwOcqz5vuoa
	9euiOpg1jQPLG/vma+gO+zvJFMzl249z9DlMQvE1HfLYkV41lgAoVhfJYFLV6MJg
	xEVPGFEWDPEzXdt41AsCVH7eLHkGUgHZ4hXS+6pTqkHmPkyFAlaEYZIJB33ukhwG
	QCwF3GPHYdSRq73snzzcWNuTjDBpeLO1M6aWYJaJzZ3vnEqZNWxzG6zIeNQpbuuI
	q8sP/NxpkiR6HO3+i+gp0FzOKIYr+fbTja+xSxqV5fJ00JhKEXaHA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02e1k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677MBdx6016748;
	Fri, 7 Aug 2026 22:18:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r1t3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 22:18:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677MIbbt14090754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 22:18:37 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F10FF5805D;
	Fri,  7 Aug 2026 22:18:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F7658057;
	Fri,  7 Aug 2026 22:18:35 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.52.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 22:18:35 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v7 01/15] s390/vfio-ap: Provide function to get the number of queues assigned to mdev
Date: Fri,  7 Aug 2026 18:18:20 -0400
Message-ID: <20260807221834.562851-2-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a7659be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yQsB-kB7boqL7geEApIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX9p6ycuuHin59
 sT7jtqlP1XHNezi4gEjQuiHMIit8T9kBnWEVtN1v7Kf6srDD2w1NILaV9pM3VZAuQRofbPaSsDT
 25aG2K8iJuEKzfkk97N55vuKS9gkDwqExNiSMfFVyMAGakBg/DUtGZslE+3k6QCFmix90lsEFFj
 Wv1daW1iby+bISrhYsVw55TOJltGWi2wUgqnZRT0vlTA49vpx5E0SxVZpubehCJen+i9tjxW+bJ
 +8ac10XG55EgCbDJaRS3ccGsy3vrBBvCH845fS0oVwM8oBsDxhTw86PMfYIpM+XUqvyfVr3g1jQ
 AO2SXMD71L1VFWFr7lkv1pqQVaoKB0rJbrTSkbIqAmT1n8/yRzZY9pEaLpmBg0+sC1T/lVOEiC/
 PwlQODFmqf8W96RKHtTbC6VrRsHEkgFlCpkR9u/mmegTCFPXX0vG0TRs0ujthbEG5WdwfpGCECp
 8eXWRQ+W/MVzcPS8w8Q==
X-Proofpoint-ORIG-GUID: 2n3yK7JLKC0yXvJ8QbT46ZJjR8f-j8BW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE3NSBTYWx0ZWRfX7iKXtrS8d2dW
 Oo1VxWCaVul1vKG2VeuZ7sSGWZd7BrimVIPyqtqzyzBKKHZjph5QE24aMX2+5hVRUBAOzQSS9Vx
 U1Ck4AdsL2/n0LKQUM+Q0SmZMxgi7A8=
X-Proofpoint-GUID: 2n3yK7JLKC0yXvJ8QbT46ZJjR8f-j8BW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070175

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

