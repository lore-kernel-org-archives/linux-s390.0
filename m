Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016873002D8;
	Fri, 24 Jul 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924340; cv=none; b=ZQOMM02GM3+eqcoiL6wVq+Qe1lUT4Mf8T8tUnGeQ3h3pe/8beRCWwaF3C2pYybu1CLGYcS+C/I/T0OR6bkK8wYjHKkpChy+J8yi2RiAupXPNqaorG64wShgGaFR4BL8xAr4PBQjtchoPs5Jq/hv13B0QwPTrbnNcMlhokrZ5x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924340; c=relaxed/simple;
	bh=JBcHnp1qYKen7leiMjdMXdS/msmNnYmjXkKYO0zX5iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDemKyxhkeATa+JdvBARR47Hdu2XSHV2GhjZXmrHJK2WvZWWdJKYlUYhYw2dpKdPrhJmsTWYSE6B1KZ2A+YK0YO/FSDRpDghnWXlHSu2gOcP1bN4FhC94T1w6VN7BDgUM9p+hZHk4bJPG3OZym5QiYOItBeE6R37bJb/DKXnjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qo8ex0Cx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qo8ex0Cx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHCRXj2452454;
	Fri, 24 Jul 2026 20:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uf9zCP
	3+cQweg2Io7movz533SBw0Gp+cLkGpXN3RDxk=; b=qo8ex0CxYN8bEKuTh2F5BO
	ya4rfKhXhFHjh/vALmw62cwdpFh6MeCdN0w3eh22OeG3c8j2UYkOlbvQwA8IEZjh
	aYSvlHRcfR/dBlTRi9FygfKNda4ZfCjQjQBjPPW/CGhEb1vPgREzSljUI6pHHgDP
	dj/peRUUupy4lkS6b4+QIiAOT1FShJR8nJdmtNDyDXc5+kWvDLC+qG1RpSvbVh+y
	NQP8prCcAYJD2/+unYq4DlEG6BB8G4KCQA3CFBwtw6wu3vYTAkvZP58qt8gpVRmX
	LLu8FZfr+TmUTc9LI4VWTwbAs0Bh/8Cm8uMENghnMdbsZciibngx6BA1FHWVfDUA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahnu66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:18:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OK4aeR019490;
	Fri, 24 Jul 2026 20:18:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyt8fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 20:18:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OKItCU25952850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 20:18:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50DCD58045;
	Fri, 24 Jul 2026 20:18:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724E558054;
	Fri, 24 Jul 2026 20:18:54 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 20:18:54 +0000 (GMT)
Message-ID: <fa86ee74-1d36-4e14-a015-91599d4d0fa4@linux.ibm.com>
Date: Fri, 24 Jul 2026 16:18:53 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] s390/vfio_ccw: implement a channel program mutex
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hbyz8xnUCJ9aO1rl7f-06_nh6NcFsNtq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE4MSBTYWx0ZWRfX6HbMmXCgFtw2
 kgKLHyccAr7IcvTu/dmXApsgC218maPE54vY5WhCwjKwCOiQiXbyNjHTuT2my6YvxjVnZYw0kUU
 s0S3zMKQOz960Bn+NZOevK8jwckwgcpz8SYOG6DZi85u7rV605g9BDvzqtiDAWuAQbboOgmxd0U
 6XvSBddnqlsb2xP/bBSr0UEML09rpOYHE/tlew4Vhlgji0th6r1DmtZHEsI/qalitPARxfxidDt
 g6sSmdywiNsYFIoRH5rriTfijqNjt4ILtyFy/Dwyiwe6ts6Ny3epTxI2xt148xFHDoHzpyl2M6x
 c3bdqFQbs+fIzu1CpVE8cyTWMaDEjYTWnVNMiILFPSGebPjnGquBXzFY98uFD2Tzvd1P3MURvLx
 eLnZAljqtgm6cFHcLhQtfe2CMLJzeebpr2cqS+fe829J+EndvFWmi6l45Q3u64eXrGgxhGb5mU/
 UAMCSKymNcYqUGmM5Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE4MSBTYWx0ZWRfX8XlVg2nYUJ5m
 PdczgysnxBwDxFyWnwb69bwCvOK+cTCq4ctUXkB96ji/OWNg373MJRiiwRM7dO0+qcocVyyotO2
 j1bqHY3OrCuxkxuk3s0USNsz2Xt4bUY=
