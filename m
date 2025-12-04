Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECD314D34;
	Thu,  4 Dec 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764824087; cv=none; b=kOMA/cilL+j4QJafq5CX+l6FLHo4i4A3glR/j1wVOgiYie0GSdg3lMMs63gtsc8Hq90O0Jv7lYVGeJWBeBCaRq2q31LlScQZSLldFFO+wSd2FKkk0VFzzmmuKWgEWXimVCLNGzTuJu55TYOvkKE8CJvauqTn60brwMqjkVXVHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764824087; c=relaxed/simple;
	bh=OBdPaFL88N76u/0Cx0X2LWFMv4khdi02pCvzAEQUcGo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RDkOF9OxBo9cv9p0CWR040HwstfYLxuB5xoHp70YpiUaUSWuAmD76OfsHcDJBFulaY9yJlXgGcfJEYArIo65VM7qqz/GWdGeACQWfYsneYUSlzJ5x/ifJGw9oS7lWa3IEHPEF4WPQ1IxzZ199pI7T6GvyXTr0fg5hj78K4fkmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLS5p/AS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLS5p/AS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B448rEC019784;
	Thu, 4 Dec 2025 04:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H1V61B
	Yy6lJHGj9O2bFelkUUNbEP5ctGgj4NKFmCsm8=; b=nLS5p/ASs7C4C11/AvzH5C
	LyJ8jk8I/Do6Q24I5vqVRbbYLefilLIG22PlaVc90B+aGQxVCOq8idRxccX16pd0
	x7OblVmdUsx/PCa768vKnWzaP433S/LGssoIqdhA6mG/kiv/t6Izynx2f3tQOWiv
	8POYv2+sGNujTRAayNVNVfJ/mw0OpQ1npMyTEPo1fNtUZgermMoc1xa09LDJ3q8t
	bb34i7NlhMYUj4fTdaShfPM6U9NpD508gEYWjN5y5hppAvNk/wdO2dFsIG6GXX7r
	KH7JVBTGHF5api5wZx1dpiho3Tur3pMz5+/uuKhWbzY7Hg/NpqgomdOLjh6O86Zw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbgem6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 04:54:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B440xsH019120;
	Thu, 4 Dec 2025 04:54:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhy605c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 04:54:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B44sYAF32178506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 04:54:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7178E20043;
	Thu,  4 Dec 2025 04:54:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF13C20040;
	Thu,  4 Dec 2025 04:54:33 +0000 (GMT)
