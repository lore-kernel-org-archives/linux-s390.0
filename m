Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35054570FF;
	Tue, 25 Aug 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663896; cv=none; b=txLYUOdt6hu/ovo9TMRXss1V8K1lAgZFX3YaHov+C+Xy5B1ZxVlEf54QkgHgoDGWzW1c8fNnwwwixUhUSHNBJzKzAY3JVGnqeDHgUpVCBceh8Kv4+4yN290MmBp+xmMEVgvdNvKf9QewFKJTiigtab3dvLL9QIPNMKxWB5h6Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663896; c=relaxed/simple;
	bh=0gOON3ItOmuveT/fW/8lchZVPwBeCSUBxPOsMCTo7js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBVK6eSi11UAdf88rY9eroM/tIoLYnX68zuIcoyKWzoUXzxesODM3V7i0mDA5Og8I6nCdciptphNgAh1A2iCFVQJbN7zjE3/wgSCglYs+dH8xvzd5DAhJfZwCj13evA3bKToNo1yJM+JbnoVzSXVdjIpJaV8vP4yOmoF3PgRaiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZytsgtAj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZytsgtAj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PB1hcf542716;
	Tue, 25 Aug 2026 13:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dQpWIo
	RQGHQH8oA/J97xzxPdQHCjguckfCEAVqaXb9Q=; b=ZytsgtAjGrcGwPdZ84qNqy
	SoZ9EI1Kbj1+GTq7LI1+wAezxvIfDxNq6/4Gm/ZXyOqNMqe48znQT3T7MhmxFWuS
	7Jw9uNnYdg8R4uGobLzNLF+VosTkl2Glv4PHYrnxWq6UoJv5VHJL34vqa8Y5ouTO
	huz9OA8VNH//AXkVNd2X9au7CEDuWLLhUVJSn/icqWekGR6cjzew/jHzn4vzYIYo
	bNnAXWXPHsVIJisomt3yysw1JzbCQQNkqNBv/AamgyQb8zAHmqbwVN5M2Ao6z8Q3
	XhKNbTtlSrjUlkoO2Pf4OUr6bW2gsusUG+97SiL93csKkAoI9ecx2LsRicqsOMUA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hrfj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 13:18:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PDBGT3019949;
	Tue, 25 Aug 2026 13:18:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q4ku6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 13:18:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PDI0A745351212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 13:18:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A0432004F;
	Tue, 25 Aug 2026 13:18:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B695320040;
	Tue, 25 Aug 2026 13:17:56 +0000 (GMT)
Received: from [9.39.20.186] (unknown [9.39.20.186])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 13:17:56 +0000 (GMT)
Message-ID: <f34135fd-ff30-4e9d-84ed-cf4cedbbcd78@linux.ibm.com>
Date: Tue, 25 Aug 2026 18:47:55 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] net/iucv: fix the recvmsg window update
To: hexlabsecurity@proton.me, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
Content-Language: en-US
From: Aswin Karuvally <aswin@linux.ibm.com>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExMSBTYWx0ZWRfXxTLOkfaNMFj5
 1cemYu/kZ6bpmDwFyC5XlZEDP3mKFYQ2zsDp/CzvEWLFT7ydYG4Qv8vpv32fVZSsXwK403/d6pR
 k7ozKYm97rVWRy2reE+Ud2OhxzpVaEA=
