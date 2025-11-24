Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8B2FB085;
	Mon, 24 Nov 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981967; cv=none; b=fgDQpRqPMYbwnyq6mjGGh7TkpBVbI9eOVpW6ytspimHIrTHwV1QP8geqnLjDGoDq5O5dCtfCiFAhL2GP82oRmoKZo/0fPtOWEODggXKDdAoz8Or/WNby658atctb3i4UUjDwkvSJKAHxYYenQ7GVzTyM9hB2HpnlCdc7Rvqts/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981967; c=relaxed/simple;
	bh=0rsyw4dO+mzhIoEg9QRJA47qYsk7p+MgaOqnna/uPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxMKjSkOqQ4E/ETihZ3gY1V7kqdF8pR6P2E3D7T/43Q18z20/iCOeerpZRUAGCk3iGA92nL9k/rZzdjPDyNoBtOIdF57IEFmhzmCOporz662XGCjI8O/S/T6VlBWANxGsvDtP7K7Fk1QFR/fFXEkIOa/vHumx+ytjzEpAVcMJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XH64+j/H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XH64+j/H"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ANMbSpS005125;
	Mon, 24 Nov 2025 10:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZNJUrTfhaEk/ltXWdpYetffvnyEFh2
	/Ze8JUXNGWWJ8=; b=XH64+j/HYgte3ciFqK3MIQu7AEkiMHN+NzXwC9vdCr3l+r
	Cyh1q1dw4S5LdTgow303JIqmydVnQgGU1qYeyHVloPdrVrfOx+sz6vkV/54UO9XA
	ymHSyXAAE2hYanTy/F63yOp6v3fY1g+HtNofuKVUq5jQKvz6WoiWoeZVJBFTRlwF
	A/jsv7sBm60jpIWA+v/waqia/wC9UUxWtSUTSMfDJH7HbSBbwwSqZwTEIzIWjLgC
	NHGSwz05prTOH2wK3gTuKqXpG0+x42MwJVf+s1eT72bC0xVvz4qwR1WsQouasFxH
	hNGcDt1+vBK8j4gxyV9lh7P5TQ6emiDC4ZknWRaA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjqarf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:59:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOA8NnC030775;
	Mon, 24 Nov 2025 10:59:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgs5nj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 10:59:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AOAxIV78978754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 10:59:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8C420043;
	Mon, 24 Nov 2025 10:59:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3468A20040;
	Mon, 24 Nov 2025 10:59:18 +0000 (GMT)
Received: from osiris (unknown [9.111.89.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Nov 2025 10:59:18 +0000 (GMT)
Date: Mon, 24 Nov 2025 11:59:16 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
Message-ID: <20251124105916.13043A0a-hca@linux.ibm.com>
References: <20251121-implement-msi-domain-v6-0-444f4a6479c3@linux.ibm.com>
 <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-implement-msi-domain-v6-2-444f4a6479c3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TwDIUcaEnUn_uMC5WsinFwpobFqU-1Oy
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69243a8b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-L5G2EjNg4gn0OKNUVsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TwDIUcaEnUn_uMC5WsinFwpobFqU-1Oy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX7eAD3xqnid7b
 Rm/FTpnZVY3Nt4V9U7Q6OR2w3Bqd9CEkBIVfXhTduHBDVgEkV9X+1Hi19O+RubL7XpC0PTwWg+F
 W17QFTEjw4dGkAimmyyYPME0Yngw+5YVrgg6DbClhMNdbpzLjGJt7yJyuaYm/IywVS0uMOXUvWc
 jKlJzJc4O3n/4hUhyCEhD5K1iNHVgrMz6bgbmkJ3BlknvMp1LZ2/BYtBZ7swOOCNK2rZrC1DS83
 TAhGBXbeoznbHC95X7h+MCCn6eTlGaVgxj1bqRuv2S1nzl8DlapUcnBXTt/g3yHmjaLpcj2NH/R
 nci2n2lIPh6G0CLxw47P4vtJ8i4ttJ+wA2hXUYXzX5WI4a9m8rEadwRJkW8E+6HMhuwKq4/aVdQ
 ORyP0tPNiQv0V9CN2vZSi1On/xHmpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

> +static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int virq,
> +				 unsigned int nr_irqs)
> +{
> +	irq_hw_number_t hwirq;
> +	struct irq_data *d;
> +	int i;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		hwirq = d->hwirq;
> +		irq_domain_reset_irq_data(d);
> +	}
> +}

Since there will be a new version: please remove the unused hwirq.
