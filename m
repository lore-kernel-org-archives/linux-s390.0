Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324DC22D78A;
	Thu, 20 Nov 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663604; cv=none; b=AfMMrwqtzXuFdI9HcS/nuqY1zcshv9vpWAueKiOqHQbHHdPSu7FF+klE6rAHf888kzSPmwbuvJuqUXZAr5ikfa6lsBCBUs0IS6rDwZrOX+JsVUkyETaW9fYgzDJotc+3d9kWVGIIoe2aUMq6TaHhumUWl9ou/EaCcrEtySAhf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663604; c=relaxed/simple;
	bh=bQqSVV4BitR/2XD42FX4Zm7+fbXLQHAlWABQIH8sWaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGKDz8RZufNwfrDeMMNjNeeoe9Jia39QBDcxdt3h6L7+NrleAbmX4AWb93L3Q0DJEIZHDQtwqPuUonNAw38DV8q3hEZbcCPXQuMCIAI/4sHTLfhJqAPG3bFJlGVC42ntjS1slZpTUgdhLTjl6PqtSd83OzFxzpD4jfAqHXgk9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GeToF1Nf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GeToF1Nf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKBbCGG002737;
	Thu, 20 Nov 2025 18:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5FxlbW
	z3Ai/W5cHY7ctPXgllG5oa/cNtnPWmVP6a2qU=; b=GeToF1NfyIPyO8VPBlqRPQ
	ohZ9G+0qCSvcRcQ6kBVPn171eGsprW41UKtblvFUNEpQ74KxeH0O76JDCgqlbl0l
	dqdJKDtTkIunjbhgE0u3iOKZ3c7WMS2gZyPLJRYlUwByMWUzv2rqzrLUx9BEtefz
	b5GeLP2K4YO/3dt5JQZw5GRSIgfhtJN3T+Nu/8pwx6p8MDUUCBn+86WDuc2dyZbO
	uBgV0+UNbnOYx8So7a/5kIZdfWjYKGl83LSVup0LGTZYRDYKj/5f8f9OVOuNWFri
	fiMqLirlwLbzIJoAYJXYd+Lu1V60cRkuTXZ/lNOxb8bygVLIkjreQGI6evFBOTyw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejju6k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 18:33:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKH2a32022370;
	Thu, 20 Nov 2025 18:33:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un80qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 18:33:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKIX6fd2753238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 18:33:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ECD358052;
	Thu, 20 Nov 2025 18:33:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB5358056;
	Thu, 20 Nov 2025 18:33:05 +0000 (GMT)
Received: from [9.61.249.93] (unknown [9.61.249.93])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Nov 2025 18:33:05 +0000 (GMT)
Message-ID: <557b0fdc-6f13-4676-90e4-062d8ff1bd66@linux.ibm.com>
Date: Thu, 20 Nov 2025 10:33:05 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] genirq: Change hwirq parameter to irq_hw_number_t
To: Tobias Schumacher <ts@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20251120-implement-msi-domain-v4-0-a01be58e158a@linux.ibm.com>
 <20251120-implement-msi-domain-v4-1-a01be58e158a@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20251120-implement-msi-domain-v4-1-a01be58e158a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dt-bp986jsieyot2ze5pd3vWPCmlYQt_
X-Proofpoint-ORIG-GUID: Dt-bp986jsieyot2ze5pd3vWPCmlYQt_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX6VPoEK0GU7Nd
 JWRDwQOk6Q3G9Vw7cqGuFC+rdRMBT+ikbnGLJKtYy55cOvxJGuaCTz515de2hciuT32uoc4xR94
 A3iX2Cv1cX+RaDswdvd26s0S5IKpymbJGLMmlYIKiGgHl1k7u+8Urd0Ijx+3aOqdPX9VX8g59Sx
 0mWNmYgD5POAkNqju3iRDEC1mTXnEeCZ9SFe3Oo2ytog4CSmv0726r2y64pMkRPu8WGXeZxdTKk
 INYsTKgrOvY6kLw79sDNfD5fIdjUydHO7IMvNcQSlVI0q2+IWcVaOUw3Lte0D5zCqyyqFyo0kO1
 ToDDLQFxiLXi3DzbLaODi3MAmv+9uXuK28I7TVdtOsgj/SzOvKWDbQsAt34TQnFhAujUR6eqBhU
 d0ebpn4ZbMDqELhEpztfPHzt+Yg91w==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691f5ee4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=a5bBmSbS2bHyvMdTAZoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032


On 11/20/2025 2:27 AM, Tobias Schumacher wrote:
> The irqdomain implementation internally represents hardware IRQs as
> irq_hw_number_t, which is defined as unsigned long int. When providing
> an irq_hw_number_t to the generic_handle_domain() functions that expect
> and unsigned int hwirq, this can lead to a loss of information. Change
> the hwirq parameter to irq_hw_number_t to support the full range of
> hwirqs.
>
> Reviewed-by: Thomas Gleixner<tglx@linutronix.de>
> Reviewed-by: Niklas Schnelle<schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher<ts@linux.ibm.com>
> ---
>   include/linux/irqdesc.h | 6 +++---
>   kernel/irq/irqdesc.c    | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>


