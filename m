Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94936B910;
	Wed, 12 Aug 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564973; cv=none; b=lA/OlPTtCRswEoBDwVaoJw/s4cd8bfsCP9sGB51c37gvHPHOoD2izudKETif8a4CGRzOPaFKOH3NPzQo06ob2ODNtFU7SVezidVENGGecyD6FnM5VhOVurmUGcgHSTSR5WN/I7Sa5ovKJMalM3owCrM/Ayqt0r+1OySyUTkRiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564973; c=relaxed/simple;
	bh=BnIh73F2OoFoFSzUMa3+RGSwKRFvellnJ8tbCxSm060=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TCSUacESg1WDkrJjs5i7/LZeHHmcHClHwoW8thAZgw8IlNQ44MEvITqt1n+ofNfkVn9XQvhNuskwGl0CeK03DB6pWEOlXNBzYt2rhnHuC2wc7wiY2uDixgZLiNPgPYHoFhHv/RMRwHfWCrEfsga1ddxXHJ/JIjlWFgVazVil0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xqs9muBW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xqs9muBW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1aWP4120367;
	Wed, 12 Aug 2026 20:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=o5NAow4DUBCi54+OKwUC5zhlj99+
	tuH8lrlSlPsHEX8=; b=Xqs9muBWEm2rkwGNaPv+Nn0Q9BJxv7PfiyAHOFsialBY
	9hx4VVZHAHZEQZGHkaEpRJM86ZbghBAiED1MDpGujcSJGEKQIsORM8W4H3aWncx5
	dxMVtIzDRDXSEDA9ay6X1IMDbvIF3HKAGepNmrZZ+pjWPSYtaatYaUAiCDCzwTxF
	XvQTWU6ZCis0vUxGvE0Bo74yQm4GKDk7XjlfMNNFxsUkXkZdHFkJCTpm669O/s2+
	KrGCFx71vRSWdLySwCkrofZoiTummwh2kCnij2u0Q90BGKaAvJKy33sTpaC1xW6q
	Ph8ftHw8TYNxeUMfbLgH9/GDFaiPvhYz9CzEE9K5Qw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbk5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CJuF0V030839;
	Wed, 12 Aug 2026 20:02:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7y4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:02:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CK2hGN66716150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:02:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E734158050;
	Wed, 12 Aug 2026 20:02:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F40C58052;
	Wed, 12 Aug 2026 20:02:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:02:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v5 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver callback functions
Date: Wed, 12 Aug 2026 16:02:31 -0400
Message-ID: <20260812200240.818004-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cd164 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=gxQObmdM_ZwBCBthh6sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WW5bMFU_roVaW8pi62QV0XmEgeRrE3_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE1NiBTYWx0ZWRfX/sDWM22783DW
 Yhoj5j/tSVtSp5JdvFSrUWoz8EaEyoKv7Z43a8wLgYr7v3Jqf04oz4rgPrjKYAjrWqRa4RqaQs9
 o84ucssChLk8l22KOSLaOvHZ/Igi1fnmWJEjdL52XGmc8d1nbUIl7Loq/nC5FbmssO4Xq4VDbML
 BH9nyvkxwe005JNToSx1SOUt5evOKW41Nh0WQAhyEiz1FXyb0PHZC9gApiJ2/xhSnCk0yZdnnbk
 1jVw1c9+nQBjCQLVPD3lhGeUL3pYhsfRNlN7EM+V05k47zZ71ZuZhtcgl88JZtBVbe0dSNcXzST
 L1in9c8wLPWQYg+TMKxfdMLJGfitdbJ+nMW0COLLWLi//40NBL4X1o+MZ5GXnP+W50ehz739Rnq
 meW5Eu09q8aT+7oG0nLrRuz2Q5GE3HaTyy7tYyrQCekzVyDsU1oOgmrQ7s92shuAmCYyN/kl/5A
 P/4HZJYIdMBFLkGHOEg==
X-Proofpoint-ORIG-GUID: WW5bMFU_roVaW8pi62QV0XmEgeRrE3_o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE1NiBTYWx0ZWRfX8ycvdMomv0mZ
 wvDHybRIDuIByjJzp4njb8W6aSzJ1254OTeCJBA383SwLfA56xifHaNlTLim3IadNQQhKmUP4dL
 T/JtnZZInkleXcr7lT7TOAoxiSY0Z8Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120156

During review of patches by the Sashiko AI, several pre-existing bugs were
discovered. This 9-patch series fixes those bugs.

Change log v4 => v5:
~~~~~~~~~~~~~~~~~~~
Patch 8/9: Fix NULL deref in status_show() during queue probe
* Check if q = dev_get_drvdata(&apdev->device) actually returns a pointer
  to a vfio_ap_queue object. If not, the return AP_QUEUE_UNASSIGNED

Anthony Krowiak (9):
  s390/vfio-ap: Fix stale do_remove flag across iterations in
    vfio_ap_mdev_cfg_remove
  s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
    NULL
  s390/vfio-ap: Fix missing lock required to access list of
    ap_matrix_mdev objects
  s390/vfio-ap: Fix required lock not held during update of
    ap_matrix_mdev object
  s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
  s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
  s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
    removed
  s390/vfio-ap: Fix NULL deref in status_show() during queue probe
  s390/vfio-ap: Fix memory leak when queue removed from host AP config

 drivers/s390/crypto/vfio_ap_ops.c | 163 +++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 37 deletions(-)

-- 
2.53.0

