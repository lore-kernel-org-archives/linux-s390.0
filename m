Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DC2264BB;
	Thu,  9 Apr 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762160; cv=none; b=j2KJXIaadhTsO6SEwX6rAKYiqURPbfw9mCsV94lKYLZiB6RxNcbqZ3I66GFzXnP4uvb9GcB4UuPvW+yjvObX+0XVSGFPU72uIZ17ezf0HQ7o/hyrNa3UiRNK2C4sMWI+2Sf7UI8tUJefGEq7Fv3r+97ZJbs7ZsqVo0xV5cuMSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762160; c=relaxed/simple;
	bh=Opq7xvofjjocGm5fwRaggibvwSwagvZe6zqC2uYa5ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfUNobLHcvviabhYO5urLRmhjRC2lIHdeOe9fOPWG1wUpXEmj1vkfgYupvmfHeykr6HleQqfNekEquVIcjyeJVf9bqiqzkl955d6BvNSaQHmph4i6LueFa6Y6izl1CiB6L8uIFkdbJoIOIu4YnG+KYS5ojr3egqrQtt/zxG+KC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XipkI61k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XipkI61k"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639BdNUY2592837;
	Thu, 9 Apr 2026 19:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qE6PopG5fwHxsdPlTedntttRx+DfYp
	VovcD4WeJmGkQ=; b=XipkI61kNFrgPhyuT1VtzvYqZ+BgTHWDs+ubPCSeoFGHF8
	HYOBVxyzsEHc+zKdoBr1+J3PaDD+q0SrzP5lzoiajkJwl7rd+Dqxrsk77YUKC2sv
	7U0SoE2+G9e24lKhust+/ttl6Fwjp8ddC/1H8XxQRBek9UjR5qflLv2sq3kb1sho
	me9auoB494Lzo2e3tz7fnbXa+Ptk5HIXzXkSEHIawBZ5SJZuty4wRxiePt1CHJcQ
	cPSfVLerxvmzQGgkgnV2H4oZkgZaqK3bGeqIwt8Ao+ZXmq9mvSclXDxl4JfwBnuf
	Bv1QrtZDsbnmQ9ZTe9k0a08NCn0ZyPxWYDWhkqdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2eerra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 19:15:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Gog8B013821;
	Thu, 9 Apr 2026 19:15:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4d24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 19:15:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 639JFq1p58393038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 19:15:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A5C20043;
	Thu,  9 Apr 2026 19:15:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB44720040;
	Thu,  9 Apr 2026 19:15:51 +0000 (GMT)
Received: from localhost (unknown [9.111.74.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Apr 2026 19:15:51 +0000 (GMT)
Date: Thu, 9 Apr 2026 21:15:50 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <ttd8que@ub.hpns>
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JspFivbzalbHUM_sdvqniH2UHA8KECcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MiBTYWx0ZWRfX1mkEI4dImjVS
 /RQlUI+nS5+LX7buHEWeeRla0EtdlPhbOeqMQJwarFxgPcIlsTA2i0bRf8eoOCwIXWLHxO+pfKn
 RL4kfVp4vFf1vsTx7WPQYar9gNEz178W6Ed6oPBiReSflQLOyCgyfkGBNRfBqOzcxYyAF5lO/XX
 w5vRyXmKFOzrF0DcVFZHauRrEqI+ijM0vSaM9HuWa9hxxfXbQiov4PFuEblc4X0F0mHn4XnBy4j
 rlI2lqkTxHgvJDrS2biHvHP3fwhEgQb26+z8L5aoNhLunIaOif6xG0EKwl8igriWNHe5OLxiq+o
 WoAG8pxjZA7FFFHxjdTdSwB3jYeckuU/Tuw/q4WRESSb8K/He0fucMIwuPiNPeygKRaLaf0FhKz
 g81EbwXxukI1SM3pNT0sUHLxekiZD7vomi4K73PrpcVYhiELLIv9X6pCNk0K6dWRT9PDzzAvfit
 8sBjU0w6St+KTHVTm5Q==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d7faec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bBiyz3D5M7uGEuQJfksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tLDVSCXzY-FTS2413_Y22Fwz-Kvfyg20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090172

On Thu, Apr 09, 2026 at 10:22:00AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > non-preemptible") defers srcu_node tree allocation when called under
> > raw spinlock, putting SRCU through ~6 transitional grace periods
> > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > per-CPU pools directly - pools for not-online CPUs have no workers,
> > work accumulates, workqueue lockup detector fires.
> > 
> > Before 61bbcfb50514, GFP_ATOMIC allocation went straight to
> > SRCU_SIZE_BIG, the mask = ~0 path was never reached.
> > 
> > Affects systems with convert_to_big active (auto when nr_cpu_ids >= 128)
> > and possible CPUs > online CPUs. Hit on s390 LPAR (76 online, 400 possible),
> > where possible CPUs > online CPUs is the usual case.
> > Also reproducible on x86 KVM --smp 16,maxcpus=255 (CONFIG_NR_CPUS=256)
> > or simply -smp 1,maxcpus=2 with srcutree.convert_to_big=1
> > or --smp 16,maxcpus=64 with srcutree.big_cpu_lim=32 (CONFIG_NR_CPUS=64)
> > 
> > s390 log (76 online CPUs, 400 possible, all pools 76-399 stuck):
> > 
> >   BUG: workqueue lockup - pool cpus=76 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   BUG: workqueue lockup - pool cpus=77 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   ...
> >   BUG: workqueue lockup - pool cpus=399 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   Showing busy workqueues and worker pools:
> >   workqueue rcu_gp: flags=0x108
> >     pwq 306: cpus=76 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> >     pwq 310: cpus=77 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> >     ...
> >     pwq 1598: cpus=399 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> > 
> > Not sure if replacing mask = ~0 with something derived from
> > cpu_online_mask would be racy in that context.
> > 
> > [1] https://lore.kernel.org/rcu/acRho9L4zA2MRuxc@tardis.local
> > [2] https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop
> 
> This was a pre-existing bug, but the change made it much more likely
> to happen.

Yes, indeed.

> Does the alleged (and untested) fix below do the trick?  The theory is
> that if a given CPU has ever been fully online, it has workqueues set up.
> Directly checking whether a CPU is currently online is vulnerable to a CPU
> piling up lots of SRCU callbacks, then going offline.  So we do need to
> be prepared to invoke SRCU callbacks for CPUs that are currently offline.

Yes, tested on s390 LPAR (76 online, 400 possible) as well as
on x86 KVM with --smp 16,maxcpus=255 and CONFIG_NR_CPUS=256
no more workqueue lockup in both cases.

Thank you!

Tested-by: Vasily Gorbik <gor@linux.ibm.com>

> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a7..e68ee7f69e1fc 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -898,7 +898,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>  	int cpu;
>  
>  	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> -		if (!(mask & (1UL << (cpu - snp->grplo))))
> +		if (!(mask & (1UL << (cpu - snp->grplo))) || !rcu_cpu_beenfullyonline(cpu))
>  			continue;
>  		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>  	}
