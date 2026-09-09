Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4357F754;
	Wed,  9 Sep 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964636; cv=none; b=dB1ufdFcDIa780D8AMzdMpHlLqJ5XdbrqCzmsKUtyf5FmqmIsLEXt11NWxJrivavCizdAYpzId7H3wvpGZkuvFR3sCGNuVvKpJK8lOcB2rDZAr7hPIJjORTfHA0hcBdUC4mUQqJxpi53ziVCuImDeVc/1wYDt0Je5j84Jpmetoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964636; c=relaxed/simple;
	bh=xtOgUh/L6MF+jrJ24X7oWpToR3DU/vTdqDq2fc1Wg/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7aAqA/YZqQcw7N46g/30JJh52a5mhU7uinhil1KFScKspZ3XfO/Ck3x1IGyBZ65vniy5n8RP6pYsokjBc/6B5TGgU8I/ABoYPk/LbbOGrXXfyDyuygSxM4BnVW2UGESUoJ1KzbYgae7XDBSkDCm4x3wgfDPVIfE47fRE5SQV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mIBmGpy/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mIBmGpy/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1VIZ1930746;
	Wed, 9 Sep 2026 14:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W+d4d3
	u/fs0bAXS2dXFOYLho/6FprKhrDIX5pnpwBcs=; b=mIBmGpy/SoaLW3G7Y0QJl6
	9dtRoIBbD/zkuiYSC1NMd4HusDq/Zh8aQh9v1Ph9y8kW0ryJZISnoH1/jRMxyWya
	5vIqFY3X2Ni21LugmtwfV3wAQTr9+rjId4XeNhh19hqj3qICCG6EklBigwCNaCDm
	NENeJHrBojkAoyylz37RssfkuS0upklYRTUrlGQzbWvAWck1PhMY1gtIopW1olSD
	jM0PLfC5p59r1yha7/P4NCrHkE14GoDFH/jri8UbsHlzzHAuIse0KUnozQJbcWAJ
	N4miVz5JlLqRLR/JrZoreBo+/ABEYbJW2KK6OP9D+fnnBOy8OctCnx06OE3RaQwA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk6edb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 14:37:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EQI4R014921;
	Wed, 9 Sep 2026 14:37:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswavvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 14:37:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Eb8sg45285660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 14:37:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04102004B;
	Wed,  9 Sep 2026 14:37:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 406CA20043;
	Wed,  9 Sep 2026 14:37:08 +0000 (GMT)
