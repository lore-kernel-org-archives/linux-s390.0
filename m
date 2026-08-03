Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC882931FA
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769435; cv=none; b=tyCrK/PHqz4ccDbzjK6lytWjykskysYPCxiIMYrBHVb8dLNfHN9e9JC1PfR3i59AwxCo/whIrfL1f4soUoYMkbzWUvY3Sq8gJbRTCmM+N2BpyteaieBp0201Ub9/ERh/OEVLfoVmIV36pv5E6Wbh9rvhjrUROQfZspKH73XvDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769435; c=relaxed/simple;
	bh=QN7QuyYvaI/1Wl0tYhclemHOsCa3GuHO1nj+keDtlqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3LqIs+QZAc4AzKv7KB7qxP72HaQDeEHNEJz4egB/FvC1rFCXYij5aWxVAaAN3xIhyJvoS/RhFIbQpyc6qMBDRXOrsQpKa5vMom7GN9KYzLZeYzq/fv4Vp52QR76GErY2cOZDABy2RZaCKyY7wFI/cYETItljRXowJGvJUCeW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JjvoZwa5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JjvoZwa5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHpRH414159
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 15:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PrS/xE
	eN7wPvCYerFlK2bO7La4qT7c6f1J1C666EyTk=; b=JjvoZwa5lC/ro9frCNPfCJ
	IMIanuZW2Bm+dvwrHPDGPcZeoei9R7mM1j+saBlmr/DXELDiLVyB/xJU3aGcy74M
	isD6rMrAkMFtudBy6m6mtCo2uxeQWFunHpvWdV9cuGmmzT6VeLQF0NxEEobRrml0
	mleo2n5aHmMhS4wx29GBt33c47iZND8Dl78snuR1oqc3rPVTZaNw6DnoAsL1sEtB
	5l7UxorvW+zkz+V8PkbHvhbFxwq3Jx+lZF0mSS2f0Cp15EMXPAQy3AP8ByyXUGo3
	J0bVyVh+NaHimoRGoiVwKkHF565+WBMG4JPKZGYo02yhw60931DLt0rkTYJsrm9A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqhd5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 15:03:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuEWh018870
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 15:03:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qe2sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 15:03:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F3mYM49873374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:03:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523822004E;
	Mon,  3 Aug 2026 15:03:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066002004B;
	Mon,  3 Aug 2026 15:03:48 +0000 (GMT)
Received: from [9.87.137.8] (unknown [9.87.137.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:03:47 +0000 (GMT)
Message-ID: <cc6e8d33-813f-4482-93c9-559bd57045c6@linux.ibm.com>
Date: Mon, 3 Aug 2026 17:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] s390/zcrypt: Improve EP11 CPRB domain handling
 with ASN.1 parsing
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-5-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260803083339.212885-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i6NtCcOrIvsWNNAb0-A9_E00nlfwnN8z
X-Proofpoint-ORIG-GUID: i6NtCcOrIvsWNNAb0-A9_E00nlfwnN8z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX0ZQBgKgeEwVu
 RhMB++M6naR7ItlXn1XaSX6GZ4UgBfiTvYO/O1KE7s/zp0YcsG1vPBZ1mvuGu9WN0u0vK+NF5fC
 K2YzaaVYKjiVAJR267b1RR0URLzoAgk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a70add9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=7k0PEULsK8KYfYnYUx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX5+ey+tAWey5X
 /GZVE7gkowVXGL5fa09+r3jbx6dew7SGmgjbXmQCO6XaZGv01v3ZSskXdRQT1K4PpVzwWQD7QNS
 3KYXOOiuexoAu6KcVrcayAyaeL3Jd/4Z7aWhzMvHEgIwh6qTfrb5/hpnfmcJ0X5rEryU0X7goi7
 YLO/I6qzMyYVG8AAfks72iXEB3FzUlpSXKmR3QTUQ3cFqm0GLl3GZ9dAApeVZTVjbA63HsLbb6S
 a+zGVB5Dt85RIDm7PAMDiVvynGXIepXXlgdMrD7eQpoXgay6VJWBqcfmaEWI2wW/hE6ig1Y2ZKo
 WjJIk8aKNt7sHwEmS5agTkr324hfN+ktluLSTZxzJpGEsipVy2Jl/vmVR4ea0Pw8EUkj4PZN12i
 3IFtnOWQJyU+ajDSapCY/afuRGogA5cGVt++1vl9v6bCV9Vxppw4b6s2uoJErzbwH7sPlzfOt/H
 QG6yVWYovK5YmjPBjOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

On 8/3/26 10:33, Harald Freudenberger wrote:
> The zcrypt_msgtype6_send_ep11_cprb() function uses fragile struct
> overlays to access and modify the domain field in the EP11 CPRB
> payload, creating maintainability and security concerns:
> 1. Struct overlay approach (pld_hdr) assumes fixed payload structure
>    and doesn't validate the actual ASN.1 encoding.
> 2. Complex length format detection logic is error-prone and doesn't
>    properly validate bounds at each parsing step.
> 3. Direct struct member access bypasses proper ASN.1 validation.
> 
> Fix by replacing struct overlays with explicit ASN.1 parsing that
> validates each field (payload tag/length, function tag/length/value,
> optional domain tag/length/value) with proper bounds checking at every
> step. Add asn1_int_encode() helper function to safely write integer
> values with correct endianness conversion. This makes the code
> consistent with the validation pattern introduced with the rework of
> the xcrb_msg_to_type6_ep11cprb_msgx() function.
> 
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.1+

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

