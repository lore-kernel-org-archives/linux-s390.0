Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BB2F12D4;
	Tue,  4 Aug 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850242; cv=none; b=jCT+TaORARbwsdRB6l1YjQB/jf0xcW0mQl1FrVWqGszRlaJ6iYChAN0h7QknyHiumVbHYzBpL3nqdZ1m0CBoDTePkb3hOhvZTcyU+DxmgQ5UaA7MS0PP/MFeyqW2qQd3o3TK7Q0EHdK+T8aAcFRFd7rhrWB1ZkXGyAzEEu2e0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850242; c=relaxed/simple;
	bh=uD2EAqaxdu2Ad94aZTmRzl9FmKqSuNpzPhj9uHY/iGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsL0nYehLa/CfahSaMk0ZXqZhvcDMCDJq4jJGT70Pu++dmSj1SVk3PgCcA/WHbBeb5OwpZ297g+02jyaz5UGf6y3UNyoCEYPbEdA5oIxAat5SXGU6fA9RfM3Z2qLhQnogjMuemk4sAFykLit7zkhLtINsxKUP1kMYlxBb4Z7D04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X/EruXhD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X/EruXhD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Cmmns865775;
	Tue, 4 Aug 2026 13:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MfBvc5
	RPOR0v3+Yg7LH5RErvSIo9WaYBzAeLOhBgNg8=; b=X/EruXhDvXEuDRGbUdK/nn
	imRH6VmPQ6DcAqD7kIXJIgoSEM41o0/Ngv5XUXF776aMHYW01G7hfNhUniuzX4tO
	Whxw2PgErFUnSeltp5beywxzp62r2dhfJqoK9aNWhWriNnyiXzzop6WO/GZjYpXo
	KLkcB2g2PUbDcs2je9RT+UGEZAUjzCU21tZm/w19Dbu7/OO2/tFPvPud2rfP0pg+
	UY40aqOrHKSDeeIa5AwMku0hQeUXmNQo0KGf9jwY6dQsjM3N9dVF0I870kgYYsAK
	S13qyrccibGzoFgP9BErzbKqDr0DiBchPXhxD2ceGbb5ss2TkeQZDtcST2U/1XMg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3x1k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:30:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674DQF3L003146;
	Tue, 4 Aug 2026 13:30:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyhvne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:30:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674DUWGH42664256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 13:30:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF43020043;
	Tue,  4 Aug 2026 13:30:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F52720040;
	Tue,  4 Aug 2026 13:30:32 +0000 (GMT)
Received: from [9.224.91.49] (unknown [9.224.91.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 13:30:32 +0000 (GMT)
Message-ID: <8c62f8c9-54ca-4fa2-a199-6d7cf0b26f25@linux.ibm.com>
Date: Tue, 4 Aug 2026 15:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
To: Nagamani PV <nagamani@linux.ibm.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com,
        hidayath@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
 <9cda0e57-ce4b-428b-9385-743fdef02789@linux.ibm.com>
 <029629de-ee55-4b3e-a7fb-a693c2b1261d@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <029629de-ee55-4b3e-a7fb-a693c2b1261d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71e97d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Hd0oI2eGEmljHiqTlHIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: SfIb4Tq2tIp9RVOLZ_W_vxkDqpX3sYkJ
X-Proofpoint-GUID: UiRLhOHgbQ7vBwWdMETijgKFUdz2V27H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfX8LaFXWYND0kg
 xzh7G+1UYCHoUkkU9fK7fsj6Jek6g49XPMadOQra+fYnD2owcnvmWWQlONhSSOrEmTIW63wSRg6
 Y9fRfkhAHXvo7mYx4caS+2movBuFQeM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfXzUoPi2ooSV+2
 YTrOXqOe6hYmwKdKAQPL3TQAJJWnbcGfujLo7qEhK+iX4WU9lJUAtyn4cFaQE7deaN4ZmaMV0If
 naRuAsG/rRWMQedYdBunu/E3cKezpM0f+Ir9CKrKL81uh31nWpx66rfmSY0dSctrt/gt4YJPJDy
 P3brvgtc3VGFLRDDEaRijDZmg7oU9402y00bCyW5MIw1sAcH2Q9+fwAn5Mn9uCJQXNcuhSeQSb0
 RvAEf7RvHRbJJs8STVNHxNZL8AJcLiFWKBaeJpFEuSBCbHdaZTaQDakPUpCqPbDDXtHo34PDI+i
 pMgDdyzmTrTTZ91ukZmgddBNDOc8IfrZy/H92GHjwTx+rDFTq+MYUNt52pS9onwz9tUhLm8lp7S
 m3EwHKQxzhViYo1liuivIMUxQafnvnxwRG+J6Mc0NWWBTNVHjK7BXp2EyVGj0TdNrG4lYeXrmvz
 MSo+ojltNNEdeublznw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040107



On 04.08.26 14:52, Nagamani PV wrote:
>> I'd rather continue to work on a more complete fix than take this one,
>> but both ways are possible.
>>
> Understood. This patch addresses the UAF on iucv_sk_list traversal
> specifically. The lock_sock() concern is at a different level and
> could be a follow-up.
> 
> Could you clarify your preference — take this as an incremental fix
> with a follow-up for lock_sock(), or hold and work toward a combined
> solution?

I prefer to work on the combined solution
