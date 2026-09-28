Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CC4D599E;
	Mon, 28 Sep 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605415; cv=none; b=HpqAxbs2YpGUPnIv+kq6QifhTwkv1kL5z7zHXi3oSrPR1m3oOAHbm/ijL8G3+Q4igGTRCHFvRmzyYKh8oQo2q5ZbpF/7c5hbi83YwzJeDNZsVdSHaNoCkF+gieoaRh9AGwN9fLHB16+BZ1ftt565lVTrJPUgIqN+IjQv9VK9riM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605415; c=relaxed/simple;
	bh=P9PqO5qfr930naBjEJYBYKBsPVV2btuw00OrnlZSvyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmEiXjfiKWMh9WEjjZFsB5VwqFHK8WzIuiU5gVYV6Z+ss9nZQ4yzp+/m6ZMLOcSJ3WmeG/OfObeeMF/6jATWQG9NZpUFm49o1Q+i6mAZtwTuIpbduAjqQl6cwG0zEr29zsPLC4M0FZNFTOfOzdCdDIGakgZ2aDPNOmLbOXgA+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SgtpN1qA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SgtpN1qA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZZVv1047082;
	Mon, 28 Sep 2026 14:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=269Qr/2f+mli5iZf5LjqCG3Wsfifp4
	/qh4IuSPn08jE=; b=SgtpN1qASY6d0PD/W/Oe9D2ym8/5/iRdQSQ2eFEdKDxVVH
	j6H0M5X2Zyhsgvl4VyUy6p0mmA8bpfwCe6Eb3/MFepx1LTfznN21FX09qLp7krhi
	IpbWporLsvfFTZkapCZ7CSjWSgzzAhRUwMNSzOse2Z6j65mkUzJWhS6/Fm6azY5v
	VrTIlF8e5POPLfPhDBoZC21D3QuJcW6VF/5OC6sVdHbOQ83gsNC+iNCXxdKkphGB
	SeCA3e4xtKDID0US2EbHCiRrqw7xYWMds29o7dxeiWY+IKDjoeMqIdVh5rjdVQDv
	HsKmQgvgBsXLojZD8vL+2FUuu2PeWvPxlEaJsYTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j51y8x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 14:23:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHufQ076700;
	Mon, 28 Sep 2026 14:23:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhdgya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 14:23:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SEN1Zh55705980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 14:23:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38ABC20040;
	Mon, 28 Sep 2026 14:23:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5552B2004D;
	Mon, 28 Sep 2026 14:23:00 +0000 (GMT)
Received: from osiris (unknown [9.87.129.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 14:23:00 +0000 (GMT)
Date: Mon, 28 Sep 2026 16:22:58 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 23/29] KVM: s390: Add basic arm64 kvm module
Message-ID: <20260928142258.53077-B-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-24-seiden@linux.ibm.com>
 <arp2njz3Dro0sQ6Z@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arp2njz3Dro0sQ6Z@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX5dsVumWdYdWF
 AZKYtE84fjB98wl/6dKGXlvs+Ly0IWzRCQtvVYltXc1mz74v1LhjwW6iWDIHvD2yRLVeoi+m7Mu
 yIk64PRIjmPyPlIfSdGB+VOWLJva8y4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX1BAFPlgJV6Nv
 OXuy0WD/1RHa0kE+XIyTFbFO0IriHeyB0GcbFKbrEk8jdJ0wmFsNwH5qPRXpsYgmjbSg+5w0LIQ
 tcxLO+zEOA+xHAAbg1KOw+eY5rjOUvN8sHC7rD5TEMrFcGeULBy1iIklCpZ/dkV+M+UzrPLQ9+E
 cnBqCflGGYWtjXzUZWTWpeVt6yiq+hbX/zgc1c2pgY0eUKYVn2vsJAFhZkrVqmaYBEmwCa+Nq5+
 jOrXaFxPCoQZZjWm46w595wiEMMZkm1EvkInymRJ4ZBlGi/qDLOAJeabAu97U4X2g0vcrKKbdTQ
 3thPAiKwu33JqADp2A6jHwtzHwyUCz0jU+nM9gT4zH1H1a5VhJvDpf6VoTQgvEDMRXpIOYHNW90
 6hRy/f0GcczR20Nvqz10T/S8rpOrc80UtbSY+6nijgyTmln/Yok1fUAu5oQKbbhHcNprHz7Sy+k
 dzmHX6gNcIvh7qwV4XA==
X-Proofpoint-GUID: -opRUxCBQ87ofTNi4olODdbsoM2GysKf
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba7851 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=kmqKt6rW6CT7MOcbZeAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QDIhRafS2tv1KtcByMsVqsVtQuv9E7le
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280056

On Mon, Sep 28, 2026 at 04:15:58PM +0200, Hendrik Brueckner wrote:
> On Fri, Sep 18, 2026 at 03:31:00PM +0200, Steffen Eiden wrote:
> > Add basic code for the new arm64 on s390 KVM implementation.
> > Add kernel module boilerplate code and trivial functions.
> > Add tracing scaffolding.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/kvm/arm64/arm.c   | 147 ++++++++++++++++++++++++++++++++++++
> >  arch/s390/kvm/arm64/arm.h   |  44 +++++++++++
> >  arch/s390/kvm/arm64/guest.c |  92 ++++++++++++++++++++++
> >  arch/s390/kvm/arm64/trace.h |  18 +++++
> >  4 files changed, 301 insertions(+)
> >  create mode 100644 arch/s390/kvm/arm64/arm.c
> >  create mode 100644 arch/s390/kvm/arm64/arm.h
> >  create mode 100644 arch/s390/kvm/arm64/guest.c
> >  create mode 100644 arch/s390/kvm/arm64/trace.h
> > 
> > diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> > new file mode 100644
> > index 000000000000..8b056fc836d7
> > --- /dev/null
> > +++ b/arch/s390/kvm/arm64/arm.c
> 
> [..]
> 
> > +static int __init kvm_s390_arm64_init(void)
> > +{
> > +	if (!sclp.has_aef)
> > +		return -ENXIO;
> 
> I suggest to use -ENODEV here to be consistent with s390 kvm module.
> The arm64 module also return -ENODEV when not available.

Makes sense. Thanks

	Steffen
