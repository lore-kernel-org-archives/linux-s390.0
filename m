Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4523E325
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032176; cv=none; b=jpPTR0HJtJY4dSg59TFkX0Zxvtb3V/i1yns0PHklecCLod7n2Szt/FjMewcQsml/bxonU6MZSUjNEiifKPtRukZZox5RKAETI8xBUPUzp8kvamNdtt0pplYznRzct/APxpEhqR+olFnIbgqfF0+dvs5oRgV1wTxnky+PINRrvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032176; c=relaxed/simple;
	bh=rWcyRQMEJUWQWMJJzOjxscRuwOyryHDZetNcwJFh8NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQlWhyPpwpb6yo2mO8t4u2esbtgVeWK2Jrkied4r47TIaFiuhtuLMJxFqZqT+KXGA6o/HdxlTKwuqtVvcG6P7lZUZsYjYLguqj/ScWCTxSC+Jf8HJULJxhhg0e44db9aNTOZwt0BlVk4SthAz3REU/UKrgr4/8/EbL0Y+hOi6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U+Bwe0gb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U+Bwe0gb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnOBC2964620
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 16:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KvpT3x
	haylh2jmDDrzqiMm9sbxL25VcABLw56LRrCFU=; b=U+Bwe0gbOi0IIpA9cDd5G3
	uhH3Oonbt/0SqK9A+wAMezhFBYL4zeTiHQ4FqvzVUF8TKSdFaZImvxa1gw0IF0yy
	fP6e9+18W7hbyZVj3Aq3YPO+ZJMS54w9SFQuiGzNF/oJIc2EY8dV8tLDLu/c8K7n
	P6ny9adtB9siNEFD2thdy/QHB2A1ltV4dQ5vah0d0Yt2UPqHeQcD8I7uWgP7pWcV
	n2VwoY8ChrEQg+L0WR3YgKu8ZoIk2Ui7+g+tAhJ7Bfm2BCX7d7dXp/WXrqdnrx3m
	gF/7xQdA/LJ5Dz6p30JF5aPAjH5cphPT6oxIFqUVM+PFZ1RrzvafVMt0J2lZ2UJQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59631-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 16:02:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FuIEA025829
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 16:02:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kbv3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 16:02:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676G2nGf53477714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 16:02:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810882004B;
	Thu,  6 Aug 2026 16:02:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 459A820043;
	Thu,  6 Aug 2026 16:02:49 +0000 (GMT)
Received: from osiris (unknown [9.111.55.125])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 16:02:49 +0000 (GMT)
Date: Thu, 6 Aug 2026 18:02:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
Message-ID: <20260806160247.15764F95-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
 <20260806155223.BD6B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806155223.BD6B21F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX2aKK/KvGmhfK
 5sksLgwCV4gsFbSfUNoRXq1ybklMK6nKuVP81Heb9TZS+5IlCw7+s3GifirT8reEwCLzYzON/Ws
 +ksuSgvr5zfV/+yB/0mndj4K77XBbng=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX9Qs6Jc5vXgiJ
 T/0c2nG+ayjwMSZG+mMJVZXEkbiMp4ZP0UHHeLUdoW9nqS/8F8PRephbYmABx+dBJNSqTHG+fea
 JfOa1QCVFdjYVax2fdDAfkfWWdPmfvKDA4gsUQZYq95iMEcLSEcNd+DR8D0aU3+Ahx/kgIEsEsB
 EPPezNw/i2+OOOS5wlaU0bEUFZBBaigMUkjdNXB4xVoMeHUXn1EHUEkIswtotGu/+ba7j4jP+An
 Kc6PNYfnq1C3kGBoXaO2UtleyxHbI5QpdkyFSYWmI6JTEZwFGQsNZR3h1iGkrOcwAJ33d9e8Hbd
 wtH7zG+jzfiyE084/A4cQ3hmDzm0dkTD3kFiAfb1Wv1z5tphk+J+uiP12DqH9MtF5en/tqVUvnB
 OAYkVVrK6Ph9aMkQd+k+lQYVVungdUFIPYVFNlkN71+kgRvZSn6uwq2FwdjwIL1TckIrjFTonxT
 OqMegmhd8GeGpGdMcTw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74b02e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=0wgQjDyZ8gMP37jryY4A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: dEqplqK14D8dA7Vd7vkjQG-ukgFOKTPX
X-Proofpoint-GUID: dEqplqK14D8dA7Vd7vkjQG-ukgFOKTPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060122

Eric, Matthew,

not sure if you are aware of the below (nothing I would address). Please handle :)

