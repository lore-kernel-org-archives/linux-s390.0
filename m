Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0236B933;
	Thu,  1 Oct 2026 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854558; cv=none; b=ELt4kBDkCbQ7CVKGxY8DZf143y6NLmUA7hd5hoWhd1REG32KFwqR8sexBbbvRg6roqyPem0fO4PA4dHR5QjJL9LdwddvALFlYrhWTny4ogGRB55uvWXGps4gvng49bm/8r9T9okIHHuynkR3UYj0aQ0xxAREuAgqNLubNGvv/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854558; c=relaxed/simple;
	bh=lGFFrJe+RgFlecAKuz80arX6emlndUmD4SkJpmFmvvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4tL9thkrXmreTRoDietuyvvYwMc/bgJDo118HJuge9PohZ80wC4hvjMIcV0c2SCEKSRZaB+JOEsuRqNKU4FJodpIdsvW1I9Yzn6lbfE5mEB4hRy01RR6mwnjdoLV31ytddx1HrbLproRabGyoYHEOmyW/feZ2YYrG4hKlHTFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IuRU28aq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IuRU28aq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691761DI4041238;
	Thu, 1 Oct 2026 11:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BXSEfh
	I5lU6UswsTTYHzTEZj3EyFOnaL4T58FFbIq60=; b=IuRU28aqz+uTk3oScaeb2R
	/zVmc173mlWtqGOSbr+IMoAyYiptk7DUDPkZ6yh8e4F4Y7wlBSfCOH4syQfU6dgC
	R6e6kZvOKmXiO5izJeQUmSlDkefx8UqT2hK3sEJ0QyYSbibCh/z7prMl95X/Fey/
	KQDWnb0e44hdILgldBMpWZdNPqZRZLXOYQ8qSdE9urZI7mS3Z5buzSne2YE0ZQAt
	rp3340Xz+seTCL4R0WkklgQhoYzYPoAOwZBKInUp1sHg7DxNVi8+wn+Cm1u2+8Be
	ZEWtDyjk0jFwNCsVcDVek8pELr4LFNhMWPGG1HPW2LZTzxI58TdwPvh2X7pjzFww
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehq5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:35:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BQIUe557930;
	Thu, 1 Oct 2026 11:35:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23rap2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:35:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691BZfwC31392078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:35:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532A92004B;
	Thu,  1 Oct 2026 11:35:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7CD020043;
	Thu,  1 Oct 2026 11:35:38 +0000 (GMT)
Received: from [9.123.9.250] (unknown [9.123.9.250])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:35:38 +0000 (GMT)
Message-ID: <a94e9796-7ec2-4ff7-b5b4-f6ca24107de9@linux.ibm.com>
Date: Thu, 1 Oct 2026 17:05:38 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] s390/ctcm: Fix use-after-free in
 channel_remove()
To: Nagamani PV <nagamani@linux.ibm.com>, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: wintera@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <20260930070234.569500-3-nagamani@linux.ibm.com>
Content-Language: en-US
From: Aswin Karuvally <aswin@linux.ibm.com>
In-Reply-To: <20260930070234.569500-3-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe4592 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=PrirHVnjloWTi40jdTwA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX0hEqk59bFJ+S
 lxZuuqupndeWnquF2bRfDVT/ky3onI3iPkDhDpB+ssCOU6H9hCOj3/ykTuIZdHW7TSOmkexIjVG
 boxUwQ6SnQ9R10mIhv+0jKapZB79YUk=
X-Proofpoint-ORIG-GUID: wfg8VDe2CyADVf4CRk6MGGnzdsewoJ_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX9z17szy+JpWn
 v7tzQfM0aHfB+rp9vbCt6iyXenjC0U9GMZcCy7E+XL1AlQPSI8yW8AIbQ1vPfhUHbwZJriT3HRg
 P5VrQktYxLKJMsXby9voQCPREtW4Jh1laujQejoT9hozSNzd4nLz5Ax6Ik26PUATglGVWMJYnf2
 IYQUiAYy9h9NnK3QbEMGwP9JOcwFWjDlzx8XxZ2goLKMNCYoCtH0rcnI+TnSVPkQa7VtQtutZjJ
 kqDAdh8z+6YD78d8qmxZJ0w6yG7F9kfxQ10/nWCdlcARBvoDoKf8qARDYNiQBxeFrxYA3YHtMQa
 gz+J/Alm/R+IXasisnAg1z6QyjBmcBG/aQR/VIuIAe7PfhfKAVVrbdxshMT0wwAkSjBCInzWfZ/
 w1nnJxGCkw0iocT7uT70yQc8UUs/gzOR2Hn4KSK2CaXgsFB6NoJw18o2byEZHe8tezJltjoOQ31
 01NKw7+C9oYkRU7Oquw==
X-Proofpoint-GUID: qMSu5Lovk2w0u3f0JF-ANdOr5r4xTyC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010046

