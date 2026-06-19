Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DEE573
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865324; cv=none; b=aNkG7pGgcnx2sSKZpEuZQuHCDhFTDyBpt5a0zXxjzJJxg/oniqr2qtoRcb3u6fdiHF8+SMh+V7DCT14GJ7Ods/HcaC5oEMe9y5fdMMNbc4T/cG89VOnV5BffVQiZMzbaIbf56FzJ6q9KCney7GwcN1fTUO2GK7bC6LSTKymtMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865324; c=relaxed/simple;
	bh=C3LrVXjmnYYLX5elK4L+1Pnnyo60aZvoNZ5UdbZ/TcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlaLvsVw+JpgrsJHTpZiWZYtJQeLkmM1yizSZ6ito6VXwqcFDx+grGKSdJ+PLh2WGghoVqE65t8r8VWsBVnF64awHaFIZ2/aM/XKSCPgE2ErvYQ/TvUVOXdmfNHvAFyMpKLmZZAC/eRc5ahi/tvoa2jG+sYTuRS8EFnFfZucLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lc96ypW0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lc96ypW0"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mjfu1587798
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wCvEUt
	UkyusCwakhcVsYvPnXq61UfHoc7jGvvUaukks=; b=Lc96ypW0c2uDMV+oiRlJ6U
	ggg3vCSEIdzhgu5DjMxFB6hB7R96oI66XwqsZj3tzInLlTGJWaJ2V+55frS9lDd5
	5O7FXMUyNZrlJTJ5WZuviqgFdu+kJZBAGuU+kBtH3J34ya3sMGJSBShYP8hPAYJM
	NEELZfLeHZgF8KtjO4fordAVEpayps+683dgRie6lHgORNonlfQaRlp85+SnYu02
	XPDxSdFYIJ0ipvahq3R/s0Cz97N86Q0SXIQYYIr7Y5SOONdEL4ySow03FNXUlzkX
	+0zn9gT1uF0CjsecQ9YGtsNMaB1kGN65A1zSFu2JRz/RWgl8AT1pFFS2nhnd5o8Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxcun5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:35:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JAYcNW005300
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:35:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gc3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:35:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JAZHn523593442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:35:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6E0B2004F;
	Fri, 19 Jun 2026 10:35:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACD52004E;
	Fri, 19 Jun 2026 10:35:17 +0000 (GMT)
Received: from [9.111.75.212] (unknown [9.111.75.212])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:35:17 +0000 (GMT)
Message-ID: <5587efb5-333e-4597-9c36-7630dfb973a4@linux.ibm.com>
Date: Fri, 19 Jun 2026 12:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <22083ccc-9393-4c59-bf74-e6236058c14c-agordeev@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <22083ccc-9393-4c59-bf74-e6236058c14c-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w4aavsU4wICy6sW0e3_hkwplOfNslUcM
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a351b6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bTjWYrRr4wvuKUlacVIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfXzXbH4jJ+0lwj
 fiIIM5jdca/v8zrM7Lx7bHeI14AXAtHJb8+A4D60ARiIbqXmuwooSHIJE5AOMp/KJ3DXWgPkJ5Z
 +c+WxYGADiG7d4vgCZAhcuxaRfQ1W7k=
X-Proofpoint-ORIG-GUID: w4aavsU4wICy6sW0e3_hkwplOfNslUcM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5NiBTYWx0ZWRfX4Q6GHgSWqdzp
 A5iUQHDcHMz+eFU80VfgihGvhP+0NrOsbXjfCWC3jcLqADws6EofgTiVrpoABK5t7bH+iV+nwHS
 EtWmdzsNORW0u6q2fnQMRdHO9E3NodRftMvx5ULADpwswwUO87VLyLCCe7acxNceGCfP/jo1eB7
 7sjrSCtDAsBRHj1/IoJEPzSRx7Yc7o2vjE4xGdMfqQMmJTkL345fhMJnE5f2fKxE6jQ9iPkGV9V
 iWudYuBSlg2c8wKBmMmv4o8m4dIYvE4ps7+TJFGxcvM2C+5R89AV1omd9M0jwaUyF5wKjiONbu+
 v1SmWieizr5at9B4pvn/EBnGM7NDh5Tzmr3nAZNwU/F0u5yoUaPcg3lucs8rdaLpzNStCWAP5gE
 0RrSvFeYZeUxQI6rQYDKuXM2Q3KQ7Is6yatis9oRPYuHorcoGKmh0eElv/D/bukYYuw/zUyI1Ut
 zRFkM+EkGhVK5bOMcxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190096

On 6/19/26 11:34, Alexander Gordeev wrote:
> On Fri, Jun 19, 2026 at 09:45:41AM +0200, Holger Dengler wrote:
>> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
>> supported keytype, which are derived from the bit-size of the key. The
>> calculation for the bit-size of a protected key has to take into
>> account, that the length of the protected key blob also includes the
>> length of the wrapping key verification pattern (WKVP). Subtract the
>> length of the MKVP from the protected key length fixes this
>> calculation.
>>
>> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
> 
> No -stable tag?

You're right, cc-stable should be there.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

