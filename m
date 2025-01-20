Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EA1DE2CC;
	Mon, 20 Jan 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373564; cv=none; b=Jvvkyio3O8NyUtB0fdFVEOtyZ4TZ3W8oTwJMJ8YsFkuTAqydEVMELE0RnQYhSgB6+zCUPl6HZDqju7mMGX/CtKb9wJkLrjm/yBSW0TYiN1wPxCbLzfPoNkpJj0ShHCmbP8f7FNNfNAC56HJo41XH3VZ64ahYMOoCGIr3YxLAEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373564; c=relaxed/simple;
	bh=mv/Ld+WOTOxGfkpGdiwjpKOwxQgkqvBNlhw/Zqslq14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWPt66VjMZqXCtJqNLGMaj9Dz0n5uN/vEGHktxQAiKrw9BxR17flXGoO+biKbz4aPY3PyUvofsJFzJhp2DKW7cwOE0F5nPYTf/8yCvAmfaur8gnVqRsQGSbZ9dDqNumFMwvhKMeqs9DozX37E4QucFeDIunl/+54pTA7nSa4qaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0qwiO6E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0qwiO6E"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7WpMa010703;
	Mon, 20 Jan 2025 11:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nDuz4L
	eBjO8cYz1slRzuDpThzY00V22a3icURtrhhis=; b=c0qwiO6EJ7RLXuhWMSCxCa
	NyfO+fv36YbyqtZcDXhjCoFDY3G6SUHj36YHlx3g65Qa+0D9NHTrEtIjC9bRtSA1
	on0zNdHqm+b7qPCDDBDzelOfnWYrLqkpbWmint66JZ7HU3srVdOXDevS3mmyk1FL
	gKvP38qptzRRpoqOb/Y0VMa0Ly/JS7QiBmnB/WPPVkfZGx14is1/cfPMBAMCPxPv
	EMhaDCg822CaRJs/Fm3T0V9Hlzq1Eyqfr2HnNHvWTMELm40BsM45kl1ns+xQnPRi
	aVc/FdyTNSIfqK2isrw8KdBLU02XV8Xsoh7DWDfHpeiemM36Q7OkL42rtyHFlQrg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n94s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:45:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50KBeFWZ012866;
	Mon, 20 Jan 2025 11:45:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449j6n94s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:45:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50K904Os032222;
	Mon, 20 Jan 2025 11:45:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448rujdvfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 11:45:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50KBjow361538648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 11:45:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C91C2004B;
	Mon, 20 Jan 2025 11:45:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07BAA20043;
	Mon, 20 Jan 2025 11:45:50 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2025 11:45:49 +0000 (GMT)
Message-ID: <acd2f413-3cd4-495b-ad84-11e511aa3f43@linux.ibm.com>
Date: Mon, 20 Jan 2025 12:45:49 +0100
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
 <235f4580-a062-4789-a598-ea54d13504bb@linux.ibm.com>
 <20250118152459.GH89233@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250118152459.GH89233@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tG5jKryMFFhu1C0IrKmmyO_bTSbBq1vo
X-Proofpoint-ORIG-GUID: HxpW9iAulyWuBjqARpkUagjeKrnfucZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=806 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096



On 18.01.25 16:24, Dust Li wrote:
> On 2025-01-17 12:04:06, Alexandra Winter wrote:
>> I hit the send button to early, sorry about that. 
>> Let me comment on the other proposals from Dust Li as well.
>>
>> On 16.01.25 10:32, Dust Li wrote:
>>> Abstraction of ISM Device Details: I propose we abstract the ISM device
>>> details by providing SMC with helper functions. These functions could
>>> encapsulate ism->ops, making the implementation cleaner and more
>>> intuitive. 
>>
>>
>> Maybe I misunderstand what you mean by helper functions..
>> Why would you encapsulate ism->ops functions in another set of wrappers?
>> I was happy to remove the helper functions in 2/7 and 7/7.
> 
> What I mean is similar to how IB handles it in include/rdma/ib_verbs.h.
> A good example is ib_post_send or ibv_post_send in user space:
> 
> ```c
> static inline int ib_post_send(struct ib_qp *qp,
>                                const struct ib_send_wr *send_wr,
>                                const struct ib_send_wr **bad_send_wr)
> {
>         const struct ib_send_wr *dummy;
> 
>         return qp->device->ops.post_send(qp, send_wr, bad_send_wr ? : &dummy);
> }
> ```
> 
> By following this approach, we can "hide" all the implementations behind
> ism_xxx. Our users (SMC) should only interact with these APIs. The ism->ops
> would then be used by our device implementers (vISM, loopback, etc.). This
> would help make the layers clearer, which is the same approach IB takes.
> 
> The layout would somehow like this:
> 
> | -------------------- |-----------------------------|
> |  ism_register_dmb()  |                             |
> |  ism_move_data()     | <---  API for our users     |
> |  ism_xxx() ...       |                             |
> | -------------------- |-----------------------------|
> |   ism_device_ops     | <---for our implementers    |
> |                      |    (PCI-ISM/loopback, etc)  |
> |----------------------|-----------------------------|
> 
> 
>>
>>
>> This way, the struct ism_device would mainly serve its
>>> implementers, while the upper helper functions offer a streamlined
>>> interface for SMC.
>>
>>
Thanks for the explanations.
Yes, probably makes sense to further decouple the client API from the
device API. I'll give that a try in the next version.


>> I was actually also wondering, whether the clients should access ism_device
>> at all. Or whether they should only use the ism_ops.
> 
> I believe the client should only pass an ism_dev pointer to the ism_xxx()
> helper functions. They should never directly access any of the fields inside
> the ism_dev.
> 
> 
>> I can give that a try in the next version. I think this RFC almost there already.
>> The clients would still need to pass a poitner to ism_dev as a parameter.
>>
>>
>>> Structuring and Naming: I recommend embedding the structure of ism_ops
>>> directly within ism_dev rather than using a pointer. 
>>
>>
>> I think it is a common method to have the const struct xy_ops in the device driver code
>> and then use pointer to register the device with an upper layer.
> 
> Right, If we have many ism_devs for each one ISM type, then using pointer
> should save us some memory.
> 
>> What would be the benefit of duplicating that struct in every ism_dev?
> 
> The main benefit of embedding ism_device_ops within ism_dev is that it
> reduces the dereferencing of an extra pointer. We already have too many
> dereference in the datapath, it is not good for performance :(
> 
> For example:
> 
> rc = smcd->ism->ops->move_data(smcd->ism, dmb_tok, idx, sf, offset,
>                                data, len);
> 
> Best regards,
> Dust
> 

I see your point. I'm not yet convinced. I'll think more about it.



