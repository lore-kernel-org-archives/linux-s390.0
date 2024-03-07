Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D371C2A3;
	Thu,  7 Mar 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801947; cv=none; b=JWSqMH0Os3tsII/RWfS3JL0zWWlU6bMh4UyyJqHwg3mLhjbDJbzr8TtbW+Ru0/NvvriHJloWpdIJtac67mwyaMvQnhgOL3vVanb0p8RRaPyupRF3A+B/xI4W4buDVc7FadaFFrm5n/YUYZE/ssYiICTP1vUoyAOmbMmyn8WQ3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801947; c=relaxed/simple;
	bh=MCYgMGtQJtqVbRnKxbazUlx9MGSIM/WNDXib9Lpb9HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2TTxrCJDFfZ61oabMVOqbzCsnZSsf+QzIWmIcXdVUDg6h13MvMN9wS37spUWCRdyTz3+wzPrWrw51QkbsUwO6b2s4ZDXgf3Vnk63T7CoNw2qd8j9yNKieG8mcrMBzcK5233VOj0ZV1i1+iFvsGbA+QnWs6mVZPLSKhOmGa9tMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZmFAUEgm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZmFAUEgm"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278W8Ed019975;
	Thu, 7 Mar 2024 08:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Xv/Q0bS2Hu0DTbKJ03ULvckczUzm75J7LZWmXWcXLZg=;
 b=ZmFAUEgm4bAvz9pQsQOx1v+YvK5fVhEDfo/3DD4XpirEAQh3CilA49yEUuUaVJpgO+XK
 OgQ2P63NppbXoAzFu6Fzu//9H7AHDjVXXYXcJA9TUTPLmU9xlYNUlM3QeSWYHa5jrD0U
 atkcYytkGdhgchWtCtHQOIGMa+7zNYsTQlwSOfHoTMKs5TED9cyFhZAp23dChoT6BqPl
 xza3vf34rUWnbHQ36Lk+dgF2Jv4oGlMxFQ9/3jx873gstr1MpOx769kVJo5oNFEPXb2N
 p5vpKw5R3xSGCK2qLutk2wGfSQ+4qdOy50ygD+OYDbqA7O+pGLLD1//yzP2wh1GgwNv0 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5bgkrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:59:01 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4278fbRl008404;
	Thu, 7 Mar 2024 08:59:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqa5bgkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:59:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4276N4Io031530;
	Thu, 7 Mar 2024 08:58:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkc4bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 08:58:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4278wpWr28049968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 08:58:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8FD42004D;
	Thu,  7 Mar 2024 08:58:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A1442004B;
	Thu,  7 Mar 2024 08:58:51 +0000 (GMT)
Received: from [9.152.224.118] (unknown [9.152.224.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 08:58:51 +0000 (GMT)
Message-ID: <6e62fdbf-a5d1-4650-b0b1-2a2698ed2040@linux.ibm.com>
Date: Thu, 7 Mar 2024 09:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] [RFC] net: smc: fix fasync leak in
 smc_release()
To: Dmitry Antipov <dmantipov@yandex.ru>, Wen Gu <guwen@linux.alibaba.com>,
        "wenjia@linux.ibm.com" <wenjia@linux.ibm.com>
Cc: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240221051608.43241-1-dmantipov@yandex.ru>
 <819353f3-f5f9-4a15-96a1-4f3a7fd6b33e@linux.alibaba.com>
 <659c7821842fca97513624b713ced72ab970cdfc.camel@softline.com>
 <19d7d71b-c911-45cc-9671-235d98720be6@linux.alibaba.com>
 <380043fa-3208-4856-92b1-be9c87caeeb6@yandex.ru>
 <2c9c9ffe-13c4-44b8-982a-a3b4070b8a11@linux.alibaba.com>
 <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <35584a9f-f4c2-423a-8bb8-2c729cedb6fe@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ngf_jF_Cztk3SP8HgUlA7c8spmmYwxYj
X-Proofpoint-ORIG-GUID: 1S1W1LwGtL_ecY16gINa2UoE3QKNwzEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070064



On 06/03/2024 19:07, Dmitry Antipov wrote:
> 
> Well, the whole picture is somewhat more complicated. Consider the
> following diagram (an underlying kernel socket is in [], e.g. [smc->sk]):
> 
> Thread 0                        Thread 1
> 
> ioctl(sock, FIOASYNC, [1])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->sk]);
> sock_fasync(sock, ..., 1)       ; new fasync_struct linked to smc->sk
> release_sock(sock [smc->sk]);
>                                  ...
>                                  lock_sock([smc->sk]);
>                                  ...
>                                  smc_switch_to_fallback()
>                                  ...
>                                  smc->clcsock->file->private_data = 
> smc->clcsock;
>                                  ...
>                                  release_sock([smc->sk]);
> ioctl(sock, FIOASYNC, [0])
> ...
> sock = filp->private_data;
> lock_sock(sock [smc->clcsock]);
> sock_fasync(sock, ..., 0)       ; nothing to unlink from smc->clcsock
>                                  ; since fasync entry was linked to smc->sk
> release_sock(sock [smc->clcsock]);
>                                  ...
>                                  close(sock [smc->clcsock]);
>                                  __fput(...);
>                                  file->f_op->fasync(sock, [0])   ; 
> always failed -
>                                                                  ; 
> should use
>                                                                  ; 
> smc->sk instead
>                                  file->f_op->release()
>                                     ...
>                                     smc_restore_fallback_changes()
>                                     ...
>                                     file->private_data = smc->sk.sk_socket;

Thank you Dmitry for your detailed explanations.
It helped me a lot trying to understand the problem.
And I'm still in the progress of trying to understand it.
 From my naive point of view:
Would it help if we catch the ioctl and check if there is an active 
fallback and either stall or route the ioctl to the correct socket?
I've seen that there is an ioctl function handle in the proto_ops.
So on a very abstract level we could do the following:
1. Indicate an active Fallback at the start of the fallback to tcp.
2. Catch ioctls.
3. Check if there is an active fallback.
	NO: Pass the ioctl.
	YES: Wait for the fallback to complete and pass after.

If this blocks too much we can obviously do some finer checks there.
E.g.: Just check if the private data is already at attached to the socket.

Do you think this would be a suiteable solution?
I'm going to look into your proposal Dmitry to see how you solved the 
problem and to understand it better.

Thanks
- Jan

> 
> That is, smc_restore_fallback_changes() restores filp->private_data to
> smc->sk. If __fput() would have called file->f_op->release() _before_
> file->f_op->fasync(), the fix would be as simple as adding
> 
> smc->sk.sk_socket->wq.fasync_list = smc->clcsock->wq.fasync_list;
> 
> to smc_restore_fallback_changes(). But since file->f_op->fasync() is called
> before file->f_op->release(), the former always makes an attempt to 
> unlink fasync
> entry from smc->clcsock instead of smc->sk, thus introducing the memory 
> leak.
> 
> And an idea with shared wait queue was intended in attempt to eliminate
> this chicken-egg lookalike problem completely.
> 
> Dmitry
> 
