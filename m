Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5247A874;
	Thu,  6 Aug 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027256; cv=none; b=tUnG99R3FCnjcjSDX/YntA9Eo29/8z7+aBdALGABy2Vc7HesuUxhHKy/6fq6cUvTdxKFGVFXAfXJ/tyLGfaSzE9W9K53PNrE2+DNACdSlNkBmqchgWQehnwxEb0tbElB/6pn1UTJUcy3Unb8LRGyBIhyWsEk9T2/0o/xRbIdqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027256; c=relaxed/simple;
	bh=b8UMmJIK1roJcxji8b7aZazbm4mtPjywKEyoQqEnnu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNFbq+jc42N5jEqgajg7umIYtt30r9Uyrof/7eeLlWdWQK8c0jnbhaKjcZVdA9vhEOVXEjjSnPkKMLoFGA1WcbcIFUhpN+9tx2Ajd7YCpwGVutBMsfX6O0UlYVmV5zvox0JVxRnUqpN2bF4oqELBo/ta21ZizERFYRXwV0GacC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OsEpifWI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsEpifWI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676DKfmE3403037;
	Thu, 6 Aug 2026 14:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ak0bsz
	K6cPIZW6kjqVEzt147e9Htnr+SwCGWCb4fvP8=; b=OsEpifWIjQrBjm2wF7s1ln
	vTNMjXsO4r47Gncu4f/s/wSNs5XuXg/+P4Wq83zk8up866GCQUTET3C0zMHab+mH
	4+UnHkBlk26yZXBPGfbhJbECyKkSllsvodyrkGAW87inaDDhf6ax33DqFT3QlKtb
	sREKpyePELa7dGvI/DWuFwFR4kMMwdGNFEf6irAH3FISPoFBSHIZDJ6lozSG33mh
	G7eUtuleWXZJ4LrK/hSTvnXLF0cQhP2eebw3rFAZktTV8YE2rW1atO+X59ChYim2
	WQ/K2ko8Sj+8VdeaPZyioDM3/d9VM94i7KsokaaXRre4ijGcHEB3YNa0orzkVgSQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fr0p9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:40:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676EQLiv018888;
	Thu, 6 Aug 2026 14:40:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyubtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:40:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676EejVV30605884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:40:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 254FA20049;
	Thu,  6 Aug 2026 14:40:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB13220040;
	Thu,  6 Aug 2026 14:40:44 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:40:44 +0000 (GMT)
Message-ID: <68cbe878-e40d-4350-87c0-3b37ad8b430a@de.ibm.com>
Date: Thu, 6 Aug 2026 16:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, stable@vger.kernel.org
References: <20260806140342.611294-1-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260806140342.611294-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hfkp6an-SMNMUUrLDZvsyZqQX2Oamd2N
X-Proofpoint-ORIG-GUID: Hfkp6an-SMNMUUrLDZvsyZqQX2Oamd2N
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX/NNzNkY9x3Tu
 KQUBF4ICO462Z7oPBKGu0xOC8lAY0GcJ+PBt6TNR9QJeu/YAl+b1a7Qf/zREfF4CmwzFDXNQ//V
 GKgz2UxwZeaMKONA0ycbYxPIqN0LnXk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a749cf1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nu9rwboPZxh9mYkT1JgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMiBTYWx0ZWRfX/N+OkfbqJn5F
 v/SgZqoA//8pw/R45LSFKBATFE8X+YdwPG5KXQdoWTRjy91PvKr+ph4XbObfWq24tsyDqvRg0Lo
 RsGVzbHqRon9nOp48Q7qzCUffQnv7VPQ6bRCdxRJ1/fUxGpe5tHWvrr2fPCxtK41MbKs9NwAz5+
 i7uA/vfJ8WVTnnDIHujAn4qBW2Pt41aM0cwv21HbizGfx0s5cP/N1AQxbR+xlLJYaNGXdiIZrc2
 PEtxCdbG5NDsaxKn46uO+R54sNC7iaqDbtU3CjTMaTcJGRPxN3LP9+dEArc9Lx2qEWuNsOqJ8n8
 SvkuaB7k+OFp3jqQQwz7QkD9IgDtMz+a5bXjO9ISBld++/AUA/mTQ/UcR22hgWY3o3/0SLBlmgq
 Rp7EpYHUWNIt5/JCfS+9nRy5sstWjFrfgvgzndlTaXr0CY3R1Du6wlbVPGXbSeaUl1zI5t7iJke
 7om7iTMDcekjav4i3kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060112



Am 06.08.26 um 16:03 schrieb Anthony Krowiak:
> In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
> &matrix_mdev->pqap_hook before the update locks are acquired and the
> mdev list is checked for a conflicting assignment. If another mdev is
> already attached to the same KVM instance, the function returns -EPERM
> without restoring the hook pointer, leaving kvm->arch.crypto.pqap_hook
> pointing at the failing matrix_mdev instead of the mdev that legitimately
> owns the KVM.
> 
> Since matrix_mdev->kvm is never set on this error path,
> vfio_ap_mdev_unset_kvm() will not clean up the hook when matrix_mdev
> is later closed. If matrix_mdev is subsequently freed, any PQAP
> instruction executed by the guest will dereference the stale pointer
> through pqap_hook_rwsem, resulting in a use-after-free.
> 
> Since kvm->arch.crypto.pqap_hook is only set in the vfio_ap_mdev_set_kvm()
> function and is cleared in the vfio_ap_mdev_unset_kvm() function, a check
> for 'kvm->arch.crypto.pqap_hook != NULL' is all that is needed to determine
> whether it belongs to another mdev. This will alleviate the need to iterate
> the matrix_dev->mdev_list list to see if the kvm object is assigned to
> another mdev.This was introduced in v3 to alleviate the need to take the
> mdevs_lock while iterating the list; however, this did not prevent a
> potential race condition.
> 
> The pqap_hook_rwsem(write) is now performed inside
> get_update_locks_for_kvm(), which is updated to acquire
> pqap_hook_rwsem(write) between kvm->lock and mdevs_lock. This ordering
> is consistent with the PQAP intercept path, which acquires pqap_hook_rwsem
> in read mode while srcu is held under vcpu->mutex, establishing the
> dependency: kvm->lock -> vcpu->mutex -> srcu -> pqap_hook_rwsem(read).
> 
> The pqap_hook_rwsem is now released inside the
> release_update_locks_for_kvm(), which is updated to release
> pqap_hook_rwsem(write) between mdevs_lock and kvm->lock.
> 
> Additionally, kvm_put_kvm() in vfio_ap_mdev_unset_kvm() is moved
> after release_update_locks_for_kvm(). Previously it was called while
> kvm->lock was held; if it were ever the last reference, kvm_destroy_vm()
> would run under kvm->lock, which would deadlock.
> 
> Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


