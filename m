Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7333ADB0;
	Tue, 18 Aug 2026 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079962; cv=none; b=QcKf7btqZpV08PsoMGVpI1RxajYkoK3vHAwpG3ADBXwUGAhWAd95y7ucP6IxIC1tPHAoz+/jMx4gJJpgRcGYmGphFEXZ/6QZx0EvfbpOWqVEGQC2Qb6X3vAlH4bMf0UT5Mo32BdCk0rRaAvH0oLzsZZ5kk5codQdwUJS1X41Gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079962; c=relaxed/simple;
	bh=aiscIuQtFNFYY/Wvks0OzKhxLX/zIouZoZFM/d65tuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy/9JHNvU+T2sJfKTKKm0ZyKP05nddUlfmfUnN71Tyc7c+qykd8uspCs3lHp0ZkWItKH1/T2FjfwGWlLFnodNbBIGk6vcg8wJiaAP50baOdtt3EcRziJLS5Lg/WgPnsmAKO5LfCg7TncryxFIgsAFWkZLjmimSvEJ50GRWoKcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5XwPf9S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5XwPf9S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IHVlWq982645;
	Tue, 18 Aug 2026 19:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wbF0km
	4NTj97TqwIvm01sqHzxHnOk9lpPo+H4sB5VZM=; b=M5XwPf9Sdwj75THAGx83wI
	SV6sc3DPBczGaDUgtzMe4fWar16fLv5mbsBwM4o+3xXj3xygEMabF2Cwmsowxhwo
	kQjm8Uq78empOGyWkqqfiD/uA+Jb+1gTVlJHRp2n7ztPuW1aJVmD7cbcQqk3mUCB
	A4NY3WFKcs/f3OhLI7qCpYfE7MtXfTWUrxbzzCr+iP/ikYyMlE7Myzz9NRtPI6H5
	RAt2vDuAkWadluZubsvjTy4ArJqtrCz7acdlAEbfh9H1r55wiNWATu9xfTwfwCqD
	sIE0Krd2CCQWk4qLBEW85DdME2KFWOgjV3UtEMx9GQ+2+bGGmyIozwIjxCzvPMRg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4tctu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:06:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IIuLi8017540;
	Tue, 18 Aug 2026 19:05:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq54x3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:05:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJ5wcK31719950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:05:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3472E58056;
	Tue, 18 Aug 2026 19:05:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A4B558052;
	Tue, 18 Aug 2026 19:05:57 +0000 (GMT)
Received: from [9.61.26.94] (unknown [9.61.26.94])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:05:57 +0000 (GMT)
Message-ID: <09433bc2-6a62-41ee-b9c0-f6eaa63546a5@linux.ibm.com>
Date: Tue, 18 Aug 2026 15:05:57 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260818115819.1656595-1-akrowiak@linux.ibm.com>
 <20260818121503.06E571F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260818121503.06E571F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SIQnc_hAw4THzf6KtwMkyOaaxBLVoaaj
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84ad18 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4QoMDG2x3sYJ-FFMaSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX/6R3q9UgNyie
 hwx3RAmCGSMktuDr6hvz9gA4bD/WlE4OANcxLYkz/Ghom2l5CSc9pZMYK8MIAR5B7G88dkbX4LB
 YFZk1u/dMWkSiX+oalgDEKIrFmOkRxk=
X-Proofpoint-ORIG-GUID: SIQnc_hAw4THzf6KtwMkyOaaxBLVoaaj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfX7wj2roYt9s24
 WSZyBdn3jVlTSuEGdvWhXuY/2crrcdsNo+dM8ObnkmPgeDEPM1eVBy1aoP4Kkxy0A4t67ruxbwA
 OSJU7y/L05Fz9E8Qa5D9MsmzRmBTtisAXScfOuHoKZcFOtnfh0sE6pYok7FpVNlNcX4p0z7nsNb
 dEva34NKmnR6d+pjRGHpJSqIHwxbqfCzItSN8tDD/2BEb7TvJUEQN7AMFw0EcMyKxSL7/zd109/
 N438EShfACgi43+zim1Rhs9AyzFoCNnv2+XF9swd3KqPFbM0frxLJ5DmcP2JRIvCeJF/v74Bk1a
 1/duY2IFSrF8C/KbJGwm+PcK71D9nzP1dRW4xDqx43FQRWI3L9Op3ihJ3OCUnAdbLXebkl1SuZ5
 ZAbb41hCTNQeS250lEg4DtI8eHxDmqGpHz+MOCoGhNfQp0ygTlLeYRRy0qvKu7YdtF3dBr5pmc5
 F9nynX2v80pbEwqJb2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140



