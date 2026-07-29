Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A384756AD;
	Wed, 29 Jul 2026 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324524; cv=none; b=fL0iscp90n1o5yB7TAthJicIjSYLOW4G9Oo5QKicdSYvPaGf50usnpKx5EfzhSQqcIhXtbjDC3TR56438vyfh09YXHsQ2cNxfEJJXkbzBYvht950h0lWC3r/yh4M9Jj3E9bFtMMwTdQ50vLlMwflGww/OkgZqgPQGlARul08Tlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324524; c=relaxed/simple;
	bh=Ka/E6I3oHla30iL39M0h2RsWCF72R3hfTPwz3xjYdpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucf1GvSBYNfytFuoHrNPEsuOnnbuviIkw3WvNlumKoeqU5vRkuRYNjTFI6iIGTEYNiKKJXS1z8NxmBubtTHx+HCIQg5gABbJR2R6kE1FmHaoTOoF3J/MXb3VS8tuVa3eZyiGu6arr1FkjIGU1WJ+1PHKMTiGX1rAoxc44wEwk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nNBCwbSH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nNBCwbSH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHr7r4076028;
	Wed, 29 Jul 2026 11:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=me4Xq5Dl+9+TMxCMS3OD+y6QfUtAco
	9IUQC27K7jgmI=; b=nNBCwbSHyvTmNdbJgzFhLmERgmn0cPyGFtOm5zq1MXqtYy
	1uuDNsBXhly7rF+hLlYLlu5tglV6jCpebuthdBOjY9kNR16IIWtpDyzaTg34kOE/
	HUoRdUWuIj4UFwo+DbvGr/oIbvsGtgOJ3v6vsw0+57AxTriXhsxOGJcCOg2kDJHe
	sRu2R3xw0d/IR+4yh409Kb/VKPY/3H+Hnxl4Ghehtl5YZo1R3G636bv3aK0v6owl
	XlEYzPYF6VgxF6IcCqEZEGQiJKnWcmB4srWHzRv+lFnVljR+Y8M7wvSPg+X3iL7r
	ZBMs/kNbjMlEPX604Bl9QFQOiS837sgjzDh5ZCqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd1mep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:28:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TBQNio012329;
	Wed, 29 Jul 2026 11:28:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pge90h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 11:28:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TBSagI30343566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 11:28:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F792004B;
	Wed, 29 Jul 2026 11:28:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B619320040;
	Wed, 29 Jul 2026 11:28:35 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 11:28:35 +0000 (GMT)
Date: Wed, 29 Jul 2026 13:28:34 +0200
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
        Andreas Krebbel <krebbel@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: Allow SCLP Action Qualifiers for Spyre card
 status reporting
Message-ID: <ttixp7m@ub.hpns>
References: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724-sclp_allow_aqs_spyre-v1-1-569acfe11385@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kI8aUJXOt65vp1XmCqBRfz84A-R3bzHh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX1fhz0Tpq9l16
 ZTcqrPfDo0Oqa3Ll+7WHIbPMSczUGq4ZXNIQGC56d6XOcUg1xfEpXVXA2oLQ5Ptna6jHRpnJQio
 k84ygsD3a9Jh5zWo79TuGDDMw8YSAYA=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a69e3e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=WXM7Mg6N9Ua0yesLb2EA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX+xWN/HDe+B4V
 TL8Q0/WXaKhv8fhOLHYmmQz3P1uVxHbr0un+8kIEszVQuMi9qywEPZtDBxJtOQPODyCUPCebVvu
 YRQdxzuz1gIT3Ya84KeJ0qOtxG7KiKJDyHwICaNhxtel191s3NQSiohnUF8YxiGryoSd5mJ3ac9
 UMF+f/XCrt0O427+ss2o0hdyKBeK1giE9WGuUkGnvElb7S5wLNSoDn8SJZZSF+JnHi70SI9j6tL
 T/zpixXDLwo/JzP87F6EyeNgTyxu/9OaNSq8Usz/bAM23CYQWeQWLb8QP2nuwmtQkaxRwPPmIZ2
 2xoCkdejdpOsyOMaKib5AGbvjQQ2cnnqoBOf64HkoLTiEO/f9z43ZXo+I6zOdSSuAjLewFJPPRw
 vlFbhZAQbwq7Wh3kRRLGNZyJTsED6FPnJYa/DRn87CCboXCEsikljEr8uTjOFJkGNTBc5pnHn4B
 VbKmaWm81oxcip9gFCA==
X-Proofpoint-GUID: kI8aUJXOt65vp1XmCqBRfz84A-R3bzHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290093

On Fri, Jul 24, 2026 at 02:23:01PM +0200, Niklas Schnelle wrote:
> Add SCLP Action Qualifiers used by the Spyre stack for reporting of the
> card's initialization status, recoverable errors, and telemetry data.
> 
> Co-developed-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Andreas Krebbel <krebbel@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/s390/include/asm/sclp.h | 3 +++
>  drivers/s390/char/sclp_pci.c | 3 +++
>  2 files changed, 6 insertions(+)

Applied, thank you!
