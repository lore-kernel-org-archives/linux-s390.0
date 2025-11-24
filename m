Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CF2F49EB;
	Mon, 24 Nov 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975397; cv=none; b=c4NDD35+TmhrvjKsN9QhvxxMUarWZHnXJFafK8D3f3Ys/KxTBGeH7ET6mV5sca0ncSPeIAIDNGYFogpLohQVsmiQAK8BL56dpFZe929ybT3pT7+7h1kvbHWLQbNWBOe/NRGvyCLv6OWyy6yetgG4X6ub7cFsKIKc90TPDR6FqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975397; c=relaxed/simple;
	bh=kM1neepDuCS0+7BEng+8NQou9OwOF3fUg1ZvsEmTyPQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNAYI62KWPHwYm+9ISisCjjnHlUXs+K/AXCERY/yka7UkA1R53BwnL3PniqOCz5VucvlOhJM+ogXarlPOkvc/k2Zvxi2lwd6uU6Z9+9lAZC1vxyuMOs4hif+dvWMjkYSxKMwpixR9Otln5QIULhan8U5U8YYxrZnuDJiCqaFTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r1nQ+HYv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r1nQ+HYv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO5bb5r006017;
	Mon, 24 Nov 2025 09:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ENjSSK
	wBFS82uJEZAYvxOxQfO6uDW2HeASXIUKtx0d0=; b=r1nQ+HYvzJFfJ8JKIYXna0
	zR6QPbR6u1Dl9XAoYDfmz4n6aJk7rD73M3npX/AqSLBp6ht8Zvbql7XiaMJ5ydmc
	57ff9SexCzsN/Czhg8cJuofGVqG4AkoEtye/b2ar8SZbna9qkP5xr0KgHLhQo1pW
	xKrizBbTo7YhwpMcmMlOiVQcySnz/9VyrE4KuE12to5zCkkl8YwD7IxptX4Z7SG+
	MB9Onn/ODyIKuKkxmL4bbbmfs1qzFEGFMX/Ktwfe9TApLED6DvoqvAvnGoWHnbYU
	oAok/r3PVzsc2WdtmDTxXp97KSKU821dPeKNNVw1nSv0k4uXMUB++tYhzmzF7n7g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjpwjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 09:09:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO6OKmO000857;
	Mon, 24 Nov 2025 09:09:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvxn6nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 09:09:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AO99T2g30998798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 09:09:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8882F20043;
	Mon, 24 Nov 2025 09:09:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE21720040;
	Mon, 24 Nov 2025 09:09:28 +0000 (GMT)
Received: from [9.111.65.191] (unknown [9.111.65.191])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Nov 2025 09:09:28 +0000 (GMT)
Message-ID: <90ed89847839798f557f0ecb0bf65f87f00cd01d.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas
 Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>,
        Halil Pasic	 <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner	
 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 24 Nov 2025 10:09:28 +0100
In-Reply-To: <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
	 <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: voQsMpN1lrk9CISSPLljagXbMJmwirKe
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=692420ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=S97O_n-OG-JIkBYQY2YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: voQsMpN1lrk9CISSPLljagXbMJmwirKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfXwVWbaKoZiigv
 t3TQvVc1KJBHpBXG9/AYHz7SwXUae41wVXJoqaMGfURspk/0mNeAjxh1YPOMrqSJr3kd9r1PhIp
 WosuIQW0BQcvNJzh8FOfwbdU/5R4rXTxO++1pU6C69D5QPfEnomlxG5nT6BKOvvpV6gRkuxbJrp
 6ID0WQuQ2i5EfJt6NMppeqE8Ad4s8CCHwkQ9+kZNV67UfPy0e8wHJtbttSLngRMq2aei0Oi5m1Y
 fvyvN5d3tC42h7PGJnlMS4PNQKmMIErelh+XtLA7yO9hHKwL6s9wzQcNhhIPg16WNxBZxQOLiOD
 vJwMYOyv8Ngzm3PD96iqHAsMcq7/iO/cy7rsozCXdr1IU8kzKlr10zddWmUE4a9mCsN6jnTaej7
 NkO7UF5szUTGQwUvs4t2bmEZiH+eeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Fri, 2025-11-21 at 16:45 +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
>=20
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de
>=20
> In detail, create an MSI parent domain for each PCI domain. When a PCI
> device sets up MSI or MSI-X IRQs, the library creates a per-device IRQ
> domain for this device, which is used by the device for allocating and
> freeing IRQs.
>=20
> The per-device domain delegates this allocation and freeing to the
> parent-domain. In the end, the corresponding callbacks of the parent
> domain are responsible for allocating and freeing the IRQs.
>=20
> The allocation is split into two parts:
> - zpci_msi_prepare() is called once for each device and allocates the
>   required resources. On s390, each PCI function has its own airq
>   vector and a summary bit, which must be configured once per function.
>   This is done in prepare().
> - zpci_msi_alloc() can be called multiple times for allocating one or
>   more MSI/MSI-X IRQs. This creates a mapping between the virtual IRQ
>   number in the kernel and the hardware IRQ number.
>=20
> Freeing is split into two counterparts:
> - zpci_msi_free() reverts the effects of zpci_msi_alloc() and
> - zpci_msi_teardown() reverts the effects of zpci_msi_prepare(). This is
>   called once when all IRQs are freed before a device is removed.
>=20
> Since the parent domain in the end allocates the IRQs, the hwirq
> encoding must be unambiguous for all IRQs of all devices. This is
> achieved by encoding the hwirq using the devfn and the MSI index.
>=20
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   4 +
>  arch/s390/pci/pci_bus.c     |  18 ++-
>  arch/s390/pci/pci_irq.c     | 304 ++++++++++++++++++++++++++++----------=
------
>  4 files changed, 212 insertions(+), 115 deletions(-)
>=20

LGTM now,
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

Thank you!
