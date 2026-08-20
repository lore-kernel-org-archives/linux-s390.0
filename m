Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC453DCDBB;
	Thu, 20 Aug 2026 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216519; cv=none; b=N713tEcCF+HWB7PStN3D4b9bAon3SM80bqTcFT+5JLImp1hXxBUgrVca6DwzpNOsh8+P3AIgeZT6q6zZ1kPNJVB1/qxQHsp5+P6NEElTe5AZblCu5QHp+5iTsFiVqjhkvsJZcEvfeUA6SBgrmtmKXARb3rlr6idd+xYxhNCZhuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216519; c=relaxed/simple;
	bh=FfRqY2ZNqOgj064lCVfkk9FH9ychIdj8XGVtDEWl5Zo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BaRkniL97CMwDpFuEGVZIAIfh8CkgdTjUpxhxz1UIHm1OT7LirUQ8evKds1ywEZapN/W+YP0LKFohOlFUh4ss7hBZJ51URxajlUi+aeJxu8o7sPMZgFTsotAM7RD20yDysYBug/iNctSzMU8aoWdS6mCOgC+bhn9laT/vU7j7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nmRX3sOJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nmRX3sOJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8uawB3545134;
	Thu, 20 Aug 2026 09:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GuAL4q
	7CQt24jE8dTeyPnHvuOlNkqbSr29hmTTZ0LYw=; b=nmRX3sOJ7GEodEaw1He4Zu
	aSs2BwOupjFV5f92/mGtANYUKvPF0YZaffI1tzousvdMC6q5dJK6eP2fDSYiOX6n
	xncoboLodlL4jxZOON/Ikt5sUkPpCmjTyN0jVFQmnxt5B6VoZVf/tw5fy15ICHvE
	Eq/ZgE7lm5qXzrO4/cvFHhGk2O9t3FFgxFTlXYqdhJrYIcpo1xFlxFV+0lriDVjp
	lsqUquSPcPZLaNKtFs90cr0VAoroqEA1PdJWlKlfsp74z7Rp0yl4/F8ChVHLH2Wa
	h3Bz+ZRNyoxrd4dSWGGfpVlZccYeqiyYcfROLdNAqDhTIf4RgHC1ZQgBe1mhUlyw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu292gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 09:01:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8uHTH024786;
	Thu, 20 Aug 2026 09:01:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhdjcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 09:01:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K91jCc38142282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 09:01:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4299B2004B;
	Thu, 20 Aug 2026 09:01:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D437D20040;
	Thu, 20 Aug 2026 09:01:44 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 09:01:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 11:01:44 +0200
Message-Id: <DKTNDJPXSMZM.2Y0XXTLMLK6UL@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev"
 <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 6/7] s390/pci: add error cleanup in
 zpci_directed_irq_init
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-6-826ff27b6e97@linux.ibm.com>
 <20260819090237.E61621F00A3A@smtp.kernel.org>
In-Reply-To: <20260819090237.E61621F00A3A@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a86c27d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=glX0xfcHcXGri_P-SMIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vH8AC9ukR2ZIte3CmIyBt-yQg5srhYW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2NSBTYWx0ZWRfX/YZcQ4n0WTDB
 hBaXzIOR6S6yLYqVG6/vE79ly0pC/a0eYaW7nNazgPhZpXOegw8SePO8xPGGLMqhXm2ebIEghYG
 crMZK/lo+yj03TRx0/TkyQDrSkcLzYWgZksZJFgwz/R9WJM69lglM5Bmd27/sJUl7BmNYHFMlTV
 14sHRAbnG8y2pNwNpDHPk5NbnBuCwBhPXNruALldKyfiYJFDcq3TmHr4glGO8W/VrXXMBdEUF+x
 JpXXbsoUKkyRzsx7BT4IkfnmHAdW4BSXBUKvmJB796heZW8eFoK4a1CyH2plv3Qua0UAwEPVM4H
 jWRnHdVzhzPVyDei1vlPL0dAPwzEKmeFl50sN0K+T5ip4Y72mz2exI/LDnsNNVo2FBk+uWucrKE
 kAEM4+JQ+m4pcNY+sfM4H3FtO0ZvAxwFmVQ0Z0XMvuH5v9KjdPtKm6WdZaegRAnjNYNEY3IGi+D
 WwgUNQ4GisUX6g07bPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2NSBTYWx0ZWRfX59cDUaBXFXRr
 O6svmEDu5KcEy6eXL1DpKdHro5+s1H2gHWwI/p8NV5nXvCPF+3wNOZdMYTowuwesUnlPqNAJQd0
 hEfuIKCmRGgY73SUBIIJTm4HTXwnHGw=
