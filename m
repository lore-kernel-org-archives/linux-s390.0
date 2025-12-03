Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9646AD51;
	Wed,  3 Dec 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765187; cv=none; b=ek0bwRKhmpxYU6CEROTG9TatrCpSpJ7abtxwGy1+WL4/IzAl9t/9X2AGiFluuaICrqVl4ParG4is3n8MoFTSOpl+/mF97ENZvGCbljTLUIZBdSuOVDT7P6+lRw4o+IJCgKuojoFQLSUH+5BPGy1xJZUzFuqBrIv4d8IPTQ/0ZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765187; c=relaxed/simple;
	bh=rZzm7t5tYhVx0GLTgbZNReDKwSu7igLhiFoZRznRz3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RthWhyp/aQOYT/0bWthfZRorSjg6tIpJWbcG2Oc2x4smabkc1erWzdV0aqqww7luHz+hft3AVQdp4gxfJJBMIf05CWS8SF2LN25xuAQL8NrnGB9k5GwcSyy1QtCndl5GHUTrYw0n+O6rQTP/kAwh8FlZ9w8hZFoUL6RIuE38xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XxIAVubp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XxIAVubp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3CIToR013151;
	Wed, 3 Dec 2025 12:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dS7Ghb
	Thu1rUQIiSy4D/ccyuH/OSPpmulEE3ZBzDI+Y=; b=XxIAVubpD6vwQdBhtDTJMh
	UmsCCRiKevYqJHqq7rnuE7wwtWj14UmPqlJQhr9yN13abvj8VjnJdQUBs4v3ONUz
	tlxZOsfV4Ox490E6sQRWzWs9quZ5k0NQsyABc5IAS02DSvuEJMGSZsawY40a/uXm
	1XhiUMvUEOAMZ53blDmKauHOtYbt+DulJdvSvFCQKb+zqKgrnudaR//JteK2mcYh
	nth8DMsNyGWAakHQssgic+1GM3a/qbSDg2B3ZSZxlpNqSYQFpE9vSFaA0mxvQ2l7
	GoWWm3ASctwTfJrcvXQi3TDCXkpKaSi5POXBbWdoJ8W3L0JW25AsWgUN6YcezCog
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgas68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 12:32:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3CApk1019075;
	Wed, 3 Dec 2025 12:32:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy23fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 12:32:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B3CWnYp50921774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 12:32:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 730AE20043;
	Wed,  3 Dec 2025 12:32:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D94020040;
	Wed,  3 Dec 2025 12:32:49 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 12:32:49 +0000 (GMT)
Message-ID: <7dea38f38180bd6b5305f72a366ef3df066000de.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Halil Pasic	 <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner	
 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Wed, 03 Dec 2025 13:32:49 +0100
In-Reply-To: <DEOF3L4CJBHA.Q5OSQSIWCD0K@linux.ibm.com>
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
	 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
	 <33d2feb221c2ca89a4d09876a00c40ed0a893118.camel@linux.ibm.com>
	 <DEOF3L4CJBHA.Q5OSQSIWCD0K@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 01JlMc6rENhQDXBZjEbQzN6QKjKh8yDF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX7j8ZqDTlgcb4
 uQYGgAiLoNswBHUS5pp3gkIu2+xNF2hfZzTAKN3Ss7HzYV8TnuCnTN/TTw3ft2F7UvMj/+2zTv9
 MV1/jaxBIfA1qIKqMt+vnd8J0m3pWWk+sqKoyZPoQGYI4MZqFLFRzh1GsbN8G1OF6pW4Fwf6uCl
 /KLz6OgN2G5jGA6HRdEjANTNo/KnjivCGMV0aATqLdcc2CdPUdXRRl+q41XUI3pqTkW5FwCn3tb
 0PFQfI7WeInHR9OrAvyd1uRvd4DFm6v5f7yBdzvzCp7/mBY9FZUdg4/odPa2YcdHa6iWNLoICKl
 0X2oeV3J15U1bjfOsDVNfZkQ12KNIFhpW5y5ICArise4N790uJEP+/rlCvgUlyJ7pt7cjOCrTmA
 LmlTwVhL54oQOZdQm3x97sKFBpuAzQ==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=69302df8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=U0qBMjkbULQbgDQXg6YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 01JlMc6rENhQDXBZjEbQzN6QKjKh8yDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

On Wed, 2025-12-03 at 08:53 +0100, Tobias Schumacher wrote:
> On Tue Dec 2, 2025 at 7:14 PM CET, Gerd Bayer wrote:
> > On Thu, 2025-11-27 at 16:07 +0100, Tobias Schumacher wrote:
> >   [ ... snip ... ]
> >=20
> > > diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> > > index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..2ac0fab605a83a2f06be6=
a0a68718e528125ced6 100644
> > > --- a/arch/s390/pci/pci_irq.c
> > > +++ b/arch/s390/pci/pci_irq.c
> > > @@ -290,146 +325,196 @@ static int __alloc_airq(struct zpci_dev *zdev=
, int msi_vecs,
> > >  	return 0;
> > >  }
> > > =20
> > > -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> > > +bool arch_restore_msi_irqs(struct pci_dev *pdev)
> > >  {
> > > -	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
> > >  	struct zpci_dev *zdev =3D to_zpci(pdev);
> > > -	struct msi_desc *msi;
> > > -	struct msi_msg msg;
> > > -	unsigned long bit;
> > > -	int cpu_addr;
> > > -	int rc, irq;
> > > =20
> > > +	zpci_set_irq(zdev);
> > > +	return true;
> > > +}
> > >=20
> >=20
> > It's always a little tricky to distinguish which code handles both MSI
> > and MSI-X or just MSI proper when routines have _msi_ in their name.
> > But apparently, both __pci_restore_msi_state() and
> > __pci_restore_msix_state() inside pci_restore_msi_state() do call
> > arch_restore_msi_irqs() - so life is good!
>=20
> Regarding arch_restore_msi_irqs() the main change in the patchset is
> that it is now also conditionally  called from zpci_reenable_device().

