Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0752429025;
	Mon, 27 Jul 2026 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189300; cv=none; b=WD0/moCvCcVTyjYQ1ODWZTNjecD+oHsykdasMdjoRFqzzO+IXi2LU2SPPL7U6c4Cv0sJCmgipNREg6LLiGmrQPpdhfFjh5KndOxiwCD8CxVN+fCEFs6WWCPNCKvQERKRvjqUGwuWW2phXv3/bTWSsrl454rsG7q5TIfaVUOX6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189300; c=relaxed/simple;
	bh=ww3zQkPQ4wSVhj4nDowj0LBRC3tmmw6bivV5LHLHcYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJIzZs9vKPeyreU5xQK06tM7Ld4e6utqxM9baeKdLMATqH+rZZTbWPKYA1gZsiR6oo7H6oE4eKEfJorcXY2hTc3ztaA4cday6z1fMcn1BSJz7f4/+DE4v0gWBl/SeRiAhh3XPcYteF8QbRIwkoBfXref7rvOI5rJrZJigCaj14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/p5XTfo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/p5XTfo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RLmBL23320564;
	Mon, 27 Jul 2026 21:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5U7HSI
	aARFY6jp+cTBGkcSB7nCg03lqbuj82eBpsf3Q=; b=s/p5XTfo7q/RNnfq46HsiT
	SU0Tk7RcY/gEzQTUqgVJ4uCyhq9CYO6rmIRGLLMfDTCH6ZCoRN4Ms2KMOKZKXCGz
	72x50/h19swJdombINA4jBq9b9ChggWNrwxpBDEf/HA3c7q/kAnp32D9JBsRnLZ6
	/mXX2mw9676DgeiUqM6grpJDnf41mHXXDL5lNWqkQ9LX3x6iAswcpTpiXG8nzly4
	msY3JH+U3EoGny8+fS0ePZRvI8fdN6b3QmRPfXd5eJxiDDw5UxbhgA4UcXcb2qFw
	PwQgeSKYDtkd+VxjkZ01KVazN6+f/WjkdpIuzOvdgz9w5fO2sMLQH7i/jJkOgrtw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj1rvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:54:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RLfarj001726;
	Mon, 27 Jul 2026 21:54:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq7anm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 21:54:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RLsrDW28967476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 21:54:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD4FA5805A;
	Mon, 27 Jul 2026 21:54:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49FD058052;
	Mon, 27 Jul 2026 21:54:53 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 21:54:53 +0000 (GMT)
Message-ID: <1819d316-62b9-48c7-abaa-f40681e22abf@linux.ibm.com>
Date: Mon, 27 Jul 2026 17:54:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-9-farman@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260727192230.2715207-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX1dq3HIHLJ5sv
 Pq8pKcr+HBidr4hO2o5gKXN+84JlTyhS4U2n0wjKmXbLlzFwKgOv/UOjesupIr12bKQAb0VpIwT
 Kp2Tduv4xs0eYonFDvoX7l9B8oVxRO8=
X-Proofpoint-GUID: sq_oiCZzpLJ_NJS1Jx2YdNU_5lb3Jl2v
X-Proofpoint-ORIG-GUID: sq_oiCZzpLJ_NJS1Jx2YdNU_5lb3Jl2v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5NiBTYWx0ZWRfX9V5IsByxDCpt
 +MV+LxF9eO/YTtEFmE3uXqZoCeEDTC605IUbsOu9LR5dd3PwvJJWdaJgZWBHkoDRXnp+ojgHk0a
 /p+JWmFGBobTYZZ+SFtYpX0KZX+K30kKl4ayy3unbN8qseQInTtwa2ocaxzhe10Nd7kb0OsmgG1
 cYWL1bVJAxEHoYK2atk7XSXdMxGZL7vN3af/1BhUs8cVpK0gvHzIdmNatNWFCBfucw/fqJQSR8G
 iJK4ehtoaN9zQu9V0BsHKO5tFxzC/Yw/DMIszLgkjsOB5TkXzh1MsE7vtGLvlltFpluuhwjaLw3
 ZySZ6FPJ1XnMWWH2ve1zmjUjVsZ5C5GCYHKzIQ9PFabNfVRyOpDOBdBMr15WLjDtqPXI1DladYL
 VKf4PEWBdkuDljjICKNduhR3s+GgoMvIL2XXvcH+GHSqhlQ31X7+hQw4tZa8/OWVPAPPbQI9y5l
 WY0M1xpQCBfwefi4AHg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67d3b0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2CkcZuEoo9mvoDp0OvwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_06,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270196

