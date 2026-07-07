Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D013911B8;
	Tue,  7 Jul 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408916; cv=none; b=E33l0SrkSuLXSp0Lfhs/aGe9F4fakKp9+vXEPGRXExqGU5uEJAXFCEoFohWhIHVbKctXJuahnZ3spLVA/zYLLA2MjYMyr5oZiNSu2VbPM0SiTKioDTM0jq6SmyYk9nEn6lvneeHAW7zFOUswom4DXGPC6YzUzm1tFmVDKHs2oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408916; c=relaxed/simple;
	bh=CkYdfRzgHc0C7Hmsb+Gi3iBMGN8iWG0xDQhHa1y4C1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtDZI6+WUkJdULUqXcDFsJGX/EPiZiv7TiCXpV2hupGp4WmxplORFDCUX4Uwkzd4RcEZMYvDcYqjxVkd9w41DOYNZ9p6MwQ5gcQ7kiOj0y5D6GDWllMEkfSKjaNFqZmbNoUnT45bBuE2qBLcNgttI1hWtKE2t3A0chtWKlUY0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EQ27WFS5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EQ27WFS5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674Ifer2386574;
	Tue, 7 Jul 2026 07:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ASP9SsAmeugXa+PWYoSj6Ew07J1BIB
	lMkdhlKL9m9IA=; b=EQ27WFS54mZ4vAz/szsbXHFYZ6HojI5h/0rRroU5Yogjca
	Sk5cynPhjtUGvXMaySNokxXGzUlbl2bl/6gKKzPq6867yORSb7FM/fBbWnG4gRsl
	vSb8g2a97ZO22Rp0Uzk9O/Fh/utfyXfWzKOy5LVUgQsGVhVJa6gRmKCMNIehNAJ5
	YEcFHdYLLx3B70rS6SQjsBd4H1zackIYONFzDoQ2T0MYrfhnq41bTI8rkDjN94dw
	e2kCm+Qkp7nMInI3SauokSEYP6ywx+tO7hdOpWFazbPToDi5fn8wUmMpXCqcY6PF
	sOWpRg0jefvg6Dc6Ld0Jb0yi5hjd+Dilp8wGgCxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3ns13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:21:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66774aGw010981;
	Tue, 7 Jul 2026 07:21:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk1h32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:21:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677LAOQ14418406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:21:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F09620040;
	Tue,  7 Jul 2026 07:21:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1AC20043;
	Tue,  7 Jul 2026 07:21:10 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jul 2026 07:21:10 +0000 (GMT)
Date: Tue, 7 Jul 2026 09:20:57 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 08/27] KVM: arm64: Prepare sharing arm64 code with s390
Message-ID: <20260707072057.583632-A-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-9-seiden@linux.ibm.com>
 <877bn77qpm.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bn77qpm.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4ca8ee cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=LSyHmQqohv__iSPK5BIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX3/lN6puSS6GP
 bKJgePq+klxWS7lo/wst4kxr8HGzyQflDKzbjYUZ12zjYTqA3o0Mg+DwVSldOv1W2mDT/iFC5YT
 LSsPQQpQubDplqIQVz84pdjl8aH135s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfX+z5lgv7MIVZa
 oJaN2ERCbmknfC9glSCCSIijIvtnLGtH2p9pyf6Hso8ONewXT6WkY3DKHr1zl3xm6RVb2m+Mkup
 eoIGXWuc/9KhKH/yFx9JozGG520Hm1PVjV9Cjv+cofr/Ma4jWTq1oQW2qkspWw5JFWUzv5mnoaL
 k7QER7/8OSLq8IxKcY5OELP6r7vGsJUE5Af2z4mBAJFnHaZi7F9o+y0saIiwWVcjtofyaCAIQQ6
 1LbLP1ldl6Zy2X6CG8VIRx/4OerC3q294/yMjcjxSoPYJ2JtxzaPikcts80AiJJZzmBdIHIx9qG
 q2YnXZIi4d8StbFKm3dJTwJ9K/bov4Lhe1JlAXOuiqkPz7bZeVrwitTbwYDTP5B9qNLvtLHG1M4
 sISZCNyakLZyoOUFLRNIdl9zvbyDi7hGOchRSWya+VanhO7js1kdnptiv9gH7Wje03TgCui/Bvc
 jdYkiXV6wZUpPC155Gw==
X-Proofpoint-ORIG-GUID: sh00DnTO4XIi6KmCOBbENJUU54MwFv1X
X-Proofpoint-GUID: sh00DnTO4XIi6KmCOBbENJUU54MwFv1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

On Mon, Jul 06, 2026 at 10:28:37PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:08 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:

...

> >  /*
> >   * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
> >   * proper exit to userspace.
> > diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> > index e2285ed8c91d..876d56dd5b64 100644
> > --- a/arch/arm64/kvm/mmio.c
> > +++ b/arch/arm64/kvm/mmio.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include "trace.h"
> >  
> > +#ifdef ARM64_S390_COMMON
> >  void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)
> >  {
> >  	void *datap = NULL;
> > @@ -135,8 +136,11 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
> >  		if (!kvm_vcpu_dabt_issf(vcpu))
> >  			data = data & 0xffffffff;
> >  
> > +#endif /* ARM64_S390_COMMON */
> >  		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
> >  			       &data);
> > +		//TODO  tracing
> > +#ifdef ARM64_S390_COMMON
> 
> Irk. The deal is that you lift full functions, not cherry-pick which
> lines you want. Just define empty stubs for the trace nonsense, and be
> done with it. But not this, please!
>

Sorry, this dirty hack is a leftover I forgot to clean up prior to sending.
Hence the TODO.

I definitely second you full functions or not at all should be the approach.
Everything else is not maintainable.

I will add the tracing stuff for the next round.

	Steffen

