Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07F44C65C;
	Tue, 28 Jul 2026 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255051; cv=none; b=Wi0W4/xhNv5GHv44q7MtQVEwWo85yXBLAkK5XjtK2P4D75jO0796FM7LFe/2qAxt2HrgB+aUCU9f0qzKYsgffnyVsOL2L/ThMDsHfhIms/eh7DY2Oy621EvyFXTJ7IgA9f6VF1jJgHWqe7jA26Y8OFLElOy4NPNDluoFHA4dXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255051; c=relaxed/simple;
	bh=V+Hrhpg3KyUC02isYOBq/X3cNJpBekkAfJCuSF0dsf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6rxu6PvCWU5O4dn/PcfiGGYpV7R6PBj9jCQWszd7OA/uF+UOSBFjOw/QTKmWs0qitL8iqyvT6ncUevCwDMjL278E/DF4fWpSZgazhF08ZeQ9/5179zdxLPGP/ONgNZSl2DEJyXTxLUttbaduRwAFAzPDpdcrPPzwTiIkD4QPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhF2FOXg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhF2FOXg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElsFK1491484;
	Tue, 28 Jul 2026 16:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P2Fm6k
	Oxa47Yk0X1bBsdXq4JnF3pI7aWndWhDXdxWAU=; b=MhF2FOXgSZhEigPr3kL+mb
	QMuThWGYO5K/0VHZLCRiTsc2ZpOu4M/g+5oE7qSTadR63tL09KMd7BIPkl0lWgae
	jg1iMK+8U9pcO0wT0kDAhg50COf2bE5KqFr0R7gOC+8LuhPGSfPTYH82Hb8pyWGe
	H66G8fIZNNj38lYanuaK5/HVm3B3kAHqoVB13Euu/fMsn9ZS4oPUlg8khS/9QJpR
	M+GXntrilUYoplTM9eI10wKHgSv6mM6U3YlCKQ41BPK8Q0ii7tRu3U5A7188YIEh
	njOClXBzh8OobG1b4kRaYuqJIla9qIdGotY/6xcGzfRD3xPBxk0pb6ruUh9ABhuQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xp8vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:10:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SFuFOt020549;
	Tue, 28 Jul 2026 16:10:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqavf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:10:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SGAl5O49938756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 16:10:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F280258061;
	Tue, 28 Jul 2026 16:10:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267FD58053;
	Tue, 28 Jul 2026 16:10:46 +0000 (GMT)
Received: from [9.61.138.160] (unknown [9.61.138.160])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 16:10:45 +0000 (GMT)
Message-ID: <dc3726b5-99a0-4912-8e69-c7850860677f@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:10:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: fix stale pqap_hook pointer on error in
 vfio_ap_mdev_set_kvm()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20260722140927.892342-1-akrowiak@linux.ibm.com>
 <20260722142334.5BC8B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260722142334.5BC8B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 643WnnhEmIx3b8SXgVwuZeUAm8Z0Pgpu
X-Proofpoint-ORIG-GUID: 643WnnhEmIx3b8SXgVwuZeUAm8Z0Pgpu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0MCBTYWx0ZWRfX8tfJOMDoJkLY
 CnyM1MgYuNLLGMofxei+OS/3Fm3Ezghkj953nbe/D/Ht9U7nxXghrSYDZ6pNkvnuPzV82aez+XX
 WtbxvaL4tKkphAsOPAFnNFfoCGZP3zA=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a68d489 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=L-Y-XvPL559Sbp1hanEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0MCBTYWx0ZWRfXyVlbU9apAvUm
 aq/6Kx3ZfqJFx8SQjy6NBtTZYHwcHCSIiKp+oTj8CEoPRpKzTLwP5WGSRuNoYrKsuKyPlwrSaTA
 zANeqaoVmlLSMxiWlTMOLRTTaQjsG/sn2HeBc7+5Za0xn6b0PyF/Bufkk14g6f1P3dBOnZ6+7+V
 0oZLB7m94BhjgJlZCiE5tIn4AnQ6hvrR3mNJk1HpRoc+0H7owNJWxangcDjYk+FUeenzB0K/j0X
 QkheIVjCB7KWhmV8ioelJE3EULFmgoDkYEERyJln37kSCRCaO3SkqNhdUgte+20wRfW6eXYUrVL
 gpkWDlIIRguDRKsTu/IWnMKNYgjyu38yP+0KSYpmB+Z4H4Rlpp0oljmoCT3SDjNcTVOxyS40rH+
 VRvvlBlnlowyLUwZZfvwTnF2ikJjsVQWjLk/NNZ6FGvvEv0peuXQ6L9OR0dwj1ZOQ2hBzf3YN2A
 pBvsAraRTnY3ay+HXIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280140



On 7/22/26 10:23 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Restoring `kvm->arch.crypto.pqap_hook` to `&m->pqap_hook` after releasing update locks creates a TOCTOU race condition leading to an exploitable Use-After-Free.
> --
>
> --- Patch [1]: [PATCH] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm() ---
> commit 3eedf7c518752f33e7b7b7758dc2098b54d797b9
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
>
> This commit addresses an issue where the pqap_hook pointer is left pointing
> at a failing matrix_mdev when a conflicting assignment is detected. It fixes
> this by restoring the hook to the legitimately attached mdev discovered
> during the error path.
>
> Cc: stable@vger.kernel.org
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..e18540fd6dc75 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>
>> @@ -1833,6 +1839,10 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>>   		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
>>   			if (m != matrix_mdev && m->kvm == kvm) {
>>   				release_update_locks_for_kvm(kvm);
>> +				/* Undo the hook installation since we're failing */
>> +				down_write(&kvm->arch.crypto.pqap_hook_rwsem);
>> +				kvm->arch.crypto.pqap_hook = &m->pqap_hook;
> [Severity: Critical]
> Is there a race condition introduced here since the update locks are released
> right before restoring the hook pointer?

This is a legitimate point since it could result in a use after free 
problem accessing
m->pqap_hook while not under the mdevs_lock. This needs to be fixed.

>
> Looking at vfio_ap_mdev_set_kvm() in drivers/s390/crypto/vfio_ap_ops.c,
> release_update_locks_for_kvm() drops the mutexes that protect the mdev
> list. Once those locks are dropped, could another thread concurrently remove
> and free the existing mdev (m)?
>
> If m is freed while we are waiting to acquire the pqap_hook_rwsem, this code
> would then assign a dangling pointer to kvm->arch.crypto.pqap_hook. Later,
> when the guest executes a PQAP instruction, it might dereference this freed
> memory, resulting in a use-after-free.
>
> Would it be safer to restore the hook pointer before calling
> release_update_locks_for_kvm() to ensure m remains valid?

The pqap_hook.rw_sem semaphore can not be held while the mdevs_lock
mutex acquired via the get_update_locks_for_kvm() function are held. 
This will result in
a deadlock when the pqap_hook function is executed because it will be held
while the hook is executing and the hook callback will try to acquire the
mdevs_lock, thus resulting in a deadlock.

>
>> +				up_write(&kvm->arch.crypto.pqap_hook_rwsem);
>>   				return -EPERM;
>>   			}
>>   		}

