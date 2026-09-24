Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE33E172E;
	Thu, 24 Sep 2026 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228508; cv=none; b=oshhAco2lAZnkbuVCX3wUrnfVeCgtW6qXdZoLeUrXMaEEHQjwqw2+J78Rkcqb2NXdywft/SPplMtUJY+TKsjl6xciQxVjT5BkTg6ICrwKh2fosig4PdgploJhM9G0KOTs1IT6yGK8XbJWyKN2EugeeF2sp2d0ZrCjKU6ai45byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228508; c=relaxed/simple;
	bh=qSw6Ch86PfeA7TbGfRfN9M4jHoDhQmrEEGKZK1qnJuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4sD+gLFcC6NuBKBlf01efMm2A1CWaEp3+TwfJ8E2efZxwX4yR0cCaqZ+fRqTxwLELVK/3lxbLDn1YKemtGJkAIeI7gTBVFMyDZaBTlWugU1inpOVXf8DU2ydrwQgivEzTUOBL3ryq6SP3bdru8jFiCjItwQhjwgzkR4d7wZsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbz4wTaU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbz4wTaU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bPLq1341316;
	Thu, 24 Sep 2026 05:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=j3C8VT6lq/50NekSaSJTHmBeZBZscb
	7GN4xLh4wEW5M=; b=bbz4wTaUGdrQaezWOslqPi0RfZE9FIjpiRPxchfX7J2lv2
	GwM/6q3h9Qfl8ASF/87c3ZuIOvgRx5i5yJByI2ck9tFyywyiJgHQN6ui6MLlY4kS
	AlZnLmJneTTyeIjZGTbobsZKqKY/1z/B8as+yq93FR9VnUB5ycUVgUXSLA5aVSx0
	wUJUnhfx3iumwz72dGMsYX7P6bG4z68DB+bS/oqSffMzvoCvlUsqfhRfTIPmkAms
	LgWgB1cLWQsaAUQDDfs9HiUWhBNNDDM9Iysi2nVVzVoNNpYgI99YiXk83L32IDp4
	/tZtAZGE440SouoPmaeNCit8qXHUfOqpJyxb/7SA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2q8wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:41:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2IYu61279363;
	Thu, 24 Sep 2026 05:41:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2v58n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 05:41:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O5feWo49873192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 05:41:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 559412004B;
	Thu, 24 Sep 2026 05:41:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C0A620040;
	Thu, 24 Sep 2026 05:41:40 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 05:41:40 +0000 (GMT)
Date: Thu, 24 Sep 2026 07:41:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nihar Panda <niharp@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, vneethv@linux.ibm.com, oberpar@linux.ibm.com,
        linux-kernel@vger.kernel.org, gor@linux.ibm.com,
        agordeev@linux.ibm.com, wintera@linux.ibm.com, bblock@linux.ibm.com,
        nagamani@linux.ibm.com
Subject: Re: [PATCH v5 1/1] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set
 only after firmware activates.
Message-ID: <20260924054138.13740A41-hca@linux.ibm.com>
References: <20260924050217.2583852-1-niharp@linux.ibm.com>
 <20260924050217.2583852-2-niharp@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924050217.2583852-2-niharp@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3apGR39Hzi8Sd8JQPzMycQJ_zRUaGT1n
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab4b819 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=I-6cxHlVoWN35HKNoDMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX4tDIOnoRhjfB
 O29MLsZZbWtMPTCpRwNNT5phN0Bhc6TlrDsSMZwGc6RdDmeDeh2z+RzRAnpso72I25+OQyb6mWE
 mnXMA1d4rEqnv38VTLZbx9kdsYWIaREcAHIRC++WMPtgcwMVom6+0d2DkK9zH5op0/F63USFFRy
 HT+T8e/1R67coBQy+nmmkO8rSt2sDJM8hosHzssxrwkRvCIsDV89EzEb3Jp7c24tnui01SabxyK
 xfSUKCASxNxs5hlGVuOs8EFpOGZVNi34HEbDFeVpRu1yOGNg0kP2RN41XMfhN2qQhy4hTPr02nW
 vn229J2maH1ka+mnq0qhG1zwufNhSSiEhTTS94QsBx6F78gLjKNQWwGx0FHQ1+1Jcnr9SKxVCyW
 0z8qP8qpDNSMPOC/BjYTItPc54KNtKiKQ+LYM6qIkZgab2fhH1FCHcnXKCjy4MhqcnzgVIAW0FR
 +GuWzLDWD5fMcQ5rRuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNCBTYWx0ZWRfX0LWzlSupcfb1
 W/5lwQSWFfEFGRq60WdGjHaiakvqLO3yx8IE0bQM5u2fTPK8T1uW9QV/XUtTPdLqXvQsHthuoHa
 ZiP37AXYPV9bic7C1Y5r+kHBDWoLoYg=
