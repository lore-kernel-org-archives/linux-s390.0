Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133B35F8D2;
	Mon, 24 Aug 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590652; cv=none; b=pn564AYEBFBz1pJGFew5MXLcvHU9bAuJ43RP78kbgghbOeRTAqV/RyJpwxY+qos115uzOq7NyF5gnOGA7BquCZR+Fvnb0tIDgYC1Y+Ba9ObVEjyAQUuwHfsVM5Mz5OWI5dnSO73K9okRIGaGm1O7r7t9ImJgx1d7Fc4JOJs/pzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590652; c=relaxed/simple;
	bh=k9b5dOERqv++fux0O/+MuzV/aqodYaBinIReq6HT1Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqxsWyR916V+mlmveOegv/7mVivDnwxu8XWa0CnAAfL4/ythWOhhThqeaYrOhusth2HpntHVcsLmb8kj5376fE/gbJXboRmaMUGEcjOIhw7xJeO7ne+ysRf8BUwElccChE5+RBCVCHfytKtLqk87FX0gP0g4f1VPcQhxzKKUG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XxQjG/go; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XxQjG/go"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OG1XZS2351358;
	Mon, 24 Aug 2026 16:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WBLpE4
	aPTjhaO/+15gm23+SjxGYoyAkVuB2m/PKa800=; b=XxQjG/gosKdcgXeyFVm//1
	zacYlpndDxt8/mie0I4UY3sRxaULesmSXGIxxLDrYFPUXHOdmKNV6QBiWHo31p1c
	itn6ltAF4D9jWGhtNqJsqCDjPWuA8MCRTk2s6BLUhhg3ou+gqWmwXTPHNjWcXlus
	QXygHkQSuugRRekv898cdzYqcj+o2zJVgEbZdRsSSjBee5zlBA+wG7rYtRprqi3a
	srsHDXfLRJf1V5Rb/sU24qCEeEey94WbRzPh2VpVZgNk7YAMliNww7+xwbuXJ3dK
	n/6I2oiD2ndM63BnTghMtSO4OY7pBSLR7S0a5DeyVIfjwi6cskoXBqToIj+bbbZg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393tvgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 16:57:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OGuHt6005048;
	Mon, 24 Aug 2026 16:57:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jq9h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 16:57:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OGvLaR6161090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 16:57:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C02F5805E;
	Mon, 24 Aug 2026 16:57:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B58E58052;
	Mon, 24 Aug 2026 16:57:20 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 16:57:20 +0000 (GMT)
Message-ID: <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
Date: Mon, 24 Aug 2026 12:57:19 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260824135850.503728-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ppxfdOiWxo71pX4HhdvMFK4alxv2A-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfX7m3NyDw4ks5t
 BJX0bqy5/HuF8eIfpPhypu2brL3QkMwkFUYTvqSbXCiOPh/oJ2QSxwnekXnmIwnRxAGN/W+pkhP
 a0oGpV8V4UoWB0hF5ieBRpYHZhwtGbev8UpnLHIce++D5rGLcM1v8+SKMyQBc3jupFKCpUe9V05
 yKFAGDxOKl3yGI3XBTeVXDy3UxlIu2fxY2HlKygXeh/pguPUAR1Wv2/k/x5J7dcoCU2EefyrSh4
 ZIV87QxEUSvBpTIpW5OxuQWTa8FD0sCTjbrZ4CXzdx+DvYjEp9v1ZS73H7TSXoSSBmpF9kgQt9t
 guBrUo/XSodrzb/SAsYZzjEs540LcAmA4jVaSlYIytUymdv3IgPldN4GLqqZbpbLSVcwjNCgEj5
 MzWwNeY/LkYqOMOduIA3GN4TkKtKqZ52ZU+FyKp4jJlhIXJbbMvsSp1E0dU5eZYKrefsvWIH9rH
 2jUUBm1Z+vMwJml8RZA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c77f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Mqm6PHJeAsOntypqS9kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzOSBTYWx0ZWRfXzr+d7DlFzWwe
 yPkTMAQWLaaJMIgpfomcj/yOnG/SVouB6GJ5BcxRQ4ibsa2trodqSPQP4a+k5et0Gkww9XAEjBd
 KTZ8pwBO5WmleFu7eKJ2u+M4ZELsxxI=
X-Proofpoint-ORIG-GUID: 9ppxfdOiWxo71pX4HhdvMFK4alxv2A-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240139

On 8/24/26 9:58 AM, Anthony Krowiak wrote:
> The vfio_ap_irq_enable() function executes the PQAP(AQIC) instruction to
> enable interrupts for an AP queue. A switch statement is used to examine
> the status response code returned from the instruction to determine
> whether it succeeded or failed and react accordingly. For the default case,
> the vfio_ap_irq_disable function is invoked to disable interrupts for the
> queue and clean up the AQIC resources (i.e., unpin the NIB and unregister
> the NISC). There are a number of problems with this:
> 
> 1. Neither the q->saved_iova nor q->saved_isc has been set, so the
>    AQIC resources - assuming those values have been previously set - will
>    be the NIB and NISC resources from a prior call; the NIB and NISC from
>    the current call are therefore leaked.
> 
> 2. Interrupts may never have been enabled. Sending a disable instruction to
>    a queue that the hardware just told you is in a bad state (CHECKSTOPPED,
>    DECONFIGURED, Q_NOT_AVAIL) is at best wasted work and at worst generates
>    a further WARN_ONCE from inside vfio_ap_irq_disable's own default.
> 
> 3. The hardware just rejected the new ap_aqic() enable attempt with an
>    unexpected status. Disabling a previously-working IRQ config - assuming
>    that is even possible - as a reaction to a failed enable attempt does
>    not make sense; it is actively destructive, tearing down something that
>    was working for no valid reason.
> 
> The fix is to unregister the NISC and an unpin the NIB in the default case
> of the switch statement.
> 
> Fixes: ec89b55e3bce7 ("s390: ap: implement PAPQ AQIC interception in kernel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 940c0ff668be..a46bf381ab72 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -503,9 +503,14 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
>  		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;
>  	default:
> -		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> -			status.response_code);
> -		vfio_ap_irq_disable(q);
> +		pr_warn("%s: PQAP(AQIC) failed with response code %02x for apqn %04x\n",
> +			__func__, status.response_code, q->apqn);

LGTM, except Sashiko mentions the pr_warn here that you are updating has
a pre-existing issue.

Since you're touching it already, do you think it makes sense to switch
to pr_warn_ratelimited with this patch?

> +		/* We could not modify IRQ settings: clear new configuration */
> +		ret = kvm_s390_gisc_unregister(kvm, isc);
> +		if (ret)
> +			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=%d isc=%d, apqn=%#04x\n",
> +					 __func__, ret, isc, q->apqn);
> +		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
>  		break;
>  	}
>  

