Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B63B71A8;
	Thu, 20 Aug 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787211839; cv=none; b=lpImXw/tULWuJ5BjDtczaHIoAFdJA9GZwjsX+jpn7ieqZO9uCg0VxiDXFxJR362ykWHjVgoTcFmFakTecSfN+i2lefBOxLk+J4o+CFEf1ZSkeWInAmCHkKkThsflplZWH64m7wxm5zcYbVjKxdpR/mMnM2izlju1hVMTdx1kYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787211839; c=relaxed/simple;
	bh=N9L+3Nr+7eM5gkpqfodrEi1p7rKCajzBe8qO3GEISF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u9FbXmpE0MbM0enPGX5lrfUkWS74ooqK8MikZV1ogHwEibQlPjBcZSdRqZVpoutJ2/L5RKdwspteQtMpeXdY5/YpvshsjToFJhmnp5Ny8G9bvaKYosFquWJ3OXyJGvXZA+pkcWJIHpPAwEyB8JijQaKi72D0lQpxWr/QxspxUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bbPTcGeR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bbPTcGeR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLW2u2363307;
	Thu, 20 Aug 2026 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pYkKM5
	DjqXjEHuQ1VpBCmOxwphFoRPtjjni+PPq+cTM=; b=bbPTcGeR6bJDhxRtfoZdZh
	qT2Zg+ptkzHpJUBb1DpMp4G04jhaEbjVEbaKGkh9oGlaf9Vqu/YB0SsSK+IxHvB8
	gSg/OVgXdO9Ng06pcP6wLXkTw1OIK7t7DJIgsvZ1rX/HB5UkvszPR2B8ssAkY1Wl
	pVHns5afm0vzP65PiP8BnKuNLPya4Do28u7D/OKXj0mGxOSRnLdJvnGq3rj2EtDg
	7PqfDgN4ekkGNh+J0ysyhXUucnyEbCS3RYCWu+OC3Y7crWM95LIt0pGUoiI4f/yi
	qWv5NURYQ5T1+knr7fZL9W5nJOodt3+Pix+4crib6QAn3s8wkNgxH1aSJWGNKPwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu48nuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:43:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K7fJu5024149;
	Thu, 20 Aug 2026 07:43:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhd7nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:43:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K7hqiO53543256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 07:43:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D9D92004B;
	Thu, 20 Aug 2026 07:43:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1C0C20040;
	Thu, 20 Aug 2026 07:43:51 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 07:43:51 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 09:43:51 +0200
Message-Id: <DKTLPWZ1MPXE.1DT0YM08L0LQP@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        <linux-s390@vger.kernel.org>,
        "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>
Subject: Re: [PATCH 3/7] s390/pci: fix resource leak in zpci MSI setup
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-3-826ff27b6e97@linux.ibm.com>
 <20260819090550.8B3EF1F00A3A@smtp.kernel.org>
In-Reply-To: <20260819090550.8B3EF1F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1MyBTYWx0ZWRfX7dU8sRYSLFD0
 rFbsAP9xFog0uYvm6xM2/de+dNFYFXGqHS48QG0cI1rNd0ngs5S8+NTxLchi2G9U4nbwc50YyOv
 eFAQCX/7hqTDmYkPTmWQ+XQKWSxo15c=
X-Proofpoint-GUID: eXTAt8xoBKuspKzDF61MoC7csoyZsDzt
X-Proofpoint-ORIG-GUID: eXTAt8xoBKuspKzDF61MoC7csoyZsDzt
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a86b03c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pgdORQlDl8DRY_nvvskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1MyBTYWx0ZWRfX2mrcfFBY6BA6
 N/nk4n4twiOieZt+iE48B+HcDYn7eWEvZsQvBJz38d7Z7n1ELurWtjtNYffRKlgTagA+pyZN8g9
 32KZagBhtOgCJivy88PRlH3QeVtG62bGeF7R15tiKxFGP+nQ+wREezL8kHn+jsh+q0HYcf2TU68
 /WSqX4AFSTHqDvB4u0YqYNbn9bdO/ZrngP7vHLoPaQgjFdaLOyyK05c629svjHNja6mI/Dqs7XM
 bso1YivbGXISaIfoQVOMrnUttc/gTHFsNypNAP9Vkcs04N4YZsI+ChDZWinNrZ9LOfGWWLULhy7
 e6LCWmRfHKXvvb2YWohdwXcWOxp18YSTI5L+VfQ3pcPQNkI4xz9ZDqmjEv0VEr5dJGy2CRqofZ4
 OeEjZ8VUhr68wZZV/1etGaOhbXPKKuwyhIwUVcbxIUwbufOwbIjhYa/IMkrGe9LY9Dye8yejUtM
 JWYCZ9+M4PDjQdtrSOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200053

