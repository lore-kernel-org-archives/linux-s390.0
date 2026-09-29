Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4451B168;
	Tue, 29 Sep 2026 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684329; cv=none; b=tMIaojE9y2PZ5fcN8Uosljc5glwp2yvaRXYe4xKGTHtvIW9DLUpU+OtLkwCy4nOLEMUXCTtfLRP/hj2/xfspdhCHDIpcfswON2VD9zQpJnTXriXBrHGYMM4/26rFYNOqZYN7i6VPSuql868HhN3UgN4CJ6PHUeLzbLiaw4xtK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684329; c=relaxed/simple;
	bh=K842MCF9MW+9vR1sNpBZKwmxwO+/euJj8NoTII7XQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a5vx3/VYKxZm93lPBwkp9w86ScFLf/k4atdXrGTdl1qiSdn3/qzhc5U77mFKl1amive5xmzPGx1HbMnVnnL8P6dhYWFlKF08vxDdnl7nlYw97gciNIDBIW86TIfDSHgv9cVroyIFhI8RGzWM4ULT9NPxif0QapXZxXUc3YKrPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mpQf9ZqO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mpQf9ZqO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5Vmv4017566;
	Tue, 29 Sep 2026 12:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=PtVJ7yaQ4xIo8lRII0cH8idfQfxl
	aZXVKcLhWbtaL98=; b=mpQf9ZqOhN+KfNoQ9fseQ9o1m8QIShsxUdeISrH0K4nd
	PfhTvi90+ORmP/AKwD+1BXc+EIQGl3wZ6a4PzElQnC9Vidg/RRf6LtU4tkAbQ8x8
	E5cqeeaba4zmTz2NACoT7WZELcRQe/1bOIQDtpmOGbvvHcHlHZS6jf8ncy7aaNFz
	FDu3Ql8EQ4ji9HKOK7GWWCWDtrn1Fi4UZArLm5r83tNcfJTjnhoXzqqmNrI3vSq9
	zJajkkLg1GtviP5oqjSyl4CFp5uTcX9LiRQa0z0+FxK4bgJhVlO94WLgmxTem4Hy
	83rOMod46F7UixGPCj0b48Caf9BHAE+G/Cmy3w544A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt65rt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlpaw1657690;
	Tue, 29 Sep 2026 12:18:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpst9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:18:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCIddW21627516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:18:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98CE858056;
	Tue, 29 Sep 2026 12:18:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E33958052;
	Tue, 29 Sep 2026 12:18:38 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.24.130])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:18:38 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v9 0/6] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Tue, 29 Sep 2026 08:18:31 -0400
Message-ID: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: o6IUzOHVH_eFchUL5Ogv-piAONq7HUzr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXw45nTqDPILEh
 OJMLXqD3jKCuK8jP/uWq9dCs0iZ0CYwSCRYWjKpUZtlBWjvaTAIxT1ixbvJf2sEjZfWZqyhCHE4
 hASzLCF6ckfLOu9TXVZlzcokgkKB/nQWqhHRc05vxp3ty4I4THO8iuK+Im8u7VBqs668tADG37W
 ejAAncMkPxxoFBLpTJ1kYgX6H1+TFv+eFc01kM43/BPxAkBaPipZjZUidWwp1L/w9GsG6T9Os8p
 G1SyoMYHiUZJI4lc7gj/K2AwqY2taH9YRktzzfe3dDnH8nPCU8QI26JjEulsnPj1bo1H2TgHrNX
 29ybUyZFSxqEaMtWVgwVmwBog+NvrOCXoWi69rKPUlYcjOKBymkKSdKhzfWLWRSiUuJ6m4D4okC
 4PV41+bc1Cu5oRhKEpIs5ijhNRcFsNEOk7cpxY9PruPrxR3e/pvalYD065vVBdmjuo4cgCXP/XL
 ARev1Qj4F2PIVw9VVDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXyh30ntblYstX
 JZvp1SmYbhxInHJTE/DJFQKwz+fnhyGFo9EZcwGRCMPJdIthDTgBwbf+ZoLwnnfi+EJkG3+KDKW
 N+JWCeCg5m5kuNnr/SlRZFWu6Ay/7Ok=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbaca2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=_biaL-lT0fUayhiG4KMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o6IUzOHVH_eFchUL5Ogv-piAONq7HUzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048

This series fixes several pre-existing bugs in the vfio_ap device driver
code reported by AI.

Change log v8 => v9:
~~~~~~~~~~~~~~~~~~~
* Patch 1/6: Fix leaks of pinned NIB and registered GISC
  ~ In umap_iova(), do not free AQIC resources after the ZAPQ;
    If the reset succeeded, they will have been freed in
    apq_reset_check().
  ~ Fixed NIB and ISC kept after a failed reset are later released
    against a different vfio device or KVM
* Patch 3/6: Fix unbounded loop in apq_reset_check()
  ~ Removed elapsed = 0 in -EAGAIN case in apq_reset_check
  ~ Rearranged code to make ZAPQ re-issue condition reachable for 
    the case the previous ZAPQ returned AP_RESPONSE_RESET_IN_PROGRESS
    or AP_RESPONSE_STATE_CHANGE_IN_PROGRESS 
* Patch 5/6: fix queue state leakage to guest and host
  ~ Fixed vfio_ap_on_qstate_transition(): use-after-free of q against a
    concurrent unbind
  ~ Changed patch commit message to include comments about the 
    excessive amount of time for hundreds of simultaneous probes
* Patch 6/6: replace guest-reachable WARNs with ratelimited warnings
  ~ New guest-triggerable log messages in handle_pqap()
  ~ vfio_ap_le_guid_to_be_uuid(): no longer called in handle_pqap()
    because the UUID is derived from the mdev 

Anthony Krowiak (6):
  s390/vfio-ap: Fix leaks of pinned NIB and registered GISC
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()
  s390/vfio-ap: fix queue state leakage to guest and host
  s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings

 drivers/s390/crypto/ap_bus.c          |  51 ++
 drivers/s390/crypto/ap_bus.h          |  33 +
 drivers/s390/crypto/vfio_ap_drv.c     |   1 +
 drivers/s390/crypto/vfio_ap_ops.c     | 912 ++++++++++++++++++++------
 drivers/s390/crypto/vfio_ap_private.h |  51 +-
 5 files changed, 846 insertions(+), 202 deletions(-)

-- 
2.53.0

