Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC91DEFD4;
	Mon, 20 Jan 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372946; cv=none; b=lyf587f/Y3W878nHj9gm7zWk9rtUTG6Y3/mIj3f8FcM9qIM8M0EIxpINn5Xxdqf1heuiwQw0ru+qR/EZHxobOduoQW3lqCKLD/8L3cG6vpIFseZUKvFz1xPDgtCZfu2VbtzPGSS78kMTLpVYnzVZlcKPrS9o85eE8vfX/dL5aFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372946; c=relaxed/simple;
	bh=snYT/6VTAYf+xlnQYn6S2ic5MZDjlcnjLOfGWCWn6E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0/Drelo9FgdBnzVYntpRkU+zkAZCQbd1cuk6ZOu7+9CEevJmGFtjOi4EmOSb/lsS0m2XUJ/iASVSz7LoV/FDsqbl8XPuxd2ZvwMVSutP6Ood5n7j/KhdeA1hlkhvlgfuF6WEgBRO9udGgUm1lWK74icfKpZp5oU2F9KpDY+Uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFKpvEf+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFKpvEf+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9GSMP008671;
	Mon, 20 Jan 2025 11:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Zhxbm
	BbXsyz6OeX0qks/cZIHA3q2cufIHJNCZGfgsI=; b=HFKpvEf+9xhDorsa9bMvL6
	EZeNaVet8ShySmbdOZP2o7Jf4qVK8zSAuiV1S5RGwxS6gp2ghXZKf4Xq1EpYxHCx
	Zc/bWDB+i9kyrFFtPwTMkR5jnlGd9R2cwt1WLaGwpxBV2i3uLcy1rxgw3wAQeVge
	Yf9zUEQfStgD/Ls3u+LCbsBdpFP1Z3SuXVxwtiSY6MFW+aPVXNgsE0P6WYBzYnsa
	6LX/muDIjsA6WNlcDMAJXZV1pEMdTn8raC14+uEOulSOGKEIyqC3Gv/nxp5nk0Xb
	mTakrqmPcPwFLkMmm27r3p1pz/lJ74+X8z7fxOHeHzbcAD1dQKVfsACK8tL26Xbg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44947suq7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:35:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KBV6pR007162;
	Mon, 20 Jan 2025 11:35:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44947suq79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:35:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K8iQeB032266;
	Mon, 20 Jan 2025 11:35:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujdu4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:35:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KBZW0x53346582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 11:35:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65EB92004B;
	Mon, 20 Jan 2025 11:35:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1351120043;
	Mon, 20 Jan 2025 11:35:32 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 11:35:32 +0000 (GMT)
Message-ID: <e6461792-91e3-4fc1-b5f4-1c808a085e1e@linux.ibm.com>
Date: Mon, 20 Jan 2025 12:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
To: Julian Ruess <julianr@linux.ibm.com>, dust.li@linux.alibaba.com,
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
 <20250115195527.2094320-5-wintera@linux.ibm.com>
 <20250120063241.GM89233@linux.alibaba.com>
 <aba18690-5ffb-4eee-8931-728d72ce90c3@linux.ibm.com>
 <D76TFVAMAGCP.2BN616RUY7GOY@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <D76TFVAMAGCP.2BN616RUY7GOY@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JaI3a24k_yhcy0nbaOk3iwx10_4zjQOu
X-Proofpoint-ORIG-GUID: StPekOFb0RaPPwYO8dyxvAzS2oDOpGud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096



On 20.01.25 11:07, Julian Ruess wrote:
> On Mon Jan 20, 2025 at 10:56 AM CET, Alexandra Winter wrote:
>>
>>
>> On 20.01.25 07:32, Dust Li wrote:
>>>> +	/**
>>>> +	 * move_data() - write into a remote dmb
>>>> +	 * @dev: Local sending ism device
>>>> +	 * @dmb_tok: Token of the remote dmb
>>>> +	 * @idx: signalling index
>>>> +	 * @sf: signalling flag;
>>>> +	 *      if true, idx will be turned on at target ism interrupt mask
>>>> +	 *      and target device will be signalled, if required.
>>>> +	 * @offset: offset within target dmb
>>>> +	 * @data: pointer to data to be sent
>>>> +	 * @size: length of data to be sent
>>>> +	 *
>>>> +	 * Use dev to write data of size at offset into a remote dmb
>>>> +	 * identified by dmb_tok. Data is moved synchronously, *data can
>>>> +	 * be freed when this function returns.
>>> When considering the API, I found this comment may be incorrect.
>>>
>>> IIUC, in copy mode for PCI ISM devices, the CPU only tells the
>>> device to perform a DMA copy. As a result, when this function returns,
>>> the device may not have completed the DMA copy.
>>>
>>
>> No, it is actually one of the properties of ISM vPCI that the data is
>> moved synchronously inside the move_data() function. (on PCI layer the
>> data is moved inside the __zpci_store_block() command).
>> Obviously for loopback move_data() is also synchornous.
> 
> That is true for the IBM ISM vPCI device but maybe we
> should design the API also for future PCI devices
> that do not move data synchronously.
>

An API should always be extendable

>>
>> SMC-D does not make use of it, instead they re-use the same
>> conn->sndbuf_desc for the lifetime of a connection.
>>
>>
>>> In zero-copy mode for loopback, the source and destination share the
>>> same buffer. If the source rewrites the buffer, the destination may
>>> encounter corrupted data. The source should only reuse the data after
>>> the destination has finished reading it.
>>>
>>
>> That is true independent of the question, whether the move is
>> synchronous or not.
>> It is the clients' responsibility to make sure a sender does not
>> overwrite unread data. SMC uses the write-pointers and read-pointer for
>> that.
>>
>>
>>> Best regards,
>>> Dust
>>>
>>>> +	 *
>>>> +	 * If signalling flag (sf) is true, bit number idx bit will be
>>>> +	 * turned on in the ism signalling mask, that belongs to the
>>>> +	 * target dmb, and handle_irq() of the ism client that owns this
>>>> +	 * dmb will be called, if required. The target device may chose to
>>>> +	 * coalesce multiple signalling triggers.
>>>> +	 */
>>>> 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
>>>> 			 bool sf, unsigned int offset, void *data,
>>>> 			 unsigned int size);
>>>> -- 
> 

