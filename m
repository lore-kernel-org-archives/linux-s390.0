Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE2F83C3;
	Wed,  3 Dec 2025 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770157; cv=none; b=a5K5+AXJTFvIZ4h8zRhVeW+nWKjKnHY4A4bYugmxQrGdyQVWsZoHFe0VRcq4PJKrOD4mzl6nXOEoesQ2s7kq4jobN5V0+eKa8Nb7nOegvjRwm/gxBUHNER+UPTxceSgG20gQMRHPnPNw3ZyHUl8gqsuNFx89TJ0zOtBv1Xkhtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770157; c=relaxed/simple;
	bh=KVeWRu10Nz8EM3eArUIMo8P17UlQ2VDwvtOzAClvGhw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cmHmn9ighbMJllkSPzd7k9PSCTP25eGSXrCItjgQn1vymf8F3K/usXAxFeW2AyMGJzc9/Bg1wq3fjpB9KsRDspEcIZqJwOfAnuAoc+W2XtDYEZk6f2Uc5JuvRZecryI1kOEipnlua1q7K4d3XpG7/EJONx9063W4fOcP7sOmHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mWE7BDO9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mWE7BDO9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B33CfrJ012481;
	Wed, 3 Dec 2025 13:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ylBxmy
	7ug8ebiKEiuhsfMLuYlJC+NV4BEEdRLtgefF8=; b=mWE7BDO91vewkqTPS5WTuB
	zKHPSVCIIyZLtRETlyeSyNBydp1l9CbmJYRPsTdswplCndc20/Fqba2PPnnNIgot
	NoNUV/b403yEJu+B/n+3gMBu4u9of0AOnQ8QM1sUpUwNvEZBU8UURDh8tvp1iJBC
	QK+XCeR1cTg+oqMN/Qc3ECmmrGUsMRdc5/xnNMiIvJfoyKTHheGeApkGsAWiaZGK
	XjoNuzBQvI/fwTp196kDm1ca1oIfv1xcfsogx9UGct4W4ioFwF6ByKIpjP+OY2bH
	G7NwjbaRPIhkLdQScZucMaE/uLICudPvDSjaLlBQ12A2/8N0l0CYSxyTFfofPTnA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5jj27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 13:55:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Ckkrv024059;
	Wed, 3 Dec 2025 13:55:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5sjga4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 13:55:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3DtitA19857964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 13:55:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787BC20043;
	Wed,  3 Dec 2025 13:55:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31CF520040;
	Wed,  3 Dec 2025 13:55:44 +0000 (GMT)
Received: from localhost (unknown [9.155.196.75])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 13:55:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 14:55:44 +0100
Message-Id: <DEOMT00FUY8M.2J9C1SM9BOTTH@linux.ibm.com>
To: "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Gerald
 Schaefer" <gerald.schaefer@linux.ibm.com>,
        "Halil Pasic"
 <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Thomas
 Gleixner" <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: "Tobias Schumacher" <ts@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
 <33d2feb221c2ca89a4d09876a00c40ed0a893118.camel@linux.ibm.com>
 <DEOF3L4CJBHA.Q5OSQSIWCD0K@linux.ibm.com>
 <7dea38f38180bd6b5305f72a366ef3df066000de.camel@linux.ibm.com>
In-Reply-To: <7dea38f38180bd6b5305f72a366ef3df066000de.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R4RglAMJSChz39PyR7qoKEIaqso0Fb-E
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=69304165 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lieHva4L-jORDU__hwUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXxsrkYQRH5/tC
 dV8kN2Ij3DINMDT4F+Rlm0+nlxKkcYebHDhtX+GYyUYDcjIp9ByRt9UIwjjjuSuPoqdLRWIquHV
 XMZ9Fhrevrcuyiadr0vexDSfkyrgXgdzYe6DXMw1XBDDbrYsLXZFY60aZ9nbwKejD5/t8rDey0m
 WfJILBrIwjauPCS2/YE8u2P+3QHv1PyjvlZZwkwVmKhjFnMKr7HCcVKXHF+vThbRYvrlHCTlJy/
 eAEQYWjDsrmjd9aoJub5yGIFSncu/KsZ1CZp7WtNECtYYmSz8obMTcm6VDIaULVfkGWKwDnWZ38
 3NTMNMW6wI6HaFxDdKJL0V3LzkRQrkXRRin2TktJJemlR9lxGo9m7RBewOE88RmXxIb5PHoK4ws
 9jNYpCprHyaOo9ZAuGaRfSXChlXl7w==
X-Proofpoint-GUID: R4RglAMJSChz39PyR7qoKEIaqso0Fb-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