Sorry, I don't follow: This patch adds a conditional call to
zpci_set_irg() to zpci_reenable_device() - not arch_restore_msi_irqs().

> This is becasue in the recovery case, __pci_restore_msix_state() does
> not call arch_restore_msi_irqs(), it exits directly at the beginning
> because dev->msix_enabled evaluates to false.

Does that mean arch_restore_msi_irqs() is dead code?
After re-reading pci_save_state()/pci_restore_state(), it sounds as if
arch_restore_msi_irqs() may be useful afterall, with device drivers
that consider the MSI/MSI-X interrupt setup part of their save/restore
snapshot? And we just happen to have not executed any of those, maybe?

So probably just leave it in.

> With the legacy API, IRQs are later re-enabled using
> arch_setup_msi_irqs(), which also registers the airq with the hw. With
> the MSI parent domain, zpci_msi_prepare() would register the airq, but
> is not called in the recovery path. This is why it is now added to
> zpci_reenable_device()
>=20
>=20
> >   [ ... snip ... ]
> >=20
> > > +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned=
 int virq,
> > > +				 unsigned int nr_irqs)
> > > +{
> > > +	struct irq_data *d;
> > > +	int i;
> > > =20
> > > -	return (zdev->msi_nr_irqs =3D=3D nvec) ? 0 : zdev->msi_nr_irqs;
> > > +	for (i =3D 0; i < nr_irqs; i++) {
> > > +		d =3D irq_domain_get_irq_data(domain, virq + i);
> > > +		irq_domain_reset_irq_data(d);
> >=20
> > Question: zpci_msi_alloc_domain() did modify airq data, can this be
> > left as is in zpci_msi_domain_free()?
>=20
> I was thinking about this myself and came to the conclusion that it is
> fine. zpci_msi_domain_alloc() sets the ptr to the msi parent domain and
> data to the encoded hwirq. Both fields are only required in the IRQ
> handler.
> * When free() is called, the corresponding interrupt was already
>   deactivated by the hardware, so hardware shouldn't generate it
>   anymore anyway.
> * If, for whatever reason, hw still generates the interrupt,
>   generic_handle_domain_irq returns an error since the hwirq cannot be
>   resolved.
> * If the IRQ gets allocated again, the fields are written again before
>   the IRQ is activated. The data written will even be the same
>   as it was before.

Well, this is all assuming no further errors in the code...
I'd still vote to clean up airq resources when they are no longer
needed - just act defensively in case some weird (future) path still
tries to use these after they got put to rest - or you have to do some
post-mortem dump analysis and try to make sense of this "garbage".

>=20
> >    [ ... snip ... ]
> >=20
> >=20
> > > +
> > > +int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
> > > +{
> > > +	char fwnode_name[18];
> > > =20
> > > -	if (zdev->aisb !=3D -1UL) {
> > > -		zpci_ibv[zdev->aisb] =3D NULL;
> > > -		airq_iv_free_bit(zpci_sbv, zdev->aisb);
> > > -		zdev->aisb =3D -1UL;
> > > +	snprintf(fwnode_name, sizeof(fwnode_name), "ZPCI_MSI_DOM_%04x", zbu=
s->domain_nr);
> > > +	struct irq_domain_info info =3D {
> > > +		.fwnode		=3D irq_domain_alloc_named_fwnode(fwnode_name),
> > > +		.ops		=3D &zpci_msi_domain_ops,
> > > +	};
> > > +
> > > +	if (!info.fwnode) {
> > > +		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
> > > +		return -ENOMEM;
> > >  	}
> > > -	if (zdev->aibv) {
> > > -		airq_iv_release(zdev->aibv);
> > > -		zdev->aibv =3D NULL;
> > > +
> > > +	if (irq_delivery =3D=3D FLOATING)
> > > +		zpci_msi_parent_ops.required_flags |=3D MSI_FLAG_NO_AFFINITY;
> >=20
> > Add empty line here, so the intent is clear that the following
> > assignment is executed unconditionally.
>=20
> Ok.
>=20
> >    [ ... snip ... ]
> > =20
> > > @@ -466,6 +551,7 @@ static int __init zpci_directed_irq_init(void)
> > >  		 * is only done on the first vector.
> > >  		 */
> > >  		zpci_ibv[cpu] =3D airq_iv_create(cache_line_size() * BITS_PER_BYTE=
,
> > > +					       AIRQ_IV_PTR |
> > >  					       AIRQ_IV_DATA |
> > >  					       AIRQ_IV_CACHELINE |
> > >  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
> >=20
> >=20
> > This looks very good to me already. Unfortunately, I was unable to
> > relieve my MSI vs. MSI-X anxiety regarding arch_restore_msi_irqs() with
> > a test since the only MSI-using PCI function (ISM) is not supporting
> > PCI auto-recovery :(
> >=20
> > But a mlx5 VF now recovers just fine!
>=20
> Did my expanation above help with this?

Yes, thank you. But I still would request to address the airq cleanup
in zpci_msi_domain_free().

> Thanks
> Tobias

Thanks,
Gerd
