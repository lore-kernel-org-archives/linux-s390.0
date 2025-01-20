Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E21B414F;
	Mon, 20 Jan 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368976; cv=none; b=mAEGip3l1I5S9eGQxlD/6d4Tb69ZS1OBYPF+Ghm7P6E/PyTi47pTyCcTGNwWNMSHnBTH1qjO0JKjfK4Sqso44D5f2F1u4mPPf4anP7Bd6s6bpNcr/KYERdwgseCuf9EPpxTNkzd9cR/0U0dPPJIgdthTTdTdn/bu29ylzy2F5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368976; c=relaxed/simple;
	bh=CXpgN0NJC8aZGTtFbSm38FYutnKk3xB+Dh1aIBugdPA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A4frki7IxMvaf5NyZvpdnMg7NAxa7ertBdxUB/bQVy2TcFzi76JyqK/utaQ8N4DlwE4lnu6b97Jl6ZY/zoMAoGjs3FzabacG4d/fbRigJ1+0LwSHyM5zg3RW9F70TaytytffmGi1GrU8I3fY4oS6lQ1zjD/r2DhBv/BN5fIH6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KJrSBXt0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KJrSBXt0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K18YaV030661;
	Mon, 20 Jan 2025 10:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/69y94
	G8dRvRRIaSAGqCqhaLVhSJxVfFfp1VbVqaEeU=; b=KJrSBXt0pp/k+101enHd94
	EIA/S9n3ZZ3UOFVgmOosHR1VJnIjHc6+NzJL0o3jt7CL27LytYVwH1F/IxIddyzY
	Dr1rHNUfo6dtuGBy1ivFn5JViSG9YH87uWPFuU1ocs6fgl8ypleFog70NGGfTL6D
	03TeuZER4XmWXhV/vpFFM7zTMw9i5WaUOkwqwOts1ICmCAyaviCLAdsikWM76Ihi
	RY5a9G0eJYlbhzvxxDVQPjcFsnNr2hub3wm3SkhbpUqcmq9MxKI9HZmdtniIOnsi
	ofJYUvLA5GfKBCXzkZzpERJl364USyw4PJgXfSED3GyYjCLVaEH+DMrUnUee7yDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449cj925hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:29:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KATOiP007060;
	Mon, 20 Jan 2025 10:29:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449cj925fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:29:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K74Okx024307;
	Mon, 20 Jan 2025 10:28:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0xx1ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 10:28:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KASgMm35848878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:28:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5510620040;
	Mon, 20 Jan 2025 10:28:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C7220043;
	Mon, 20 Jan 2025 10:28:41 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 10:28:41 +0000 (GMT)
Message-ID: <17f0cbf9-71f7-4cce-93d2-522943d9d83b@linux.ibm.com>
Date: Mon, 20 Jan 2025 11:28:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/7] Provide an ism layer
From: Alexandra Winter <wintera@linux.ibm.com>
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
 <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <80330f0e-d769-4251-be2f-a2b5adb12ef2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jQA0GXHf0fgairOX8fDqgjG_YVhC0w8a
X-Proofpoint-GUID: AyJ_vEUcRz4Y43A35-mE5gLav_susfoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=601 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200087



On 17.01.25 14:00, Alexandra Winter wrote:
> 
> 
> On 17.01.25 03:13, Dust Li wrote:
>>>>> Modular Approach: I've made the ism_loopback an independent kernel
>>>>> module since dynamic enable/disable functionality is not yet supported
>>>>> in SMC. Using insmod and rmmod for module management could provide the
>>>>> flexibility needed in practical scenarios.
>>>
>>> With this proposal ism_loopback is just another ism device and SMC-D will
>>> handle removal just like ism_client.remove(ism_dev) of other ism devices.
>>>
>>> But I understand that net/smc/ism_loopback.c today does not provide enable/disable,
>>> which is a big disadvantage, I agree. The ism layer is prepared for dynamic
>>> removal by ism_dev_unregister(). In case of this RFC that would only happen
>>> in case of rmmod ism. Which should be improved.
>>> One way to do that would be a separate ism_loopback kernel module, like you say.
>>> Today ism_loopback is only 10k LOC, so I'd be fine with leaving it in the ism module.
>>> I also think it is a great way for testing any ISM client, so it has benefit for
>>> anybody using the ism module.
>>> Another way would be e.g. an 'enable' entry in the sysfs of the loopback device.
>>> (Once we agree if and how to represent ism devices in genera in sysfs).
>> This works for me as well. I think it would be better to implement this
>> within the common ISM layer, rather than duplicating the code in each
>> device. Similar to how it's done in netdevice.
>>
>> Best regards,
>> Dust
> 
> 
> Is there a specific example for enable/disable in the netdevice code, you have in mind?
> Or do you mean in general how netdevice provides a common layer?
> Yes, everything that is common for all devices should be provided by the network layer.


Dust for some reason, you did not 'Reply-all':
Dust Li wrote:
> I think dev_close()/dev_open() are the high-level APIs, while
> ndo_stop()/ndo_open() are the underlying device operations that we
> can reference.


I hear you, it can be beneficial to have a way for upper layers to
enable/disable an ism device.
But all this is typically a tricky area. The device driver can also have
reasons to enable/disable a device, then hardware could do that or even
hotplug a device. Error recovery on different levels may want to run a
disable/enable sequence as a reset, etc. And all this has potential for
deadlocks.
All this is rather trivial for ism-loopback, as there is not much of a
lower layer.
ism-vpci already has 'HW' / device driver configure on/off and device
add/remove.
For a future ism-virtio, the Hipervisor may want to add/remove devices.

I wonder what could be the simplest definition of an enable/disable for
the ism layer, that we can start with? More sophisticated functionality
can always be added later.
Maybe support for add/remove ism-device by the device driver is
sufficient as  starting point?










