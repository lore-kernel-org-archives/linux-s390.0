Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D33EC829;
	Thu,  8 Oct 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449436; cv=none; b=AvpOCpiaReR00P9JfoVcFLvHYtiV5gW0AgQaTaRvl1Pyr6167N2UySuamYtrKiLH1YUGyuOvZ+XADvZep67K3yGujc7UuOgCqAb0eVm88PZ/WFfIaRN9QxqMZf3xStWQgG1aLWH6OxsOaLCmyyDsstMY+EZnADqfXetq/CxJbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449436; c=relaxed/simple;
	bh=Juv2C+V0irH5GhmWxr15zigmYH1PMqK1Kz7ehUS9Ci8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kfm92x3mkMou7hckTO0F3IFx0EPC/SFE4nHfqPyz6orCl+rFcyhlVqsJk7GpUfwDShOwTfuJvpHtKPJ0oI/GttsKl0p4BnY+puKkQePaLGVWL+vZ9E7ajXSzwDzcPTzVL54Fj2SAzY2ltT3B0hbM79kzrEQ58iUIFx/X941se4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azkXNcWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azkXNcWq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZZo9588932;
	Thu, 8 Oct 2026 08:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8TiEl1
	KAxxu4Kg6F4TmQ2agRG0ciLFMV0YNV1cCZzU8=; b=azkXNcWqpL4gu8awaNzpSA
	HHWBHdMSwtfiZKdRsveLn6VPYpLS1ZrWsu9Enq1Xv2nvBuXy5HUIZp3GwhyC+Npc
	JiOzZl7rEsKuO5HDdcE9Ya0GyEidYx3NSW+AQ9vHmDIQ/PRKHgx6lQ8dNbaMPaHH
	CBQKqzZe3ANpQUoKNX6SWfwg7p5yLnwU4eRNlHQY7B/v7Jlv+sv7i0C1ZssOng0N
	aGgyE2SIa3LuauZHXMmac0VUvp8zYgqSIKElaJht35ANoQKzIgdynmyR5uzuTM32
	bioPmoAbMLau/bKFKjwXSzW5GuHE+WIVWo3IpABrN+NzojLm5tXD+vT7QWmXRbCg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw29j3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:50:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IUTv3149960;
	Thu, 8 Oct 2026 08:50:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dpada-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:50:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6988oRl438732052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:50:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E36620043;
	Thu,  8 Oct 2026 08:50:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3250920040;
	Thu,  8 Oct 2026 08:50:27 +0000 (GMT)
