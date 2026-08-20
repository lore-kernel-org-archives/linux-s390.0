Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2683E49E7;
	Thu, 20 Aug 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231294; cv=none; b=SGDJQR7QVCn7eQWOoSjr0SXegL/0qTabuBvlEG7lrOZVjohU+5DK1IDrxsYb3A2gsHlxR5QKBNYBO1IOqPw27ZF8WDoeL4UOaWpKoUs8kxY7VlkO793gXDilHZrn7K6ZWXFr/41MTNel16iRtXWXXzCEU8rONkjpz5kjFlLGe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231294; c=relaxed/simple;
	bh=6JXJ7yaU65mWazAkPSkUtmQuqQvyJacQ4FclxXo8JCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH0r8l8+8FSwlR/SkWVTgd1n/lfJVTEtt5EC4B8k9THCyJGhNlxjCXaKjmowyuZeqkTEtrWcgosih0tpBtECKG95hcGYOLJkA+IfdPmunJnW9Z4BoKtYJIp4bIbrvOKsjPCVMEjr5VB+g69r0OnlYGT13E3I03Bmdl6H8Vs6FR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kg+YNJz7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kg+YNJz7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8QYZ52794873;
	Thu, 20 Aug 2026 13:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vzrBYu
	UIs3CeafkjdrV2tadorcYPpq8k/DM2/RBSSv8=; b=kg+YNJz7CLE9IjMCM86SuD
	OvmVlM/k3w29Iu36jj3xuocmmTmcLI5t1Jyp9GfCVQFK+MhseECVfsPT82y90c4O
	E6GiE3Xw7qUPU4B6BskXGms0HYBtFzeL7hp6WFPZ+gPG4SYz8jSPCFOX+Q2m910W
	CM5ZTirKDKMR33LMin9EkBmheSXSB1EwD49tMEuhQZxNd6Wg9nqgPAYI6vqvxQH5
	iccaSB93pA9pvir8pY+exAsWl+h+GjQnuAEfDrzT/5yIwW0NqJycC2Dq3Fh7HRV3
	gpLIUbr8jo3Pvj/ySmYXZZyGvZWGgr/QIocvVnA1SStsWD6oCrndYarR/FMPnDOQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0aew8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KCuGAw001726;
	Thu, 20 Aug 2026 13:08:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ypd6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 13:08:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KD82rw20972050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 13:08:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF2758055;
	Thu, 20 Aug 2026 13:08:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F35265804B;
	Thu, 20 Aug 2026 13:08:00 +0000 (GMT)
Received: from [9.61.142.83] (unknown [9.61.142.83])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 13:08:00 +0000 (GMT)
Message-ID: <8fcac646-b33c-44e2-90db-b517419f8f76@linux.ibm.com>
Date: Thu, 20 Aug 2026 08:45:16 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] s390/vfio-ap: Transition device migration state
 from STOP to RUNNING and vice versa
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-13-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-13-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P2EKMalu5ZBCHBwLQNf1sU5Z6EE6cdgI
X-Proofpoint-GUID: P2EKMalu5ZBCHBwLQNf1sU5Z6EE6cdgI
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a86fc35 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=y0ArAjEgCogrmhQn_7oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfXxKBz/HejOZYU
 v24g7q/WXOUYwu+V3jz0BcFANJKgXgvegZqbDvoXJtSa6GMRr3h2b4WIORF+fHlDOYIBAa+9XwB
 c45sVkxuhKMRWrZroRyrWPV7OszEXuc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX8BEDWftr6Bif
 WDkqRQCByJm8bBwYz81/uM5D/IBsSo2yhkLy0DAD3rvAttEaeHB1tJRRSZfmMAJfNK89CeKXfdA
 pJElXKEP9lr/7lLJoATi2R3rcmB0ZLkfHEfyo+se2aix5Rlhg167wlbQdjciBcxWFPOiov2kU/3
 6SFsHVXPlGImJGCi58kllYE/58X9PnLznx4e60XiX9/eDOtT9zPs1WoZP5DjFWe2l5jFUuwKy27
 h365nSCHkf0nTOL19Usf2nMaRLDj8g1r0c1EZv6LpkWUCMGfB6kM830Z7+U9AkxoS719UXwSDNm
 T690TZAgP8U5jBUx0f9DEIUFj0YcH4+zQWeRTVwUuUUeJACr1yzB7JpE12zApPGIrbzhwl8Kpqi
 i3trtqbP3aljsJmCPjvLqTudtHmuQwSfS1NHBWHwD5DtAdw2FIJKcY+hxrWbuKEcInqlnBAgo/n
 5ic90cBzKrkSFfxIbSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200097

On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> The transition from STOP to RUNNING and vice versa indicates that
> the vfio device is operating normally and migration is not
> currently taking place. In this case, just set the new state.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
> index 30160e3ddded..24955f70e13e 100644
> --- a/drivers/s390/crypto/vfio_ap_migration.c
> +++ b/drivers/s390/crypto/vfio_ap_migration.c
> @@ -1524,12 +1524,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
>   		return NULL;
>   	}
>   
> +	/*
> +	 * These states indicate migration has either not been initiated or
> +	 * has completed and the vfio-ap device is operating normally. Since the
> +	 * vfio-ap device does not virtualize a DMA device, there is no internal
> +	 * device state to incorporate into the vfio-ap device on the target.
> +	 */
>   	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>   	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
>   	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>   	     new_state == VFIO_DEVICE_STATE_STOP)) {
> -		/* TODO */
> -		return ERR_PTR(-EOPNOTSUPP);
> +		return NULL;
>   	}
>   
>   	/* vfio_mig_get_next_state() does not use arcs other than the above */

I'd argue to integrate this one into the earlier patch and drop this one.
