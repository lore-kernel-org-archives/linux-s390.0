Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBE3A7F68;
	Tue, 18 Aug 2026 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046228; cv=none; b=dtPz3cssa0jdBUmQ5td1N2Zenh9dCY9OxSPEB806HeC7xuuvLeGHUEUbAlSIMDdwav56Oak2bNhWtKXxz3MPWYczRs5gCeQY1QUagYgbtBx2O2UktOpwxst2Uz9TvbxH6ptroMXLdhPIj5MA4rIj7efH/4QylUl3UciKB2F8emY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046228; c=relaxed/simple;
	bh=caNA1FOovdtBMEmSP47lpd4CEtS6dN3xJalFINYYI3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3LC8GwQu/S/BF8IODnczx/y7CdbqaubK+EPyF1GXxF531v5JB0f0s3OqdUU+k8fo4hN1lVq4Bcyvz9jpDHj0RAnXXfWGVqZU0955KLg7LFNPdbo7QY1jShoAhb8OxZfUEW5L0F9Nz2Wsra/8TMvQ3AlUsDOkk/ITZXOmtdbvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEoJwjNu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEoJwjNu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1lUh2625083;
	Tue, 18 Aug 2026 09:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C0kJYs
	Y/VDcx6k/5tiLWBmUkqkCjleiQdPNfvMdCqm4=; b=OEoJwjNuUNGH+tESC0EihC
	fNewYEG/PEItOTqASlUlc2xzXzo998NThbhs6bn1K1KwE1zwbg3MgF2++PFEYE62
	T0Lv2VboX47IhDYpJZ5wPNMqLVBQlJpPzfS6ENYqoLv5yEt22sXakJIYwQKkWp9T
	1dT6bDyqHOwvF5PDDrYi2AOwaJdP/DR71edzT42bbFZTJmZu57TDrJpKmcFWR7C9
	L1v7TJvB4lFGtwZS8BJW43TVg+JYK8/Gs8qrBZEsHjW1f1DnZd50rzGbntNKDK6X
	zIeKMiK9FLjgcad+Y/oJ3uK6V+5ZvRjjNi0L2M4VbmDarqkclOaQd6wjz7N6b25Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4qcda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:43:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I9fLQf011428;
	Tue, 18 Aug 2026 09:43:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ya8xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 09:43:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I9hY2k45810074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 09:43:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 413FD20043;
	Tue, 18 Aug 2026 09:43:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E716920040;
	Tue, 18 Aug 2026 09:43:33 +0000 (GMT)
Received: from [9.111.161.182] (unknown [9.111.161.182])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 09:43:33 +0000 (GMT)
Message-ID: <aa5dff74-97a7-4996-85d5-b065d7dd4329@linux.ibm.com>
Date: Tue, 18 Aug 2026 11:43:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/iucv: only deliver HiperSockets frames to
 HiperSockets sockets
To: Jakub Kicinski <kuba@kernel.org>, hexlabsecurity@proton.me
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        twinkler@linux.ibm.com, linux-s390@vger.kernel.org,
        hidayath@linux.ibm.com, horms@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-b4-disp-60433a46-v1-1-509e1200533e@proton.me>
 <20260817202536.3590565-1-kuba@kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260817202536.3590565-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EXj7gnnyb_74mheflaMpWhC8cm4d4CfE
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84294b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=5px8zkL6CzUBe5c8zRoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MCBTYWx0ZWRfX8qhy1fbxJo3Z
 4YJ/XAlQBJu+d6HJ7Y/9zMj/6MOezKlldy/t/mXD87+5o9xISwpLPaUb5V7gRuBlXrp6HphkyCJ
 hs5x3EFqBWIw4K+dg0S4M/TjSaNb8PM=
X-Proofpoint-ORIG-GUID: -Xuhdd_YTPP6_tdaItA0Sw9tufHLU-kZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MCBTYWx0ZWRfXxs2xTzc07Iz6
 ek8m0508in+Qs1XrktrLh988Ym3hQgKvX8ni4/mnmNPgcTVVRWP81d055IaW4tTYXqpD++A0MbA
 +Y+v+t1nIgXkRAE34LssBXRFk/286Bzhk7q6owqoj+Mfs7wXUTHAQaP4R6QNS78NLasWJmS8CIu
 OLLnksMoBDr5X/MmJmcNyf5U0yuHvh/fPk+yfwWRyAIWCckHOLE7QghGXLggcduMBsD3Supfd4Z
 6l8y6rtlMZdKx8AsidNtItrQgkHH430wTqIEAile1W/zc46zcJwDXI9l2xlKsYiqrOc664iNdtN
 u5mj7x9YnXID8u1d7ClDHgaTaMc6Xdq/2BwXsDb5zxOmrSojBt/QVop1K6QBJix1TozLyH1q4Rr
 DQQ4bNM2breKuj0IeXYv9zow2299ar6G0sWDRk9s/j0dD47td4k76nTxy46n2q2byVpJE06bXfP
 UWS37Y1csAOs/zLvZVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180070