On 8/18/26 8:15 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Use-After-Free of `q->matrix_mdev` due to dangling pointer left after unassigning an adapter or domain for a queue not present in shadow_apcb.
> - [High] The patch fixes KVM GISC and NIB page leaks when a queue is synchronously reset by handling AP_RESPONSE_Q_NOT_AVAIL, but it misses the asynchronous reset polling path, leading to the same resource leaks.
> - [High] The apq_reset_check workqueue function loops indefinitely without a timeout while waiting for an AP queue reset to complete, causing a KVM process deadlock if hardware fails.
> --
>
> --- Patch [1]: [PATCH] s390/vfio-ap: Fix leak of KVM GISC resources ---
> commit c19d4565d7b440cb8eddb06c5a8a375c867d24ea
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Fix leak of KVM GISC resources
>
> Two related problems exist in the handling of KVM interrupt and page
> resources when a queue is removed from the host's AP configuration
> while assigned to a mediated device (mdev). This patch addresses the
> AP_RESPONSE_Q_NOT_AVAIL response from ap_zapq() and fixes the
> vfio_ap_free_aqic_resources() cleanup.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 44b3a1dcc1b36..e277062e92bea 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> @@ -2004,6 +2004,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>>   		break;
>>   	case AP_RESPONSE_DECONFIGURED:
>>   	case AP_RESPONSE_CHECKSTOPPED:
>> +	case AP_RESPONSE_Q_NOT_AVAIL:
>>   		vfio_ap_free_aqic_resources(q);
>>   		break;
>>   	default:
> [Severity: High]
> This isn't a bug introduced by this patch, but does the same resource leak
> happen when the asynchronous polling path in apq_reset_check() encounters an
> AP_RESPONSE_Q_NOT_AVAIL response?
>
> When an adapter or domain is removed from the host config while a reset is
> asynchronously polling, ap_tapq() can return AP_RESPONSE_Q_NOT_AVAIL. The
> helper apq_status_check() falls through to its default case and returns -EIO:
>
> drivers/s390/crypto/vfio_ap_ops.c:apq_status_check() {
>      ...
>      default:
>          WARN(true,
>               "failed to verify reset of queue %02x.%04x: TAPQ rc=%u\n",
>               AP_QID_CARD(apqn), AP_QID_QUEUE(apqn),
>               status->response_code);
>          return -EIO;
> }
>
> This causes apq_reset_check() to exit immediately, skipping the cleanup:

This is a legitimate concern that needs to be fixed. While this bug was not
introduced by this patch, the fix is related to the purpose of this
patch, so a v2 will be posted.

>
> drivers/s390/crypto/vfio_ap_ops.c:apq_reset_check() {
>      ...
>          ret = apq_status_check(q->apqn, &status);
>          if (ret == -EIO)
>              return;
>      ...
> }
>
> Does the default case in vfio_ap_mdev_reset_queue() also need to call
> vfio_ap_free_aqic_resources() to prevent a leak on an unhandled ZAPQ
> response?

This covers truly invalid/unexpected response codes — it would not be
appropriate to unconditionally free resources in that case without
knowing the queue state. I might also add that this should never
happen as all response codes expected by the architecture are
covered by the cases in the switch statement - except for response
code 03 which will be captured in v2 of this patch - so the default
case is handled correctly.

>
>>   		WARN(true,
>>   		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
>>   		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>>   		     status.response_code);
>>   	}
>>   }
> [ ... ]
>
> [Severity: Critical]
> This is a pre-existing issue, but is there a use-after-free of q->matrix_mdev
> if an adapter is unassigned that is not passed through to a guest?
>
> If an adapter is unassigned, its bit is cleared from matrix.apm and
> vfio_ap_mdev_unlink_adapter() removes the queue from the mdev's hash table.
> However, if the queue's bit is not set in shadow_apcb, it is skipped from
> qlist:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_unlink_adapter() {
>      ...
>          if (q && qlist) {
>              if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
>                  test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
>                  list_add_tail(&q->reset_qnode, qlist);
>          }
>      ...
> }
>
> Because it is missing from qlist, vfio_ap_mdev_hot_unplug_adapters() skips
> calling vfio_ap_unlink_mdev_fr_queue(q):
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_adapters() {
>      ...
>      list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
>          vfio_ap_unlink_mdev_fr_queue(q);
>          list_del(&q->reset_qnode);
>      }
> }
>
> This leaves q->matrix_mdev dangling. Later, when the AP bus queue device is
> removed, get_update_locks_for_queue() dereferences the freed pointer:
>
> drivers/s390/crypto/vfio_ap_ops.c:get_update_locks_for_queue() {
>      ...
>      if (q->matrix_mdev && q->matrix_mdev->kvm)
>          mutex_lock(&q->matrix_mdev->kvm->lock);
>      ...
> }
>
> Can this lead to a kernel panic during normal operational reconfiguration?
>
>
> [Severity: High]
> This is a pre-existing issue, but will apq_reset_check() poll indefinitely
> without a timeout if the hardware wedges?
>
> drivers/s390/crypto/vfio_ap_ops.c:apq_reset_check() {
>      ...
>      while (true) {
>          msleep(AP_RESET_INTERVAL);
>          elapsed += AP_RESET_INTERVAL;
>          status = ap_tapq(q->apqn, NULL);
>          ret = apq_status_check(q->apqn, &status);
>          if (ret == -EIO)
>              return;
>          if (ret == -EBUSY) {
>              pr_notice_ratelimited(...);
>          } else {
>              ...
>              if (q->reset_status.response_code == AP_RESPONSE_RESET_IN_PROGRESS ||
>                  ...
>                  ret == -EAGAIN) {
>                  status = ap_zapq(q->apqn, 0);
>                  ...
>                  continue;
>              }
>              ...
>              break;
>          }
>      }
> }
>
> Operations like vfio_ap_mdev_reset_queues() schedule this work and synchronously
> wait for it while holding global locks:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_reset_queues() {
>      ...
>      hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
>          flush_work(&q->reset_work);
>
>          if (q->reset_status.response_code)
>              ret = -EIO;
>      }
>      ...
> }
>
> If the queue is stuck in hardware and continuously returns AP_RESPONSE_BUSY or
> AP_RESPONSE_RESET_IN_PROGRESS, will this permanently block the locks and
> deadlock the host driver and KVM process?

This may be a legitimate concern, I'll look into it and post a patch if 
determined
to be necessary.

>

