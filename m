Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC003B8922;
	Thu, 20 Aug 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215280; cv=none; b=PKAnvF+K5BnEl+KHtcwoUfVNYff3FUfdXAo22E0i0VJkJmp1IVgPiUSWIq6pPM89rNy7sY7BMyTtROJnu02h88RUlFtivwDoNuZpS7//ztLMzdRRLcA0efni/x6iPswptcvTVdlJ1DAgcpHNvFDWCeIbvTxbKF+6M6fSskzRQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215280; c=relaxed/simple;
	bh=OWcedJZ6pS72pebbqkungtVA/aGa/2LV5n+fw0FCOBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=orioKJKeP2TTR2eP7Y6BokfT8GUkIiih13rg1n76zztN+6qIUI2SnV9V1rh0vrB21R+6xbY6241Pkj6+dmYhZPWEnv7poukTY65qt+fJOaeT2mYn9EFXhGasZ+R34hLuOurmToTgPNLutEFyBwkSzqoOdFxfbpevjT29yWZmrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n7fypKC1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n7fypKC1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVU5N471173;
	Thu, 20 Aug 2026 08:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u//jbb
	Tg7GN+mqpLRyLn3ltMQREFfi9WnSCzZYaO7hY=; b=n7fypKC19+lYrOwtApi2Sl
	wrSNU4F+u3jQHmurpnt6MyGNsB5+ULD6lslDzYvhlA3+heg3OooXi62WVNRHetH2
	PBiuk7w4Ef8CFdaib6DNe4cCtRlD/fzXcmZlESCB2938PCGhg2kn4KOTw4l0fVsn
	96FYKmnDs4WR6ngN9aTvh9TWVEjVV4e6RGltPNHnL/AtKCxCaot3pDVwuwf/46g6
	ZcY4n95Nir2WG9rIvTWyQ1A9y3rXGturZYe7ZmARAhGjmu6fLWdXTUGzZg9+HmTE
	e9obUHOfIwO2ToCbH+g+yaPIGaXZPKAbP5XhPNIOmjbgriQtMDyFrjgjRj6iKyow
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0h4wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:41:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8fGdh017399;
	Thu, 20 Aug 2026 08:41:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twdkga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:41:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K8fAGN48890260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 08:41:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EE5E20043;
	Thu, 20 Aug 2026 08:41:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06C3F20040;
	Thu, 20 Aug 2026 08:41:10 +0000 (GMT)
Received: from localhost (unknown [9.111.13.52])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 08:41:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 10:41:09 +0200
Message-Id: <DKTMXSFMTV5U.34YRPA8XMXSP5@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Heiko Carstens"
 <hca@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>
Subject: Re: [PATCH 5/7] s390/pci: add NULL check in zpci_msi_clear_airq()
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: <sashiko-reviews@lists.linux.dev>, "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.22.0
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-5-826ff27b6e97@linux.ibm.com>
 <20260819091426.3F6FD1F000E9@smtp.kernel.org>
In-Reply-To: <20260819091426.3F6FD1F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86bdad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=XZzVTYKnKsqqoe2S8gsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mu79rTRncK8kMUJgqoEhJmAmt4q0Q6Rc
X-Proofpoint-GUID: Mu79rTRncK8kMUJgqoEhJmAmt4q0Q6Rc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2MSBTYWx0ZWRfX2sbtjbkomNZD
 9Or2L7FWd22ZO5HK8pWAGesSZtZ9iYmNCMFJT2rZeUt+G3j6Wc4S42fRl62mV3Ew0xWGrc4u2G5
 EjAQUVxALv+XNZ/aKhTq9/7gsm4Ezdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2MSBTYWx0ZWRfX8SC3GOGdr8hT
 +TN1tcI+9PZYqi54eaatSKRYUyPrZwuy9PzoZpk66HeUKFEvX6noA7mQO9/NKYQYGjnVOqFeVaX
 nxOW9cgpm4ZEWf3sweJJoWqrZtvcLrIS+rvkeruBGrKACK8NHCkobifCqDbH/XEpBVikrRnkvEL
 PoC3kHY8ci74gMTfC4rgQ9Y1RduHGlBgKIiqhjbA7SYkBMn2vcUVEZedXLts7Jr9BA7GbLuVYdT
 Vq3JSB/e1IoI+MBfQTKCGZ6GS1pKWsVbGMFRJnicXu2By6gCsLy5eRMcIqdXb1zOdkzgdwQaGvT
 OWgV7wrjFOaD5oAGVYRM1ohPEdYie2/Nbx+eUh+8N75ehpPNP0b/z7y+j1FEP+O0lOoZaOjCvMi
 UprbBvY5c34294dp0Htj/ujGpskhTyf5q0Vf7jaVnutdZ85wuoxzSDPf2ZBlSxCGHoTrk6+HsYk
 U1EbsU4ouMe3puUleXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200061