X-Proofpoint-GUID: 3apGR39Hzi8Sd8JQPzMycQJ_zRUaGT1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240024

On Thu, Sep 24, 2026 at 07:01:36AM +0200, Nihar Panda wrote:
> Set QDIO_IRQ_STATE_ACTIVE only if both the subchannel-active bit and
> the QDIO-active bit are set in the Subchannel Status Word (SCSW).
> 
> The channel subsystem sets the SCSW_ACTL_SCHACT bit in scsw.actl and
> scsw.qact = 1 in the SCHIB to indicate that the activate-QDIO-queues
> CCW program is running and the queues are ready.
> 
> An interrupt-driven approach is not applicable here.
> Using CCW_FLAG_PCI on the activate CCW generates an intermediate interrupt
> too early, before the firmware sets qact=1.
> Therefore, polling the SCHIB via cio_update_schib() is the only way to
> reliably detect when the queues are ready.
> 
> Signed-off-by: Nihar Panda <niharp@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Nagamani PV <nagamani@linux.ibm.com>
> ---
>  arch/s390/include/asm/scsw.h |  4 +--
>  drivers/s390/cio/qdio_main.c | 59 +++++++++++++++++++++++++++---------
>  2 files changed, 47 insertions(+), 16 deletions(-)

Unfortunately the cover letter does not mention what has changed
compared to the previous version. Also there seems to be a confusion
between versions. Cover-letter says v2, while the patch says v5.

In addition the code changed obviously. Is it ok to keep the Reviewed-by tags
from above which were given to a previous version of the code?

> -	/* wait for subchannel to become active */
> -	msleep(5);
> +	rc = -ETIMEDOUT;
> +	timeout = jiffies + HZ;
>  
> -	switch (irq_ptr->state) {
> -	case QDIO_IRQ_STATE_STOPPED:
> -	case QDIO_IRQ_STATE_ERR:
> -		rc = -EIO;
> -		break;
> -	default:
> -		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> -		rc = 0;
> -	}
> +	do {
> +		msleep(1);
> +		if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
> +			rc = -EIO;
> +			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
> +			break;
> +		}
> +		/* Query hardware */
> +		spin_lock_irq(get_ccwdev_lock(cdev));
> +		if (cio_update_schib(sch) == 0) {
> +			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
> +					&& sch->schib.scsw.cmd.qact) {
> +				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> +				rc = 0;
> +			}
> +		}
> +		spin_unlock_irq(get_ccwdev_lock(cdev));
> +		if (!rc)
> +			break;
> +	} while (time_before(jiffies, timeout));
> +	if (rc == -ETIMEDOUT)
> +		DBF_ERROR("%4x act TMOUT", irq_ptr->schid.sch_no);
>  out:
>  	mutex_unlock(&irq_ptr->setup_mutex);

As already mentioned in a previous comment: "worst case" is that this would
timeout after waiting only 1ms (+ preemption), compared to before where there
was a guaranteed minimum wait time of 5ms.
Is this change intended? Could this lead to regressions?
If this is intended it should be described.

Usually problems like this are avoided by retrying n times, instead of using a
fixed timeout value.
