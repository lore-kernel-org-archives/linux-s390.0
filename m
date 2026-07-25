Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662C388E5B;
	Sat, 25 Jul 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784999088; cv=none; b=CmAn4l9GVehN552LQfEvbUOH92URC9JoJuP8IzvS8L1GrhitV564NDSPw2al4tFUsF+3qkcARXNGLDKAHMrVL515E3n3eiC+CJFgS0zf7iqfLcds+kF5Ws9vISnqHon8vyv/IvLg8VOdzcSv10sF6W+dsSmeUZ51XdqClMV26js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784999088; c=relaxed/simple;
	bh=+fx1+j5fDhYbIUsoUTBaHhxS3HKJWGe8bqnjyUcZ62g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4pceMwdFwF+20gK+Ydn/c294JxCEz+jepHfoKxQ15Yw4Fx4ZpZl+BvobIlYMRQeI+0zcF/mMFskRSAC77Plv+zyVHVIzgsf46ukd+Zy6jOo6IpHxCcp7GMywSFDdV0AMLuAXit3agE6P3q6O/jGcUfzvYSX1jKd/R4F59mTA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MinSP9wJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MinSP9wJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlaV9815207;
	Sat, 25 Jul 2026 17:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ay9Bxw
	XBcVd4f5ahs/uQka5+ZZZpLyKTk9bNaw+rijs=; b=MinSP9wJ7NirxHtdrY7+f1
	AW2aDbo49AvZE/q088zAslyxHvuCLRu+64xlDQe/0CdqN8k8FtB7zO7PKg9VSlbb
	DbX85zuakL2VeRbcK1LrQE45+Rroypx1WUThh89pCyhLfK7VVClubTdVmeEshaWV
	6PRWGdQDNk0Q/+g0/X49z0YojY8g4ud7QXTMsYgJtq3GkWyhGBdUE1QC22UD7j2l
	aQ3nakfCz7MDV0+YF8/8hmrRzQd4oGQU3Y9KZDnd0+ER/FFFD5lxexeL7LQPuiW+
	hDGrJzjTZ75CQRp5j739ICph0+v1BK4aLl71+c10mnz9H9MfLmvz9Ktm1VGv/nYw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x8tst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:04:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PGfDQQ032058;
	Sat, 25 Jul 2026 17:04:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9wmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 17:04:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PH4gcT53870884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 17:04:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E44358057;
	Sat, 25 Jul 2026 17:04:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3A5E58059;
	Sat, 25 Jul 2026 17:04:41 +0000 (GMT)
