Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4141FC7E6;
	Thu, 19 Dec 2024 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601020; cv=none; b=EfoFitkTccVA32MKjRjeeqZMN/ZZO2BEOrU+dXc0+aRIr6aTcPGeje7zggwugSbW94s80vIhxs/BCfRCl5kvHZnz9vIaggEbw5oUD6p1SynYluoRujlVtUw/9kc910c3m/DMon8OffZXWzfdriTx2YL5Q+lgdHzG+7Ri7ompnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601020; c=relaxed/simple;
	bh=JYcd44WiL4+1Px5D3UzxkaD4JgeUeE1fXErAzwJFl4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqlMOch0zdS8cpK6Z+zeQ6eftvFGBtJrYCLvW/Zo5BRHhIL8lg/u54/A9+AkiN2vZqB4evaBMgkQnADp5WSitjV0HuybRvsxg8eb+Vitr7Q3vhOSn0O4F7XpxK8zL5Zvfg6rYj/epSAw19z5PGbyGzq6fJYc3yJoHKwSH/kwFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A78+rZkq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A78+rZkq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ3tEX6029919;
	Thu, 19 Dec 2024 09:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WSyPqG
	lQ8d/79CpLn42u4TR+SUkuqCpia6XjUoRE0kQ=; b=A78+rZkq7Gx7ehrlrEZmg1
	srfU2XpXAARFqNdVO/E3LgEDCDcS/m9aYXFQ+zbo8mAiMF0CU1Hvarkm0mnN9PWR
	ze/xdT/EpGXYjuvGt1zeAMfH8orDi85AyElMqdqSXtoHpb3cxsBUQNH53jKnWFJz
	phcwLuWO9qL2tHWEP7xkr8AKqNFglIKXUVf5J1sviNcoDtExts7W0J1HeOELnK42
	sh0T+81Bxy7hPzpByjHJvKO2svQvk1nvyULpw8XcBPU6uSEGIFosUlxRg7/QOCEb
	yrsyo6qigX8O9pHzFGeoUnoLZeD+D4j+RSOTnOMWtmwjlFegtek8PpV/GBrQs1NQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mbyhsabt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 09:36:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ8waHh024022;
	Thu, 19 Dec 2024 09:36:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukmdpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 09:36:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJ9arta58851818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 09:36:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3030A2004B;
	Thu, 19 Dec 2024 09:36:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14A4A20043;
	Thu, 19 Dec 2024 09:36:53 +0000 (GMT)
Received: from [9.152.224.44] (unknown [9.152.224.44])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 09:36:53 +0000 (GMT)
Message-ID: <7bcae2cb-fd90-45eb-af04-d7f228c9df63@linux.ibm.com>
Date: Thu, 19 Dec 2024 10:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20241217023417.work.145-kees@kernel.org>
 <aa6c671d-f4f4-446d-b024-923555c3f041@linux.ibm.com>
 <C822C723-2141-4380-87FF-CA1D87FF8DBF@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <C822C723-2141-4380-87FF-CA1D87FF8DBF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6FUym1l60VOhFQzC3dzZmFzumDvq8sIQ
X-Proofpoint-GUID: 6FUym1l60VOhFQzC3dzZmFzumDvq8sIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=736 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190076



On 18.12.24 22:44, Kees Cook wrote:
>> This does not compile, it needs to be:
>> siucv->siucv_family = AF_IUCV;
> Thanks! I saw 0-day reported the same. I've fixed this for the next revision. Do you happen to know why this doesn't get built during an x86 allmodconfig build?
> 
> -Kees


Probably because of this in net/iucv/Kconfig  (?)
config AFIUCV
	depends on S390
