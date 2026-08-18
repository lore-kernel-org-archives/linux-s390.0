Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895E3812D1;
	Tue, 18 Aug 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063399; cv=none; b=IZNxwCgNCexa9w7xWk1aSHxhPUZf5enZGv2QCvEdFDLv6jc550L7GE2W/TEMz266ojwQjg8hixDNb/awexBApn+QI2wHjvheaJolEAG85K5PFHzrXmQAlG6Yb9S9mTTbX/IKVWqItsobSY4bt2bPUhwA79ZGVBJn44XbfilUktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063399; c=relaxed/simple;
	bh=Z2Zpn0mMP5umwZgoTWvF2T+J67srfo/UyfNCeRpk0T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNzitLSaIQ37Au4dbaSaZHTCVy//iL2OAkNO1Hf1CpsvdKpJdUpnG5DXNxG7mPcWKwqQZTwJ0Y119rMBgFM6E2mJDyPzjzjDo45g9Sa4WjdcaZWNlfRw752e4lxSrmKNNvNTC4/bHcgk5FZ4xp0AIvot2D91t8YTPbpfM9kD9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RWVwh/Vv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RWVwh/Vv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3ffe542523;
	Tue, 18 Aug 2026 14:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Q4Ux+/QWCkRJg2MxE2yY8qzYqHCrz3
	TmVY+vbgce/Xw=; b=RWVwh/VvvXlls5dH7wvJ3j00r2j4SyKTzO3VZmiIPcIy50
	tOGXXtcdikNr/VzbxPfgwbfPIdYfd3Ug4vzkA0tTcba4tZW+RPSW2AzJUvAWKDxd
	jhfGokTFUhg4zyz7UdA6phuw9E1SY+fjMNuIoHhcCvCoLzCjuoI9aJAjy2xPJsKL
	YJ2QpERhsCloi86UHfQfLINbokEbIbfol+tusUc68cpkoUTCC+NQwcB4qBn6ozDq
	0/cIUEy/EUxcQ2Zat9Epm2ty6lpGDprtAlh0XX8rOs+2edu8AcBLeuwrIM2Frnj1
	oLoo2II/kYFSpNjAF2Qxb++wElX29GemY3ecratA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt88gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:29:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEQeEg020014;
	Tue, 18 Aug 2026 14:29:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq3ts3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:29:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IETXuM42009038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:29:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8402004B;
	Tue, 18 Aug 2026 14:29:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE7920049;
	Tue, 18 Aug 2026 14:29:32 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 14:29:32 +0000 (GMT)
Date: Tue, 18 Aug 2026 16:29:31 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 08/33] KVM: arm64: Use accessor functions for core regs
Message-ID: <20260818142931.21865-G-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-9-seiden@linux.ibm.com>
 <86a4qq1gyy.wl-maz@kernel.org>
 <20260818092924.21865-C-seiden@linux.ibm.com>
 <86ecfv613k.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ecfv613k.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a846c52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=v8CuuPHm0S7VpODZ9BkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX+NVez4jOsbpG
 godyTBBEaM0PrH1ZZzKoPyxEiSsG5XX8DiV1/X3t4jBzQFjdzJPIkJUewzswzoJoWFgwB/EED4H
 WICgLAmS5wNH/M3LXQL0K48xhvGGsf8=
X-Proofpoint-GUID: ibFV31CahW-cnJdkL25DpOaeaRym7fEh
X-Proofpoint-ORIG-GUID: 7vXRAGfGpAKRcPWjy_33qur8DqEHUmHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX/Yyr2tRG5nTs
 vzLAP3kp2L1nLG9boP1NJI61AQkTpCz2JLJDnwuCCkRMUjplnpaZKbjWFy2EFSC02jnjkLKOvT8
 H3brincHUwbwXe5xs9kMaTwcgkxZPGACQysqxW2Qo4h1pIPx3cHK05r+piP/bEhTQHAypVO9Rt4
 tescpu0HW/OeBJnbd2lKPuuH+eqkvGsbFfk415nH0442qMMOrp3LuCWjiuH6N1R+g69zIeu/vzy
 ch0e8QUETSXWhL5f17CYUDMk2GqzGKtPCu5QTV678rlsk3tMEsa/V7DvF9fk/+NNJqScq1r8bBy
 qQJRWey+5PZyGQdgG/DYZHmlrblxmu7z9GnUvZpfDDHvqXyjzTXKN+u85Vq0SXHJ4h8qAZb/ioq
 Qrc8kNba0IXedPI0heqhouUZusm4W/l3e9oVkXEv9sOOaupAh8LHcRwOWdIqFJkrm8u4FqqqMOx
 Dn3r+qmLQRi9eYzNlXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180103

On Tue, Aug 18, 2026 at 01:54:07PM +0100, Marc Zyngier wrote:
> On Tue, 18 Aug 2026 10:29:24 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > On Thu, Aug 13, 2026 at 10:56:37AM +0100, Marc Zyngier wrote:
> > > On Wed, 12 Aug 2026 16:36:04 +0100,
> > > Steffen Eiden <seiden@linux.ibm.com> wrote:
> > > >
> 
> [...]
> 
> > > > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > > > index b01d6622b872..773f6c8e5026 100644
> > > > --- a/arch/arm64/kvm/guest.c
> > > > +++ b/arch/arm64/kvm/guest.c
> > > > @@ -134,19 +134,19 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > > >  	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
> > > >  		off -= KVM_REG_ARM_CORE_REG(regs.mregs[0]);
> > > >  		off /= 2;
> > > > -		return &vcpu->arch.ctxt.regs.regs[off];
> > > > +		return &vcpu_gp_regs(vcpu)[off];
> > > 
> > > Doesn't this belong to the previous patch?
> > > 
> > 
> > My thoughts about positioning this change in this patch:
> > 
> > The previous patch changes the semantics of vcpu_gp_regs and just
> > touched the part where the old semantic of the function was used.
> > This is mainly done by not using vcpu_gp_regs where it was used before
> > as it cannot be used to access e.g. pstate anymore.
> > 
> > This patch then introduces and *uses* new accessor functions for
> > abstractions (and uses the vcpu_gp_regs abstraction where it was not
> > used before). 
> > -> The patch changes direct accesses to using accessor functions.
> > 
> > However, I have no strong feelings for this. If you want this in the
> > previous patch, I can do that.
> 
> I think it'd make more sense. You can capture this in the commit
> message to make it clear.

Just that we are on the same page: you want me to move the change to the
previous patch?

	Steffen