On Thu, Aug 06, 2026 at 03:52:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Premature loop termination in `vfio_ccw_sch_quiesce` due to re-used completion without re-initialization.
> - [High] Unconditional NULL pointer dereference in asynchronous subchannel callbacks.
> - [High] Leaked workqueue items (`io_work` and `crw_work`) during device teardown leading to Use-After-Free.
> - [High] Lockless state access in `vfio_ccw_sch_io_todo` causes a double-free of channel program (`cp_free`).
> --
> 
> --- Patch [1]: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce() ---
> commit c7b4889a75b6cf11527a57bff8438c3c08dac9c4
> Author: Heiko Carstens <hca@linux.ibm.com>
> Subject: s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce()
> 
> This patch adds the __must_hold attribute to vfio_ccw_sch_quiesce() to
> inform context analysis that sch->lock must be held on function entry.
> This resolves a thread-safety-analysis warning during compilation.
> 
> > diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> > index 1a095085bc728..ed9ca77c5b23f 100644
> > --- a/drivers/s390/cio/vfio_ccw_drv.c
> > +++ b/drivers/s390/cio/vfio_ccw_drv.c
> > @@ -35,6 +35,7 @@ debug_info_t *vfio_ccw_debug_trace_id;
> >   * Helpers
> >   */
> >  int vfio_ccw_sch_quiesce(struct subchannel *sch)
> > +	__must_hold(&sch->lock);
> >  {
> >  	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
> >  	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
> 
> [Severity: High]
> This is a pre-existing issue, but does the completion handling in this loop
> allow premature termination?
> 
> If wait_for_completion_timeout() times out, but a late interrupt arrives
> and calls complete(), the completion's done counter becomes greater than 0.
> 
> On the next iteration of the do/while (ret == -EBUSY) loop in 
> vfio_ccw_sch_quiesce():
> 
> do {
>         ret = cio_cancel_halt_clear(sch, &iretry);
>         ...
>         if (ret == -EBUSY)
>                 wait_for_completion_timeout(&completion, 3*HZ);
>         ...
> } while (ret == -EBUSY);
> 
> Could wait_for_completion_timeout() see done > 0 and return immediately
> without waiting, causing a tight spin loop calling cio_disable_subchannel()
> since there is no reinit_completion() inside the loop?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a risk of a NULL
> pointer dereference when fetching the parent pointer?
> 
> During device removal, vfio_ccw_sch_remove() sets the drvdata to NULL:
> dev_set_drvdata(&sch->dev, NULL);
> 
> If an asynchronous event like an interrupt triggers concurrently before the
> CSS core fully detaches the driver, could vfio_ccw_sch_irq() or
> vfio_ccw_sch_event() fetch a NULL parent and immediately dereference it
> in this sequence?
> 
> struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
> struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
> 
> [ ... ]
> > diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> > index 0501d4bbcdbd6..8db29519dbfde 100644
> > --- a/drivers/s390/cio/vfio_ccw_private.h
> > +++ b/drivers/s390/cio/vfio_ccw_private.h
> > @@ -127,7 +127,8 @@ struct vfio_ccw_private {
> >  	struct work_struct	crw_work;
> >  } __aligned(8);
> 
> [Severity: High]
> This is a pre-existing issue, but does the device teardown path leak these
> pending work items?
> 
> When a mediated device is removed, vfio_ccw_mdev_release_dev() frees the
> private structure without calling cancel_work_sync() on io_work or crw_work:
> 
> static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
> {
>         ...
>         kfree(private);
> }
> 
> Additionally, fsm_close() can skip the global flush_workqueue() if
> cio_disable_subchannel() immediately returns 0:
> 
> ret = cio_disable_subchannel(sch);
> if (ret == -EBUSY)
>         ret = vfio_ccw_sch_quiesce(sch);
> 
> If a work item is left pending on the workqueue, could it execute after
> the private structure has been freed, resulting in a use-after-free?
> 
> > -int vfio_ccw_sch_quiesce(struct subchannel *sch);
> > +int vfio_ccw_sch_quiesce(struct subchannel *sch)
> > +	__must_hold(&sch->lock);
> >  void vfio_ccw_sch_io_todo(struct work_struct *work);
> >  void vfio_ccw_crw_todo(struct work_struct *work);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the lockless state check
> in vfio_ccw_sch_io_todo() allow a double-free of the channel program?
> 
> The workqueue function vfio_ccw_sch_io_todo() reads private->state
> locklessly:
> 
> if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
>         cp_free(&private->cp);
>         cp_is_finished = true;
> }
> 
> Concurrently, fsm_close() holds sch->lock, changes the state to STANDBY,
> unlocks, and also calls cp_free():
> 
> spin_unlock_irq(&sch->lock);
> cp_free(&private->cp);
> 
> Since vfio_ccw_sch_io_todo() operates outside sch->lock, could both threads
> evaluate their conditions simultaneously and concurrently execute cp_free()
> on the same channel program?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260806153849.2622576-1-hca@linux.ibm.com?part=1
