Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418398;
	b=kTvA+2b/UjM8HUm9DdlMQa8URV6IQcNzaoLEH5M3Jn8za4vZCPo7doqgv4MoWDO+AEhZ
	 9AYI3KTguIK+wKudS83nt6cpklGfU3/8BZO0A3usDYvXqD/3eSYXpQ/1VomF0KnXdAKHk
	 3ZpbEDwniKLgss3kD25lU3ijdTG8/Xkb8WFDRaY3pDQXaBPgtPNkD/ELS3fis/R4NWsUk
	 g78JngxLEW+HpcoA8JCsQXuZVx7JOsrQDnKbrz84LBSh4dGZEGEph4HXlrTEGuO35KPLI
	 8YtEv8RqDOMSZUxQehEN8vmUIZRx75q/kZ83YsRw3sMEWja95YKahAraVBIQf/CwU/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418398;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RWDhYc96Mo5U+Ld7Dg4DmbCYC9ThBLzaTHcOjhlGf24=;
	b=SnYK/XPmM4LzVARwr7HlTNxxZCIvw4k8zWyKIz/LQesFc13m4Z07BoRItqN++UVCZx4w
	 NwlLkYI2vNHRsk1Z3Q4cIVmA65l9U4Ilfx0ZfvIHYTlvlFr99fy/9JXQ+wJf+EZQmEQKJ
	 oHkcza2mIEnyA6A9Tb9H547mG3KF3llabK3G1gGZx9+TFQko/E0nWH6qgnGTKFok4DaKM
	 w9zBHAMpaMx7P9UmCcsGqqlwqTkk8tOxJIjl9NfUdt/6wcwQCadLX2Q8fGSTV1AgSL4n/
	 c5GXLMfHnzcgqLYkvq9g8QUtFScWVw4lWzS0FRFu2eHP2QcigTOZ3YoJN52pWqqQYnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0YcfZtz;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B9606A326
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 147B9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0YcfZtz
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFELAw1392030
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RWDhYc
	96Mo5U+Ld7Dg4DmbCYC9ThBLzaTHcOjhlGf24=; b=n0YcfZtzrjCT3v3Fn6OMVE
	OCHbbb0S0E3SS5zpVRwV8o2SosZzmRnwq/7MSj86EP3w+XZgvgdRRST7ApmMpNSy
	MuKGDp2SoLPCrwWUmCsSudDA/84Z39fGTjZPxxKt/dkbmcoCATQODbHuk0JyqyWq
	LGyuw8GXIhf53UVpJKM3hij3a+uU0p/ClSGeepA9OOJmcdHc2sDp/scAyG4Xz3vq
	Kzczmml2ck+XFDoGa+fqOkfnDc1d9hQiNwIYl5fPs8vhtOWRTDzVl36wGdOa8tnf
	NtjVmFqTMxh/mY9B2b4KEdyqxRaUeIgE8hHu/xqz5r//h8WdDdX34ARJc6MN0BtA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkucwt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:33:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF4xrH3490872
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:33:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309neaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:33:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABHXCl444302602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 17:33:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7088920043;
	Wed, 11 Nov 2026 17:33:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13DA620040;
	Wed, 11 Nov 2026 17:33:12 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.87.86])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 11 Nov 2026 17:33:11 +0000 (GMT)
Date: Wed, 11 Nov 2026 18:33:09 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Allow hugepage migration for s390
Message-ID: <20261111183309.778780b3@thinkpad-T15>
In-Reply-To: <20261111182149.7ffa706b@thinkpad-T15>
References: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
	<acdfe7cd-1f50-4a10-b9cf-5a4318fd582e-agordeev@linux.ibm.com>
	<20261111182149.7ffa706b@thinkpad-T15>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af4a6dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=acJEtOqLSsA1G1aZ9aAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX+1wGdGGKpy+U
 RQdaZLkUANhUjAYpgB5qaugXUPsNVJNrG8nYnuuft7L5tizU3UDmCIhSW8TCpfeGJlkSsEEMHCU
 fMnhCOlLY4k5GUc5ckunGg0rGa8Fmm5UiWpbWPSOrHPpOrBIfK2NVQ6icDLZMuvhRr6hgTgQ3BD
 c0TiNTbI7h5goFJq+ucUWONPa+TZ4wV50kEEGWLquU57zJF5qeEyZRk7t875aG3Km4poDVRZ1Mz
 pL7Y+dxwzOr+58f/NWs0Qp0bBW3vaf6G0LJj/PTvcCNbSSVg4UL8boKmCWk/GEnUHTrmAEiaMl5
 JZaDhI6i8TKgktPBFv3aPtBNdIPFFb9qTUiRAUAGB3CpyZJgZqaxGRqZtpdN553xhKHGTy9yu/q
 MC4H2qEam1SBi1scg7XIhUrgF0t7dqVbgfVMZRGSJVrHjUOqSoSTeTHnWuKbNbH99f14nfPK1JK
 +hwFcscJUtRDLtYRANw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX4lMD9yXaia4U
 6p0OdVnqywMdhWCX7YUg4Ukrc526E9W4kL5YnVxkSiLiUeiJfOrb3ryeqLDqYlRbghNSwcEW61T
 EFxZHJwDaTBz8suSebCyi+1t6jD1u60=
X-Proofpoint-ORIG-GUID: jEIdRmDpBVFy1wzj0UnPIY1-Ve7YOyYA
X-Proofpoint-GUID: jEIdRmDpBVFy1wzj0UnPIY1-Ve7YOyYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110068

On Wed, 11 Nov 2026 18:21:49 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 11 Nov 2026 17:09:45 +0100
> Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> 
> [...]
> > > @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
> > >  
> > >  	return 0;
> > >  }
> > > +
> > > +bool __init arch_hugetlb_valid_size(unsigned long size)
> > > +{
> > > +	return __hugetlb_valid_size(size);
> > > +}
> > > +
> > > +#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> > 
> > Could you please use IS_ENABLED() instead?
> 
> Does the benefit mentioned in Documentation/process/coding-style.rst
> for usage "within code" also apply in such a case, i.e. not within
> code?
> 
> Or are there other benefits or coding style requirements? Just wondering,
> because I never saw that in such a case where a whole function is behind
> such an #ifdef.

Ah ok, there is of course some code in the function, and it is not (yet)
referencing symbols that will not exist if the condition is not met. So
I guess it also makes some sense here. Will send a v2.

> 
> > 
> > > +bool arch_hugetlb_migration_supported(struct hstate *h)
> > > +{
> > > +	return __hugetlb_valid_size(huge_page_size(h));
> > > +}
> > > +#endif
> > 
> > Otherwise, LGTM.
> > 
> > Thanks!
> 
> 

