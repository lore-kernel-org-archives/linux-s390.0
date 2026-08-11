Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAB40F744;
	Tue, 11 Aug 2026 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440062; cv=none; b=r8vXZZX96FrahXrohT6DcSMpUIjjw81kPejk5vftjfvNkCt8JzI8qkFq/NHJ53ebgyl/yTBrTirl+pNBRQCgTgfdcOmjfeY9CS7+Is1xjq2Ewd88d/W/8/1jZCukUFCMLMULtrCAyIDZWIBYKXf774eBPzfJs1vLcl7qlBkGZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440062; c=relaxed/simple;
	bh=dc1BLD2dg7yrpEhvGtxRkENFk+pHc1HBcM6inJPP+kA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DXWCIayxbwhTirCidwAnpheAMtF7msC3kDnBRDmeGS6zdZv9zrPalRCG6HwBYAjxDVsfMAVvWLIdgsE5Kxm100zwrvtTJtVSxl0F7tL0X3W+S8ApT5k4q7xDUlweT/nw1mg3PaCRDXJmWvpf44CHxiOA9WsRunmkvKD/YG39NQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aB7ad8QE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aB7ad8QE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1mIQ1102214;
	Tue, 11 Aug 2026 09:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BmHm/1
	S3e7v3/qC1G38UKuzdKFJvdQaf18Bs7TWcNJo=; b=aB7ad8QExXWxO0Gj5tSXXX
	49mv/3+Ra4gzyvHdvZed4h8wBGRe8ROzPmV6wzjd7HivhkKAbgMs7wcurcXKavWz
	v7IERiKyeaijJwKXchmjLHce2R+LSXkc4zqFRfFHoMpdrexRnLCa7UgYqCmqXkRI
	CnbVubJlZLH5mgJi9AfMvhH0R6pT5UDQ4TNOnDbvdPl6mmg7UOIX+Vu1OKx6r0N4
	YvJ4aJxIRehjCOME1oTP0hoSFxktXj6biOKIAVlL/QhZ/cWEBcCxihi81uQG9O6v
	buMUDdKO0n/XBe3OKnrWPMjQrFLPnGzoJhD70XUf0FvHycjz8ILO8ji88uU86nRg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyv6kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 09:20:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B9BGoI022335;
	Tue, 11 Aug 2026 09:20:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w0eet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 09:20:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B9Keg639715290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 09:20:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6882004B;
	Tue, 11 Aug 2026 09:20:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B8F320043;
	Tue, 11 Aug 2026 09:20:40 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 09:20:40 +0000 (GMT)
Message-ID: <0e7d2695-3473-46c7-badc-ebf862a022dd@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/dibs: Correct freeing of dmb_clientid_arr
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
        Dust Li <dust.li@linux.alibaba.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20260810111432.2334900-1-wintera@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260810111432.2334900-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3NCBTYWx0ZWRfX7aeKau+y+p0y
 sSXm8XcPAHwWlclxRECd1i4PT9tqDob/i7sCccAdbZLnNBrcJ0ZBFLupIExFLkFGsZcl/A64Vyd
 9jbYea8+gJGqVG2lWas/4VaN8hiKKkZPQCtUxQdlZQ7rYkQpa2P1dud83vfeEXHpaFx5CWwYR+5
 hcUQxcgODjVQh7zeQIQ79MgnSl2ILU/yn6QGNwZDL3NhsCgumpOe96llzxiF1L1r7cZ2AtcWcx7
 TyjH3RkmxSi/ATu3jJBJq6dVGThEb/QhHQqzN0Nvrk3qXcf3bKTCCaY8SrJiqI0nh+gmzgxZd4f
 TzMUGJeLRC4S8po4Bfof05ffTBCFs3Hz4GactSd9Q7S3R/kRbAHAI1dkRCdyMyW538oqtUoqpKL
 ry2+BuolPD/vt96d0H67ekQEfEV6ECb8G27bfejReac0p090DAA7VuWw+ZvIUPL3O4yuZFxehxj
 ZGVJrT5Fbc/3teFQqsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3NCBTYWx0ZWRfX0lfXr0AC0Osq
 Ejas9Q1jrmXWGOZcTMdIjmWRA+m/tDsVVdvzRtnel9vKcn1VR/yPzSZp7L0dS8rAyY/kjnErOIG
 m8SmXEdSgid2PliWImZAKr+OjW1Uz5Y=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7ae96e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AxoDFHF54RuZZfRr5JsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: keszK41sogrJRWcc6HBChVjtKg3kAPIL
X-Proofpoint-ORIG-GUID: Bi3Ia__sULsuMmIybTpB8qzcyM2uAcQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110074



On 10.08.26 13:14, Alexandra Winter wrote:
> A dibs device interrupt handler can be active after dibs_dev_del() and
> may still access dmb_clientid_arr. (UAF)
> 
> In case of a failure in dibs_dev_add() being called by dibs_lo_dev_probe()
> dmb_clientid_arr is freed twice (double free).
> 
> Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
> Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
> for now, because no dmbs can be registered before dibs_dev_add().
> 
> Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
> Cc: stable@vger.kernel.org
> Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
> This is a squash of [1] and [2] as requested by Jakub.
> 
> Simon and Dust Li, I'd appreciate, if you could double-check whether
> you can give R-b again.
> 
> Link: https://lore.kernel.org/netdev/20260806120447.596164-1-hidayath@linux.ibm.com/ [1]
> Link: https://lore.kernel.org/netdev/20260804085848.3579518-1-wintera@linux.ibm.com/ [2]


Title should be 'dibs:' instead of  'net/dibs:' for commonality
dibs: Correct freeing of dmb_clientid_arr

