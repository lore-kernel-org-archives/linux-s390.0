Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBA374187;
	Wed, 30 Sep 2026 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753376; cv=none; b=oTgs0Or13G+H0ZTKalFVLDKwy+ec+lZ9FjHYaFfxmgIcPuUeW1jS3vGfn4CTRoqmwb1YIMV4kPPnY84cbIv5MtkXO/YpGvuKd7xNj6TUFNYXgJ9QgXDtujbx+WUa6Op7EWZ7DOURGVZP1Ym+Xe2f2dDwCbvKyxQW7jWLDheyvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753376; c=relaxed/simple;
	bh=ntE2VgJ/2ndBLvycIIAQ/XTPb/6jBTUG7A5qs9WsMjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK5oOzNwiLClGxjm6M1knKFAcAU8cqGba8uS999qPNd70LJq89cf1B66E69Dovk2GbeTwDHO9xC+NjkKQ3BUEUszUjvWCq6L2QpuhV2Ba2/8RRWovhQ/d1KF9R5VT9zn07V0Kdimbowzdg4jgWlj+Lux8YFuUg3FTgndMoi35qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WteS/e0x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WteS/e0x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZdwO1171861;
	Wed, 30 Sep 2026 07:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yDjzzb
	3YB8/Duz/xovBGr/fUbsnCWQl3DbCZ+JIDik8=; b=WteS/e0xq8zBvcwvG0PwU0
	pkjWgT0n4So5b41CCer2H49B2E+LECu5qqas5g2QYLASaLEcnEqek6wTvMC47+2k
	bNYNKZpmcAooXNSOd+aAABgjuBPyHks0nI46naIW4FzCoH8GYoQYPoPf3Va1yPO+
	sXBme00Jseoj8k8B3IkUvpPxgtPcNf4NzksIRIUn0oCWyfpXjq9gUIo4+1hw3KyS
	5UH3tRPdbpPkphe7B1/GRPDgr2AIRLnnMoLrMEla7/nSJ73bWE13i9Exp/E4nESU
	gvyNPPMo5ReNnZH1841XM/5N7SwiPJIjrQuu8PmaxvJkCxomdPmg2GIEWLHvJctg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkb04u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:29:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4dj7O2541956;
	Wed, 30 Sep 2026 07:29:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpaqfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:29:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U7TKal48759206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:29:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC08B2005A;
	Wed, 30 Sep 2026 07:29:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF06A20063;
	Wed, 30 Sep 2026 07:29:17 +0000 (GMT)
