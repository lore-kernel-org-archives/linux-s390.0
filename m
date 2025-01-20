Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43729191F6F;
	Mon, 20 Jan 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367033; cv=none; b=IQEH/5Z+XwQr4chaeHToUZcT+mWkAzQwp6I7KuXNOoGHAO3RKWrtw1TCv/4BPCLcN4Kc2bvW/Ds+RiZQrXh2dyobpaVcyD/+wLaSdQs6dptMLgjXADKZguYmwqvGgDQtQ5l5Z3NiuMGVKm98byEylr+oLhmT8Aam3MCoBrQeeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367033; c=relaxed/simple;
	bh=rxy0A8Fy/ZZ8TPrPdImTYDrGojT9BmbxOBVIb6iUw6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy/H7EX9raOiCQwuxlDjH8AwNH9ohm001mSPN1lytmTOHUNHj/rqOXrtOdCz5Gbxldf89v+g6ydQGIfsWEGgR4h3hYBIHxf+WYuyPS4HMwAfNSGQGD/nzQYwpnI9JDZnN6xFDs6jQCqcX2Ib+i4w72kij1fp8BVjufyJWND8uKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jsB1Y+PE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jsB1Y+PE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50JJkYbr031153;
	Mon, 20 Jan 2025 09:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1+7hbM
	Cf33epAjVVT8wYNcVVSKvYpU5eMiHdWNZRgOQ=; b=jsB1Y+PEeJXFLsUUMH9C4x
	JMMsGLi9YTrmjNyuX6tHUGkOFXmfg0eE+fQeio4918nQ6wwUnONrl9KsETj+zR6T
	wAcOnl1HvlArLyMzl9S3Yyl48vSHOxlM/9Mgfqvd77zx0Z+myNkFWcKCFt6LZW1v
	rmyYugOyr/WIuBjTF+JgLOTrFTaB3mS3PtxNMjUCRZKioi4iOe3R5ZAbkXT83HC3
	I6VON7bBUsmo2Ors/afEJ5JrT3sIClR1/wdCRPTDUgy87rZUTWXQh6sVlBBh+di5
	CP9K770h9Tahwj3OnW2AZdYW4YFznCOJoFJRm0fnKr+3kHJrWHGuhvovWt/ePLXQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44947su9vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:57:04 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50K9pecP024044;
	Mon, 20 Jan 2025 09:57:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44947su9vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:57:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7n46Y029622;
	Mon, 20 Jan 2025 09:57:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmn5rv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:57:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50K9uxln62915026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 09:56:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39BB620040;
	Mon, 20 Jan 2025 09:56:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8D332004B;
	Mon, 20 Jan 2025 09:56:58 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 09:56:58 +0000 (GMT)
Message-ID: <aba18690-5ffb-4eee-8931-728d72ce90c3@linux.ibm.com>
Date: Mon, 20 Jan 2025 10:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
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
 <20250115195527.2094320-5-wintera@linux.ibm.com>
 <20250120063241.GM89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250120063241.GM89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LU5WOucVup0Ss3Fhp3bx3Y3rS2Ntf83A
X-Proofpoint-ORIG-GUID: 5tsnkubn4k4XmteB9UXy0PUIHWJL5cdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200079



On 20.01.25 07:32, Dust Li wrote:
>> +	/**
>> +	 * move_data() - write into a remote dmb
>> +	 * @dev: Local sending ism device
>> +	 * @dmb_tok: Token of the remote dmb
>> +	 * @idx: signalling index
>> +	 * @sf: signalling flag;
>> +	 *      if true, idx will be turned on at target ism interrupt mask
>> +	 *      and target device will be signalled, if required.
>> +	 * @offset: offset within target dmb
>> +	 * @data: pointer to data to be sent
>> +	 * @size: length of data to be sent
>> +	 *
>> +	 * Use dev to write data of size at offset into a remote dmb
>> +	 * identified by dmb_tok. Data is moved synchronously, *data can
>> +	 * be freed when this function returns.
> When considering the API, I found this comment may be incorrect.
> 
> IIUC, in copy mode for PCI ISM devices, the CPU only tells the
> device to perform a DMA copy. As a result, when this function returns,
> the device may not have completed the DMA copy.
> 

No, it is actually one of the properties of ISM vPCI that the data is
moved synchronously inside the move_data() function. (on PCI layer the
data is moved inside the __zpci_store_block() command).
Obviously for loopback move_data() is also synchornous.

SMC-D does not make use of it, instead they re-use the same
conn->sndbuf_desc for the lifetime of a connection.


> In zero-copy mode for loopback, the source and destination share the
> same buffer. If the source rewrites the buffer, the destination may
> encounter corrupted data. The source should only reuse the data after
> the destination has finished reading it.
> 

That is true independent of the question, whether the move is
synchronous or not.
It is the clients' responsibility to make sure a sender does not
overwrite unread data. SMC uses the write-pointers and read-pointer for
that.


> Best regards,
> Dust
> 
>> +	 *
>> +	 * If signalling flag (sf) is true, bit number idx bit will be
>> +	 * turned on in the ism signalling mask, that belongs to the
>> +	 * target dmb, and handle_irq() of the ism client that owns this
>> +	 * dmb will be called, if required. The target device may chose to
>> +	 * coalesce multiple signalling triggers.
>> +	 */
>> 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
>> 			 bool sf, unsigned int offset, void *data,
>> 			 unsigned int size);
>> -- 

