Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513D21A449;
	Mon, 24 Nov 2025 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980906; cv=none; b=KI2vVEORgdT/X6LTEkZ8MY8vJMa3YGqgGOaB1/i7R95YVKtVKUuvlhtwOCplKb5WgAr7il55pQYJEdKGvSa6XfYg9sA77GwDm5vwdOUfmsOLkC42LwFAbtLrGL51aZjegoTPRGaSJUMXNITeoNLIwdogW5emlxrrsWAKNyw36g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980906; c=relaxed/simple;
	bh=HeBXXKO2rTEjry8OIowCm1jBqqDmes9CS8EjCtvIgX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=swIFlpX8wDjxl2sNdMvZhBhuNLaej+jKcxJScRQKlpMCatbk/jqS9kV4YEw6ubBlKSvp50xZNLoOFDYci8XRhN5o/VHFAFYh1ueD1IsC9GYkiZ2na86FUAiTONZT7o29YsQ7QilJuy/ZhOQr7sxM27Bi47fnUBUQMsI9jfvnSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mIO6S8cz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mIO6S8cz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO9grqD025083;
	Mon, 24 Nov 2025 10:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CGIqbE
	3Hk+twt/fj4kWDU9W60mRTEhsunqTIdxs/quI=; b=mIO6S8czQbN7qRGCEdx5CA
	exTSJemI63isZAYp2n+IfEpr5RyNTDE+e9bNR+HjUjuNJ1ZHIdr9Y6cP7Dp/jNW3
	72K18xOlNGaSVuli1twQVVbh2jv1cPb6qECwvwsY3AOppoWwBeh3mQo9XAjjWBBk
	Cru58AdvpumZXWaHgLc8IJJhlajxhwtxyxCn2O2nIojOJzUdUHp/6bcrPdUKQgsS
	Jg/jXZ1cDl+kvF/rVsOTFIRx+eAsauBlIhzoUs89fPS1KzPjimyt5rbEd+x/uI+5
	OAmJ/78gtap2SCQYVyCnz0abGjPbMB7wB4fQxiTt+o46qVrsIf8uVMDWq+SmYMSA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjq8u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:41:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO7X9xs016395;
	Mon, 24 Nov 2025 10:41:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0jwbk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:41:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AOAfaSU29295132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:41:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B7620043;
	Mon, 24 Nov 2025 10:41:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C35320040;
	Mon, 24 Nov 2025 10:41:34 +0000 (GMT)
Received: from localhost (unknown [9.87.133.143])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Nov 2025 10:41:34 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 11:41:34 +0100
Message-Id: <DEGV1FLJUZUK.168XQ7E6S86F8@linux.ibm.com>
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
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        "Farhan
 Ali" <alifm@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
From: "Tobias Schumacher" <ts@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
 <176fd445d19ab883a22dc0cd9f480e0c7f3927fb.camel@linux.ibm.com>
In-Reply-To: <176fd445d19ab883a22dc0cd9f480e0c7f3927fb.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xmlUnJ8D8774wrO1nuSUGY5SRMW4BX8e
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69243665 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UbfRCO35A583fSXhuSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xmlUnJ8D8774wrO1nuSUGY5SRMW4BX8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX6ApsoCxZ7j7s
 fTbllIQnUK7Jnpk3YKkv1mnjA01BDPLFLov/Nvy0MGPujXCsUsqhE7Xa2wTHN4DzbE7pdSz4iI+
 aEU03xxO2UToX0+w1TlaO7QWxBIBvrWronCACV265q8Tj6EM2QKFTQG8wz6alLyQNYFZ8/JmOyE
 vePirq5Rnt++4Vp5Srp5lePm2lvD56f3LmaMV7o/iDcKOPGaNIrn8F+zHX0Ynemsul180IefQFE
 b6ebe4cBcpkTmddKozwWP0e+OsNXCIYFm6QHnddgyFrOYRxevp9oVgRSmVeN5Av7ZshjAETszsj
 RW261FMVP19Dnd8HvNrx2CTQG44yqnCJq9w/Dyl1At409TXVdjC2bUZ7LS5ThmI2wUifwqsFgt8
 62iAm80vYTbpdlPTMn5foJtKCRr7Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Mon Nov 24, 2025 at 11:30 AM CET, Gerd Bayer wrote:
> On Fri, 2025-11-21 at 16:45 +0100, Tobias Schumacher wrote:
>> This patch series reworks the PCIe interrupt handling on s390 by
>> migrating it to use a proper MSI parent domain. Introducing a dedicated
>> MSI domain hierarchy aligns s390 PCIe support with the generic Linux IRQ
>> domain model. Currently s390 is one of the last architectures still usin=
g
>> the legacy API.
>>=20
>> The migration splits the existing code in the legacy functions
>> arch_setup_msi_irqs() and arch_teardown_msi_irqs() into different
>> callbacks of the newly created MSI parent domain:
>>=20
>> - zpci_msi_prepare(): prepare the allocation of per-device MSI IRQs.
>>       will be called once for each device before allocating individual
>>       IRQs and sets up for example the adapter aisb and aibv.
>> - zpci_msi_teardown(): reverts the effects of zpci_msi_prepare() and is
>>       called after all MSI IRQs are freed.
>> - zpci_msi_domain_alloc(): the allocation function for interrupts
>> - zpci_msi_domain_free(): revert the effects of zpci_msi_domain_alloc()
>> - zpci_compose_msi_msg(): create the MSI message to be written into the
>>       corresponding PCI config space.
>>=20
>> * Patch 1 fixes an inconsistency in the irqdomain API. Internally, hw
>>   irqs are represented by an unsigned long int (irq_hw_number_t) while
>>   the external API in some cases takes an unsigned int as parameter.
>>   This fix was required in V2 of the patchset. Due to conceptual changes
>>   in patch 2 it is not required anymore for s390, but still seems
>>   sensible.
>> * Patch 2 implements IRQ domains for s390 PCI
>>=20
>> Since patch 1 changes common APIs, some build tests were done for x86_64
>> and arm64.=20
>>=20
>
> I just ran some error inject test on mxl5_core on a z15 zVM system with
> `zpcictl --reset-fw <PCI-ID>`
>
> With your patch series PCI autorecovery does not finish, unfortunately.
> Instead HW presents an Event 0x10 (MSI was received from the PCI
> function, while no AIRQ was registered)
>
> I'm afraid, there might be more work required...
> Gerd

Thanks, I'll have a look.

Tobias
