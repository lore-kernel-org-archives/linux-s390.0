Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CB3F105E;
	Fri, 28 Aug 2026 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953625; cv=none; b=h0AX2ttk4obUPLQ//YHxv6ohFOF/dYZH6t34BNP8Rl3mAlXKOlI6Ct+lbFhaOfkSUJW4WEK73/gsNgF4tyA3cZSrPWeKOf7yzBn1fTvx4fGcL6BWpG6swF3FnlD3Qkev1t/6ooqllCx4FaG0nYoEtuHPQlva24xPE58CXQvXHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953625; c=relaxed/simple;
	bh=kwTMLWiIm+Hbl0ENs95oh9e5jmIUtJgwLRtpH6JNFkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbm9Z+aue6rRTnNrpVpzyFbWIViUFNQftKaCjyfOKEbYsCHXSOj8uKtECTh78+SRxQgG+74A8xSEoOCQbz6PFtFxrXxENXeTvcwNaojkGgDQJRrzw/75+MbjdfSUEwYLYWhg9RDx/LMx18YiucHCx5DLvfKAA3yCzG40SDKtnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iga9cpDw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iga9cpDw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SJVkwL3065582;
	Fri, 28 Aug 2026 21:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=E0QIJ0aI0cthTGglV2QUfFgCHOE88nMd5JTz+uGoM
	xo=; b=Iga9cpDwfycHG1mEEjuQAMg0f0Sr/IwrNio0OnzZDnC3uaGqISip8GKvj
	99HX4A7IhE5Rr6sqRA21r5JBfnJ9HA5aFsGddvNAT5P1W13n+OFnkLkI7zOdo8D2
	mw1a/NOJkbTxjjqesuieYE26ltbLAOYZxXHDBV+HKDMGy9eFBoq96LcX5h8qrojI
	u9TiykRxVZ6+uehwYwodanHe/dIAc56yxFzmOaUhm9UQJiDcTTjvE3YUKiLnsS67
	qN8d4p9x1hT3DmjLNhUIWfQo+GtdfL4tXxnutvRG85/QTDnBNCgWY8n3NEMvEGFB
	DgZb1PWuWKo3pRjn+Xgu6ZZGGAKjw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxxxjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:46:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SLfGbs004229;
	Fri, 28 Aug 2026 21:46:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwryj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 21:46:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SLkGMF30016182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 21:46:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61C5F58058;
	Fri, 28 Aug 2026 21:46:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A6FA5805B;
	Fri, 28 Aug 2026 21:46:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.33.14])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 21:46:54 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 0/4] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Fri, 28 Aug 2026 17:46:49 -0400
Message-ID: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX7Jpz+AvHyCgS
 gTX+Z1lEt5N0/o7wxrYeHl6yWIFa4Eb97MGWvoH8swVY4+f7uUfSCGJPlTucx3DOIFgICh15G8P
 yi0XMRdsz6kA7e+zO+sv1+LOdBS4qRA=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a9201d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=wQHx6xCcwkXnZ02BoLoA:9
X-Proofpoint-ORIG-GUID: EzSAQFFtAI2d65HIv4QpaSzYiPjGN9Ac
X-Proofpoint-GUID: EzSAQFFtAI2d65HIv4QpaSzYiPjGN9Ac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE4NyBTYWx0ZWRfX7NVEHZ/zJc+Q
 BSKKgJ66JhqJKCXDxu7U3WpZLwjs0d1H1z/2r0ab6jKr1SL+03UPUelw6/Yp4kZmdto1W3gwrWf
 bCOJVUjZri0iB4cO+BMC76dLxiFD8PmBB5AbmxT5ZdLSoCRZQ8A5oawirXz7xNh7Kw1+CNU6vL3
 iMSsNq8HFFvBxA5BwXzfe+xZTWZniR6yxw6ZPTIGhBn0K3DnRGAwUnGtDAhcrDQAAMaSwWh91LQ
 sE9kbuYA6qCHpe0XwwrWQnaUDKrY1yYH8tutpBQI5bJzucY0+URhfqHYcqyPMww47Sz+/waLMEN
 GM/4I45YHH2RkYkBUKVZ5URlboc4PqQKizUgzgDuzrO+qdQ+L24rwfgfATXds6sIsebaJIi6zsW
 YB2iIqDyDpV4WeLsA8wAwzux+Kpa6xiqIC1hDd5oohb9It2UHAGtmqJUZ52INDmv1AUX5Q6le/B
 WqzTpDeaJoHzdKoDRRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280187

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Change log v3 => v4:
~~~~~~~~~~~~~~~~~~~
Patch 1/4: Fix leak of pinned NIB and registered NISC in
           vfio_ap_irq_enable/disable()
* Overrode the response status in vfio_irq_disable() for the
  AP_RESPONSE_NORMAL case when vfio_ap_wait_for_irqclear() returns false.
* Changed name of vfio_ap_wait_for_irqclear() to
  vfio_ap_wait_for_irq_state() and added a parameter to specify
  the value (0 = disabled, 1 = enabled) to which the status.irq_enabled
  (I-bit) is to be compared.
* Added a call to vfio_ap_wait_for_irq_state() to vfio_ap_irq_enable()
  to verify that the I-bit is set when AP_RESPONSE_NORMAL is returned
  from the AQIC call before proceeding.

Patch 3/4: Fix unbounded loop in apq_reset_check()
* Check return code from apq_status_check() called from apq_reset_check().
  If it returns 0 when the AP_RESET_MAX_WAIT timeout is detected, then
  clean up AQIC resources.

Anthony Krowiak (4):
  s390/vfio-ap: Fix leak of pinned NIB and registered NISC in
    vfio_ap_irq_enable/disable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()

 drivers/s390/crypto/vfio_ap_ops.c | 216 +++++++++++++++++++++++++-----
 1 file changed, 186 insertions(+), 30 deletions(-)

-- 
2.53.0

