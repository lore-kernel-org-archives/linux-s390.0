Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67B1EE032;
	Thu, 20 Feb 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048929; cv=none; b=ZqK4GvfHZxPvshFMBiUT8N09iexthmW/k88Me+UIqgDYeshCUkGMY3r3pYwPm9vrjr4cCUypYo9lTzSoXefJUMkueYETvjDIVgB4OUqOAba2yvZATQvIEFebCRkSGCeJ3lIUpxCezI6e+qUdeKyNVfkS+hnY2xKZAyZyVOuvviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048929; c=relaxed/simple;
	bh=ZVhBmrsyGM13pc4FtlV7FgXQNriRkQVrrI5sFBrJxPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0cQmd1QsdPIv4Yo/6c6R+Pktgr49HBIkvS0EruGsqdqT0N5THGAYAZTU5VrDuTQYBZBzU6NmjNvq31wtmoZS2f30XvI16zag55Hfv2WoY42PlwEKUPJaEYuDysEux2SQi4LJEIx1FPGdv39DGRJMJGjEqK6fgSXID6c1nj62Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BCBjE3Mb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCBjE3Mb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9P5Ko007707;
	Thu, 20 Feb 2025 10:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ujuHnR
	76tvpz4/RK1mGB53DPQfOPMqw3IQtytJ4ILFE=; b=BCBjE3MbWzhhHiXm7FTfNs
	kMYzFZ3jbJ6RpIRvdZRycbPk9IXsF3uSeak3HXGa4CgakTwR2zxVFgwVncxPAslz
	Xe49aKbYy8btQfASk2zgOE/qicxYh9fFYWgXyBjdycn7TJa6xDyiGvYGXrN66SQp
	bBZu+D4oKgQrcnzo+lRV4DUePkocOIhDQKsZWMDGr6AmH7qpA6B/IfFGz5mvCwWj
	G9igAJ56eRrlMJL53PLMjD1iEu5X4cXGfZIFGbPvVGvYvv93MRAh8tB0bQI6h8VM
	iDj/LVK9+ldPBCyv2tq3ACfRN+QA1AhsCev7XijbaEGS3dXD5bChHdhGMzpMt2Kg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qy8cm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 10:55:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KArwS1012824;
	Thu, 20 Feb 2025 10:55:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qy8cm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 10:55:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51K82TDA027050;
	Thu, 20 Feb 2025 10:55:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w0259h9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 10:55:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KAtCDD57606480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 10:55:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82FC020043;
	Thu, 20 Feb 2025 10:55:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF1D220040;
	Thu, 20 Feb 2025 10:55:11 +0000 (GMT)
Received: from [9.171.63.18] (unknown [9.171.63.18])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Feb 2025 10:55:11 +0000 (GMT)
Message-ID: <e44c0761-ea50-4c44-b42c-415dffdb441d@linux.ibm.com>
Date: Thu, 20 Feb 2025 11:55:12 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] sched/fair: introduce new scheduler group type
 group_parked
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20250217113252.21796-1-huschle@linux.ibm.com>
 <cc6996cc-c5c1-429d-ade0-9978b859f207@linux.ibm.com>
From: Tobias Huschle <huschle@linux.ibm.com>
In-Reply-To: <cc6996cc-c5c1-429d-ade0-9978b859f207@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ct2IvKZD6_Q5Diiqy7uyOzOnkv_JcEQ6
X-Proofpoint-ORIG-GUID: vcZh0oNL4zuZdyycl9vyld7y6w1sAvJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200078



On 18/02/2025 06:58, Shrikanth Hegde wrote:
[...]
>>
>> There are a couple of issues and corner cases which need further
>> considerations:
>> - rt & dl:      Realtime and deadline scheduling require some additional
>>                  attention.
> 
> I think we need to address atleast rt, there would be some non percpu 
> kworker threads which need to move out of parked cpus.
> 

Yea, sounds reasonable. Would probably make sense to go next for that one.

>> - ext:          Probably affected as well. Needs some conceptional
>>                  thoughts first.
>> - raciness:     Right now, there are no synchronization efforts. It needs
>>                  to be considered whether those might be necessary or if
>>                  it is alright that the parked-state of a CPU might 
>> change
>>                  during load-balancing.
>>
>> Patches apply to tip:sched/core
>>
>> The s390 patch serves as a simplified implementation example.
> 
> 
> Gave it a try on powerpc with the debugfs file. it works for 
> sched_normal tasks.
> 

That's great to hear!

>>
>> Tobias Huschle (3):
>>    sched/fair: introduce new scheduler group type group_parked
>>    sched/fair: adapt scheduler group weight and capacity for parked CPUs
>>    s390/topology: Add initial implementation for selection of parked CPUs
>>
>>   arch/s390/include/asm/smp.h    |   2 +
>>   arch/s390/kernel/smp.c         |   5 ++
>>   include/linux/sched/topology.h |  19 ++++++
>>   kernel/sched/core.c            |  13 ++++-
>>   kernel/sched/fair.c            | 104 ++++++++++++++++++++++++++++-----
>>   kernel/sched/syscalls.c        |   3 +
>>   6 files changed, 130 insertions(+), 16 deletions(-)
>>
> 

