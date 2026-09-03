Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3034477FE;
	Thu,  3 Sep 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424770; cv=none; b=byiS6b+5u7k0XSmJHw74RM1PWMFQtkDWGEi4ukqrwNBGkw6P9yLskryDiYUSdOVKA20WTYGvyZKo74rIwsodCDA2XVaqj2uLw+35/ai6NaEcYqv/q+mDiiEnojyXXcO0IbD45ORLK6Vad3UCf2Xagi760Xk3rBKatq0CfH2fdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424770; c=relaxed/simple;
	bh=gy250ESkrbNXAmt1Pukflcbtb9tpx49F7FI58wzn4vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSRUkGlc6qQhcusX5kqMzrYtzsIY8Wdjk4OGQhJikr8DXFqc4m3sXnByREb8ccR9d7rxRg9k7w15Pg9MGZibwu1m8o39mDsTqWu9s8pNxOe/k1dZhIt6dpwpQ8ngdIOa959OhRx1vzFflwpSbq6hkS/cwccdzJp4GR80aq485l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rEQVh27W; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rEQVh27W"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361dIY2067499;
	Thu, 3 Sep 2026 08:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Rt4e7QN0rJH2sd9pKw5EYUdXR/LSB/
	5HWW+QqOZZCsw=; b=rEQVh27WfTWWYLSguk9gflz5iF8TNsLXhDbfHpqP1yhhXn
	L5o0CoJHP6CQVA7rzpKSYCyTjKRSAX8oMRCwcmth0zWeI/PisnKV5vsYiLNsiN11
	jdC/y11SoBEr7B0RhMl4KAoGKCjlq6/MiwydPPrSDYtDm+nyAre4or12tEMo9tNL
	YnnLH4g+4KFaGBJkYAsorO1/HSaiOlmqzepzxVND3vkB1SGqUSnvYMSndyB3lelj
	DertguxMa2aHLyFjjai8+xvE93sbuOjhZoOIDEAFcR8PYTDr9rDo2/FuFYAeIenN
	Zpt7GQkAMH9WZdd0MVPE4GBWRQCMxx0rj93hRMxA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj3p4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:39:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6838QNSR026134;
	Thu, 3 Sep 2026 08:39:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyem3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 08:39:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6838cxWI42336638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 08:39:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7D862004B;
	Thu,  3 Sep 2026 08:38:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E135220043;
	Thu,  3 Sep 2026 08:38:58 +0000 (GMT)
Received: from osiris (unknown [9.111.48.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  3 Sep 2026 08:38:58 +0000 (GMT)
Date: Thu, 3 Sep 2026 10:38:57 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
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
        Hendrik Brueckner <brueckner@linux.ibm.com>,
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
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig
 and Makefile
Message-ID: <20260903083857.33034-B-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aphMx5hsoXwIpNjt@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rM4PDv8t8LtgoXWWsvkGxVtFUtq-EWVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX0qBnQykfpZag
 LyEzK0Q2M0otBgsmLVbuaAXKJ1SF9G5knSJd5e9TwSRJWnhgOAIKtus94XMVUFZbY3RAHtC2GFy
 GrJ/EQcRD6HLVB/I53AkO2OBxgHGDKhHPKzP43l2GO/48ztY7rAhh7v87gpdNIe5WDWhmkAJ+ps
 r4v5KU++n8/8KPATh3+9syWC4QpbkaMaOidSWFB3jSmFvZcc64ijxcRxh1oxIPWg7PTPyMNuszZ
 ArgyScowGdXwliSCGujAoDa30fmB3jZZcrv2wZffigtVL7djh0ln08kPoXM44OejTN/LYy91zMX
 Q09wpnUQlRpRCOIQ6R3mHs0FWFxpR436WNSLzGX4z3C/AjbFaUUH71G3nJ3MXzxkcqfqrk9/zLa
 FRaId3HgBwE7Ij5MeYY4GqvWtAsYZksNYqJyEtpqu6P3WRTDs+mdvIZFQOWdrCYOnIjrTmHt3Ib
 gswBu79IXXUSHWb+O3Q==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a993229 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=FnF-cwsuLINmlKs4EWIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA3MyBTYWx0ZWRfX1y1xvG8KvX7m
 QIoVzvZSl28jyNFTawqLR78bFVRCcQlmevjvDeSlZNE3I7PMWOOiwILvshbzSvL0170u+/ERtyM
 +G6PSYLb8MF2/wG8GYXB8mQBExjwxiM=
X-Proofpoint-ORIG-GUID: BC3K-qeP0r6HnRlADMcN-_W4aPty92j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030073

On Wed, Sep 02, 2026 at 09:20:23AM -0700, Sean Christopherson wrote:
> On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> > index 8d3ee17a1bcb..9c69ea16031e 100644
> > --- a/arch/s390/kvm/Kconfig
> > +++ b/arch/s390/kvm/Kconfig
> > @@ -53,4 +53,33 @@ config KVM_S390_UCONTROL
> >  
> >  	  If unsure, say N.
> >  
> > +config KVM_S390_ARM64
> > +	def_tristate y
> > +	prompt "KVM support for hardware accelerated arm64 guests"
> > +	depends on HAS_IOMEM
> > +	depends on KVM
> 
> Is this actually necessary?  I.e. does kvm.ko need to be *loaded* in order for
> kvm-arm64.ko to be loaded?
> 
> If kvm-arm64.ko does indeed have a hard dependency on kvm.ko, then I think it
> makes sense to not have redundant "select" statements below.  As an outsider,
> it's super confusing because the KVM_S390_ARM64 are incomplete, e.g. are lacking
> things like VIRT_XFER_TO_GUEST_WORK (at least, I assume those are lacking), and
> makes it hard to see what is actually unique to kvm-arm64.ko.
> 
> If kvm-arm64.ko doesn't have a dependency on kvm.ko, e.g. to initialize hardware
> or something, then this "depends on" should go away.


It is a bit more complicated unfortunately. KVM_S390_ARM64 depends on
KVM as there is code around in the kernel & drivers (arch and common)
which depends on CONFIG_KVM we need as well. I did not want to leak arch
local configs to common code if I can avoid that.
I could change it to select KVM ? Do you have another idea on how to
solve this issue?

The two modules are completely independent at compile and runtime. So
kvm does not have to be loaded for kvm-arm64 to work.

VIRT_XFER_TO_GUEST_WORK is only lacking for now. I will add it later.
Currently the kvm-arm64 module is incomplete anyways but I did not want
to send a 60+patches series and rather stage the introduction over
multiple series.

I will remove the duplicated config selections. Thanks for pointing it
out. In previous series I had an explicit KVM_S390 config. Both KVM_S390
and KVM_ARM64 selected KVM. But this created too much churn around the
whole tech-stack (default config change, s390 is the odd one out for the
KVM config meaning, ...).

	Steffen
