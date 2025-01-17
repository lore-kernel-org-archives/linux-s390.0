Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E18D530;
	Fri, 17 Jan 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128328; cv=none; b=kGXCBPH/VAEmIEdjVOC6K4WKLGXy8quuQfgIT7k8HQyBOvJBOjfMYrCctYW7x+6sGAqfk0x0zIkotOmcBtOn2OM+MY9FRsJ5Wg9sW95XZ37uPJSrtIZu/NjcofeclWolI4XiyEKxtoVAA2dcFxky0YviwYN0EmqEtZprzUlmP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128328; c=relaxed/simple;
	bh=prmmqicUYpBStsmoFjdm2jAAKyf4XrMWxBLTJCmDSII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4euoZxwjVV9rYraddWnZYwRwsDrSNdW+2pCLri23uK864/TWpV9fuzQ3EM5RULUrTBX3+DQF8sVOjs2FwoiFtTSu6DNPWVbnPD4zWNpTaWWIbuB1hkyjdOEpIYkPii5tCFY1eq6KFcAFrZdm+lfYEQu90DgaePxVPLw8iO0iZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MG36Y+v0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MG36Y+v0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEs9sc026521;
	Fri, 17 Jan 2025 15:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NgMqxK
	WUOpakIfsPIMo0duOb1vtEbUYqa9rh5bkaG+o=; b=MG36Y+v0XqJ6Hfrul5/tZW
	rRHV1FnnpQv2IbwxDIwkVjdVMP75/E7uOCWD5WChcxHfQhXzZ82CbwmSIAwDGJzU
	JsqhM4JlPGoib9uU7XUEMjb6c3R0j58vHeT62KT5Rph2nkMV2pqgdc6zKYCWlprE
	loYAIQm+tle0J4pU0GquOykSoS3w7NNAUdK9TsONvcXESQmPC35mQPjEXz3geyeI
	Akcu7d409dVHGSp24QDZWUZYz1kWNL+KLaTo0nD4lpjDhBJDAY1qlJoghYAL666u
	SGYn5YpbaEWwAclRExpteC9xMUQ9ySn6/DeYA6+zn/ZBO3ZlCxzmCcBjokIakavQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpcb09s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 15:38:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HFQVac014897;
	Fri, 17 Jan 2025 15:38:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpcb09h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 15:38:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HF0cve017003;
	Fri, 17 Jan 2025 15:38:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkkf0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 15:38:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HFcMj450266436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 15:38:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E362004B;
	Fri, 17 Jan 2025 15:38:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C69C20040;
	Fri, 17 Jan 2025 15:38:21 +0000 (GMT)
Received: from [9.171.79.45] (unknown [9.171.79.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 15:38:21 +0000 (GMT)
Message-ID: <bfa431f9-333e-439a-b6b0-8fc16e0f38f1@linux.ibm.com>
Date: Fri, 17 Jan 2025 16:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
To: Andrew Lunn <andrew@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
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
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <221565b5-f603-43a1-a326-3f6c568684b8@lunn.ch>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <221565b5-f603-43a1-a326-3f6c568684b8@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T6o-DzzPsUegc7SqRlKFzQJgnbOrOaEW
X-Proofpoint-GUID: pPenGHSo7FPJbt3yb4WCYVgt801LyfHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=494 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170122



On 17.01.25 16:06, Andrew Lunn wrote:
>> With this proposal ism_loopback is just another ism device and SMC-D will
>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
> 
> In Linux terminology, a device is something which has a struct device,
> and a device lives on some sort of bus, even if it is a virtual
> bus. Will ISM devices properly fit into the Linux device driver model?
> 
> 	Andrew
> 

ism_vpci lives on a pci bus (zpci flavor) today. The fact that it is not
backed by a real hardware PCI slot, but emulated by s390 firmware is not
visible to Linux.

In the first proposal, ism_lo lived in on a virtual bus, afaiu. I liked
that. In the current stage 1 implementation that is currently upstream,
it is not visible in sysfs :-(


ism_dev is a bit modeled after net_device. So it is contains a pointer
to a struct device, but it is not the device itself.

I have to admit that the sysfs details are a bit confusing to me,
so I wanted to discuss them first before adding them to the RFC.
But I tried to bring all the prereqs in place.
