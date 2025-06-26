Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0A219E0;
	Thu, 26 Jun 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921170; cv=none; b=TcCmE2FD8OuNlWNqn+PTAzDVFu5CD/lH/1OvFGMSk/+zzlX+Cl2JZWC+7gJOrSLwAvtThwVVUEbXdmeU740r1LBFGUC86odoZ9hHeRxmkBUOe5rji5T23VPd9veaig6X1JYxEDmmANCh8KGpRpzEvq4NxHDeObNAwuObiWrH2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921170; c=relaxed/simple;
	bh=+Jh7pqa0rrPv+UjDTbhWiaUFzOmU8prTFCGr0D5c7TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1ji2/qm4+uSydtxCuACA1GvTfYiZ2XBoB9IwO+bw662qVERkS4DpQQ+DKFhTR+bBmNc+urDBlynNUj2Bg+sZhwASMTriWRYvBnbYpXqoW29FFlF+8RW2fV55BAxck0jnlXcrhAG8BNi/tutsthHg1SMTFXw60gPv4QsgQ74g/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l4brjSYg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l4brjSYg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AY8U015733;
	Thu, 26 Jun 2025 06:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qGXqzq
	Zk2m0+B/Vg2ydcRL2C7Yorj34mc7Fi/qDBFtE=; b=l4brjSYgfQiyyQiEv3Z8GQ
	VqrkQBQ3LibTAUHhA5Pm7lY5WKZ1+Dq5eXNwOWhVXtNB91rTIYuaYr/yL2wFDrnv
	N3WNlo217SdM9WImQsCR/NnxLKB/Gw02hCcryJnFEcA9cd1k2lg25WnrGz+KqUcS
	x2JeWoNOKm2UY6Qm1l3YzSRBbCYjXfRkE3AhIVQkcHF+RbEO1JuuSM/w9Y2zcp2O
	9F17mQRiNFpI2mWNT2tEA+7pNrLs2Z1ACa8/M5V1Up/IWHm532gVa2yOnH75U8Nh
	fB6vI09rIMFREikbM0icoXx06KqD/+j8914oL7XluEHBi5E5ZGkKh1FohdUI5HoA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jmphw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:59:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q6q2xq004680;
	Thu, 26 Jun 2025 06:59:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jmphu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:59:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q6CheL014704;
	Thu, 26 Jun 2025 06:59:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2n94r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:59:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q6xHx832244404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 06:59:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34084583AE;
	Thu, 26 Jun 2025 06:59:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D84658387;
	Thu, 26 Jun 2025 06:59:11 +0000 (GMT)
Received: from [9.109.248.195] (unknown [9.109.248.195])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 06:59:11 +0000 (GMT)
Message-ID: <e95675b6-8a40-4b89-9b43-40c9fb11cc88@linux.ibm.com>
Date: Thu, 26 Jun 2025 12:29:09 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: update smc section
To: Jakub Kicinski <kuba@kernel.org>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
 <20250624164406.50dd21e6@kernel.org>
 <20250625235023.2c4a3e8d.pasic@linux.ibm.com>
 <20250625152118.77fdd8fc@kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250625152118.77fdd8fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA1NCBTYWx0ZWRfX0bdGq/ifMTut P1R4TOFtdYVYHPgonnHrQH5RhF1RvXkbJ1Y8ZOFOgrYDZXwawXDWhL6kcyt6UPSmBxnwnIB0D2K 8WCqzIqRhxLq8A8UAeLleiZ5QUv0GfzUqn7T86fIT4cm3L8aP2YN5Pxhy4Avb1234hEcIroDIwZ
 UxK+xYTvI3phQLsybzB+HahFAikmJoLK16fgfByEPDoI2ohaHP2ZbSTd15c1YEjs1CKSWX7rUdg QP1ekkl7re0vhvSgsqsc5t16gVTIkQlXnBW6newq0e5OFIUCsn/yiJga2hFqQZj8H/dt38r9dgQ 4IAj+w5kJewwaJupt27uoXEQEkWEgV/6J4LvAbKyBfmDlx9UyI104Onodv1xGpGovtscG9dUEUH
 eUWEaDjwggJKXGm7Vx6ic+Lw57aBsfa2DxOwqMH3LkNu77Y0foe5yqqFFsdINcn2024sTDn9
X-Proofpoint-GUID: baD_6b44jXasBfHdpvoIgQS4DsRGgX01
X-Proofpoint-ORIG-GUID: WzH_p4gGfMKd1wvH9TgwYvTv6yYS3qhg
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685cefc8 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=8mEB3MV0AI4UP8Fti6wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260054

On 26/06/25 3:51 am, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 23:50:23 +0200 Halil Pasic wrote:
>> Jakub, would a respin with
>> s/+M:	Mahanta/+R:	Mahanta/
>> and the necessary reordering work for you?
>>
>> I'm with you, we should observe those rules, not only because they are a
>> community standard, but also because they make a ton of sense IMHO. So
>> my proposal is to make Mahanta a reviewer and revisit the topic of making
>> him a maintainer after none of those bullets apply to him.
> 
> Starting with a R: sounds like a good compromise, thanks!
Thanks Jakub for considering this! As Halil mentioned there is an SMC 
patch related to PNET already in the pipe & I'll soon send it out to the 
netdev mailing list.
