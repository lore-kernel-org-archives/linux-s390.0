Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD193DDDCD;
	Fri,  4 Sep 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514486; cv=none; b=FGbH5tcsrx1LOct3tGBTfCLBhPvT0QEV2EPj8bIrGuJWKEiP/pYV8jzeOPmobwoWZgUiAtgYqUqUUYix0jc4XCHnz8Un212sNHAbPIw9hUTxhji63Oc2VT/3tucC+x5UXF86kW4EMfSm7jKzK4KLO2966NQeejKIqdXbRCc7yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514486; c=relaxed/simple;
	bh=gh3EtD6pYGtZ4g/rfgM6jtDrdAKAgAO04ubjSm5YTpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvYXHmCOA4KP/QsuE96JCYmRGwAu9Cfw8sx/nMrtkGZniSlzHgXMO4f5x3l7rGnfFUmpBqTI4Kai8xHYf1fXjRpdxBhFDBjVoKjibwfWVrCHLD7HigJfJULILgmPTb8B7dX+Fbw/ii5fj7dK/YbheJQpqtC+cb5IkxjysT6ZBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tLqCP2KG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tLqCP2KG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Vw73993615;
	Fri, 4 Sep 2026 09:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5aQnF2j30gj/aJWPtgwIZ8ONJRvCWDR8rCAdV3abF
	nc=; b=tLqCP2KG6ExX42uWZIhOq9vsOn22JIkiAR4wTSMKJQzZreTiQC/V2O/xi
	O4cLw3bXF0ccILPI8bkAp49G/eou3L7DWB0T1Bl8BcdbkFJY3bQimaMXAAqdyfn2
	JFBLOVu5CsP0dS7PjY+rDvoqStf5K+CLLiBBZbFQ+pwWqHDN9TI5PfDvcZc66Ulm
	DmBll3umxufCJaJA8VANf0rSdinIxxMm84Ss9Qe94m465Vycyvb6Td5ZFQlS8n0Z
	Qh0pwn8y7AwfZOad1kAtkwo36+GkjYpHIST4v9iZchvNdPGsabVWI+M0ueD4tpBG
	GY26OSABWCL4ZUPk4Rio+UKeNHYjw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue9dwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849QQf7005572;
	Fri, 4 Sep 2026 09:34:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hv7eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:34:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849Yb2i57278820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:34:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E88D5805E;
	Fri,  4 Sep 2026 09:34:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AEF858063;
	Fri,  4 Sep 2026 09:34:36 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.80.215])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 09:34:36 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 0/5] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Fri,  4 Sep 2026 05:30:49 -0400
Message-ID: <20260904093435.1161402-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: os8HOgTEJ-pxyhxpqjvtQYxk_tfWiEdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX/mwpOfdEALcu
 DH8iOzIVSdLNtbM5KH30R9mJUgtykbuv63ka9PToG+mWhiKzYLVlxrE4WMc5Ow9kKePxLd1brer
 H+VaN5PMaknGIlV8gPPxq3hpHVmiEyp/7GLcTPSjIhRKN1U8HWXX2mG+End4RKyUXdQtSC69r9b
 xjKs82i1ZntXJR7rWSR2lFLA56JEZJR8QFJoLGOWjmZCbbv2Rs+rO/PC1JewU9G4FtkGS2MSsMf
 Srr9iMESvZd7SmK+zEwD82SCodb9WD7VPZ0bAAr05G3Xx6/DgGyIujwZ8vzYlQcYs6n/vNOKGKz
 dHey8D3qE0n3xNEeaFNONrc/UvHg1JZX8M8RraJd01TLqPOBWHzwkn4NKhFGJ9KZAke3YdxNZv1
 DwoPHNo3+b+0BrbHwTLqWkGQKpKB33nczDjS1jMHR7wke9vMdsgAm3HB4YYUW6OUSugAwm8mexZ
 x+xy2y/qBiY/4VVVq9Q==
