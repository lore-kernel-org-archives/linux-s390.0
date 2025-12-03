Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390A29AAEA;
	Wed,  3 Dec 2025 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748415; cv=none; b=XcWQ73V6tj5bX3acpSY37/7JnEEPsY/ybbjM0bbkRVAlqAYEG9cdfNI7zIpNUrYZUCMo9y9gNsFHsew7d9prtTD3DNv5hb0uCTp1NWmzefA3s+TyFS1sPiD3AGrripK+D15T2NZdsEGDs8TvOhr5VLLLcCYMq8tyWHC4UmOQYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748415; c=relaxed/simple;
	bh=/IOevQhobQ1i47cEMLomol01/xIKoEhj4PSqPCStMBM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jjX2KEdrCa1ijldr3jhGxF/3UGO6Ee/Yy5jC9LpRpGDYHmXoXcDvYGKgMngmlCbBI3vuLExfkf/r3tpW0iHVmhI5oJWQa21fL3wKY55ZA66sVX8qdZgZqwPVK4zeL6YRpqUNc368PWyIN5HwbjYz/8SVNI8XnayQWvgmAG9TJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1TIe01q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1TIe01q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B37UMQt003477;
	Wed, 3 Dec 2025 07:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XBT+6Q
	tCKMp/MBqLHKPjZsT0vBMMY9MNKfLozVtgy0c=; b=g1TIe01qq5a+c5ysYJjtlZ
	FmVz/LuKLfX338WAoFJqOeMl3XiLmJm4g+yiJtMCPqduUKdX1ad94RfD+GDmX0YC
	Ild7ZxSJC++UgOC5DfsW8lTFqoZmum2Xx1aeWUCNyExIWzMGi8FJH35wlEmtIKLl
	x3Q1K89/r3nC3pzjr0ak4mc3Gy3EsaCYiuqREnJRLO0xrm9LBOoo3r0S83/02KXT
	8SZjenOjJ4T15z7Uj9+Jbr3OUDj3hV9gAt19l4dAN/mO7FuELjf11YsF+ZzMdhZr
	mTCwvY5+k6Ku5LlwDE9Dz3JpmraoJv1QiuVq/H3NqU04ecQfVbmNXyIwz8BmjRJg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9sefc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 07:53:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B34uD6W019051;
	Wed, 3 Dec 2025 07:53:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy109j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 07:53:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B37rPJf13500772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Dec 2025 07:53:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38C0F20043;
	Wed,  3 Dec 2025 07:53:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E248220040;
	Wed,  3 Dec 2025 07:53:24 +0000 (GMT)
Received: from localhost (unknown [9.155.196.75])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Dec 2025 07:53:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 08:53:24 +0100
Message-Id: <DEOF3L4CJBHA.Q5OSQSIWCD0K@linux.ibm.com>
From: "Tobias Schumacher" <ts@linux.ibm.com>
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
X-Mailer: aerc 0.21.0
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
 <33d2feb221c2ca89a4d09876a00c40ed0a893118.camel@linux.ibm.com>
In-Reply-To: <33d2feb221c2ca89a4d09876a00c40ed0a893118.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fNiQlBHlg1HCjlmIXrMo-TFjGsH5KOeM
X-Proofpoint-ORIG-GUID: fNiQlBHlg1HCjlmIXrMo-TFjGsH5KOeM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX2/Geg2plvJju
 RrTRy4P+ed6TeKvJO3mVKmuTbrEhHxe/OXo4ETKUPqRZLyNutyt5G9Sa7hNmecqJS8j+GEcrGGX
 1gcBDfVyUe40Rn2WideBHLBzICUwlZFmssNAak6PG5jN12x8POEHrD9HvOYpzBQS1Bla25dJOKV
 Jc2Vv0XCR2PbnwHbJ2QixQ0suZsGm3ZugdI8el7NqTqszHUSzjc/t0x518L/PCEQ7c1caCrOvSN
 nTljYsh0IBqddQBJPY9KWkovDcgLWqgHtGTDRPkDV35ZADTOVEFQX9CiFnWGNuFh2V5VgGxN9XE
 vClZKhtk8ifGhSEI21+lA+btQvISwyi9RlO1EZh8X1WT0kWYg3mtKtuRSfdzyM8fj5iE6DXIQSp
 m/rxTPrCaTD+PkXh7peTMmzlmnSWhA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692fec7a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G-R7nP6ZrLRClLtA3OQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Tue Dec 2, 2025 at 7:14 PM CET, Gerd Bayer wrote:
> On Thu, 2025-11-27 at 16:07 +0100, Tobias Schumacher wrote:
>   [ ... snip ... ]
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index e73be96ce5fe6473fc193d65b8f0ff635d6a98ba..2ac0fab605a83a2f06be6a0a=
68718e528125ced6 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -290,146 +325,196 @@ static int __alloc_airq(struct zpci_dev *zdev, i=
nt msi_vecs,
>>  	return 0;
>>  }
>> =20
>> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>> +bool arch_restore_msi_irqs(struct pci_dev *pdev)
>>  {
>> -	unsigned int hwirq, msi_vecs, irqs_per_msi, i, cpu;
>>  	struct zpci_dev *zdev =3D to_zpci(pdev);
>> -	struct msi_desc *msi;
>> -	struct msi_msg msg;
>> -	unsigned long bit;
>> -	int cpu_addr;
>> -	int rc, irq;
>> =20
>> +	zpci_set_irq(zdev);
>> +	return true;
>> +}
>>=20
>
> It's always a little tricky to distinguish which code handles both MSI
> and MSI-X or just MSI proper when routines have _msi_ in their name.
> But apparently, both __pci_restore_msi_state() and
> __pci_restore_msix_state() inside pci_restore_msi_state() do call
> arch_restore_msi_irqs() - so life is good!

Regarding arch_restore_msi_irqs() the main change in the patchset is
that it is now also conditionally  called from zpci_reenable_device().
This is becasue in the recovery case, __pci_restore_msix_state() does
not call arch_restore_msi_irqs(), it exits directly at the beginning
because dev->msix_enabled evaluates to false.

With the legacy API, IRQs are later re-enabled using
arch_setup_msi_irqs(), which also registers the airq with the hw. With
the MSI parent domain, zpci_msi_prepare() would register the airq, but
is not called in the recovery path. This is why it is now added to
zpci_reenable_device()


>   [ ... snip ... ]
>
>> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned in=
t virq,
>> +				 unsigned int nr_irqs)
>> +{
>> +	struct irq_data *d;
>> +	int i;
>> =20
>> -	return (zdev->msi_nr_irqs =3D=3D nvec) ? 0 : zdev->msi_nr_irqs;
>> +	for (i =3D 0; i < nr_irqs; i++) {
>> +		d =3D irq_domain_get_irq_data(domain, virq + i);
>> +		irq_domain_reset_irq_data(d);
>
> Question: zpci_msi_alloc_domain() did modify airq data, can this be
> left as is in zpci_msi_domain_free()?

I was thinking about this myself and came to the conclusion that it is
fine. zpci_msi_domain_alloc() sets the ptr to the msi parent domain and
data to the encoded hwirq. Both fields are only required in the IRQ
handler.
* When free() is called, the corresponding interrupt was already
  deactivated by the hardware, so hardware shouldn't generate it
  anymore anyway.
* If, for whatever reason, hw still generates the interrupt,
  generic_handle_domain_irq returns an error since the hwirq cannot be
  resolved.
* If the IRQ gets allocated again, the fields are written again before
  the IRQ is activated. The data written will even be the same
  as it was before.

>    [ ... snip ... ]
>
>
>> +
>> +int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
>> +{
>> +	char fwnode_name[18];
>> =20
>> -	if (zdev->aisb !=3D -1UL) {
>> -		zpci_ibv[zdev->aisb] =3D NULL;
>> -		airq_iv_free_bit(zpci_sbv, zdev->aisb);
>> -		zdev->aisb =3D -1UL;
>> +	snprintf(fwnode_name, sizeof(fwnode_name), "ZPCI_MSI_DOM_%04x", zbus->=
domain_nr);
>> +	struct irq_domain_info info =3D {
>> +		.fwnode		=3D irq_domain_alloc_named_fwnode(fwnode_name),
>> +		.ops		=3D &zpci_msi_domain_ops,
>> +	};
>> +
>> +	if (!info.fwnode) {
>> +		pr_err("Failed to allocate fwnode for MSI IRQ domain\n");
>> +		return -ENOMEM;
>>  	}
>> -	if (zdev->aibv) {
>> -		airq_iv_release(zdev->aibv);
>> -		zdev->aibv =3D NULL;
>> +
>> +	if (irq_delivery =3D=3D FLOATING)
>> +		zpci_msi_parent_ops.required_flags |=3D MSI_FLAG_NO_AFFINITY;
>
> Add empty line here, so the intent is clear that the following
> assignment is executed unconditionally.

Ok.

>    [ ... snip ... ]
> =20
>> @@ -466,6 +551,7 @@ static int __init zpci_directed_irq_init(void)
>>  		 * is only done on the first vector.
>>  		 */
>>  		zpci_ibv[cpu] =3D airq_iv_create(cache_line_size() * BITS_PER_BYTE,
>> +					       AIRQ_IV_PTR |
>>  					       AIRQ_IV_DATA |
>>  					       AIRQ_IV_CACHELINE |
>>  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>
>
> This looks very good to me already. Unfortunately, I was unable to
> relieve my MSI vs. MSI-X anxiety regarding arch_restore_msi_irqs() with
> a test since the only MSI-using PCI function (ISM) is not supporting
> PCI auto-recovery :(
>
> But a mlx5 VF now recovers just fine!

Did my expanation above help with this?

Thanks
Tobias
