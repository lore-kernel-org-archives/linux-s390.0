Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4649DB8A;
	Tue,  6 Oct 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300887; cv=none; b=OrDS4lDG0dl3MfvSdBW/77kun2Afkt8hl3t4CJhfhZUR/KG1usjmgc1WGIU6ygCSGMbFh7jMJoNgji4y8eQmkpgloRLAUztXFNd+vpmMVTNJoSFYs+oTSOmn4brR7ckvxgTrkOVKu0QBG6JsCPDaRKQefAR6KLhxNpFp7XHcFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300887; c=relaxed/simple;
	bh=ejME8MHyivvJkAXcja+B2HPeKR+IyYCKM6MFEN62k6U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PcVSC7kBLqZHyk68Eiq2u3Hp72oFHfhCzidPpGlpwx931qazn7fgQwvXKHuoMK/ORJH2jdNtYll0BGdyI6BHitCMm/K+37PGn7LY2ROJpPeKpvIc+EyLSBZ/i+e/STQK65DPehCuAD78GA7bQj60OInfD3SlK52Rd2K0HO04GHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZbCyzlT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZbCyzlT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZMkb4058911;
	Tue, 6 Oct 2026 15:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fNPnLX
	W8NS6VI/asA3dIfPHg9fKSryh55Tp2p2ewemI=; b=fZbCyzlTsKO57jyYKRp9iB
	+Zf/46+0ZgaLMUafisJa1sEtzjO2ZikAsdIRuAV77X/eAGvfabks3E8NV9ogS8/w
	xSgHocduQgeKH7OKN22B0rI+jmaHVOwbEDZO0xvtN4QihiStpVAzwEyPv+F9cqja
	l7UBVVfBQOpEBKK+Ff8BNRG7B1JyYNmvpYH75InZ7GLZgvOGd5CWEHfrhLhkkju3
	XstrzgoSCN+nSHWooiB4a9bU4yo8vhGl4KJwmEEdYBr2N+jqHHeTrYLpRKbZ3TvI
	lPH9L58gGC3ZGix5oIv8zUIqHQWwGMXegWRY4G0gb05njcWr8qL3JqTqhr0CnVwQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74rw76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:34:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHafM453074;
	Tue, 6 Oct 2026 15:34:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgteww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:34:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696FYhit18350666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:34:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F1058065;
	Tue,  6 Oct 2026 15:34:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 502B858059;
	Tue,  6 Oct 2026 15:34:40 +0000 (GMT)
Received: from [9.87.140.229] (unknown [9.87.140.229])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:34:40 +0000 (GMT)
Message-ID: <7cf012ca23e9ac9fb648adc9467edc54f1e3f6cd.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/7] s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init
 time
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Gerd Bayer
 <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Christian Borntraeger	 <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato	 <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-6-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
	 <20261005-s390_irq_domain_fixes-v2-6-d45b824874c0@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KkT2UacLUQTjQY39xFlj_XMPZ5cbpilj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfXyD5ADyc6utws
 nxWf7jf/1nb8bb1R1ZWeMSb04512L7MgUQcTL4n5t+2UfJne/OOBdmXApUKfKITtstN7tyA40W9
 EQLBo2oIXLtNZdmPzqAaUUbeexUjKnI=
X-Proofpoint-GUID: KkT2UacLUQTjQY39xFlj_XMPZ5cbpilj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfX4xVwD3Ia8Ceh
 AJCu0EnkXgGi+sM6yXBQ6FF+xP1ASRC7C1/ybx4AnJ4Hsz7QSNUhWhEYtm/A/pgipiNB0d9d0VI
 dpv50zUOj4NjB7MzNhCXBJpmbWRGideUB61Wpi7RecUh2yM9fL66/rKqUhGpXiUvSl4Lm6fAFlu
 d+CQODhDpYd+ZsksmU7HUTSyc1v8SAGTJlPo12NEHgvu/nOGD4HGYOZWBeXESJyxZbtEwp/zqx4
 A5uGoZ97fSNi6bJ23I9/3K08zBj7RVP9erevzjT09nBjrkZ/aLaECkPWZm19n7RbFBJ0fUPTYcZ
 MKqfahKPNbXu+0YDmtjtpShJw8Vgvv+UtLuEmCVkoqJY8PvtYlhSjpnC5iGFtCBmf24zusg1k+4
 ojoT9HFzkXpMMOhirbWn3Kar09S4iXT2IUMIHRxiiMAzRQZaAbzQ6aVK9reFfp4lCy2PaCM1aUu
 TacoXN4rW/wjRJAiTjw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac51515 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=GWHo-SLf9ZsVjsKrVycA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060060

On Mon, 2026-10-05 at 14:03 +0200, Tobias Schumacher wrote:
> MSI_FLAG_NO_AFFINITY is added to zpci_msi_parent_ops.required_flags from
> zpci_create_parent_msi_domain(), which runs for every new PCI bus,
> including buses created at runtime from a hotplug availability event.
>=20
> That is a non-atomic read-modify-write on a field which
> msi_lib_init_dev_msi_info() reads without a common lock while setting up
> MSI for a device on an already existing bus:
>=20
>       required_flags =3D pops->required_flags;
>=20
> The stored value is always the same, so no caller observes a change, but
> the race need not exist: irq_delivery is decided once in zpci_irq_init()
> and never changes afterwards.
>=20
> Set the flag there instead, before any parent domain exists.
>=20
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 682bceb6525e..661867a1ffad 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -523,9 +523,6 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zb=
us)
>  		return -ENOMEM;
>  	}
> =20
> -	if (irq_delivery =3D=3D FLOATING)
> -		zpci_msi_parent_ops.required_flags |=3D MSI_FLAG_NO_AFFINITY;
> -
>  	zbus->msi_parent_domain =3D msi_create_parent_irq_domain(&info, &zpci_m=
si_parent_ops);
>  	if (!zbus->msi_parent_domain) {
>  		irq_domain_free_fwnode(info.fwnode);
> @@ -636,6 +633,9 @@ int __init zpci_irq_init(void)
>  	if (s390_pci_force_floating)
>  		irq_delivery =3D FLOATING;
> =20
> +	if (irq_delivery =3D=3D FLOATING)
> +		zpci_msi_parent_ops.required_flags |=3D MSI_FLAG_NO_AFFINITY;
> +
>  	if (irq_delivery =3D=3D DIRECTED)
>  		zpci_airq.handler =3D zpci_directed_irq_handler;
> =20

Looks good to me and I agree the race is benign as everyone races to
write the same value but this is certainly cleaner. Thanks.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
