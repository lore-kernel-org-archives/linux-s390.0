Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF315F308;
	Thu, 18 Apr 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441468; cv=none; b=M1CcL/sczETC94Nk6uI031Zmtnfr/rgVLWh5K0w7e0tj8/IWUpS5Yk3MyHevYmyPFUNv4GvsAs73n6B3ukjzbM2Zd5BHTbyozhOIukOwF19C7Udxq4t+vy1OR9IUiRyEEh36Hwm1t7TU48WBhjb0EiFPsRsYdYs+k3KoYPsROuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441468; c=relaxed/simple;
	bh=OS1eopgWdWaRom68gxSnrqcvK3I+vQ7mAEjAtD2j/Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrGtoCWwpfsIAmTyS4Hn5LJZz+domy+1WQYaKM5ECSdiM+oW97cZuNeGLUffd4y4aTLJOI5ztUTpspX4jraHq89j/tSH5Pyb5NrZNI+i7yBk9IYZJhPnr7Uu6BIBCRtjhbPUA1RABloK/VIXFLpaXLLS0pbjsFGJA6C8HTN7ppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fsXI2ett; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fsXI2ett"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43IBSvKc011425;
	Thu, 18 Apr 2024 11:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k2SbzdrcCdD/gvsyTXjApTaaKdIy/TKA/AiN1OOH+Jo=;
 b=fsXI2ettbdcy/W9K+zRU72IZCAsDyagjsXC9EXYqS5pT5e0KKzvnjC7y32yqx6BCEmop
 tTr20G/r9UOeK60HSKWI28/6W2kcmFnts2oQCLmpCZYmSbUUann4JxoPhg0GRZZ0G4AY
 FRvc6QmwulGohCLNJaDXntl65Z1fhf3yNfwrrXv8BcKAfSKXOWSX1IHpNk3q9kQTMkzj
 cNVyWQxU5hP267OtGzmzYv4R79ol7hs9Lh4uAPR7F7XdkLAlcW3vMPlCIJ7RimWufuXt
 yRsi+Q4aggjKDgML7uHl4mWr0qF0Zevz4Bo2oKMk6Rx3FMx/tzMbfScBN9IHQFYL5YKj Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk2p181t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 11:57:24 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43IBqfNY019155;
	Thu, 18 Apr 2024 11:57:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xk2p181su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 11:57:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43I9mMBC021365;
	Thu, 18 Apr 2024 11:57:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kkt1vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 11:57:23 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43IBvKUG35586720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 11:57:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C83C58054;
	Thu, 18 Apr 2024 11:57:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08B55803F;
	Thu, 18 Apr 2024 11:57:17 +0000 (GMT)
Received: from [9.171.41.254] (unknown [9.171.41.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2024 11:57:17 +0000 (GMT)
Message-ID: <5b79f874-fe66-4b9c-b8cc-ed691c6981c5@linux.ibm.com>
Date: Thu, 18 Apr 2024 13:57:16 +0200
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
 <0cbb1082-8f5f-4887-b13c-802c2bbcca36@linux.ibm.com>
 <7672ae57-86b9-91c2-b03e-2700b931b677@huawei.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <7672ae57-86b9-91c2-b03e-2700b931b677@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D5B9YXgKKCs1xcDAZn1ROSFyq8AGSQxL
X-Proofpoint-ORIG-GUID: TYkssIbEaA5EuTzpS4JQf0NRzDUryAuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_10,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=938 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180085



On 18.04.24 13:01, shaozhengchao wrote:
> 
> 
> On 2024/4/18 15:50, Wenjia Zhang wrote:
>>
>>
>> On 18.04.24 03:48, shaozhengchao wrote:
>>>
>>>
>>> On 2024/4/17 23:23, Wenjia Zhang wrote:
>>>>
>>>>
>>>> On 17.04.24 10:29, shaozhengchao wrote:
>>>>>
>>>>> Hi Guangguan:
>>>>>    Thank you for your review. When I used the hns driver, I ran 
>>>>> into the
>>>>> problem of "scheduling while atomic". But the problem was tested on 
>>>>> the
>>>>> 5.10 kernel branch, and I'm still trying to reproduce it using the
>>>>> mainline.
>>>>>
>>>>> Zhengchao Shao
>>>>>
>>>>
>>> Hi Wenjia:
>>>    I will try to reproduce it. 
>>
>> Thanks!
>>
>> In addition, the last time I sent you a
>>> issue about the smc-tool, do you have any idea?
>>>
>>
> Hi Wenjia:
>    I have send it to you. Could you receive it?
> 
> Thank you.
> Zhengchao Shao

yes I see it, thank you. I'll look into it as soon as possilbe.
