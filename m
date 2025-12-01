Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2930C371;
	Mon,  1 Dec 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592797; cv=none; b=PMhvQ1h2PE+Xuc38BNhuBdR2/cLGb6Ztbu4GCjeKMKlDVQEAsdsWWHUnEU97v4csJocvHhl7GixyD5fkv8UJldcekHbgAjRjT64ZjlKohhlq/YKbT+o8FolqC1FP6SZN2l5J9lIqqQS+ZqNIHK6pP9JJLmaXFAg6AVKaeFKhKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592797; c=relaxed/simple;
	bh=OeVfLvZLVkBxJSWFhMwzT4fRjijhV3rDGD7Ud7pCRgE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qvKU7baoNjdISgvxH22N+58WCgj4STBOvPuvp0zJ3ZZlEHtyR3JMu1G4CSvy4dEFrAsOxvsK4gXDk9nWU7oq/Y9xmjSWwvQqyQusZTqPTvi4zk08gsUMn3XQlkKOlMpsNWQU77hqADWhZz6YhS1R9nfv4cr7DpC4M86eamRmy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=blDithMi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="blDithMi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1BK01C006233;
	Mon, 1 Dec 2025 12:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/alY8Y
	xzew69avEvDr8xKZB1aEoExnGemNNuwjvjvFg=; b=blDithMikBUVmZ75Us5eXl
	4W82IwGQlH7zpozeAvxK8AH8QVoeQJKxwd9lJKV2N7ZK7OWEh/0U3eHTZ8fuknqJ
	MfzlgRbJYyufc/Q4QhxqkinpA+tVMSKzeYO8fDWc42lYHpk4QF2vTguBvigAEA10
	xQrXz/jRGx91PgQLsOYoYbRrvkzV+AES5HLQZNRFltfCl/X6RmNt7rayBiBrxdW3
	wHj6SBTwotFGRBOcf/V7alkDO4fPCAqmvclJ/LDNnTFR11Kp0DRmq434BSMU4by7
	5ZC5pDd54j1zFf0RQw+Ta10qxy9q6bcBLVMrWJlmwA0kZRDsW0KTa+9HFYjdtgPQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg56xdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:39:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B19ihO0010227;
	Mon, 1 Dec 2025 12:39:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnjx9g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:39:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1Cdjvh44761452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 12:39:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B5E2004B;
	Mon,  1 Dec 2025 12:39:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6907420043;
	Mon,  1 Dec 2025 12:39:45 +0000 (GMT)
Received: from localhost (unknown [9.111.148.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 12:39:45 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 13:39:45 +0100
Message-Id: <DEMVXQGEFUXS.39W8XTWQ1WVZJ@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle"
 <svens@linux.ibm.com>,
        "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Thomas Gleixner"
 <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20251127-implement-msi-domain-v7-0-86c9a4837e8c@linux.ibm.com>
 <20251127-implement-msi-domain-v7-2-86c9a4837e8c@linux.ibm.com>
 <47a6dde6a2cd353be7c33a25fc2b6032e9256c9d.camel@linux.ibm.com>
In-Reply-To: <47a6dde6a2cd353be7c33a25fc2b6032e9256c9d.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qtMtztHxudjEEr17HH8yXgsPdnO9z1ux
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692d8c96 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=bXAjS1RguCY0HMnHgRcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX4J6P0szSm72M
 kagKacoJ9GrsXgK8NHf+QnjQOdp9N3PIhEaN9/QI1RQ3nlFiEAaGM/DsbnAcembd6f8XypE31ya
 9lJOfzwiAR4QhY1ES8Scv+tfy9E2uHfP6dboc7pe47DDMOQurQT7iIycAD1Ad/BRS04VjNziHe+
 uHy4JYPPvodksop/5aCRB4B4fyg2uZRaSO4jgahS+/P+bOJc6Ls1m1sOclfADzTDopfMes1koaS
 QtiSDOtXdUPBzoCli1lyKJyZkqW8MJ1vZuFena+6zREhQNi6PqvddfUb5yulxQl5QKeTqkRuk/C
 +GdB1K9yChZBeD1ahSnh2vwVTt5V4E2jr0m/x7G1pg3qCGtWuNNlQHpe+kV0bDTPltFyYoDroQH
 dSggKaY0q0qDENyoFeAguGl9TxwCXg==
X-Proofpoint-GUID: qtMtztHxudjEEr17HH8yXgsPdnO9z1ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

On Fri Nov 28, 2025 at 10:47 AM CET, Niklas Schnelle wrote:
> On Thu, 2025-11-27 at 16:07 +0100, Tobias Schumacher wrote:
>> s390 is one of the last architectures using the legacy API for setup and
>> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
>> to the MSI parent domain API. For details, see:
>>=20
>> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>>=20
>> In detail, create an MSI parent domain for each PCI domain. When a PCI
>> device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
>> domain for this device, which is used by the device for allocating and
>> freeing IRQs.
>>=20
>> The per-device domain delegates this allocation and freeing to the
>> parent-domain. In the end, the corresponding callbacks of the parent
>> domain are responsible for allocating and freeing the IRQs.
>>=20
>> The allocation is split into two parts:
>> - zpci_msi_prepare() is called once for each device and allocates the
>>   required resources. On s390, each PCI function has its own airq
>>   vector and a summary bit, which must be configured once per function.
>>   This is done in prepare().
>> - zpci_msi_alloc() can be called multiple times for allocating one or
>>   more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>>   number in the kernel and the hardware IRQ number.
>>=20
>> Freeing is split into two counterparts:
>> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
>> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>>   called once when all IRQs are freed before a device is removed.
>>=20
>> Since the parent domain in the end allocates the IRQs, the hwirq
>> encoding must be unambiguous for all IRQs of all devices. This is
>> achieved by encoding the hwirq using the devfn and the MSI index.
>>=20
>> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
>> ---
>>  arch/s390/Kconfig           |   1 +
>>  arch/s390/include/asm/pci.h |   5 +
>>  arch/s390/pci/pci.c         |   6 +
>>  arch/s390/pci/pci_bus.c     |  18 ++-
>>  arch/s390/pci/pci_irq.c     | 310 ++++++++++++++++++++++++++++---------=
-------
>>  5 files changed, 224 insertions(+), 116 deletions(-)
>>=20
> --- snip ---
>
>> +
>> +static inline u16 zpci_decode_hwirq_msi_index(u32 hwirq)
>
> I think the parameter's type should by irq_hw_number_t here. It doesn't
> matter for correctness since we're only using 32 bits now and the cast
> just cuts off the upper 32 bits but I'd like to preserve the type until
> you explicitly mask off the bits we don't use.

Makes sense, I'll change that.

> I also considered making zpci_encode_hwirq()'s return type
> irq_hw_number_t but I think it's not needed. This is because there
> we're still in the process of encoding the hwirq and want to emphasize
> that our encoding output uses 32 bits.

Agreed.

>> +{
>> +	return hwirq & 0xffff;
>> +}
>> =20
>
> The changes versus v6 look good to me and I agree that putting the
> zpci_set_irq() in zpci_reenable_device() looks like the cleanest fix
> for the recovery issue. Also good catch on the msg->data assignment. So
> feel free to (re-)add my R-b as per below.
>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks, since this is only a minor change let's wait if Gerd and Farhan
want to add anything before sending a new version.

Tobias
