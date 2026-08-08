Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56B1E1A3D;
	Sat,  8 Aug 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208842; cv=none; b=Gumm0AqgWD0ghq4PqgzAsk+aOR9K6z69ObglDfj7wPIS6npus0/d783isAB9YQqbA5uMRSVoVgMQwmuDq53ezAHNJwI01uYPxQ2Oj76xojD6H3dD/vNvLl7WhMjZ0ql+WtweFsinHBuzq6tFkZbQS51aCK6wr35L8yjPQt2oPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208842; c=relaxed/simple;
	bh=N7YNTaD708Ak1rcIEbcxnkyicdOsxQywrN2VWQyDoGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGp42bmsndg4BQo6zeAAsL/adto3K8/QbmQEML+ikJS02Qkje/HUg2eT2V3oahiBiEVYzbzssWe9Kov7vnPgbMtEW7ILn7KV9CM1PUQVXuw1s2GE1Fnx5G7zDltHLmZuqlLx5yiLgWzmQ2kycS/4iAEhJsvWjXgyMRl9BU6J5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a+m1vKrc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a+m1vKrc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678H1t6E605920;
	Sat, 8 Aug 2026 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EumPc/Z8Qs2I5BfaYp5qyMsIm8lGMzPFXtxpi/APn
	ZI=; b=a+m1vKrcDDjunBB/BZPAlth8lIJVuBSBguhVpeWK/lshKENbFUqiNjFBa
	lRkoPDyFsIiiWJkL5+k96MXYGFyaRFSRrl69bImqdLQ7rX5rT+D7zvMTEkYccJCl
	/LIfW2z4kph8jUzn9HbxMnDyk7UMt2Wz0+KW14QSqhLex2o/1mU0vi/H3X+Opdx2
	hxoY7e13pu/GTneMnoF6oAOuxUScfaYMANx6oZpbllPsNvUGdHcXi9uccV+v/N1O
	AEq/vs/vkvZU93vZR/Re4ctRILlAe+TbXcYMU7ZNCH+0icc2X5zEtMv/RJGNtQPO
	RYDpZnPLpxYg7hzYPMAOcWpVQt2Kw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchn92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GucTw020353;
	Sat, 8 Aug 2026 17:07:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwm6fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 17:07:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678H6bBZ3801754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 17:06:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD8158050;
	Sat,  8 Aug 2026 17:07:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50CDF58045;
	Sat,  8 Aug 2026 17:07:13 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.94.189])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 17:07:13 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH 0/5] s390/vfio-ap: Fix bugs in vfio_ap device driver callback functions
Date: Sat,  8 Aug 2026 13:07:07 -0400
Message-ID: <20260808170712.839066-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CSrL7VKMj1s38YYbZbXy4qxVu4lVkzPw
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a776244 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=JeDQMd_j_dsK6LpMBgMA:9
X-Proofpoint-ORIG-GUID: CSrL7VKMj1s38YYbZbXy4qxVu4lVkzPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX3cnEck0qpz54
 hFA8wUgRzkfrz1avNQrVn6Yk77wNKk2No4BbmMROSesK0M4oyLDFuMQ4oUyiBjqpgKVXzZkc1nX
 NihYGYOa+qUB3NXoM4BnhaCZJq7Qgt0Pk+f/2qOYRE84wNCn80s9IYiH0mpA4Ro3p/uir4Jy+zq
 i0PfkyoQLEkaYQyLVhI9FFTOh5vcUSIxNlAuY+f9rVTWDFYf7MlZ7sT6MF9K4PE70myGbms/7p2
 LUGJt6wt1+gahkTxGNdZCUfcltApPGQm+oEt1OE5vpF7th/NQ6UiRb9u6Vv3bVjgvlYX2KofdGx
 ig/4HLNv5ySCQrNL2ZXBkZnpVkBFL+7VHECrPZn4WM+sHjJXpEOoNYcm6pLN7fRK2FzKqqLQYf4
 Z8IUjtTzHdHs9wk8KOHMba8J/V2pAxiHKarvx5KJPCd8a/c5s8R9FF/zMgA6JlLfzQzhb6qv+C0
 5ABmpu9MIGfvSF6hVDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE0NiBTYWx0ZWRfX+AOSxRw/Sbvp
 /fGbDJgxg0qB7DfkLk0jU8IGynhojA8/o7wdj7DXFpdyLvurqIwaWp2x+cYN4BhhVY/CXeK/LkL
 erh63JnsYWsxMYAM2uxLUw4EpjSh0zc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080146

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

Anthony Krowiak (5):
  s390/vfio-ap: Fix stale do_remove flag across iterations in
    vfio_ap_mdev_cfg_remove
  s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for
    NULL
  s390/vfio-ap: Fix use of wrong lock in mdev probe function
  s390/vfio-ap: Fix required lock not held during update of
    ap_matrix_mdev object
  s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove

 drivers/s390/crypto/vfio_ap_ops.c | 59 +++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 18 deletions(-)

-- 
2.53.0

