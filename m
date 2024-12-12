Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD841E89C;
	Thu, 12 Dec 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999811; cv=none; b=lVhx2Zql1XTvFL+oJznrrIb1lTm7RXhVWEZTUgoRXWXViz807jS3WQWvyA0tJCDlTG6JqrNsvNfo616nZSIOSUCQssXQJNcguUXd1pr2qdSqLj4TwezFeb2NCmLryYvoUTUq/85PHVTRQmpCnYXMCfWnXcFfhhU3W1JJgQmPDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999811; c=relaxed/simple;
	bh=Op5yf32g9TOumU+/rU3vOMZ4PAryy+8pHaPZSN+FjOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6diAW0REIZXQAXJ8+Z+Z6HTSoK6wsMHV6fHzr11xHs++SHa8dKLfGNAeJZNKgtafUfaY8ZMccWjnleBN63MyfIhsDQc8ZwOC1aIq3uYLT5vBRgNZTNMvLZjBHff+usFZm4dtkXK0BaScRHZ3UPjAP6dWyyJO/FQEAVjFEhyPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B2zeNUaC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B2zeNUaC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC69ACx030550;
	Thu, 12 Dec 2024 10:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Op5yf3
	2g9TOumU+/rU3vOMZ4PAryy+8pHaPZSN+FjOU=; b=B2zeNUaCGCI/7NznPSvMx2
	AQ/9U83PTERNreHFL7kuHJ0n7bRMWsUH9nG0YARxRwpn+UJOCiyiQZe3PuFUTOum
	UuIzjDobg5H5pntL+MChhxKGjJ+5cjuCrS6mh9k62w8hc19OuDgQ74VeaAoi5iQv
	pBaPSVCJUrsD/bA3uQJTsfv01pFtdCVAKWgURQjlcDw3isgJeBrr/WWe7rMjw+GT
	QhpelPj3XCPsxotPGtTuraIR2qr25oYteW+vTWEVBaNYaIV2AseBen5TeR6lyxd6
	+wATNHXgdgT+NK1qcMMADoAiUl8NC3yK+RpnNEO+Us6FELP/RrqhZ7IhwxdH7qaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1w3per-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:36:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCAXHI0024097;
	Thu, 12 Dec 2024 10:36:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1w3pek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:36:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9bO1f032739;
	Thu, 12 Dec 2024 10:36:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psr1jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:36:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCAaZOb55837086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 10:36:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E7D2004B;
	Thu, 12 Dec 2024 10:36:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BC620040;
	Thu, 12 Dec 2024 10:36:35 +0000 (GMT)
Received: from [9.152.224.86] (unknown [9.152.224.86])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 10:36:35 +0000 (GMT)
Message-ID: <f10497b1-e27f-43b6-81e6-bedfc8bc93e9@linux.ibm.com>
Date: Thu, 12 Dec 2024 11:36:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Dragos Tatulea <dtatulea@nvidia.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <a8e529b2-1454-4c3f-aa49-b3d989e1014a@intel.com>
 <8e7f3798-c303-44b9-ae3f-5343f7f811e8@linux.ibm.com>
 <554a3061-5f3b-4a7e-a9bd-574f2469f96e@nvidia.com>
 <bc9459f0-62b0-407f-9caf-d80ee37eb581@intel.com>
 <54738182-3438-4a58-8c33-27dc20a4b3fe@linux.ibm.com>
 <89c67aa3-4b84-45c1-9e7f-a608957d5aeb@nvidia.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <89c67aa3-4b84-45c1-9e7f-a608957d5aeb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7L9s-Ny2rPyhePN9q9L9qpbZDemvRdKy
X-Proofpoint-ORIG-GUID: 8Q-We0TaB2HNx-Xa6qoACCUbGOyn5mTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=727
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120074



Am 11.12.24 um 18:28 schrieb Dragos Tatulea:

>> My preferred scenario for the next steps would be the following:
>> 1) It would be great if we could get a simple mitigation patch upstream, that the distros could
>> easily backport. This would avoid our customers experiencing performance regression when they
>> upgrade their distro versions. (e.g. from RHEL8 to RHEL9 or RHEL10 just as an example)
>>
> Stupid question on my behalf: why can't this patch be taken as a distro
> patch for s390 and carried over over releases? This way the kernel
> upgrade pain would be avoided.

This is not how distros work today. All code/patches must come from upstream
and all code/patches must be cross-architecture. There are exceptions, but
only for very critical things.

Furthermore, the right answer to avoid upgrade pain is to fix things upstream.
So lets try to find a solution that we can integrate.

Christian

