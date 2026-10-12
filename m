Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF278470438;
	Mon, 12 Oct 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795095; cv=none; b=dJ4rnw/ckOu/jxxkSG2sfc7uQeT/BtL+eF0NK8gQCUaN/d3miSOvXa4rPtqTFb5vChN6296NzRVHXQQsmn57iUWt6fKvj2BL5DPu0vBD/3QVkvCbE6aIh/ModF5k9hPd+DouO4DCwJKg8PLVFaerzK00Ayf63a8ONdCd+LUDC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795095; c=relaxed/simple;
	bh=r45O+/xXmTzQOIKeFrn9S7D05dFYzOMFhDO5HNP1t28=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KpHbasvGxu/Hqf/J/x6D8xt8dEXz25tphfGWvmb6omMlvnKpUjLyUwOhpTrp1T6S/ODIll0kfzuf0iWma6e32K7TgBFB7NkPuCSb2LsMyXxeVWqCFlALpT2Eb/cADa3oJBG1kvqqGvuQIdbKgZxe1itnOfqToiKKjUvvpo6r/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WAKc5ntB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WAKc5ntB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iJ0n3810233;
	Mon, 12 Oct 2026 08:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/OSjIU
	WwVaZ47cwRPJEe1K6dVET6WakK8haYqFTR7fE=; b=WAKc5ntBdIMl+qtcEaKOKU
	IpNxzSofp+TH5xgDhylenCeeYIEB5uzJKt3oYhgZ1QXI1NzMW5CHvctRlIFY6sRC
	ggLfO8I6oat7o7+LIfCSbFSLPPY2AiamS5tFo/miAAzgsFPnbdbOWD43LDw69ihS
	S/fXiZ5HdkZjNvayFoweL1SiVDz9Ew/9O5U+pnNBHMiHIwcs3JzmVroFH/XGYQXr
	kIqoVk/SoN2WRbhcc8dJ2zXRaIev0ACs5g1bGMdDDjY78RqsNROqoo2OMebOJDhS
	ueR9S9FTjRx8fmABCxbWR3vHuW5KgRE0hePmerPYM0IiHpayNCqJU/3h/cJl4Pxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhqqpc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:51:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K22L3934747;
	Mon, 12 Oct 2026 08:51:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfv7uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:51:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8pOZj31785504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:51:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACA5A5805A;
	Mon, 12 Oct 2026 08:51:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5363658063;
	Mon, 12 Oct 2026 08:51:23 +0000 (GMT)
Received: from [9.224.91.56] (unknown [9.224.91.56])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:51:23 +0000 (GMT)
Message-ID: <e99fe7f709317a8f5680112fe50995027e173181.camel@linux.ibm.com>
Subject: Re: [PATCH v3 8/8] s390/pci: Unregister the adapter interrupt
 first in zpci_irq_exit()
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Alexander Gordeev	 <agordeev@linux.ibm.com>
In-Reply-To: <DM04BTXODU3S.39KDFFEEM0BNP@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
	 <20261009-s390_irq_domain_fixes-v3-8-ced19028da3c@linux.ibm.com>
	 <sashiko-outbox-164943@kernel.org>
	 <DM04BTXODU3S.39KDFFEEM0BNP@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:50:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX6iIgofEOt9p6
 nvettxEAFRX0juWalfuYP4feJQMjWflNwqIuFDkpoHDRGIxa5zyEf5u42gNxSmYENjy/k7GbVlh
 3zR+yxNkaMwwXbOHqOoMxmPgZN2ZHdLAmL+VRovGay8dvR9XRj+F3BOWsdskA/Hmg05freZ6gLk
 lXOP40UJ9h5VdXXzHBKBolbxbiYHkmRApgbTJKP1PA00vTOkWHWEIaDu8K3lLctAj/OQzaLk27j
 DACvR9XX9c5Og1qLBzuDfU0Qf4hTWN0xh8XYwp5neZtSbWHO2ESz7RJrVfFyo4YEE/UOCsAunmM
 EJ5ES57TMg6JDAM3AYjsNoXNvFHDq4HTIAfCnKfBy7pqzaCj7DEHsLyK7KpDfFcqbKpT2+NBTx5
 7Iq/qTvbPoH7YfrB4fPzDv2pH667ErZGuzQaxBJ7fmZCxag1QctdqSwEsmvstIkUIBkb5acytsk
 ngXR3lzHPlhWZS4BvUg==
