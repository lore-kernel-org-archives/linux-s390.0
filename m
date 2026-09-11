Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038A414435;
	Fri, 11 Sep 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121591; cv=none; b=U6RFFgPH47Y4ozVGyGPGmuwl9uxn3b89Cu53VRcgFgIpQZ66hFyXhx183m2BUhJ01RK/QwyTWgp9Ty6U3HnGiNMTdouXW0l8jJAXmsaII/gGPnr3ZyX3a1pusLcYF+H4e8uPoJO59nF9ysgRezuQ3woBAd7892q/pyFQBMswQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121591; c=relaxed/simple;
	bh=pnVLSrAjCV56Xsa2nAbS199XrYVJIU0YKHVcEMyIwo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qd7JGcLu+5r9Ls2NNYlkUalyySz/NOfRbxy7zzwkTgiEMFRAtoBAQNyOemE2tL6JtsIN+LwY9nOHuIhx/NKsRXS5mdvGgWAGB9Cz7ixmohrBeSVvO3rCcLf4c+SpVEtbFH+CbBjMa2Z9kTRH7wPBqbZ8jA6SPHkw7+hppodb7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=luhaula8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="luhaula8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81Z6J1237483;
	Fri, 11 Sep 2026 10:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I36XyN
	DQD1DXpFTtggAs7XsC4VtvkGoxuq61QXkJuYU=; b=luhaula8tKEmSlBPpJPYki
	9SSfQ8ivvaEiU3u0AYTrR6o2v4eQB4xN3XZ+K4Ncs8yvFyD3UEccPgG0z+TEWnCs
	ojz2fmKHp+Oosa75oCQGrJ4VSy4tFXLebjoHDHHIBrQOEoSzhcwgpYL0SB+haLwc
	lNuEs/ETM6blbEfhYUqyPJfPAvbHKLG95GaKn1he7zUOnRnk1XyzYfOhsbpcOiwa
	3slliSHD2ow87LgCx/O+Keg7SpU83txqu4Bvj+2pbV4hXfZ70Xlzw7g32lPIlebE
	gXI2+JPC013x1BK2SVlh43iri99Ob0t/m73YajN2dkSaFPaxSzEDThT3/CyGRQwQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qtr7j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:12:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o8FX1318015;
	Fri, 11 Sep 2026 10:12:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfdpdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:12:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BACjit45416714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 10:12:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D296720071;
	Fri, 11 Sep 2026 10:12:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D921C2006E;
	Fri, 11 Sep 2026 10:12:42 +0000 (GMT)
Received: from [9.123.3.144] (unknown [9.123.3.144])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 10:12:42 +0000 (GMT)
Message-ID: <cac29eef-fb5b-403a-bfef-deac70c48e99@linux.ibm.com>
Date: Fri, 11 Sep 2026 15:42:42 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
        aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        kees@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        sashiko-bot@kernel.org
References: <20260907144511.3810194-2-nagamani@linux.ibm.com>
 <178900839135.219967.4379937251971534684@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <178900839135.219967.4379937251971534684@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa3d423 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=DXY4j925BDO8AIclqs0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t4THGQNdaSFO2ksEpioYWK8VfsrakR8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfXxsymMUM71/Q3
 PmnN4B4OLdmcUCMklD2hupn4wYD1rXLByoziEUqmajLSPQjj7ydElH2PacGp1eOm9+NnaC1Nqsv
 nscpP870deI9ILW+sWjUqjDqakJOzfkBksfNzG05GcPtNz4ozEqo8+dzR5T5EhErsX5azXdoM+g
 Se7volfR25/7X7/VohCp9evDO8+5WaOcMW1sNia99aUwOLx4mrUnlXSZibtLI5/TROXnA5JbqWj
 8rFkQF6KfqkEDIz4jAryX3ubZGpqWMTHj/YEwebcvgmPHt8qmiVUEZFx+j1u33usFCmq0sEp8Df
 kUEqlcr6OAYChzfjPZWrwJEn0wHPNldhlnhcUDI9w2z3JwWGvGlIyvD+fOOdzg3+tQLnxSMbMiS
 2w2Rvqzwiw+6PD98QjrgZ9RSr6PxJqungWsMqDaisD8EgH7kFJCmNOzvKMHVbtcKgEzk5xMUV/5
 FqkKsIRNQxgRKRy2dzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfXzmJFC5801JDu
 O7GMs6BhTkDlmIbSKXxkknSS7i219FG76QGEkf3bAZ/r+XBLjrLLP74OGa7MFSUY9PEpxoChtEP
 8prBqXplxSOr/w9/0p9rvebCX86jpLk=
X-Proofpoint-GUID: pWmAclbgDqPCyCorLYgPPtEe95FrdOhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110140



On 10/09/26 8:16 AM, netdev-bot+sashiko@kernel.org wrote:
> - [High] Incomplete fix: the commit removes timer_setup() from
>   fsm_addtimer()/fsm_modtimer() on the premise that "[t]he timer is…

This refers to priv->restart_timer — addressed inline below.

> 
> [Severity: Low]
> There is no symbol named ctcm_send_sweep() in the tree. The ctcm_main.c
> call site that arms a timer without a preceding fsm_deltimer() appears to
> be ctcmpc_send_sweep_req():
> 

Correct. Will fix the function name in v2.

> 
> [Severity: High]
> With this removed, fsm_settimer() becomes the only timer_setup() call site
> for fsm timers, and it is also called unconditionally. Does that leave the
> same corruption reachable for priv->restart_timer?
> 

Pre-existing issue not introduced by this patch.

> [Severity: Low]
> This now propagates the mod_timer() result, but the kernel-doc for the
> exported fsm_addtimer() in fsm.h still says:
> 
>  * Return: Always returns 0
> Would it be better to keep mod_timer(...) followed by return 0, or update
> the fsm.h kernel-doc to describe the 0/1 "was pending" semantics?
> 

Will fix in v2 by calling mod_timer() separately and returning 0
explicitly, preserving the documented return contract.

> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but with the timer_delete()
> gone, the two payload stores are now published with plain stores while the
> timer may be pending or its callback already running:

Pre-existing issue not introduced by this patch.

> 
> [Severity: High]
> This is a pre-existing issue, but it interacts with the switch to
> mod_timer(). fsm_deltimer() only does:
> 
> 	timer_delete(&this->tl);
> 
> which does not wait for a callback running on another CPU, and
> ctcm_free_netdevice() performs no cancellation at all for grp->timer or
> priv->restart_timer before freeing their containers:

Pre-existing issue not introduced by this patch.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but ctcm_free_netdevice() frees
> priv->xid with kfree() even though it is an interior pointer into an SKB
> data buffer that was released a few statements earlier:
> 

Pre-existing issue not introduced by this patch.

> [Severity: Medium]
> This is a pre-existing issue as well, but does ctcm_init_netdevice() leak
> priv->fsm when the MPC group setup fails?
> 

Pre-existing issue not introduced by this patch.

