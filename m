Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DC3B4EBB;
	Thu, 17 Sep 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667530; cv=none; b=NFyct5Ipe2QrG6Kcm8Ad+us5V4lip2qdY5wBVFJK9tnnlh2eb0w7Q2FjuLIjeasdpCSzvAPQohT6WoCmvzcZzo7HfF803VVFhjYRN395q67qHswUqMFznIdE7bl5cBojuWD3gnmt4bARziv6g1rOM0IuIBeQeU0DdqPatGVFeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667530; c=relaxed/simple;
	bh=XlD58mLQ7SRLIA4Uj0KtOJmgnS8lNiZHzv/KIhC1hcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHg2lPhfll5SDmUBENyYyvPJD3etfrkyA/wHvf0RbHHcVvIlV6uq3KiLMAGtSgIaSgJzllxEZuFDVcEMuzdQp3o9K4lp3FlA3w2ME2/N1Kq+CbFCb8ag82UdBRlY7s26nNiiGsfK2/j8yOobFloBIOftbwDmynQUKLCm+kfWWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z1vCAfUo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z1vCAfUo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVTIs1271881;
	Thu, 17 Sep 2026 17:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2NF6ri
	gA+4U9F9vXIVxkw/1K+XoJ6n7gjslzq12OkUE=; b=Z1vCAfUo3S4lXvamEfPBI7
	+8Uv9pUNfmXmKRrfxCPqhTm6rj4VtneEOA+JhMXl0U10eRQtob/fJKlmwvPns4NB
	X7jQlnVB9VMuoO+DanoazAUMN3CV2H6lbVyjF/BOpF65trecAa1VK8hbQZjg7oVZ
	zrWMfVFDss2I8YTaVDneaoAOFvyYPHD0uklXumqBsJo41+noHAkY+ZCCBWQ2V3Ic
	fRazEx34MrtUWW2KHwlj3WHWy2ZrzYToPZ7vDXeeaSi5qPQslrqgq5UK85Hrayty
	oMA3TeVoxg6uLgLAg2xJJ0c+RSqzqWoAUN8mdKNOn2Z3OBL5HNhNVMS2oBjV3XjQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqkxkh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:52:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH91hT3546850;
	Thu, 17 Sep 2026 17:52:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffbm0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:52:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HHq5K256492468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 17:52:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9DC958059;
	Thu, 17 Sep 2026 17:52:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15AA858043;
	Thu, 17 Sep 2026 17:52:04 +0000 (GMT)
Received: from [9.61.246.38] (unknown [9.61.246.38])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 17:52:03 +0000 (GMT)
Message-ID: <55d0fe12-64c9-47bc-ae40-73ea773a5a06@linux.ibm.com>
Date: Thu, 17 Sep 2026 10:52:03 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] s390/pci: Fix missing device lock in
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
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
 <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-2-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfXzVa25HKCeibk
 FekiRGqGYbInVT82LYZGQy0Uym/HibxQIw4edI8Tyx06t9GlumSy1vl3DnHuEv+IDdoiKrpeWrI
 BR3rCknoLrshBN3WYGvTpyek+2DgMQkk0byLqYX576bEMHWxzrcqFgX3isz4ixHa0O2R/TUc/UW
 7sCAEWhzYl9GS9f7Y1VaKH+pl41TVGV7fvTazXEOU6WaSA6ZW0qofIXLz/PtBe4HcsQFiDQToJK
 J44FH7cYDaZQinEUzBHIaq3b4TiAymAcC5zko5AuDkmgPAxDoBQjbvTuEsLbZCO9T8incOJmYUY
 gPSeOGiiKckTyRt6RYnJC6WVzlVlsrKcJW9gJppaiZX4nJm7CFm0NGYd22wyGzcIGZJowBpzbR9
 0UESOyc8IQn/VfXfZrMFYJwtJwLs1lZ4/xOvqEy08x6GE2e0ZD3h0tzwNTEE5h725jPgO/6kDII
 pcQrbh7WsHFUgIrwgnA==
X-Proofpoint-GUID: T8KxEdkH9GPucIsfJYY5XhoiNJeMV2dX
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aac28c8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sCmUU2f1jfVtFHSl52YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T8KxEdkH9GPucIsfJYY5XhoiNJeMV2dX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfXyuV0Xt2ypQlH
 DwyZQZsJ2JUkn7XrAv36wAD3CT85lSrbqNPKsnT3vnya74B6wjPX/ioXeh821hJPxqXdT7PEGn/
 i7Lp092+BAtstR+ge8Yciqye6jeIOGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170250


On 9/16/2026 8:14 AM, Niklas Schnelle wrote:
> When pdev is non-NULL, zpci_report_status() accesses the device's driver.
> To get a consistent state matching the recovery, the device lock needs to
> be held. Do so by expanding the existing device lock critical section.
>
> The lock only needs to be held when the pdev is non-NULL, so extract
> the pdev-specific reporting into a helper function which also adds a
> lockdep assertion to detect calls without the device lock held.
>
> Cc:stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_event.c  |  2 +-
>   arch/s390/pci/pci_report.c | 21 +++++++++++++++------
>   2 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


