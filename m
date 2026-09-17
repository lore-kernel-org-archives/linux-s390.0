Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E74DA9AD;
	Thu, 17 Sep 2026 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645317; cv=none; b=vFFTk8gd4fjyOS9cA6X4uohaooVnlHhBM5V+ljKjWVxu/Dp4BvUJ7USyFVxKElEixnknFWg92bGYXuAH10x1JGnf1A6Qms7O8f7o5UVC4zQeQa/aJvVTjGP6/r1oPlBTHRdnbKCS8/tYJrrE9TV61nT5m4pIxrVt7qjlyzgnfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645317; c=relaxed/simple;
	bh=vDKlQ2rl4BEjEMKeeUXZZykr0CFc26klDVFsMOaWkKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aATJ+ivdU/AtIL25E1xYrgwkjDgGdzi16N/lXQi3cZmki+q7eQFoh0Hze/hrAPWmj2rV3Nv3flJmOzE4LeH0dP2YkBbLUjKLYJ0V/F/Hzc+eEkW/6XbaBK+gmyuE98ICKcnzFvH77yRKAYwk/dW1rUoPTSqNuHmuPKvRwW8qlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdCccc/0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdCccc/0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1SIs322296;
	Thu, 17 Sep 2026 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OWR9zTAHWVLpK4bmZCBTkD/N7ttjRZ
	I1QCl8LhAualQ=; b=fdCccc/0BBlVyT49fbLhHCklz8pg8BrLjarFIP3eUti3pZ
	YN0nFpYyDOGyGNQVn99nVNtUVTMUrWxZsGamfnhLEjbU/UIlXyssCXcOedjrMYrL
	EhiCVOfHWktjzQedPpc6iw58LxpE4VrSjj5e9OmlC+tDPG7caqi73e6UrA/2/ZbJ
	qI5wDIZDuS1bh0Hnun3gl2ClMgaynlmFmUdmKPsWItMm2RNOYiwXfKi7ZqOUlTe9
	c4Cw9sgaEMKAnrGCkOvnYnHFLCIPzuxo0K0IPj/PKAZVnRdSujw6DVA/YkFI4b+U
	+qR0AhiHbeS4mHPyxcvwYTdnSX53e+/AeGafH4ng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqj2gt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 11:41:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aHtU2962371;
	Thu, 17 Sep 2026 11:41:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ys762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 11:41:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HBfNxs41746868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 11:41:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAE4E20040;
	Thu, 17 Sep 2026 11:41:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DD592004E;
	Thu, 17 Sep 2026 11:41:23 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 11:41:23 +0000 (GMT)
Date: Thu, 17 Sep 2026 13:41:22 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <20260917114122.474297-B-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com>
 <20260903083857.33034-B-seiden@linux.ibm.com>
 <apmHrnxRLl9BuVhn@google.com>
 <20260903154317.246414-A-seiden@linux.ibm.com>
 <apmhX8H-WUc3U4_N@google.com>
 <51286424-e802-4ea9-b958-925fee8025ed@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51286424-e802-4ea9-b958-925fee8025ed@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfX21RDwL9VzF5j
 aJTLFTOCjHBV8pAJckEPMbqTIyBiThBHZJd8dllJ3JnFt+uArqyb4+UYlqY04brIHLUk8HJj7Rs
 FseQMmPMFOtivK4tzrLPNE9mEq3oHBxLHdUiz1EbWZWI8PxN7Go35NDY/cc02Ffu4/cBY4+B1Rp
 cLpTl3fNMN8AqrThipIaUry8aSxZ1/93/OIzSK4E0Is3CHCpS4HJOKt5GqDYxkFqOvLumFUUNgw
 KL+k6I7mEDreHZoRW+1SF6OTOhuTyw2LzliXfynO5facXjDbmiy42M+R2vrZL4AxUl/+yNVNhiY
 oU09LHQSekY/l10HNKury6qDyBKApPmFXzGEsugJDcuNU8ENiRQKEYruvLPWBx3OXp9YUD2hW7H
 wcIENwyGViDoRbpDFxjJuHxrP3CXOugq9DaL+I2XMVjqoMcpt5STFP3ejHykSdAlZCLBbPRlicI
 VND80dd+b/oAtsWeRyQ==
X-Proofpoint-GUID: mEIQfDHlg26Av6E-D7a4lLq9rs4V3krI
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aabd1e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=fFzJ_os4vFYzPQsHbnAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: e9PGhILaeHOEO5CT_bB5ZuJF45-PfPe0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfXyKbRztHCxg7j
 FZFDYZrOj0mk8jUgeCjgYhXfFeH5KbBUra8SmtMujMguTjMWheMQ/fT+7bzyaB5ERzZumWkCHGC
 uJT/At1ZUEYJ+1z9o2fZn+jkiAPnJp8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170160

On Thu, Sep 17, 2026 at 01:07:47PM +0200, Christian Borntraeger wrote:
> 
> 
> Am 03.09.26 um 18:33 schrieb Sean Christopherson:
> > On Thu, Sep 03, 2026, Steffen Eiden wrote:
> > > On Thu, Sep 03, 2026 at 07:43:58AM -0700, Sean Christopherson wrote:
> > > > And FWIW, while it might seem daunting, from my perspective it's not actually that
> > > > much churn to do things "right".  Provide KVM_S390_NATIVE, and then have KVM reflect
> > > > the "weakest" of S390_NATIVE vs. S390_ARCH.  I.e. make KVM=m if either of the "real"
> > > > KVMs will be a module.  That requires some creative shenanigans, but it's not hard,
> > > > just weird.
> > > 
> > > FYI the first versions of this series had a 3 configs approach very
> > > similar to yours.
> > > 
> > > IIRC it was not so much the churn we have in (upstream) kernel code but
> > > more on the distro side and to everyone building the kernel in their
> > > favourite architecture (s390 :))
> > 
> > How many people are running distro kernels on s390 hardware?  And how many distros
> > actually change the default KVM settings, e.g. to build KVM as a module instead of
> > baking it into the kernel?  My guess is "not many" and "almost none", i.e. the
> > actual impact on downstream users is likely miniscule.
> > 
> > > Suddenly the KVM config changed its behaviour (effectively becoming a noop)
> > 
> > Not really, because "KVM" itself is inaccessible (well, unless someone is hand-
> > editing .configs or generating them by script, but that's their own fault).
> > E.g. upgrading to a new kernel will explicitly prompt the user to choose for both
> > KVM_S390_NATIVE and KVM_S390_ARM64 (or whatever they get called).
> > 
> > > I am starting to think that having no separate config option for arm on
> > > s390 might be the easisest way. Just KVM and guard both modules behind
> > > it. It reduces the config space bloat and I do not see a reason why somoeone
> > > should only compile one KVM module but not the other. kvm-arm64 won't
> > > load if you do not have the hardware anyways.
> > 
> > Because there may be an unforseen need down the road?  Smushing things together
> > after the fact is generally easy, pulling things apart without breaking everything
> > is usually much, much harder.
> > 
> > > But I am not opposed to the x86 approach. Just thinking loud.
> > > 
> > > Anyways, I am off for vacation expect a reduced reply frequency from my
> > > side :)
> Yet another option
> I think there is value in keeping the config space simpte for users.
> Why not simply keep CONFIG_KVM and it will disable, module build, compile-in
> both variants.

Good Idea. I'll merge the configs into one.

