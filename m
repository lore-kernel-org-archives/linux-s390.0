Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC520C46A;
	Thu,  6 Mar 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275692; cv=none; b=UiIpnwsfWMF2+ixbKc/TuPzyqwdL/dLUH81CKdpzY9eT2tP0d11JGt1+BIgKUQCzTjUHYnI5GJKYA1ZHS/iLvBhVhPa/eATPvJgcN1weH58clshAsc0xMmtkLX+0qX5/UTM+01u8UqG7tAuW8g7qPaAnhugayx5i5QtWB//8zAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275692; c=relaxed/simple;
	bh=8fbMY8SwQspH1wER8XtpaGcYm/GrDfVnX0T1zU1RT7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0vYj/6d4i094js55p4TAT2jPgN9Z+LySPw+wS4fv0cjw9yGnC6t5N0sf/y0N2uRxF2Wggcd7vkRjPyrc9hmJUU4+4RuwpoJJMMkhRFVARNGotX935YVN5tM4W6C+7bbKiscFkmvINnaKZEO6Z9hndKOS4Ax55suT4+MUu/I/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d7NxU0nU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d7NxU0nU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526CS9Bq006414;
	Thu, 6 Mar 2025 15:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xLEcEg
	GLRQEklmroADsacfKh8IuCslLlpSN3By6o+h8=; b=d7NxU0nUZ1iL0GRNFFeAdV
	b6+AyXJrrsis5IO1/Lvn5/e5g92Um9yYNWCgX8yKHh2TlP4AtD+ahgXWnszZyC8X
	eDW4caXJKdL9076vYSfbxWPcqM5TCkpcAWYbWPBbFMoEeqK7QvVq7WOx0ffuvIfj
	wqBUTIEY6tEHqeSgVPYNdyikWDZBji/DoH93GsQulmYMi8MGU9a7TwanpddKljH+
	QJVMfvrt9ToKOEbFefKJjPp/dBWAJTKHrLofzb1aslhXkExI21sswfcZvDeypn2o
	Ashuj1cTPQzHQxfoGzN6uV6S8beQPa29xFghTWDOIwnKDzZGFNb6xsQHu7m4lvzQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457br2s1pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 15:41:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526EpFkv032236;
	Thu, 6 Mar 2025 15:41:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjt9qk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 15:41:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526FfH2L22217448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 15:41:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402D658065;
	Thu,  6 Mar 2025 15:41:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599145804B;
	Thu,  6 Mar 2025 15:41:14 +0000 (GMT)
