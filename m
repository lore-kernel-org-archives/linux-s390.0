Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7A34D3BE;
	Tue, 18 Aug 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063555; cv=none; b=UVbwvCaY5b55XN4GdHbeRAbKt83V/2NSZpRo3nPRhArqFB1UBZIc5pZm3sL4bZO6nQom9iu35DrsfEPyaPpgNW5QAS6ZDFTbHb2yRoN/9QencPDuiBB5zcj3v7Pyi7FBzf+GyNcqMBzMPSbEKofXtS///pnfq+7dudGQn0WBUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063555; c=relaxed/simple;
	bh=Nu4ar1tjItLX9SqqtXy6c4Ll4Jn0MfM2dez1G0XkrXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5SJXEps4sgLN3e2r9k6TgqbmhpJ3g7YPpB7apqMHOqtvZjmXUuym8jKPFn9YWbgSJM/UfNoynxwsCvxZrGa8T6k6OxwXjfZgrTy6+/L91VSx3mFcJKTde850vTLQ7Js2mmLpGDZu9BnEodGpf/wKkFimc8a3AosBx/W8UwtCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAAHb7P+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAAHb7P+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3rMv2831771;
	Tue, 18 Aug 2026 14:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k0GNVx
	WYMe6//F4MMZIk2UTC2p+ujC79wXYMitDFsm0=; b=PAAHb7P+qHB/32G8MUgTGr
	SOTN97MaaECqF/8T7zREU9UOT2ZcnK4cQ6QmNo2E+yETLf5YhIoK4ulVEHmVFPbt
	zRdBBqyrBG/aLolEpvtSERU6ciidnlggX/Q3OxXVDtKNqngytIizYWB+jQxPUV+m
	5N6i9jLo/FoH6UfIZO/d8YHRUW5S4sT1eKSZ4LEFyJsXuAin8dxI/zaQsd5B11fA
	VgikmKWi/o7EXCi1lvNFqvkBos6E/S3pQqQXoBQJd5gSX388xhkpkC514SENHihy
	hlmcDl7FNWmVouVy3KR30Q9uOdngnSvywsNVx+LNqBk3yJQBB7GvigDOxxmacpcA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqrss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:32:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEQKbP011306;
	Tue, 18 Aug 2026 14:32:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbff7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:32:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEWS9Q44171664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:32:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FFF920043;
	Tue, 18 Aug 2026 14:32:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 920BE20040;
	Tue, 18 Aug 2026 14:32:27 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.2.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 18 Aug 2026 14:32:27 +0000 (GMT)
Date: Tue, 18 Aug 2026 16:32:26 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Michael
 Mueller <mimu@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew
 Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
Message-ID: <20260818163226.68c6bea4.pasic@linux.ibm.com>
In-Reply-To: <3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
	<20260817122849.9F8061F00A3A@smtp.kernel.org>
	<3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXxiaz0YapN5jl
 sFtxj6UhLRCIFO42QLy9UiQYvRABnl/zhSXBhKxqkjX9X6GDucm+V1LUiR2IM1KZzLjHoyO2IOL
 lJCs+ZY/IlBmOaYU70+G+AqTKjd7O5s1+22hRIrWOfK1mGzABKe6i2m5SDYXJw8/6npvB5G5CZh
 UmH4icZW4otD8FHXawBZfbWT7D+F9eaKyOIpqHeoFcHhezIbqYeayik25wpF+qYDF0RFNlCD6nj
 XmgdMnH/zENvASTL+GM6zsRMMcy/+FwZeP8Toe++PGoyan5aUPfxKRkyRd+187LHha+ifqkPVhX
 DPrU55GzbjIhICuld6EdZLAotMMmZgdx3s544XQ/oiF5Z7RHriVuY0ZNypsLgq5+2C4HrcItFng
 rg/07ZRyRXMOsgc/1BgDqqyTsfjEz/Sy6kVFU7eogmTWAgr2X96NZKujkSVJXgTDhf9cVVb2VCf
 7/m66zQDJw/5XoEqVZg==
X-Proofpoint-ORIG-GUID: yzPUUrhW7yuQ74atz1oUDne8npCXOR_B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX9lSeU8+pX1hb
 MDtVZXonRBM/sTBPgxyfx258P4HR29lw0ncsndXvb9g8XgpfUHDGUD9oHS1F1WNm2rufWJxaNxs
 zqklFvxIvGy+9fOUpouzK2JXQjNuSYA=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a846d01 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3RURawJg7slDEgzNLLoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yzPUUrhW7yuQ74atz1oUDne8npCXOR_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

On Mon, 17 Aug 2026 15:22:41 +0200
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> >> +	irq_pend_mask = inti_to_irq_pend_mask(inti);
> >>   	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
> >>   		sigcpu %= online_vcpus;
> >>   		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> >> -		if (!is_vcpu_stopped(dst_vcpu))
> >> +		if (!is_vcpu_stopped(dst_vcpu) &&
> >> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
> >>   			break;
> >>   		/* avoid endless loops if all vcpus are stopped */
> >>   		if (nr_tries++ >= online_vcpus)
> >>   			return;  
> > 
> > [Severity: High]
> > Does this code drop the interrupt kick entirely if all vCPUs currently
> > have their interrupt masks closed?  
> 
> I think this is a corner case but still a valid finding. We can probably consider this
> slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?

With GISA, I think the FW is supposed to deliver the floating interrupts
without dropping the vCPU out of SIE. I'm not 100% sure but I think we
can rely on that mechanism for the CPUs that are in SIE. Without GISA,
I think, it is reasonable to assume that vCPUs don't keep running for
ever. It has been a while since I have looked at this code, but I think
the SIE exit path would catch this. If that is true we would not really
lose initiative, but just see delayed interrupt delivery.

Sleeping vCPUs on the other hand are not of interest in this context, I
think.

Opinions?

Regards,
Halil
