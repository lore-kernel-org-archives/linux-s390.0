Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73F339363;
	Mon, 24 Aug 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561300; cv=none; b=uot0hCQ00Y0+SRw4ILBDuyzUIeivfEEVb2rNP9vWRu+CYlHmX4d1X3iZ1oEpogML1g9iePxEk3FlXF7yliAE7dymwQGf9PZILCN6Xubpenev+ZIC12ydMVPjToYL/LiJbcG+zXxVXWl42YtXuaim+LfssdIUlNQ/j6Z0ShVZDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561300; c=relaxed/simple;
	bh=T8p2SjRwYf7PMgfremyvAZAvRBqGtDlE+otoS5/RW8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRTK0xeQJmj+fvK1q4WlLnJN5PhT4hPC6ptsmtj1KTqR5FPY6wMswiIir6vrZ80/oW94geR8tdXotgJTqQaU2UpJ2jEIv5t0tvQAj1o9cjibKd7fSHvOQgkSwNWmUJMePQu/FOjHxQQDySANwYaPgirsnw8a7Eq3yBuPCcLkJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R8BjBtf2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R8BjBtf2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5Vnd3857108;
	Mon, 24 Aug 2026 08:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0FBft0
	TNIEbsBqxKfHYP3MdlZqz6UcKc+KyR8+8hrsE=; b=R8BjBtf2KozpNLMALGJHqK
	kpVHhhJFvp/gDbtB/u8L61bPc068MrV90ZEmesZDjDKXIqcOIRD1N0LmahYQ0QR+
	4Ggr5AU0K5ouyUffMl2NPTTqUVvq3as3fw60zU1duYW0t4QnidYKKQTJlqY/k+xA
	aua7R/bSp/mM/cfAvNn5nkJriGpVXsBnJwwjUT8mrDYq2u+/Kd2cpTKB22FvKVbk
	AcKMomBBD9vwc7MyFWa+QWGKqe3DILGmLBwPUS+TWQibbWKIpwoD2KJApUHvjHAx
	7ZCGQosPXZkJ9l1NTY2KDIJ4tNBE8yqEyG8VdnTkbw0YsQpZBY+ZeUoznNQwCyxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hgd7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:48:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8fL14005756;
	Mon, 24 Aug 2026 08:48:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvw05v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:48:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8lx6U34406784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:47:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC522004D;
	Mon, 24 Aug 2026 08:47:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DEB720043;
	Mon, 24 Aug 2026 08:47:59 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:47:59 +0000 (GMT)
Message-ID: <ac920c76-07db-43f4-ad95-da36073ca45a@linux.ibm.com>
Date: Mon, 24 Aug 2026 10:47:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/iucv: drop HiperSockets frames from other
 network namespaces
To: Bryam Vargas <hexlabsecurity@proton.me>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260815-b4-disp-dc82fde4-v1-0-e83b10b22ce9@proton.me>
 <20260815-b4-disp-dc82fde4-v1-1-e83b10b22ce9@proton.me>
 <e42b30ee-f7cc-4f65-8fe6-1bc6888829f2@linux.ibm.com>
 <20260821114210.430509-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260821114210.430509-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX/TllOLlaStOX
 qOSA+za1g38+IHZkzGAmlhZm5da/9jgAsIM/rPvlihqFvxLhSpPcK3cATJj/YwSpqaDzr6w8Lk7
 5HWza1qiML0icTUIv4GQp58asegvbzQ=
X-Proofpoint-GUID: ZBhAaM7V1zOytrQjO6s9nXJ4IcYD4Ye2
X-Proofpoint-ORIG-GUID: QUhjRtkPnKO-pIynFtc_kE4sUpqgjLu8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX88NpPBva2I2o
 Ng3/QnWxpJsIWvF49kj++ItSCMuP8Tt7FmRryZA3bP9OoEBXto0Z7m6VCvViviLfLnzTC1X+WLg
 SVoSGNb5PXYIax6VFl51yV8mxFOxUAxq/C6RN7G7qPh+DezyAR6BdZw/KnB8YqndAOP7DOP4KkS
 3AVIk5iqy/P9JaA6vrp3VV2xmV4xLgL1Uv4fUNxrSKpWiEYiyCZYB0TlAxVHnKgGzpjXpX2deg/
 YjIXeJoo5LIr2XDzVYvL1E8LJN5w02Nt3NDrmnfY6jzdVwFA8dZymavaNrEaUYHPubxUQmLdYQu
 fH5eVnMd1vH6ZKWpFFSnbI2ti0b2G9k6kyzrxliZCePfWKq+f6RAJVKdqvMmI3+uDlBRTMxxrZZ
 HCSZAChalTZuOrqC7V3W0KCwb260oJ0YqPi+NFQg7EnpXvWrA1zPhMKNGFllRVi8ilHZEG2SP9x
 izr/e15KRPq+BKTm7mA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c0544 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NUaoYWLe1u_Qn2jP5V8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074



On 21.08.26 13:42, Bryam Vargas wrote:
> Alexandra,
> 
>> I am wondering whether a check of
>> +		if (iucv_sk(sk)->hs_dev != dev)
>> +			continue;
>>
>> would cover a broader range of issues.
> 
> It does, and I'd rather have yours than mine. It covers three things at
> once: the namespace case, since hs_dev can only come from the init_net scan
> in iucv_sock_bind(); the transport case the earlier patch went after, since
> classic sockets have hs_dev == NULL and drop out of the walk; and delivery
> to a socket bound to a different HiperSockets device.
> 
> I went looking for the regression it could carry -- an accept-queue child
> left without hs_dev, which would break connection setup -- and it isn't
> there. The child inherits at af_iucv.c:1908.
> 
> One thing it doesn't reach, and it's why I'm not dropping both: the check
> sits after EBCASC() has already rewritten the transport header in place at
> :2073-2076, and a SYN matching no socket still takes the !iucv branch at
> :1872-1877, which swaps the frame and hands it to dev_queue_xmit(). So it
> replaces 1/2 and stays complementary to 2/2.
> 
> Send yours and I'll drop 1/2.
> 
> Thanks,
> Bryam
> 


Thank you very much Bryam, I fully agree.

I've sent R-b for 2/2, and propose to take it as it is.

See https://lore.kernel.org/netdev/20260821125501.3718748-1-wintera@linux.ibm.com/
for my proposal that should supersede 1/2.
Your review would be highly appreciated.
