Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CA44C64B;
	Wed, 12 Aug 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554597; cv=none; b=nlJ7hgmSRXjWHPP3jwyq+/SEEktUJFVqA9vHghYWxneEzJR1+4s8ZD7E2jer1FrDKi/Cmy7dOYgKniB7sn7nC3fPuP/7rHcJUttBipzOi/IEBx0dLDlfImLuWPrCRp0TnM5ZILedV7++jAWcVYNq0BqdQNMxDcX5p8Ik+fWx0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554597; c=relaxed/simple;
	bh=vt/d2zGxrF0ngjjzHpi9fY7q7B4z4ZiT17Hr8ZNajzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppCMq+vh20Zq9sZbvPcWn3fDcJXIxAos8wxK9DsEqci7b6C2FiZXhY4hhxWEKqryW7ZuLlZI/9lCl/MTMOnSu1MJMZfQZsKk5DPUh9zMM7yjNYBpPyB+SAQZldnJoP6q0sSEZoBML1fwvgAk5bnvLKFsoIBKlNT9j863eQ5AIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lNEwCYyL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lNEwCYyL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1aCl4120367;
	Wed, 12 Aug 2026 17:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=98L42Et11dhMp9Vk9l3PehmRbZaM
	sOFVImCzaMHzg/Y=; b=lNEwCYyLN16Lc2vNhYsDoa8ixRpWDxxfaF+3sPt8r1b/
	7hKcWXxRgF/DCvoi+59XI9q32U9tVCpo66mBink1byzkSLbbATf+6oG9WwMhx4Ea
	0nq7mvmkOzErhm5tEmBG1GVaITuR74vWEX5OhER/tvgG3GqFUmRevNPtaMc+IeX7
	we6I8cvlqCOIOxrIy1Bf36us7Xlbg01SsJxhqNyOBPMYDvoPJYH9bAPo+05Zoui+
	OLP83A36N+j628OtC/P44Cpg+u7D8FhoaiIGBdMrA9vER/tFsctNDKguxe/5vmsw
	d8AHIzqjgPAexrlrdkk3odEQ4yVZeN02BobOFX5F0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwauaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGun9s006415;
	Wed, 12 Aug 2026 17:09:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6w0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 17:09:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CH9ljH27656746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 17:09:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EFD358043;
	Wed, 12 Aug 2026 17:09:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6179058055;
	Wed, 12 Aug 2026 17:09:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.9.29])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 17:09:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 0/9] s390/vfio-ap: Fix bugs in vfio_ap device driver callback functions
Date: Wed, 12 Aug 2026 13:09:36 -0400
Message-ID: <20260812170945.738351-1-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ca8dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=DKk2rkjsOlNOu_rQTFEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IJ0m8yTPwJX6wKB0eWw6lne0uNlBWUX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXwnzXiri+Ojgg
 3mSaasJXnXOMa9R3QAd613oE+uIjYslW9lVbW8b3BwbYfagQxu41HwmF1oSQjzfpC41geY8oxPd
 QgGm151dMZzOPaRyVDZhYswozHy9WPdioUtoU9kvBar0d6mR9Z4htnuu0LveSyZBWjBfLzeCu5W
 1GDMn9bxb5TCb9nZVxqen4Y9izM33pcgfwKMEqqHBaicPUKXLx84qfmmWGctE9nZSf5h+Xpl87h
 JztgVblFha8SvRbAJmvC69ErJSwaMhjA8k1M3tDhYwtiOjiJnck2ka2LnyDKkSS2kYqgRjEayKl
 rCBF1ZPT9ygnq8H5zCb2mFYpHItXYuAj8S25FMewjL0Vbf2uVa4fTq02HYQtfcHMkBTNeV8Abi4
 59sqaSIVkfbWyGI2C2OfQ1y+MXsaWCafx/MAehFRecrjCBeml/y4IXdkLuw+Qj8oCPRbWuztcfP
 zuy6vY32EkvCLlBKltA==
X-Proofpoint-ORIG-GUID: IJ0m8yTPwJX6wKB0eWw6lne0uNlBWUX1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX0OqWT1Ngmgwj
 KCwIBgHTg6VcaKu/YDza6tH8xbEU8hiuV/A6ZypVSxEVTuhuEybdcNRLo/tHpjd9BaDvLnX+ebm
 nTefhSkI82fYD2AA4aCLWJpR0IS41ZU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138

During review of patches by the Sashiko AI, several pre-existing bugs were
discovered. This 9-patch series fixes those bugs.

Patch 2: Fix dereference matrix_mdev->kvm without checking for NULL
* Added block comment prior to traversing the matix_dev->mdev_list to 
  explain that it is safe to traverse the list because the 
  matrix_dev->guests_lock is taken in vfio_ap_on_cfg_changed() which is
  called prior to calling vfio_ap_mdev_cfg_remove to hopefully circumvent
  repeated LLM review comments that the list can change while traversing
  it.
* Added block comment prior to adding a matrix_mdev to the
  matrix_dev->mdev_list in vfio_ap_mdev_probe() to hopefully circumvent
  repeated LLM review comments that the list can change while traversing
  it.
  
Patch 3: Fix missing lock required to access list of ap_matrix_mdev objects
* Removed setting of matrix_mdev->req_trigger and 
  matrix_mdev->cfg_chg_trigger to NULL because matrix_mdev is kzalloc's and
  to avoid setting them to NULL after exposing the device to
  userspace via the prior call to vfio_register_emulated_iommu_dev(). 
  
Patch 6: Fix potential use of uninitialized apm_filtered bitmap
* Added block comment prior to zeroizing apm_filtered bitmap to explain why
  and hopefully prevent LLM review comments about it being uninitialized.

Patch 8: Fix NULL deref in status_show() during queue probe
* Added call to release_update_locks_for_mdev() prior to calling
  sysfs_remove_group() to fix an ABBA deadlock on the error path.


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

 drivers/s390/crypto/vfio_ap_ops.c | 145 ++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 37 deletions(-)

-- 
2.53.0