On 17.08.26 22:25, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Looks like other places need a fix, too. Please fix them
> in one patch, failing that in one series."
> ---
> net/iucv: only deliver HiperSockets frames to HiperSockets sockets
> 
> This adds a transport test to the socket lookup in afiucv_hs_rcv() so that
> an inbound HiperSockets frame skips sockets bound to the classic z/VM IUCV
> transport.  Selection previously used only the four 8-byte name fields from
> the frame header.
> 
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index ea047bab65e7c..5fb6793b9a64a 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
>>  	sk = NULL;
>>  	read_lock(&iucv_sk_list.lock);
>>  	sk_for_each(sk, &iucv_sk_list.head) {
>> +		if (iucv_sk(sk)->transport != AF_IUCV_TRANS_HIPER)
>> +			continue;
> 
> [Severity: Medium]
> 
> This isn't a bug introduced by this patch, but should the other lookup over
> iucv_sk_list get the same treatment?  iucv_callback_connreq(), which handles
> inbound classic z/VM IUCV connect requests, still matches on name alone:
> 
> net/iucv/af_iucv.c:iucv_callback_connreq() {
> 	sk_for_each(sk, &iucv_sk_list.head)
> 		if (sk->sk_state == IUCV_LISTEN &&
> 		    !memcmp(&iucv_sk(sk)->src_name, src_name, 8)) {
> 			iucv = iucv_sk(sk);
> 			break;
> 		}
> }
> 
> On the configuration the commit message describes (pr_iucv set and a
> HiperSockets device present, so both transports coexist), can a socket bound
> through the HIPER branch of iucv_sock_bind() be picked here?
> 


The finding makes sense.
It is probably best to fix this for good by making the 2 environements mutually
exclusive, like it was intended.

Afaict the TRANS_IUCV can only be used in a z/VM environement.  "pr_iucv != NULL" guards that pretty well.
(To be verified)

So preventing TRANS_HIPER in a z/VM environement would be the fix.
Setting hsuid only in LPARs is one part. But a HS L3 interface could still exist in a z/VM environement, and
receive malformed data. So that needs to be taken care of as well.


My hope would be that such a clear cut between the environements would reduce the number
of scenarios and thus reduce the number of findings.

Thoughts anybody?


> If so, the child it builds looks inconsistent:
> 
> net/iucv/af_iucv.c:iucv_callback_connreq() {
> 	niucv->transport = AF_IUCV_TRANS_IUCV;
> 	...
> 	memcpy(niucv->src_user_id, iucv->src_user_id, 8);
> }
> 
> That is transport AF_IUCV_TRANS_IUCV with src_user_id copied from a HIPER
> parent, i.e. the device hsuid, while the vm_bind path of iucv_sock_bind() and
> iucv_sock_autobind() always set src_user_id to iucv_userid for classic
> sockets.
> 
> After this change the two directions disagree about whether transport is part
> of the demux key.  Was making only the HiperSockets side transport-aware
> intentional?
> 
> [Severity: High]
> 
> This is a pre-existing issue, but since this hunk is the lookup in question:
> should the ingress device and its namespace also be checked here?
> 
> afiucv_hs_rcv() never uses its dev or orig_dev arguments, and the handler is
> registered globally:
> 
> net/iucv/af_iucv.c
> 	static struct packet_type iucv_packet_type = {
> 		.type = cpu_to_be16(ETH_P_AF_IUCV),
> 		.func = afiucv_hs_rcv,
> 	};
> 	...
> 	dev_add_pack(&iucv_packet_type);
> 
> With no .dev and no .af_packet_net, ptype_head() files this in the global
> ptype_base[], and __netif_receive_skb_core() delivers ETH_P_AF_IUCV frames
> from any net_device in any namespace:
> 


Correct. A check is required that only IQD devices in an LPAR with hsuid are
valid receivers. Coordination with the qeth driver should be considered.
[...]



