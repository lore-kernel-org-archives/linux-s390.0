Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EE3A901D;
	Tue, 29 Sep 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668767; cv=none; b=a44S0U38tCjj1PgfUqzHYwS/PmkVX7W1Je4Ml63qFe0HFxFAEvKaUJiIfSsQx/1D7fR6bGsBMXCBwqPX+hDOOEE/41gAUo9zqSq0MH7tpaJmebBK/gtV7Jt9m1x8xyg/FeZhjlHxAL/UkO0+FtCUbbIerY1BuU4BtJx81Hut2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668767; c=relaxed/simple;
	bh=XatRpQaf0QzysXxX+7yxAEVKzUZoXkival6gfjqGo4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adE3sZ6RIKDwhghCGD9r0/5hfwIB7M/kcjnA/sIQJZEvkQKx1Qb8cNBnuJHmoISE4LlrzDym3CWCHD4j8ky9s79Zvg+s2g+eLx9mvCC90+Ys2JyyJbPngWphyVjiaQmcIr+n+ku6Zq6bhyzALzyQpoBlmW/xOUnLSmc90V6Et70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FZrVLgXk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FZrVLgXk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7ZhLG3344955;
	Tue, 29 Sep 2026 07:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vNnz6B
	VUPMu+4LfEGiTwwlWfV6MDi2XPBEGzS7tQZuM=; b=FZrVLgXkNwrxwXoZCeQ+tP
	aHaEhiTJ9zwf+hENEKks0pZAgOXtIXX/gUvskvhH6iT3Ma6VhJbY/qv+Lsa6v86I
	3q9B3b6zz89ADpRVlW2/5eNYFs/Tkxj4jZQUUysuyZcSKyuLWFJbht3JoSdAU7+s
	lE0W5G6PmhoQTF0YiBm3IU2WProrh8blAo51OJ2uUm2GDwXCd5USFoSXsYRAHFky
	FvDKRqCDpwx6v4n+LY/gfj0/W1k7AqZTFeIxvQ5d+OU4JlJznEAXJSjRRNa8tnJa
	2ibn/J+eOupe9xY0us4M8+sUfuGAHa9ay11V6ZEhuMRGbn93KIg1phlRe/i+SsxA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk5hqj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 07:59:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7WTV81399784;
	Tue, 29 Sep 2026 07:59:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpryr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 07:59:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T7xCtE30671386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 07:59:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B4EF2004B;
	Tue, 29 Sep 2026 07:59:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B46D020040;
	Tue, 29 Sep 2026 07:59:11 +0000 (GMT)
Received: from [9.111.133.97] (unknown [9.111.133.97])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 07:59:11 +0000 (GMT)
Message-ID: <b6352a09-c9d8-44ee-850d-24731bdda69e@linux.ibm.com>
Date: Tue, 29 Sep 2026 09:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] s390/ism: Zerorize dmb at allocation
To: netdev-bot+sinfo@kernel.org
Cc: Aswin Karuvally <aswin@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        stable@vger.kernel.org
References: <20260928151420.383105-1-wintera@linux.ibm.com>
 <179060878011.31693.9560616938197921438@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <179060878011.31693.9560616938197921438@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Dq6oxlTlGgjWbDKUF6Laq3E-DEFTiGtJ
X-Proofpoint-GUID: LX339yYhOmkuhCuHNvupgdyJPLuVlVi2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX47Pt4eTPiKPy
 k/EjrQWQ5DFOE5LGiGPiwvninrOXwRGSXCRjqFH3lXuFu0a5sA61VN0ZmmrxhVxKCSaUkvNB/r1
 jRKqPFCslJ9CeFSoCHuXhIgKFQlWiro=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abb6fd6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=xiR1IYxcKOTdaxYgfMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX0pt70fkGDxW7
 XXk7PMNpleH0FxCYJPO0P3hb1eC0nmUm9xoKCOByjBW2UA6MpCxo6CFVqmZfwCghNpXzuZsQpcB
 1KQtp/fNXINRc2DHeuyHMFydoeQpxCDxVy91xxub3VqE6iwUzhDQlgR1CL8ypCR08h/xhlGEo+c
 fl7/RA+8pK4S43FOPx4s0c7XWymbeZXiUnKFTT6SqXjKf7GEnCxHPd6guMij9pzZm00n8iywLD9
 O82L692RZrKzuWWW6T9Og5nS3hffGowxRuaOEo7HmWHdzwNL5E0n29B1psYjoi2+qxUp29t4nOE
 bnKoXiwivQzgDUMEYOz1kqbL/+ulUCg2k++HOs7AaH/0KWGgXeW3er8Gsve66n7+0fV6WWaBrrv
 fG2f5dEpGICanDZWcSod4Pf3QSErX0ajVjHP5FL34DDf1w5r5X7idTHxc60CNUb43heQCbX7TXR
 7rOZ1wOTQTVYOmAYEEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290030



On 28.09.26 17:19, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.


For reference:

On 28.09.26 17:14, Alexandra Winter wrote:
> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
> uninitialized kernel memory to be exposed in the receive message buffer'.
> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
> general the smc kernel module (dibs client) will only push newly received
> data to userspace. We still should not have uninitialized data in a receive
> buffer.


As mentioned in the commit message this issue was reported by Sashiko and found
valid by me. I do not see a simple reproducer.

Alexandra
