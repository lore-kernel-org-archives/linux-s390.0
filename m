Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2548F01B;
	Mon, 12 Oct 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815484; cv=none; b=u/uONukkotK4XFAHb6AClaj3gXsqisC4L+bZjfmXe7qQ8WjAAQ7StnKvixnOyQt7hPGesWlxz+1zvyA2SKD1kLKnrGsOq82UWVJPRruHGBHZlxz9upvadCXCmy5WiC52FfXGueUW5FHXQaWZsBW41bfb6AxPIfYuZV0eKmBsj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815484; c=relaxed/simple;
	bh=cwNeHIUl6p8KJxXDwgAzED7mAKp/Pz7kWvsHFdSgijY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEcQPKHkG91umkWXDMuHzGGFrmxkIFFiNnWKG1HgEslUOPng1rl+V36fywQEw59xmdcKDYuFSvRIMH9AMRLHkuTK0GyXLXpuA0IPjqaQmNdKWQtSEpu7pdTBvu6vUZCnqUfj2+FwuPEyjJkg0eag8ztRr6TExTN8hjdo8YM7kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QdRlAXLT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QdRlAXLT"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEE1d3209697;
	Mon, 12 Oct 2026 14:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TJl3D1
	pzprafFh7GndGxQJlYsvdSrDBW7tORWfxQ7sI=; b=QdRlAXLTTQgnlFfELNAFKj
	3HQ6d9UePlhZYpqRShjJwCGtIGfYF8uyObIyWUO0Clxeu5gb9UxwG7JMpKOySWIy
	wP7y92vaSSLWGxB/hd0qSA4WIGjDD4045pC479CkZBC++D0Q6vLaNR479o0hjLTz
	+X10AVV27zIz0Kz3hSh9dM7+1q2nR4WWpsLFs41jScL7FhCYHbHk7B+g8lO5t5kX
	lBtH0Uo2E2G7ZgoeeXT76qCzcVc80YXLQUkDT+7HR4iX+j38wMxKMk779uZntN0v
	1lo4qAMA+qm72+RSYE4kGKNKpUTzfdLbr2YJdhbf+TZdqdG3ZF8QNkyzzPgSEs0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv09260-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:31:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4sFf1212024;
	Mon, 12 Oct 2026 14:31:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:31:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEVI9G56099280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:31:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 221202004B;
	Mon, 12 Oct 2026 14:31:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A54820043;
	Mon, 12 Oct 2026 14:31:17 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:31:17 +0000 (GMT)
Message-ID: <efd8f77f-f66e-481d-a67a-d4f2d0520ad1@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/32] s390/traps: Handle nullifying program checks in
 get_trap_ip()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-8-hca@linux.ibm.com>
 <f7a81358-0ff9-404b-9b27-1ea11c095694@linux.ibm.com>
 <20261012134221.19350F50-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012134221.19350F50-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX0n5dOWwd5xof
 M3GN9euaWWgUsC7hsMzP4bfQ/y+E6tlshpsByJcS8evy8kM2EdyhZgByw+L46FAw6rhdOPpyxpF
 ZUpxU+CrDvPBFA22aRpO4BxNiJHpWeIwsXvpt9KJyzWUHjHjN0tYsIwNfK37cZXnGSommROpmll
 gIZ0VnrbqGwI3+RNsR4OUhgxu0m6pYblvXOdviYJohULsckAsDVuvOXxDPOU88KztICJLAv02Yr
 3lliVgll2VqJaROlKrYk9Co91vyUKtMQXWuORmltZfnJzA6RR/+TuJlfcrTuB8OvzlWHEpq+QFy
 +3jJLQW63s4AFRGObzuTzE2OX/ggsgnpsNN9y81qZac1RPzjMJTxneccYkqDZoPZhojTmK+IuPr
 o+sSeS+Eg4Hr0o+J9obU1pyv0dTUsN3U4vseBvjUt3YgYYakTlpjCqP48kt/G2DurMPWKoZaHpl
 2vsrXmi6JqUDWuKOuGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX5edEEpVJ9kRS
 jVgh7eX/iO118UGVVHbwzuoS8ZYplBVwD61aS2g5q+M553tlba5Df/zjjH0PkJ6RGGiRCR1mxlG
 +3s35rlLaRtXS+OdLa0ODFhv/Oi5UE4=
X-Proofpoint-ORIG-GUID: X4DRiyxEZ8_Mdl_eWJ3UIiO-pIjTWDnb
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accef3a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=cuqZv70OvzW3UWfsH6YA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: X4DRiyxEZ8_Mdl_eWJ3UIiO-pIjTWDnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/12/26 15:42, Heiko Carstens wrote:
> On Mon, Oct 12, 2026 at 03:01:56PM +0200, Ilya Leoshkevich wrote:

[...]

>> Should location be moved inside the "if"? Now it reads weirdly: we cast
>> the pointer to __user before checking for user mode.
>>
>>>    	if (user_mode(regs)) {
>>>    		if (get_user(opcode, location))
> 
> You are suggesting to move the assignment like this:
> 
> 	if (user_mode(regs)) {
> 		location = (void __user *)get_trap_ip(regs);
> 		if (get_user(opcode, location))
> 
> ? Or something else? Sure, why not. Just let me know what you prefer.

Yes, and maybe also move the declaration there too.
