Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81938DC7C;
	Tue, 18 Aug 2026 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072340; cv=none; b=KxoMnQpArEEfInJ3pceddSMgR3KDQ9BsttWxslo/wzfFTSEzDLxMRZwya15Xi5VeeU/MONV7rBkZg/bElf8AFr+4VskF9bLURVrwAzc0b9rJKq13sQWrmpMdNL4RPUR4rNfmEdKULIm6k0MUaLmcPUGUDFj+0gSVLIawog9bt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072340; c=relaxed/simple;
	bh=qB96Myp3e87pGsgQvOtWd+Q1UZwg8qA6pnBCbcn8vaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5EAL0Dqut8GL9gOzYRRjxGYcMjiONB3YUWDyYBPcfk+quVcI+Un1AjT+lM2H9ctxm0zf4cwP/uNdCl1ffqtb4j4BpEKNLgRtdokTQvL9E3J2hfR6p/ex2XipGF9IfI5Cl9y/EZhX+8o5ksMtAZ3KdpFlZDi2FrHv3Fp//DxdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxqY6BmR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxqY6BmR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3d063582558;
	Tue, 18 Aug 2026 16:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xSaa5a
	d9whBZM6BpEFa4Guwjm1yMPlDrT+vSCA8TNWw=; b=fxqY6BmRibgrvn8pRFDWIs
	IslCLFmwj8Z48q4o5+vdRB4f5l33KZFSRlN6NufWzj2WqDK0Rli0GKAHZBwfA9iZ
	6Z+SEEVB02GpU4a3KRScfliwTgYbcUfQloTSKDaO7PgPY3AyFuE1UWuzZOOqnj1N
	qhnJZw5sudgHYRDJ5+KTkL/MJFTDhw3ay4jlbqQbo+gSwYgSbWOrMtmFB8IF74K3
	VcJSqSFvyMDRDxi4U6JVc/bcV0q74xxAAAP2ete+KVx1QV+Lx3jr6HDbTI4kdnTA
	HTFnxY9gzXoINGpNYii8oXu4mAuSbqXuHn8cI8SsbuBfO2pnp6jWmiBuambVMYlg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe972a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:58:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGuPDC006658;
	Tue, 18 Aug 2026 16:58:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh49sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 16:58:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGwrxi45220120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:58:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C2520043;
	Tue, 18 Aug 2026 16:58:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC4820040;
	Tue, 18 Aug 2026 16:58:52 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.2.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 18 Aug 2026 16:58:52 +0000 (GMT)
Date: Tue, 18 Aug 2026 18:58:50 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        Eric
 Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
Message-ID: <20260818185850.0a522630.pasic@linux.ibm.com>
In-Reply-To: <4f233ae1-2a30-4498-bd5d-2a001c96b2d8@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
	<20260817122849.9F8061F00A3A@smtp.kernel.org>
	<3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
	<20260818163226.68c6bea4.pasic@linux.ibm.com>
	<4f233ae1-2a30-4498-bd5d-2a001c96b2d8@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX/dL/8Mx4u2xg
 igyTOnPKN6vK4FIb/Hnj0K7LeRrFPzzE7ofeacGKrFTWhEue4uPP71HdwlI0gVklpr6lD0b2X+s
 Qx7hq+pguLRq7ELH/eTkXm8V9l0Dzmqo9KE6HG529T1kfG2Vwat6+nOhIa+Yb2OLQbCNY9Z80BS
 wOE8xSL9yfGy0dwczJXSZP5Y7HuIPPLCvlA5LC3146EkSmr770aC9lTq/K9RE4twJoIR/WiA+94
 6PovJdudJobwgWwObdRLVt4EGZKj+wOmbxVxwTSvwLpSF2+l2h8OLjcspnsyTYXQXie7PGaHPun
 yds7RhnjsDdg4RFxW7TH7/dQgcqBbdHVE1nvIf3PhQ3a7O0PcZyg3Ok3z9LcXGX+gJH7j9EnWa9
 J3a3w8UkFSCdR9iBHuAptrT8EY1iG5x8AMTEYummSwTayAoXPu6OcckrgWbo1ywQxAyGZ8K2Gne
 U9c9WpRfgHWpGa0SMzQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a848f52 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Mdc7fmIS_ZdQ-8du_ekA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IegUhs1uygnFrYziChUzy73HJAD8g8B0
X-Proofpoint-GUID: IegUhs1uygnFrYziChUzy73HJAD8g8B0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX1IQfDi16leA7
 g4X6JgTJcsC9wNl0SvLQSKo44Y7PV28RVyJ43tFBDKTbZ743UMG1QOup7uj5/3e3M5oQGwF8Q39
 HV9kbFLPxSuaf+AfNcgPuIvQhg+Nx9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180122

On Tue, 18 Aug 2026 17:14:52 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 18.08.26 um 16:32 schrieb Halil Pasic:
> > On Mon, 17 Aug 2026 15:22:41 +0200
> > Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> >   
> >>>> +	irq_pend_mask = inti_to_irq_pend_mask(inti);
> >>>>    	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
> >>>>    		sigcpu %= online_vcpus;
> >>>>    		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> >>>> -		if (!is_vcpu_stopped(dst_vcpu))
> >>>> +		if (!is_vcpu_stopped(dst_vcpu) &&
> >>>> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
> >>>>    			break;
> >>>>    		/* avoid endless loops if all vcpus are stopped */
> >>>>    		if (nr_tries++ >= online_vcpus)
> >>>>    			return;  
> >>>
> >>> [Severity: High]
> >>> Does this code drop the interrupt kick entirely if all vCPUs currently
> >>> have their interrupt masks closed?  
> >>
> >> I think this is a corner case but still a valid finding. We can probably consider this
> >> slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?  
> > 
> > With GISA, I think the FW is supposed to deliver the floating interrupts
> > without dropping the vCPU out of SIE. I'm not 100% sure but I think we
> > can rely on that mechanism for the CPUs that are in SIE. Without GISA,
> > I think, it is reasonable to assume that vCPUs don't keep running for
> > ever. It has been a while since I have looked at this code, but I think
> > the SIE exit path would catch this. If that is true we would not really
> > lose initiative, but just see delayed interrupt delivery.
> > 
> > Sleeping vCPUs on the other hand are not of interest in this context, I
> > think.  
> This is all corner case handling. Imagine one CPU running with IO disabled
> and all other CPUs sleeping. If now the "opportunistic" wakeup fails the
> GISA IO interrupt will never be delivered unless there is another wakeup.
> In reality this is a will not happen, but see the latest kvm unit test
> patch from Janosch and it might also create latencies, the "pick one CPU
> to deliver and wake it up if normal processing does not work" obviously
> has a hole in specific cases.

Right, but that is not the "if all vCPUs currently have their interrupt
masks closed" case that Sashiko is talking about. Or did I misunderstand
that?

Yes, I agree there are holes, and I was hoping to contribute to a better
understanding on where the holes actually are and what are the
implications of those holes.

Regards,
Halil
