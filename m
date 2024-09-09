Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773861531E0;
	Mon,  9 Sep 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883344; cv=none; b=nbmxmo/UK1F1334N10Id+Memkm+fbsp6sNeqqJvXp/5ajWNphfxjLtC6eUqTe3Rw6ah29lXt0VJ89EE8O9ZGrXx4hMFD6TInA9AQpJVOw/NxbfX5czCrkqpgPmhOy2sFoa7Ef6K+BuzgN2EnxoVYsyNvpnwtj7irOENt+ueE2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883344; c=relaxed/simple;
	bh=ueCToDbZid8JX2C3swPgzCSjf3onHxH3q5gmhRXImbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2hNtoOZHRiWsW18QhEoSC6CyelCMn0TRsq9b3nkswBKsNckgwiHY/kcxq2Ns/zrz2f2wS4ienSegFu/TpipvX1sctKDnHXyDfLcgJBV+R+EmLJBz8+DLkjdhxftNejwItZ03h2LLgLY8/LgQlD1k+VukSKlTjj6kmNbQaO8RF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzNvkvl1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzNvkvl1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48937mZr021934;
	Mon, 9 Sep 2024 12:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	WK8zaUvTuTLbZmPQBkOXWqV+PiywjNoHX+KbhBAL5I=; b=WzNvkvl1CZxKwyZk5
	gvW29+pPPtGLAiOa0ZjCWqsmJvrBLZwD2PFRVxMTAMPjccIyE7ZEwdU5Xhq92k5c
	OY8CzXDuXehLicdewCrchXIViX23k8z1x7El83L6LNzX6zdmwI/hvK4VbpUo+xGX
	pVgkcVsXUL5e+X+ZIudMaiPFvAmm7YO8fvBzlSp4wOSbcYG9ywnMcbIEfH7MKPKs
	6CT4G6bRDQDjxT8Z//Wq+CpSZl09UJNiqBAZRDXAavWhYFlvXqvUXDH8cliXwtJ9
	xnI30iASLB3qj/IDUm25zLFIgSQlzTlVm0mmYPpUG87K0Qs1QYExdioGQFIb4d2x
	X5Ydg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geja9m2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:02:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489BNtNe019843;
	Mon, 9 Sep 2024 12:02:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25ppa5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:02:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489C2I8628836484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 12:02:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37C735805D;
	Mon,  9 Sep 2024 12:02:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 813E458043;
	Mon,  9 Sep 2024 12:02:17 +0000 (GMT)
Received: from [9.61.94.68] (unknown [9.61.94.68])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 12:02:17 +0000 (GMT)
Message-ID: <d5911cd9-0365-47e8-91e4-f55317b8040b@linux.ibm.com>
Date: Mon, 9 Sep 2024 08:02:17 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Driver feature advertisement
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
References: <20240905124351.14594-1-jjherne@linux.ibm.com>
 <20240906104540.9510-F-hca@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20240906104540.9510-F-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2sGJE3oXWHeW4qFWGRM--t6f6XkUDZmR
X-Proofpoint-GUID: 2sGJE3oXWHeW4qFWGRM--t6f6XkUDZmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=714 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090092

On 9/6/24 6:45 AM, Heiko Carstens wrote:
> On Thu, Sep 05, 2024 at 08:43:51AM -0400, Jason J. Herne wrote:
>> Advertise features of the driver for the benefit of automated tooling
>> like Libvirt and mdevctl.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>>   2 files changed, 47 insertions(+)
> 
> Via which tree should this go upstream?
> 

I'm not 100% sure. Would s390 next be appropriate?
