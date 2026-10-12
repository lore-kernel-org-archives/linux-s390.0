Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CE3750D5;
	Mon, 12 Oct 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816189; cv=none; b=lE0r5FZ96yxcJaFtv9fZOvBqcZvn/sljrmhrUhL+T9ESTrFOg/M6ZqTLuzjZxnyJKH32M+S2TPGMj8NDBQOClP4qw8uEARVvcVAtXjRuXi44jrqHagnn7ppz9WRBmZH/gVo82F1WKegfwAVZNwxwg9PaFC0F+qsyJsUjw3CExH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816189; c=relaxed/simple;
	bh=de++yez/EDw5v12343W+6FoxIue0/Kiud1UpJiusQFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3K2Jd355cFWIA+zNyJiwVDqXGapLIYtrTub8uXgR8iXwuftdvA42mMmu+O6xYYQBgPMZTEcrE4XN5OGMzcjEYnYsC71GJXr0MSzdXxXwHQ+/gcupGL9JDXV8Y0xf6JMzuJH4Hc1dlcMbzR0GHPlhlAuXiJRHEipMQde/LWlUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=shcfq0DL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="shcfq0DL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEfte183057;
	Mon, 12 Oct 2026 14:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iDJF8q
	mI6PS+fwKmn5h+LuEf7O53YZcSIAiEUaAEO8c=; b=shcfq0DLFDRO118Z7SmwGn
	kyyqX24okEneTEi/wyBo6NpjQY8SF6gH12fswUhZ22fNJjjjWsM1/8ePN259Jbiw
	eBkE2oxuk3zGD1kzxXLif1g8tUTUecCMzGq5zPMGNC7OxyFyCvVLyhxflDOCphbf
	maoWWsSUIGpn5Il9jea6kffQa0TIDEPnN7FsMOFqszlHywQKVOqiUVLpwPv4hm1n
	zMU+huyL4zrRbP+8hVx2feBHIFIGiM9qSe4re4B6v/9x25cDnTlRB2yc8JwqzNZN
	tImzdMCOEGJtWrRt2vnc+F0R1yVGDjNCz8Jv11cXBXSD3Lb7KJOWwl1iRBPAl0+w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39dp2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:43:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC50Dl1287103;
	Mon, 12 Oct 2026 14:43:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwhj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:43:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEh2Pk17367544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:43:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B6E2004B;
	Mon, 12 Oct 2026 14:43:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519F720043;
	Mon, 12 Oct 2026 14:43:02 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:43:02 +0000 (GMT)
Message-ID: <da1110ca-3b2e-49f2-b8f4-6d3eda33a9d9@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/32] s390/extable: Remove EX_TABLE macros and fallback
 extable search
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
 <20261001103247.1989111-33-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-33-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d_3zPTzxLkp4Gd8MWwg3yojCOlNJiY1C
X-Proofpoint-ORIG-GUID: d_3zPTzxLkp4Gd8MWwg3yojCOlNJiY1C
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accf1fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=zqj48yzne7XEvSD_7ugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX4pkpQYMp5JMH
 Z3FpcU7MffzabtUSsQm6WcubVlTuBCudIEyWgVCo/FvqeJ0rSVpIetLleATkWKgiPdG2h60k4Qm
 kuj0RrJ76jx9In/X4Eifn2Ypf9ka9vY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX4GhK6j0M6Q6U
 0ldj4lUl0xvseXG9BPptUnHQGs9b3PmND3uorg64hKh/KUjYYvUGeoFezCfOve0e2uL0EqUMh92
 QUaBo3yoTFkh7W1GzmhVq8xZ1wUYJQhzLdySXqiGtj4mIw0hc+aGsvP3zDlMqpauQp5s3m3Jxij
 o3n3gJM7O6m5mo2ABt0YZlI3peMG9Ym6nlbyUnO+RK9a+emKQQVQjI7yF8nS3ZyMk6Du2rRN4D3
 4/Po2E73nGg5AhNnA2yp5M38x5unNyN6lV58JhUzaQtwVDCId2X8uUemrinkVHZmQ7JAwm7i9SX
 ZzMIxz1K+OhRrHvHFZ4sgsu2NFcoVsGnRZveIhrGY7iz1P7Fp5ufDUTJQ6HaPsnUtlk4/rBNixC
 o9uEn/rkepAHLeTbGpAZurW6PKNX1pti3biYXzrj5a0eZwu+53x7uuqGOxgBGQnK3Jl84nmHf5H
 QB3JevDznzaK2M0qB+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Now that all exception table entries point to the faulting instruction,
> rename all EX_TABLE* macros to EX_TABLE_INSN* and remove the
> EX_TABLE_INSN* aliases.
> 
> Also remove the fallback extable search via instruction_pointer() which
> was only needed to handle the old EX_TABLE entries that pointed to the
> instruction after the faulting instruction.
> 
> Add a comment above the EX_TABLE_INSN macros that documents the usage
> rule and describe the difference to the previous EX_TABLE macros. This
> might be helpful in case of backporting to old kernels.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/boot/pgm_check.c          | 23 +++++------------
>   arch/s390/include/asm/asm-extable.h | 38 ++++++++++++++---------------
>   arch/s390/include/asm/extable.h     | 25 ++++++-------------
>   arch/s390/mm/extable.c              |  2 --
>   4 files changed, 32 insertions(+), 56 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


