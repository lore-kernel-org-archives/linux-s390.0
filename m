Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A821F8905;
	Fri, 17 Jan 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111861; cv=none; b=qYpgS7TcURWowjJ2Ld85OUHwXaF0eR9Q5CwAGlCwJmFL7lJ4ha/0h7JbQ8CXXhgYqKCsnwuWmMd/KzSY/SCNQcULSqcoeJZwze8r7GF/+O3QOSy5abue075cbuSppAJqROwrNC6TAKZydVParoLDD8xCuECw6jgpwwZGtR5qEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111861; c=relaxed/simple;
	bh=6dHuOH8tZH87hfcM8Zo2QAgoWHdytFSqcuRVEsj8ANo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgBDuMyhmvfBz5OW8QuWfOVfaC6GvttC0wHgKzZUyeGHuGs79vq3Q+WqfpWC1lNL+glmN22IcXSRvXC4hO0IHzFMDfSta/Dq4GvYiWS29KZg65YOSOiVeP9RXJWhrw46O9n8PeRTtb22oaK5pC8/59hLLimOVKzfrYk7HBsK26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I8isLou3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I8isLou3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H3qqqP025512;
	Fri, 17 Jan 2025 11:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z9VWwi
	BIRwOvxV6QcNBCpok231Z8erNJNcVDezJ2D9s=; b=I8isLou3gvy/gUm+1E2Rdn
	4eczJ4fy6XOuIIdA1NljyFHIyuyx+Ve8g+7NIVFe5YUdn4hGyEl4QXlGqWzxFsT6
	wUuUr0QRoscnNT5bzCVkvAz+ZdnTfDP9PbOCg2QZ7EctglX1WgMNLu5MS7Iart8R
	ENRxpkrk4o8MR/teACfzkhB0pj2tcEK1pfeXgDN19ao2nRCROztMA2oCSDE/HbOz
	kygobWZPyIdQaL/ddY4qcyYUukKRSHBuNo/hjKPaiEpjRr6m+mrHlRKFrfECT+LU
	NGAXJj+wtS5SZz9tIBFc7HleCMpWhrvPTsN2PH999fX8j4x0EcK5D3+zC7vLrfhA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpc9qua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 11:04:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HAx2dj007845;
	Fri, 17 Jan 2025 11:04:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpc9qu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 11:04:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50H7ZdbA016571;
	Fri, 17 Jan 2025 11:04:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p226sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 11:04:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HB47m052888048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 11:04:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0632004B;
	Fri, 17 Jan 2025 11:04:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BE9920040;
	Fri, 17 Jan 2025 11:04:06 +0000 (GMT)
Received: from [9.171.79.45] (unknown [9.171.79.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 11:04:05 +0000 (GMT)
Message-ID: <235f4580-a062-4789-a598-ea54d13504bb@linux.ibm.com>
Date: Fri, 17 Jan 2025 12:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: dust.li@linux.alibaba.com, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250116093231.GD89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bc5ul1wygm9gBnHl7Y7C9AI4itJqMy-3
X-Proofpoint-GUID: 4hgNXehnU4vmNjx6aiB2Sb3C9yGOnPjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=654 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170084

I hit the send button to early, sorry about that. 
Let me comment on the other proposals from Dust Li as well.

On 16.01.25 10:32, Dust Li wrote:
> Abstraction of ISM Device Details: I propose we abstract the ISM device
> details by providing SMC with helper functions. These functions could
> encapsulate ism->ops, making the implementation cleaner and more
> intuitive. 


Maybe I misunderstand what you mean by helper functions..
Why would you encapsulate ism->ops functions in another set of wrappers?
I was happy to remove the helper functions in 2/7 and 7/7.


This way, the struct ism_device would mainly serve its
> implementers, while the upper helper functions offer a streamlined
> interface for SMC.


I was actually also wondering, whether the clients should access ism_device
at all. Or whether they should only use the ism_ops.
I can give that a try in the next version. I think this RFC almost there already.
The clients would still need to pass a poitner to ism_dev as a parameter.


> Structuring and Naming: I recommend embedding the structure of ism_ops
> directly within ism_dev rather than using a pointer. 


I think it is a common method to have the const struct xy_ops in the device driver code
and then use pointer to register the device with an upper layer.
What would be the benefit of duplicating that struct in every ism_dev?


Additionally,
> renaming it to ism_device_ops could enhance clarity and consistency.


Yes, that would help to distinguish them from the ism_client functions. 
I' rename them to ism_dev_ops in the next version.