X-Proofpoint-GUID: TQ9-LJlYCZjPk0EGvyh0aCeaMD9coupU
X-Proofpoint-ORIG-GUID: TQ9-LJlYCZjPk0EGvyh0aCeaMD9coupU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX9D89eUZsnCC1
 //8TLv8RpdfFasBapTm0j9LhqdSGsybaWTrngA+lj2fymchRd+rddPcUBK0ShIrHxhe8fy//jDR
 zpiE4tfWfZHPlfxf1gEIc+MzcA10fkc=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc9f8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IOKMQBWHGGPYXvr662wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120034

On Fri, 2026-10-09 at 09:10 +0200, Tobias Schumacher wrote:
> On Fri Oct 9, 2026 at 8:29 AM CEST, sashiko-bot wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] s390/pci: UAF memory corruption in MSI setup due to missing de=
vice teardown
> > --
> >=20
> > commit 4f6e192e648a7af5752afbd15f3be9f0172b9594
> > Author: Tobias Schumacher <ts@linux.ibm.com>
> >=20
> > s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()
> >=20
> > This commit modifies zpci_irq_exit() to unregister the adapter interrup=
t before
> > freeing the interrupt bit vectors. This aims to prevent vectors from be=
ing
> > freed under a live handler during the pci_base_init() error path.
> >=20
> > > diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> > > index 4b8ebb987580b..16ae80ed2d139 100644
> > > --- a/arch/s390/pci/pci_irq.c
> > > +++ b/arch/s390/pci/pci_irq.c
> > > @@ -674,6 +674,7 @@ void __init zpci_irq_exit(void)
> > >  {
> > >  	unsigned int cpu;
> > >=20
> > > +	unregister_adapter_interrupt(&zpci_airq);
> > >  	if (irq_delivery =3D=3D DIRECTED) {
> > >  		for_each_possible_cpu(cpu) {
> > >  			airq_iv_release(zpci_dibv[cpu]);
> > > @@ -684,5 +685,4 @@ void __init zpci_irq_exit(void)
> > >  	}
> > >  	if (zpci_sbv)
> > >  		airq_iv_release(zpci_sbv);
> >=20
> > [Severity: High]
> > Does this change fully resolve the use-after-free risk in the pci_base_=
init()
> > error path?
> >=20
> > While moving unregister_adapter_interrupt() prevents the interrupt hand=
ler
> > from accessing the vectors while they are being freed, it appears the d=
evices
> > registered earlier by zpci_scan_devices() are never unregistered when
> > pci_base_init() fails during zpci_fw_sysfs_init().
> >=20
> > If a driver later binds to one of these still-registered devices and ca=
lls
> > pci_alloc_irq_vectors(), the PCI MSI setup accesses the freed zpci_sbv
> > and zpci_ibv structures:
> >=20
> > arch/s390/pci/pci_irq.c:__alloc_airq() {
> >     ...
> >     /* Allocate adapter summary indicator bit */
> >     *bit =3D airq_iv_alloc_bit(zpci_sbv);
> >     ...
> >     /* Wire up shortcut pointer */
> >     rcu_assign_pointer(zpci_ibv[*bit], zdev->aibv);
> >     ...
> > }
> >=20
> > Could this lead to memory corruption when a driver attempts to set up M=
SI on
> > a device that was not properly torn down?
>=20
> Right, this issue exists but is not addressed by this patch. This series
> fixes and cleans the s390 PCI IRQ code, so I'll fix that in a separate pa=
tch
> outside this series.
>=20
> Thanks
> Tobias

I agree and indeed it seems that if zpci_fw_sysfs_init() fails and
we're still trying to probe devices we have bigger issues than
registered interrupts because zpci_mem_exit() frees the iomap. I think
one fix here would be to move the zpci_fw_syfs_init() up before
zpci_scan_devices() such that we won't try probing drivers. Clearly
this is out of scope for this patch though.

On the plus side it seems rather unlikely that zpci_fw_sysfs_init()
fails during boot and if it does I'd be quite concerned what else is
broken.

Thanks,
Niklas
