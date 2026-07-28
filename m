Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1A3FC5AA;
	Tue, 28 Jul 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785232280; cv=none; b=E1r4/EJUrmLJyZbwKpckDEfuNA/KcoAaRQSclmU9XnfY7cE34gESdy40eFfW94nb+8+GL9cBRIWyFKjLv4r/LCZapXgsXZkb+Wbt2QIND7eR8AyftNF3gEAgWwvIg0J9QHNF8i1HF4x1T3VzT72NcwKMe7GKSXgeQRrr+4JvkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785232280; c=relaxed/simple;
	bh=5bqZR58k9VyTcQeA3w194QZQ3+EBOuFEbYqBB5YO8QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKqCZglANI2k2nYeCOzCBkr6I0VgQubAf/k2KgE1nvT2beEfGFiCNgQ67Dqj6aUsynm0sfxQkNaEZfCN816KH2rpRhFW+c5N8ck0map9L/2Vh34PC3iJ/4j42jNRUWFuyOHY+j74+RlOcJRdO/oTpx5pa0J8BE5JVw/U8haIfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HmnE8XgM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HmnE8XgM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8HcOj511714;
	Tue, 28 Jul 2026 09:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ROplq/
	hcU2gsOgtYAUb4UUWvw13VseDqKzURE12GY0I=; b=HmnE8XgMRRPlhrCAum80DP
	LSctQiv1v7CT3tLhAQzzpeZ9D/3vY5BOf010AalIe2s3bTVmmBvQOltQe7gmALKx
	+Cx3/mByO4zLnjkJXoZD+adqJUKAC/iEfVMjTtBuriPmP67XVeTNwq28hza8iyUK
	oznM0hDNGgkZAdyefcnLP/tpD30tf/yO1wqp5+fXunUet5RKi5qJAGgzJWTBKv/b
	cx7jgUTdj1IKd24QH1E/5CL2aHYEw71Dovtk0sz0JLtSHEmpEPlxAaS+lblgkRde
	W2x+hYt4yz3MGS4ZIKHH9IEtiDW9yP47BNyQfS16iPPNlqY9EbwZwrF1RTYX3JRw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xmhv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:51:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S9fJes022957;
	Tue, 28 Jul 2026 09:51:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg910c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:51:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S9p5Ve32244048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 09:51:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E74720043;
	Tue, 28 Jul 2026 09:51:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1441B20040;
	Tue, 28 Jul 2026 09:51:05 +0000 (GMT)
Received: from [9.111.67.171] (unknown [9.111.67.171])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 09:51:05 +0000 (GMT)
Message-ID: <09e9a0f4-48c7-4e63-a6f3-dae61c1f94e1@linux.ibm.com>
Date: Tue, 28 Jul 2026 11:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/crypto: Replace cond_resched() with schedule()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-2-hca@linux.ibm.com>
 <f88846b24b1250f89b503b6ddfda318c@linux.ibm.com>
 <20260728082948.13361Ab7-hca@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260728082948.13361Ab7-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FP7mdeo-xiPscPLzBLDIyZ8S-AlsRWNN
X-Proofpoint-ORIG-GUID: FP7mdeo-xiPscPLzBLDIyZ8S-AlsRWNN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4NSBTYWx0ZWRfXyoc036Q6jSO7
 cX+oAUkIFzYNREqsTAZYzWur8g/yKCryhNSZGGn1aiUJ85ePipZf/NJdJ1o/raNiyehdOMGC+0J
 Sk+C82g21XIYh77qZJ7apjMR0xkRDzY=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a687b8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=aCFUBb3aLFy8RMfsWHIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4NSBTYWx0ZWRfX3NPkFFbn92q1
 WMkB8vUA0PofHxLFuJ1yhH4YOClwG3rObE2zoLNcaxfIViytnkyZxJ7ZvkoWRpPOMlburvplEUa
 1XEZ6KpL0bwnhwgmCtbt3cJhZaf85WNemT4BVLB9/462dnyLSzJcNj+DJgx7lDk1xgnBbBZX5e/
 3Y+TnGe1rrstYaNP/RSx6mr3vNgJSETC5ZQyx9uBBskHfJjfXQno1vCV4gImSObhaE8QScwj0w1
 mIHttnsLmqI7hc+AuKfO0fR9xQcHO0+XhOsWBq/WfSsp+cOwhmuCOqPePNOrx/XPGfEDfQg6wSI
 Zh5M9DOklNWyUDmbtdEVZ/umWtHRw85XoS235aD7jJ/gCjmGVj1HSIao9ekC6wUQeFZmN59sAyJ
 vc43LnJCxuwtCmfaDW6OWQFpG9pxxtwtNznCOJF5+oXqdiDte9LTu+Pw6JHnxu2J6G9Tr8Fmflg
 C8eh6b45GfynrTTPGSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280085

On 7/28/26 10:29, Heiko Carstens wrote:
> Well, the main question still remains: why did the code use cond_resched()?
> 
> This doesn't make sense to me, at least when reading the comment. So to me
> even the schedule() approach I proposed is questionable. Why didn't the code
> use msleep() instead? Or can we just remove cond_resched() entirely without
> any replacement?

As the comment says, if possible, the scheduler should run any other 
workload in case of a -EKEYEXPIRED, as the re-creation of the protected 
key is in progress.

My current understanding was (and still is), that cond_resched() (or 
even schedule()) is doing exactly that: give back the control to the 
scheduler. If this is not the case, but msleep() is doing the trick, I 
would vote for msleep().

Removing the code completely might also work. The situations, where the 
protected keys expires are very rare (once per protected key after a 
live guest relocation). These situations are hard to trigger and we 
should test carefully, if the removal works in all cases.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

