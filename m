Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965183DDAF6;
	Thu, 17 Sep 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667467; cv=none; b=ovVUOrBeWAUkSTHbz3nQE625o9+SPVvhF4PAh1isjb8MTeQGUZ2D6KTdRSzMoGAlmxGB7gaNr2iuqo5DMDexiQ5pKA4Mjgg9KnnC+yOOdpKgLJDIFRlhkqqG4nhXUoUvKNNNWIblbsj9Nuj932NSHXrnZwpVWIbsjthtai/BN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667467; c=relaxed/simple;
	bh=rO1Ik4p5OqNrKi9+t040GMoT8/Wmm3FTFu6OtLw5xGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1FLut8t1tYWV96Gh+j3lKwpHZmTWXhN//6QQhGnLWJXTnei+icRWXVfqI3IBakGmc77ZKrRRM2K5Z2gcJjZnSF3jYceNG1RtZUBhfZEjBdVzgV8cZrC1lvFkqwmBDRC5kRHrgMU0nhykUMEnJfzAjjG9S0lG+EIpJMnc2lk2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LMA6JBWP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LMA6JBWP"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVXun1980278;
	Thu, 17 Sep 2026 17:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UGvFvv
	QOM4sRf57C29rkYRpFpFt4RjaCHQN5iT8PtVw=; b=LMA6JBWPOXTYwbLR6/5qbw
	uJG5bkmnwwhVLh4CwstZ0L0qjjVy9vHg/N2T3LobxtK63xMibbNEmZlGsJsMDUh2
	hy8koJLmA0BakWl7VffGSHz9IGCD9VIJWj3aTJtBUcQ8zaIdzANIeK/PGU3OfRuV
	S7NOelbOeo4DZsBV2UGOVKL9Gim2qoY1j3tjE1duDSJoDTJNVHqUXb+ws0A1oKk8
	sw6kYdiv+IrlsiFeiCdcH/XJqz4ppUZaiS1+IRzlRrxX6za2CrSYDqzLack8PF5C
	xhp1lUvrttT9jjHOH/b5BtwTWQs6a+u+zCA1QCxS4kYMZNni+Wvufx7qKGSGv60w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ebgve-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:51:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH95lO3510163;
	Thu, 17 Sep 2026 17:51:03 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa3gu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 17:51:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HHp29F19333856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 17:51:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1185805D;
	Thu, 17 Sep 2026 17:51:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C424858043;
	Thu, 17 Sep 2026 17:51:00 +0000 (GMT)
Received: from [9.61.246.38] (unknown [9.61.246.38])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 17:51:00 +0000 (GMT)
Message-ID: <0a7b4087-3c9a-4e2a-8c80-2709790b3812@linux.ibm.com>
Date: Thu, 17 Sep 2026 10:51:00 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] s390/pci: Fix leak of struct pci_dev reference in
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
 <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-1-61a2f980e71d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX6tOBfg5Wx1yU
 7yffwaLQ+GLRJyTBaI/mg3IkWpUMgaXikYONdn9e5Cf1WK5+YsJEJFNhg8fhsvgezrKGKYsSfCB
 soXGv62npsQB7vbYRVw5/gDn+agE7ytLDIs2ivp8S36GNcJ2jrkdFCK1L9Egz5+w3fmvzeOjQUg
 AIU/omRH5yU2zg6KlzTQyOJLWdEsY5Gy6bH67AyMJLsV28JEpEQcR0rJ7Sgm+3FkNLLjygNTriP
 XPDEszXpYTFNXMLHVNATsQO1qr8/9qk3sQ3E05UtImMxeUGT0SxCrOtgXLQzsPdhmiAAI+mEyB2
 /D+DO522fwkTr44yU6fr3bMMpU+uA68P3zC5c8s+Ql0jv3w2J9Qcsf83MNvAJ4O8YH7CEYHoPHO
 ryjnXLMWNOxOw3GiXcgu1d5QXr11B+garC3jhOryc3MclPODQCL8BacSfxUA93Y4s4jjRFEj88k
 pDIYUL1bsdsKZDnA2ag==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aac2888 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=_3ZQhW_Asnu8ubVhLK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OxRgtGUZZlGRyhyTmGFHQtFy4TeMC68S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX2OHrVj2A4STb
 cmAqOwYwnh5AfjBqaH6M3kZsARmbXzqHlbDHOBeULSOcPeR+buJXteu/mJm1aQM+rKFxrg7yLiq
 pxPqTwctSJnJfHHDDe8g/EX6h3GwxeM=
X-Proofpoint-GUID: OxRgtGUZZlGRyhyTmGFHQtFy4TeMC68S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170250


On 9/16/2026 8:14 AM, Niklas Schnelle wrote:
> In zpci_report_status(), a reference to the pdev associated with the
> zdev being reported about is acquired using pci_get_slot(). This
> reference needs to be dropped with pci_dev_put(), but this call is
> missing, thus leaking the reference. On subsequent hot unplug, this will
> cause the struct pci_dev to not be released, leaking memory and
> preventing reattach.
>
> At the same time, the only existing caller already holds a pdev
> reference. So instead of reacquiring and then dropping another reference,
> simply pass the existing pdev pointer to zpci_report_status(). This gets
> rid of the need for pci_get_slot() as well as the zdev->zbus check.
>
> Cc:stable@vger.kernel.org
> Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
>   arch/s390/pci/pci_event.c  |  2 +-
>   arch/s390/pci/pci_report.c | 11 +++++------
>   arch/s390/pci/pci_report.h |  4 +++-
>   3 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