X-Proofpoint-ORIG-GUID: os8HOgTEJ-pxyhxpqjvtQYxk_tfWiEdp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX/KrprrVvIsn4
 3opwbWP3Tf7ExL+EAV+Qc+p/6+6+ORdT0z5esuPDnRkWtR4UaujC1sqLAkSyfbPM5ZIMhqnuUo6
 j4v+9GwmGGJrARq+srzQ8r5qgMK1YL8=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a90af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=G01SfWaDaZ_euUNNutgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040086

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

Patch 1/4: Fix leak of pinned NIB and registered NISC in 
           vfio_ap_irq_enable/disable()
* Added return codes to vfio_ap_wait_for_irqclear()
  ~ Returns 0 for response codes AP_RESPONSE_NORMAL and 
    AP_RESPONSE_RESET_IN_PROGRESS if the irq_enabled bit is set to 0
    confirming the queue is disabled for interrupts.
  ~ Returns -ENODEV for response code Q_NOT_AVAIL, DECONFIGURED and
    CHECKSTOPPED to indicate the queue is not accessible
  ~ Returns -ETIMEDOUT if the number of retries is exceeded.
  
* Changes to vfio_ap_irq_enable():
  ~ Removed call to vfio_ap_wait_for_irqstate() because the responsibility
    to wait belongs with the guest that initiated the AQIC.
  ~ All AQIC response codes other than AP_RESPONSE_NORMAL indicate the AQIC
    enable call was rejected by the hardware; so, the AQIC
    resources passed as parameters to the AQIC will be freed; i.e., the
    page containing the NIB will be unpinned and the GISC unregistered.
    
* Changes to vfio_ap_irq_disable():
  ~ The AP_RESPONSE_NORMAL switch case added check for return code from 
    vfio_ap_wait_for_irqclear() rather than just freeing AQIC resources. 
    They are now freed only if the return code is 0 or -ENODEV.
     

Patch 3/4: Fix unbounded loop in apq_reset_check()
* Added a done: goto label at the end of apq_reset_check() that frees AQIC
  resources and can be used in all places that free them.
* Added the following return codes to apq_status_check():
  ~ Return -ENODEV for response codes AP_RESPONSE_DECONFIGURED and
    AP_RESPONSE_CHECKSTOPPED. It indicates that the queue is not
    operational; however also tells us zeroization can not be confirmed.
  ~ Return -EAGAIN for response code AP_RESPONSE_BUSY because it is
    unrelated to reset processing and indicates the ZAPQ should be
    executed again. 
* Made changes to the AP_RESET_MAX_WAIT block:
  ~ Now goto done if the return code from apq_status_check() is 0
    or -ENODEV which indicates the queue is not operational, so it is safe
    to free AQIC resources
  ~ Calls a new function, report_aqic_resource_leak() that logs an 
    appropriate error message if reset timed out.
  ~ Sets q->reset_status.response_code to indicate the reset could not
    complete in the case where the response code returned from ZAPQ is
    AP_RESPONSE_NORMAL but the status bits confirming the reset completed
    could not be verified.
* In the -EBUSY code block, replaced the freeing of the AQIC resources
  with goto done;
    
  
Added a patch 5, s390/vfio-ap: fix queue state leakage to guest and host.
* Patch 4/5 opens a hole fixing the unbounded loop in apq_reset_check
  created by commit dd174833e44e ("s390/vfio-ap: remove upper limit on wait
  for queue reset to complete"). That commit was created "ensure both the
  security requirements and prevent resource leakage and corruption in the
  hypervisor. This patch limits the side effects of an unbounded loop, yet
  accomplishes the goals of that commit.

Anthony Krowiak (5):
  s390/vfio-ap: Fix leak of pinned NIB and registered GISC in
    vfio_ap_irq_enable/disable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()
  s390/vfio-ap: fix queue state leakage to guest and host

 drivers/s390/crypto/vfio_ap_ops.c     | 373 +++++++++++++++++++++-----
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 2 files changed, 305 insertions(+), 71 deletions(-)

-- 
2.53.0