On 7/27/26 3:22 PM, Eric Farman wrote:
> The fsm_notoper() routine is called when the device has been
> lost, and is (by definition) no longer operational. Since this
> can happen asynchronously from the normal behavior of the
> driver, the cleanup may happen when holding other locks
> in the calling sequence (notably, the cio subchannel lock).
> 
> Push the cleanup of the private->cp resources to a workqueue,
> where it can be done out from under that lock sequence and
> (soon) under its own serialization mechanism.

This part of the commit message needs updating now that you are not
introducing a cp_mutex.

> 
> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>  drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>  drivers/s390/cio/vfio_ccw_ops.c     | 3 +++
>  drivers/s390/cio/vfio_ccw_private.h | 3 +++
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 1a095085bc72..c197ad5ab580 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>  		eventfd_signal(private->crw_trigger);
>  }
>  
> +void vfio_ccw_notoper_todo(struct work_struct *work)
> +{
> +	struct vfio_ccw_private *private;
> +
> +	private = container_of(work, struct vfio_ccw_private, notoper_work);
> +
> +	cp_free(&private->cp);
> +}
> +
>  /*
>   * Css driver callbacks
>   */
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 4d7988ea47ef..4d47a3c7b9a0 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state = VFIO_CCW_STATE_NOT_OPER;
>  
> -	/* This is usually handled during CLOSE event */
> -	cp_free(&private->cp);
> +	queue_work(vfio_ccw_work_q, &private->notoper_work);
>  }
>  
>  /*
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index bd488e40e153..8ec6b175d991 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -54,6 +54,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
>  	INIT_LIST_HEAD(&private->crw);
>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>  	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
> +	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
>  
>  	private->cp.guest_cp = kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
>  	if (!private->cp.guest_cp)
> @@ -139,6 +140,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  	/* Should be empty, but just in case */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	cancel_work_sync(&private->notoper_work);

Sashiko mentions (and I agree) that you can accidentally leak the cp
resources if you manage to cancel the pending notoper_work before it runs.

Since you are not running on a workqueue thread, it should be OK to
flush instead to make sure that the pending item is executed.

A subsequent cancel should not be necessary, since we know that only 1
instance of vfio_ccw_notoper_todo() will ever be queued because we queue
it on the first time the device goes NOT_OPER.  Based on the FSM, once
the device goes NOT_OPER, subsequent transitions into NOT_OPER are
treated as a NOP and there is no way to transition to a different state
other than NOT_OPER until the device is released, so you can't go from
NOT_OPER->x->NOT_OPER.

Would probably be good to include a (less verbose) comment to that
effect along with the flush.

>  
>  	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
>  	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
> @@ -209,6 +211,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>  
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	cancel_work_sync(&private->notoper_work);
>  
>  	vfio_ccw_unregister_dev_regions(private);
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 0501d4bbcdbd..e2256402b089 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -102,6 +102,7 @@ struct vfio_ccw_parent {
>   * @req_trigger: eventfd ctx for signaling userspace to return device
>   * @io_work: work for deferral process of I/O handling
>   * @crw_work: work for deferral process of CRW handling
> + * @notoper_work: work for deferred processing in not-operational state
>   */
>  struct vfio_ccw_private {
>  	struct vfio_device vdev;
> @@ -125,11 +126,13 @@ struct vfio_ccw_private {
>  	struct eventfd_ctx	*req_trigger;
>  	struct work_struct	io_work;
>  	struct work_struct	crw_work;
> +	struct work_struct	notoper_work;
>  } __aligned(8);
>  
>  int vfio_ccw_sch_quiesce(struct subchannel *sch);
>  void vfio_ccw_sch_io_todo(struct work_struct *work);
>  void vfio_ccw_crw_todo(struct work_struct *work);
> +void vfio_ccw_notoper_todo(struct work_struct *work);
>  
>  extern struct mdev_driver vfio_ccw_mdev_driver;
>  