X-Proofpoint-GUID: vSEVgRebmgPG2Joiy-NMpQABeXCs6UWq
X-Proofpoint-ORIG-GUID: ymgsZEEDQQX3VsvAaDaCSLL_FGGCQrPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExMSBTYWx0ZWRfX9l4DFAapfelw
 vrlvtoBMTuyV1iZFfKPPZ+0+Z+Ki7Lry+B8JlIQsWR2a3FbgYzfvWWo4dDSBQbBI4AUr/QVWgpx
 gy1euejpG9WAQw8GgH5lpylm11HetX0TMAIQixAnhpY1mPYMm1UUOblEl5gAGu//0ry6B6G91VQ
 XptEY7fEJ7vfXGunzDvJJaWp+yT8xopu7LzIgOgXcS64Zdbti356awSFGzGkxqyxjHCIJdDxv0v
 6h5qGaEQU7ICKJAvNKUiQzryYeWewDBbPJc3meqaUh8WtSGm6YFy4yf6Nhc9fvGLYT6Ij1uYMkd
 1b8OV2VtiSgnQgJcNQ71E0TveSMEVktuft7CMQZmyFdx0ZpId2Zw53Q7yImnyoZMXOzNnNbflLA
 PBOLCIzyjNbETo5sDppNSp+//JVNv+ndXg3zLo5woe3oezFlb3pn4f2S4hbp8iCPK4H6XrNHswO
 OtDrDFThgia8PWLKYvA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8d960d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=hpx9BEuE4PY9g35JE8AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250111

On 21/08/26 16:47, Bryam Vargas via B4 Relay wrote:
> v2 answers Jakub's reviews of v1 with changes rather than replies.
> 
> 1/3 keeps its hunk and states the impact properly. SO_MSGLIMIT accepts 1,
> which makes msglimit / 2 zero, and msg_recv never leaves zero on a classic
> socket, so the NULL read is one recvmsg() away for an unprivileged process
> on a socket of its own. With relocate_lowcore it faults.
> 
> Its Fixes: tag was wrong as well. The unconditional send does date to
> 3881ac441f64, but iucv_send_ctrl() sized the skb with a constant ETH_HLEN
> until 238965b71b96, so before that it just returned -ENODEV. Backport
> window is v5.3, not v3.1.
> 
> 2/3 is new. v1 admitted it widened the msg_recv race and left it open,
> which isn't good enough under Cc: stable. afiucv_hs_send() samples the
> counter and settles it after dev_queue_xmit(); sendmsg reaches that under
> lock_sock() and recvmsg reaches it under no socket lock, so the two don't
> exclude each other and both can subtract the same value. Negative counter,
> WARN_ON, and the same credit advertised twice to a peer whose
> afiucv_hs_callback_win() subtracts the wire value from msg_sent unchecked.
> 
> Taking the socket lock around the deferred send would close it too, since
> recvmsg is the only unlocked side. I didn't: recvmsg has never held that
> lock, and making it do so changes the receive path for every caller. That
> belongs in the locking rework, not in a stable fix.
> 
> The claim sits after the last error exit rather than in the header build,
> so the counter reads zero only while the transmit is in flight, and a
> concurrent sender isn't talked out of its own update.
> 
> 3/3 is v1's patch, and it must not be applied without 2/3: hoisting the
> send out of message_q.lock drops the serialisation that lock gave two
> concurrent recvmsg(). Backported alone it recreates what 2/3 fixes. Both
> changelogs say so.
> 
> Litmus test under LKMM: the counter reaches -2 before 2/3 and cannot after.
> No hardware run; I have no IBM Z, and CONFIG_AFIUCV is s390-only.
> 
> The unlocked hs_dev and sk_shutdown window, the unbounded backlog_skb_q and
> the WARN_ON a flooding peer can reach are pre-existing and wider than this
> series. They belong with the locking rework Alexandra has open.
> 
> Thanks for the reviews.
> 
> ---
> Bryam Vargas (3):
>       net/iucv: only send the window update on HiperSockets sockets
>       net/iucv: claim the receive credit atomically
>       net/iucv: send the window update outside message_q.lock
> 
>  net/iucv/af_iucv.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> ---
> base-commit: 746fc0787f616da418ffc04a110296fe95d53491
> change-id: 20260821-b4-disp-3a6e8695-c1f4a6069169
> 
> Best regards,
> --  
> Bryam Vargas <hexlabsecurity@proton.me>

Thank you for the fixes Bryam!

Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
