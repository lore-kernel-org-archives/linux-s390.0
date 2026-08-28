Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B93409637;
	Fri, 28 Aug 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911568; cv=none; b=ckZe9r1RrYRW+R9wAnNy/z3Wjk1BSTdeNYnCcv2BNEcA80CXN+30kcX/Izf4tj6oU2hDcnC5j9PsxaFPc6oVD96yx28d8N5lyCBGcFzdGNmanaHpo432nBFNi2OqfvRKhDNJfmz85DwNJ5LnTOSEQJyawEIXfpjf2wsiORB0mTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911568; c=relaxed/simple;
	bh=X2bq9OIm48Q+SAoL4uEP6fjrYNFiKSJHuLKLbDkqb14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sezqb5tf5IyNgPGYY1J2QdNZ219/8I/qbglE3RFzj+ghwaWxdzIfr61Rz4/DNaa3IqChR4aA3ReApZsSL7Jpjmxqs9KGPoB6nIdb3m9W9JvLoeGL33SlBYZA4ZN7c5ihitez6lL9icjYIsj1L70uKDOPHBbNxquCC9hginW0yfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7XnIuvM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7XnIuvM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S6Vgrn1183759;
	Fri, 28 Aug 2026 10:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zcld0B
	q7lN/AGA+G8wNPr3Nv9H3ZtxPKVLAMCEuWJHA=; b=N7XnIuvMS70Q5qMT5NxBSS
	4XgpweFv6Ig8DQTT1bdIMSu8Nieql3vrgJAe+zG8JYoNa0TNxwYtAcSAVCBQ6h9H
	30WvZjVgu5kI3I/70jZE0EwhYGrJhSBM0t5oZW7vqlhsl8uJpmiCDXQwcF7J/7c2
	M03SLPPId48p7pB3qid+yDxoNWOWIgFX6Bg1aP+9AvyAZdvxf6QsgQrvQBbOKNm0
	4LHpa3rVVCZHRHVrMgEADwAUXXwSzxHoJzDB7Mj0ZX2nrE0JWaXtoegivkNNhnOc
	KDjoLM5lz0Tj1+mRRbWTIOlWA8Xco/UPw0UFxwJa45FZglWgS57WT9Hybq2MZ76A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394kf1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 10:05:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S9uFgU027443;
	Fri, 28 Aug 2026 10:05:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragwcj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 10:05:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SA5ppe13697418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 10:05:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 824C32006C;
	Fri, 28 Aug 2026 10:05:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3792720040;
	Fri, 28 Aug 2026 10:05:51 +0000 (GMT)
Received: from [9.111.135.176] (unknown [9.111.135.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 10:05:51 +0000 (GMT)
Message-ID: <833853f7-6659-4e9a-b8d1-be27d5804930@linux.ibm.com>
Date: Fri, 28 Aug 2026 12:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] net/iucv: only send the window update on
 HiperSockets sockets
To: hexlabsecurity@proton.me, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
 <20260821-b4-disp-3a6e8695-v2-1-37597ff723a8@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-1-37597ff723a8@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BF6zlPgnwNa7mrkLfaLOMU-iGAUMta5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX5S0+zjSuXrt2
 4VisFqFbWkVR+dNJ/eeXwJnSo+mAqHo1YFGLOa/DLR/Kpkm+cKrSAD1HkzwYUXxacN/K5qb7HHF
 J3IT1cuQUqvrh6noGDK2YRuaRrnOnFWglmyhIcm2VX4AeVxaE+HnjT6JgHZU49tJ8ekNxFB7mmP
 J+d0uqy3fgLbgDQ0NhnAAk7ZwM26ncvYMxDhbrLTV/Ob12/FO/EYXHTZyt9oH3QIw5hKSYgJM/q
 DZGHTWeoWiip+ID4nHPPxqwMw3//+B7/yrn+vDIo7j1+jPVJ9FT+it2bA1Ym9L2pzjdC63u51TZ
 YJmIMi8kGEoeyNBHtZYBpDufZfV9aeeK7hOPx9EQ8qc3EpD3CPA/ovijkCMaet99dKB5dZWZj0i
 3bgY9QNdrE52R+WfWZKT2U1PtESMMYB7Qoil+Ysqz4MC+a81DPmbvgUaHv0ixKTz214gdtBPNUZ
 HxP1c8lcrX1zDqJuKdQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a915d84 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zuM-BvYbtpJmjVirTZoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX7BBrUGiGuUNG
 I6LgNYsMfmLd6EP+625cUpj2z30WTnQ0bGyijCYnhuenvYJZ6vkwNXTn9vAq0327xHXT5d8Q5Oy
 RB1YYdZE4ZeyP2wFqOpETRj4ipEswFo=
X-Proofpoint-ORIG-GUID: 3p_voacDNfRY4kBA6Thl4rRyZRQISzq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280086



On 21.08.26 13:17, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> iucv_sock_recvmsg() sends AF_IUCV_FLAG_WIN without testing the transport,
> but that flag exists only on HiperSockets. On a classic z/VM socket
> iucv->hs_dev is NULL and iucv_send_ctrl() sizes the skb from
> LL_RESERVED_SPACE(iucv->hs_dev), so the read goes through NULL. It is one
> recvmsg() away for an unprivileged process on a socket of its own:
> SO_MSGLIMIT accepts 1, so msglimit / 2 is 0 and msg_recv never leaves 0 on
> a classic socket. The read lands in mapped lowcore on a default kernel and
> the socket takes a spurious disconnect; with relocate_lowcore it faults.


Hi Bryam,

FYI, I tried to reproduce the fault with boot parameter relocate_lowcore.
It did not run into a page fault. My AI says: "relocate_lowcore moves the
lowcore mapping from 0x0 to 0x70000. It does not necessarily unmap all of page 0."
So a garbage read still happens.

The bug is very valid and I can reproduce the spurious disconnect, and that
it is fixed with the proposed fix.
But you may want to adapt the commit message.


