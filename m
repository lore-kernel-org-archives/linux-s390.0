Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AA2EC083;
	Tue, 28 Jul 2026 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250104; cv=none; b=Iaf4YYsnzRWHpLPohShzYFq421bX2GdzyJBnxIaTkJi7ynuwkzTz3xtaD3Fa0v6sZh6cRARJRddEzcglNcDPsaxslp8136eYlx2TyNXRdBtUvxOMIp+GecGJG+MPlwPJBG9t9mTYKOD/Z9NRnR7DXUw6ZVDaJsCt1fpKo4uipl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250104; c=relaxed/simple;
	bh=A6eYCzjCgU8RlxoXsZ9fTx79XXkPiMAZr690OcQu0rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeCatbd9hfwT7aAcf88h6g5cbB7CCK+xKkkKHHUNUUjwFM10gN+M0CRg9BharaAEi7WcZ684gi1WL7tPmlB0md8JUDE7bCX7vX/CClONjiox4KIChoKGaH0WIxRuSvqKXrUA1gIYncxVHteUZMG81Zx3yeM04GyY4U17aYWBxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7+Vbryh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7+Vbryh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SElgYx1380160;
	Tue, 28 Jul 2026 14:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yAqdzV
	tVmduMiLL9KAWAa/1GKZv/e5nZ3CqxmuyZbvk=; b=H7+VbryhopHn6aCaEz4LPN
	eiGlUkFLJvgw/vUcJGCiqgDg1NFzgiLGtnLETMdkvlneEaKn80o9KxwefUP3skiu
	/l3b7zqEZu2gBnyy7Ns80gQLyJXqNMQXeLlmBJlzEvO+9QSWhdyv08JC/XRYFbxS
	wwCcDufhnPeABU+kI4OBBshO+Lw3AwEHLfmBjEzd11hDIn0D1y4zPXbqvH0hHFxl
	VAKsRkOtbKPqevJWkP7Es/JloYctojfrmzRajoLjc9ybLNsUiN/HulvSTLuOwg2G
	TX7u71uqqPzaf0lJKX+zSLMpHfYlgZo3wBiPlwuslT8/4VGmM1AsDSzb9rgFfKzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj56m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:48:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEfbes024220;
	Tue, 28 Jul 2026 14:48:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y21cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:48:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEmKWi23593550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:48:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14BA35805E;
	Tue, 28 Jul 2026 14:48:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D03458052;
	Tue, 28 Jul 2026 14:48:19 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 14:48:19 +0000 (GMT)
Message-ID: <210fe174-f1f5-49f0-a5f9-77084bddb976@linux.ibm.com>
Date: Tue, 28 Jul 2026 10:48:19 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX/OOVK4MbXbMD
 Ox6xcgI/aYGrMqpWeOnqQGvGmUnsqcB97JpXhQC8DCI0cV2EHdpTUNdordo2M8bVA53L4h3IFx/
 HajJpQuY3DICcsbld53N9UUqMR6PiZA=
X-Proofpoint-GUID: kpUqODpdq3uyBjRn8KWA6ZUjLruUQW_m
X-Proofpoint-ORIG-GUID: kpUqODpdq3uyBjRn8KWA6ZUjLruUQW_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfXwbDlaNtCEXjh
 KOVqF4Y2PYPgR7l4b5BZNUTlbEXcW7ZHpso6RqRfzpfKPTbIPDHgWdeQ6rZuygKoprMa6LdvEiZ
 kzrUO74G8nwSD3YdpFliZbjc1dUMZvMzAxn4a5WN2M/7R/qhx/IY8A44LolTSG219O1NcclNZAp
 FJChesACqVRCm5xrlzhqzaCGJFfslKdUE/xOAQi1B7tTWpYD4srKUfPtJAW6PsblWyMwK8lBUPf
 o7jVOFezzvC9cMwMa0Q3CbXlUS5SH+nG97jrrSMkhKE5L4WD+adbcOIW7k1nOfiKmORQL4WJZ54
 AyQaH58wSNEfX+/ZcByqyTKOoahN5OXAxinsW9MJJAHfnIbLhcRce1HwI1KjEcl3wl0JmwAJyic
 wUuXl52tt0Ru8x/Sg+0ajyIfvjnFLSz9G5u3vFdx4Hgciips7ElL+KIe0J9E8CnyD36r94VzL3d
 5w3g/w4VDjOR1+aDbmw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68c136 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sR5FZkZDx7CDG0P_Oh4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280132

On 7/27/26 11:30 PM, Eric Farman wrote:
> The fsm_notoper() routine is called when the device has been
> lost, and is (by definition) no longer operational. Since this
> can happen asynchronously from the normal behavior of the
> driver, the cleanup may happen when holding other locks
> in the calling sequence (notably, the cio subchannel lock).
> 
> Push the cleanup of the private->cp resources to a workqueue,
> where it can be done out from under that lock sequence and
> a future patch can safely manage the locking requirements.
> 
> Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

...

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index d361d1fde3a0..1df6d649565b 100644
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
> @@ -134,9 +135,16 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
>  	/*
>  	 * Ensure these work items are fully drained, so none can
>  	 * fire after being released.
> +	 *
> +	 * notoper_work should have nothing to do here, because only
> +	 * open devices could have channel_program resources in use
> +	 * and those would be released during close. Nevertheless,
> +	 * call flush here as well to be certain anything that was
> +	 * allocated is freed.
>  	 */
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	flush_work(&private->notoper_work);

Sashiko still seems grumpy about this, but it largely seems fine to me.

We know that notoper_work will have either 0 or 1 task queued to it
(never more than 1) and that for the life a device a task would only be
queued to it exactly once (on entering NOT_OPER the first time, which it
a terminal state e.g. the FSM does not allow transferring to any other
state).  It is impossible to "re-enter" NOT_OPER and queue a second
notoper_work.  Therefore once not_oper has been flushed once (either
here or in close_dev()), nothing will add another.

The only scneario I'm trying to think about is whether it is still
theoretically possible to go into the NOT_OPER state after this
flush_work().  Which wouldn't be solved by a cancel_work_sync here
either btw.

This window would be very small and highly unlikely + this otherwise
closes the more obvious issues so with that:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

