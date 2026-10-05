Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C13BD65D;
	Mon,  5 Oct 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190118; cv=none; b=u2VCpWYb6ytBW6xeCfM7caSB2agDD4GdYECQrq+Y2KLog6X2nk4idBsF+Y2M/Hf5k6LObk4LSohJYuxIUzycTsyrbGgblA972gJqyjud547yd0jkSnhfkYjqcfOgU/HTuakzN1kahxDaleDyxKFnmyniTY04fYy2YDu/zBeQR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190118; c=relaxed/simple;
	bh=LZIOGAkJ3OgzArNWUywigRAYWez3aNenFptdwUN+GGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8g5+zuFBiFiEVGnPMD6ptvaShfT9WRIiyNjG8C/xmTcVifmpKR8PEhOgxGCmMUNIjQZAhJc6hypcpqxAMx/+zP9so5cOOXFOllHFU47pJE9fpthEJ2+70+gT1ddEdhnXwJ3icf50PqkXRnVVn8D68ce1PYuyoZR33GepBQYQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsxl1H8i; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsxl1H8i"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515LCk3343732;
	Mon, 5 Oct 2026 08:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6lL3B7
	Zp+T9kYBWKTo/ToUgLjDkFtS0muoqzcVHyDyM=; b=hsxl1H8inbQbC5Qp5nmEln
	hSm41OIK1fvzp5mDd99vz+1hnfBKwQz22+S9D5jRhW6CgcT+5kFfpF0EUL3arOOS
	kyPrSYAhUwc56Xq+CGr+sFA7KgSWpfXM8WQvPXb1Uy1KjNXHUMG2d8rccFj89ajG
	2fq2q8HENcznCsidK+tA62oAE1mmMnwfPW3qnPKvn/SXWbBmITExEcW6Z6icHGZy
	fhOInURvPBH9IbupgpHHAN/NyXdgphT+JiSShvCbWs4dRhcHT+RzYSF+RbYsVTaP
	s1HqWLt1tFxMcZHRpk/2TfCNerfrfZZNDZ5Tz5EF8asdDG9DzVmZ4VE/QB9IyU1Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74ha0g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:48:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956JbAe2165214;
	Mon, 5 Oct 2026 08:48:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmu6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:48:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958mPiu40829218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:48:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B133D20043;
	Mon,  5 Oct 2026 08:48:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3FD82004D;
	Mon,  5 Oct 2026 08:48:21 +0000 (GMT)
