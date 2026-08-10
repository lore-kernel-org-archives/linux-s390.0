Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203E4A32;
	Mon, 10 Aug 2026 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348058; cv=none; b=eGVvUa71DGSg1oFrF8CnVxxbXOv80fKnV7Z7kAXSBHgrcr2TAkqWn7x1vupCjK2C0DWP33AZ9EN7p5WcjWix3PD3UY3c9FxZrGBUlWbrZiusBrU2imJ3m/yfVP8IW1LcJ2+evhP1SxOD4zQ52ap+E0MZVkWv2wINOOo5OZwFvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348058; c=relaxed/simple;
	bh=g7MIX4GKv7NDCNx6HOis0FNG6NziKw6qgJWUn+u4pKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWaKvbSJFd3dxYW6dogy1c5FiAKeaH1i1s8x0mmaF0pgQ9kVq8hnfO3Pmh1ctmOavteCg3zkuru0dvlBZ75VdHd8kvcyS4AKlx/oz9BWmiodjp/R8yF8cmWyICV/KNHuGGsP014TDtICs0DkVfoDBIdgWZPVpvfK37IVaQbuB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R40WBjjL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R40WBjjL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A5VRk6752139;
	Mon, 10 Aug 2026 07:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g7MIX4
	GKv7NDCNx6HOis0FNG6NziKw6qgJWUn+u4pKM=; b=R40WBjjLVYmflnTmwsS8Ce
	ZJletgeZJsz2/thjphld6DvwML/jBO8DQ3UsofIDf3IMqJzbVElkEQzXeFH3rFuz
	nEoogST66u9OVTNO9nORFa1eQBimeG+Ul3nC1ixHK+SsGhoVjzXLwpuPK6pBEP62
	Q5x1dY0hl1WS1ZE2QXslJ8/+7ITAfBrNO9KV52FLT8kFeXPqOmIyAN6apccVIqka
	jDWWjZrMXPpGdhJUYozcFeW0bzGg8SwAfC+JSN3KSqC4U/Kr7jXMPJtYNSyVmGC4
	tEo3OUPe+IxATbxmoFAWbu8DMpT3IFKgECfBQYHnOnCvxACn7r0R7/f5EfPzEyRg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9eugm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 07:47:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67A7QO9x016210;
	Mon, 10 Aug 2026 07:47:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vuya6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 07:47:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67A7lDOE38535652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 07:47:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBC582004E;
	Mon, 10 Aug 2026 07:47:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1D52004B;
	Mon, 10 Aug 2026 07:47:12 +0000 (GMT)
Received: from [9.224.91.49] (unknown [9.224.91.49])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 07:47:12 +0000 (GMT)
Message-ID: <6f82c1f5-06f5-431d-9b23-4e34c8572c8a@linux.ibm.com>
Date: Mon, 10 Aug 2026 09:47:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net/iucv: af_iucv socket locking - accounting, and a staged
 plan
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thorsten Winkler <twinkler@linux.ibm.com>
References: <20260724222917.134769-1-hexlabsecurity@proton.me>
 <f74b9587-c09c-4fce-9415-e2d3b49d0247@linux.ibm.com>
 <20260809014911.752106-1-hexlabsecurity@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260809014911.752106-1-hexlabsecurity@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA2MyBTYWx0ZWRfX+y70lmAPLu74
 nAvsmNKs03aYW6TForlczlil/RUIJ7dwMHaiUjV5fjisV6YOyQHwnfW2DdujlwT+wf5gh+lJGl0
 WKZRkYz9P5oTbdZ1m2y/QpwKpxxUtEveXJHQ1ep2vM41EYdho1yr4fbV1lr0/B7lMBCQR+HvCou
 6KpujKIZEyatOzBnNJ6seg2sL+PmJdgZFVGlj5L5jy4f+O80dhUv0rxeBlYXqlRl3JJYsUAm3Hl
 wKuJ3QraX3JPoLu6ZFnHG4FIZ1SQBG4OKQ7uhZ2CQwuDjeQUPz2SzcuJ1WuThAul00QXxmwGuSE
 GIpCVPnOCBgBRCY+GUNI7nbIs2lA5o6T5/VK5HdcfnK7h9ns8CMb1+TZqMoUPG4aGRjxqlARCs1
 NEuILIRPXmbjU0QveBkrkNQ4GFiieX2m2FrctyAZmSnx/Q/1WbHAsxYNjbzR/6OxZyl+7wwL/QG
 rNUnP0sYUh2Rw8250gA==
X-Proofpoint-ORIG-GUID: 1sRoKFbtWRwXFM--b_9dg4Ib6fOgmHk3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA2MyBTYWx0ZWRfXyz5ijW14Bi/t
 7mJBAakkaivEyOAoDCcyJNbbiNU6EHd0ESM6a8Bm7kplRob9+QWj1z68H2JnuGMJ08JLOrjBuQH
 dl8JJtx5Lj8KT5pnorIyREddnZ0FZlk=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a798206 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=V45w1f9ymux-jMZoJjQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N-i0qHDQlNPloHC5238KVQ-iZp6VoD_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100063



On 09.08.26 03:49, Bryam Vargas wrote:
>> That would be great, we are also working on several small fixes. Let's get them out of the way.
> The connack patch is written: bh_lock_sock() in iucv_callback_connack(), the one
> site whose context is unambiguous, since connrej and shutdown run in the same
> tasklet and already take it. Fixes: eac3731bd04c - the function has held no lock
> since 2007. checkpatch --strict is quiet and it builds for s390x. Which tree do
> you want it against?

net, please.