Received: from osiris (unknown [9.111.58.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 14:37:08 +0000 (GMT)
Date: Wed, 9 Sep 2026 16:37:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Nihar Ranjan Panda <niharp@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Nagamani PV <nagamani@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: Re: [PATCH v4] s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only
 after firmware activates.
Message-ID: <20260909143706.13132A22-hca@linux.ibm.com>
References: <20260907051016.1296884-1-niharp@linux.ibm.com>
 <20260907052157.AC6D51F00A3A@smtp.kernel.org>
 <34a27ebe-e9fb-4300-9d5c-beac88744bd4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a27ebe-e9fb-4300-9d5c-beac88744bd4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DodnH2NDUEsdE77KiwO9Ksd1XfHHsnqg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfX+PQnSSCNlmUt
 6yMQlB4ljKsfpzGufaVojfKedubPu32XKPXTW/5cHcPssBwnKMDXghk5E5kPO7k9ZJJH7Rr6qUy
 9OiLIme9bsTRvUv7n8rmDvcR0NmhLv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfX/cjJNbB9moBK
 bxlomn79aAsCT3ffhD/u8HOYzXAz/jDGfzUAT/TDWj8Fhb5uZvMSjjQB5ika1Tf+sxGwq8MjiVA
 sFTWpAV/sG3wOy84C1XxfRGKULrG6yqhv+D076o8b+GC8beOw4VIHwif31EfcT1F1ou7Wt6QBoh
 26j+Z9jLrD3TF+hKpCYrckecOkDhOOCh3UzglkPbB59koNAL5ZKoXJW24wUw11/+Sy8QpiwS8nk
 NPzzmmTXfkOri3XG4zNJ+pGlteWluUm1CgBDkiveElvTqRwLgBYKvg2dT2oI8WTr3uEuUO9bGKx
 51VgH9Gk8sw1hADUK37qWbHm+9IbJZwNI6DcokP/eoblRB43oDTrZQqtl6Llyd3Fn7Hg6Y0U5g2
 RB3uUchcztmnZf04ysJegPg1g8Qf9tAHuOlgEpnKml1xlZncbLHMTkURmi7FfgrHTUCJclF4K3s
 C6oJQ5auaJuNpkvKDaw==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa16f1a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-iIxx6m34nZCUG48ZDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DodnH2NDUEsdE77KiwO9Ksd1XfHHsnqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090162

[full quote below since additional people are added to cc]

On Wed, Sep 09, 2026 at 11:27:25AM +0530, Nihar Ranjan Panda wrote:
> On 07/09/26 10:51 am, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > 
> > New issues:
> > - [High] Lockless execution of cio_update_schib() causes a data race on the shared sch->schib structure.
> > - [High] The timeout polling loop is vulnerable to a preemption bug resulting in a spurious -ETIMEDOUT failure.
> > - [High] Missing I/O cancellation on timeout leaves a dangling channel program.
> > 
> > Pre-existing issues:
> > - [High] qdio_set_state() is called locklessly, potentially overwriting a STOPPED/ERR state.
> > --
> > 
> The above reported issues have been reviewed and determined to be invalid. 
> Please find the clarification for each item detailed below.

I do disagree for at least two points (the other ones are up to other folks).
 
> > commit f5d84619d7d33842d3cc7f120e8e2f08b030d3f4
> > Author: Nihar Panda <niharp@linux.ibm.com>
> > 
> > s390/qdio: Ensure QDIO_IRQ_STATE_ACTIVE is set only after firmware activates.
> >     
> > This commit modifies the activation sequence for QDIO queues to poll the
> > Subchannel Status Word (SCSW) instead of relying on an intermediate interrupt.
> > It checks for both SCSW_ACTL_SCHACT and qact to become set within a loop before
> > transitioning the state to QDIO_IRQ_STATE_ACTIVE.
> > 
> >> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> >> index c1e09fa34e774..821d501efdccf 100644
> >> --- a/drivers/s390/cio/qdio_main.c
> >> +++ b/drivers/s390/cio/qdio_main.c
> > 
> > [ ... ]
> > 
> >> @@ -1178,23 +1197,32 @@ int qdio_activate(struct ccw_device *cdev)
> >>  			      0, DOIO_DENY_PREFETCH);
> >>  	spin_unlock_irq(get_ccwdev_lock(cdev));
> >>  	if (rc) {
> >> -		DBF_ERROR("%4x act IO ERR", irq_ptr->schid.sch_no);
> >> -		DBF_ERROR("rc:%4x", rc);
> >> +		DBF_ERROR("%4x act IE:%d", irq_ptr->schid.sch_no, rc);
> >>  		goto out;
> >>  	}
> >>  
> >> -	/* wait for subchannel to become active */
> >> -	msleep(5);
> >> +	rc = -ETIMEDOUT;
> >> +	timeout = jiffies + HZ;
> >>  
> >> -	switch (irq_ptr->state) {
> >> -	case QDIO_IRQ_STATE_STOPPED:
> >> -	case QDIO_IRQ_STATE_ERR:
> >> -		rc = -EIO;
> >> -		break;
> >> -	default:
> >> -		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> >> -		rc = 0;
> >> +	while (time_before(jiffies, timeout)) {
> > 
> > [Severity: High]
> > Does this loop risk spurious timeouts under preemption or high CPU load?
> > 
> > By checking the timeout condition before evaluating the hardware state, if
> > preemption occurs right after the timeout is set and lasts longer than HZ,
> > the loop will terminate immediately.
> > 
> > This causes a spurious -ETIMEDOUT failure without ever checking the hardware
> > status.
> > 
> NO, the loop is safe because msleep + time_before(jiffies,…) is immune to preemption delay; 
> jiffies advances independently

This is not correct. It the task that is doing

	rc = -ETIMEDOUT;
	timeout = jiffies + HZ;

is preempted right after assigning the above to timeout, and is scheduled back
in _after_ timeout then

	while (time_before(jiffies, timeout)) {

evaluates to false. Which means that -ETIMEDOUT is returned, even though state
has not been checked even once. This is a regression to before and needs to be
fixed. Similar things can happen if the loop itself is preempted. It might
have waited only 1, 2, 3, or 4ms, and might then be preempted - without
checking again. Before it was a minimum of 5ms and a guaranteed check
afterwards.

The 5ms might have been a random number, but it is a change and potential
regression as well.

> >> +		msleep(1);
> >> +		if (irq_ptr->state != QDIO_IRQ_STATE_ESTABLISHED) {
> >> +			rc = -EIO;
> >> +			DBF_ERROR("%4x act WS:%d", irq_ptr->schid.sch_no, irq_ptr->state);
> >> +			break;
> >> +		}
> >> +		/* Query hardware */
> >> +		if (cio_update_schib(sch) == 0) {
> > 
> > [Severity: High]
> > Is it safe to call cio_update_schib() without holding the subchannel lock here?
> > 
> > The lock get_ccwdev_lock(cdev) was released earlier, and cio_update_schib()
> > performs a lockless memcpy():
> > 
> > drivers/s390/cio/cio.c:cio_update_schib() {
> >     ...
> > 	if (stsch(sch->schid, &schib))
> > 		return -ENODEV;
> > 
> > 	memcpy(&sch->schib, &schib, sizeof(schib));
> >     ...
> > }
> > 
> > This results in a data race with concurrent interrupt handlers that might be
> > updating sch->schib, potentially causing torn writes and state corruption.
> >
> Yes, it is safe to call cio_update_schib() without holding the subchannel lock. 
> The implementation is secure for the following reasons:
> 
> Subsystem Consistency: The lockless call is consistent with all other invocations of 
> cio_update_schib() across the driver subsystem.

This is not true. All other places (except one) call cio_update_schib() with
sch->lock being held.

The only other "offender" seems to be vfio_ccw_schib_region_read(), which
looks like a bug.

I leave the rest below to other folks who have been on cc on your original
email (+ adding Eric and Matthew for vfio).

> Authoritative Data: Both concurrent writers are applying identical, hardware-authoritative state, 
> eliminating the risk of conflicting data.
> Writer A — the interrupt path (do_cio_interrupt()): memcpy(&sch->schib.scsw, &irb->scsw, …);
> Writer B — the poll path (cio_update_schib()):memcpy(&sch->schib, &schib, …);
> 
> Fault-Tolerant Design: The polling loop naturally tolerates a missed read and will simply retry, 
> preventing state corruption.
> 
> >> +			if ((sch->schib.scsw.cmd.actl & SCSW_ACTL_SCHACT)
> >> +					&& sch->schib.scsw.cmd.qact) {
> >> +				qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
> > 
> > [Severity: High]
> > This is a pre-existing issue, but is it safe for qdio_set_state() to assign
> > the state locklessly?
> > 
> > By directly assigning irq_ptr->state without serialization, it can overwrite a
> > QDIO_IRQ_STATE_STOPPED or QDIO_IRQ_STATE_ERR state set concurrently by an
> > interrupt handler.
> > 
> > This could mask concurrent hardware errors and leave the device in a
> > false-active state.
> >
> 
> Yes overwrite can happen between do_cio_interrupt()  and cio_update_schib().
> The mb() inside qdio_set_state() ensures the write is ordered and visible, not exclusive.
> The race is not new and is not worsened by the change.
> The race window is smaller, the guard is tighter, and the hardware confirmation adds a second condition. 
> 
> 
> >> +				rc = 0;
> >> +				break;
> >> +			}
> >> +		}
> >>  	}
> >> +	if (rc == -ETIMEDOUT)
> >> +		DBF_ERROR("%4x act TIMEOUT", irq_ptr->schid.sch_no);
> >>  out:
> >>  	mutex_unlock(&irq_ptr->setup_mutex);
> >>  	return rc;
> > 
> > [Severity: High]
> > If this returns -ETIMEDOUT, is the pending asynchronous I/O left uncancelled?
> > 
> > When the timeout expires, the function returns the error while the channel
> > program started by ccw_device_start() may still be active in hardware.
> > 
> > This could lead to use-after-free and memory corruption if the uncancelled CCW
> > eventually completes and performs DMA writes to memory that has since been
> > freed or repurposed.
> > 
> No, as qdio_shutdown() → qdio_cancel_ccw() → ccw_device_halt/clear() is the 
> mandatory error path all callers must invoke, so the channel program will be closed.
> 
