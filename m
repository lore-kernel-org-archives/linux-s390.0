Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBD2D061C;
	Tue, 28 Jul 2026 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204510; cv=none; b=PNG2RxIOvoUrb3RgYTzViZ5BJzKqQZu2lmUglbpuV8GRHtyB98mwZW1WauR8cWDcrECcVdFBFjgsp6R2Dx3c//GA/7rbTHqrNb39tegGLSRLszXV0e0JTc6R+q8ujsXwALN8DykY3GGqMsTjyrC80HdXLq794INbb1YkCk2/8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204510; c=relaxed/simple;
	bh=IOzGXLPfCzn5XsPYl+Kw0fkPbufPqX5gl9GdNnBWDc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRt1nDzCLLBNbsX1sjWSZvrNnHtujtpXtJlYAy5I/noF2KvTECCAtuh5AKxa4mJLwdow1pNgKrUCxZRWART4A2hCtkGpPzcCBb8QFQ8AVL+jGZ/sEBqxNlfh31Fae5GcaXyOnjv3KfBmRBFWT3oap9B+PAaLwgXaIruerg8v0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j+WZmSFu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j+WZmSFu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0mFd43676360;
	Tue, 28 Jul 2026 02:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0049nx
	PdXq0xZl64ubOd4sPipMUSHINgMV+mVxLKa4k=; b=j+WZmSFuQ7aNvH4vtcVLLp
	2V3tmzdJ6WUqdEgwyDl4E3+Yx93F3plo3lfKHr2SXY9xgiZ76JvkYalOoK6C9fiD
	06MkuHr6nVne6SKMCwIDfIaVn6mNACVwUFIPlfP0Bn3B1KKzB8dFpIzBoufUKbbu
	n4bsUBDb2AuOeewywtj5bZk/0btK06gJxT97OHnugY5WtWhqAkqfUyB/TyT5Y1ac
	ysLmG57xKbeOZXl8sJDPVYlLjA9NqWSdiZMJD0r8w4AJ97qcRtveFwXTTc17AbIN
	rjOMOtVOS6J6H+BPpmCFT7jQi8a+tzYCFHL38GvWG/TpH9Vn/8nXYd0yel1T5YrQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj2g7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:08:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QOM8029301;
	Tue, 28 Jul 2026 02:08:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq814y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:08:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S28Oq818874922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 02:08:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFC3158052;
	Tue, 28 Jul 2026 02:08:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D8875805A;
	Tue, 28 Jul 2026 02:08:24 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 02:08:24 +0000 (GMT)
Message-ID: <3048391c-003a-4bde-84c9-e1eca0063766@linux.ibm.com>
Date: Mon, 27 Jul 2026 22:08:23 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX/W1tT7q4vRmH
 uKokzOdrIBdRcJnIwQm1pZGZ44qQwOY87jpWL+XdDD8xr1APCxOt+efVpAWC0nPIgt4Rhf/F25v
 52j/4PXuhvampD1LRfo22O0VI+Nk5aM=
X-Proofpoint-GUID: 92P_GnRWfZe9VQmJhuk8IjmWzBK7rN4D
X-Proofpoint-ORIG-GUID: 92P_GnRWfZe9VQmJhuk8IjmWzBK7rN4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX/ob26IHYgE/B
 FS8h3rmpdYqqzPV7eCpObK1G0z+jynCwJX/fcLXqMSWOQtO+L9ldbwQEFnomSDzDY7rBazhLKi8
 WSvgFDIwMEE6YMDAidIXfzVK81d0PK9Yr7US0raGDBeevwIr5IA6q+dQYxpA+qD2aay9T1Dmyrf
 eX1y1w4L8/EcpH8zu31LO7+Tf69VGUKo8/uaRLT/WO/LYtCpcB3y6Lz7koORqrQ2/djcDOqFsrY
 ZLrBVnzFUJsslM9hnR3uxsYB9BCkMCjObw1V93MDaqXXJHtQOUKFJQQ/qxNLp3yBBMNTNJAW7ow
 DA78zuNpmTuoXfit1q+O5Cnrj1r9FNO8X/eiIG/UADnlbDjwu7Prf3vi6QTZrjkLYkO5u9ZnED1
 KT4l6pDri7LFHbAHrF7x+vzhPHDXTwtgCKlMmfc298ytjGTzs/8Zz61gUl/hd0aD7XCGRLxqjD5
 mZHs0RzDizQQ5NiyhbA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a680f1b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2CkcZuEoo9mvoDp0OvwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280014

On 7/27/26 9:35 PM, Eric Farman wrote:
> The fsm_notoper() routine is called when the device has been
> lost, and is (by definition) no longer operational. Since this
> can happen asynchronously from the normal behavior of the
> driver, the cleanup may happen when holding other locks
> in the calling sequence (notably, the cio subchannel lock).
> 
> Push the cleanup of the private->cp resources to a workqueue,
> where it can be done out from under that lock sequence and
> safely under a common locking mechanism.

Nit: you mention 'safely under a common locking mechanism' but that
doesn't actually happen until next patch.

Maybe add something like 'so a subsequent patch can...'

> 
> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>  drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>  drivers/s390/cio/vfio_ccw_ops.c     | 6 +++++-
>  drivers/s390/cio/vfio_ccw_private.h | 3 +++
>  4 files changed, 18 insertions(+), 3 deletions(-)
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
> index bc8eb485d03f..1cca3ecdae45 100644
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
> @@ -133,7 +134,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  
>  	/*
>  	 * Ensure these work items are fully drained, so none can
> -	 * fire after being released.
> +	 * fire after being released. The notoper_work struct is
> +	 * only meaningful if the device had been opened, which
> +	 * means it would have been cleaned in an earlier close.
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> @@ -216,6 +219,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	flush_work(&private->notoper_work);

Sashiko found a path where you might never open/close, so I guess we
need to flush in both close and release after all?

I still think flush vs cancel to ensure that we process the cp_free()
work if it's pending else we risk leaking the cp resources.

I think this is the last issue of note, so this series is very close as
far as I'm concerned.

Thanks,
Matt

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

