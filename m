Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D3207658;
	Fri,  6 Dec 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498745; cv=none; b=iiEpOYpjO19Ucke4FdbWTC8mrWVpdHatDwvL89b1ru53pXppt2WRVEocCwnBP8LbZWf7wqYaQrTTvRi9ktWxqMPUASqGkOe6dFFyzxzs8a50CC1LkRvoL1nXnd/lkpb2uAmuLqhfv8It0n5K7fHrMQzlhooopwjuEjW81WpgiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498745; c=relaxed/simple;
	bh=UhnTYqx1P+i70Z7jLTbhQwl3CmZR0MayaBVZK0fs7AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1aF+X6CNoY1y95rbjWNl3AjxThicEnTqPG/WuKHnVJ//lh5rKdaz8FMYylkoHgRbZ3B3wiI7+EL7FZb9DNTyBfDSx3huZD9TPD7vTXy5UFBTox2M1At+GmX3mEll79V1QWQ7xP/IxnHwR3Vl7ammOR1+2L5qPBjdkTktNJ+LE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XLq0FrqV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XLq0FrqV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6DtYUE030884;
	Fri, 6 Dec 2024 15:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vDRx8L
	t1Nvf/4JkfbPhuRoGULKdQS2FfAaWTLt6QTxs=; b=XLq0FrqVF+0cgdO+mOIUAe
	noNsh3cOIYdwCO77kw/BYKlcNi+Coru9yED2NWP4nXTCY+biX/h5lVMnpaGscuYV
	yQ/Y3HOsd8sjKQWinIn9nEQRzllGWGR1IFiSMwKJS0kPl4zHG5/rw0l46v3H3Keb
	Saa9rz4VnLNgRhO9hbgxW0wi3Mz29zCZwSTRf1f2nwus0NUBHVkSuJ3XPVwuKCYD
	OxJa8iiR7Ly+pQvZRzQxY9GfpWSpLtCgzz4h+989oeVfQ5OS9ETio87IXPhk2Gvf
	LVRJ/s04nXYdSOsomqza8k4suD3yF/Pfj7lPhNDqP0v7/6bNxgFlJupsDWnB81jw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb8spp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:25:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B6FBfQg027556;
	Fri, 6 Dec 2024 15:25:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb8spm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:25:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Eqxru022960;
	Fri, 6 Dec 2024 15:25:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1ne4sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 15:25:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6FPTUR59113974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 15:25:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A014A20043;
	Fri,  6 Dec 2024 15:25:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C9E20040;
	Fri,  6 Dec 2024 15:25:28 +0000 (GMT)
Received: from [9.179.9.40] (unknown [9.179.9.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 15:25:28 +0000 (GMT)
Message-ID: <b966eb7b-2acd-460d-a84c-4d2f58526f58@linux.ibm.com>
Date: Fri, 6 Dec 2024 16:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nzYmFORzoAB99hdyifedKjegiy1q3Jri
X-Proofpoint-GUID: cq1CLDit5SUKvL-sTJlueDKAKTgB0zP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=905 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060113



On 04.12.24 15:36, Eric Dumazet wrote:
> I would suggest the opposite : copy the headers (typically less than
> 128 bytes) on a piece of coherent memory.
> 
> As a bonus, if skb->len is smaller than 256 bytes, copy the whole skb.
> 
> include/net/tso.h and net/core/tso.c users do this.
> 
> Sure, patch is going to be more invasive, but all arches will win.


Thank you very much for the examples, I think I understand what you are proposing.
I am not sure whether I'm able to map it to the mlx5 driver, but I could
try to come up with a RFC. It may take some time though.

NVidia people, any suggesttions? Do you want to handle that yourselves?
