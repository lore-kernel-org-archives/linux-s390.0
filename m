Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9FE417BE5;
	Fri, 31 Jul 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493244; cv=none; b=qvAamZD/OTspg3LXl2FzNJNUzKgSv1SPQ0IvOY8KRQrCU8nB4tKE3bcxivp5gykzZRKsgq1eAGJg6Jtd6SmsUC0rbpQjGEmjSpGRRxyv0RYAggrj/OJtEQRMKhVtKzgoJHhIKzLmOTay23k5LIGUopsDF3sp1QyC72/qwD7T9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493244; c=relaxed/simple;
	bh=9oObe4UkwkAA6IDKQjqiWTf+YPNcboRDCXYFGZGNBU0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nz28qPSv234AE2j1JHKzgRtiwnRhnwX9WgH0t5Y42laYHGNdF/Jyyvu6vPoETxCV3Q2wAoOZE56ZWLwNOfNEbW1xf0sBTOD2uCuv8IwNz5hhRdJmQPW5z7/fKHx3xgUkAQhiB/W5Hqa234ip97S6ecNrbwxk2J+vh3ugoOeGHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azEpcH8M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azEpcH8M"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8Hphx1230298;
	Fri, 31 Jul 2026 10:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BeEpoR
	TcX0OR0VppOYdTB6AIhVDDsaWHi6x0ZASvTlY=; b=azEpcH8MEerZJAlUYVCQZE
	oZD4x02XUW98P0E1XZpKjv8DM9SK6KHIrM4iLQWpVWEpaUx4vEEd9sjYW5wBmRTJ
	/qc2XC0nkdMDUJOt45RsF1V/Jp3sBAwI/wQvkuOU6EJR70xIm9+GR7+ka45F2xDU
	kFw47rprzBMqJHJR2Cbf6KoVHm8zKWJmlaEHypX4wxZggLZ3EazCrcl3Q7zthp99
	KIdVHob/vF9jo04nUbezmN9eIn+mDMTqzPEE4RnTi5Rv700bBfhelaDJR2FxJVK1
	mugyjeuZ1naEAC0WVKavAOySwfKncyYKr0+2cVV8Ka1u+ks+ObMAs2+18WjJfetg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjkg2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 10:20:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VABLxQ029388;
	Fri, 31 Jul 2026 10:20:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yf77j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 10:20:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VAKMUq27591040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 10:20:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E3842006C;
	Fri, 31 Jul 2026 10:20:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3C32006A;
	Fri, 31 Jul 2026 10:20:21 +0000 (GMT)
Received: from [9.87.137.132] (unknown [9.87.137.132])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 10:20:21 +0000 (GMT)
Message-ID: <769d7245-dcb9-4019-bb5c-ff5130f4f28a@linux.ibm.com>
Date: Fri, 31 Jul 2026 12:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] s390/dasd: fixes
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260727142840.567286-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfX9XaP+4JmOLym
 DDBY8Q28fRs8BTxireKZ0TquULZURJVXOeVfKooLVWTnqGcQWxjG7Hh7nH1EhG4ZB/hPYc2bIBr
 kAzXHiDjZ6q8WfVUfr9km61Znehi2BE=
X-Proofpoint-GUID: Lt7iJOUxsy4dum0txE8QKFO-7Ga9D-Gr
X-Proofpoint-ORIG-GUID: Lt7iJOUxsy4dum0txE8QKFO-7Ga9D-Gr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfX9hrAoWYsxjhx
 FH5RlfgjRyJg3oXXdIKuZg+WRpfg1s6YQVECDH3pmjqXhaj9Ja36U/x+Y/6D1HagDG0H6Wjx98r
 7nVR+wRCwoWepVZKjun4Kb/BJq4qCoKM7eTN7HSfrSpRMg+QaGf2Iyr3Fe9ngHocCNE6Cq6a41V
 BcD2+8V+//JBy+Mq7UHVfDvb0nAoTrerk6wYjzIYHGC9gBxA9bKdM0rBjKSSG/LmtFYBInxg9t8
 u5yT9jZoK3bGSazwYQm28+06vwYI2QOb/iwNLjKcz5JLSSsPeSnJ7SrQAgd6cYmmp80tbO7P9U+
 bpyEF24ChyBPVvH4rE9fEM3ycXzgaoylpnAKpyzndKz0wtwFrLhuPcAM6ASuwwMSWYmVQWre3eJ
 fAlEnN40eyFjmvB2aQrauYnc+b+yWq/O9oJIWcAe0poE/FcNiaIHR4xUq2PoGTdyQJ2wr//BFh8
 qIohGSiULLpNMO02SxQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c76ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vMJE824UCUDTa55BMMQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310077

Am 27.07.26 um 16:28 schrieb Stefan Haberland:
> Hi Jens,
> 
> please apply the following 3 patches that partially address rather
> important issues in the DASD driver.
> Thanks.
> 
> Jan Höppner (1):
>   s390/dasd: Fix potential NULL pointer dereference
> 
> Stefan Haberland (2):
>   s390/dasd: Fix path verification interrupted by concurrent
>     dasd_sleep_on_immediatly
>   s390/dasd: Fix undersized format-check buffer
> 
>  drivers/s390/block/dasd.c       | 14 +++++++++++++-
>  drivers/s390/block/dasd_eckd.c  | 11 +++++++----
>  drivers/s390/block/dasd_ioctl.c |  2 +-
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 

Hi Jens,

do you see a chance that this will make it into rc6?

regards,
Stefan