Received: from [9.87.144.213] (unknown [9.87.144.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:50:27 +0000 (GMT)
Message-ID: <f082e43f024a3aa4a897b388b346eff4edea37ec.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik	
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Gerd Bayer
	 <gbayer@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:50:26 +0200
In-Reply-To: <9e3894fa-0a1e-432b-ba1d-76ea34d4f648@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
	 <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
	 <sashiko-outbox-162922@kernel.org>
	 <8086f631ce7ce60f1763171c8f05b050ff6c73fd.camel@linux.ibm.com>
	 <9e3894fa-0a1e-432b-ba1d-76ea34d4f648@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNCBTYWx0ZWRfXypB36NmXx2/8
 8eRtJV4Px+0zNs58TJ1ucIOGFt0bteDMxVcXoJGfGFiFi3ILzHfMCCPnOAasOA9S8rofRdMXEho
 7G6ZFZcboElA0YHSYe3igrtXaRmB9+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNCBTYWx0ZWRfX3wFrSXb/2Wjy
 UVcMbt+uJF2gHefpqBzlDEC3uCIz5s1fE8U6PrgtN9JXkGbiKlZ97ECQQxYm1MuyBdjeLsEeeQf
 UP/TdeA0cGgvHIeuuIh7bRQuGrmFsMpIxGx8lX/8IHT/ioeZeY7d7fba2goNikTIW6eohRB0TOk
 VFu3cpp++qvz8p410JdetbW4uNX2rZFZv8e/QKcGYAwZjB0AlunLxu8Aamjbw1MHdZJBRQMar2P
 eSJreU2FPEHQQCvnCJO520Y2hvW23UcBqNwCBBj7q4n2RWnzUt5VphuTo04mN+Aw2HfNISVl/RO
 fK15GaQO8Hcv+Vhx7lDIL7bNxvyx1GuykYUJW0ipj/nTEZ63TxX0J2UWZyYNJ0UVMtQzIpNlmOC
 HIscUvpINrXXSGqQyywGNS6aaZ5S6F41nBvpTytl1MhheNKHsFKx/X/nNGYYk0dKOlL4JWnnL2i
 n2myGV3NdZqr4gd+hlw==
X-Proofpoint-GUID: lyGhy3qTWks-qMvbq45vU3OhBXKygFlg
X-Proofpoint-ORIG-GUID: lyGhy3qTWks-qMvbq45vU3OhBXKygFlg
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac75959 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uAU7TOegW6suiBGCkl8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080034

On Wed, 2026-10-07 at 12:21 -0400, Matthew Rosato wrote:
> On 10/7/26 10:46 AM, Gerd Bayer wrote:
> > On Wed, 2026-10-07 at 11:19 +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [High] s390/pci: infinite loop in zpci_refresh_trans on CC=3D2
> > > --
> > >=20
> > > commit 1c8706bb963f0d551da7d8535f804ca9f9b4305a
> > > Author: Gerd Bayer <gbayer@linux.ibm.com>
> > >=20
> > > s390/pci: Use 32-bit fh outside of inline asm
> > >    =20
> > > zpci_refresh_trans() declared the PCI function handle as a u64 type j=
ust
> > > because the actual RPCIT machine instruction required that in a 64bit
> > > register, while the function handle is architected as a 32bit type an=
d
> > > defined as such in the zpci_dev struct.
> > >=20
> > > > diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> > > > index 2ba787e2304b5..053afb3e7a990 100644
> > > > --- a/arch/s390/pci/pci_insn.c
> > > > +++ b/arch/s390/pci/pci_insn.c
> > > > @@ -117,13 +117,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u6=
4 range, u8 *status)
> > > >  	return CC_TRANSFORM(cc);
> > > >  }
> > > > =20
> > > > -int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
> > > > +int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
> > > >  {
> > > > +	u64 req =3D ZPCI_CREATE_REQ(fh, 0, 0);
> > > >  	bool retried =3D false;
> > > >  	u8 cc, status;
> > > > =20
> > > >  	do {
> > > > -		cc =3D __rpcit(fn, addr, range, &status);
> > > > +		cc =3D __rpcit(req, addr, range, &status);
> > > >  		if (cc =3D=3D 2) {
> > > >  			udelay(ZPCI_INSN_BUSY_DELAY);
> > >=20
> > > [Severity: High]
> > > Does this retry loop risk causing an infinite loop or CPU stall when =
handling
> > > large DMA spaces?
> > >=20
>=20
> This should really have been flagged as a pre-existing issue vs a new
> regression, it is not a behavior introduced (or changed) by your patch.

Yes, I agree. This patch didn't touch/remove the capability to pass
back a modified addr or range.

>=20
> > > When the s390x RPCIT instruction sets CC=3D2, it indicates that it ca=
nnot complete
> > > the operation in the allotted time. It then updates the address and r=
ange
> > > registers to reflect the remaining uncompleted portion.
> >=20
> > I've re-read the relevant ISA documentation a couple times now. I don't
> > find any mention of address and range being modified after RPCIT was
> > executed - regardless of condition code or status.
> >=20
> > Maybe @Niklas or @Matt have an idea where this allegation of "CC=3D2
> > means partial completion and one should retry with an updated
> > iova/range" comes from?
>=20
> FWIW, it's not coming from QEMU -- we don't even have a CC=3D2 return cas=
e
> for RPCIT today, and we never update the iova/range on return.
>=20
> Perhaps, lacking access to the ISA documentation, it made an assumption
> that the range would be updated to shorten the next RPCIT as this would
> allow us to converge towards a smaller and smaller range each attempt to
> potentially not hit the busy condition eventually - sounds logical anyway=
?
>=20
> But I also find nothing that indicates the range will/should be updated
> on CC=3D2 (or otherwise) from RPCIT; so it does just sound like a bad
> assumption.

Thanks for the confirmation.

> >=20
> > > However, in __rpcit(), addr_range is passed using an input-only const=
raint ("d"
> > > instead of "+d"), and the arguments are passed by value:
> > >=20
> > > arch/s390/pci/pci_insn.c:__rpcit() {
> > > 	union register_pair addr_range =3D {.even =3D addr, .odd =3D range};
> > > 	...
> > > 		: [addr_range] "d" (addr_range.pair)
> > > }
> > >=20
> > > Because the hardware's partial progress updates to addr and range are=
 discarded,
> > > this loop continually re-invokes __rpcit() with the unmodified origin=
al
> > > addr and range.
>=20
> That matches your observation:  we indeed aren't taking updates to the
> range in __rpcit().  But as you say: there aren't supposed to be any.
>=20
> > >=20
> > > If scanning the initial portion consistently exhausts the hardware ti=
me slice
> > > (such as during IOMMU TLB flushes on devices with large DMA spaces in
> > > zpci_refresh_all()), will the operation fail to advance and loop infi=
nitely?
> >=20
>=20
> That concern sounds valid at face value; if we tried something and it
> couldn't be completed in time, from a linux perspective we are simply
> trying it again without changing anything and hoping everything works
> for the best this time.
>=20
> > I see that all the PCI related instructions in this file may retry
> > indefinitely (with delay) on CC=3D2. However, the architecture guarante=
es
> > that at some point the instruction will end with any of the other
> > condition codes.
>=20
> I think that is the rub.  Sashiko couldn't possibly know that such an
> architecture guarantee exists.
>=20
> I suspect the question is also a bit theoretical: what happens if the
> range is so big that it's impossible for the RPCIT to process it before
> the CC2 trigger point due simply to how big the range provided is?  Then
> you're guaranteed to hit it every time unless you 'chip away' at it by
> shrinking the range after each attempt.
>=20
> I would assume/hope that the SDMA-EDMA range limitation we impose on the
> aperture size already ensures that it is easily possible to handle a
> RPCIT from SDMA thru EDMA without tripping CC=3D2.
> So then the CC=3D2 case becomes purely situational vs a guaranteed result
> even for the largest possible RPCIT request.  That already makes it far
> more reasonable to simply try it again.
>=20
> So: assuming that architecture guarantee stands (we know RPCIT can
> possibly complete for the largest possible range SDMA-EDMA, and we have
> some architected guarantee that the loop will be broken otherwise e.g.
> architecture says it won't keep giving us CC2s forever) then it sounds
> like nothing to fix, but maybe worth a comment in a future patch that
> explains these guarantees, based on what you find in the ISA.
>=20
> I suppose we can consider whether linux should have its own redundancy
> here or not in addition to those guarantees.  That sounds well beyond
> the scope of this series and goes back to what I mentioned at the start:
> this is pre-existing bevahior and should not hold up this patch either wa=
y.

I went back to commit cd24834130ac ("s390/pci: base support") from 2012
when RPCIT was introduced: The potentially endless loop on CC=3D2 was
introduced at the very beginning.

I found explicit words in the ISA specifying that "no other action is
taken" when the instruction ends with CC=3D2. IIRC, CC=3D2 was introduced
to signal a program that there are internal inhibitors present that
prohibit to even start the requested "refresh" - or other PCI
instructions. I still have to search for a statement that guarantees at
the architecture level that CC=3D2 won't be presented forever. When I
find that, I'll think about how to frame that into a future patch.

>=20
> Thanks,
> Matt

Thank you,
Gerd
