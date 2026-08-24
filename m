Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA441B8CD;
	Mon, 24 Aug 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576918; cv=none; b=HcLbwahxmA8lB6MTMeVSPwX/wQIeOwHGmZFRSvEpLYZjvAa9E67M2dUeBTDlLvPy4RMm/NFecdtzk8y7p4KKsNmahbUGGakLhngb8BwfRIGgQYEBIBAIMAi8gM39icUh7Tid5/K04EYWOqQAeb6zZPyNwSm6BIWuiU6j28AcJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576918; c=relaxed/simple;
	bh=TQ+i+55YhwB8S/ZFTKAa8Ua+yTjcKuZsjlqGLT7It9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxYTM3KvrHnVjEGV8CGWbJvx2pXxWEXV0arslXYgosOqFFfLMuawoVBrjvdWEvBDlAHO86aCifz3z9qpvGkY9ohkN8knPqNujqFvGCGQwOdYaEoNvupy9uMyAwFr8xcddY+fBLdQ+NFs4fFQhedkGNllnapOiliBkR8OcefyKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YiXKnvlw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YiXKnvlw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1YVd1957995;
	Mon, 24 Aug 2026 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Bfw901
	k5j8dwju9Lpw50b74wdvY+BAP1/Ct5rALXEm0=; b=YiXKnvlwFPC1ihTwzAKtge
	J5Y2LDaMgCAjdjyPrU57kXG7bLnBPHYWk+IVeTpeGOuNvmx02GCnD1xmLrMv8hJL
	JzdnNV6fuSa9cc2g6XlNEIVae/kByQw1CkB6sYilfPF8ZARD0uD1p3kPa3M6S7sD
	uAtkECMJZzx1j26O6OIZj9WBgZGaj7JpIwoEJYGX5Tw8VCAqdBiuYyrl4soe/ETj
	2xdfA9NDirB3geB6qznzZNjP42c8mMsNQiPzXYvWXYABjUVxl2+mAbReTNHS7DJQ
	SJpRrlfe/v8cQIN132s51xL4njVZfPKOFo1de2ElwpG0BPwiSWNHLWtjoSjwg/NQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hef4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:08:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCvHoh016545;
	Mon, 24 Aug 2026 13:08:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxwsda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 13:08:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OD8L4n45416900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 13:08:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54F1D20043;
	Mon, 24 Aug 2026 13:08:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2537920040;
	Mon, 24 Aug 2026 13:08:21 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 13:08:21 +0000 (GMT)
Message-ID: <8b840ef9-6c50-4f0f-a04c-2dca3f5f40c0@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:08:20 +0200
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
        Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Hidayath Khan <hidayath@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
References: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260821-b4-disp-3a6e8695-v2-0-37597ff723a8@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Cb4QjKkhddu6GuqZePgKZEmR-4wMzYLC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX0N7gwjbz6t4s
 KEf6bvg6sJEPVA9Dxmk1/ZiT2s2/wNFnWnQ/FGDOQ69AIZGCbWkydauWjQD9ykXVA1lU6I0LPU+
 coYa3TU71o2FU92tsNTref4QpPiaEMY=
X-Proofpoint-GUID: Sn4c6IRNtxM-T99fOA10GX4j_SDurrEh
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c424a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=WiqbPmbkvyWkeHEX9y4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX/c78lCsm+2zk
 Pdxfc6Cgt6I60D8n0Q+J/MQBaIxN8aWkc/bGq1D3EJvUU6OKEBeoWQynaHXWBRB8ZnFqLBCEh20
 pX8ByZT5+QvjStyLWdLZWmzJNgYICgzrXWIibZcmlB15jDtGz8JYgDYoc45qZMokekGWjNOLivF
 WJFwMEkQD7FoY7XnTrBDPCEIoNfo9sJMJRNNsVlBrBoN1KkM5opYYKqetDWa7K0t6LhnvxuLe68
 xsMZHCO9s5hI2Uv95/tFr/cj69Q+8vH393tCupLrhYS8+F3E4N1ILWoFJnZKOo6oWGSLWIgIcEl
 DmcJZ9cS0995b/MOaFjNGR3aZQiXuEO+lPB1ctTkZqeCHYAY3BrgHzhVc+F4MGZN8RBQjOo1GKo
 ty9ajrZFBFsiyPlXBb7EwOwIN/3wIXZcCckq8Mn3+qOSOLzfXvrJDDdh14ZdCIrYrqUrrnflCaV
 UrARgMEsfwBEWJl65Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109



On 21.08.26 13:17, Bryam Vargas via B4 Relay wrote:
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
> 
> 
> 

Thank you for the fixes Bryam.
I have reviewed them and would technically give an R-b to all three.

However I propose to send them again as one single patch. They are
really about the same subject: iucv->msg_recv handling and even have
a dependency, as you rightfully noted.
It will be much easier to proceed and to backport them, if it is only
one patch.

I know it's a tradeoff, but I think we will do ourselves and the
upstream maintainers a favor, if we send not too small fragments
of fixes.





