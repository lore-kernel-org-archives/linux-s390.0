Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0943F4BF;
	Mon, 10 Aug 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389794; cv=none; b=FOKaiUYs4VDlrDke6MMgthEAU9FHqEcJumFfMH/r1xndxtO01erOkBxI737Ih4ItdSIGOdDRJXK780PqKi6yRx6e/mwP2TOTR3dba2iHfcrnncVtlaGQHkdrrIPE2k7rhjF5JvVMOMioe9BQ7Kifc29QXSCtySr/R3enUhQ5G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389794; c=relaxed/simple;
	bh=kDSSBAYu5KEI5VJmEGyLUerVvrWJTSVUJi143tSMic4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkint5pnHfylTLMcMNAnXIKet9QW3qBpqIHf6igORQjQ7aVavGcNb1Wmnk0jlN6P/rHsEGZUes+OHNblmv3r/rMGpuV6lRSV1+IXioNGENoMBbohtRdaBUzvAkkr3nBabOa3RwcnG9hlGuvDKNEABMP08GNonpX3HzPkhGeywcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYeWoV1j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYeWoV1j"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2GoG2513316;
	Mon, 10 Aug 2026 19:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OQsO88xfGMNd4ZjNZe6GR5mWXb3Z1j11NHYC3OCoH
	lo=; b=dYeWoV1jR+KdwSdyacAjkJATicTEGrwftO6wXP9ldPuS7tmuv3+DbOvzc
	ehbnYj8FWRLV6XuQSMIvgU6SDZFC56+n32ZYY2GDSyAr0DAQ/GKSiLC5+AlZdzDU
	PFJ2NEQCLlzNfheg3kd29eG7K6AEPTK3CioLhSyijsdd8Ts+1vSeA0a+R6V5ZudI
	07rJolAMOFGVx0Jx032qDGmkXEjyiUBGIxoa8wEbZVqDjYsR5UZrGiWo98a1fCib
	M5NDqc4Prw0C6BCwD5m6MVmM+30eHQR+XR8ID91HfsR7nysb043HBtUuzfXOBm67
	kXa822annAhpj6U64364p/EZHAXUw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw18cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJBoEL005939;
	Mon, 10 Aug 2026 19:23:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gx2k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:23:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJMxim25363006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:22:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC20858062;
	Mon, 10 Aug 2026 19:22:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA36558057;
	Mon, 10 Aug 2026 19:22:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.71.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:22:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 0/8] s390/vfio-ap: Fix bugs in vfio_ap device driver callback functions
Date: Mon, 10 Aug 2026 15:22:49 -0400
Message-ID: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7a2514 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=XlMgntXxoZGTRFLZ7GoA:9
X-Proofpoint-GUID: q_3PGTNblfvW02IbN4lAs69mp_svKwV_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXyI8eX13FCvnG
 F6x03IkxSay3ORVQlGAWSZDgg4FaHCxC3snLM6K7ZJ96xep++8u0Iy6NtoHAImBMvpzuZPvGlcG
 fxWdB/X0MR3d9eU40OPT8miPBbXkfWTfVS8g3IEHys8gOg10grqkOmooukRHz+KvOo6qk93osp5
 HWtFjPZ4zgZxDOQA2v17TgGD86qyKX5ktkZDcdjXPSSPPMz8Ij3XnFN7key16dtp+QLyGZPBk9I
 cVnZ7/F2BmGYg7ohzQqT1IvUvrS53YUJ9BBH94hccnOKSSylFtqzABd0V0uw0Q+Ju9yjMvdpziF
 NgwdLs1w3zrOFGp63ekRkskot76/ZAOUVcQtHaZKyydW+EVWwlOAsIUWxgoUVMLLq+neoEuIq/d
 xw+PXmqQU3hk9PA8rcpRWBiNhxfXi28q5cNIzyU84jVGcY/QDH8xAwRug4LSwo4RL+52RdWxof8
 l5PEBZVX3I6tadFYH2w==
X-Proofpoint-ORIG-GUID: q_3PGTNblfvW02IbN4lAs69mp_svKwV_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX4tRiU0pdGo60
 NQndDDUW985SkRwp1daWa0MsfihMr2EsgCZA6xHoWnF5UOf+QnawhF9gvbQ4+FCwcNCr22OrEDo
 RbG0QefYFJ3wVXVnt3b3Kk/7KFKKM70=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100162

Patches 2/5 and 5/5 in this series were previously posted as individual
fixes upstream. During review of those patches, the reviewer identified
several pre-existing problems in the same code paths that are addressed
by the remaining three patches. All five patches are fixes for
pre-existing bugs and are tagged for stable.

Patches 1/5, 3/5 and 4/5 fix bugs in the call trees of the two
callback functions implemented by the vfio_ap device
driver -- vfio_ap_on_cfg_changed and vfio_ap_on_scan_complete:

* Patch 1/5 fixes a stale do_remove flag in vfio_ap_mdev_cfg_remove
  that causes spurious hot-unplug operations on mdevs that have no
  assigned adapters, domains or control domains in common with those
  removed from the host AP configuration.

* Patch 3/5 fixes the use of the wrong lock to protect the addition of
  a newly created ap_matrix_mdev object to the mdev_list in the
  vfio_ap_mdev_probe function.

* Patch 4/5 fixes the missing mdevs_lock while updating the apm_add,
  aqm_add and adm_add fields of an ap_matrix_mdev object in
  vfio_ap_mdev_cfg_add.

Patches 6-8 fix additional pre-existing bugs and were added as 
responses to reviews of v1 of this patch series. The change log below
identifies the patch reviewed and the resulting change:

Change log v1 => v2:
~~~~~~~~~~~~~~~~~~~
Patch 2/5: Fix dereference matrix_mdev->kvm without checking for NULL
* Added new patch to fix the potential use of an uninitialized apm_filtered
  object passed to rest_queues_for_apids called from the 
  vfio_ap_mdev_hot_plug_cfg function. This is a pre-existing condition
  discovered during patch review of 2/5 for v1 of the series.

Patch 3/5: Fix use of wrong lock in mdev probe function
* Added new patch to guard the traversal of the matrix_dev->mdev_list in
  the vfio_ap_mdev_for_queue function called from the status_show funciton.
  This is a pre-existing condition discovered during review of patch 3/5
  for v1 of the series.

Patch 5/5: Fix control domain removal in vfio_ap_mdev_cfg_remove
* Added new patch to fix skipping of hot-unplug in 
  vfio_ap_mdev_hot_unplug_cfg function when the last adpater or domain is
  removed from the host's AP configuration. This is a pre-existing 
  condition discovered during review of patch 5/5 for v1 of the series.



Anthony Krowiak (8):
  s390/vfio-ap: Fix stale do_remove flag across iterations in
    vfio_ap_mdev_cfg_remove
  s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
    NULL
  s390/vfio-ap: Fix use of wrong lock in mdev probe function
  s390/vfio-ap: Fix required lock not held during update of
    ap_matrix_mdev object
  s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
  s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap
  s390/vfio-ap: Fix required lock not held during display of sysfs
    status attribute
  s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain
    removed

 drivers/s390/crypto/vfio_ap_ops.c | 93 +++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 30 deletions(-)

-- 
2.53.0

