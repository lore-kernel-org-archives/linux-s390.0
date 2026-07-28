Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71C27A462;
	Tue, 28 Jul 2026 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204516; cv=none; b=BQC/j9Db4k+H3PuC2NuCIfGrdusoAc5ExCkj9xCZ5NgUItzsr/zTvVv/KteKyOXATjTn368triSpJ6OgkFkmOy7s0IheqOwgY3IeWO2SUARPQ18+3j/LQM6+MYmWDDaL4mNZAZK/Xh1vQ864T2ECUHAwYV6NdLyoCkg7upxVjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204516; c=relaxed/simple;
	bh=HNTpFDiUjec0pU/+OUp9yhjBGKstX3nuZv5ZWRBMY8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT8EoUAQOKlktipn4NbdSjzfkeI1z25YPH1aaUhLbVfk+UktRKf8ZbWxHVJcTFexzNOd2T4h096su20NU2jpkc780fvBQ2KUTlaR/mFjAV5LklObjjKdH/E/HeuqYnmCBRP+aMTuby0YNEsAt5bxXvWA5/GaVbyECvJOV6Agi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AyOR+Wi+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AyOR+Wi+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0mFd53676360;
	Tue, 28 Jul 2026 02:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z7NZr4
	BFvMzd3F+tDrXN2nV97S/VvCNcetNJt07WLho=; b=AyOR+Wi+utWhQXpvkwW2ZC
	OoehVAONbeNpzCQ6oTSfCIjMZ1apGxIMb2IfcizB9KKbxq/DRbqMvfj8org8PGoh
	utPDw4/ODipjfX7nbnVQXSN112l8Qi3Udhwo33/Jjd9OYhh5NpWs0qbJ/ZGQSwVQ
	XydDmIfTVs/DU/blLgKMbOiGRUSSK27JfFTjcUuTQ98mhaPGjA8RwTgLlcM402Cn
	t8w5fxTpQf8o8L2aBL+3SOSzwf4HnPVP7UKvPnW6lI2vw0MoyOnZpTK1Nb5MjjG2
	2weR5B5XzJEdayVcsg6Jm97dZBTlErzyCZhetoYBbpj6I6SB7stXFCzQj8cphy/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj2g83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:08:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1uNET030304;
	Tue, 28 Jul 2026 02:08:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw002u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 02:08:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S28Vbf22741510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 02:08:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A612D58056;
	Tue, 28 Jul 2026 02:08:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235BE58052;
	Tue, 28 Jul 2026 02:08:31 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 02:08:31 +0000 (GMT)
Message-ID: <94c0d892-08e4-4ecf-8190-c2ae14f3d7e7@linux.ibm.com>
Date: Mon, 27 Jul 2026 22:08:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] s390/vfio_ccw: selectively expand io_mutex
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-10-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728013509.1551753-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX9D1I3xhaPYzH
 yA+JrhIe3iAd3KhxR/KQPOTQGiHF46Xz5GLVte7Kfj0Tbumg1x+4R5DWoKACrUBRt8tvVgNjQZy
 yIZhZcv3j5j+5GGFYWhzL+qGuGQ7py4=
X-Proofpoint-GUID: 9ADdhQjYzuMIGVLlJf3Qqx-J2KOis9_1
X-Proofpoint-ORIG-GUID: 9ADdhQjYzuMIGVLlJf3Qqx-J2KOis9_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAxNCBTYWx0ZWRfX65ctWD71CX+4
 0gU4iELg7FfT7niRkSsHWwsOypN/vNcj5xw4OOyRcEWKj8JnQRjqmKmxClhPhJsfGdcONbmeZ65
 3dRK42HvO9aAABK70VlIuyK6lIon3CZrAaM8rWPbyZ7VdAfJGBpKZr99b9QOGeG+bTBIubN5D/+
 bLFgcwLtj1ytM3wKoB9ou8OLzwyFV5hq7a42kD56ozhX11qYOqc6+YVtBuKTVd4ksKwAfo2VMr5
 TAv0n0BFExfEu9L1ls2IHjrGRty5RP0oVgtPZgTbtxY0OuMn1ZJgMjLKYhJ+Mtovc6N7vXiooHl
 g46w9koZqtZn0M642IdNNfxwFZ8kCGBltHAut+fpdlWZxH6tm2FuHVQ5PKrs9QpNBe8pjHDCbtl
 Q7Df3QTR7MoApQgJEXCAC50uJdaOZRtsB58Wl3FeapOHouyHI2gauEqjqJVeL6c2kmbC/P2Kvul
 Jk3UGTt+4V5JXg2VJdw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a680f21 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aw3LToj-I7jRMUeLEmcA:9 a=QEXdDO2ut3YA:10
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
> The io_mutex was defined to serialize the io_regions, but then has
> also sort of been associated with the I/O themselves because of
> the close relationship they share.
> 
> With the handful of races that are possible, the choices are either to:
>  A) expand the scope of io_mutex to close these remaining windows, or
>  B) reduce the scope of io_mutex to just io_region, and introduce a new
>     lock mechanism for the remaining I/O resources
> 
> This patch implements A, since B brings with it a lot more interactions
> that would need to be tracked and kept in a correct hierarchy.
> 
> The biggest functional change is the introduction of a workqueue
> element for the cp_free() called out of fsm_notoper(), which is could
> be run in an interrupt context and thus cannot be acquiring mutexes.

