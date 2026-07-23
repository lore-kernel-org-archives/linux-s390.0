Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85347AF6F;
	Thu, 23 Jul 2026 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820929; cv=none; b=sjgVAyOC145eTFZlXiGvuc/3UH0EUsKC/LH65FJ4zOY/A2J1LEHP+vfeBRuDgzIqsmCJhQHCnORDgLkCOnxEfPGXXFC/d3K+ubD112Cr3jGNlKkKP0dnRPKa6ryi4+FkjcDWPDA4JJ7FJhglxR/KR/RFexenmcMOaqa1nlJUk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820929; c=relaxed/simple;
	bh=p172zE4t6R7SIzH1FiEoON2M7Xi0vUtgKBCeTA9PdUI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afp/FGnHxlC/f4WttDfiQyWg9b1ZcTaa3/RwS4eO3KW97GT38GgC8WGPY2hDblkwE1sgF5xVkQN8GC1ZU3R5eQ0WGwSYnPdnp+3GEia4YGZjW7Fa/5rHJKphbMxvG9Mu0SudEQKFMRVnIk1nzc/N6YVWhLf/2lMAwhN+Oc8YLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fK0nMEe8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fK0nMEe8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBdiO3106079;
	Thu, 23 Jul 2026 15:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xT+NiZ
	ggV3uCxprhyFL7QGMCoLyOoX5IJtOtrh8BwwY=; b=fK0nMEe8n99zOSvDkKwdOs
	Z0GhJG2BK+76Jq+iBmiNNjuKptHohBpYAAtc7hwAlWIXP+i9jU0rIDpWnyVs7LYF
	RvhJIxf9pn+IjTp+G/y1CQVSmJle5mL7mrRZf8ysqffDoKBQOe6UjIzBU97hudxu
	4TXDKRXVJ2AC3E0sDRNxMPL8hjFmgbKf9RFoYt1MlqXNCDOoMqWA4qk/c6CIHRsg
	WSYfgG/EO9deI8FgTXV0w60aGyGuNz8UGut2rjYSEPg3rRhKkjAtz4MzlZBytDUv
	MYwolVEaOgfuOjHHoo2OQZJkN8RUAFwbGwLYkntm2iG78oNfBF7Ex9gLvGTpN47A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7918b6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:35:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NFYbtW005289;
	Thu, 23 Jul 2026 15:35:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcssy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:35:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NFZLx14915786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:35:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B92D95805D;
	Thu, 23 Jul 2026 15:35:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83A7D58059;
	Thu, 23 Jul 2026 15:35:20 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:35:20 +0000 (GMT)
Message-ID: <a5dee982-6958-4328-89bd-b7d69df730f7@linux.ibm.com>
Date: Thu, 23 Jul 2026 11:35:19 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM s390x PCI fixes
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <6cefe506-b36c-472a-8ab7-ca2483dcc0a9@linux.ibm.com>
 <695f10af-317b-4de0-a66a-4257d40d8cc9@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <695f10af-317b-4de0-a66a-4257d40d8cc9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1YwPJLjIAd8GxcO1taMwHbfgG6PySFGr
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a6234bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=l-ubyujDiMiib_jDr8IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfX2vpFCHCKcM8k
 CLcb3BgjwRsPTKFqv3cIWBNxwMXrnhVKSxN7b2eljOs00P5RpDYFqcjSkKt5htYuPB9B3pzZ7Yb
 yP62qAXUP2eqlXjlUQHFeCmVaYqfHp4=
X-Proofpoint-GUID: 1YwPJLjIAd8GxcO1taMwHbfgG6PySFGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfX4fBmxf3GUftH
 xCigom8kcOhdpiM1KzFFImUz8VbQXy3X7Ja1LUb5MjawAl/FUD48XL2qwc5TS4cBMkolItANvGq
 x+nWJvcJMv/j6WavoyW7USrcryqJZcHG+7jrEfllSQ2aSBBGs+wY19Wxa9oRDtktfuLc/iW+Yne
 GZwOIB1em1Oa4Q/QJCw/dZFt7Xz6yTYXWN1C2SONpDijg2Gq1rnIPnIRD/r88lsQOL6dn1kMev/
 6OkwwREc4jkLZrS/PMXs0+gTpz9xFcMA2NFYA0wiG/MaJmdsT/3X3f5Gv+kJeRGlDtyoR67HH6e
 YU8PYPITooXglovMzosZhmuRYDRNyhpBdHyCfKiOQ9aRHDC3wWH7tSw4XLXjtTLiiDL5D6EaXdw
 jOAR0vJKt0cRkOOfKJmao/CKwqZCXpn2xXGWcbAouv2pjNa8BEu8bk2eVQSX+l79fUfcQlWtLsB
 +G4LT9SL8v5NgUAHICA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230149

On 7/23/26 9:00 AM, Matthew Rosato wrote:
> 
>> I would take this series and do small fixups where necessary. Just tell
>> me if the change for patch 6 is fine. Or provide a v5.
>>
> 
> I am reviewing and testing this today, please give me a few more hours.
> 

Farhan, could you do a v5 with comments addressed?

I am willing to also tag patch 2 if you either make the change I asked
for there (or explain to me why it's not necessary).

I've also done a variety of testing, so I'd be happy to also give my
Tested-by to the series.  But would be good to do this on a v5.

>> I suggest to add cc stable to all patches.
> 
> Agree

