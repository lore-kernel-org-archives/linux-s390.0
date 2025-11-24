Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A285BA95E;
	Mon, 24 Nov 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980220; cv=none; b=r5ITTYYCRsjbHNXQGiPpy/vJA4ZEO9BZDEMmfeJyKwIqG4WPwpyMl74XXaNDj6rDrEbWLX2s717zaecOGKtLLrp04F/L+MklWLLU07kqzK1jOf8r5kPZCGHkeRHuXs7UFkN0FNrPPcBhc7ohYFX1vXEX+YjdtxXDaRMQHr5ix8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980220; c=relaxed/simple;
	bh=NoE9LX5gQzVFL80VPHU6m45dKRNlLSLQS1ySbLJufhc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGLAXFwrgbq//SM5q/C2ATGT7fJfa4+2UsFhigTmEUEP2QEjXrfjTXfngPES97fljkjKagHw47MyB+n+i2kbu1Kt66y4ThELUJQ5+ly6vEpJ0OjE6S3inH0Ma5N3ccpmvCchXrxJJa5H4fYyxOXdesQt7LoqE42kXOJVk8OTiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WHmf5s/x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WHmf5s/x"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO9n1Ug023367;
	Mon, 24 Nov 2025 10:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7BQaj9
	DqU3TqiwR80GIDGEfayEotFW1b6T40Ql1GJNg=; b=WHmf5s/xSr35CmrExiXEOt
	vubE1cr1dOZL/pjDisJuR0HMSCZfQLhR6A70MvxHIPWRSh66x+m98SIM0Es9GIJH
	UOrYrH9UIT1oM60fLj9vbgZcst/7qOSfFtZQVCgNEqYVnJ7U2brGwkWFwoHeaXy+
	s9CqPsqvbS6FpxYuLac7VsdgBkAuImzxWalGS4L9v6KnuwoGmJVxpBnxfhey20CS
	lsLZbKPbkEhC3NhgEXDiI58H9VC1qR5ouCr54n+wnjqen4hXBGN9x99QJBXbE+ID
	Kjr1+LRkyNY+AqZ/Q/+c99/vR7Vl/JRNCEA6z7p0vRZ4nc+dIGCoxMQE28iY5EVw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjq7e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:30:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO9uwDK030768;
	Mon, 24 Nov 2025 10:30:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgs5j8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:30:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AOAU9vu37421506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:30:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 722ED2004B;
	Mon, 24 Nov 2025 10:30:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9594520043;
	Mon, 24 Nov 2025 10:30:08 +0000 (GMT)
Received: from [9.111.65.191] (unknown [9.111.65.191])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Nov 2025 10:30:08 +0000 (GMT)
Message-ID: <176fd445d19ab883a22dc0cd9f480e0c7f3927fb.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
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
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Farhan Ali
	 <alifm@linux.ibm.com>
Date: Mon, 24 Nov 2025 11:30:08 +0100
In-Reply-To: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
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
X-Proofpoint-GUID: LKSxHgJt70P5xNmP116g4O-dHR6aHRFz
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=692433b6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=k0yQqzTXkmz0LktGLCIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LKSxHgJt70P5xNmP116g4O-dHR6aHRFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX5if8D3439XPN
 k/E7KbyiXsLvGfTCfN/4DqESQYEhPDP7YvKYk82mfCaaxlkHG6XfLzYMpbcIdBjsAsj7QDcfYuE
 4VDrTrwxZ0YRdDdBnPi4h4UwcIs/LQ8X8wlteeUViXOH2Zw37BvlUywIGDBhW/4OjHZaloncX0J
 hcuc4Bp5+l6JkIgErkU9wAUyRbh+V0N8XQzAgqowTR6LkxcFvxiK7bpPOD6geFXcUMBahSgoGS+
 3HBtf+uj/65N0hRxCh89m78d6yFwSdKu1YIcbMiDSUBQoVAkx5CrbO/wnaoJiwrKb5btteZ2r5K
 clL1mK6k55kyj8uj5sntGuWs+FzSTGGX3h9w5N3JRbFp2NbZoIHhEVXs2xZzSmy3fwuR+M6n67W
 pDcz74ibObgB29V3Jl1lCBDJ7kGvFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Fri, 2025-11-21 at 16:45 +0100, Tobias Schumacher wrote:
> This patch series reworks the PCIe interrupt handling on s390 by
> migrating it to use a proper MSI parent domain. Introducing a dedicated
> MSI domain hierarchy aligns s390 PCIe support with the generic Linux IRQ
> domain model. Currently s390 is one of the last architectures still using
> the legacy API.
>=20
> The migration splits the existing code in the legacy functions
> arch_setup_msi_irqs() and arch_teardown_msi_irqs() into different
> callbacks of the newly created MSI parent domain:
>=20
> - zpci_msi_prepare(): prepare the allocation of per-device MSI IRQs.
>       will be called once for each device before allocating individual
>       IRQs and sets up for example the adapter aisb and aibv.
> - zpci_msi_teardown(): reverts the effects of zpci_msi_prepare() and is
>       called after all MSI IRQs are freed.
> - zpci_msi_domain_alloc(): the allocation function for interrupts
> - zpci_msi_domain_free(): revert the effects of zpci_msi_domain_alloc()
> - zpci_compose_msi_msg(): create the MSI message to be written into the
>       corresponding PCI config space.
>=20
> * Patch 1 fixes an inconsistency in the irqdomain API. Internally, hw
>   irqs are represented by an unsigned long int (irq_hw_number_t) while
>   the external API in some cases takes an unsigned int as parameter.
>   This fix was required in V2 of the patchset. Due to conceptual changes
>   in patch 2 it is not required anymore for s390, but still seems
>   sensible.
> * Patch 2 implements IRQ domains for s390 PCI
>=20
> Since patch 1 changes common APIs, some build tests were done for x86_64
> and arm64.=20
>=20

I just ran some error inject test on mxl5_core on a z15 zVM system with
`zpcictl --reset-fw <PCI-ID>`

With your patch series PCI autorecovery does not finish, unfortunately.
Instead HW presents an Event 0x10 (MSI was received from the PCI
function, while no AIRQ was registered)

I'm afraid, there might be more work required...
Gerd