On Wed Dec 3, 2025 at 1:32 PM CET, Gerd Bayer wrote:
> On Wed, 2025-12-03 at 08:53 +0100, Tobias Schumacher wrote:
>> On Tue Dec 2, 2025 at 7:14 PM CET, Gerd Bayer wrote:
>> > On Thu, 2025-11-27 at 16:07 +0100, Tobias Schumacher wrote:
>> >   [ ... snip ... ]
>> >=20
>> > > diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> > > index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..2ac0fab605a83a2f06be=
6a0a68718e528125ced6 100644
>> > > --- a/arch/s390/pci/pci_irq.c
>> > > +++ b/arch/s390/pci/pci_irq.c
>> > > @@ -290,146 +325,196 @@ static int __alloc_airq(struct zpci_dev *zde=
v, int msi_vecs,
>> > >  	return 0;
>> > >  }
>> > > =20
>> > > -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>> > > +bool arch_restore_msi_irqs(struct pci_dev *pdev)
>> > >  {
>> > > -	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
>> > >  	struct zpci_dev *zdev =3D to_zpci(pdev);
>> > > -	struct msi_desc *msi;
>> > > -	struct msi_msg msg;
>> > > -	unsigned long bit;
>> > > -	int cpu_addr;
>> > > -	int rc, irq;
>> > > =20
>> > > +	zpci_set_irq(zdev);
>> > > +	return true;
>> > > +}
>> > >=20
>> >=20
>> > It's always a little tricky to distinguish which code handles both MSI
>> > and MSI-X or just MSI proper when routines have _msi_ in their name.
>> > But apparently, both __pci_restore_msi_state() and
>> > __pci_restore_msix_state() inside pci_restore_msi_state() do call
>> > arch_restore_msi_irqs() - so life is good!
>>=20
>> Regarding arch_restore_msi_irqs() the main change in the patchset is
>> that it is now also conditionally  called from zpci_reenable_device().

Right, sorry.=20

> Sorry, I don't follow: This patch adds a conditional call to
> zpci_set_irg() to zpci_reenable_device() - not arch_restore_msi_irqs().
>
>> This is becasue in the recovery case, __pci_restore_msix_state() does
>> not call arch_restore_msi_irqs(), it exits directly at the beginning
>> because dev->msix_enabled evaluates to false.
>
> Does that mean arch_restore_msi_irqs() is dead code?
> After re-reading pci_save_state()/pci_restore_state(), it sounds as if
> arch_restore_msi_irqs() may be useful afterall, with device drivers
> that consider the MSI/MSI-X interrupt setup part of their save/restore
> snapshot? And we just happen to have not executed any of those, maybe?
>
> So probably just leave it in.

No, it's not dead code. After the zpcictl --reset-fw, MSI-X interrupts
are shutdown before the pci_restore_state(), which is why
arch_restore_msi_irqs() is not called. But a driver can still call
pci_save_state() and pci_restore_state() without shutting down MSI IRQs
before, in which case arch_restore_msi_irqs() is called.

>> With the legacy API, IRQs are later re-enabled using
>> arch_setup_msi_irqs(), which also registers the airq with the hw. With
>> the MSI parent domain, zpci_msi_prepare() would register the airq, but
>> is not called in the recovery path. This is why it is now added to
>> zpci_reenable_device()
>>=20
>>=20
>> >   [ ... snip ... ]
>> >=20
>> > > +static void zpci_msi_domain_free(struct irq_domain *domain, unsigne=
d int virq,
>> > > +				 unsigned int nr_irqs)
>> > > +{
>> > > +	struct irq_data *d;
>> > > +	int i;
>> > > =20
>> > > -	return (zdev->msi_nr_irqs =3D=3D nvec) ? 0 : zdev->msi_nr_irqs;
>> > > +	for (i =3D 0; i < nr_irqs; i++) {
>> > > +		d =3D irq_domain_get_irq_data(domain, virq + i);
>> > > +		irq_domain_reset_irq_data(d);
>> >=20
>> > Question: zpci_msi_alloc_domain() did modify airq data, can this be
>> > left as is in zpci_msi_domain_free()?
>>=20
>> I was thinking about this myself and came to the conclusion that it is
>> fine. zpci_msi_domain_alloc() sets the ptr to the msi parent domain and
>> data to the encoded hwirq. Both fields are only required in the IRQ
>> handler.
>> * When free() is called, the corresponding interrupt was already
>>   deactivated by the hardware, so hardware shouldn't generate it
>>   anymore anyway.
>> * If, for whatever reason, hw still generates the interrupt,
>>   generic_handle_domain_irq returns an error since the hwirq cannot be
>>   resolved.
>> * If the IRQ gets allocated again, the fields are written again before
>>   the IRQ is activated. The data written will even be the same
>>   as it was before.
>
> Well, this is all assuming no further errors in the code...
> I'd still vote to clean up airq resources when they are no longer
> needed - just act defensively in case some weird (future) path still
> tries to use these after they got put to rest - or you have to do some
> post-mortem dump analysis and try to make sense of this "garbage".

Ok, I can do that.

>> >    [ ... snip ... ]
>> > =20
>> > > @@ -466,6 +551,7 @@ static int __init zpci_directed_irq_init(void)
>> > >  		 * is only done on the first vector.
>> > >  		 */
>> > >  		zpci_ibv[cpu] =3D airq_iv_create(cache_line_size() * BITS_PER_BYT=
E,
>> > > +					       AIRQ_IV_PTR |
>> > >  					       AIRQ_IV_DATA |
>> > >  					       AIRQ_IV_CACHELINE |
>> > >  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>> >=20
>> >=20
>> > This looks very good to me already. Unfortunately, I was unable to
>> > relieve my MSI vs. MSI-X anxiety regarding arch_restore_msi_irqs() wit=
h
>> > a test since the only MSI-using PCI function (ISM) is not supporting
>> > PCI auto-recovery :(
>> >=20
>> > But a mlx5 VF now recovers just fine!
>>=20
>> Did my expanation above help with this?
>
> Yes, thank you. But I still would request to address the airq cleanup
> in zpci_msi_domain_free().

Ok, will do.

Thanks
Tobias
