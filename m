Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42C470130;
	Mon, 12 Oct 2026 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815337; cv=none; b=Pl6HvrsptTvmZZZcglPXfVhrRm8Zd6OxXDdJmjUGX583zO9EeuIFSSIpIPkrJYWHS1uYJ+0O2eYhJ5onfJ7/PzxwXPJdki5dks/+N6zuYLQWanoCTTV3OhsvfJfw3eEKtfqvOE1UcSEJhN/URcYyYpKVa/NPfQzr0nv1Whvh7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815337; c=relaxed/simple;
	bh=nL15Q28LrVIN0wU2qji8Toq1YpBJh1mibqs5Z9cSnhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uic6IwjuXb6sLiJYfJ1CGcrMQNjRvHG4qw/v6S9FOiJMlT95LIfhyB8XDxlnACBbu79X36KnErqwZbQ+vkRsE7RAC/dSCvWYrRFAOBi5f28VR/o2DtUk5AbHiUYltkYH9vbCEWxI1u8u93I1WD3LiNYmeB0qTRP3ik/4bhKsKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1t0NjEm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1t0NjEm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCENEE3209890;
	Mon, 12 Oct 2026 14:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q9Jkck
	ER0pyd76WpdpnhABcapJ806jQlQxaDAbh3+w8=; b=e1t0NjEm0Qb7qPwqXkd7it
	lE45Idiwim1eYO0/UjY931E1jRRjkjic/vzE0LCIyW6W4kqXaYUGzkYUFvZJe5oE
	FvB9bay+Z2nEu+6Lg8k7p9juVXDEF8R23wJcIo/xu1EFX8xwHgq8gRoVN0h4Q/Sv
	toBvyHad9pMOVMHtQ2+hRNMVcvoj1FXVdWT8APlKvAU+pZnh9CAL8yedY8gt4L53
	hZssWcsgV4t8IvkMd637dtggrj457BB/xL+qo/dhZlS7tS5nH8Qd5QWMPIUEgdQt
	WUkRw5Px5g8CwcKeJIcmnAffTDvHnbwMc9nqbN4VPWlrLBXR1wI8MU9PQ7qWO15w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv091qx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:28:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4xXU1212055;
	Mon, 12 Oct 2026 14:28:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnj4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:28:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CESov316122302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:28:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52ED220065;
	Mon, 12 Oct 2026 14:28:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64ED2004B;
	Mon, 12 Oct 2026 14:28:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:28:49 +0000 (GMT)
Message-ID: <2509b6bf-9919-45a9-b506-920706576d81@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/32] s390/boot: Convert inline assembly to EX_TABLE_INSN
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
 <20261001103247.1989111-27-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-27-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX4OgcBv8+vyba
 kTca9jx1f77O4ML+HGe8TIsFXgjR/XvP/GfVazO+Y0sGpK9gfuTmB2IwzKhMbg06vtmiYxRGmGv
 8M7ZDktNj7aBLXlwMIvgYbRvOHAgoGEHM2LG4i0yVMLq6ngCEI8IAs1JFSo5E9ym+frhnfWdHDr
 KWuCFTnCqPwGm1p+sW0T7B28k/3gAlC+H6Zuz6o4vNXw0pl4kulLnRZ9ndtlqtaFdzJ1LWQkG5M
 8HmMJWdiP/BIIpMGYqpzDA8uF9KPX1/fNyzmkUuV800A3SNGVTKKRUpGHP56DyYWeSA4lbIHy3b
 9FC+z8i5zRjNE8X+e4NCyGT6BBOe239wZUMYp+tGFM4cZdN61q6yGNLfhXo+RFwVi74KTZti1Rl
 fAZx3Dc1At7xYlndrZta+3e+E7DosDbLTjOpE0l88ZdZ+j2A+NhR+vyGG47ud78/rq4U1JSa729
 ZEKF+CTe1jTndBjnPxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+kOzEdXTsMsE
 7CspSEOiEeqgNfQwvxSmRaBeyxYQRnjWrMVrfMMj4ZQty2UDUY6RTLg1EQyjYTVKd0+1T8Ei4fp
 0rweliCQYsFAoOWmdqQBjNxoJnJQUKY=
X-Proofpoint-ORIG-GUID: 2BfwvcXnhKIhDr-TYcr4M97dki70AKr_
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acceea6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=IvibhD0KQJyWEH3R5V4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2BfwvcXnhKIhDr-TYcr4M97dki70AKr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all boot exception table entries to use EX_TABLE_INSN.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/boot/ipl_parm.c     |  6 +++---
>   arch/s390/boot/physmem_info.c | 18 +++++++++---------
>   arch/s390/boot/startup.c      | 12 ++++++------
>   3 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

