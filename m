Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367B48663E;
	Mon, 12 Oct 2026 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808558; cv=none; b=HeY1lQn8VWrL0Ove3CkpUbfYADh3qM0Wjy4Io3agn2rflXo6hEJ/PTNibBZCtmP5SVlurmKoz6aHZTzA0+WL+phuZQVorgV+Cws7ruu9vhm5DpRwTnjPxXR2FfmYBIpYvvTZ8R5j8JHh2yarEHBNz6dWdNyFfWW7BxIx9A2ai3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808558; c=relaxed/simple;
	bh=gr1UdHkZT42TXwB3sKo1tjGNk2HmN8ULExP+yD+lhJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC1I4k3Xg8TdGaNA8sLZTTx8j1mH0U3TrPaUDcTfp/36Xk3OowAwrFQ4UgsNA2LPD75vl9SPq206MJ6JOavVjgnTKFk71kqYAPr2WP9vZwTl3pHX7o6VY4/0QOmwnkW/kqsKOXZOW1L9PCT6GXvVwWErDMy0yt2v5mYgkX/qgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJalAjIL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJalAjIL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCESAK073741;
	Mon, 12 Oct 2026 12:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i7+T3z
	qPokUbiXGCw8MWaB8EypIUGzJiRg44KWBdSWI=; b=XJalAjILuT26XdZtZo6+1W
	CtmF4LiwENagCmxWo6ojA4fGtlCX3dau0PvTKO+e/cr8xD5h2rE61kskwA+l7ZPL
	r0dcHh0nVyXy7CTyD3RbktQHZb+r8pE5inSXVpD3PBtCKv462LVjw88gQlx/afh8
	2WTpa9/YGQsqBmyPrmqG0dUm1qB0YB5j5ho5DM4BjGIQcrJ3NlvGOMy88k3sVf3A
	cw5AcWCU0+rByCqfa4+d4+W3lUEksU/4ek5tB2GxGf3gVE9DZRZjNlka4CocM4Pq
	0lwZgBFWRJ1jD4jqY3I1rdBDLzser1gL6RbfexivPaDWkR/8vR9/+zup9+AiQyFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhrjqw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:35:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC51dq1212074;
	Mon, 12 Oct 2026 12:35:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjn4hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:35:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCZpUv33554904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:35:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E6D20043;
	Mon, 12 Oct 2026 12:35:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FC0320040;
	Mon, 12 Oct 2026 12:35:51 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 12:35:51 +0000 (GMT)
Message-ID: <a2cce267-4d50-4509-b44a-bcf15ec1612c@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:35:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/32] s390/tools: Rename gen_facilities to gen_bitmaps
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-6-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX5qsjHEsYzH8z
 hO0kjnzaZxZy72xwOF4KBh+8tBFYfFh/G01K2fMY1Vn5Q+qPHNmWNkYKJqALbaPULDgkcqHVkyx
 LCwUFBR1D8pL+Alv+rzY0oAwx8nn0VbN+FKkDFfKQYXQDg9lgEkC61WhpboQ7lsKwKilKl1Ma+V
 3PDmmTixeLCZDEWAGlrsHtFS9hkrV9OrsOJo0GWhh0Aw4mBVZicRhLAOB8jy+OXoXTmUeqUn3h8
 BN0rI8xL/6xyVaOVXrqtrifY3e03O0R0GLRsxv1o4Il3Ke1F09AVjzSmPIrZVL9pkGdvZZqTtK6
 xMQIZ5Lh+XWYVFSZAA22jLpZ2GX4vWOgNh9K+3KiIEyYydIKaqsy9qiaEEjbx9cNi3Du/gTQiID
 EL9y0fq+Qw+92o6d+xytXBIKg26AgIXDO/0GS0TPpd6kVrTd/5IzfzMrH4ZZsAtdqpkFbvjU61D
 4JakW/Wx4pJCDMHJhnw==
X-Proofpoint-GUID: sePPDrQtJbPy9OuYpWEEDxqvfbRgJSsi
X-Proofpoint-ORIG-GUID: sePPDrQtJbPy9OuYpWEEDxqvfbRgJSsi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX78NwcjN5p5VQ
 H9FRYl81uQ6KJ0wY/mNM7mNt/fTmG86gWoaWxHxHyIL5uiFsYQ9+2kVTT9TsQvKZssWAibJl/N8
 vXlPnIacqAdZ+wryotJYnFFEDd93E0Y=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accd42c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=E-j8CXGbEkyVYomHf4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120048



On 10/1/26 12:32, Heiko Carstens wrote:
> Rename gen_facilities.c to gen_bitmaps.c and make it more generic so it
> can be used for various bitmaps. Add command line parsing, and use it
> to explicitly specify that the facilities header should be generated.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/tools/.gitignore                    |  1 +
>   arch/s390/tools/Makefile                      |  8 +--
>   .../tools/{gen_facilities.c => gen_bitmaps.c} | 49 +++++++++++++------
>   3 files changed, 38 insertions(+), 20 deletions(-)
>   rename arch/s390/tools/{gen_facilities.c => gen_bitmaps.c} (83%)
> 
> diff --git a/arch/s390/tools/.gitignore b/arch/s390/tools/.gitignore
> index e6af51d9d183..e07d27143172 100644
> --- a/arch/s390/tools/.gitignore
> +++ b/arch/s390/tools/.gitignore
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   gen_facilities
     ^^^^^^^^^^^^^^ This should probably be dropped now.

[...]

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
