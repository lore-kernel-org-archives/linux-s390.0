Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56312BEFFD;
	Thu,  6 Aug 2026 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021762; cv=none; b=AOKYXxnnYEajEeYQTF0VR8IFhDaQI2LVfi2KXzs44GXFlRsqD/CGot99IoBkZ2O0AV/3uZYaPh/QzADAUwyeBiqVfHyDy3OqQ451gJiNEtEhRaD6g5mvZANGGN7NOB1wWdeOFP3juxyoGw3eoORs6WcmiV2BJw3KXwutx5a9/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021762; c=relaxed/simple;
	bh=1zD3/psbF7azCCj46B2fW7e/srSl8SY13vaYTiO76uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCQVs9vyjUGlCKsRDTRMQAfbVS3/+JwzFRf42W6etCThJHg+YdMvoi7L7M5gLTEUibrdQXEN9u+oBEywxlUTQGzjMNVBqom6yEXMYoF+LUKu0/IkFkns3fjZge0HI3hyba+gmYhAZme1PwVXuK7hdoaX+ZG7O7WLH3et9yGhq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gN0ps6j/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gN0ps6j/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nlgkr993067;
	Thu, 6 Aug 2026 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rtGYn0
	/u1VFGdi2N0WA5Ry7fGTrpuaZB/L5YrmAXZig=; b=gN0ps6j/+1XbQBNibBIhUP
	DwWlGVfQgOhClDRLmXfXxxrWTB71wT1eVNaYIKI8dW9+6HKsiJVXQnnu/oFhubOH
	gI1mTr46DOHVJhHZ5wc3vr5lJk9IVJBxq6RioeM7v2pFZPVLTB+rTwY66gOVSFUI
	BzUHyKpkBP7VnJBznuHGamFCcrHycEVpXj6mMXlLdsf8zT0IMTv5Zw+u8qu8lHrM
	zalXv8Kqm8aoKs5mCizZFWxo9GU8KtVUGxeaJq2Sgfy93+MeRX5Y4zlEjpM220em
	GhkRCoub7oE0P+fEbOiKs0YwZwFzMef0J3hswYi1JnfPVj0vSAw2yAdyLHrUeRNw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gfu2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:09:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuL2Z022039;
	Thu, 6 Aug 2026 13:09:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhk5xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:09:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676D9EWk26608252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:09:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6ED12004B;
	Thu,  6 Aug 2026 13:09:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADC4020043;
	Thu,  6 Aug 2026 13:09:13 +0000 (GMT)
Received: from [9.111.83.204] (unknown [9.111.83.204])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:09:13 +0000 (GMT)
Message-ID: <6ecb4cb8-b138-4fa8-b8d2-32cc1224460e@linux.ibm.com>
Date: Thu, 6 Aug 2026 15:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390/block: Enable CONTEXT_ANALYSIS
To: Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Jan_H=C3=B6ppner?= <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
References: <20260806130050.2057443-1-hca@linux.ibm.com>
Content-Language: en-US
From: Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20260806130050.2057443-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX2Wi1xi/FRwAj
 jpdxX13flKZK7HHhDiEskND3BMwvQe8f576a5uzHbODYW/l/6U4VNrWm/lNDusRewHgA1mEeueR
 vAondWb7f6gY3CeKYKSXqzcA2jPi766H3/PIAqMw/SqJgA5pGYHAECxjTNbFaw2hsdfV1K0r0Qn
 PJSpu5nq8FK1AK+iHw0aO+RzRbiY7sgudE13wdsO4NS06x0IFUSRUGko7QC7opbRYcSnKiThS9y
 MwWiaZFY99scPfGmpZU86zhZmoWx0TfijPSwkd8uCNBnuXcfm4yFkwm7SjJ2nYD6VzIMiwuHNhA
 IXfqMjhcOmFhFn99y0TGxDlphJTlBBAO6kmEtAuX6mWUCGzc2bz6GBZq1qO6JwiuxXK4v1xvOKC
 i2gvlvWHfqtaK25u1OKmVFQNg1YGp5B7dJAlX86LWImyDHJlI30rjhO1vNPcAuxz7B3dBzG4YeD
 hngjolSCSDs5CIYSEGA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74877f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=gP54STInbiGPwzblvxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 475Ag63VRHTVO2d8YSKFqAcoMML_Tpjk
X-Proofpoint-ORIG-GUID: 475Ag63VRHTVO2d8YSKFqAcoMML_Tpjk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX/sKs+3B5ccVN
 RI+LNEE2aqhcKBI7vlrc94MM7eyMOm6a8htQ7++fx6yUB86GLL8Zz/TPdV3isctnH3K/Wg07lFW
 9N70nTZ//Ea+dnXgWHk83RHB8+xhJxc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060101

Am 06.08.26 um 15:00 schrieb Heiko Carstens:
> Enable CONTEXT_ANALYSYS for drivers/s390/block.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> Do that for drivers/s390/block. In order to avoid false positives due to
> conditional locking, disable context analysis for specific functions of
> the dasd driver.
> 
> Disabling context analysis for specific functions keeps analysis enabled
> for the rest of a file.
> 
> Jens, if you and Stefan agree to the dasd patches, I think it would be
> best if this would be routed via your tree.
> 
> Thanks,
> Heiko
> 

Sounds good to me.
Acked-by: Stefan Haberland <sth@linux.ibm.com>

> [1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
> [2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")
> 
> Heiko Carstens (2):
>   s390/dasd: Add __context_unsafe() attribute to various functions
>   s390/block: Enable CONTEXT_ANALYSIS
> 
>  drivers/s390/block/Makefile    | 2 ++
>  drivers/s390/block/dasd_eckd.c | 7 +++++++
>  2 files changed, 9 insertions(+)
> 

