Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214501C760A;
	Mon, 10 Feb 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184019; cv=none; b=DmiEWTz5+kzJsyqujoJf7IbQVm79qRdWCdbyqkuL721YFjVflWTIqOQvBOJTRPOVDy/wodUo2F/yOGhdbzHChu6TDO1SbTICVZdnxTTic+dqDcdttcwrRiUlTmSCa+GAL4mDqF3aYD+w80xHJ6gEsbqMAPQjMJqOU2HHksYQjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184019; c=relaxed/simple;
	bh=ncnDP6pJKG77kyxFzNCp8swT2gLWcvpWpD1t7tV2FjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbvJYJwf/k00ogdBXFbvFxjVqTid8iCvJPZsICpaTMTIncsUfiTTym+8j6TbNjJYonWdrjTjoE4OWgsJjd6kkoKZOFWgCEhtD+D4t4CbA5Lg/nTf+dY4JA0qcN2GAA+cd6d+w87BXH5b8jHJCkOyX63Hgrs0A+4wVVrtWZTHeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a8Uidmhr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a8Uidmhr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519MnLqn015303;
	Mon, 10 Feb 2025 10:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R8wdkp
	Sq74jP7jXEtGou00JFyMZWEHjj3uL01JkAbXQ=; b=a8Uidmhri27XdWID49w/Zc
	BiUYeSaH/jMxmZdgdEWBWl9jKdGPYL1DuzLvQ5oIXxog1OTL/TaTiqz5zn0mCSl3
	c728IRaXMIOoqUs5UQS0WbstaqlSpK2NRQ+SIpwKw3l2+WvCaXVXhNvz6HZ3iWuJ
	RNJInLpmTwDD7KpMTi4gDb9uAeWF1zZV9oE067P0eFSM3L4BItia8IQzvllq4I2E
	B4g8BACa/M5em481EzboLvMVvYJSsEnrIiEYe81RiOrmQIv6vgZh1LHbMhJc/Nz0
	+ttByCkGo/AhthRmzDbfCK526sclnF/EgbvWMtgxIXtIITkIAaPzuoMvWLzXfKhA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gaamct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:40:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AAWjoP028736;
	Mon, 10 Feb 2025 10:40:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gaamcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:40:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7ATJ4021886;
	Mon, 10 Feb 2025 10:40:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkse0qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:40:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AAe3vP35520820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 10:40:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1E6200E4;
	Mon, 10 Feb 2025 10:39:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADCF6200DE;
	Mon, 10 Feb 2025 10:39:31 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 10:39:31 +0000 (GMT)
Message-ID: <19790e19-01f6-4843-a19d-9b8b1c5b16d5@linux.ibm.com>
Date: Mon, 10 Feb 2025 11:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 5/7] net/ism: Move ism_loopback to net/ism
To: Julian Ruess <julianr@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
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
 <20250115195527.2094320-6-wintera@linux.ibm.com>
 <D7LJMF6OMXFQ.1ADL6WMIWIQ5C@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <D7LJMF6OMXFQ.1ADL6WMIWIQ5C@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k1A_yghwez5FTiBcEUvttePrp9z9j8QY
X-Proofpoint-ORIG-GUID: _Cr57fcxIt_uzhHaSveNeouHgBQdlS5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=788 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100088



On 06.02.25 18:36, Julian Ruess wrote:
>> +static int ism_lo_query_rgid(struct ism_dev *ism, uuid_t *rgid,
>> +			     u32 vid_valid, u32 vid)
>> +{
>> +	/* rgid should be the same as lgid; vlan is not supported */
>> +	if (!vid_valid && uuid_equal(rgid, &ism->gid))
>> +		return 0;
>> +	return -ENETUNREACH;
>> +}
> This vid_valid check breaks ism-loopback for me.


oops, I also get:
> smc_chk -C 10.44.30.50
[1] 967189
Test with target IP 10.44.30.50 and port 37373
  Live test (SMC-D and SMC-R)
Server started on port 37373
     Failed  (TCP fallback), reasons:
          Client:        0x05000000   Peer declined during handshake
          Server:        0x03030007   No SMC-Dv2 device found, but required

Sorry about that.
Current upstream smc_loopback just ignores vid_valid in smc_lo_query_rgidsmc_lo_query_rgid(),
but I'm not sure that is the best way to handle that.
I'll investigate and make sure it works in v2.
