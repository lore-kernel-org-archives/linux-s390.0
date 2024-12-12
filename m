Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CBC210F5E;
	Thu, 12 Dec 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004870; cv=none; b=PB25Ex1mVoqxvjz9+d0OngBAaKRNkT0l2r9mTFQ5Jm3UDXdICAnUrfofL/jVcwldtFzv8h4rtnlBgNCSPmU0AFZ/yiGOsavd2ughDEmmIwa4Dhv7UdTUzgVp0gX0FkWy6SsCqdhiQgPmMy4TbiNqkVZ4ZRv7J0LTmaKpUMt7yT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004870; c=relaxed/simple;
	bh=1UnvRowKTHMn0oCFKjnBckfeB2U2PCWdb7BTU8jkPGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEobwYrIOE25TY/P201Xv6kUpgNFHIknM++vzZp3m5HRUVkf64Qqcj8QmBrCi8ykTMEDspiYG45V3yQKJOZKd4HP6vVe10PzmDObPW+MD9XSE5JqzT2zTdhTRwkr3hOPKeDK7kpJ0itlVrYna+fStoHoNHkgtwuw5Kt3XEsVays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1Cs5YXy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1Cs5YXy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC6mqMG029640;
	Thu, 12 Dec 2024 12:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gjR9Jw
	FSftBz03xxwTbHkYSDXnrIBd72MCfq9Q9fRlE=; b=P1Cs5YXy8UF1A4Jj7ZYtow
	pS0AJZwEuilgz5gND42ipL4zahIWeoV4mO2WYbCqJZFYqnBgygIxwn0G53ji9GMs
	P8T0tE1xO2Eh5/d8vQ9xK+0BYfTWZFgIbn6WvpkoKuk0srC5ZVSyn/tpBqQOgWlk
	agsWlobtCK0JS2WUfafRBVNuhQgX5OMO6insBd6Cm7HqL89ujEgwCkKnk9ekbxe0
	ZQW4spMOuauVHGhtlArv8PNKsUvZ/SYeJwmnFfZyKHAldhnf0qgltVNN6zk/XqJK
	JecNAza19iKJdIvsI51a80OUDgCdvph9YVXslig+mBlrwNBT1vjEEca18qjhH3DA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjtr0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:01:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC8wcgx007793;
	Thu, 12 Dec 2024 12:01:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11sp6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:01:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCC15go26280638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 12:01:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2374A58055;
	Thu, 12 Dec 2024 12:01:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C1158059;
	Thu, 12 Dec 2024 12:01:02 +0000 (GMT)
Received: from [9.152.224.200] (unknown [9.152.224.200])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 12:01:02 +0000 (GMT)
Message-ID: <c99b7bc1-25a6-4075-8d8c-38ce8c32351f@linux.vnet.ibm.com>
Date: Thu, 12 Dec 2024 13:01:01 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] s390/crypto/cpacf: Constify 'struct bin_attribute'
Content-Language: en-GB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211-sysfs-const-bin_attr-s390-v1-0-be01f66bfcf7@weissschuh.net>
 <20241211-sysfs-const-bin_attr-s390-v1-1-be01f66bfcf7@weissschuh.net>
From: Finn Callies <fcallies@linux.vnet.ibm.com>
In-Reply-To: <20241211-sysfs-const-bin_attr-s390-v1-1-be01f66bfcf7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mMHCSTRghwdb3srlLi0x430gvhXPJ50Q
X-Proofpoint-ORIG-GUID: mMHCSTRghwdb3srlLi0x430gvhXPJ50Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=808
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120086

On 11/12/2024 18:54, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   arch/s390/kernel/cpacf.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)

[ snip ]

Tested-by: Finn Callies <fcallies@linux.ibm.com>
