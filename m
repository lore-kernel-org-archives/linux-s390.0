Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79C1EE7D9;
	Mon, 20 Jan 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393954; cv=none; b=hR6F6036tfwoyswUCXxQ1AtPWaJzmWbX7lR1qahaU62l1RoX8iiiKd4nhkUs0/CVUuECC+bqNfKvjiSVQvMfbCKqYrvkc0JFD+IdIdTuhb75mu5UIQjkqTq+s/NE26lEIUgYecFd2/HPbuDfLDm8uiFGsHGoAI6gZTkVzxnQTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393954; c=relaxed/simple;
	bh=b1izEIOG/9ykKpvXnFEOtTy6u9+Kx9WqQ3YLIyChENc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO0LAJ11VDAGQVb+qO74S3SsTRhUpW8X6aP9CasufLkHe86m0AXCf2opNPlM6x4MiCBcZS6EqEPaIWFrRCswmOwCZW8HaaFuhSrLsRKm941yXuh8TcLA5SPQG8mP6Er9MWc80VSH8s/Qt/vsqCwwDE6eXBj2DohNRDkvhdxHVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c+5nWuEK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c+5nWuEK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KGZTF3003190;
	Mon, 20 Jan 2025 17:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u11oEO
	UQKzuAopTeuM0V0EwaEGs6wWe3STtKZB1hQS0=; b=c+5nWuEKEWkrqJuTThZLTu
	U4yo0pBtW2BB7kYRUTQnmhRPSeJ2c7mKUAdDHdKsB4gIb+1QScvI1TD4Ie/c19Cx
	11nrlHKWoMsyf1n1nBGB/XmaFep2al97KxwgdSE6+Q+wRCdTrtyHm7kis0KLqlnW
	b4VKfA4NzFBPfnAJEo5Y9KG6ZvlZVX0R9F4mqsv83yiQOQ1JkBEElE3g9qGou2Ma
	gxMpoA2Y65JmpQ2ckQosIhBc2/5s33B2WM4N6xr/dOW5E65h4ECd0C/6z37E/Rn8
	X3FyG3HgbGhTP7DF1g57AIqz4aIRNgLEu67bbjMO4G8fhORw9KRoQk1pJ8FNxH7A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449ga7b3ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 17:25:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KHNh0F012524;
	Mon, 20 Jan 2025 17:25:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449ga7b3nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 17:25:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50KDU5Ad021074;
	Mon, 20 Jan 2025 17:25:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb171as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 17:25:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KHPeZ122217188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 17:25:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E90A520043;
	Mon, 20 Jan 2025 17:25:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40E020040;
	Mon, 20 Jan 2025 17:25:39 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 17:25:39 +0000 (GMT)
Message-ID: <8f973fe8-04d1-4659-ac90-4b76178f6055@linux.ibm.com>
Date: Mon, 20 Jan 2025 18:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: Andrew Lunn <andrew@lunn.ch>
Cc: dust.li@linux.alibaba.com, Niklas Schnelle <schnelle@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <034e69fe-84b4-44f2-80d1-7c36ab4ee4c9@lunn.ch>
 <64df7d8ca3331be205171ddaf7090cae632b7768.camel@linux.ibm.com>
 <7dc80dfb-5a75-4638-9d44-d5a080ddb693@lunn.ch>
 <c2eb6fd7e9a786749d70a17266a04fb50dbd5bb8.camel@linux.ibm.com>
 <85d94131-6c2b-41bd-ad93-c0e7c24801db@lunn.ch>
 <20250120062112.GL89233@linux.alibaba.com>
 <7fc92a63-0017-4d59-bdaf-8976bf8dcee1@linux.ibm.com>
 <13a42088-8409-4603-83d7-4afbfc609f65@lunn.ch>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <13a42088-8409-4603-83d7-4afbfc609f65@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J72ykVmjBOMZiT23CokzoARb4A4nd-tx
X-Proofpoint-GUID: IUYLwCSoHea1O_R1qB8_couGupEx8TYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_04,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=538 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501200140



On 20.01.25 17:01, Andrew Lunn wrote:
>> What is central to ISM is the DMB (Direct Memory Buffer). The concept
>> that there is a DMB dedicated to one writer and one reader. It is owned
>> by the reader and only this writer can write at any offset into the DMB
>> (Fabric controlled). (Reader can technically read/write as well).
>>
>> So for the client API I think the core functions are
>> - move_data(*data, target_dmb_token, offset) - called by the sending
>> client, to move data at some offset into a DMB.
> 
> Missing a length, but otherwise this looks O.K.


Right, move_data() has a length field. My bad.

> 
>> - receive_signal(dmb_token, some_signal_info) - called by the ism layer
>> to signal the client, that this DMB needs handling. (currently called
>> handle_irq)
> 
> So there is no indication where in the DMB there is new content?
> 

The existing ism implementations pass a bit mask in 'some_signal_info'
that can be used to signal which parts of the DMB have data to look at.


> And when you say "This DMB" does that imply there are multiple DMB
> shared between two peers?
> 

Yes, there can be multiple DMBs between the same two peers. And/or an
ism device can provide multiple DMBs that are shared with different peers.


> Maybe i have the wrong idea about a DMB. I was thinking of maybe 64K
> to a few Mega bytes of memory, in a memory which could truly be shared
> by CPUs. But maybe a DMB is just a 4K Page, and you have lots of them?
> If you are 'faking' a shared memory with DMA, they can be anywhere in
> the address space where the DMA engine can access them.
> 

More the latter. Although they can be large, if the client or
application wants to spend so much memory.

Which brings us back to the other thread, that ISM may not be the best
name for this concept. MCD - 'Memory Communication Device', was a
proposals without 'Shared' in the name...


>> I would not want to abstract that to a message based API, because then
>> we need queues etc and are almost at a net_device. All that is not
>> needed for ism, because DMBs are dedicated to a single writer (who has
>> the responsibility).
> 
> But i assume there are "protocols" above this. You talked about
> running a TTY over this. That should be standardized, so everybody
> implements TTYs in exactly the same way. 
> 

Yes, the 'clients' are the protocols above this.


>>> One thing we cannot hide, however, is whether the operation is zero-copy
>>> or copy. This distinction is important because we can reuse the data at
>>> different times in copy mode and zero-copy mode.
> 
> This needs more explanation. Are you talking about putting data into
> the DMB, or moving the DMB to the peer?
> 

The former: putting data into the DMB.
But yes the concept of attached, no-copy DMBs, that was introduced by
ism-loopback needs a better description.


> If you have a DMA engine
> moving stuff around, the data can be anywhere the DMA engine can
> access. But if you have a true shared memory, ideally you want to
> avoid copying into it.
> 
> Then you have the API used by your protocol drivers above. For a TTY
> running at 9600 baud, a copy into the DMB does not matter. But if you
> are talking about a network protocol stack on top, your copy from user
> space to kernel space probably wants to go direct into the DMB. So
> maybe your API also needs to include allocating/freeing DMBs in an
> abstract way so it can hide the difference between true shared memory,
> and kernel memory which can be DMAed?
> 
> 	Andrew
> 
> 
The ism_ops register_dmb() and unregister_dmb() are meant to provide
that API.
