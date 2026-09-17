Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6F4582E2;
	Thu, 17 Sep 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630352; cv=none; b=YDl1R93bEyv5N5daReeyN3f4aD8/2sg1hoOEEiVZJ8wrDb8IEfYhTzi9nCyaDiZhxsqHGhPbLhNb0lKjR9WBCMbih7SFogVPjvRuXjVbIDai/S/qhspaQR3T2taHD1p1uYI/HYkCYXNwhA/Mef6KlQ1xJbT8lp114+Yo547IgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630352; c=relaxed/simple;
	bh=wVjmz3uzS8Ebe8IAHi87y61KFGuEW0dCHrMcq6V0sPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZEgi/XlbzdHj1OxSTyWcLJUAQ5k+/NRur/jEEUazuHrXBxahEl5jxeFIKLjF/gGpnlshQz8H9WycUAPfZ1JbAl59EAbPXuWCg8nJ5liPZ15hfXHI8mD7wE9LJh3SYxhu/Eb36R84FDIO+p57H3OOIO4TpQUVUgKn8HemexlP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X9HlzLnT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X9HlzLnT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61px31560089;
	Thu, 17 Sep 2026 07:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nSf42h
	q41rEHHoMo9a7HIV8wc5YwXylTpafUXKn1vFM=; b=X9HlzLnT9bF45Ebg2h5Wgi
	vfgbs428cY43VAUFjNGNdFM4IefFipC4kB3kSiRUuX1Hx+BBYAZtXUjwAtLWgxQq
	ixRa6I9miUtqv2oeyDk0Y/pODzearFUvZrlWsfuLL50RaS/E13GIENK3PIyckbtL
	1OyQQ3UFQjj3W55fKlr5JdXCaFw5ehBMTm/Dvzmifb7cLTOIZL9We6hkvx+/2PJ8
	KYVPHQ7HbKD+kw/AjGgrVRDS9/oZdXlhyGr/yU+HfpeI3F185rh10AVNDD+Psdya
	1ANhRJRwQdrB9/u63ucxdR0qe78+RmROZP4baHBo8mWU1w8TQMop2Pz2idO1ILhw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j0ur8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:32:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H652lS2713815;
	Thu, 17 Sep 2026 07:32:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ff9axr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:32:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H7WJgO46596498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 07:32:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 592F520040;
	Thu, 17 Sep 2026 07:32:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0728C20043;
	Thu, 17 Sep 2026 07:32:17 +0000 (GMT)
Received: from [9.123.3.144] (unknown [9.123.3.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 07:32:16 +0000 (GMT)
Message-ID: <9ff0027c-6381-455b-97df-7d1081a23e8a@linux.ibm.com>
Date: Thu, 17 Sep 2026 13:02:16 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
To: Alexandra Winter <wintera@linux.ibm.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        twinkler@linux.ibm.com, heiko.carstens@de.ibm.com,
        hidayath@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
 <9cda0e57-ce4b-428b-9385-743fdef02789@linux.ibm.com>
 <029629de-ee55-4b3e-a7fb-a693c2b1261d@linux.ibm.com>
 <8c62f8c9-54ca-4fa2-a199-6d7cf0b26f25@linux.ibm.com>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <8c62f8c9-54ca-4fa2-a199-6d7cf0b26f25@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX9XZwVSLr8CY3
 RW5GX6/5GutZ9vZaBdldVBtxlVPbhYNZtd1GPj6KL24VlBZ0ITtBQ1x0OZV5H2PNiWZMujHWN8L
 JNjMyAVsgBmpSri1VzS1Hvx+97OHGVqNG6QPQRVTUi16DNo9mtAbnOY4FrB6ZgcQYZ0WZ+2eHRO
 sBuWEypAbMc+67Dm1ff314gcVCAFA3IcpNvpBppQ0brjoVElAF0JNdmtsYo8D3Y1Yjj6Eh2Wbwe
 nEqe6B+DxH9Sjw2PYbcsPiC3PkHu+B6+aQMKK9M+aKTwlYSPFb6ELYePST/91ceYX2nHllBWf3R
 4clCp/QfyxdrUo0FH6xDPgWHYDf6BuQGi8BNZvplcVyG1qeaccEhGwDzL4csMUWEVcJOTqJLCXg
 XjTt8idR12o+SaI2zc3lewjlNxsb+DcxLcE+nQ6tIAZZ1YjRep/3pdeTCkj78c6/TB6C9a0d7MW
 gBS2IkR5sdQX0ZiVDPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwMSBTYWx0ZWRfX45z9QuCUfKJ4
 qQrWTtucR/tBbTSAZbjrWpr0PZQ+Nq80pX/sN+r/7gbpkQ+35YTycaYmWQp+eodbcsY0EtSVrb7
 TDKjrVceqnUh4iEygcuIa9DAEBSLsE0=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab9788 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=O4vWJ1xFwzTzK0bZaFMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I2cGYaHTDG1AnGEZLkhnYd4V9fb2NPzx
X-Proofpoint-GUID: hyNQ05ZJnkT4h0OnEoLeLsH9wWeYCXOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170101



On 04/08/26 7:00 PM, Alexandra Winter wrote:
> 
> 
> On 04.08.26 14:52, Nagamani PV wrote:
>>> I'd rather continue to work on a more complete fix than take this one,
>>> but both ways are possible.
>>>
>> Understood. This patch addresses the UAF on iucv_sk_list traversal
>> specifically. The lock_sock() concern is at a different level and
>> could be a follow-up.
>>
>> Could you clarify your preference — take this as an incremental fix
>> with a follow-up for lock_sock(), or hold and work toward a combined
>> solution?
> 
> I prefer to work on the combined solution

The combined solution is now posted as [PATCH net v2]:

  https://lore.kernel.org/netdev/20260917071706.23831-1-nagamani@linux.ibm.com/

The v2 fixes all three races in one patch using a two-pass algorithm:
Pass 1 under read_lock_bh() collects matching sockets with sock_hold();
Pass 2 under lock_sock() per socket calls iucv_send_ctrl() and updates
sk_state, serialising against iucv_sock_close() and sock_orphan().

All three bugs confirmed with KASAN + KCSAN TAP on IBM Z.

Thanks,
Nagamani PV
