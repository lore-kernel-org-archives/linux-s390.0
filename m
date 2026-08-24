Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC253859E9;
	Mon, 24 Aug 2026 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599620; cv=none; b=UyUZzLqx83RHEPJqsjLj3U8ob4jwL/fF9RKHl2mmZ4bnWUiiIRjiCtI9wTSlcalWqjtAmKFSUm5h/z4OnEoU7+bwL0P90ZDbuk0hrQYTAoCWI+1Xn4aVCG9jc9/uQx2UP+cvZpK0C8EvgQ5faUEdsSlIIDeNuKtahkInXgLgoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599620; c=relaxed/simple;
	bh=Gcw5UP4gGC4F289qTbPeGhJ8G0BIK5Z3mLupp8P2Fo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6Fj7GosuTrFoLSxLz0Gc6bLRIg2DWoTXZ6ITWPyh2pzkTSzDd6/R2eLldn3d/GmWlXdunmnO9uUmyMc68UglPexASi8FjWuMf5VJOKIlfzcH0iE223AoMDiOdzM+i0/eKZxuSgov4wZZAXAT7K1UKcWELkiCyEwOqpigMSGZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DalAbQri; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DalAbQri"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1gVj2418100;
	Mon, 24 Aug 2026 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+VMZVr
	X/Ikrt3ZCzeinXPpUUFGPbvYQ41HoGVYdLfww=; b=DalAbQri4vigtX382j4cdZ
	w8sO1buY5Wek9sZTHlqyfGBycTfnAqOkY1Ovz5LCn4yvozTwmWIkf6l4tf78ofHc
	5vI8k8MCoBRL20p3JV4IiceIAMJ4hYHcOb2Zc7aeyc9CBRgyl1p26cHFaopzHUT0
	ouHtV9V3KLM5bxfpoi7xmkWsllq1rFK/IgkiPWVyvNyCsgGbIhXf57GQ/e2gmehi
	MQgnwdeaTXpBNAsYU5XDnr2BvgpB8HlmPEBNvO9IQMh5jCa1CTnO/8WuQLybRZCu
	NvtdfkXlHmHpdBBDMn/9M3CDjYsYR73KSP8N60ZFKBYDGlQ0ksRRcZcJ0ZMtyT5g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx3gcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:26:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJQjST026591;
	Mon, 24 Aug 2026 19:26:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag7w7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:26:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OJQp7l59507102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 19:26:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF9358051;
	Mon, 24 Aug 2026 19:26:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5FC5805A;
	Mon, 24 Aug 2026 19:26:50 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 19:26:49 +0000 (GMT)
Message-ID: <88a04bb8-76f1-4805-af42-558e6499f841@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:26:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
 <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfXxZEqJk3+u1i/
 Fbs/vw7K5rv/KClxOrt64hDA7BAhO87KSEKmp9EvuR2DXHkRKz1gK6IQipM9yLRO4ZHfOC0JP9q
 y+D6PKO0uGspEuQvbjJ3XpEsqE3TgJ8=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c9afe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oJhS4qge3_J52AN1xGYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ufc8smyBS976Xa_pMSkZPHGHY9vJpJO7
X-Proofpoint-GUID: ufc8smyBS976Xa_pMSkZPHGHY9vJpJO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2MSBTYWx0ZWRfXzbzp3f2oU08s
 k2hF+00LG8b5+TMy1UGq1vf9K08ZdMXFlQRkzk97SpiVP5PlSqkwkIXa5DsojoTyPL1y6n2Y1VD
 3P23BeMj7TLFm1/vXrDxkm9fANjAf40a/CvbI0cM/bmWo0YvwWMCEjE35Hkr4lNT1bfx+jq/22r
 Qd7GHf36uecCBRJVKfUqNeptYFYvEqalHM8zqKg22Y1HYeHCJ9xmKuAKXa1II5ixhoap8Az/o3X
 fVNrrCu1bNY/c0XYBUoNXVdzqb81wjOxSywf9P4W6cbtK9Qw8FYFOChOPqJJBtoXRMAWGE20Q+M
 dPe/+arExFbAA0ZzO3wd8xWV54IN7Ddtuir4WHy29Yo7YYCn8vTfTOLwjIJdzNMhZlAz2DPWA4L
 LpFuZ2WtLZw2Tkp86fMrZCa3raMp2Nu0uAOEqwiBk1BlW2bXiZOkGNb1bLNELyhZp6P4WLrdtR5
 TQd+rzOmOZPP5pMjOEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240161



On 8/24/26 12:57 PM, Matthew Rosato wrote:
> On 8/24/26 9:58 AM, Anthony Krowiak wrote:
>> The vfio_ap_irq_enable() function executes the PQAP(AQIC) instruction to
>> enable interrupts for an AP queue. A switch statement is used to examine
>> the status response code returned from the instruction to determine
>> whether it succeeded or failed and react accordingly. For the default case,
>> the vfio_ap_irq_disable function is invoked to disable interrupts for the
>> queue and clean up the AQIC resources (i.e., unpin the NIB and unregister
>> the NISC). There are a number of problems with this:
>>
>> 1. Neither the q->saved_iova nor q->saved_isc has been set, so the
>>     AQIC resources - assuming those values have been previously set - will
>>     be the NIB and NISC resources from a prior call; the NIB and NISC from
>>     the current call are therefore leaked.
>>
>> 2. Interrupts may never have been enabled. Sending a disable instruction to
>>     a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
>>     DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
>>     a further WARN_ONCE from inside vfio_ap_irq_disable's own default.
>>
>> 3. The hardware just rejected the new ap_aqic() enable attempt with an
>>     unexpected status. Disabling a previously-working IRQ config - assuming
>>     that is even possible - as a reaction to a failed enable attempt does
>>     not make sense; it is actively destructive, tearing down something that
>>     was working for no valid reason.
>>
>> The fix is to unregister the NISC and an unpin the NIB in the default case
>> of the switch statement.
>>
>> Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index 940c0ff668be..a46bf381ab72 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>>   		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	default:
>> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>> -			status.response_code);
>> -		vfio_ap_irq_disable(q);
>> +		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n",
>> +			__func__, status.response_code, q->apqn);
> LGTM, except Sashiko mentions the pr_warn here that you are updating has
> a pre-existing issue.
>
> Since you're touching it already, do you think it makes sense to switch
> to pr_warn_ratelimited with this patch?

I think it makes more sense to switch to VFIO_AP_DBF_WARN which all other
guest-triggered warning paths in  this function already use.

>
>> +		/* We could not modify IRQ settings: clear new configuration */
>> +		ret = kvm_s390_gisc_unregister(kvm, isc);
>> +		if (ret)
>> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
>> +					 __func__, ret, isc, q->apqn);
>> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>>   		break;
>>   	}
>>   