Received: from [9.171.48.29] (unknown [9.171.48.29])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 15:41:14 +0000 (GMT)
Message-ID: <dabc5fd13900935287a3b187d0d2cac2f2920dd4.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/pci: Fix dev.dma_range_map missing sentinel element
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Jason
 Gunthorpe <jgg@ziepe.ca>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens	
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev	
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Thu, 06 Mar 2025 16:41:13 +0100
In-Reply-To: <20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com>
References: <20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmesutgFCQenEYkACgkQr+Q/FejCYJDIzA//W5h3t+anRaztihE8ID1c6ifS7lNUtXr0wEKx
 Qm6EpDQKqFNP+n3R4A5w4gFqKv2JpYQ6UJAAlaXIRTeT/9XdqxQlHlA20QWI7yrJmoYaF74ZI9s/C
 8aAxEzQZ64NjHrmrZ/N9q8JCTlyhk5ZEV1Py12I2UH7moLFgBFZsPlPWAjK2NO/ns5UJREAJ04pR9
 XQFSBm55gsqkPp028cdoFUD+IajGtW7jMIsx/AZfYMZAd30LfmSIpaPAi9EzgxWz5habO1ZM2++9e
 W6tSJ7KHO0ZkWkwLKicrqpPvA928eNPxYtjkLB2XipdVltw5ydH9SLq0Oftsc4+wDR8TqhmaUi8qD
 Fa2I/0NGwIF8hjwSZXtgJQqOTdQA5/6voIPheQIi0NBfUr0MwboUIVZp7Nm3w0QF9SSyTISrYJH6X
 qLp17NwnGQ9KJSlDYCMCBJ+JGVmlcMqzosnLli6JszAcRmZ1+sd/f/k47Fxy1i6o14z9Aexhq/UgI
 5InZ4NUYhf5pWflV41KNupkS281NhBEpChoukw25iZk0AsrukpJ74x69MJQQO+/7PpMXFkt0Pexds
 XQrtsXYxLDQk8mgjlgsvWl0xlk7k7rddN1+O/alcv0yBOdvlruirtnxDhbjBqYNl8PCbfVwJZnyQ4
 SAX2S9XiGeNtWfZ5s2qGReyAcd2nBna0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmesuuEFCQenEYkACgkQr+Q/FejCYJCosA/9GCtbN8lLQkW71n/CHR58BAA5ct1
 KRYiZNPnNNAiAzjvSb0ezuRVt9H0bk/tnj6pPj0zdyU2bUj9Ok3lgocWhsF2WieWbG4dox5/L1K28
 qRf3p+vdPfu7fKkA1yLE5GXffYG3OJnqR7OZmxTnoutj81u/tXO95JBuCSJn5oc5xMQvUUFzLQSbh
 prIWxcnzQa8AHJ+7nAbSiIft/+64EyEhFqncksmzI5jiJ5edABiriV7bcNkK2d8KviUPWKQzVlQ3p
 LjRJcJJHUAFzsZlrsgsXyZLztAM7HpIA44yo+AVVmcOlmgPMUy+A9n+0GTAf9W3y36JYjTS+ZcfHU
 KP+y1TRGRzPrFgDKWXtsl1N7sR4tRXrEuNhbsCJJMvcFgHsfni/f4pilabXO1c5Pf8fiXndCz04V8
 ngKuz0aG4EdLQGwZ2MFnZdyf3QbG3vjvx7XDlrdzH0wUgExhd2fHQ2EegnNS4gNHjq82uLPU0hfcr
 obuI1D74nV0BPDtr7PKd2ryb3JgjUHKRKwok6IvlF2ZHMMXDxYoEvWlDpM1Y7g81NcKoY0BQ3ClXi
 a7vCaqAAuyD0zeFVGcWkfvxYKGqpj8qaI/mA8G5iRMTWUUUROy7rKJp/y2ioINrCul4NUJUujfx4k
 7wFU11/YNAzRhQG4MwoO5e+VY66XnAd+XPyBIlvy0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCZ6y64QUJB6cRiQAKCRCv5D8V6MJgkEr/D/9iaYSYYwlmTJELv+
 +EjsIxXtneKYpjXEgNnPwpKEXNIpuU/9dcVDcJ10MfvWBPi3sFbIzO9ETIRyZSgrjQxCGSIhlbom4
 D8jVzTA698tl9id0FJKAi6T0AnBF7CxyqofPUzAEMSj9ynEJI/Qu8pHWkVp97FdJcbsho6HNMthBl
 +Qgj9l7/Gm1UW3ZPvGYgU75uB/mkaYtEv0vYrSZ+7fC2Sr/O5SM2SrNk+uInnkMBahVzCHcoAI+6O
 Enbag+hHIeFbqVuUJquziiB/J4Z2yT/3Ps/xrWAvDvDgdAEr7Kn697LLMRWBhGbdsxdHZ4ReAhc8M
 8DOcSWX7UwjzUYq7pFFil1KPhIkHctpHj2Wvdnt+u1F9fN4e3C6lckUGfTVd7faZ2uDoCCkJAgpWR
 10V1Q1Cgl09VVaoi6LcGFPnLZfmPrGYiDhM4gyDDQJvTmkB+eMEH8u8V1X30nCFP2dVvOpevmV5Uk
 onTsTwIuiAkoTNW4+lRCFfJskuTOQqz1F8xVae8KaLrUt2524anQ9x0fauJkl3XdsVcNt2wYTAQ/V
 nKUNgSuQozzfXLf+cOEbV+FBso/1qtXNdmAuHe76ptwjEfBhfg8L+9gMUthoCR94V0y2+GEzR5nlD
 5kfu8ivV/gZvij+Xq3KijIxnOF6pd0QzliKadaFNgGw4FoUeZo0rQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmesuuEFCQenEYkACgkQr+Q/FejCYJC6yxAAiQQ5NAbWYKpkxxjP/
 AajXheMUW8EtK7EMJEKxyemj40laEs0wz9owu8ZDfQl4SPqjjtcRzUW6vE6JvfEiyCLd8gUFXIDMS
 l2hzuNot3sEMlER9kyVIvemtV9r8Sw1NHvvCjxOMReBmrtg9ooeboFL6rUqbXHW+yb4GK+1z7dy+Q
 9DMlkOmwHFDzqvsP7eGJN0xD8MGJmf0L5LkR9LBc+jR78L+2ZpKA6P4jL53rL8zO2mtNQkoUO+4J6
 0YTknHtZrqX3SitKEmXE2Is0Efz8JaDRW41M43cE9b+VJnNXYCKFzjiqt/rnqrhLIYuoWCNzSJ49W
 vt4hxfqh/v2OUcQCIzuzcvHvASmt049ZyGmLvEz/+7vF/Y2080nOuzE2lcxXF1Qr0gAuI+wGoN4gG
 lSQz9pBrxISX9jQyt3ztXHmH7EHr1B5oPus3l/zkc2Ajf5bQ0SE7XMlo7Pl0Xa1mi6BX6I98CuvPK
 SA1sQPmo+1dQYCWmdQ+OIovHP9Nx8NP1RB2eELP5MoEW9eBXoiVQTsS6g6OD3rH7xIRxRmuu42Z5e
 0EtzF51BjzRPWrKSq/mXIbl5nVW/wD+nJ7U7elW9BoJQVky03G0DhEF6fMJs08DGG3XoKw/CpGtMe
 2V1z/FRotP5Fkf5VD3IQGtkxSnO/awtxjlhytigylgrZ4wDpSE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NEmAqTUpu9S7uvVo6JYiQ6I1xxd_IkSo
