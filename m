Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B346D549;
	Wed, 22 Jul 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722326; cv=none; b=f8A9riVKCu2u0zajiRWsqGI4F51t+fL6m+j5pt9J08Pd3JaQUb1FbBwlZf9AUURXKTeC+NQzTHncdbg1xMHf0BegS7eIxXImXQ9ltLWGOCHiqkHHIAC3bAUyD75h2HCVO+Dj4auiwncUXHhd3BuijqskyKzDDnarPhYkxvZxQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722326; c=relaxed/simple;
	bh=/xyQbuG5uXhjiKE0u6K6hvoXeRAFOJV5WHgm2KQ/X/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX2WrKF0Bkpep3k/Zrj8ORjAjYubumBpk8yAC+trQoygVYHOD4YuZo0mZ3uuoqRqUGnwNykdVh9wU8Xj55Zjby5QBwipYB9o+vrvusamR+wRFlIrPwWQ6yecKCqTEtUoudoXJG4G3Lpi7P1P++Dj89JPQ4ocGqRCpCbL5zMKTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAhKy5Rw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAhKy5Rw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9BmIH3671370;
	Wed, 22 Jul 2026 12:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/xyQbu
	G5uXhjiKE0u6K6hvoXeRAFOJV5WHgm2KQ/X/Y=; b=EAhKy5RwdgLkFgSoqfFq+X
	TgUfvlCB0/jJlBP9nOTk2CmRU1BPWluSls7s5X9P4UtrUCfbJQxYm/zW5JbhvFBI
	rVsrq6/SEnRn4A4JD4ScY++LzJU1oAjyw+E95Y4+FQadWgjcbmG2Py03/q3BvoDt
	WgUyXtNl9+eLtn+k/vg4mPSI+PhhNDuj5Y+iq6wuyH0NoDEmab5JPzvLNZwB6CzG
	bs+/Z62wyrDkO99J588Q9GqykqA74ZAsCBPpwJttIXnQKufFeoP0UrAyggMjvw6n
	wytcVJR8DWK1on1rqJeRzr1YbUyGCbnp09PZOxnwwLw01/9YYnFgbo17vu5OBLHg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah9hmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 12:11:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MC4bx5021954;
	Wed, 22 Jul 2026 12:11:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq7by7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 12:11:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MCBp6q62914960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 12:11:51 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 579ED5805D;
	Wed, 22 Jul 2026 12:11:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0ADB58054;
	Wed, 22 Jul 2026 12:11:43 +0000 (GMT)
Received: from [9.224.66.107] (unknown [9.224.66.107])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 12:11:43 +0000 (GMT)
Message-ID: <60a17e5c-e50a-4e85-9562-6ec398789584@linux.ibm.com>
Date: Wed, 22 Jul 2026 14:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS
 (SMC) maintainer entries
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>, aswin@linux.ibm.com,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>
References: <20260722085705.56755-1-wenjia@linux.ibm.com>
 <453f43c3-e27f-4688-88db-19cc7f668f94@linux.dev>
Content-Language: en-GB
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <453f43c3-e27f-4688-88db-19cc7f668f94@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jumzN9e4GoSQIf3t5lKKX4f-LoyPZE8u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExOSBTYWx0ZWRfX8ijCchiyQ7Ta
 rKzXyOXdRURFfBtfrh5Qnp1LyDO/gX4XwUMuXSSAyNZJVva1pghJSwbHoGok7PyPwPXbyWBHPfL
 xpbv9k1EClHYF/veHPCRa6KY+IqDqoPNnX4Km/a50E//dv+JaYdLHN3CwWE2fAr/tn4E3pI897C
 2m7JPg6RVqnlT7PuXKnuJlF5fKlrGhD+HCaCry04DEV1vf5aFytCcZPO/9CBqjcUsp7cbR9X8CK
 4bkD4R6Sg3u+x+8s1WmJXRKUGaoK2Nz0icaeFtrJvQp94dqHBWJUX3sXLzjLVk5iR1TxDjrRAD5
 8G0iR5vWfhsWoaWMzAtvmHQ8Q58ctIHNlg5Y7PSqsOdIqm/fqCPOn6fRTJ4LYdGGUrVXneXhjJ4
 icP87N06wjLZn/Ror3L/kxO6AWQaSBrEY6Ay8jG0SEt4M+8KCVg04NcKKbDbFbxVEKLQpYlWclf
 01crt17fyT/bw5BlGeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExOSBTYWx0ZWRfXz5bdUXxyzadt
 F6RuXGzcczKNRTgcB+pUvRUH+TWhF6GgBaaKRJ9XbRC9dm4TSht45xTO1PydeGoTfPBug6slbiH
 VtbnEYnAj5lzlOW03taujghTAOIXm14=
X-Proofpoint-GUID: 8MnGqe8DGCUQ9O7MkmtQFL3gfPzx26OP
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60b38a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=-6nGRnc1cQ322fPTUM8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220119


On 22.07.26 13:06, Vadim Fedorenko wrote:
> On 22/07/2026 09:57, Wenjia Zhang wrote:
>> Due to a change in responsibilities, I can no longer serve as an SMC
>> maintainer and need to be removed from the MAINTAINERS list.
>>
>> To reflect these organizational changes, promote Mahanta Jambigi
>> <mjambigi@linux.ibm.com> from reviewer to maintainer.
>>
>> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> ---
>>   Kernels.code-workspace | 1 +
>>   MAINTAINERS            | 3 +--
>>   file                   | 0
>>   3 files changed, 2 insertions(+), 2 deletions(-)
>>   create mode 100644 Kernels.code-workspace
>>   create mode 100644 file
>>
>> diff --git a/Kernels.code-workspace b/Kernels.code-workspace
>> new file mode 100644
>> index 000000000000..9e26dfeeb6e6
>> --- /dev/null
>> +++ b/Kernels.code-workspace
>> @@ -0,0 +1 @@
>> +{}
>
> this is not needed part...
>
right, thx, will send v2
>
>> \ No newline at end of file
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1ab8736850ea..f60ccc62e710 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24631,8 +24631,7 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>>   M:    D. Wythe <alibuda@linux.alibaba.com>
>>   M:    Dust Li <dust.li@linux.alibaba.com>
>>   M:    Sidraya Jayagond <sidraya@linux.ibm.com>
>> -M:    Wenjia Zhang <wenjia@linux.ibm.com>
>> -R:    Mahanta Jambigi <mjambigi@linux.ibm.com>
>> +M:    Mahanta Jambigi <mjambigi@linux.ibm.com>
>>   R:    Tony Lu <tonylu@linux.alibaba.com>
>>   R:    Wen Gu <guwen@linux.alibaba.com>
>>   L:    linux-rdma@vger.kernel.org
>> diff --git a/file b/file
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
>
