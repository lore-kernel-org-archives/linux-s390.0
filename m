Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF00299A8E;
	Tue, 28 Oct 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680250; cv=none; b=cedh1AoyVwqMDN+8HGkUNYA4oYqreGUYhnWXZgpTWEN10NlZgT0FPAAHElfUsKGD9M0O1pZcvA15EXXApOWQCR/vPmpJVm3Ym7+2HOiEa/V8udT0oxrPp2CYVVTeemtV1VVmcxbfEYdTcKKlRNcIZPRfRze8ZXGY52I/+c4/HUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680250; c=relaxed/simple;
	bh=R2Ac4nOB30bTdRRwdeDIX6zjSBnTZwaQbpepDadB53M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFYkF4kAczkQZdTGXP6TluRflh5RmykTID/5xBq1QOTMFWKphiIs3b+rgAfrNIjZc+1C2AQJAk7cpRZZo7gCeGM0VZ/4FFvN57/lfs01j+kuboWR9LlHUKE3KnseFk4Xf8ptyZ5ugzvfq+bapA/+lkmAZehhGrkQSSc4VABsSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUV2eGqD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUV2eGqD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SDbXo2018371;
	Tue, 28 Oct 2025 19:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fcOgXcqOFnMC08vCFQWhhNNhOigL3j
	q+jhyzDJAMb48=; b=UUV2eGqDCdRk71FQY5mA5lZyUbCbIv2NotsZzhjNqJdP3a
	zK9AjqfArJYOHbJ4W0+bu0iHcaJqs0Jp0QaRZH6NgujGjQVSM7iXTn5VwSRm2DYW
	+7frje1vhvcSZtF3h9vdt2ZRcxSO9jbi9lkaHjo75/hbAg0x4H62SpXQvmmOJSmp
	GU2BhcoHR+7Naq7KUqngh89MpGkIx/bviJwCC/URqE7X1SfsLaK8etEFpCBh+sn0
	Hd2wNIBSo+iRuc9a71lSLgJrcuuMlttIifP9rh1mvXBjfLHcXiIwnenCobIZ1Qj9
	Dw8cg2to9R789K+EhuO7c+bj4VeAQbCFklObnoIw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81xey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 19:37:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJLgqt030817;
	Tue, 28 Oct 2025 19:37:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwg1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 19:37:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SJbAki37159282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 19:37:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8832E20043;
	Tue, 28 Oct 2025 19:37:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8F420040;
	Tue, 28 Oct 2025 19:37:09 +0000 (GMT)
Received: from osiris (unknown [9.111.86.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 19:37:09 +0000 (GMT)
Date: Tue, 28 Oct 2025 20:37:08 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, osalvador@suse.de,
        akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org,
        borntraeger@linux.ibm.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] mm: hugetlb: fix HVO crash on s390
Message-ID: <20251028193708.7213A7e-hca@linux.ibm.com>
References: <20251028153930.37107-1-luizcap@redhat.com>
 <50d815a1-8384-4eaa-8515-19d6c92425b3@oracle.com>
 <20251028161426.35377Af6-hca@linux.ibm.com>
 <5c72e064-9298-490e-b05a-16be6b5590b7@oracle.com>
 <20251028170251.11688Aa3-hca@linux.ibm.com>
 <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f522b65-1ab8-4725-8da7-3f071e7919c1@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=69011b6b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=f0Pcmk6uCRRijeZF_SEA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ZIIeRTfL90xSM42Fi60shxNf7BZy0dhp
X-Proofpoint-GUID: ZIIeRTfL90xSM42Fi60shxNf7BZy0dhp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX7+qngpRd+nhm
 /sp757299cAtgUe4mlSUay8+yRs9JiuYNSihUWaB9g8OQ4lFb7tsSQdGTqjgjMLApRrCiEOb75y
 FYXLVxaAgLS2Qm/kMkQJpZ2viAOH+ODIGJkVMF5N7K6XvLxiYJB2vH+Gnv7Pp6S96aOoujozU0U
 Xm4Q1WeAAYDaODGNh4T6MfV66OVPP8Dnu4nwpdf+SL+29TmLrAz7TvmcZWQ/Y/2xlwmKLUiar8K
 bb47GRSkWpc9qIAXETDyv6QGlZwJGkxIDUq9+4EZJKMgSjCrRpuTRf1RX4HujpDdjs6RTm6UngO
 sEamq2O4vHD3ikBMncC8glIbvdbfixV5MIKMPw1hPgzGRQae4USiv1Xyb0U4xx/C+LiLt3WbRYU
 fygbAbHeYtGxx22TffGyBpoH3QgoEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

On Tue, Oct 28, 2025 at 01:15:57PM -0400, Luiz Capitulino wrote:
> > > flush_tlb_all() however is the *closest* equivalent to this that's behind an
> > > arch generic API i.e. flushing kernel address space on all CPUs TLBs. IIUC, x86
> > > when doing flush_tlb_kernel_range with enough pages it switches to flush_tlb_all
> > > (these days on modern AMDs it's even one instruction solely in the calling CPU).
> > 
> > Considering that flush_tlb_all() should be mapped to __tlb_flush_global()
> > and not __tlb_flush_kernel() on s390.
> 
> You're right.
> 
> > However if there is only a need to flush tlb entries for the complete(?)
> > kernel address space, then I'd rather propose a new tlb_flush_kernel()
> > instead of a big hammer. If I'm not mistaken flush_tlb_kernel_range()
> > exists for just avoiding that. And if architectures can avoid a global
> > flush of _all_ tlb entries then that should be made possible.
> 
> Should we take a v2 doing your suggestion above for now and work on
> the tlb_flush_kernel() idea as a follow up improvement? At least we
> go from crashing to flushing more than we should...

That's of course fine. I guess for stable backports a small fix is the
best way forward anyway.