Received: from [9.39.23.177] (unknown [9.39.23.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 08:48:21 +0000 (GMT)
Message-ID: <cc794003-f041-4075-a6be-3ba9f2854acb@linux.ibm.com>
Date: Mon, 5 Oct 2026 14:18:20 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
        aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20260930070234.569500-3-nagamani@linux.ibm.com>
 <179109824657.434549.2788045083218312906@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <179109824657.434549.2788045083218312906@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zIT5mqKrzO6xvQIQpyU5xNZgjQlPrfOL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfX6kzOLosm0hRw
 dhGiURO4V6+Nsq78RJDbpPPVO29mSMSb7zJhMoA20zoTUWgc2L0aynj+4uWa3Onf8S009wcqLDB
 sGV4iJE9WrLL4JTpsnLUOiT+FZdD10A=
X-Proofpoint-GUID: IltHLHOB_vBY72tW8ULbPCuV8t2Cm4dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfXwQanOo2dmz2A
 NIK2Ve/orONlCPxtM3x4vlwP4ua02gYFb9JPG+HikCnyVAaefS9CJeMIzmJ9DMBkK3mNW2WL1Zy
 nIu/kQbQi9C6AUYsYw9cqhzye1+whv3MBMVY5oDoKsfPrjsWci9+ZYTeQrEE+GardYaYGmls05S
 0UIaU3XGNNT5nC11ldwFys/rfmDHiZY0vrLW+IR3+zpZ6Yac0J/Cj1BjI3nSKyk6vGoWrmW1J+5
 toMO9D/0f7D8krdFcNHQI5SbEy93Cdu/K5wZXFrWTTWMzMOrdGcYbFtuMoE9ldLThFnLn8d4HwQ
 7lJgee0UkCP8qioIC7Up7QjgccLVMDLng9UnUrN4YCX2NgH22FgmZCjyaOb0th05NduUyMgzYaH
 qjhctyoordWKmyzOVGoOnToPsPD23daTal+KIvzKxHrQOoXlQ4Jdb0lJ6BlnAeDldtSXmHQjzc2
 doX9nlB/jmX//rp3FJA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3645e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=45-e2YAC9sOU2Qo0GAIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050034



On 04/10/26 12:47 PM, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Do these waits run too late to protect the state that the channel
> callbacks use?
> 
> The only teardown caller of channel_remove() is ctcm_shutdown_device(),
> and it calls it after the net_device and its private state are gone:
> 
> drivers/s390/net/ctcm_main.c:ctcm_shutdown_device() {
>     ...
> 	if (dev) {
> 		unregister_netdev(dev);
> 		ctcm_free_netdevice(dev);
> 	}
>     ...
> 	ccw_device_set_offline(cgdev->cdev[1]);
> 	ccw_device_set_offline(cgdev->cdev[0]);
> 	channel_remove(priv->channel[CTCM_READ]);
> 	channel_remove(priv->channel[CTCM_WRITE]);
>     ...
> }
> 
> ctcm_free_netdevice() does kfree_fsm(grp->fsm), kfree(grp),
> priv->mpcg = NULL, kfree_fsm(priv->fsm) and priv->fsm = NULL. Under MODULE
> it also calls free_netdev(dev). The ccw_device_set_offline() calls in
> between can sleep, so a channel timer or tasklet can fire in that window.
> 
> The channel callbacks reach this state through ch->netdev->ml_priv:
> 
>   ctcm_chx_txretry() (ch->timer):
> 	fsm_event(priv->fsm, DEV_EVENT_TXDOWN, dev);
> 
>   ctcmpc_chx_send_sweep() (sweep_timer):
> 	if (grp->in_sweep == 0)
> 
>   ctcmpc_bh() (ch_tasklet):
> 	while ((fsm_getstate(grp->fsm) != MPCG_STATE_FLOWC) &&
> 
>   ctcm_ccw_check_rc()->ctcm_chx_iofatal():
> 	fsm_event(priv->fsm, ...);
> 
> The circular chain in the commit message also goes through priv->fsm or
> priv->mpcg. For example, mpc_action_go_inop() does this before it reaches
> tasklet_hi_schedule():
> 
> 	grp =  priv->mpcg;
> 	grp->flow_off_called = 0;
> 
> At channel_remove() time priv->fsm and priv->mpcg are already freed or
> NULL. Wouldn't that chain crash before it can re-arm anything?
> 
> If so, timer_shutdown_sync() only waits for a callback that is already
> dereferencing freed or NULL memory. tasklet_kill() also lets a queued
> ch_tasklet run against the freed grp.
> 
> channel_free() moves ch->fsm to CTC_STATE_IDLE, which has no handlers,
> so most late ch->fsm events do nothing. But that state change takes no
> lock. ctcm_irq_handler() runs FSM actions under the ccwdev lock, and for
> MPC ctcm_close() does nothing:
> 
> 	if (!IS_MPC(priv))
> 		fsm_event(priv->fsm, DEV_EVENT_STOP, dev);
> 
> As a result the MPC channels are not halted. An action that races
> channel_free() could leave the channel FSM in TXIDLE or TX with timers
> armed.
> 
> ctcmpc_bh() never checks the ch->fsm state, and ctc_mpc_flow_control()
> can schedule it at any time.
> 
> The ctcm_new_device() out_dev path uses the same order, but its channels
> were never started there.
> 
> Could both channels' timers and tasklets be stopped, and the subchannels
> taken offline, before ctcm_free_netdevice() and kfree_fsm(priv->fsm) run?
> That would mean moving the quiescing out of channel_remove() instead of
> reordering it inside channel_remove().
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the other fsm_timers in
> this driver seem to follow the same pattern: cancel without a sync, then
> free.
> 
> priv->restart_timer is bound to priv->fsm by fsm_settimer() in
> ctcm_init_netdevice(). grp->timer is bound to grp->fsm by fsm_settimer()
> in ctcmpc_init_mpc_group(). Neither timer is ever cancelled with a sync
> call. The only cancellations are fsm_deltimer(), which is timer_delete().
> 
> mpc_action_go_inop() always re-arms the restart timer:
> 
> 	fsm_deltimer(&priv->restart_timer);
> 	fsm_addtimer(&priv->restart_timer, 500, DEV_EVENT_RESTART, dev);
> 
> dev_action_restart() re-arms it for 1s in the MPC case. So during MPC
> group recovery the restart timer is usually pending.
> 
> For MPC, ctcm_close() does nothing. So ctcm_shutdown_device() then calls
> ctcm_free_netdevice(), which frees grp->fsm, grp (which contains
> grp->timer) and priv->fsm while these timers may be pending or running.
> After that, ctcm_remove_device() does kfree(priv), and priv contains
> restart_timer.
> 
> When one of these timers expires, fsm_expire_timer() calls
> fsm_event(this->fi, ...) on a freed fsm_instance. That reads the freed
> state and jumpmatrix, and calls a function pointer taken from freed
> memory. A timer still pending inside freed grp or priv memory can also
> corrupt the timer wheel.
> 
> There is a similar ordering problem in ctcm_free_netdevice():
> 
> 	if (grp->fsm)
> 		kfree_fsm(grp->fsm);
> 	dev_kfree_skb(grp->xid_skb);
> 	dev_kfree_skb(grp->rcvd_xid_skb);
> 	tasklet_kill(&grp->mpc_tasklet2);
> 	kfree(grp);
> 
> Can a pending mpc_tasklet2 run here after its FSM has been freed?
> 
> Should priv->restart_timer and grp->timer also get timer_shutdown_sync()
> before priv->fsm and grp are freed? And should mpc_tasklet2 be killed
> before kfree_fsm(grp->fsm)?
> 
> [ ... ]
> 

Both are confirmed pre-existing issues in ctcm_shutdown_device() and
ctcm_free_netdevice(), outside the scope of channel_remove(). They are
tracked for a separate follow-up fix.

Nagamani

