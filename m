Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1161D8E12;
	Fri, 17 Jan 2025 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118869; cv=none; b=QsbKSrQV23x/oDUmrDvmjskpS0GE+4ZsIbI47IDx59q7KnF2BasZb9zI44nSNX1e1F2RWnbCH3mg17iVllG/vSJ1a9HADL2thBvr7/7dfAUrWWy7iWBGNtBRS7eZjKIDcnoWK7oY0xmOwTBFH5meuo40rkT7jUHpZCSJ/F9uDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118869; c=relaxed/simple;
	bh=DtBqAiwYn1HCqeIYoElglq++muGygnstVIbpQUGUEaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EihlBMBrqsXb1CPMseG5d9hf+NmPduLVFAOITRkCzm95yNwRt5Z6bZUdVjdIEayAac49bOtfJtl/8vmdc7nsrhJA73V2Se54zNWETntlwwRxi0MlIIvLd8asMZNKbPo9krOhYUICB+gwd19KhCCQI/FEUV1mdr6uoRo2VYd0Wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D1upPy8o; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D1upPy8o"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H3qZwa025351;
	Fri, 17 Jan 2025 13:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VVs+K3
	EeTYV4VAov0c8Y1wSaOO4Xz6nw+zDYObs71SM=; b=D1upPy8oNwiZdMER5PcS/6
	N8GKU40nSSifdc/HS7vd/WkCfsL5hXBINDpouud2Yq4nZPKHC3MNX4U6SI2QY/Xq
	pgSq/sLQTtKGxdQeQieM+/6csIbfc4iGAwpSPQTAamGpQ46mJYb5/isQNG67qj82
	ctpjxEy4m4YBSXs+eN4XStUTsET+7c6JVFa+vewyBUk/eRin7Sk7RQF0Cy0xcqPw
	84cwZuT7K3tLsokKPhz3fGijFo3CLIeolpgieObZMqMACvvVf6WktUSfA9/75HVw
	DzmK+SREgM/4pF/eAMQFeZSFEMqNNWqYrQbPbEo57G5CnQwS95Y7KPFOvEbbqgHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpca7wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:01:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HCoqkV017532;
	Fri, 17 Jan 2025 13:01:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpca7wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:01:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HA2Zhm016976;
	Fri, 17 Jan 2025 13:00:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fkjwph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:00:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HD0tQR18612708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 13:00:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A4C2004B;
	Fri, 17 Jan 2025 13:00:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8CF20043;
	Fri, 17 Jan 2025 13:00:54 +0000 (GMT)
Received: from [9.171.79.45] (unknown [9.171.79.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 13:00:54 +0000 (GMT)
Message-ID: <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
Date: Fri, 17 Jan 2025 14:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Content-Language: en-US
To: dust.li@linux.alibaba.com, Julian Ruess <julianr@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
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
 <20250117021353.GF89233@linux.alibaba.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250117021353.GF89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SeGWHKV7ATYFQYJvRA1LeG8J6pmYe63s
X-Proofpoint-GUID: 5ZWIpIwTbc2xkdAZUOLSN3Eiew2tp0C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=258 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170105



On 17.01.25 03:13, Dust Li wrote:
>>>> Modular Approach: I've made the ism_loopback an independent kernel
>>>> module since dynamic enable/disable functionality is not yet supported
>>>> in SMC. Using insmod and rmmod for module management could provide the
>>>> flexibility needed in practical scenarios.
>>
>> With this proposal ism_loopback is just another ism device and SMC-D will
>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>>
>> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>> removal by ism_dev_unregister(). In case of this RFC that would only happen
>> in case of rmmod ism. Which should be improved.
>> One way to do that would be a separate ism_loopback kernel module, like you say.
>> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>> I also think it is a great way for testing any ISM client, so it has benefit for
>> anybody using the ism module.
>> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>> (Once we agree if and how to represent ism devices in genera in sysfs).
> This works for me as well. I think it would be better to implement this
> within the common ISM layer, rather than duplicating the code in each
> device. Similar to how it's done in netdevice.
> 
> Best regards,
> Dust


Is there a specific example for enable/disable in the netdevice code, you have in mind?
Or do you mean in general how netdevice provides a common layer?
Yes, everything that is common for all devices should be provided by the network layer.
