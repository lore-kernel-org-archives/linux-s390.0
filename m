Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F6409275;
	Tue, 22 Sep 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074479; cv=none; b=Nnft7vaLQNyvacCejAzckSZg64eUQJgVcccuNPHdGo6f1NmCUdV/0FBtK3hRNmQDSFr+H8UCgTx6epd0wTK/W2Kbm/0DKAzUPHR83mTR9nBIrxTaRaMaOioG+5P4PaA9jKLjjP7yjCtMALbgd2S8vIB+x5Qm+T7b/4WT547XWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074479; c=relaxed/simple;
	bh=oJwNptDZcD5/WvZrtVwL7zTqFDuJc9l2duAZ3uiRITg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Irj6uUMqpg3ILlTljBHZ6XPTnWyWI35ecJKr75iOuU53ciW58sdfvgSMWY2O1Vv3+naZ9Btkbr1bzxf4fyBSolOIKiJRDpLrdGFHD0C5jAw7/N4YRg5hmsYJ/z6zZuAAR88eB+GXjKSe55Msfb+hKntvtWYBvZexp+83adZY70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fa9jPokF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fa9jPokF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05ZIA2980352;
	Tue, 22 Sep 2026 10:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ww5/Xb
	xna6uERz6s5dtWeyVzbQpR9YLcjUoFn223sgk=; b=Fa9jPokFTNXoFgMxfBKeQw
	9tb5pU+1J/9xUje+rJxAKIGMslC8twW/RUsIfkW2VAuXSx2/LiIo2XoLx5oNmTNF
	yWgZt1oT+9wkYMZwTledDVtvCIZrU6vzRXSViVhx1J0EX/XepXldYphQLsrRoRxF
	7FXWaYnuvGNewCKEA6YPz18IuUoTjJA1r+RugT8R40uWLhImQiar3OcyCueR9e4J
	EIevfOilqmgxjjnYaFEAooq4qYyxdghRuIiiqHjQSjkiyfExKJ0kdVdvm3f+hp5h
	mYhUqgYXoLHGQ6wQRbihSms3j/ewygRstqK+82u/DLj+/xTDmXmzJGI9shziorsA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv510s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:54:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MA4JAf2002282;
	Tue, 22 Sep 2026 10:54:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjsest-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 10:54:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAsLMw47120810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:54:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9425520043;
	Tue, 22 Sep 2026 10:54:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB2020040;
	Tue, 22 Sep 2026 10:54:17 +0000 (GMT)
Received: from [9.39.20.68] (unknown [9.39.20.68])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 10:54:17 +0000 (GMT)
Message-ID: <cca9b841-2719-4691-943c-d2aa7d7d98ae@linux.ibm.com>
Date: Tue, 22 Sep 2026 16:24:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] s390/ctcm: Fix timer bugs in fsm.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, kees@kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
 <20260916132149.4185912-1-nagamani@linux.ibm.com>
 <20260921161519.17f77cae@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <20260921161519.17f77cae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 45K6JPrXP6KjSpYEBAf-8J7JuMAwwlp-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1MiBTYWx0ZWRfX09QxjKQ4FvHs
 9BtOImu5MdUtOY9+l1mGK7fIOphJHENeIJ7ylt3rAzhI1wXL4F4XPyFYDOKGb2XP6pZqqmJrTJ/
 UJpxA5PCJ1H4RAXcgV11jjOmtjI03HM=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab25e62 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=9R54UkLUAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=DMUOFhj9m736tlyUx-QA:9 a=QEXdDO2ut3YA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-GUID: CtO8W81s9c5Ec54rVBiO-SMfEpt5BW61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1MiBTYWx0ZWRfX7bLhAw3TM9bK
 1gz0mJPMLKocDLp5wtyKHElJcl8UwYLGFEl+vZawl3plm4AjqVTAoy2nZA5MkDBNIQaOXT5TAQ9
 vCIgOF7P93b2Fw0klzYgwow/AyefnS/afnThCzoBSllIoj9S2LhbcH8pVE4IxUi6drWpCRTdEHY
 gNOD20ewCgijWRwitw/x/x58GUxqkIlILElYb2VJd2GdNe0rnJxh9uOyFxT80hPAH5d1E61fZy0
 ea0cf/ZUwpvT5wLgRbccvPVFaOR5rl9ric1jGOuWjWOM0ekuwooj6MSUC3fb8uHtlBj1hAwCjID
 FR8UjjKObWPzyoFiGT3UmsPvdXEgJt9C/UYhKmphnv1VIzdWndCr43Zu+cPI8EIYP6O9ayKMM+U
 pVtO6lIUpCJ2Sa1ACNedv2IEFCFfhfcL/FTHCLPX45oA9Tk0X4zvC/D9lH8fF6gzf0Rlyx9jNkd
 kVZDF6Ox/VlMy52QeIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220152



