Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEA37C11E;
	Tue,  9 Jun 2026 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034833; cv=none; b=Q3fzMjblL3fGmfYfh1pqWW5XrVnZcuOTWi46hdDbXtAZRdk+N40FtbDU1anMVgpmQkKW/ssFjS9qkZ//F/MB33aJClOJG4nEjNzmknEH8bTmeBI05RYUfhQL7tZm1kC68mbf1rVWRAmnQ5U8dwuEx85n2puBTjxEkDicY0TMedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034833; c=relaxed/simple;
	bh=+kTbz2Uw85wz5BrjFBMS8NVDI6izvfM0QweDZwLgOPs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=O15WQIhDXMjSEgI5e8CKKUNpX0oUC8spXT/Q/ho+ik7tx3UsDJRh4gvXZjviwvJKHaDJqs4j/PRdN0wZhkLMfFDRxhfDYTzM83Yyx1D6MGgJErPEZy6B+fqKaAOtWTO7jgjGp9/ZjBDsDIIRDigLZrBLZa1QmDiy/UdfxA4w51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jwV2DdQ4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jwV2DdQ4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659DDQ8j2576971;
	Tue, 9 Jun 2026 19:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cBS7l2
	GAIYLN2ZFz2m7xbAQhC6bb5hYcnSlpyJQWHJk=; b=jwV2DdQ4bNj6ffBcHb6Bru
	ctS50XzyuETNGePFDsN9jIhuY21BnWDonAzjGNzoRTiokcX13QLA242Z4RRg/iE3
	fkqK7H4Q76+TOWmUveESMYaTa50SG9hrySYLX9rPBEq4ZfSRaOMIMJRe45oLKEzF
	6EQAMB53+SmzR/HszXGbKm1PRdFrK3hwbTQCpYGyE/Tlwkp/c/G3+66uSCM8COGO
	ptpzBMigcKLNAlvkOxmxGKM9kzvAksZtbJFePqkLcBu7jidw2WfGhblSqjwICheI
	PZi9rKidbaY7pQB/ixhvJTNdsmixAcGQB2/7RTIgy+FHiMjbUeIB72IxZguFheXA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23x3jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 19:53:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659JneTb004969;
	Tue, 9 Jun 2026 19:53:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jybc5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 19:53:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659Jrj2F28639812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 19:53:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81BF858056;
	Tue,  9 Jun 2026 19:53:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2405E5805D;
	Tue,  9 Jun 2026 19:53:43 +0000 (GMT)
Received: from [9.111.45.90] (unknown [9.111.45.90])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 19:53:42 +0000 (GMT)
Message-ID: <8a0fb2e392f4ca26d08f6dcd7c0e1f9236a62a06.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        alex@shazbot.org, stable@vger.kernel.org
In-Reply-To: <20260608171850.62829-2-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
	 <20260608171850.62829-2-oelghoul@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 21:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a286f4c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=0rbsSUeNS0Mnah478iYA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: vAPTwIjX7PuGTo6SYFinDbVuAKep3Knw
X-Proofpoint-GUID: vAPTwIjX7PuGTo6SYFinDbVuAKep3Knw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE4NCBTYWx0ZWRfX2eSvSU5kEMtq
 bYu+RgfRG7e3VG1ePfMqPgPIUg1l0Deea0sjdziFKC0vVyoUBbEqfdoJsxxpT/zxNL6tDO03/6l
 /S2N6AmyWFr8RsVpFyKZuCcQd752acfROJdqRwcn8FeOSxgbofwe9mtlGvBPnEXcaj5zC1/A6jv
 YduuiID5a2FrIceB8QiXFcPYWumk6u3Xe9CprKFJnVZMhJ6AInyFmF7N/njKb2bjq8qdU7LVERw
 rfl1UF/W6HeNMl2+GGlmFNsPW//G4ujX/oZKaLq2s6otpjge0Wb1i9HGsfQvQgyOJHVjHQw2T+0
 HDwUcQ9EZKg5I8gjAQldjkoELISrDJr1nZqPkFki0j/CfCctW/jVfKDtvEkawJetrnHG9DSCAeb
 d2MklZMXENNU69QtyFGwDpQYnzhOWpdwg2iIfRom4vVospGqwAntgDi8f3Zoq5WIoI37ImeY1h0
 hlcbJxRl52NPec43iQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090184

On Mon, 2026-06-08 at 13:18 -0400, Omar Elghoul wrote:
> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
>=20
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 39bd2adfc240..2910d4038d39 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
>=20
--- snip ---
> @@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_enable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);
>  }
> @@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_disable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }
> =20

There are two Sashiko findings[0] which look real to me, but they are
pre-existing issues and should really be handled in separate patches.
The issues do look unlikely to be hit randomly and hard to provoke,
still we will have to look into them further.

For what it does this patch reads correct to me and stands on its own.
I also did a bit of testing with lockdep enabled.

So, feel free to add my:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

[0]
https://sashiko.dev/#/patchset/20260608171850.62829-1-oelghoul%40linux.ibm.=
com
