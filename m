Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426653E5EF9;
	Thu,  5 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740119; cv=none; b=owlUSvTnSVx9HIihYvWWkJAs2q9Haw210s0NofcsiYiJgg7rDOYnVY52cBAOmRMyQvh8/Hn4L7nI3N878g2GvQ2ve2CUSNjRlVGCH6Qm7HvtZqmarKPv2vP14ME0jL1ZvB2zIG5ZxULSCdcbNR+WWyvxkKfxxbHqIi9ke+aUumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740119; c=relaxed/simple;
	bh=TC6gTWg2gKDiToECZ7YSdDHYU0+yLGYcGfvxjJxhTGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWmGafoesJcIPgvNDae/Bp5nc36p6/9y7YoKI2qZysz1zJV6py4SEPIRRHXyqK2CYrcGcZdjXtRX0ZH6DtzrSXyIHSC0rU0Qnxn7fJJjT3zRV3r0cW7r9+5nCtnvVuNA84RRJip+MF2l+itDgYusik6Vm87LiShRV3ZWdUg/48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ReIVWHtY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ReIVWHtY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625GbT0E1968518;
	Thu, 5 Mar 2026 19:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PaIwnidmPpUXTzxTtpJ+ZE4SilWqz2
	AnXHYQ/tzIUVg=; b=ReIVWHtY5vguCZiA2lMFq/Zf3F7Z+uEd64mBJrXMEzorwA
	DXalJC3fTEs38niueC7Tj75BCQWJ+l9ssWHyxnWrl9ot/vv4483RkfjS/3DuqsLA
	QZ9kr2O6OXN/ptQLwHTFdZszdCLmKAHZl777UReLT9Z+QGg6+ROVVy0BeP8IuY5y
	kUcvfcORHUekQmHghB6SSMCJf/COhy2k64Hc/CEYUd8AEaw8vTWSYJYXwJ0iADdt
	JtGqdKwNKEwTeW6jQJ5G8PXO2K5WR5nggpq5D8EcTW4jHPpps53VU3kdUSmFtXD6
	+ORzbARKeajQeNMFZhvXR/kScWPSjMF2lC6kEa7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk44xxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 19:48:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625HYmmZ011236;
	Thu, 5 Mar 2026 19:48:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2sdse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 19:48:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625JmN4H46727560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 19:48:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8948620074;
	Thu,  5 Mar 2026 19:48:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A0620063;
	Thu,  5 Mar 2026 19:48:23 +0000 (GMT)
Received: from osiris (unknown [9.87.155.84])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Mar 2026 19:48:23 +0000 (GMT)
Date: Thu, 5 Mar 2026 20:48:21 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-next@vger.kernel.org,
        linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305194821.8663A9e-hca@linux.ibm.com>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
 <20260305074922.7170Ad3-hca@linux.ibm.com>
 <20260305121201.GB596554@noisy.programming.kicks-ass.net>
 <20260305123505.GA1395416@noisy.programming.kicks-ass.net>
 <20260305124501.GB1395416@noisy.programming.kicks-ass.net>
 <20260305130725.GB652779@noisy.programming.kicks-ass.net>
 <20260305150210.7170D10-hca@linux.ibm.com>
 <cfd76996-ecae-4ed9-add0-70ca2e59ef11@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd76996-ecae-4ed9-add0-70ca2e59ef11@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aoE729KLzwmwOg3HuJ85cp9VEJ0pVU_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE2NCBTYWx0ZWRfX5iLlZn5O/PEq
 87GYPRFUbgVhVEXOHgHarct+0F0R/X43avO3wPH1nhqBjOGC01iajblI/OrtgO7ZK4yi8VbFl2S
 YUS2Yib4qUegF3Lh709C3WlBwPcH5/UgZUvCu9dHR2VdQII+oiOsT2q+OGe1fi8y0C8gJh0YHZM
 cKYBjn/IsEuwB1Bl3KQ6HM5kwpaVPRzPS3ksdnjpbMoPuHiWCD3ZpWq22JXkxwQltK2qFT/DmLi
 EMJ6pGyANgqITKgTCABs0sxho8DUmsiUV10Sxz+j13CqZ7yX1X5iWpltcpB1mnuTuXMIT7EnXt+
 iPPywAkIFdx4cb9BD43xEGnVRDnWYt21/96HSxy8VMiY88i+0LztBsVANhrxMfn8+Nv9amoro1V
 DVjaoH4HCCLoxe+o6teddMfPWsfxkeQyMGiynDTeRtLfQ8SEA8JgjOWpac2qATEN4aXwSu2wa6Q
 DDnJ/bauKZkaCgI2h6A==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a9de0c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=HJzEO1QZ-oQFQT59-5gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aoE729KLzwmwOg3HuJ85cp9VEJ0pVU_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050164

On Thu, Mar 05, 2026 at 06:24:48PM +0100, Mikhail Zaslonko wrote:
> >> Another change is that you clear I and E in the PSW bit before
> >> irq_enter_rcu(), which, per:
> >>
> >>   7e641e52cf5f ("softirq: Prepare for deferred hrtimer rearming")
> >>
> >> can re-arm the timer.
> >>
> >> So where previously it would re-arm and still have the I/E bits set, so
> >> the timer could fire, they are now disabled.
> >>
> >> I really don't know if this is a problem; I'm clutching at s390 straws
> >> here that I really don't know much about.
> > 
> > That's the old PSW where the interrupt happened, not the one with which the
> > CPU is running with, and shouldn't have any effect.
> > 
> > ...but reverting that commit actually does fix it for me. 
> 
> For me it doesn't. But reverting this one helps:
> 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")

Mikhail, which commit did you revert? The above discussion is about commit
d8b5cf9c6314 ("s390/irq/idle: Remove psw bits early"), which is not
explicitly mentioned.

But it is indeed broken: irqentry_exit() has a regs_irqs_disabled() check,
which I broke with this commit - but "only" for idle exit.
Result: no hrtimer_rearm_deferred() being called on idle exit.

Oh well. Peter, thanks for pointing to this broken commit. Will be reverted.
