Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66124718F1;
	Fri,  9 Oct 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529855; cv=none; b=npNtZH4esAL4t4LATi6d/9b3nj6de8woY4JZi+Pc9pCr1JQ4d7wcAFI7whworV2riA618DpTZpdhOzmNDVdrxBNUHVxlG+ac83eNft5BPPH8TuJbkig+UMvcI7PXnEy4P6e9J9VaOQ1i7MiyZ9bYQzVkq+NGZYpt81KE8igzenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529855; c=relaxed/simple;
	bh=gCry4cK3rUZDrsplRfukjZPAimHWsyChbpmyVJqyfMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jIhTq/Z4i0t0IqqoxiTxjDWuKt1gZBh9MNfaQQmCBfRYhqSHt0EX2QVt80IJeJsE9GCbNT+YjmA+hX96TdkBIGrYSSIcrHWDiDHO/8T1N6BNk8VIf3Ab5vDH8VSbmsSAWkuieu2lxc/hl8VmMUNhMR0Fz1qZKlmlw/nb4xLCQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ekh5V0Gu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ekh5V0Gu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZbmW3209246;
	Fri, 9 Oct 2026 07:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8aBIZD
	a+kJR/ZX//689ssl30RGMF9ZLB0YC8xlJA0/Q=; b=ekh5V0GuufY/K7AoYixY/g
	F5Eu1hMyB+PKO4yzKPNfyM6kp1Xk1rWlshUox3U6y72AJ6hREfxnOJBycVJcLo1r
	/BsgbkTv5//sestwhMPKKuk13SnILH1RmhzioYqRxWKuywHWW2loKseJoBeTHaGf
	GWUD1gxq8mnDClG1ditdnG2xxCIPQy5QxOMmqmj8PPRSOcaqTCnviI7iLF0XHJ/K
	L/sXaErUr2JUKCzqZ5szMVy3T8QTzyLNVqmrHljG+BmuET1EPUnpYdnGlGYtWDLd
	R1ToHhP7Ohmqb0qbfHTSjAdyD9Dbwa84M5cT8wDwSQV/JAS6AsSDaLWydxPSuwcA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvrd14-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 07:10:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HiFc290583;
	Fri, 9 Oct 2026 07:10:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dtta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 07:10:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6997Amo536897062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 07:10:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B7C2004B;
	Fri,  9 Oct 2026 07:10:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E1732004D;
	Fri,  9 Oct 2026 07:10:47 +0000 (GMT)
Received: from localhost (unknown [9.111.170.212])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 07:10:47 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 09:10:47 +0200
Message-Id: <DM04BTXODU3S.39KDFFEEM0BNP@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Heiko Carstens"
 <hca@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 8/8] s390/pci: Unregister the adapter interrupt first
 in zpci_irq_exit()
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc HEAD-0d169b7
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-8-ced19028da3c@linux.ibm.com>
 <sashiko-outbox-164943@kernel.org>
In-Reply-To: <sashiko-outbox-164943@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4vBC3a0z-kFPYn2P6mc-HUmGhukpcHY3
X-Proofpoint-ORIG-GUID: 4vBC3a0z-kFPYn2P6mc-HUmGhukpcHY3
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8937c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=TzoSXx77MbkTK0BF7iQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyOCBTYWx0ZWRfXx+D5+TWwZoEx
 mLkg3cjk8nj+93OpdLNs4klIC97OUTX+27Gq5WtbiR/dw9cTyrLCK5jq64ah1I9/9hGUGNbfcQE
 ZRXaF4KQ+a9SehKcoERvw4yf2sk2YVQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyOCBTYWx0ZWRfXyVCg7qVwtbUX
 WGj4k6z4Vh1IuCHNOR+jizaVA2/pIiHn3MlT8VxGfqnsVUgKCqdRWNkhQGpzBMIoQ5VIdkw7W25
 PRbDB6l+vp0QgeUWT3bkft2WtbrMCuUsyqChqGsX12KzqdU3p1H3SwvYPApwFfd31xDqwfi8ZJ2
 K+PpueTGMil9BClH40Aj6yBUuHGoFyegnkSBhmXC5i8OklTU8HpN3HNE1+NfTaV3n3rybcLOybp
 uQkih+53aSo1fRTHvbxAd6X/GrrTbbHG0j2fwvarhT+yBdGHM33P7YVazcT0c48H4e6NQgQNLkO
 E4Ep/kHhn4xhmnsxZMmitf2OIR79dXoDBrESdCCCdjP97f27IufcCmhcyy2P7Y1mSruFctsi3Ce
 dQ8IjGcrfcrmndgUkluWQjIluIEdMJ8nXTJKedP4z0pcM9YePlh+3YWVqVnlPmjcnFYOufYqy7B
 k+GPChJHKoOb73W5YCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090028

On Fri Oct 9, 2026 at 8:29 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] s390/pci: UAF memory corruption in MSI setup due to missing devi=
ce teardown
> --
>
> commit 4f6e192e648a7af5752afbd15f3be9f0172b9594
> Author: Tobias Schumacher <ts@linux.ibm.com>
>
> s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()
>
> This commit modifies zpci_irq_exit() to unregister the adapter interrupt =
before
> freeing the interrupt bit vectors. This aims to prevent vectors from bein=
g
> freed under a live handler during the pci_base_init() error path.
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index 4b8ebb987580b..16ae80ed2d139 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -674,6 +674,7 @@ void __init zpci_irq_exit(void)
>>  {
>>  	unsigned int cpu;
>>
>> +	unregister_adapter_interrupt(&zpci_airq);
>>  	if (irq_delivery =3D=3D DIRECTED) {
>>  		for_each_possible_cpu(cpu) {
>>  			airq_iv_release(zpci_dibv[cpu]);
>> @@ -684,5 +685,4 @@ void __init zpci_irq_exit(void)
>>  	}
>>  	if (zpci_sbv)
>>  		airq_iv_release(zpci_sbv);
>
> [Severity: High]
> Does this change fully resolve the use-after-free risk in the pci_base_in=
it()
> error path?
>
> While moving unregister_adapter_interrupt() prevents the interrupt handle=
r
> from accessing the vectors while they are being freed, it appears the dev=
ices
> registered earlier by zpci_scan_devices() are never unregistered when
> pci_base_init() fails during zpci_fw_sysfs_init().
>
> If a driver later binds to one of these still-registered devices and call=
s
> pci_alloc_irq_vectors(), the PCI MSI setup accesses the freed zpci_sbv
> and zpci_ibv structures:
>
> arch/s390/pci/pci_irq.c:__alloc_airq() {
>     ...
>     /* Allocate adapter summary indicator bit */
>     *bit =3D airq_iv_alloc_bit(zpci_sbv);
>     ...
>     /* Wire up shortcut pointer */
>     rcu_assign_pointer(zpci_ibv[*bit], zdev->aibv);
>     ...
> }
>
> Could this lead to memory corruption when a driver attempts to set up MSI=
 on
> a device that was not properly torn down?

Right, this issue exists but is not addressed by this patch. This series
fixes and cleans the s390 PCI IRQ code, so I'll fix that in a separate patc=
h
outside this series.

Thanks
Tobias