Received: from localhost (unknown [9.111.167.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 04:54:33 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 05:54:33 +0100
Message-Id: <DEP5X6S6TRTK.1EM2YD3IT92B9@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Farhan
 Ali" <alifm@linux.ibm.com>
Subject: Re: [PATCH v8 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
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
X-Mailer: aerc 0.21.0
References: <20251203-implement-msi-domain-v8-0-94836907490b@linux.ibm.com>
 <20251203-implement-msi-domain-v8-2-94836907490b@linux.ibm.com>
 <0506645063efd6c1472c3b787b5195e96e18048e.camel@linux.ibm.com>
In-Reply-To: <0506645063efd6c1472c3b787b5195e96e18048e.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GKMQuKXZ_7QxSACfKdFa0iuP8hO1y-bV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX+a/InQZXnTEx
 k36IEf5wf6MBO65K9/EE7jHlSJdJ4uu9UNwaYXKROb+aWIA9xnet5NgPqnX4UQ8iZps9y7GeoNH
 /KFLlmZKRkIKcxkNt1MEsEs6QKON5Z1I9WaMfC5W8WW6Vn6JfGujc0NQUaBdfCUiOQqmfqCm7PB
 IOqVXvlrbSYkoNg2bUMrtNuOym0K3v8lfPS+veaUYTqegfAEVf9OvSFkmed/lEPPzGvobwydZNR
 t/acdKaBC79NRRJTCnOMbOKLA3TU58ff5IadEvfkJAvEhsmsgOddHZpYcVv4iRpaGcnarQGH7Gg
 0DfslPnvZx5YmBt6cdpQh1oLpwNYOW9yAA0cn4YHVwyXteuGhk2k7jKy0B6JKR8uL1sH6m0SM0/
 Ocwi+OlwSch7zT9ApYnfEtJbCkNsVQ==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=69311410 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=wwkEXVi88CX8OGLk8O8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GKMQuKXZ_7QxSACfKdFa0iuP8hO1y-bV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

On Wed Dec 3, 2025 at 5:14 PM CET, Gerd Bayer wrote:
> On Wed, 2025-12-03 at 15:36 +0100, Tobias Schumacher wrote:
>> s390 is one of the last architectures using the legacy API for setup and
>> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
>> to the MSI parent domain API. For details, see:
>>=20
>> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>>=20
>
>   [ ... snip ... ]
>
>> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned in=
t virq,
>> +				 unsigned int nr_irqs)
>> +{
>> +	struct zpci_dev *zdev;
>> +	struct msi_desc *desc;
>> +	struct irq_data *d;
>> +	unsigned long bit;
>> +	unsigned int cpu;
>> +	u16 msi_index;
>> +	int i;
>> +
>> +	for (i =3D 0; i < nr_irqs; i++) {
>> +		d =3D irq_domain_get_irq_data(domain, virq + i);
>> +		msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
>> +		desc =3D irq_data_get_msi_desc(d);
>> +		zdev =3D to_zpci_dev(desc->dev);
>> +		bit =3D zdev->msi_first_bit + msi_index;
>> =20
>> +		if (irq_delivery =3D=3D DIRECTED) {
>>  			for_each_possible_cpu(cpu) {
>> -				for (i =3D 0; i < irqs_per_msi; i++)
>> -					airq_iv_set_data(zpci_ibv[cpu],
>> -							 hwirq + i, irq + i);
>> +				airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
>> +				airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>>  			}
>>  		} else {
>> -			msg.address_lo =3D zdev->msi_addr & 0xffffffff;
>> -			for (i =3D 0; i < irqs_per_msi; i++)
>> -				airq_iv_set_data(zdev->aibv, hwirq + i, irq + i);
>> +			airq_iv_set_ptr(zdev->aibv, bit + i, 0);
>> +			airq_iv_set_data(zdev->aibv, bit + i, 0);
>>  		}
>> -		msg.address_hi =3D zdev->msi_addr >> 32;
>> -		pci_write_msi_msg(irq, &msg);
>> -		hwirq +=3D irqs_per_msi;
>> +
>> +		irq_domain_reset_irq_data(d);
>>  	}
>> +}=20
>
> Thanks for addressing my concern about clearing the airq data!
>
> FWIW, what you thing about abstracting out the airq clearing stuff with
> something like this diff on top, so the loop body remains somewhat
> short and zpci_msi_domain_free() keeps its working set of local
> variables.

Sounds good, will do.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 5639789dc58f..3322d8c9aff1 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -439,34 +439,37 @@ static int zpci_msi_domain_alloc(struct
> irq_domain *domain, unsigned int virq,
>         return 0;
>  }
> =20
> -static void zpci_msi_domain_free(struct irq_domain *domain, unsigned
> int virq,
> -                                unsigned int nr_irqs)
> +static void zpci_msi_clear_airq(struct irq_data *d, int i)
>  {
> -       struct zpci_dev *zdev;
> -       struct msi_desc *desc;
> -       struct irq_data *d;
> +       struct msi_desc *desc =3D irq_data_get_msi_desc(d);
> +       struct zpci_dev *zdev =3D to_zpci_dev(desc->dev);
>         unsigned long bit;
>         unsigned int cpu;
>         u16 msi_index;
> -       int i;
> =20
> -       for (i =3D 0; i < nr_irqs; i++) {
> -               d =3D irq_domain_get_irq_data(domain, virq + i);
> -               msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
> -               desc =3D irq_data_get_msi_desc(d);
> -               zdev =3D to_zpci_dev(desc->dev);
> -               bit =3D zdev->msi_first_bit + msi_index;
> +       msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
> +       bit =3D zdev->msi_first_bit + msi_index;
> =20
> -               if (irq_delivery =3D=3D DIRECTED) {
> -                       for_each_possible_cpu(cpu) {
> -                               airq_iv_set_ptr(zpci_ibv[cpu], bit + i,
> 0);
> -                               airq_iv_set_data(zpci_ibv[cpu], bit +
> i, 0);
> -                       }
> -               } else {
> -                       airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> -                       airq_iv_set_data(zdev->aibv, bit + i, 0);
> +       if (irq_delivery =3D=3D DIRECTED) {
> +               for_each_possible_cpu(cpu) {
> +                       airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
> +                       airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>                 }
> +       } else {
> +               airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> +               airq_iv_set_data(zdev->aibv, bit + i, 0);
> +       }
> +}
> =20
> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned
> int virq,
> +                                unsigned int nr_irqs)
> +{
> +       struct irq_data *d;
> +       int i;
> +
> +       for (i =3D 0; i < nr_irqs; i++) {
> +               d =3D irq_domain_get_irq_data(domain, virq + i);
> +               zpci_msi_clear_airq(d, i);
>                 irq_domain_reset_irq_data(d);
>         }
>  }
>
> Sorry for me keeping nagging...

No worries :-)

Thanks
Tobias
