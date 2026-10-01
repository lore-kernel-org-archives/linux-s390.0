Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D14F4028;
	Thu,  1 Oct 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868508; cv=none; b=W6QIN+ahppV8hDByrsv97JU/bS+5+dGUWaC59QMQdP7IN13GMzW44SoQiVY2i6Bf8RYMnHJvCrabR2Q7YIlUacilz3yf5tjJdjYLnMZqd6cV/g0KCRUiwDtVaw4t4x9VJKdAYMurXgtv8vB00YSIAWJPlwFxC8ZFep1VzjGBUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868508; c=relaxed/simple;
	bh=F7uA/WesQ7CRliLTYJAYWhZReCAT4X085VkubSIQxiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGpIEAwwFgECD9UhwwFDy2y2tuaNwoJDU2HNSSzF3cnXnDXT7Tvtjif4xbh+nRw7+MCvob6MOwiJ8VaLFZlqHp7A7UxEwbeOnpXv/M4oq5cy33iuH8JIxM8P7176aajPGfF8oMmWcYNd04xspguehuxn6pyFmVSVXrQ/JfugU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rrV0xBOg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rrV0xBOg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691Daqo31887543;
	Thu, 1 Oct 2026 15:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vgnG8rVeRbJNCaAy2IBzbkoT7ghCWn
	R2QVi/WWha3Vs=; b=rrV0xBOgP8q6078R+SrzmauKvifGq4NiympvzFOYe3ewk6
	HKWGwytDTchEh2YX/B6teyqNutB9496uebTQH5SxabrZaYznb1k1AiulSAEZ9Txp
	yu52H8+LZdr/lL4PDIdoCHmpjLwh5//EdfaZ/jduDJ11bfT/O3Vg8Y40wiZrJlxP
	ckDaNIU6wZE60IN6j3UvpfA0Bl/r4dssBrJEQmOge9+kZBcGfkM38+L3iqlbk6S/
	NpGj3s6Uxd6IkUqlctA5oxpG5g4RwRzLG7CksJVemmweU+sjXvfhLj9Ctl2rnEXU
	YsjYMTz2IKqdLGzpaGshw2pV1+PXvdThoqwJeXzQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5m1aj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 15:28:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691DlUMQ1014241;
	Thu, 1 Oct 2026 15:28:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e9p97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 15:28:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691FS2Kg42205502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 15:28:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E5452004F;
	Thu,  1 Oct 2026 15:28:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B302004B;
	Thu,  1 Oct 2026 15:28:01 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 15:28:01 +0000 (GMT)
Date: Thu, 1 Oct 2026 17:30:05 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault
 handler
Message-ID: <20261001153005.314717-B-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
 <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
 <e1569c6e-94df-4609-8d94-d6319b4171cf@app.fastmail.com>
 <ar5udQI9qDAtYrGi@gremlin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar5udQI9qDAtYrGi@gremlin>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX2dHxbg9WFAX3
 vCgw9xIT/uH9JuA8kMyp8iH4EM3shTvqHta2glpmTrhKg3ZxR+HYWRuuZ1Tb8SDqndrkHQh6/g+
 HCpaYQIFM66g6y0gOBIIndyYh7p2nCo=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe7c07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=6ZjwDr74HOGPPcGGw4sA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jiEUxPFN5Hly8OX4mT18-m95iiCMMpxy
X-Proofpoint-ORIG-GUID: AEF0VvpZZK8TQE1iAmu6GvIL5k8eZq4v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2MCBTYWx0ZWRfX3RZjgu7EO1TA
 nqQ6f8qZDuj+FPjK69SeLZS8QCIs8YEYUY7Hyu2E4gXHbNesmy4e6o9PQ9/Xd+7/G0R80Z5nWjw
 EQqwPb3JnhC1nqV/a11F5dwG7zSablKI4L/xqnp2Ysw+fqPx6pOP57yhGFqyhQ1GQCZlgGK5n1u
 Qv0T/F/J4FJTuMevh+tDdEQDqvHDwCb9xqjco02PAhkckyMFdw/LL5fJPKPjOHHn+J7e4dBseRK
 PPRUzfVZbuMeQgVcdacTKOowhtTn/sQYW3meePxrGUws0FqjoAD8eWU2/gXiq/w3FHM1cf6XOv9
 uhX09oM//b03nI0dFItJxvZfWkP9CBB4TgEZgiTAOxASgM0FVQr124GqOTWBmPKh82X3428GbWk
 TGFa6lGK5NaWuPk+3yk4zN+LR2H94ETBltPv2d2WNlCpb9/ZUpTdebyl1YaQreR4PtlEkNODDcg
 qBrwGspG411rS5vx1YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010060

On Thu, Oct 01, 2026 at 03:36:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 01, 2026 at 03:35:37PM +0200, Arnd Bergmann wrote:
> > Another ones: after 34cfa9b3af17 ("KVM: arm64: Implement
> > KVM_PRE_FAULT_MEMORY"), we are now missing a kvm_arch_pre_fault_allowed()
> > definition in arch/s390/kvm/arm64/mmu.c:
> >
> > ERROR: modpost: arch/s390/kvm/arm64/kvm-arm64.ko: symbol 'kvm_arch_pre_fault_allowed' undefined!
> >
> > I copied the arm64 version without the pkvm reference to make it
> > build for me.
> >
> >      Arnd
> >
> > diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
> > index 7ee157c61d70..be16351acaae 100644
> > --- a/arch/s390/kvm/arm64/mmu.c
> > +++ b/arch/s390/kvm/arm64/mmu.c
> > @@ -179,6 +179,14 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
> >  	return ret;
> >  }
> >
> > +int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> > +{
> > +	if (!kvm_vcpu_initialized(vcpu))
> > +		return -ENOEXEC;
> > +
> > +	return 0;
> > +}
> > +
thanks. This must have slipped through somehow.


> 
> Ah the s390 <-> kvm emulation stuff.

no, its not emulation :) 
We use a hardware based acclearaion approach.


> 
> Yep if it's meant to behave like arm64 then that should be correct.
> 
> It's odd to me that pre-faulting was not previously implemented for actual-arm64
> but was added as part of the virtualised s390/arm64 thing automatically :)
> 
> Not sure if this implementation requires what s390 does with:
> 
> +int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
> +{
> +       if (kvm_is_ucontrol(vcpu->kvm))
> +               return -EINVAL;
no, ucontrol is a feature only for native s390 guests.
kvm_arm64 on s390 always evaluates kvm_is_ucontrol() to false if it
appears in shared (between both s390 KVMs) code.

> +
> +       return 0;
> +}
> 
> Or both conditions? One for the s390 guys.
> 
so just the initialized test.

thanks

	Steffen
