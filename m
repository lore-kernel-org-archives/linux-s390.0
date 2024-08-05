Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A813D26B;
	Mon,  5 Aug 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846214; cv=none; b=MvHduk1ltd+S0KsHdMHb0ElOnQIiBNvMv6oqxupdiRrHIicquD++yX/Tq8GSYwvnRxOcyH3fk5DW7xmlOwmrDbwip1Sa08J2neJR4GjQiUBJfMaM1QA1iXOet3wuMhLI6rqDQTpvS4TR5gq4njV7CbRWyTfCkRzDkhFOpkEDLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846214; c=relaxed/simple;
	bh=bPKmx/tAHgCR1rUrgpNdp5DjTRrC8+TNRyW72qLLc2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6YwV4iKwZAJdIVKhSwOSDs+d3LrQX/s9d0JBULIDGuX2quVr1PEu+EgVDliMdlV/KtEBY8SsTfF4SbaJqmEyel2w85qdhPsZ7MO3HFbtPUKEyXElX0Fr26w6SQGllhm/xBvAKOi89eVKjRFz7mYLCg0K3WYoQGTGBel5tpRne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8kbyMNM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8kbyMNM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758Mjfc027344;
	Mon, 5 Aug 2024 08:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=X
	LzBGo0fwAbtj6MJ0AMenJWD3iUI+Q2yHWMxW10eWHM=; b=U8kbyMNMojb8JUL45
	Oc3AeCJrHCFFXO2Jr6byVCMN2v5FzxkXNAJGDfMU4gQosCB6I2Fnh+10xjqgGWUx
	L6nT7LYNjnAjSJ4vIH4MYCH7MuEdXDtoR9bxfekHDRt+GLsoWPV6DZpvoUKsn7JM
	PA5YnnBoIoq8Wl7DqRsO1TvU7NM92YULxapyUC60MZM/MjO+m2Js/CiogGRCgrqo
	X2ccXV+RYoToTtlvQDK8i6uNX2UNyBmORKFkwzs2HR82v5IxIx2gBLQJ2lJ3zeAy
	NvEhuLyRmUwhxySpztKe65ujJHcqyLjUG1x7ppqfeK+qMVTojOo969sDtKnoODy/
	Hsn4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tsxer5ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:23:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4758NLIW028173;
	Mon, 5 Aug 2024 08:23:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tsxer5g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:23:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47546g1t006385;
	Mon, 5 Aug 2024 08:23:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t13m56fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 08:23:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4758NIJh57999780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 08:23:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53ED458056;
	Mon,  5 Aug 2024 08:23:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F5CB5805A;
	Mon,  5 Aug 2024 08:23:16 +0000 (GMT)
Received: from [9.171.14.14] (unknown [9.171.14.14])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 08:23:16 +0000 (GMT)
Message-ID: <800b1186-2d87-4b20-9d38-b4fecde161f0@linux.ibm.com>
Date: Mon, 5 Aug 2024 10:23:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: delete buf_desc from buffer list under lock
 protection
To: Wen Gu <guwen@linux.alibaba.com>,
        shaozhengchao
 <shaozhengchao@huawei.com>, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240731093102.130154-1-guwen@linux.alibaba.com>
 <ef374ef8-a19e-7b9b-67a1-5b89fb505545@huawei.com>
 <dedb6046-83a6-4bda-bf1d-ae77a8cda972@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <dedb6046-83a6-4bda-bf1d-ae77a8cda972@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFlZnaG5VPGS5Tib4Ium3cTkJIs7gNaH
X-Proofpoint-ORIG-GUID: ifLCTVxFfKAnsx-FLFu0CAt-yu7ZxsJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=795 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050059



On 02.08.24 03:55, Wen Gu wrote:
> 
> 
> On 2024/7/31 18:32, shaozhengchao wrote:
>> Hi Wen Gu:
>>    "The operations to link group buffer list should be protected by
>> sndbufs_lock or rmbs_lock" It seems that the logic is smooth. But will
>> this really happen? Because no process is in use with the link group,
>> does this mean that there is no concurrent scenario?
>>
> 
> Hi Zhengchao,
> 
> Yes, I am also very conflicted about whether to add lock protection.
>  From the code, it appears that when __smc_lgr_free_bufs is called, the
> link group has already been removed from the lgr_list, so theoretically
> there should be no contention (e.g. add to buf_list). However, in order
> to maintain consistency with other lgr buf_list operations and to guard
> against unforeseen or future changes, I have added lock protection here
> as well.
> 
> Thanks!
> 

I'm indeed in two minds about if I give you my reviewed-by especially on 
the reason of unforeseen bugs. However, previously the most bugs on 
locking we met in our code are almost because of deadlocks caused by too 
much different locks introduced. Thus, I don't think this patch is 
necessary at lease for now.

Thanks,
Wenjia