Nit: re-word "which is could be run"

Also the wording here kind of implies you added fsm_notoper() in this
patch, but that was last patch - here you just made it use the io_mutex.

Otherwise LGTM.

> 
> Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_chp.c     | 2 +-
>  drivers/s390/cio/vfio_ccw_cp.c      | 8 +++++++-
>  drivers/s390/cio/vfio_ccw_drv.c     | 6 ++++--
>  drivers/s390/cio/vfio_ccw_fsm.c     | 5 +++++
>  drivers/s390/cio/vfio_ccw_private.h | 3 ++-
>  5 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index f3015132d4b5..9269b54f5cfd 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
>  
> +	mutex_lock(&private->io_mutex);
>  	crw = list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
>  
>  	if (crw)
>  		list_del(&crw->next);
>  
> -	mutex_lock(&private->io_mutex);
>  	if (i >= private->num_regions) {
>  		ret = -EINVAL;
>  		goto out;
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 5ef082b8289a..58722c4baa25 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -977,17 +977,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
>   */
>  bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
>  {
> +	struct vfio_ccw_private *private =
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	struct ccwchain *chain;
>  	int i;
>  
>  	if (!cp->initialized)
>  		return false;
>  
> +	mutex_lock(&private->io_mutex);
>  	list_for_each_entry(chain, &cp->ccwchain_list, next) {
>  		for (i = 0; i < chain->ch_len; i++)
> -			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length))
> +			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length)) {
> +				mutex_unlock(&private->io_mutex);
>  				return true;
> +			}
>  	}
> +	mutex_unlock(&private->io_mutex);
>  
>  	return false;
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index c197ad5ab580..757ff5b2556e 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -91,6 +91,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  
>  	is_final = !(scsw_actl(&irb->scsw) &
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> +	mutex_lock(&private->io_mutex);
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);
>  		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
> @@ -98,9 +99,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  			cp_is_finished = true;
>  		}
>  	}
> -	mutex_lock(&private->io_mutex);
>  	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
> -	mutex_unlock(&private->io_mutex);
>  
>  	/*
>  	 * Reset to IDLE only if processing of a channel program
> @@ -110,6 +109,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
>  	 */
>  	if (cp_is_finished)
>  		private->state = VFIO_CCW_STATE_IDLE;
> +	mutex_unlock(&private->io_mutex);
>  
>  	if (private->io_trigger)
>  		eventfd_signal(private->io_trigger);
> @@ -131,7 +131,9 @@ void vfio_ccw_notoper_todo(struct work_struct *work)
>  
>  	private = container_of(work, struct vfio_ccw_private, notoper_work);
>  
> +	mutex_lock(&private->io_mutex);
>  	cp_free(&private->cp);
> +	mutex_unlock(&private->io_mutex);
>  }
>  
>  /*
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index 4d47a3c7b9a0..5fd94e9d5c61 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -170,6 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
>  	css_sched_sch_todo(sch, SCH_TODO_UNREG);
>  	private->state = VFIO_CCW_STATE_NOT_OPER;
>  
> +	/* This routine could be called from IRQ context, so defer */
>  	queue_work(vfio_ccw_work_q, &private->notoper_work);
>  }
>  
> @@ -409,7 +410,11 @@ static void fsm_close(struct vfio_ccw_private *private,
>  
>  	private->state = VFIO_CCW_STATE_STANDBY;
>  	spin_unlock_irq(&sch->lock);
> +
> +	mutex_lock(&private->io_mutex);
>  	cp_free(&private->cp);
> +	mutex_unlock(&private->io_mutex);
> +
>  	return;
>  
>  err_unlock:
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index e2256402b089..739121116ab6 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -88,7 +88,8 @@ struct vfio_ccw_parent {
>   * @state: internal state of the device
>   * @completion: synchronization helper of the I/O completion
>   * @io_region: MMIO region to input/output I/O arguments/results
> - * @io_mutex: protect against concurrent update of I/O regions
> + * @io_mutex: protect against concurrent update of I/O resources
> + *            and @cp lifecycle
>   * @region: additional regions for other subchannel operations
>   * @cmd_region: MMIO region for asynchronous I/O commands other than START
>   * @schib_region: MMIO region for SCHIB information