X-Proofpoint-ORIG-GUID: NEmAqTUpu9S7uvVo6JYiQ6I1xxd_IkSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060118

On Thu, 2025-03-06 at 16:25 +0100, Niklas Schnelle wrote:
> The fixed commit sets up dev.dma_range_map but missed that this is
> supposed to be an array of struct bus_dma_region with a sentinel element
> with the size field set to 0 at the end. This would lead to overruns in
> e.g. dma_range_map_min(). It could also result in wrong translations
> instead of DMA_MAPPIN_ERROR in translate_phys_to_dma() if the paddr were
> to not fit in the aperture. Fix this by using the dma_direct_set_offset()
> helper which creates a sentinel for us.
>=20
> Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> This is based on iommu/next which contains the fixed commit
> ---
>  arch/s390/pci/pci_bus.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 0e725039861f92925a38f7ff7cb6de6b0d965ac3..14310c3b48860a16de13536ad=
f95ef99e6af21cc 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -287,23 +287,21 @@ static struct zpci_bus *zpci_bus_alloc(int topo, bo=
ol topo_is_tid)
>  static void pci_dma_range_setup(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> -	struct bus_dma_region *map;
> -	u64 aligned_end;
> +	u64 aligned_end, size;
> +	dma_addr_t dma_start;
> +	int ret;
> =20
> -	map =3D kzalloc(sizeof(*map), GFP_KERNEL);
> -	if (!map)
> -		return;
> -
> -	map->cpu_start =3D 0;
> -	map->dma_start =3D PAGE_ALIGN(zdev->start_dma);
> +	dma_start =3D PAGE_ALIGN(zdev->start_dma);
>  	aligned_end =3D PAGE_ALIGN_DOWN(zdev->end_dma + 1);
> -	if (aligned_end >=3D map->dma_start)
> -		map->size =3D aligned_end - map->dma_start;
> +	if (aligned_end >=3D dma_start)
> +		size =3D aligned_end - dma_start;
>  	else
> -		map->size =3D 0;
> -	WARN_ON_ONCE(map->size =3D=3D 0);
> +		size =3D 0;
> +	WARN_ON_ONCE(size =3D=3D 0);
> =20
> -	pdev->dev.dma_range_map =3D map;
> +	ret =3D dma_direct_set_offset(&pdev->dev, 0, dma_start, size);
> +	if (ret)
> +		pr_err("Failed to allocate DMA range map for %s\n", pci_name(pdev));

Arguably one might want to use dev_err() here but the rest of the file
uses pr_err(). On the other hand dma_direct_set_offset() uses dev_err()
in case there is already a dev.dma_range_map.

Also maybe s/allocate/set up/ since we're not checking just for -ENOMEM

>  }
> =20
>  void pcibios_bus_add_device(struct pci_dev *pdev)
>=20
> ---
> base-commit: e840414e5a73ac02ffba6299b46f535a0b7cba98
> change-id: 20250306-fix_dma_map_alloc-b3b05903dcfb
>=20
> Best regards,

