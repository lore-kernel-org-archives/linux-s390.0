Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7B7441A;
	Thu, 18 Apr 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426647; cv=none; b=gTwCvSitBpnOSPmQSVXBVkxyPbimD1KkCkDMoysFB3Nh8noKd8QkMdU5Xdas3msA6/zoJmLZVQ0m4/RLePrNs4VaGYcDxLYJiSpzjdYbTbJIdqYbqrdc8tKixpQR1J/ecsv7I1pOhisXpIX7sOIxCngPk817d46iYKc5G4/IGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426647; c=relaxed/simple;
	bh=o3XmpEEH2rwQJDfM1A+Eu9lpuCGCjX/Q6j8gALMaLfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4pb2J7pqDaNF1mo4Es1zCtas8cbZm7YoM8BJmbNQGbYagPYtHJYgdPxioMrdXNQM03vpdTf+Lc74BUx9SEcDgAgrRuFW66No03rLaF9eeWSZzLaloPgpZTLbDhlCMKjNUw6P9FdkSeGHXnnqu3agJGmiwrjhWpzposZwfvZ87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCijjlzB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCijjlzB"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6wna1023637;
	Thu, 18 Apr 2024 07:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HmV44gSdHHkRTQQml0Kn3wsdu76HyakiT7VCsfUGldc=;
 b=mCijjlzByWeBjxw2AlnU0A2SnkNBlcUAwrIvrmU2vntvZ5i0oK2V0OoB2GZL0kdNEsK+
 6Z8n/DLvjUDgWoTp5nlyl1Q/JBb4q3y7xxxGBbjJfJ9209n+xA8N334JPB/mG4RgEWEZ
 GDhCRfkvi19yRM1+uQmClrARTRA9BEusPA0JzfgtFBZ3T4w0/D2J/Gke7DR0Ru+FKSMJ
 1+E7DRylwvWfNIBOcQGcZXG7ZwfKrWpvhIl7NX2CBNVO2kaBYYt6gGSKeSPOKxDprh1z
 H+3PRw2AwvNyCnh16CWL3r1qFae3skE0Unv4B1bQK/I8VgsHuLlbiKGhGYIPsenh34rS CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjxb985hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:50:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43I7oXkJ003042;
	Thu, 18 Apr 2024 07:50:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjxb985hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:50:33 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5EGss015826;
	Thu, 18 Apr 2024 07:50:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vmhamk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 07:50:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43I7oS7b30081636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 07:50:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4B05804E;
	Thu, 18 Apr 2024 07:50:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0BCD58062;
	Thu, 18 Apr 2024 07:50:25 +0000 (GMT)
Received: from [9.171.41.254] (unknown [9.171.41.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 07:50:25 +0000 (GMT)
Message-ID: <0cbb1082-8f5f-4887-b13c-802c2bbcca36@linux.ibm.com>
Date: Thu, 18 Apr 2024 09:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
Content-Language: en-GB
To: shaozhengchao <shaozhengchao@huawei.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com,
        tangchengchang@huawei.com
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
 <ed5f3665-43ae-cbab-b397-c97c922d26eb@huawei.com>
 <c6deb857-2236-4ec0-b4c7-25a160f1bcfb@linux.ibm.com>
 <cd006e26-6f6e-2771-d1bc-76098a5970ac@huawei.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <cd006e26-6f6e-2771-d1bc-76098a5970ac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PcE1aeck5ymIvLwy-Fkae1MabSMgkvMC
X-Proofpoint-ORIG-GUID: 37hsqy0aTAJeDPGj4reMiALtLEZ8vkIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_06,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180054



On 18.04.24 03:48, shaozhengchao wrote:
> 
> 
> On 2024/4/17 23:23, Wenjia Zhang wrote:
>>
>>
>> On 17.04.24 10:29, shaozhengchao wrote:
>>>
>>> Hi Guangguan:
>>>    Thank you for your review. When I used the hns driver, I ran into the
>>> problem of "scheduling while atomic". But the problem was tested on the
>>> 5.10 kernel branch, and I'm still trying to reproduce it using the
>>> mainline.
>>>
>>> Zhengchao Shao
>>>
>>
> Hi Wenjia:
>    I will try to reproduce it. 

Thanks!

In addition, the last time I sent you a
> issue about the smc-tool, do you have any idea?
>

mhhh, I just see a patch from you on smc_hash_sk/smc_unhash_sk, and it 
is already applied during my vacation and it does look good to me. If 
you mean others, could you send me the link again please, I mightbe have 
missed out on it.

> Thank you
> Zhengchao Shao
>> Could you please try to reproduce the bug with the latest kernel? And 
>> show more details (e.g. kernel log) on this bug?
>>
>> Thanks,
>> Wenjia
> 

