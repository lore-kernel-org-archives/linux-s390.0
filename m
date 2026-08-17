Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C42EEE8C;
	Mon, 17 Aug 2026 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979012; cv=none; b=Rb2mDh7kfoAclIkF13MFmmg4T6+BwO4rylwa6f1iR8V73vCrlFXLtf+aFUyhovUYSS4yYpSB4QATL2CxIZNPP9YYB6Wb4WEAtOSeBki0rmB/8YGu8L6SoyV0NSpYlAnCytQOOxGImuyxjhww0MzEv2d6A5sw2biPL+OcVLjHV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979012; c=relaxed/simple;
	bh=72cBH1ogUFdWYYyhDfVvYFm94Xfqh7ns3CZ47s9n5F4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cN340VStNdFoarVr9Hont9Eh1IqYMlt1cREq9Evn/ylfFFCOx1uA2g3JpuSFiqVuomVhMXKlsqbx6gPedN6YfMNedCUEJlifWp7EsqOFzqBtKAAbe75+JG5EWmLsWQCs/Szvcoe9xySbQnaRqOZAhNwOJGIZ7p2mSTr3nuAOgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FtrMgFRQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FtrMgFRQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCWMfu1349033;
	Mon, 17 Aug 2026 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ICiuKD
	woKeq56o8TiQa6AtaTew1A8yOUfniA2Z4g+Mg=; b=FtrMgFRQGx609lNp9QGQwV
	49xHaJh0lRf8KXj1uEIm5QI8BRD2oGLrBq/BpnB9Gv7Noew9GHdv8URVQg6HG6/2
	Zlm6vsw8VKLr44QMo14QI6W8D0wy6wxC2V7FYndYuXXEuEwz1Lw7wUEATZfnowYX
	aZM4Mu572kQXmciZye8XThDMaujzZidg9cbc2WHRyVy8+ucO9E4HWoXSUpJNanPm
	4Ypf4ZIVa62x4chcM118FVAh/US4fdZOGBWhnHHhb3tgFw4yVemepYs/0e4IWaZx
	KhHKviBxNLuwpePo1FVv5Y4ewkytoxsQUMlxO16ZsUtywTBqa7YFh/fxrkbOw4uw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3jw4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 15:03:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HEuQIi026618;
	Mon, 17 Aug 2026 15:03:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epxnm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 15:03:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HF3Iln38470142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 15:03:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52EBA2004B;
	Mon, 17 Aug 2026 15:03:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2290620043;
	Mon, 17 Aug 2026 15:03:18 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 15:03:18 +0000 (GMT)
Message-ID: <2edbc943-1485-4cfd-80a6-165271463dc0@linux.ibm.com>
Date: Mon, 17 Aug 2026 17:03:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/iucv: descend into net/iucv independently of
 IUCV
From: Alexandra Winter <wintera@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
References: <20260815135456.53684-1-pengpeng@iscas.ac.cn>
 <20260816135517.816271F000E9@smtp.kernel.org>
 <4fb902b2-bd5e-48b0-aca0-07e51a80d8c7@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <4fb902b2-bd5e-48b0-aca0-07e51a80d8c7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GsTb4p3M3CnjROCUTirXHjUB4K97tP2j
X-Proofpoint-ORIG-GUID: wlHiJJWO5oOuvCGmwrVyhCI7bd9XDcUq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX0NzH2Fa9m9UQ
 rabN91v8jTfp4IybeXHmbIilVVwXpsm0xSYFqhOa0MsgeCCX3HE1iAf3VuxLHWi5Q4++b4cR/rE
 A85JIN+DLLrc5lFCGDeVwfNjLEwvCSw=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a8322bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=hsW9paApf2v-0O2tkuYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExNSBTYWx0ZWRfX7ru5f9Mzx9qL
 eeSaK967D52DjolBkQO4Ux3UZ3fLdAue8yPoJ+Vgm1KQe24eWlrOnZJwRDxIsrZGE+evjQGms9s
 Oxu8j9pRPK8oz6VOjBKru/wFoGi4/vY00Mvim5leP0DwwXGhNN/twR4dtYloBAx9ii90o6JnksN
 QkCEtLifJ9YqdHYN2IPbS0mbz7BYkZ2VJ2OuDRVjFzZoFwvFB5gKialnbFNAnp+iYD1IGs4OJjS
 PaQJUQwPbZ/qYJbX11dfBb0YVl2210HvhQGmTj9Lp5BE94Fy6zTMx+OBz7iwu+lWNCKR9Y87y0P
 rHtoTCkFNUGiiKrXeMkRBcoiYZ0DN2VFLA+X6Lpry0qwnCeE4ZlsQ0Fkj/cSc7RswF0exwJP1f2
 tVtcBxLBIBcmK6dkxBIg9RBzQ8asGP7aRBT+0H8vOSwhvtyBnef96ZfnLx7oFvABEHiKodQ/bE6
 Vhy94JmG1X/mH4R85nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170115



On 17.08.26 14:06, Alexandra Winter wrote:
> 
> 
> On 16.08.26 15:55, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Unconditional descent into net/iucv/ causes a vmlinux linker error when CONFIG_AFIUCV=y and CONFIG_IUCV=m.
> 
> @Pengpeng Hou,
> if it easier, you can also fix this issue by making CONFIG_AFIUCV depend on CONFIG_IUCV.
> I see no practical scenario where we would want AFIUCV without IUCV.
> 


And I agree with Sashiko. I did not verify this combination with your initial RFC, sorry.
So I propose to depend AFIUCV on IUCV instead of your patch.
Do you want to send such a patch, or do you want me to do that?


