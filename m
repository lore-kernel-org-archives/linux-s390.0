Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7D2FAC16;
	Mon, 24 Nov 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981746; cv=none; b=KyDimQjgbCxFYoO37eUAfTpLEHuA8uI/ehPdoczubF5NepkesmlsRMHIWMLBUSlpiSzrhBgveR5bFHVdPPjQinVnCDAZn646lU/Dz/K79+0Gx/AoIQMqCFCHejXmrpyMBmSWYTpmTLpNJ+hzNHMa2tJ4Tv2Z0U7RsLxWb+AOt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981746; c=relaxed/simple;
	bh=35uAi8V8R0Ep0wmKkDcbjdS6ZJu3gdKwprU+8keDS6c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SEb2/rvy5+LYajuXYXzGxp9LE1bDYyxHet8Le3cqUTz277nzhj/TXTOjRHtfhhuRUfvpfUW7BxO/FgiM0ZQyNGRiBt+9MLcszhArhciKDKZEaBN6GwhAX7aI/6r0hcXQyD12d82V7kQkaPKjPTjBMZqDIsgaXNNHzEuQJ2ulpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pcbC0BUc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pcbC0BUc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOARA5m007484;
	Mon, 24 Nov 2025 10:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GnsRYC
	V2M67jrehH9YkNlB7dAEz/7jSLuoJn+MrOtdI=; b=pcbC0BUcHXX8t3z506G3Gd
	VRthYkVbn/UbLlfvdhXHahSPsheY7cQBeZJYtsEK2IhseaDIeXDVwQ9eXVu95jS3
	JW1VR5Cx9ChFih1u9AdrZ7GfT2xaqZyJtUQ3xwUeAaIYZQQTu6cEfgRimNdjI7sX
	qYR+gUUHydN89i8yGpQl0Lj2BcNZKGmzMWucjk18KZFIEyKs7QDRalkbhshptT4T
	Jciopm1wTzfy7NoW5W2UsTAfKjH6NAIjFWkEo2WWTEj4ia2mQPzCNQjZDt7VzaAx
	Gs2q/dJtU35BtFW/XyM1Hb9wx3dDyRQTDUb/xtstK64DUYLg6i0O/XTd+k0360Jw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phqr24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:55:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AO7TuGh016418;
	Mon, 24 Nov 2025 10:55:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0jwd2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:55:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AOAtMKg41484694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:55:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8F4320043;
	Mon, 24 Nov 2025 10:55:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ADEC20040;
	Mon, 24 Nov 2025 10:55:21 +0000 (GMT)
Received: from localhost (unknown [9.87.133.143])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Nov 2025 10:55:21 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 11:55:20 +0100
Message-Id: <DEGVBZFMVBNY.XOWQKJPUIVCI@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev"
 <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Niklas
 Schnelle" <schnelle@linux.ibm.com>,
        "Gerald Schaefer"
 <gerald.schaefer@linux.ibm.com>,
        "Gerd Bayer" <gbayer@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Matthew Rosato"
 <mjrosato@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain
 API
From: "Tobias Schumacher" <ts@linux.ibm.com>
To: "Heiko Carstens" <hca@linux.ibm.com>,
        "Tobias Schumacher"
 <ts@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
 <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
 <20251121161104.27602Ee9-hca@linux.ibm.com>
In-Reply-To: <20251121161104.27602Ee9-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX0/BhIDI5MxBl
 oH2ehEAql0l2WgBNTZSawDZp9klBrZtsiCfA+zQ32FfQaT94irt8bWD0dDw0s1tF81TVOg1bY9v
 CtSVCJ2olvqMOcJ4QC8asqP/Ee6NG1CkOS8x/IXKFu+/FBCaofK8LYEiAmgxj6v4E3f9/A3X67L
 dw8Tfh9Ai5auwtKU9OaJnVqrzGSAz2AZZ3K0O38o/OV98xkAUIgm3/UXRhn1iW6BeKz9w26s+3U
 GIEmEkH4KLOYzvvXbCKmnT190up4Nz6wxSA0p3FS1Y3uX7I6OLAY3pEghuA7oimX/6aqcZqLb9E
 PXPSesc27sG650dLzBgJFdUuqGsutNqfI9OO41NsSVPzewYm/Za2h3zcsF/A93kvPE9CnmHScpT
 C7uUmLbAh91tEw7Nk/NtctwVMJh1sA==
X-Proofpoint-ORIG-GUID: JjnJ1LKaYJ_Lc66TWqiK-briUfvGESYy
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=692439a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=58y8EWi8-MnPt3D15-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JjnJ1LKaYJ_Lc66TWqiK-briUfvGESYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

On Fri Nov 21, 2025 at 5:11 PM CET, Heiko Carstens wrote:
> On Fri, Nov 21, 2025 at 04:45:43PM +0100, Tobias Schumacher wrote:
>> +static const struct irq_domain_ops zpci_msi_domain_ops =3D {
>> +	.alloc =3D zpci_msi_domain_alloc,
>> +	.free  =3D zpci_msi_domain_free
> ...
>> +static struct msi_parent_ops zpci_msi_parent_ops =3D {
>> +	.supported_flags   =3D MSI_GENERIC_FLAGS_MASK	|
>> +			     MSI_FLAG_PCI_MSIX		|
>> +			     MSI_FLAG_MULTI_PCI_MSI,
>> +	.required_flags	   =3D MSI_FLAG_USE_DEF_DOM_OPS  |
>> +			     MSI_FLAG_USE_DEF_CHIP_OPS,
>> +	.init_dev_msi_info =3D zpci_init_dev_msi_info
> ...
>> +	struct irq_domain_info info =3D {
>> +		.fwnode		=3D irq_domain_alloc_named_fwnode(fwnode_name),
>> +		.ops		=3D &zpci_msi_domain_ops
>
> All initializers should come with a comma at the end. Anyway, let's wait
> for Gerd. If he is fine with this version I'll add them when applying.

Sorry for that. Since Gert found another issue, I'll fix this one, too.

Thanks,
Tobias
