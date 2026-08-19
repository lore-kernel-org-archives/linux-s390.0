Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B504306779;
	Wed, 19 Aug 2026 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787175026; cv=none; b=SOzYpN0C9m6pEOLx3DGDkC0cap+Wwk3bqJ21LET5r8aVqyT8U4UTkpKCHMDzG/7jjKqJf9purvHun+wd7xdpnG0tMWMvNGNwyxW8ZEQN5YEGtJ86vnBjf7qO4Y2grEpfqma2weUD+n4V1yZkulWQtxbVNKmAVP3SAnYIv4gLkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787175026; c=relaxed/simple;
	bh=Jh+HdtL7skpgi+alYWJ5zQIUz4Hp4L47BgHV0bYJcdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rfq7hKlXMtlK9rec7REQ9wKvSiksydKnrw7/GnkPmCaXgig6BXyWWCtqFrV2MUrNVshW7P2fcufsNHLRQrvLD6SUvIDY8Gw82oMUi0MZht1bDIECjV5jM1UeGqLHWTSZ85sNI9/eWBoIjRJPM5JFQI/T8RG3rrhfIrFL0aK+1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mLjD/qBy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mLjD/qBy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JI1gXq3087376;
	Wed, 19 Aug 2026 21:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Svbu+Y
	5bEzK1Yn2/TBFoeIt6yJ1rLLCrn1bSQdbkqUI=; b=mLjD/qByausjzof46IiX8r
	O1Zkj4XPSfTB2AJKIjNIFFw41S9QXI7FJKBWNpcxkg8PrnHO5BgpHgyuD3K6Dlpq
	0xmdF4ifEM9W4iEWO6LDA6ZTIwYSgybDgk+MZuqfJAHbluzDwMtBaJbqHwG9wk7B
	QeG8Ms9pXKFYkEAbwv4K0zDNV0UNxF47J1QfdROquANBOV/VBHvWnZR6j0vPozSw
	aSsZWmoDMrdKc+NViwd9KZootAtj+QeYDKjmgLwYOqBMUtLPSzl5jpJtUpmqV+4Y
	r4iO8d+0peRbjwIxuHPN/yLuEbcSl1hClIYTOv+O9aHyT6b8CLHLhMK9nghZGPVg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu266kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 21:30:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JLQJtl012206;
	Wed, 19 Aug 2026 21:30:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yjr6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 21:30:23 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JLULxQ4915818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 21:30:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB68258052;
	Wed, 19 Aug 2026 21:30:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A156B5806D;
	Wed, 19 Aug 2026 21:30:20 +0000 (GMT)
Received: from [9.61.242.204] (unknown [9.61.242.204])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 21:30:20 +0000 (GMT)
Message-ID: <2d699043-d415-4ba5-907f-393ba481ba20@linux.ibm.com>
Date: Wed, 19 Aug 2026 14:30:18 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
 <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a862070 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1Lu78BW-BsQnypBMslMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OufyXLFBSsyPpjkj5pH_wVo_XIayCKyk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE2MiBTYWx0ZWRfX0NmyigtabJRY
 aINJU2kRDrhmzCwcVB8O2NBBdi6uMT38VqVGKRhr5gsIhftIKyg0oHZ9lk8KtPAy4qgHjBpDqwS
 pZMj4jDZevhceDR/K6tZRyQXFbUvb+FJMT6lBEbZtSD0dpF4R7puGQ02G/hZwt2ojmqX2Wq3Pxs
 wrbAEtU1HImHf8BGTDrCaVaGChGThGhF5r3TMEBJI2z8bnopVhsWNKEjD7IxPTNoYyn+NQHtNOk
 HgQvgt6BUu7JGbUlT7FqdGErdSvWIpNUWX4oGm1AmeTXfo9UZYNyYrPucWVbtVdQZp9oTSg1iZ5
 gosWKk85QSvKkvtLwIWvYCm951JosITKX4rhjJM2PFnVSRxBFS6AC+o6lcMtOSDsfLWeOEycSId
 VzDOhF+rt9ePI+AFM3i1wyLQ4OxRSm1m8CgW2afBL6kitqOIhY74v/XKMGvFIgoVcYbfQLXD/z/
 8YbWQksaz/+folx57AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE2MiBTYWx0ZWRfX4/OkORVpHlaf
 HQ3jOE3TCuE3Puz0A7s3xwDpmPEwG3M2o4A3u7CpLmUdsxNw8EsUGBv3oSVsalAh1TBNkiEPXQp
 ZDeMWZYHmYhb1MKnqcBY538ZtmE7K48=
X-Proofpoint-ORIG-GUID: OufyXLFBSsyPpjkj5pH_wVo_XIayCKyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190162


On 8/19/2026 2:58 AM, Niklas Schnelle wrote:
> As zpci_report_status() accesses the device's driver the device lock
> needs to be held. Extend the critical section to cover the
> zpci_report_status() call.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_event.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 839bd91c056e..48c150d6ba81 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -256,8 +256,8 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
>   		driver->err_handler->resume(pdev);
>   	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
>   out_unlock:
> -	device_unlock(&pdev->dev);
>   	zpci_report_status(zdev, "recovery", status_str);
> +	device_unlock(&pdev->dev);
>   
>   	return ers_res;
>   }

AFAICT this change is correct, but should we also add a lockdep_assert 
in zpci_report_status()? Since this is the only placed its called, it 
maybe fine as is. I just fear that we could miss on getting the lock if 
we were to re-use zpci_report_status().

Either way
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Thanks

Farhan


