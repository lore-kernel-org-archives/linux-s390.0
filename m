Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3D3FADFA;
	Mon, 18 May 2026 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105737; cv=none; b=UBOCqGEOL8i/K6PweAWSKqfOpDDxOKHQLsxCzfnpFWL4UKHj/GQcg7cac4bL7dhMa15/niZU8IOGJQUmiPmB7wQNvm7EWaEBI8BybXpW9ov3tKrlCIKysv6uDLFBCUbdeTzj5Cf5ECMdoN6nER+ii+8RDFzsNqmUsnflQb/M+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105737; c=relaxed/simple;
	bh=+ditw1cbWYXH7v+hikKyKtYDYrFedcNYjhaALpyk80g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEktVduYsrfY12WLB/i5MJzndRt59MMNdID0yGGfvCQQ9sL3QUBUE+crKhxv2zddRa1jYElbOg4z2JDV9CFby9OCBEorc6bsx4cuPb0uwpXa76Rxs0PWuMKRlximGqPlt3u4xvHDhXEOBce5dSNDb6GLwrP3p3LozRTzgukNKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hDQCLY98; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hDQCLY98"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6pVl53913287;
	Mon, 18 May 2026 12:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=soMsls
	37LehcwMPbuz9TaCha5/23ZDZWjR1vmrne7qg=; b=hDQCLY98DygvWA78sEhnlx
	MIsMoOejhXt5J8xrMc4Rvy70DoSwbuEvE4xmar00BKhdYYGGGv+keas8gYthz+CO
	usr5bsAEl94wsqmeGtmQVysabRF+VW8FAHvWFaqToXi49uNCsu2aHM7awED57TiM
	r+0FkTbQrhV4EUW0JECBUAQEaIPKf6+VpoU5pa4j8a08l3PEcmV7MhEfNkaNzjeX
	NG7yLXOe59NQ2PD2L2WKJ/k8EB9hv12X0J9qOJs+NrDJMpP2r4nb9B/1xIY4BMqv
	28jyxIFveXgpHHv7h1n5V/poKfIBNb9pozY2CAyNRiaiCEqoCII3B8cJPdD8nmZg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xqvwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:00:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBsA6i005957;
	Mon, 18 May 2026 12:00:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpwwmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 12:00:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IC02QM52363580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 12:00:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29B3520075;
	Mon, 18 May 2026 12:00:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB6720065;
	Mon, 18 May 2026 12:00:01 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 12:00:01 +0000 (GMT)
Message-ID: <732d4698-8b36-4803-9c81-ae9865b3f943@linux.ibm.com>
Date: Mon, 18 May 2026 14:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
To: Stanislav Fomichev <sdf.kernel@gmail.com>,
        Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Magnus Karlsson
 <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        James Chapman <jchapman@katalix.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        David Heidelberg
 <david+nfc@ixit.cz>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
        linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
        kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
 <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMiBTYWx0ZWRfX3xunao6xX+5I
 s6wQoFowRAUi5CnuOdhi4McLg8i2KlSPcqO1ELPSqQgNpPFc8PL8kcysA9y2F/kozRyiNSNx2Sl
 E6xH9abIKEnkIqUFLq2wUMhw07xzz/MqU9gkrv885jalQejkibSBJmYNtpxP2Uz9C21/0n0UR8h
 O8Ua7duVPKh7rLv6JAt9vi/2bTqkXUhmbmJLzpIzw2wkNctKNOY4mIf7Z+L5R5+pe3xq0Bfk7Ti
 qr4qUHXPs68WFi6NPqiiNSU634IQZArcMnh7noc26Iej4pjbieIgb2YQ8NHfd219NZ+10VxnbUf
 k6cjhVO51c8ouZ2RS6/q0w5I47Pf/n1kP4STK0opkSXpdXIbDlZjEykeqGju3VyatzPL720I/G+
 IB0dBm8na5z1LtC3QKiRvzVQJ4Gyj92xl4lYH9hFY6CAwqIH7X2EzXGYFqRAZBJ0p9Qixz4YH5y
 +zAfeeTWJ0aF/rMF3ZA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0aff45 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xNf9USuDAAAA:8
 a=OxTNfTo8x2dPQPtXHAQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P2k76_u3HpaQjsmgodUOFxpuNHH4zJHj
X-Proofpoint-GUID: _tEQJNW7Ox_Sa-u3uOE70Qe3g9quvE2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180112



On 15.05.26 22:45, Stanislav Fomichev wrote:
> On 05/15, Breno Leitao wrote:
>> Mirror the locking used by the SO_MSGLIMIT case directly above: take
>> lock_sock() before reading iucv->hs_dev and dereferencing hs_dev->mtu,
>> and release it afterwards. This keeps the two adjacent getsockopt arms
>> consistent and matches the lock held by iucv_sock_close() when it
>> clears hs_dev.
>>
>> This is not an exploitable bug. iucv_sock_close() is the only writer
>> of iucv->hs_dev and only runs from the protocol release callback,
>> which the socket layer invokes after the last file reference drops.
>> The getsockopt() syscall holds an fd reference for its entire
>> duration via fdget()/fdput(), so iucv_sock_close() cannot run
>> concurrently with the SO_MSGSIZE read on the same socket. There is
>> no other writer of hs_dev, and the aligned pointer load cannot tear
>> on any architecture Linux supports, so the existing code cannot
>> observe a NULL dereference or use-after-free in practice.
>>


Actually iucv_sock_bind() and afiucv_hs_callback_syn() also write hs_dev,
but iucv_sock_close() is the only instance that clears it to NULL.
Maybe there is another wording than 'writer'?


>> The change is purely defensive: making the locking pattern uniform
>> across the function avoids surprising the next reader and removes a
>> foot-gun should the close path ever grow a new caller that does not
>> hold the fd reference.
>>


Thank you for this in-depth analysis and clear explanation.
I agree it makes the code more consistent; there should have
been at least a comment, why locking is not necessary here.


>> Note: For the reason above, it doesn't contain a "Fixes" tag, and is
>> aiming at net-next instead of net.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  net/iucv/af_iucv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
>> index 72dfccd4e3d58..3dd11d7a967c8 100644
>> --- a/net/iucv/af_iucv.c
>> +++ b/net/iucv/af_iucv.c
>> @@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
>>  	case SO_MSGSIZE:
>>  		if (sk->sk_state == IUCV_OPEN)
>>  			return -EBADFD;
>> +		lock_sock(sk);
>>  		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
>>  				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
>>  				0x7fffffff;
>> +		release_sock(sk);
>>  		break;
>>  	default:
>>  		return -ENOPROTOOPT;
>>
> 
> SO_IPRMDATA_MSG also seems to be only reading the value set via setsockopt,
> so maybe it's ok to just cover the whole switch with lock/unlock? (will
> mirror what setsockopt does)
> 

I like that idea.


Feel free to split this improvement out from your series, if that is more convenient for you.


