Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48174734E4;
	Thu, 27 Aug 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837104; cv=none; b=guW2Yr4iHVNEkFpruyo+Ji4UQyQK/4Co236vmjiu7SpKOIg2Dxi2w9diPiFa6H4u5TWsSQ8jR/O6k3AetcO45eHDhon0l0z1Rxbq6+FynitFFU1GBNr/ZbIaMa3t6CeKq1xVi5KAfVK9tZXjf206zIZTkI4PT16BP6yOS5UtJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837104; c=relaxed/simple;
	bh=O01+2gqAS84ei1KVU0D8zF+odY+EBxLRLRumpdd04hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wvq/cX2LreoFSgapyYSrSNW2qMYvzl5OYBtugb/4buoEfYzEKmpeTOA6jySPIRGUsJwIyjM8jskD/3058DU9H6LFwMmXAoc+Uy6a0aLQtEM49lgObK56W5rmkGDELKGoWjeyf2fnHUFccxD/wHGEXlhoO1+MaOLKmSJwh3ixaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anmFJgXc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anmFJgXc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVY0x1126117;
	Thu, 27 Aug 2026 13:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BR5toKeBHPBM+oAduvq8+gnNSshpkNt3pxm1vbU+/
	CQ=; b=anmFJgXc633bTzk8q+dhmjkOu33qxYGMpI2PUsrrZ2R1rMzJ4TXUeHltk
	UHJko7IkRFPS4pBu9Vx8cXcIa1hcLMfko+O8RmVDQmXaQrhQUGMHIxHVOwF8f831
	vMvGPVLlS0a9Ch4Nl7Grtlis03isqXhwfB31QIaUasyyyYczytrEIAyfDasrZYkC
	fi5qCY+97VkbKQSsgxxJNQTP7oKRD70rE6BwGokC6DZuKEBCe/W822NF9QnNXznH
	5cjymeTePTiPgXkGr3nKFEDkJjO1a8pFhgzS9hx5isLEcRVjptcshLfTPCfUwpV4
	PFV3OTOWNQ37KAHaLNqDxAa7wG/lw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er5hg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDBPJW025606;
	Thu, 27 Aug 2026 13:24:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qgg3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:24:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDOhev19268182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:24:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A679758061;
	Thu, 27 Aug 2026 13:24:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 798EA58062;
	Thu, 27 Aug 2026 13:24:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.15.38])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:24:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 0/4] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Thu, 27 Aug 2026 09:24:26 -0400
Message-ID: <20260827132441.555866-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BaA1elubFLIJmhkfPhus415DWPdDE5we
X-Proofpoint-ORIG-GUID: BaA1elubFLIJmhkfPhus415DWPdDE5we
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXxEkrXbCaeila
 p6gr73mOiZt4Asr3AQgLXYyez0LeTVCjl5hmrwNu9gQ7+k062VIQvSEIdvKtmSzwxgLttkVp3kB
 Mfsg+rgN84XizjaK1dwLQKPzuoC9fQdEgZSqGXzxtTzSjas/Xx2OIeOWhPaYK0GVqVGF7rmTdFR
 KVbi2/NStXRIdHS0pMVBJKPxcXoeDFseoi0GLiiMuJgf1U5laZPiJG2nP6QoNgtwRu+j7NSGgks
 WZ6Q9sW93rW6AE9Xa7TKeezAYUmZsbYJGY9TUUUu6mZIySnHYzXW8/OdHSeoeY+6EEnVebu9jfx
 9l6CtpBuguXJYOyz/EMT1lqUIRw1TWr/QRlEjTF4vaSHuoEA6aHW7hiZRm6jEZlbIjadyxdvs/b
 kGRezWU3hlV/CLgXGF9fE89o0D+jv5pVXHdflvJyQfseWAKrZrq3+E/g3KHWS2dEAG3yQn5bnh7
 FpG53wegBYtpYrD1tVA==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a903a9d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=oyab_VEMWqT20_fMoCEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX+Gy7xbfPFimy
 ItiTSvq3LwuZN7UpzUUf2Ld6CeyHU3WcV5VP4tio7sOnGP0BC2PF69hz3WkZQ91qPnBSBP+pQDS
 qJP2bMg/HQrbUPVIsLSwKB+TIsTRssU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Change log v2 => v3:
~~~~~~~~~~~~~~~~~~~
Patch 1/4: Fix leak of pinned NIB and registered NISC in \
           vfio_ap_irq_enable()
* Added fix for leak of pinned NIB and registered NISC in
  vfio_ap_irq_disable().
  ~ Changed subject line to include vfio_ap_irq_enable/disable()
* Add a bool return code from vfio_ap_wait_for_irqclear() to
  notify caller whether the IR bit in the status returned from 
  TAPQ is cleared. The caller will use this to determine whether
  the AQIC resources should be freed or not. Also:
  ~ Edited the doc block preceding the function to provide a clearer
    explanation about what the function does.
  ~ Edited the WARN_ON message to make it more understandable for someone
    that doesn't know architectural internals.
* Modified the response to the AP_RESPONSE_OTHERWISE_CHANGED case in the
  switch (status.response_code) block in vfop_ap_irq_enable(). This 
  response comes with CC=3 indicating the NIB and ISC were not accepted
  by hardware, so the AQIC resources are freed for this case.

Anthony Krowiak (4):
  s390/vfio-ap: Fix leak of pinned NIB and registered NISC in
    vfio_ap_irq_enable/disable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()

 drivers/s390/crypto/vfio_ap_ops.c | 148 +++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 25 deletions(-)

-- 
2.53.0

