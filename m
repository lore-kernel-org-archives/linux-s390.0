Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AB40B102;
	Wed,  2 Sep 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340461; cv=none; b=sISETvSWqSSX+kvugsP6KVM835vUi5Q1lKS4is6wWt2Sqghn0SU4BeyAZSPl1haaXqM+lmidzqcECc8Nj2HSKGaSAR2nLLQ7eRTpJBKMHfF++p+hpENJwQNJA/9LIuzMrVC9UJUA1FHtZ6/sW4AGiYWWaidlXH3Nc3T4KyszokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340461; c=relaxed/simple;
	bh=1xdldqEAvNlEHgEwwq4NTC9GQw9+uQB1grul/7KiVlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww0LekH3wlJjjvxGcTZV4GiVwp0i4Vaekbdk7t3VGezB+chfV696tZQgaa0eMmLD07rzymwxJ+CkigY4OT9xfG/K2Bg8e48SCA6UThes3TBzte0hWOih1HeQqiOoD8irgzpbM+yxIjqEDHnSLiHol+iVCWBm8KnHDrAJBLr8/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aQkac4ba; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aQkac4ba"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VpdB2306852;
	Wed, 2 Sep 2026 09:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8AqoYC6w7cGqvCApgJVekM9rSN9fLp
	aJea1c35J8vec=; b=aQkac4baoVBcd/gr3t42BfdcF/bXQtadWq2J6xdTTOVexg
	bC3jLEAWqZDGaroPEAsIn1Vu2m7B+yiGlqXd8iDESLYgk9ffYsFHkZgujdtaVkN4
	T5pYJUpMayTGAIRn0OQPCwk8Km1eRV4NugTxdBXoDrDzFYnpuqyeK6jZTzg1LyTD
	AunH+aGr3X35FHtE1jAsdjgM30cGEvPNFGuvInLbrwoPpnVESgqzRNVOL9qmKwEb
	xyR1sIOENYLHCMpnTtkZ4t0G5PseHraT49ggFKua5OhLFNGQWTurcBuc3ad2Cxys
	aOflYHQJ4LEXVgRAkCD08P97RTqmnjFwQ5kLTrBw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudw6rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 09:13:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6829BQ8k022561;
	Wed, 2 Sep 2026 09:13:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyggm81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 09:13:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6829DsqF31654596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 09:13:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3CE2004D;
	Wed,  2 Sep 2026 09:13:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E68A62004B;
	Wed,  2 Sep 2026 09:13:52 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  2 Sep 2026 09:13:52 +0000 (GMT)
Date: Wed, 2 Sep 2026 11:13:51 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
Message-ID: <20260902091351.438647-B-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-4-seiden@linux.ibm.com>
 <apdwHcdy2iYRTrww@google.com>
 <87ik4om4x2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ik4om4x2.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1F3pFqBliXsclDESpUMcg1Z2cLb-e86r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3OSBTYWx0ZWRfX6JtcG97cfxR6
 M4fLC+5JFLfefyJ1qrpgJw/iXLu2gd2AcQ9igI6kuKVVKwyQXLrdH5RcYRv26yseZUJyufkJwjS
 nujMYVuQXk36dNNw3gVbWXaSK5iesK0HQrdOEftwQ3tMNqDbDpZ7yRzLEjQoYo9rsQbkblu3QeD
 F8QX7BXmfVOlOh///QP+kcohJs1wkIubtCoBsdgc2KETGEc+00lLjjyNzOmUTbGDvUekrc77wTJ
 7QQ8DLPCsbG2yPHF8+dAEZzCNj0z3v6trPZkmGfPxtyVs2i4QtU/1tp1mBj/8JFGtyjaQa5tqbk
 /1M8eVbP1oVzDt0r2yaL4Dhfx8ClG6elPzAIlyexPsJumZFN62k5+buX6br5va+BTYKb6TluANA
 Ek2Le2C5Fxzjiiduhw3Mzlmn7MvP5WPJQkW+aes9Ds+/UuNGqAN4vMqGjLN8KoF9DmzDoMbPMZ/
 wMWIXwYNxIlLbfMK2vA==
X-Proofpoint-ORIG-GUID: iQl2bPnGO4GAkYjG_46D3jnneKaByzvI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3OSBTYWx0ZWRfX/JFIgWLLDrEv
 4uA/cRHPETAHaE3tPnGzeVlr8K5IlC35MK//vvD97JgmRLsZjFu/iOg+buJD94SfUKWap44cGIE
 RMXAdoaGiQT56QJLsUNHrsxaREHH7TY=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a97e8d8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=oAQvYTIzDSDSlRPHBVEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020079

On Wed, Sep 02, 2026 at 09:30:17AM +0100, Marc Zyngier wrote:
> On Wed, 02 Sep 2026 01:38:53 +0100,
> Sean Christopherson <seanjc@google.com> wrote:
> > 
> > On Mon, Aug 31, 2026, Steffen Eiden wrote:
> > > Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> > > where one KVM implements MMIO but others do not. Solve this by
> > > additionally testing for the non-existence of KVM_NO_MMIO before
> > > including MMIO code to KVM.
> > 
> > Ewwwww.  IIUC, s390 ends up with two KVM modules, i.e. there really are two different
> > KVMs being built.  Rather than have a KVM_MMIO and NO_KVM_MMIO, I vote very
> > strongly to drop CONFIG_KVM_MMIO entirely and replace it with __KVM_HAVE_ARCH_MMIO,
> > a la __KVM_HAVE_ARCH_VM_FREE and others.  Tracking two separate macros is going
> > to be annoying to maintain, and will definitely be confusing for non-s390 people.
> > 
> > It'll mean linking in an emtpy coalesced_mmio.o on s390 when building without arm64
> > support, but I'm guessing that won't be at all common for s390 builds.
> > 
> 
> I ended-up doing something very similar locally, because I couldn't
> really make head or tail of the logic while being in holiday mode
> (which doesn't help). However, I kept the negative logic, so that we
> don't need to add anything to any architecture but S390 (they are the
> odd one out here).
negative makes sense. 
IIRC KVM/power does select KVM_MMIO most of the times but not always.
I'll check that.

> 
> Untested hack follows.
> 
> 	M.

Thanks!
I'll verify and integrate it

	Steffen

...
