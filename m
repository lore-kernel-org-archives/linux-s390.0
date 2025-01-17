Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC991FC7FA;
	Fri, 17 Jan 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115613; cv=none; b=gJZ1hH7LzNG2yLvaKrFsZNITEifMF6+rTi/fEfgMQlwRnLleVVAFvyvRgxPxQcdW58vR2nogXbKKZovknnrdbLLqcoIF6jqpX9fYiFI8iWeJE+dbXzJfQ338IRxf2m6LPkEw8XUHCc6Sthzkk+isq/xDLTAnwNa+hHmRS8TCwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115613; c=relaxed/simple;
	bh=xsSRIjIkgn9T3QF1O2r1XLv6qGuUZswNM7sUf5cK54k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx/tpgpulXGSA/hPQwwbswhcKhTQ04ibbG4f50I73yO8WksYdjYIzxLY8P03nXxfHDI/BxTSz5QzVUcy4L9TXbNNh4W51Aeubm2Ew0kpN55KRUoZJuA6xY3i2SPip4R76OECuvkZes9b5HfRjnilaxnMof1x/H4A/eLWBEw+HT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H+wQHNeh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H+wQHNeh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H85pKg000849;
	Fri, 17 Jan 2025 12:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sdRtsC
	rS8b3c9WX8npFv2fTaSEgz06Rcf08YZEuFkIk=; b=H+wQHNehe3pMk7uHIZnGjF
	b3VARVC3aOgwCYDGEOmTSJ0jRtUjE+5ThjaYIU/AP6uVEwdbgsHNgsrOUvrdhHOX
	a1I6PFR/VofHI5YQ0tFFrcd2p3F8g4mFRYNXh3GMc78RLA+Ru+PPuXkEBtgxYgnA
	DmgxdcRtO8eSpL6gVRWGxuqxhdA6QCkVVEehmSXO6IUDAYurVca2knoCdXfrN62g
	l2adGSX3ynyoKbEAixgB1Re/hEd6WEkSOoE87zSZEh5ioT/JewKGNrwMCiEh5Ysj
	/mPbmuADH9bBtrVGQA/w+Rrx5XDeJG3dT9uwUBsUK2UIAamqCL9F2nNOOD/54cnQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3h077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:06:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HC6cfu008199;
	Fri, 17 Jan 2025 12:06:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447kd3h075-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:06:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HBvdpD016571;
	Fri, 17 Jan 2025 12:06:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p22ddv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 12:06:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HC6Xvc32637546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 12:06:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B48D020043;
	Fri, 17 Jan 2025 12:06:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 986BF20040;
	Fri, 17 Jan 2025 12:06:32 +0000 (GMT)
Received: from [9.171.79.45] (unknown [9.171.79.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 12:06:32 +0000 (GMT)
Message-ID: <5bb98815-43f8-4ca5-96b7-9b4b0cd77d40@linux.ibm.com>
Date: Fri, 17 Jan 2025 13:06:32 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/7] net/ism: Create net/ism
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-2-wintera@linux.ibm.com>
 <e379f0dd-8ad0-4617-9b24-0fa4756d30ea@lunn.ch>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <e379f0dd-8ad0-4617-9b24-0fa4756d30ea@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nOEOSnOZBmnXAC7Lec3Cd4onq6_Scmbd
X-Proofpoint-GUID: 5YBBgT4p4bPSwkD-KUvDJggrEuxaIREg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170096



On 16.01.25 21:08, Andrew Lunn wrote:
>> +ISM (INTERNAL SHARED MEMORY)
>> +M:	Alexandra Winter <wintera@linux.ibm.com>
>> +L:	netdev@vger.kernel.org
>> +S:	Supported
>> +F:	include/linux/ism.h
>> +F:	net/ism/
> 
> Is there any high level documentation about this?


As the ISM devices were developed for SMC-D, the only documentation
is about their usage for SMC-D.
e.g.:
https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1%20Emulated-ISM_0.pdf
(page 33)
https://community.ibm.com/community/user/ibmz-and-linuxone/viewdocument/2021-07-15-boosting-tcp-networking?CommunityKey=c1293167-6d93-448e-8854-3068846d3dfe&tab=librarydocuments
But those do not go into much detail.

We now want to provide interfaces for other usecases in Linux.

ism.h would be the place to  explicitely state the assumptions, restrictions and
requirements in a single place, so future devices and clients know about them.


> 
> A while back, TI was trying to upstream something for one of there
> SoCs. It was a multi CPU system, with not all CPUs used for SMP, but
> one or two kept for management and real time tasks, not even running
> Linux. They had a block of shared memory used for communication
> between the CPUs/OSes, along with rproc. They layered an ethernet
> driver on top of this, with buffers for frames in the shared memory.
> 
> Could ISM be used for something like this?
> 
> 	Andrew


If the communication endpoints were represented as devices, that sounds like a similar concept.

I think you could implement a client that provides network devices on top of ism devices.
(mapping MACs to GIDs)
As the memory buffers are set up for 1 sender and 1 receiver, it would either create some additional
latency, if you setup buffers for each message or additional memory consumption, if you try to keep and
re-use the buffers.
I'm not sure what the benefit ISM would provide as ethernet device. A shared network card would probably 
outperform such a usecase.
SMC exploits ISM for TCP traffic. There the buffers are kept per socket connection, and a lot of the
TCP/IP mechanisms are not neccessary, because transport is reliable, synchronous and in-order.
Thus latency is minimal.

 

