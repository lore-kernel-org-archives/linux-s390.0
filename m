Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70A316199;
	Sun, 23 Aug 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518817; cv=none; b=B5VePH5qIgrOeeVr540cClrVFIvrlXmZhMkaGsZ+b9Q1JwopRhVXtr60+Nn3V+w5EuriQXpx+GJkqdasQCyoMZ5P16B0RuBc6uv6a++D1qiyMG9QSIUwWE6mJKWp5Wmko9h5X98en8rkb7wa11UHecYzo2JSGZCMDK2g0z9sACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518817; c=relaxed/simple;
	bh=ysMoG29JCPi1nmoksp4T3E43Igk79V0BoY9qy6/CGPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO7TYUa7RCNKorDABIdFOEksHGFKlpYmVIP6XTV898kE+aU2bI3W46rUoBZPJdQYYabSZgghO6j+qYCFvWF26kqujTDueobZH1lVAWtboc/OZcQF9zIsQXkofd7IVIjZswujr8RcxnhgEdFfYx/+CdLFeNaL2Ma6+82QTJmxXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DIcYhG9l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DIcYhG9l"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67NGVb7h3639796;
	Sun, 23 Aug 2026 21:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Fhueq7hOTtM/kKTRgb6Fa9HDq9KCBT
	a8qnLiH7HOvNU=; b=DIcYhG9lvjmYVvY0ARtPXtseSHpils/hWlvydEanls9saK
	ABk52k7VcnC/O9obTWlykhLNiBZtiPdb7FIdFqAIlF4jKfUryeXz/n2toNQYufa6
	wreg2M5mAlRFQm3YxRT/CQq1cbLg3JKg2V1F8c7+4i4bwKdiF22UshR1f5Xkco2A
	MAYpq4jEk81dpxZbfrRPo5SseQNc/Nwt6I5kpOjkqCVnD8p0Ka1sTX5cjeppD0a7
	GgVpSGJxxMstSqVEhzLywR/GMkIpCvFxx/Hg21G2pkRJtJQrBQJNBf/LJfmCMObK
	+zf1SdYXLJMMctzoD+N51ChqCubB8RgMI5bRfPoQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwwmfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:00:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67NKuPtH022182;
	Sun, 23 Aug 2026 21:00:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag2ecw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Aug 2026 21:00:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67NL0AkD10551590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Aug 2026 21:00:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0995F2004B;
	Sun, 23 Aug 2026 21:00:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F7720040;
	Sun, 23 Aug 2026 21:00:09 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 23 Aug 2026 21:00:09 +0000 (GMT)
Date: Sun, 23 Aug 2026 23:00:08 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/pci: Fix leak of uninitialized kernel data in
 SCLP report
Message-ID: <ttk8qc8@ub.hpns>
References: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-fix_pci_sclp_length_check-v2-1-9ee9428e659f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE4OCBTYWx0ZWRfXxydgLSsDAcvl
 hWZ5CYdZ4upt7Dgg30UNmF3ryWKliWCC/HVqqhHBE8OlDnF+iaMs5oB73iFq19eWzXhl54fYRsJ
 g+VzfSFw2O08NN66BtKxklpdi6R9nos=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8b5f5e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WzAXfNBGZ1IBalv5aagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EvI9RpZ9sTXy-lmUiOBoOhRZm6tPrd_F
X-Proofpoint-GUID: EvI9RpZ9sTXy-lmUiOBoOhRZm6tPrd_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE4OCBTYWx0ZWRfXx/P3vK+3EIzK
 5ei3SjFUpl3wUbYJUZ6xfyL4qD4x7/CpDhOMtbHPf+gayWyAhmCjCXJ321mZngVRhurF/lcfyLr
 Y6Yk7wdJG5EqTpvpjdsj2wcDAcha2R0sFZ1NYkXJqOZa6cRcRu3DiHehQ5OHNzT8mhkZxMyEfu1
 k20t8g2zpi7Cy3ezUnzUGMetgHxbom+RoIxPNPmGGb16XYgjrKCvlwf4M3wHbobBIMkbMAmu/gn
 IA9RWZidNG39hxRPSTdUWRR7SA0CpIK/zanxJSkzOxUDrtEWv7grl3sT5wJ1b1Va2SQmBkK4IzJ
 ovaLzM6ol1PoXTVv6VUI77t8eJQ92xUY+B79tpowp4ocwrxoIiX6Qye0xgXiZUoODDOoBrNbpwI
 u9iR6sdIi72kxVWlT6oh9IZUn9+JslXY8k1qtJo5OtDKNebxZstES6jwjHILS4oX99AvgcHvyTc
 5Jhho9NnLwTz+Kwy2lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230188

On Thu, Aug 06, 2026 at 11:43:39AM +0200, Niklas Schnelle wrote:
> While report_error_write() checks that the provided buffer is at least
> as large as the header struct, but not that it is large enough to
> contain the report with the length claimed by report->length. If
> user-space provides a short buffer, meaning a larger report->length than
> the actually written payload, up to around 4K of kernel data from past
> the kmalloc(len + 1) sized buffer allocated in kernfs_fop_write_iter()
> will leak into the SCLP report.
> 
> However, as the entity processing the SCLP is privileged and able to
> access at least the page including the report, this does not leak data
> that entity could not access but it is still an out of bounds read and
> a malformed error report that should be rejected.
> 
> Fixes: 368704a65be8 ("s390/pci: add report_error attribute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Changes in v2:
> - Changed subsystem prefix to s390/pci
> - Added Fixes tag and Cc stable
> - Improved commit message
> - Link to v1: https://lore.kernel.org/r/20260805-fix_pci_sclp_length_check-v1-1-d125cb415bc3@linux.ibm.com
> ---
>  arch/s390/pci/pci_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thank you!
