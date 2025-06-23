Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AA201261;
	Mon, 23 Jun 2025 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669061; cv=none; b=SsrXYo2CtW9c2/YEP5NGIARYV6Y+gtTUmYZ6DYOxXNjTJ0tNHzw9RKQ+SBZc4ZiDYNLTfse/lZSCc8jderzmhxJBocdvC8FitIOP1EZWcfcwfZ2OL6Crm8QZU/cCqe/vKeyWDg1Jzb436ujWp0KmXQKMf4yQl2OzBxofyTDUTtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669061; c=relaxed/simple;
	bh=t7FHICmzE4r3QRYdc3oFhrMV56wP74z5AL9PhKJSoqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjFw/mNZrsBEM9lYi6B3OTcR7k9F45yGzV02v58zy00p5Uiq91Eq0JlkKfpqaM2sZ0j3WaV0dvL36hRgHSuWXWoZovVW3BE0nZ+VOsr2GlkE6odG2lGTr4IL5/xbVxPWyhiQwW0lMKKtb3mjqLQ857XhoXO4Rf0FOzI8hn5yl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qUnThEPl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qUnThEPl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MKQEMP005484;
	Mon, 23 Jun 2025 08:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZPbrsJ
	MJDeYor22LNf0/ZRrF8mcPclVDdrKXL6sBJ+I=; b=qUnThEPl0BszX7EQwmS0ru
	GwM2qR479/eX4iRporQR3We4/YVrJapbs+wQ3aLSwYNbK398VmQX8MnMAJithBTw
	3W+Awfvjf9TODhW4kHL5CUQhb2yy1Xb3a73CP5GgM9ybeA71M3cOrHWkYVH1LqG/
	2Smu3c1FXpCot0gOxiKdvmkFDWx0Ybxd9UpUV66hHuHR2QOqRBdW6ZENYoQs5cbU
	2EP2ArkDOu3Ah7MfcJba4Q6LXYzgy/hBAFuhtFLz51zrEMFUqqKz4YzNlrZRE/uu
	gb3DImJ8KGiZMHTy3uimgnXIJlA2P3tpWe9Oq82O/p/XfAJiGd9tOygUjJWDLKcg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0dak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:57:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N8rWCU028212;
	Mon, 23 Jun 2025 08:57:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0dag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:57:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N64mFL014710;
	Mon, 23 Jun 2025 08:57:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s251t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:57:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N8vTfU15139542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:57:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D59AF5805A;
	Mon, 23 Jun 2025 08:57:29 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE3458051;
	Mon, 23 Jun 2025 08:57:27 +0000 (GMT)
Received: from [9.111.82.48] (unknown [9.111.82.48])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 08:57:27 +0000 (GMT)
Message-ID: <b477a91f-788a-4b21-b164-2628752de8fc@linux.ibm.com>
Date: Mon, 23 Jun 2025 10:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: update smc section
To: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250623085053.10312-1-jaka@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1MSBTYWx0ZWRfX5czYeZ3o/EDb 2gmuYjbn17CyYxbFaPcgTJvyIUj4iQURtgzKL8zMAMrSiNt+S0Hlh6L8Q6qCIq4EQItxXQtgUyy kOuLNHJKkaqC4xCKyZZxOz869XGf3sYdKf0xKoVnge/o3uVpBVz9+8pmeXlUfYcTYz6vxVgmpsC
 ecZR/CQQdOI7uvcDC6HbrlhBqcYqLwGfMPu6r/AdIy2FXWK0XSP7phMU2V8wJxLGwdUtiV5WQO1 wYFswKq4pZ9528UpZuqD8jQe4pQvoDfpEGYEZ0XVCai9KAqJ9XFBb5qWJDVztOBqhsJq6wfGCgb QPbkXRPqgAJ7m4S9TiwvfPLEYhRgCZgXhrKcpESes7xuhnPOqi0DV8V2nRlr2joc5BBRn9JXNLA
 8kunP8qoyWjggk/K4WHwRjmifIHvo5vd5S7DFli1S5egfubzv/RH7Un8ln1+4pASqykMmGkW
X-Proofpoint-GUID: UQ9TA2I7dqac2ZomIZ6sCT68GIuzLAmH
X-Proofpoint-ORIG-GUID: 1l91L2QK7vc-R1ZP0xqiXg4KlbGlhLnO
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685916fc cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=qPgYS-SWOX8TBiLe_hsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=802 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230051



On 23.06.25 10:50, Jan Karcher wrote:
> Due to changes of my responsibilities within IBM i
> can no longer act as maintainer for smc.
> 
> As a result of the co-operation with Alibaba over
> the last years we decided to, once more, give them
> more responsibility for smc by appointing
> D. Wythe <alibuda@linux.alibaba.com> and
> Dust Li <dust.li@linux.alibaba.com>
> as maintainers as well.
> 
> Within IBM Sidraya Jayagond <sidraya@linux.ibm.com>
> and Mahanta Jambigi <mjambigi@linux.ibm.com>
> are going to take over the maintainership for smc.
> 
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..88837e298d9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22550,9 +22550,11 @@ S:	Maintained
>   F:	drivers/misc/sgi-xp/
>   
>   SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> +M:	D. Wythe <alibuda@linux.alibaba.com>
> +M:	Dust Li <dust.li@linux.alibaba.com>
> +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> +M:	Sidraya Jayagond <sidraya@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
> -M:	Jan Karcher <jaka@linux.ibm.com>
> -R:	D. Wythe <alibuda@linux.alibaba.com>
>   R:	Tony Lu <tonylu@linux.alibaba.com>
>   R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-rdma@vger.kernel.org

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
