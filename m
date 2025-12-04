Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A21ADC83;
	Thu,  4 Dec 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847229; cv=none; b=sUJ8afHDHfw0A39jcLhH6cJHn6USCz9BhDMvJp1Os2zw3cMjV+qSarRC7rnq7+DzXf4Y9/dBUln5ey8dQ3Qj2aoldN/r3sZ+eLfrPfe2IknusAVpmZm3wePEYAiuDQGOyjwZgNXUIeZq/ITf2GRKu4duqsB/528oXCTwxu/fiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847229; c=relaxed/simple;
	bh=4NaHwevdvzKSD9cZHYeOwdWPMd82T+00h3vd2FwHe8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpQ1akrtrtkJpsFKxWU3L9b2f7oUCFNMShWnfhDJ4Z4LldofuRJsBLvEZyX9h//D2AGuTo3UByx+c5riGW0tykvrOaSMI0cGGyyds0KNK6FKtitqL98BRxMwoPu/KPcRtlKUvm6toJUVA8i49dZvLChG2VCeDtnUqZHVzyJ44R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qTOKydua; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qTOKydua"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3N6pZh017501;
	Thu, 4 Dec 2025 11:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=huYB46nKtInI+Y/SSkPcdZ3eKhz9jy
	wAt9znxWKfrnQ=; b=qTOKyduaRXhAQNV3QcRR3iuU/TY3jLDBzfV0HoWCbi4FCy
	NCTSeHPuQmIl8lgVPmft5dk6r+0IW6H/FdbN+EaImX8NIpbVir3buy5Nvd9HQgw1
	Z2OZwZLukAxNu6Lq/V7BRZU5egr6O51QJpioTvQftdBm+8NU3Ctn+IuMuJCQzdwB
	FkITNZwefxHCHD/AVs7HpKsUkzAkP8Z63H1z9w6Q7FR7l/yOqNXcMZHo5o/MRzxW
	jd35MVmEBNVHKoxRCCxQEsaeRmpucw90UhTI7hsU80D165rdtuvJeQRMqt+noz/h
	pxxqUvRfHDdNC83CIx8x9wXkEagVZvud1PMzlOPA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9yy4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 11:20:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4AoXrm024120;
	Thu, 4 Dec 2025 11:20:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5sqj27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 11:20:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4BKJMM30867774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 11:20:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B113820040;
	Thu,  4 Dec 2025 11:20:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E85F20043;
	Thu,  4 Dec 2025 11:20:19 +0000 (GMT)
Received: from osiris (unknown [9.111.24.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  4 Dec 2025 11:20:18 +0000 (GMT)
Date: Thu, 4 Dec 2025 12:20:17 +0100
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
        linux-s390@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v9 0/2] genirq: s390/pci: Migrate MSI interrupts to
 irqdomain API
Message-ID: <20251204112017.30109A70-hca@linux.ibm.com>
References: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204-implement-msi-domain-v9-0-d2152235701b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tlQJaOGtfjh7oR7xUBuqf1c8tqY-d1nD
X-Proofpoint-ORIG-GUID: tlQJaOGtfjh7oR7xUBuqf1c8tqY-d1nD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX14dk20YQn3/h
 RnHRZ6mlDNVhTWuLc/PA5ZqNIWDenxMryBFZdGstoIYCmircuE5ApRnA2trrYtTTdYPLNpStCI8
 +3C4UY4xwRzPgJe3uJm0U0Wh1R4F2ikmjPINmQ/k9Kc6PiqVtCfhiZamdE+5MkeZTOCtq8ffjDd
 cXFuDpo0AD8ZfARE3tu+Bp34eALdYsm8GI1aNvUO20l3hFbfUkSBxvyuIIYDoG4vz47a3xJrOr4
 rGAGYdnQUE5vDQzVtiN0X9XI1Bp+yxf3dIoAM62vk60r3aPXEe6P+4Y/b9OWAmNrp9ipathbMS5
 Bw7WVpy2tcCpfLzXiwaRtJFNcxz2zn1Dei73QOqmoXXGcTNY/my3AyBR5w6+AFfUODSxfni68rQ
 xm2pwCke1a+zS6wnGSSJ2mwUbtep/A==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=69316e78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PNGMqOLg_kmLGsCwNosA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On Thu, Dec 04, 2025 at 06:05:00AM +0100, Tobias Schumacher wrote:
> This patch series reworks the PCIe interrupt handling on s390 by
> migrating it to use a proper MSI parent domain. Introducing a dedicated
> MSI domain hierarchy aligns s390 PCIe support with the generic Linux IRQ
> domain model. Currently s390 is one of the last architectures still using
> the legacy API.

Is there any reason why this should be squeezed into the current merge
window? Would it make somebody's life significantly easier?

Otherwise this has to wait until the next merge window.

> Tobias Schumacher (2):
>       genirq: Change hwirq parameter to irq_hw_number_t
>       s390/pci: Migrate s390 IRQ logic to IRQ domain API
> 
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   5 +
>  arch/s390/pci/pci.c         |   6 +
>  arch/s390/pci/pci_bus.c     |  18 ++-
>  arch/s390/pci/pci_irq.c     | 332 +++++++++++++++++++++++++++++---------------
>  include/linux/irqdesc.h     |   6 +-
>  kernel/irq/irqdesc.c        |   6 +-
>  7 files changed, 253 insertions(+), 121 deletions(-)

Series applied.