On 30/09/26 12:32, Nagamani PV wrote:
> channel_remove() uses fsm_deltimer() which calls timer_delete(),
> returning immediately even if the timer callback is running on
> another CPU. This leaves a window where fsm_expire_timer() accesses
> ch->fsm after kfree_fsm().
> 
> For MPC channels the teardown has a circular dependency:
> 
>   ch->timer callback -> ctcm_chx_txretry() -> mpc_action_go_inop()
>     -> tasklet_hi_schedule(&ch->ch_disc_tasklet)
> 
>   ch_tasklet -> ctcmpc_send_sweep_resp() -> fsm_addtimer(&ch->sweep_timer)
> 
>   sweep_timer callback -> fsm_addtimer(&ch->timer)
> 
> Use timer_shutdown_sync() for both timers: it waits for any running
> callback and permanently prevents rearming. Shut down sweep_timer
> first (its callback rearms ch->timer at ctcm_fsms.c), then
> ch->timer. Only then call tasklet_kill() -- catching any tasklet
> scheduled by an in-flight callback before shutdown.
> kfree(ch->discontact_th) follows tasklet_kill(ch_disc_tasklet) since
> ch->ccw[15].cda points to discontact_th and
> mpc_action_send_discontact() starts I/O through ch->ccw[15].
> 
> timer_shutdown_sync() is also used for non-MPC ch->timer:
> ctcm_chx_txretry() (CTC_STATE_TX + CTC_EVENT_TIMER) calls
> fsm_addtimer(&ch->timer) on both paths.
> 
> Depends on "s390/ctcm: Fix timer corruption in fsm_addtimer()" which
> replaces add_timer() with mod_timer(). mod_timer() on a shut-down
> timer is discarded; without it fsm_addtimer() calls timer_setup()
> defeating timer_shutdown_sync(). Backporting without that
> prerequisite is unsafe.
> 
> Fixes: 293d984f0e36 ("ctcm: infrastructure for replaced ctc driver")
> Cc: stable@vger.kernel.org # depends on: s390/ctcm: Fix timer corruption in fsm_addtimer()
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260922101913.239103-1-nagamani@linux.ibm.com?part=2
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
> ---
> Changes in v4:
> - Shut down timers before tasklet_kill() rather than after,
>   shutting down sweep_timer before ch->timer.
> - Use timer_shutdown_sync() for ch->timer on both MPC and non-MPC paths.
> - Name prerequisite by commit title and add structured stable tag
>   dependency (Jakub Kicinski).
> - Code changed; Reviewed-by and Tested-by dropped.
> 
> Changes in v3:
> - Kill ch_tasklet and ch_disc_tasklet before stopping the timers and
>   freeing ch->fsm: closes freed ch->fsm access from tasklet context and
>   eliminates tasklet-driven sweep_timer re-arm.
> - Shut down sweep_timer with timer_shutdown_sync() before deleting
>   ch->timer to prevent sweep_timer callback from re-arming ch->timer.
> - Move kfree(ch->discontact_th) after tasklet_kill(ch_disc_tasklet).
> - Drop Reviewed-by and Tested-by; please re-review and re-test the
>   new teardown order.
> 
> Changes in v2:
> - Add Fixes: and Cc: stable@vger.kernel.org tags.
> ---
>  drivers/s390/net/ctcm_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> index 8b0d76a47d9f..27a22dbc9280 100644
> --- a/drivers/s390/net/ctcm_main.c
> +++ b/drivers/s390/net/ctcm_main.c
> @@ -211,9 +211,14 @@ static void channel_remove(struct channel *ch)
>  	while (*c) {
>  		if (*c == ch) {
>  			*c = ch->next;
> -			fsm_deltimer(&ch->timer);
>  			if (IS_MPC(ch))
> -				fsm_deltimer(&ch->sweep_timer);
> +				timer_shutdown_sync(&ch->sweep_timer.tl);
> +			timer_shutdown_sync(&ch->timer.tl);
> +			if (IS_MPC(ch)) {
> +				tasklet_kill(&ch->ch_tasklet);
> +				tasklet_kill(&ch->ch_disc_tasklet);
> +				kfree(ch->discontact_th);
> +			}
>  
>  			kfree_fsm(ch->fsm);
>  			clear_normalized_cda(&ch->ccw[4]);
> @@ -221,11 +226,6 @@ static void channel_remove(struct channel *ch)
>  				clear_normalized_cda(&ch->ccw[1]);
>  				dev_kfree_skb_any(ch->trans_skb);
>  			}
> -			if (IS_MPC(ch)) {
> -				tasklet_kill(&ch->ch_tasklet);
> -				tasklet_kill(&ch->ch_disc_tasklet);
> -				kfree(ch->discontact_th);
> -			}
>  			kfree(ch->ccw);
>  			kfree(ch->irb);
>  			kfree(ch);

Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
