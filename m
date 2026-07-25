Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BE3B19A3;
	Sat, 25 Jul 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784997608; cv=none; b=AYQDIn3rFhW1UdDJzbGixZ1PllbxpufdS3sKkaIypBja8uhR9N7AJePmSHVD95f64LhegyPeMcpbdM5FURv1CWqDAyj+tNFYCKh6CinNCV7ZfLVxOHuUROrFXR5A60dcCYVxWmKYrvHQlAwKDa8OsQkANhRvDXZAnpjTzA5syns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784997608; c=relaxed/simple;
	bh=QFWkMglrIhTSwgwjN41QuI3geHpw7No7ZOtdrR/pHek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhlrtXBkKqOE6CbWnUhy9yrhT2xd71iw6phAim8iDXL0Y64jSboN/wunnc320U8JOiOevYC8Smu9W+g18NB/3ydrxfh9avyaXtNzNsQDzcWhqD8b0fkcPwvoVbKnF4ipUyU5imBbgB4iOTs0IwzyRLQQgK4Ch3mtZhqj+z9454g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nliym8yB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nliym8yB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDmFmr3117956;
	Sat, 25 Jul 2026 16:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3ka+LI
	URGLnxX8j1pPtvfRf8Y8hG5KD+DicG0yxeULs=; b=nliym8yB/4LTbG/BNHkvv7
	VPDEnKxMcX4r+mFcdKGvL6QgXZUoEGUnbcLypWhVsjsouvTnBhtZMrHNT0KTd8Y+
	EtQ9QkxP6u1m3WSzdmwCzPhFeGLNvLPvFQF2TlBkE7go5SOndWmRhH+MMDpLc9hO
	k4p5BrjCZwD2kRity9AZYEYXKxHe8ujUZSXqH1CtdaupzBZP+/V4fs4XN/F1xVzY
	vfNorGWrd7yHymnuzAa/ZPdsSgl5WhYVzUh2PxmR70z1SKCevgrVQfam5Vw9p9RE
	Z4Ztp27MhTt3pKnWRG8k2MkPCq3Ndl4XZWNp7sEIJEWvF0yOikEUhoAAQUvNIF2Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0rvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:40:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PGQIaB021769;
	Sat, 25 Jul 2026 16:40:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn1u1uws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:40:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PGdNS428377640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 16:39:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23CF958058;
	Sat, 25 Jul 2026 16:39:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CF1558057;
	Sat, 25 Jul 2026 16:39:58 +0000 (GMT)
Received: from [9.61.125.168] (unknown [9.61.125.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 16:39:58 +0000 (GMT)
Message-ID: <685bd45f-379e-4878-b76a-6c7a13f1c036@linux.ibm.com>
Date: Sat, 25 Jul 2026 12:39:58 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXxDusa_XfUgDxXaOPuj6aBCHRCZUP1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE1NCBTYWx0ZWRfXxv/R22NOljok
 XxF6ZOgytnHCTZ3rfjXPQAWZZdR9gnTo+rHocEFmnA33IE5urVD2Q+1fAvmnjWD5sZmZaAPAyiQ
 6OTd8oYirdeQhocnzcnGAthjq7ER0EUAJ0WfTDw4XBFqwbH2mMP8SnfJ21bsuvmYl0F7BN3F5/s
 uXlu8TNTTkeV5qa+Tvn1CrQlx/si0PQI2ssB4yEoZl7+INCCzxtqPmlBa6FeLGHfF6+Fz1nR9aL
 Z2rFOP0ctOBWnhkB1oJB8IbqCm3G5s+t27EBvRPmV+LIxt+zu71IiBn5fQd0H7aKsuai2hJ3XWm
 IfBgzeHqcChUkzuB+rFX1GYEZOz/8ILGKNRSxEhnTVGII6iXlrH4GxOTfd/5/DhR437cAG+ULiv
 Pn3qBuA+qXgzSCFSlfIZNyz2xYCEygk6Tu4NMQVFR4lasM4izGPS1KzNDHE0Cf7UGV5OYBXR2Ii
 Pp1J5hVnI0FGseO4seg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE1NCBTYWx0ZWRfX0QKs8gyWGabT
 2p22a/usBW/kALpXmcDwJhNaD8kw0WlldT6kB65mQX5vF87+16pFVCNx14xIF+CmseBtpjWvnNN
 j8frwOzzq/NjlWEP6x420IYatjst1jk=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64e6e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3NM-aQxfNb8fiyjzp1cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HXxDusa_XfUgDxXaOPuj6aBCHRCZUP1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250154

On 7/25/26 11:27 AM, Eric Farman wrote:
> The fsm_notoper() routine is called when the device has been
> lost, and is (by definition) no longer operational. Since this
> can happen asynchronously from the normal behavior of the
> driver, the cleanup may happen when holding other locks
> in the calling sequence (notably, the cio subchannel lock).
> 
> Push the cleanup of the private->cp resources to a workqueue,
> where it can be done out from under that lock sequence and
> (soon) under its own serialization mechanism.
> 
> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Doesn't this need a cancel of the workqueue before the vfio_ccw_private
gets freed, maybe in vfio_ccw_mdev_release_dev()?
> ---
>  drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
>  drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
>  drivers/s390/cio/vfio_ccw_ops.c     | 1 +
>  drivers/s390/cio/vfio_ccw_private.h | 3 +++
>  4 files changed, 14 insertions(+), 2 deletions(-)
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
> index 032a1cdf4df7..6c74d596be9d 100644
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