Received: from [9.123.15.93] (unknown [9.123.15.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 07:29:17 +0000 (GMT)
Message-ID: <4590a880-d267-4c26-8a1f-c33cb3f53fca@linux.ibm.com>
Date: Wed, 30 Sep 2026 12:59:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, kees@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot@kernel.org
References: <20260922101913.239103-3-nagamani@linux.ibm.com>
 <20260928233416.2796559-1-kuba@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <20260928233416.2796559-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IeKpu_-aFwcfU0z65FUsIH114n8mKFi4
X-Proofpoint-GUID: etoNrfvWsyMV4bYGka86F5EdpnXBpyj-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX9LRaDlD3Ga0l
 kjEejqPCeJ/6Yy8V51Pjyb1kxvAl/mEjz2kEvBdLxKzgYwqSyX5qBZ2OCHk/gm0hcW4rKtKojv1
 ROnJH1sJElCznPjO/OeaLZ6pk+xMArU=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abcba57 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=An1SWL3B0YKOnqAVLzcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfXxr1vTkXGIl6x
 yevyTlAHqV5bTe/YKQoXq/Rtni4feIKgfiseaZ1E1pTFeera9NE4ztYStwirhoryJZLniY5Ac28
 1AV98X4KpSsrV8kQzWNHqwao2leTKmDizcaICGCDE8xsfwSvBI1TnjHCSaT4DKL6tJ+9+If/9cD
 7JrtBtZ922X37TOgPvd+M7OtDUWZV2bstxPHZPFMItYgiWz0y4drYnsQz+pc4WbKZ/0mh17DBxC
 oZL3M6zH0AlV8H/6/x1eJ2njV1aw1JNvAnbYCV/ECnyNlCdp925CTDBvcAL0mhN49KXi+6e5VZV
 MWdlCVs+R0fGrW0wAf+RSgj8aFw3KqPh5Soqtj+iBIKIhnFDwKd4rJIHRrXRoO/L0vyp6YclA91
 Mu3fzZrGYNIMX13JM2t0GpLnhoLiWi27oyQrXESnpsdmToeAEO6RvcsPJPse6VM/0LuDY1F65TS
 QRJL+LFAGC66Vq3559A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028



On 29/09/26 5:04 AM, Jakub Kicinski wrote:

Thank you for the detailed review. Responses inline.

> [Severity: Low]
> This isn't a bug, but "Patch 1" and "patch 2" won't mean anything once
> these commits are in git history.
> 
> The prerequisite is "s390/ctcm: Fix timer corruption in fsm_addtimer()".
> Its Fixes: tag (e99e88a9d2b0) is different from the one on this commit
> (293d984f0e36). Without it, fsm_addtimer() calls timer_setup() again, which
> restores ->function and undoes timer_shutdown_sync(&ch->sweep_timer.tl).
> 
> Could the commit message name the prerequisite by title or SHA? Could the
> Cc: stable line also use the "Cc: stable@vger.kernel.org # <ver>: <sha>:
> <title>" form, so the dependency is recorded in a way tools can pick up?
> 

Fixed in v4:
- Named the prerequisite by commit title ("s390/ctcm: Fix timer
  corruption in fsm_addtimer()") throughout the commit message.
- Updated the tag to structured format:
  Cc: stable@vger.kernel.org # depends on: s390/ctcm: Fix timer corruption in fsm_addtimer()

> 
> [Severity: High]
> Is this quiesce early enough? On the offline path, channel_remove() only
> runs after ctcm_free_netdevice() has already freed the shared MPC state:
> 
> ctcm_shutdown_device()
>     channel_free(priv->channel[CTCM_READ])
>     channel_free(priv->channel[CTCM_WRITE])
>     unregister_netdev(dev)
>     ctcm_free_netdevice(dev)
>         kfree_fsm(grp->fsm)
>         kfree(grp)
>         priv->mpcg = NULL
>         kfree_fsm(priv->fsm)
>         free_netdev(dev)        /* MODULE builds only */
>     ...
>     channel_remove(priv->channel[CTCM_READ])
>     channel_remove(priv->channel[CTCM_WRITE])
> 
> ctcmpc_bh(), the ch_tasklet handler, dereferences these objects without
> checking the channel FSM state. Setting CTC_STATE_IDLE in channel_free()
> therefore doesn't stop a tasklet that is already pending:
> 
> drivers/s390/net/ctcm_mpc.c:ctcmpc_bh() {
> 	struct net_device *dev	= ch->netdev;
> 	struct ctcm_priv  *priv	= dev->ml_priv;
> 	struct mpc_group  *grp	= priv->mpcg;
>     ...
> 	while ((fsm_getstate(grp->fsm) != MPCG_STATE_FLOWC) &&
>     ...
> }
> 
> Suppose the RX path scheduled rch->ch_tasklet just before the device was
> taken offline, and the tasklet is still pending (for example deferred to
> ksoftirqd) when ctcm_free_netdevice() runs. Can it then dereference a NULL
> priv->mpcg, or a freed dev in MODULE builds, before channel_remove() gets
> to tasklet_kill()?
> 
> Something similar can happen with sweep_timer. An in-flight action in
> ctcmpc_chx_send_sweep() can overwrite the CTC_STATE_IDLE set by
> channel_free() and re-arm wch->timer:
> 
> 	fsm_addtimer(&wch->timer, CTCM_TIME_5_SEC, CTC_EVENT_TIMER, wch);
> 	fsm_newstate(wch->fsm, CTC_STATE_TX);
> 
> If that timer fires before channel_remove(), the TX timer action would use
> ch->netdev and priv->mpcg, which by then are freed or NULL.
> 
> The error path in ctcm_new_device() has the same order: it calls
> ctcm_free_netdevice() at out_dev and channel_remove() on both channels
> afterwards.
> 
> Would it make sense to quiesce the tasklets and timers of both channels
> before ctcm_free_netdevice() is called?
> 

Confirmed pre-existing bug in ctcm_shutdown_device() / ctcm_new_device()
error path, outside the scope of channel_remove(). Aswin Karuvally has
picked this up and is preparing a fix in a follow-up series.

> 
> [Severity: Medium]
> Can a timer callback schedule ch_disc_tasklet again after the
> tasklet_kill() above?
> 
> tasklet_kill() waits for the current run and clears TASKLET_STATE_SCHED.
> It doesn't stop a later tasklet_hi_schedule(), and the timer actions can
> reach one. 
> [ ... ]> Would a second tasklet_kill() after the timers are synced, or a
> tasklet_disable() before them, close this?
> 

Fixed in v4 by shutting down timers before tasklet_kill():

  if (IS_MPC(ch))
      timer_shutdown_sync(&ch->sweep_timer.tl);
  timer_shutdown_sync(&ch->timer.tl);
  if (IS_MPC(ch)) {
      tasklet_kill(&ch->ch_tasklet);
      tasklet_kill(&ch->ch_disc_tasklet);
      kfree(ch->discontact_th);
  }

timer_shutdown_sync() waits for any active callback and prevents further
rearming. Shutting down sweep_timer first breaks the sweep -> ch->timer
re-arm chain, and shutting down ch->timer prevents scheduling
ch_disc_tasklet via mpc_action_go_inop(). tasklet_kill() then cleans up
any in-flight instances.

timer_shutdown_sync() is also used for non-MPC ch->timer since
ctcm_chx_txretry() can re-arm ch->timer on that path as well.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the same removal sequence
> seems to leave two other FSM timers running on freed memory.
> 
> ctcmpc_init_mpc_group() binds grp->timer, which is embedded in grp, with
> fsm_settimer(grp->fsm, &grp->timer). ctcm_init_netdevice() binds
> priv->restart_timer to priv->fsm. ctcm_free_netdevice() frees all of these
> without first cancelling either timer synchronously:
> 
> [ ... ]

> Should grp->timer and priv->restart_timer be stopped with
> timer_delete_sync() or timer_shutdown_sync() before ctcm_free_netdevice()
> frees them?
> 
Confirmed pre-existing bug in ctcm_free_netdevice(). Aswin Karuvally has
picked this up for the follow-up series as well.

These changes are included in the v4 series posted to the list.

Nagamani

