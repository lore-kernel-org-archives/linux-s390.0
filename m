Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF868389E1F;
	Wed, 29 Apr 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485043; cv=none; b=oiuIlhtZDwhLp92fdjA2XXajKeOpOFjlSizZYvIGBGBsDbl61aZfEItGg4MvRE9mqMFlenvTBAKKx8/IbQSWjL/5Fqn2r6bFgDKWnHind10PwPh0M0X+Bo++gZ7RiJ++eZW/RV1DaEOg3WEZWL8i+K9V2dH83N1301iqjlfjXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485043; c=relaxed/simple;
	bh=lhRf8bewji/NelXAkO7rmLVJYVeaXGPrbJ2hXNF+bDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b71dHrOOosnJYd0MHQzOs8rbqC+v+0XkYfkmqAnNB8xaA5A6Nt6LXTPCa5rw/sLBUgF3Rk5G8E9xP6ep9wB7NZukvP1N4LDA88XPFZbDXBCQyXLwOdfx3/ZpX7m3aftSVqBt0FoPNO+WQJXu2L0UVQnrzFXy/fiSw/LQcL1F57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCG3EX35; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCG3EX35"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T9UTSP2713609;
	Wed, 29 Apr 2026 17:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=g5YB4BVbp2W0wvk5RiZ2cwAxL3ZGaT
	OsLR9ddNKjQJw=; b=mCG3EX35x1+9nauHxwSW+Dg9Tdy7tjfgt25iqT54uuY++u
	rKzUhS31wFdYd/pXuZavzdBbg+wmUPy5pVBwvv/Jm4GGCS/rGZvII8UCaERswdgu
	mczL5zF9YkuA0JjJA4vD0xc31NojUCiTfsInPCSOEw4IHohrxrJDEyce0ggKweBx
	vILaBkrDXRG7mu22gplGadkWa0+mWYxduVA74OGRrFSBNDqLDo2YOHqunDF6FDXB
	hFKprRxfb1Ua3Jgajt8YU1/x2KMPpZPdKNRVShLu5FyJTXIoY57edHMUhAjehsiY
	OAWDu5R7+s7tVVnnRYXHRCzLYKt/kL1g4Pf1PBKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rbv24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:50:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63THckjJ025518;
	Wed, 29 Apr 2026 17:50:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk7dm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:50:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63THoX8E37683626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 17:50:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE70D20040;
	Wed, 29 Apr 2026 17:50:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 614B32004D;
	Wed, 29 Apr 2026 17:50:32 +0000 (GMT)
Received: from localhost (unknown [9.111.69.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 17:50:32 +0000 (GMT)
Date: Wed, 29 Apr 2026 19:50:31 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Samir M <samir@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <tte9o87@ub.hpns>
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
 <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
 <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>
 <ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aJHM6d5iFPfNqsvjoGjEIpHZ14HvB_FO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3OSBTYWx0ZWRfX273QpL4dFyxg
 uQcN7guOpg0Feots4fD555NjgWCbQNRdu8Jv+9aFR1TpvV5ZlMzwd+kMqCLxDqfB23ZwP9FETcF
 1BvxZTU7GrYFh+cTGa9DX3KLSnElJ7+gD/e54d4TRn4CIk5Ecx+SA0S/ouXIMVEYL3TAXlvdkFr
 wurjMqbUSmiN051cCN4aLS02mxoX78fHfXSHjVHkdWY4NCuSpUjwlxDpxux/xEPaqV0OZPzBgAz
 qPgW24aihpZP0fKpulzYfYXxwbcM4rorXKnR+v5CN2RCxGyL7ZtdVkAp/CfnA1fDKRAeqH2nfRZ
 Gz3/Ke8iUVlhciIgdewLswDmyYiOc3p3F0mWwniR2aMcTNcPk1ontfDVPjwUEOGa9h6herD1A22
 cVVC5SdOTU54r5xweq07c0/ciJ/1dkjalsvQTsbV5kT8FnLg9rvsGXbuiUE+oO59E5evkf/sBka
 qm1QMmmi557FLvcBI7w==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f244ee cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bll54Tbc3Bfas-WANKEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IsuJ-D0pI-qdWZz_qQOLMIgB-ukfAK90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290179

On Tue, Apr 14, 2026 at 12:24:12PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 09, 2026 at 09:03:26PM -0700, Paul E. McKenney wrote:
> Please see below for the full patch, including refraining from queueing
> workqueue handlers on not-yet-online CPUs and diverting SRCU callbacks
> from not-yet-fully-online CPUs to the boot CPU's callback queue.
...
> commit ce533a60b2ef29a9b516cc717e77c6b679bc09c0
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Apr 9 11:16:02 2026 -0700
> 
>     srcu: Don't queue workqueue handlers to never-online CPUs
>     
>     While an srcu_struct structure is in the midst of switching from CPU-0
>     to all-CPUs state, it can attempt to invoke callbacks for CPUs that
>     have never been online.  Worse yet, it can attempt in invoke callbacks
>     for CPUs that never will be online due to not being present in the
>     cpu_possible_mask.  This can cause hangs on s390, which is not set up to
>     deal with workqueue handlers being scheduled on such CPUs.  This commit
>     therefore causes Tree SRCU to refrain from queueing workqueue handlers
>     on CPUs that have not yet (and might never) come online.
>     
>     Because callbacks are not invoked on CPUs that have not been
>     online, it is an error to invoke call_srcu(), synchronize_srcu(), or
>     synchronize_srcu_expedited() on a CPU that is not yet fully online.
>     However, it turns out to be less code to redirect the callbacks
>     from too-early invocations of call_srcu() than to warn about such
>     invocations.  This commit therefore also redirects callbacks queued on
>     not-yet-fully-online CPUs to the boot CPU.
>     
>     Reported-by: Vasily Gorbik <gor@linux.ibm.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Tested-by: Vasily Gorbik <gor@linux.ibm.com>
>     Cc: Tejun Heo <tj@kernel.org>

I retested it on s390 and on x86 KVM with --smp 16,maxcpus=255, all
looks good to me.

FWIW, again:

Tested-by: Vasily Gorbik <gor@linux.ibm.com>

Would you mind adding Cc: stable so it gets picked up for v7.0?
61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
non-preemptible") is what made it reproducible for us.

Thank you!