Received: from [9.61.125.168] (unknown [9.61.125.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 17:04:41 +0000 (GMT)
Message-ID: <845a7809-4009-4199-b35f-ff08aaeb0336@linux.ibm.com>
Date: Sat, 25 Jul 2026 13:04:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] s390/vfio_ccw: implement a channel program mutex
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uwx06w_cqhmyXzkp0yLKxP4QsHY0p2Yk
X-Proofpoint-ORIG-GUID: Uwx06w_cqhmyXzkp0yLKxP4QsHY0p2Yk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE1OSBTYWx0ZWRfX+GMHaotSg1jH
 auxsOqqVTvx4VZHX2N7hoKOFrQrWy6iynX0qF8VQJxI9LybAuMO/+F0M3XPoRHFxCln4sfduvxe
 IKlr+rST+wNHy3OdJZI9FzwsoTFLcBo=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64ecad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=GmbE4a3rjE6j2juYKq4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE1OSBTYWx0ZWRfX8Atne76cv4Zw
 nzbSv1+JN8UZOSl/lrzUveSSIyVn5Ldm4BJ52P52EuSjz17UbOsAtFnSShC5CQmThtppd+BqbmT
 +JCJGhCgSSFraEHz4Q30eIwHIqK+Ipse8q2OzD1dgksQQCrNn6POK86PyfBvzHzuJbq6GsO1VDJ
 OuO9I11DayqB1Bk1Avdt/e3KslsRcVNg+YdJV92Avq8rwj4hcGAbaCtwta/RVT5rBFrwTVDlkUL
 rG9ybSb6gmP9sqy6Ao1DSGui1gRN7vRZYyVIdjOBNTLGnIUcQd446Xzmj41sFWOEvEe37mcD8gX
 X7ndw1JWpzqWU4zin+Yn5eZmgx6aSg+0VYFdsMsqqZJuSYbhkDfAhHMd8KZJsK1U0oMofNYMG8E
 X7fWCQzMr53c/oJUKd9HOKoJpBxNaQDwa360VfJk3BpJsI5nxIspRovD5fKh0E/5GyjOOX1RlDB
 7MqlTViya9Pb+1OnFyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250159

On 7/25/26 11:27 AM, Eric Farman wrote:
> The channel_program struct is manipulated without a serialization
> mechanism to ensure consistent behavior. Take a broad stroke of
> putting the entire structure behind a mutex, and ensure everything
> that needs private->cp holds this mutex.
> 
> There are a couple where the cio layer's subchannel->lock performs
> this role in this code, which isn't correct (it should only be used
> when touching the actual subchannel, like cio_enable_subchannel()),
> so adjust the locations where that spinlock is acquired/released
> to correctly coexist with this new mutex.
> 
> Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c      | 30 +++++++++++++++++++++++++----
>  drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++++
>  drivers/s390/cio/vfio_ccw_fsm.c     | 20 ++++++++++++-------
>  drivers/s390/cio/vfio_ccw_ops.c     | 10 +++++++++-
>  drivers/s390/cio/vfio_ccw_private.h |  3 +++
>  5 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 5ef082b8289a..ab66caff9894 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -738,12 +738,15 @@ static int ccwchain_fetch_one(struct ccw1 *ccw,
>   */
>  int cp_init(struct channel_program *cp, union orb *orb)
>  {
> -	struct vfio_device *vdev =
> -		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
> +	struct vfio_device *vdev = &private->vdev;
>  	/* custom ratelimit used to avoid flood during guest IPL */
>  	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
>  	int ret;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	/* this is an error in the caller */
>  	if (cp->initialized)
>  		return -EBUSY;
> @@ -784,11 +787,14 @@ int cp_init(struct channel_program *cp, union orb *orb)
>   */
>  void cp_free(struct channel_program *cp)
>  {
> -	struct vfio_device *vdev =
> -		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
> +	struct vfio_device *vdev = &private->vdev;
>  	struct ccwchain *chain, *temp;
>  	int i;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	if (!cp->initialized)
>  		return;
>  
> @@ -841,11 +847,15 @@ void cp_free(struct channel_program *cp)
>   */
>  int cp_prefetch(struct channel_program *cp)
>  {
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	struct ccwchain *chain;
>  	struct ccw1 *ccw;
>  	struct page_array *pa;
>  	int len, idx, ret;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	/* this is an error in the caller */
>  	if (!cp->initialized)
>  		return -EINVAL;
> @@ -883,10 +893,14 @@ int cp_prefetch(struct channel_program *cp)
>   */
>  union orb *cp_get_orb(struct channel_program *cp, struct subchannel *sch)
>  {
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	union orb *orb;
>  	struct ccwchain *chain;
>  	struct ccw1 *cpa;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	/* this is an error in the caller */
>  	if (!cp->initialized)
>  		return NULL;
> @@ -931,10 +945,14 @@ union orb *cp_get_orb(struct channel_program *cp, struct subchannel *sch)
>   */
>  void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>  {
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	struct ccwchain *chain;
>  	dma32_t cpa = scsw->cmd.cpa;
>  	u32 ccw_head;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	if (!cp->initialized)
>  		return;
>  
> @@ -977,9 +995,13 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>   */
>  bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
>  {
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	struct ccwchain *chain;
>  	int i;
>  
> +	lockdep_assert_held(&private->cp_mutex);
> +
>  	if (!cp->initialized)
>  		return false;
>  
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index c197ad5ab580..4830f0dd9c3a 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -91,6 +91,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  
>  	is_final = !(scsw_actl(&irb->scsw) &
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> +
> +	mutex_lock(&private->cp_mutex);
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
>  		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
> @@ -98,6 +100,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  			cp_is_finished = true;
>  		}
>  	}
> +	mutex_unlock(&private->cp_mutex);
> +
>  	mutex_lock(&private->io_mutex);
>  	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
>  	mutex_unlock(&private->io_mutex);
> @@ -131,7 +135,9 @@ void vfio_ccw_notoper_todo(struct work_struct *work)
>  
>  	private = container_of(work, struct vfio_ccw_private, notoper_work);
>  
> +	mutex_lock(&private->cp_mutex);
>  	cp_free(&private->cp);
> +	mutex_unlock(&private->cp_mutex);
>  }
>  
>  /*
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 4d47a3c7b9a0..cefdfcb0cad7 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -25,17 +25,15 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>  	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(&sch->lock, flags);
> -
>  	orb = cp_get_orb(&private->cp, sch);
> -	if (!orb) {
> -		ret = -EIO;
> -		goto out;
> -	}
> +	if (!orb)
> +		return -EIO;
>  
>  	VFIO_CCW_TRACE_EVENT(5, "stIO");
>  	VFIO_CCW_TRACE_EVENT(5, dev_name(&sch->dev));
>  
> +	spin_lock_irqsave(&sch->lock, flags);
> +
>  	/* Issue "Start Subchannel" */
>  	ccode = ssch(sch->schid, orb);
>  
> @@ -71,7 +69,6 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>  	default:
>  		ret = ccode;
>  	}
> -out:
>  	spin_unlock_irqrestore(&sch->lock, flags);
>  	return ret;
>  }
> @@ -251,6 +248,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	private->state = VFIO_CCW_STATE_CP_PROCESSING;
>  	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>  
> +	mutex_lock(&private->cp_mutex);
> +
>  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>  		orb = (union orb *)io_region->orb_area;
>  
> @@ -299,6 +298,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  			cp_free(&private->cp);
>  			goto err_out;
>  		}
> +
> +		mutex_unlock(&private->cp_mutex);
>  		return;
>  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>  		VFIO_CCW_MSG_EVENT(2,
> @@ -319,6 +320,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	}
>  
>  err_out:
> +	mutex_unlock(&private->cp_mutex);
>  	private->state = VFIO_CCW_STATE_IDLE;
>  	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
>  				      io_region->ret_code, errstr);
> @@ -409,7 +411,11 @@ static void fsm_close(struct vfio_ccw_private *private,
>  
>  	private->state = VFIO_CCW_STATE_STANDBY;
>  	spin_unlock_irq(&sch->lock);
> +
> +	mutex_lock(&private->cp_mutex);
>  	cp_free(&private->cp);
> +	mutex_unlock(&private->cp_mutex);
> +
>  	return;
>  
>  err_unlock:
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 6c74d596be9d..9242a37677a0 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -38,8 +38,13 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vdev, u64 iova, u64 length)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  
>  	/* Drivers MUST unpin pages in response to an invalidation. */
> -	if (!cp_iova_pinned(&private->cp, iova, length))
> +	mutex_lock(&private->cp_mutex);
> +	if (!cp_iova_pinned(&private->cp, iova, length)) {
> +		mutex_unlock(&private->cp_mutex);
>  		return;
> +	}
> +
> +	mutex_unlock(&private->cp_mutex);
>  
>  	vfio_ccw_mdev_reset(private);
>  }
> @@ -50,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
>  
>  	mutex_init(&private->io_mutex);
> +	mutex_init(&private->cp_mutex);
>  	private->state = VFIO_CCW_STATE_STANDBY;
>  	INIT_LIST_HEAD(&private->crw);
>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
> @@ -91,6 +97,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>  out_free_cp:
>  	kfree(private->cp.guest_cp);
>  out_free_private:
> +	mutex_destroy(&private->cp_mutex);
>  	mutex_destroy(&private->io_mutex);
>  	return -ENOMEM;
>  }
> @@ -142,6 +149,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>  	kmem_cache_free(vfio_ccw_io_region, private->io_region);
>  	kfree(private->cp.guest_cp);
> +	mutex_destroy(&private->cp_mutex);
>  	mutex_destroy(&private->io_mutex);
>  }
>  
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index e2256402b089..b595fd81f370 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -94,6 +94,7 @@ struct vfio_ccw_parent {
>   * @schib_region: MMIO region for SCHIB information
>   * @crw_region: MMIO region for getting channel report words
>   * @num_regions: number of additional regions
> + * @cp_mutex: protect against concurrent update of CP resources
>   * @cp: channel program for the current I/O operation
>   * @irb: irb info received from interrupt
>   * @scsw: scsw info
> @@ -116,7 +117,9 @@ struct vfio_ccw_private {
>  	struct ccw_crw_region	*crw_region;
>  	int num_regions;
>  
> +	struct mutex		cp_mutex;
>  	struct channel_program	cp;
> +
>  	struct irb		irb;
>  	union scsw		scsw;
>  	struct list_head	crw;

