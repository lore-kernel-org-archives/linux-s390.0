Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A3390CAE;
	Wed, 12 Aug 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564988; cv=none; b=h7o6dYRMDwD7mrkEJsyeMolEyODNvdvb9H/nYd0yRakygYAFomxZmMGSalBJoUHSKvQpYwUPa9IEUIvLK83CjeUjj2ikpqMbZ3M3T+HEPEvGLOzZBYJs/WE1/32rC+RdfRbtLprqXixnB6PlBxVvPlQGQgchBNuwsrQgdSJnuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564988; c=relaxed/simple;
	bh=X//UKBUUpUskOIAgBTfpfSW+M6VENerl0FCCuO1HkbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT9fuQSVWP3znSZT1YjKD9jlEc+Mui9RvKbb+P8my65iFj/LEk3vseKW6vvqR+8QX9zYWDGjICOKehSlabo0pw5QaEFSX0U1uRyYHsjUqnnSjAKooP0KyO4XpLWadCr6rtDpMZWJfX74tqzWEXknniFAoB6eDke6u1pBZTM+H/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGWb9cpo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGWb9cpo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2oEJ197050;
	Wed, 12 Aug 2026 20:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PnxY9uMnf06L5hMnn
	ymhC8gDi9LXvoWYazDhqSh9U3o=; b=pGWb9cpoPfzMXeFZlptZs16+WRwOywVGJ
	L+PgUGrDYiBMjacud66sUMPDALJ2/iDxUJ6aOQ6TVRLOwRyCDyqVtIYeoBwaCJcq
	mpsrBjqEOOx6tPHh9USyS8gNW8nFByXCTfXdErr1Uv2A4QHbTvX4t18+ZvxD4zNJ
	hIJEw9kcqEWXpqfSGKI4MM8/RVy4uJqx7PCE5/tq4vIa1snHdX9XXmSWR5CEOivt
	yXPdDyrzUraILLYjOmAc2loPvzsfbEo1UNmJhRH/Zx7YNDKmi3aDjD2ivxXuUmoh
	tTT8CiYzb1fO63tBIQD9Tl6HsVpsZGFUbu0nrmo1jInMUVJQfJyIw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp33kjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:03:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuHqY030878;
	Wed, 12 Aug 2026 20:03:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7y6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:03:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2xO858589524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F20CE58052;
	Wed, 12 Aug 2026 20:02:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6514858056;
	Wed, 12 Aug 2026 20:02:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed from host AP config
Date: Wed, 12 Aug 2026 16:02:40 -0400
Message-ID: <20260812200240.818004-10-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812200240.818004-1-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cd175 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VrB3zfVs-A4ss5GmTxoA:9
X-Proofpoint-GUID: GNSZ5PH5L9wWryeOC0YZU0f1iHgiRjS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX4Gq5/oA5g4qD
 wccyI6cCng8MIHbF11yZ+JNp/F6gvsGCKT/mA/8UI9etibM031Q+cc4KrzUn/nJ1G+KNDOPdGdV
 rbIZ49+Cb15B838iATU+W9goj7gd8oic/EI4T0bpG/hg+LU/cSQzGiygokSnNdKvNSOFp2ysMGL
 aLdS1vn1WTAMxneQpOxxf6qG2v4GnsS5adHxLug9Ap++A3e/PAoUZ4uc6fhhUNayjZYtjvzOCAG
 kmnThbpYyfzlvQ9KZguUwbX6Lm1Q4Ekce9+SOiDFp3dX+Da+3mx2znMBViWpw716r+mafPw8t/h
 7ISRnSTZ1R4qfQwuxxmJsPH46baZJhsyLjUazfyL3eahzXWP6N4zoVLOlB2dlHHsXameNLMa89W
 uywB2f6VRE1Dkrst9iQA/b+zEKGn1Mg4IzFj2TDAYex2RNW026bvH1PXlRbu2OkaYWRKHk7FiE0
 FyzeBuHJuPgao5wWAtA==
X-Proofpoint-ORIG-GUID: GNSZ5PH5L9wWryeOC0YZU0f1iHgiRjS1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2MSBTYWx0ZWRfX1dUTnYbXAXld
 PwwgNL9GXzo6DH4G9dQXAMv9/1Uz8aAdgwilv/TBNDZhhFT/eIQsoxB0w2V/S8+m0mRhcrRhfGy
 zOKj3vh3gVn8Bv/q0gToOgHQc5tM3QY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120161

When an adapter or domain is removed from the host's AP configuration, the
AP bus invokes vfio_ap_on_cfg_changed() to notify the vfio_ap device
driver. For each ap_matrix_mdev object to which the adapter or domain
is assigned, vfio_ap_mdev_hot_unplug_cfg() is called and removes the
adapter or domain from the matrix_mdev->shadow_apcb (i.e., the guest's AP
configuration) and hot unplugs it if a guest is using it. The new host
AP configuration (sans adapter or domain) is then stored in
matrix_dev->info.

When the AP bus subsequently unbinds the physical queue devices associated
with the adapter or domain that has been removed, it invokes
vfio_ap_mdev_remove_queue() for each queue removed. At this point, the
adapter or domain will no longer be assigned to the
matrix_mdev->shadow_apcb or the matrix_dev->info object because they would
have been removed by vfio_ap_on_cfg_changed(). Consequently,
vfio_ap_mdev_reset_queue(q) is bypassed and kfree(q) is called
without executing vfio_ap_free_aqic_resources(). This indefinitely pins
guest memory (q->saved_iova) and leaks KVM GISC resources (q->saved_isc).

Note that resetting the queue would fail with an invalid APQN error due to
the fact the queue is not longer in the host's AP configuration; however,
it is still necessary to free the AQIC resources. The fix here is to call
vfio_ap_free_aqic_resources if the adapter or domain is neither in
matrix_mdev->shadow_apcb or matrix_dev->info.

Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1edd0b7a3cce..bd9d239caeba 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2533,12 +2533,15 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	/*
 	 * If the queue is not in the host's AP configuration, then resetting
 	 * it will fail with response code 01, (APQN not valid); so, let's make
-	 * sure it is in the host's config.
+	 * sure it is in the host's config. If it is not, then free the KVM GISC
+	 * resources.
 	 */
 	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
 	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
 		vfio_ap_mdev_reset_queue(q);
 		flush_work(&q->reset_work);
+	} else {
+		vfio_ap_free_aqic_resources(q);
 	}
 
 done:
-- 
2.53.0

