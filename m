Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9627377ECF;
	Mon, 24 Aug 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605718; cv=none; b=XflTbJY+2xIW+FNbuzmBbVR/fhOs1NMsKiSDIA9V9W0rKum/HYODg+rYxYtXoA6XpHl4BILhbI2SBwi412f51A3EXxaPF1t1UsqNvU6aRALd8jm25d7lGh5FKgVLxxjbIPGaNnUmLKd62rVaZxS5sugeXahW1qKrNGXDnq54b8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605718; c=relaxed/simple;
	bh=BWol0kkqvoCBhcyS1Fni6yrG+S8arl7oTGCBbfnvrIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmjRewxUnJYGwpeG5mczTiZbIQbPu/QDJ6TXSVhJ8XuCcKfeQo7Arm1dBlI55nDXpELzevV/KS9+o84fmhL8wuPm7NGEqSPWLCa6jHt4320B2sTB8hqKyNmLgjnCm2iM4yVi9VpQsmWL0p93DpJn2h2cpUA7IpH0Sx7gmmnBzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhxVDjY2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhxVDjY2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVWan2858005;
	Mon, 24 Aug 2026 21:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZqUgNT
	hCWN4UWJUXglLRLs79vZFtmHWoViSJBNLMZhw=; b=fhxVDjY2QbNM56mZRTgr9c
	gymWLpTVzjNPv7DIGs0LTO1aiztfSUBDJmzsT5m+rcwVgyDuWPHKlUnik3FRlRXa
	8ijEeW5NRL44IU3wtKY1FWnqi/dhq8q4zPqIThC4xPnVMpbWB4NSlSs+JrDomGFC
	/aDzxXOzobKgZJhXVWGJNQOgjqOosQpcxBKae+S1inDvB5g87eb7JEifwEMjFZGd
	74RPEUHKXFvhx90hBbtZaX+y29MFQQX+mrDRVOVtr9cCIH+Ghom46C14D4G/+iS/
	RIKw8d8tc+PWEx7/BRmJ3k5kdL06b5QBKw7nWrBo4toM5LmcauMHtndjG/tAthDw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4m7yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:08:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKuGTe010880;
	Mon, 24 Aug 2026 21:08:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy09ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:08:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OL8Was29753934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:08:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D619C5805C;
	Mon, 24 Aug 2026 21:08:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29FB75805A;
	Mon, 24 Aug 2026 21:08:32 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:08:32 +0000 (GMT)
Message-ID: <f2a050d7-e964-4472-8b4e-cd1df574a099@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:08:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size
 in vfio_ap_mdev_cfg_add()
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-5-akrowiak@linux.ibm.com>
 <20260824141119.9C19C1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260824141119.9C19C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9nDqMdvmqvfo27ZiCgILwlb7toCo88bt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfXzVQsZ40W1eis
 CCujVXN4EZY+nPgzrZ4pc7tBppcwDqJAk3XVM4u3BxksLOtMhHlp5HGtPxPl8S/umNtdCLt+ovZ
 g0UMDkImcvkbthRRj6723SiKMq6Vj88=
X-Proofpoint-GUID: 9nDqMdvmqvfo27ZiCgILwlb7toCo88bt
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8cb2d3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=F5A-pXNOIzfVKz90SG4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfXw+SRQdg/hvFu
 cSc2gbT2xgSVni05cCZ4fu935E+gYUfGxAS5TGbZsz1uNhFYplk+Z2Qz9LmEMgxgUS/z1VmMcwP
 2knfnKH0wDFxtr3ZSnBHGsImBsmYHonjJRPjGDBAT2APaG+y5gYz0+7sxrT+pP+1gcRrRGq/fX/
 xcZkYa7VMmxz3EwMyh2wgoJXftaJFKiBkQxUm8BQ96ADSA+duv8SmIZaPkF/3wuO08N1aDCPrL1
 qLqlnXgu2FWhG4EslMNe2wQBRmzi9mGX/Pxwd86xXWymj7NkaoMWPN9CBMrF2ywLLucKbuGaFys
 xwzYwEiZ4OP/3Gl6koe2tiiHMEBOyXJUJpJEybv/AyGzLQ0E4ISMWFsrl1H6z0/k1xW3Ufv9AYk
 H5NNgzBYPrCt3o3bYnC7KCh+xwacTqhza2Ab1VVXRI5VPZSs5G9IQMOqALVebsZqdv1NfRQDnen
 fwvAzJr/EAVNphdn1Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240178



On 8/24/26 10:11 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete Fix / Latent Stack Buffer Overflow due to Inconsistent Constant Usage
> --
>
> --- Patch [4]: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add() ---
> commit 35cf2442d556c90b8b97a43b8f409fe51d21bae0
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
>
> This commit changes the bitmap size constant from AP_DEVICES to AP_DOMAINS
> in vfio_ap_mdev_cfg_add() for the adm_add bitmap. The change prevents future
> issues if the constants' values ever diverge.
>
>>      Control domains are indexed by AP queue index (APQI) and their
>>      bitmaps are sized by AP_DOMAINS, not AP_DEVICES. The two
>>      constants are both 256 today so there is no functional impact,
>>      but the wrong constant is inconsistent with the two bitmap_and()
>>      calls immediately above it and with every other operation on
>>      adm/aqm bitmaps in the file, all of which correctly use
>>      AP_DOMAINS.
> [Severity: High]
> This is a pre-existing issue, but does every other operation correctly use
> AP_DOMAINS?
>
> Looking at vfio_ap_mdev_on_cfg_remove(), it appears AP_DEVICES is still used
> for domain masks sized by AP_DOMAINS:
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_on_cfg_remove() {
> ...
> 	do_remove |= bitmap_andnot(aqrem,
> 				   (unsigned long *)prev_config_info->aqm,
> 				   (unsigned long *)cur_config_info->aqm,
> 				   AP_DEVICES);
> 	do_remove |= bitmap_andnot(cdrem,
> 				   (unsigned long *)prev_config_info->adm,
> 				   (unsigned long *)cur_config_info->adm,
> 				   AP_DEVICES);
> ...
> }
>
> Similarly, in vfio_ap_mdev_hot_unplug_domain():
>
> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_domain() {
> ...
> 	DECLARE_BITMAP(apqis, AP_DOMAINS);
>
> 	bitmap_zero(apqis, AP_DEVICES);
> ...
> }
>
> If the constants AP_DEVICES and AP_DOMAINS ever diverge, could these
> operations cause out-of-bounds stack memory accesses?

Yes, those all need to be changed to use AP_DOMAINS

>