X-Proofpoint-GUID: Hbyz8xnUCJ9aO1rl7f-06_nh6NcFsNtq
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63c8b1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gFTwVeD1yrmUlQk_w58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240181

On 7/23/26 1:47 PM, Eric Farman wrote:
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
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 10 +++++++++-
>  drivers/s390/cio/vfio_ccw_fsm.c     | 22 +++++++++++++++-------
>  drivers/s390/cio/vfio_ccw_ops.c     | 10 +++++++++-
>  drivers/s390/cio/vfio_ccw_private.h |  3 +++
>  4 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 1a095085bc72..1d8c2ed9da50 100644
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
> @@ -259,12 +263,16 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
>  	rc = 0;
>  
>  	if (cio_update_schib(sch)) {
> -		if (private)
> +		if (private) {
> +			spin_unlock_irqrestore(&sch->lock, flags);
>  			vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
> +			goto out;
> +		}
>  	}
>  
>  out_unlock:
>  	spin_unlock_irqrestore(&sch->lock, flags);
> +out:
>  
>  	return rc;
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 4d7988ea47ef..9fbe97bd23f9 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -25,17 +25,15 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
>  	unsigned long flags;
>  	int ret;
>  
> -	spin_lock_irqsave(&sch->lock, flags);
> -
>  	orb = cp_get_orb(&private->cp, sch);

Can you extend the documentation for cp_get_orb to indicate that
cp_mutex must be held on entry?

Actually, better yet, can you use lockdep_assert_held()?

Would be a good idea to put these also in other functions that have now
an implicit expectation that the mutex will be held, here's the list I
came up with?

cp_get_orb
cp_init
cp_prefetch
cp_free
fsm_io_helper
cp_iova_pinned	
cp_update_scsw

In some cases (like cp_get_orb) you'd have to do something like:
    struct vfio_ccw_private *private = container_of(cp, struct vfio_ccw_private, cp);
    lockdep_assert_held(&private->cp_mutex);

Then this lets us also use lockdep to make sure the mutex is OK now
and in the future.

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
> @@ -171,7 +168,9 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>  	private->state = VFIO_CCW_STATE_NOT_OPER;
>  
>  	/* This is usually handled during CLOSE event */
> +	mutex_lock(&private->cp_mutex);
>  	cp_free(&private->cp);
> +	mutex_unlock(&private->cp_mutex);
>  }
>  
>  /*
> @@ -252,6 +251,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	private->state = VFIO_CCW_STATE_CP_PROCESSING;
>  	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
>  
> +	mutex_lock(&private->cp_mutex);
> +
>  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>  		orb = (union orb *)io_region->orb_area;
>  
> @@ -300,6 +301,8 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  			cp_free(&private->cp);
>  			goto err_out;
>  		}
> +
> +		mutex_unlock(&private->cp_mutex);
>  		return;
>  	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
>  		VFIO_CCW_MSG_EVENT(2,
> @@ -320,6 +323,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	}
>  
>  err_out:
> +	mutex_unlock(&private->cp_mutex);
>  	private->state = VFIO_CCW_STATE_IDLE;
>  	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
>  				      io_region->ret_code, errstr);
> @@ -410,7 +414,11 @@ static void fsm_close(struct vfio_ccw_private *private,
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
> index 032a1cdf4df7..04800cfa779b 100644
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
> @@ -90,6 +96,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>  out_free_cp:
>  	kfree(private->cp.guest_cp);
>  out_free_private:
> +	mutex_destroy(&private->cp_mutex);
>  	mutex_destroy(&private->io_mutex);
>  	return -ENOMEM;
>  }
> @@ -141,6 +148,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>  	kmem_cache_free(vfio_ccw_io_region, private->io_region);
>  	kfree(private->cp.guest_cp);
> +	mutex_destroy(&private->cp_mutex);
>  	mutex_destroy(&private->io_mutex);
>  }
>  
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 0501d4bbcdbd..ac5aaa78a74b 100644
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
> @@ -115,7 +116,9 @@ struct vfio_ccw_private {
>  	struct ccw_crw_region	*crw_region;
>  	int num_regions;
>  
> +	struct mutex		cp_mutex;
>  	struct channel_program	cp;
> +
>  	struct irb		irb;
>  	union scsw		scsw;
>  	struct list_head	crw;