On Wed Aug 19, 2026 at 11:05 AM CEST, sashiko-bot wrote:

-- snip --

> --- Patch [3]: [PATCH 3/7] s390/pci: fix resource leak in zpci MSI setup =
---
> commit ac232ab92e1500cdc9f0a1a221f03f9be96fffe4
> Author: Tobias Schumacher <ts@linux.ibm.com>
>
> s390/pci: fix resource leak in zpci MSI setup
>
> If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
> by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
> ZPCI_NR_DEVICES summary bits (~128 total), reducing system capacity with
> each failed device hotplug.
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index 94b03d16006ba..5e934ac990ac1 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -320,8 +320,11 @@ static int __alloc_airq(struct zpci_dev *zdev, int =
msi_vecs,
>>  		zdev->aibv =3D airq_iv_create(msi_vecs,
>>  					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
>>  					    NULL);
>> -		if (!zdev->aibv)
>> +		if (!zdev->aibv) {
>> +			airq_iv_free_bit(zpci_sbv, *bit);
>> +			zdev->aisb =3D -1UL;
>>  			return -ENOMEM;
>> +		}
>>
>>  		/* Wire up shortcut pointer */
>>  		zpci_ibv[*bit] =3D zdev->aibv;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this direct assignmen=
t
> need a memory barrier?
>
> This pointer is published to the globally visible zpci_ibv array.
> Concurrently, the asynchronous hardware interrupt handler
> zpci_floating_irq_handler() locklessly reads this array using
> rcu_dereference(zpci_ibv[si]).
>
> Without an rcu_assign_pointer() or equivalent release barrier, could the
> reader observe the aibv pointer before its internal memory regions are
> globally visible, leading to an invalid pointer dereference?

Duplicate finding already answered for Patch 2, yes, will fix this.

> [Severity: High]
> This is a pre-existing issue, but does zpci_msi_teardown_directed() free
> vectors owned by unrelated PCI devices?
>
> When a driver requests fewer IRQs than its maximum capability, __alloc_ai=
rq()
> dynamically allocates exactly msi_vecs bits. However, the teardown blindl=
y
> frees max_msi bits:
>
> arch/s390/pci/pci_irq.c:zpci_msi_teardown_directed() {
>     ...
> 	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
>     ...
> }
>
> Will this cause memory corruption by freeing trailing vectors that might =
have
> been allocated to another device? Should this free zdev->msi_nr_irqs inst=
ead?

This is what Patch 4 addresses.

> [Severity: High]
> This is a pre-existing issue, but does zpci_msi_clear_airq() double-count
> the iteration index and write out of bounds?
>
> In zpci_msi_domain_free(), it iterates over nr_irqs and passes the loop i=
ndex
> i to zpci_msi_clear_airq():
>
> arch/s390/pci/pci_irq.c:zpci_msi_domain_free() {
>     ...
> 	for (i =3D 0; i < nr_irqs; i++) {
> 		d =3D irq_domain_get_irq_data(domain, virq + i);
> 		zpci_msi_clear_airq(d, i);
>     ...
> }
>
> Inside zpci_msi_clear_airq(), the hwirq already reflects the correct inde=
x.
> The bit is calculated, but then i is added again:
>
> arch/s390/pci/pci_irq.c:zpci_msi_clear_airq() {
>     ...
> 	msi_index =3D zpci_decode_hwirq_msi_index(d->hwirq);
> 	bit =3D zdev->msi_first_bit + msi_index;
>     ...
> 		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
>     ...
> }
>
> If nr_irqs is greater than 1, doesn't this skip the intended elements and
> corrupt pointers in unrelated active IRQs while failing to clear the
> target vectors?

Good catch, will fix this.

Tobias