X-Proofpoint-ORIG-GUID: vH8AC9ukR2ZIte3CmIyBt-yQg5srhYW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200065

On Wed Aug 19, 2026 at 11:02 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The newly added error cleanup path in `zpci_directed_irq_init` i=
ntroduces a DMA use-after-free vulnerability.
> --
>
> --- Patch [6]: [PATCH 6/7] s390/pci: add error cleanup in zpci_directed_i=
rq_init ---
> commit 5a0360870b410d13391fe09d0a8840ffaa9cb9be
> Author: Tobias Schumacher <ts@linux.ibm.com>
>
> s390/pci: add error cleanup in zpci_directed_irq_init
>
> This commit adds an error cleanup path to zpci_directed_irq_init to relea=
se
> airq_iv resources if per-CPU allocation fails, preventing a memory leak.
>
>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index 1515d8d7460ea..1ddf6b3625a26 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -586,7 +586,7 @@ static int __init zpci_directed_irq_init(void)
>>
>>  	zpci_ibv =3D kzalloc_objs(*zpci_ibv, num_possible_cpus());
>>  	if (!zpci_ibv)
>> -		return -ENOMEM;
>> +		goto out_free_sbv;
>>
>>  	for_each_possible_cpu(cpu) {
>
> [ ... ]
>
>> @@ -599,13 +599,25 @@ static int __init zpci_directed_irq_init(void)
>>  					       AIRQ_IV_CACHELINE |
>>  					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
>>  		if (!zpci_ibv[cpu])
>> -			return -ENOMEM;
>> +			goto out_free_ibv;
>>  	}
>>  	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
>>
>>  	zpci_irq_chip.irq_set_affinity =3D zpci_set_irq_affinity;
>>
>>  	return 0;
>> +
>> +out_free_ibv:
>> +	for_each_possible_cpu(cpu) {
>> +		if (zpci_ibv[cpu])
>> +			airq_iv_release(zpci_ibv[cpu]);
>> +	}
>> +	kfree(zpci_ibv);
>> +	zpci_ibv =3D NULL;
>> +out_free_sbv:
>> +	airq_iv_release(zpci_sbv);
>
> [Severity: High]
> Does this new error path introduce a potential DMA use-after-free?
>
> Just before the allocation of zpci_ibv, the hardware is configured with t=
he
> physical address of zpci_sbv->vector:
>
> arch/s390/pci/pci_irq.c:zpci_directed_irq_init() {
>     ...
>     iib.diib.disb_addr =3D virt_to_phys(zpci_sbv->vector);
>     zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
>
>     zpci_ibv =3D kzalloc_objs(*zpci_ibv, num_possible_cpus());
>     if (!zpci_ibv)
>         goto out_free_sbv;
>     ...
> }
>
> If we jump to out_free_sbv and free zpci_sbv via airq_iv_release(zpci_sbv=
)
> without resetting the hardware configuration first, could the adapter
> corrupt memory by writing to the freed physical page during a spurious
> interrupt?
>
> Would it make sense to either defer the zpci_set_irq_ctrl() hardware
> configuration until all software allocations succeed, or unregister the
> hardware in the out_free_sbv error path?

zpci_directed_irq_init() is reached from zpci_irq_init(), which
pci_base_init() calls before any device exists. A function only starts
generating directed interrupts once it has been registered with
zpci_set_directed_irq(), called from zpci_msi_prepare()->zpci_set_irq().

Tobias