On Wed Aug 19, 2026 at 11:14 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] The patch introduces dead code by adding NULL checks for impos=
sible scenarios due to a misunderstanding of the MSI irqdomain lifecycle.
>
> Pre-existing issues:
> - [Critical] Double addition of the loop index `i` in `zpci_msi_clear_air=
q()` causes a heap out-of-bounds write during multi-MSI teardown.
> - [High] Missing device teardown in `pci_base_init()` error path creates =
a Use-After-Free condition, which the added NULL checks silently evaluate.
> --
>
> --- Patch [5]: [PATCH 5/7] s390/pci: add NULL check in zpci_msi_clear_air=
q() ---
> commit a9e3adc4d04b20107c5f8c48da92688566d873e6
> Author: Tobias Schumacher <ts@linux.ibm.com>
> s390/pci: add NULL check in zpci_msi_clear_airq()
>
> This commit adds null checks for the interrupt vector pointers in
> zpci_msi_clear_airq() for both DIRECTED and FLOATING modes. It attempts
> to prevent crashes during error cleanup and shutdown paths if the pointer=
s
> are already freed.
>
>> In FLOATING mode, zdev->aibv can be NULL if:
>> - zpci_msi_prepare() fails after __alloc_airq() but before setting
>>   up the device's AIBV, and zpci_msi_domain_free() is called during
>>   error cleanup
>> - The device is being torn down and zpci_msi_teardown_floating()
>>   has already released the AIBV
>
> [Severity: Medium]
> Is this description accurate?
>
> If the .msi_prepare callback fails, it returns an error and the MSI core
> halts allocation without invoking .alloc. Consequently, the .free callbac=
k
> is never invoked for this device, so zpci_msi_clear_airq() wouldn't
> execute on this error path.
>
> During normal device teardown, the MSI core guarantees that .free is invo=
ked
> per-IRQ strictly before the domain is destroyed and .msi_teardown is invo=
ked.
> Since zpci_msi_teardown_floating() is the only function that sets zdev->a=
ibv
> to null, zdev->aibv should be valid whenever zpci_msi_clear_airq() execut=
es.

Right, will fix this.

>> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
>> index e9eda846cb2d2..1515d8d7460ea 100644
>> --- a/arch/s390/pci/pci_irq.c
>> +++ b/arch/s390/pci/pci_irq.c
>> @@ -465,12 +465,16 @@ static void zpci_msi_clear_airq(struct irq_data *d=
, int i)
>>
>>  	if (irq_delivery =3D=3D DIRECTED) {
>>  		for_each_possible_cpu(cpu) {
>> -			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
>> -			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>> +			if (zpci_ibv[cpu]) {
>
> [Severity: High]
> This is a pre-existing issue, but does checking zpci_ibv[cpu] here lead t=
o a
> use-after-free read?
>
> In pci_base_init(), if zpci_fw_sysfs_init() fails, it jumps to out_find a=
nd
> calls zpci_irq_exit(). This frees the zpci_ibv array via kfree(), but lea=
ves
> active PCI devices registered.
>
> When drivers later bind to these devices and tear them down,
> zpci_msi_clear_airq() will execute. Checking the freed zpci_ibv array poi=
nter
> will likely evaluate to true, causing a use-after-free read and subsequen=
t
> write when it is dereferenced.

Right, will fix that.

>> +				airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
>> +				airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
>
> [Severity: Critical]
> This is a pre-existing issue, but does this code write out of bounds duri=
ng a
> multi-MSI teardown?

Discussed before, correct and will be fixed in follow-up series.
