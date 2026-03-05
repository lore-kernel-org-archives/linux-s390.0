Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5A1E5702;
	Thu,  5 Mar 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722947; cv=none; b=dUwqv9vugK9H/bhfwzeVzm4QrBmYvFLplR2vwXkMEAUQvEfb5BnEqUxlAzvWCSvaSyRpoJXApj4KiG0+xXPuud9FkdFZ1iDfAzR55NhHmxUgp50KWP1UXDzof8b3rghg9q+2ut00aEv9Hf6D7DzJ94Ru+cpCJPwtcTCoFvCnico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722947; c=relaxed/simple;
	bh=QfhbVajT2+iJxHAN64UyxLFS+dMQwfQbCDnZgKB/W70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT74KHF9XLutkRZlKtttAzO4nBObJFEmz2QchC5iXkbgHyzNcaS4pzCAkEMR8L6emr/y0sz2HD7FIBqctgXeu8SUxtLW9xrRRj6oKyR8JFLJlweIcC/t3VWgQFj/5mqV3ltNn3IRSlQU9j4oRvOmx4mPDyjXTW8lFAdgrecNfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZ1TyYkA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZ1TyYkA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62513x1l2560406;
	Thu, 5 Mar 2026 15:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cUdxgVTBRKkuqFcqsMtldluXcHNLXC
	TvkiZ/QXHvf1w=; b=pZ1TyYkASrfsQdXxQWo5SIjYzFs3Bhrmp2Nq2/vv0coDir
	NP/jDRqvOTX9MqY52cOmnLInPRcTUW7v09BDCRQCB0Xlq4nwPe1EALuEtBxhSgpw
	lfwL9gjtf5pqlZJSfGQYiBVh71bNmcjrZKw9h9Ls4FOo9XoCC967MlIrT5WhGxxS
	kKfcIp3Oo9662D0J8bH9KQkTWYTX8s6cmBIfVegbdV5bhgHSZJyqsjBL+47eCs3t
	i+kvOCUAhnzGunbYNvnr0gP+jdcScTpZo+Gtx+VAJdM3pOJimwcaeaRrBaodXa5Z
	+MUIUWSbkZ9B5HyY57T5QjVkVum1PoIxclxF+1gA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjc8ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 15:02:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625DT4ZA029112;
	Thu, 5 Mar 2026 15:02:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsbvrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 15:02:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625F2CC012583376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 15:02:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F21612004E;
	Thu,  5 Mar 2026 15:02:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C962A20043;
	Thu,  5 Mar 2026 15:02:11 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Mar 2026 15:02:11 +0000 (GMT)
Date: Thu, 5 Mar 2026 16:02:10 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mikhail Zaslonko <zaslonko@linux.ibm.com>, linux-next@vger.kernel.org,
        linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305150210.7170D10-hca@linux.ibm.com>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
 <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
 <20260305124501.GB1395416@noisy.programming.kicks-ass.net>
 <20260305130725.GB652779@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305130725.GB652779@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a99af8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=eh9lVRh74qEsOkDO9VIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDExNyBTYWx0ZWRfX+KZ/9ZK13CwP
 Tlua3Ow3lVoyi+5W7Z4ELcyNBvG8fDTkv+wisEvAUkdGfnmGPSqlXR6wqHadarpwSa4c6Vt0ISq
 R54c0Kag3ISqo8df94o0a9U1UYNyEchlz8x+O46tcsdEN3iNCHtYS53RhLySrJ/ZvFaD/FavrPm
 XhrZlVRF9J7ifjBCJEiN8qy7wx7L1xovcquMoqzSzwdxyDwXIrnSVusq4zGpn0FYGtDH1cXbnPh
 ZeULKVZ4gW5NuF6zPXnF2z8Shs8m1gc1dNy9S78CssIPJGnZQhblnbjMKxuTlbPFlyFA6dSh5rB
 +6fMylEcf0giYlX9wLYQSGY+1eHMW1dXUKM73lOjynPZ6GK+slpl9Zs5XnkyDXA5n5ki8RNqnr8
 OjlfJjwB8rr2B1uqXbzg9ktQhw9Xma3Jr8d+lUuczFa6EwWVrDFPLX45PfvMrSEwEkdDZudzui/
 wCvzcVp9/Fxs1btsm1w==
X-Proofpoint-GUID: 3Me9obr6uypio5hX8WmI-YawuqHTPKfb
X-Proofpoint-ORIG-GUID: 3Me9obr6uypio5hX8WmI-YawuqHTPKfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050117

On Thu, Mar 05, 2026 at 02:07:25PM +0100, Peter Zijlstra wrote:
> > > Moving that before irq_enter_rcu() means it doesn't see HARDIRQ_OFFSET
> > > in preempt_count(). As such, it might actually call into schedule() from
> > > hardirq context.
> > > 
> > > Or am I missing something?
> > 
> > N/m, it turns into __this_cpu_add() and that doesn't have
> > preempt_enable().
> > 
> > 00d8b035eb71 ("s390/idle: Slightly optimize idle time accounting")
> > 
> > Is actually a correctness fix afaict.

Yes. Those dependencies become quite subtle when calling early into C code.

> Another change is that you clear I and E in the PSW bit before
> irq_enter_rcu(), which, per:
> 
>   7e641e52cf5f ("softirq: Prepare for deferred hrtimer rearming")
> 
> can re-arm the timer.
> 
> So where previously it would re-arm and still have the I/E bits set, so
> the timer could fire, they are now disabled.
> 
> I really don't know if this is a problem; I'm clutching at s390 straws
> here that I really don't know much about.

That's the old PSW where the interrupt happened, not the one with which the
CPU is running with, and shouldn't have any effect.

...but reverting that commit actually does fix it for me. I don't see
immediately any code which checks if the _previous_ context had irqs enabled
or disabled, since that is the only difference.
