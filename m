Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CF4334DD;
	Mon, 24 Aug 2026 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579949; cv=none; b=Hd0KvSTrI3Y/4yEXJBJ57rcj1TV5LqX4Ln5fB2uuEV3n+wSdzCYUfGg1QGVfmVUCm5a8zljma8YXqtxdqBPqkL8Tg7/IrCn/lRXxd9p2DqwDsbuH+PZVFTGwglCgIZXBU1g3hAwVFc19OlkAelrqdZ/NQwPCveO36ZUz6igvgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579949; c=relaxed/simple;
	bh=GA58i5yZ7Fz6R/VnbhzSvSFWJgxbSv2V4tpNwTktvHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOJXI20aMgO+0CUXIoYl6GJA6p2UHVwlKQ3yqQjgbbKdR49wgGzYBveSR92YDkFKHO1hcnWOYRnJhYY+cr3glYL26PXjFMB9SevZbUe0QDtQQJ1+3bFeSQRpF9sr4g2P8N8NwhEd475Gj9N3YZBbkZo8gRVFFV3Dut/2oLnlpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rvqMp8hc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rvqMp8hc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1aZ41935920;
	Mon, 24 Aug 2026 13:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jNVl2s8E0X9TeiljZ
	VY6AVLigeFaTta/cQHrRX4/+XA=; b=rvqMp8hcr2CHjr+Wd4TBjS9KleffwsGjJ
	hFyaCRZTtt/5reLAKb6dC4/HMA1lHurQ6Yu4xfYRC8/Sm3ttClJW2G6dAHVAfHHJ
	DqcU8EIu72Fd1zS4G00O0/2t9Rep0XWLKoLEFXJA/rsYuXIqypI9u3pSXIYs8mSU
	SjL1PLCTD9OVto43aGK9Z6TofS4WqVu+bCbxc3z9GxzPSvzupG1bJkEHLYV+Nlgj
	gvAe+yTbACx2nr0wi8xVxYuJSbNHJCbjFiU85Bew14xJeIoU+iHMp3Qhvk1zZlKH
	nAxDWRsgOgGfekLXIFN1kblYwrHBYKYHshq7kngNjwtgYlErvnR8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393srk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODuMZr016699;
	Mon, 24 Aug 2026 13:58:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3pxehb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:58:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ODwtsg40435978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:58:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2016D58054;
	Mon, 24 Aug 2026 13:58:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52ADF5803F;
	Mon, 24 Aug 2026 13:58:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:58:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered NISC in vfio_ap_irq_enable()
Date: Mon, 24 Aug 2026 09:58:47 -0400
Message-ID: <20260824135850.503728-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824135850.503728-1-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TzT7Hpaed7qz90igUyVS798thvl0GHCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX/ElyCbbiHjfh
 E4tryVrSAjANoJWETnzpPMGHRcpW+ec8RvOMdfZoQYGs8PaHfF4ZRaEkglrPCrxz5N5piJxZS1O
 zRU7FtJBHQvvQRRwZD+KU7Rc/xT0A6pB9XwRetily3IrwhdksaoFLNcv3++aqyPZ021wRr8Nt1W
 KFyC8VZRiT97y0ecjtfxecMejTFtp4BNDO9ISkAVLRbNC0ncZccGvEIj4jfC42GkPjxWTNwr5R5
 knaBUWjg+67kgIVMAGaM5Al+FiBdWnVnKL4MTEac7cQgR3QxxWqKYh0ku3I50ItR3iLvVrl2lLq
 dzpoih2J2icMIGoq1S4Y/6vEn0EQURuAxIPDYMk+6CVvkhylI80yRAm6t9j9ldsjqHEuu0LvwyL
 l0Z6fc/nodyRxWumydljxibDgbGAydKkCswhiH+b+K3VdixhTtg3jrYBO5yvIDabsi9Ps81AyfE
 2KvH9hMsg3rb+C9qr8Q==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c4e21 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hmEx05nRRPonxVd58HoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfXy0pBSlw6vO5Z
 t0ZTmTkQ92+9Tqwtjw/N5is8z5yLjm3AxxTKynMrbh63Hc0Dc1SH0kfKDEcTnZ+cE+HViMb3AMA
 Om4NOtGa9CfW+Yu1PsxzNs/+mGzqWKs=
X-Proofpoint-ORIG-GUID: TzT7Hpaed7qz90igUyVS798thvl0GHCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114

The vfio_ap_irq_enable() function executes the PQAP(AQIC) instruction to
enable interrupts for an AP queue. A switch statement is used to examine
the status response code returned from the instruction to determine
whether it succeeded or failed and react accordingly. For the default case,
the vfio_ap_irq_disable function is invoked to disable interrupts for the
queue and clean up the AQIC resources (i.e., unpin the NIB and unregister
the NISC). There are a number of problems with this:

1. Neither the q->saved_iova nor q->saved_isc has been set, so the
   AQIC resources - assuming those values have been previously set - will
   be the NIB and NISC resources from a prior call; the NIB and NISC from
   the current call are therefore leaked.

2. Interrupts may never have been enabled. Sending a disable instruction to
   a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
   DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
   a further WARN_ONCE from inside vfio_ap_irq_disable's own default.

3. The hardware just rejected the new ap_aqic() enable attempt with an
   unexpected status. Disabling a previously-working IRQ config - assuming
   that is even possible - as a reaction to a failed enable attempt does
   not make sense; it is actively destructive, tearing down something that
   was working for no valid reason.

The fix is to unregister the NISC and an unpin the NIB in the default case
of the switch statement.

Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 940c0ff668be..a46bf381ab72 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	default:
-		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
-			status.response_code);
-		vfio_ap_irq_disable(q);
+		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n",
+			__func__, status.response_code, q->apqn);
+		/* We could not modify IRQ settings: clear new configuration */
+		ret = kvm_s390_gisc_unregister(kvm, isc);
+		if (ret)
+			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
+					 __func__, ret, isc, q->apqn);
+		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
 		break;
 	}
 
-- 
2.53.0