On 22/09/26 4:45 AM, Jakub Kicinski wrote:
> On Wed, 16 Sep 2026 15:21:47 +0200 Nagamani PV wrote:
>> Fix two bugs in drivers/s390/net/fsm.c found by Sashiko AI code review.
>>
>> Patch 1 fixes timer list corruption when fsm_addtimer() is called on
>> an already-pending timer - timer_setup() re-initializes the timer
>> list_head while it is still enqueued in the wheel.
>>
>> Patch 2 fixes a use-after-free in channel_remove() - timer_delete()
>> returns before any running callback finishes, leaving a window where
>> the timer callback can access freed memory. Fix by waiting for any
>> running callback to complete before freeing the channel.
>>
>> Changes in v2:
>> - Patch 1: fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
>>   in the commit message (Sashiko netdev-bot)
>> - Patch 1: call mod_timer() then return 0 explicitly, preserving the
>>   "Always returns 0" contract documented in fsm.h (Sashiko netdev-bot)
>> - Patch 2: add Fixes: and Cc: stable@vger.kernel.org tags
>>   (Sashiko netdev-bot)
> 
> Clashiko won't respond because of the unnecessary threading,
> but there are 4 high severity findings needing your attention:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916132149.4185912-3-nagamani@linux.ibm.com

Thank you for the pointer. I have reviewed all four High findings.
Two share a root cause and are addressed in v3, sent Tue 22 Sep 2026
as "[PATCH net v3 0/2] s390/ctcm: Fix timer corruption and use-after-free"
<20260922101913.239103-1-nagamani@linux.ibm.com> (raw). The remaining two
are pre-existing issues outside the scope of this series and will be
fixed in a follow-up patch.

--- Findings addressed in v3 ---

1. [High] ch_tasklet re-arms sweep_timer after timer_shutdown_sync()
   returns (Sashiko patch 2/2, finding 2):

   ch_tasklet (ctcmpc_bh -> ctcmpc_send_sweep_resp) can re-arm
   sweep_timer after timer_shutdown_sync() returns because the v2 patch
   killed tasklets after stopping the timers.

2. [High] kfree_fsm(ch->fsm) before tasklet_kill() races with a running
   tasklet accessing ch->fsm (Sashiko patch 2/2, finding 5).

   v3 fix for both: kill ch_tasklet and ch_disc_tasklet first, then
   timer_shutdown_sync(&ch->sweep_timer.tl), then
   timer_delete_sync(&ch->timer.tl), before freeing ch->fsm.
   kfree(ch->discontact_th) is also moved into the MPC teardown block
   after tasklet_kill(ch_disc_tasklet).

--- Pre-existing findings tracked for follow-up ---

3. [High] grp->timer / priv->restart_timer not cancelled before free in
   ctcm_free_netdevice() (Sashiko patch 1/2 finding 2, patch 2/2
   finding 1): predates this series (commit 293d984f0e36), out of scope
   here. Will be fixed in a follow-up patch.

4. [High] NULL deref on peekskb->len in ctcmpc_chx_txdone()
   ctcm_fsms.c:1299 (Sashiko patch 1/2, finding 1): skb_peek() returns
   NULL when collect_queue empties. Predates this series. Same
   follow-up patch.

--- v3 summary ---

  Patch 1 (fsm.c): unchanged from v2.
  Patch 2 (ctcm_main.c): tasklet_kill() moved before timer stops;
    kfree(discontact_th) moved into the MPC teardown block.

Aswin Karuvally will review and test the new teardown order.

Nagamani
