Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808896;
	b=oBPTmLwbdvQmR7A2eK+HcYWT4XwPjh6w9a05bBy8AEjYzrn+VdYzyXDwXsbEklXv3SMr
	 O+Bh/r1ndwUOUuFMMykuaY5ujL3BWmvHJl/mxI5skjpVKmMb2gIOwrTfM9+Fz9dFm+b8E
	 AZQk6fer1n9KOsODW7RAWVfM5HlmFRJQnltPD96IMolb3cKykWWTWDztmN4SuLXZkI33z
	 lYtn4sISb1dXU6KNaQsjxty50LV21gE0StOBnVnn4hSohgVJ4dS8v+u6Je/nhiPElPV+z
	 myG33T54YdJiVJ52CBmt+eSn2L+pF/aX20oMlQciyzIF1RKAfGZHC1WcQhm/mJoExBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R6KJM2GfJyrMMrkottRzcbbvzHNZxrDYP8okpIqoI28=;
	b=jdqzBJPRzFnAIg+OuIlx7FeVIqThRXmkaFNGJqO+9PwF+rezQUyS4n5MiGl3dY0jYjCY
	 eGqaiIHGcaWtsGY8eqeW8aWfZyFkHE1xTpebQNDeXOJsuCjkxiLCkiYr5oER16LcPoHuG
	 ibImz+vP9kj55RPNKFz+wg3nOZIk/VPkXXxGSxkTEACcrtWi3YAE/XBzjK8xUmdCjxNBt
	 iNpVJHJ9ZZhMdpxizc8JzOdZJagJ+9qxch9YmpXUgAxXg1kHsNqo1iCFMsZLFIxIIW5YD
	 bUQPgcR3RugR/U4Yqt0+L2uAt/zKdap2rn/fyqCSvhAWmmsxVxcVKwYQTSeU3UMRKsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HyrO65IS;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C8606A326;
	Wed,  4 Nov 2026 16:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 625C8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HyrO65IS
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FiAwr899006;
	Wed, 4 Nov 2026 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R6KJM2
	GfJyrMMrkottRzcbbvzHNZxrDYP8okpIqoI28=; b=HyrO65ISP9j1iuwknCLRh4
	nceJom/4oo8+MTk9TQQ3KWR0Mqfv4gbFe3jWxyqJLQ5SJFLDVze0R6itWQEthFNV
	bnZowbQ1yp+6oVU73QnmVfHkEsC8otttnz1+xUsnTgqmvqqopSBTTfkJyl5x/dP1
	5moCs4gexVZtev9G+/xb/RsxwA3VvfmNgonGABljxxOQ5RbJUzXa5t2v4cGN9+9V
	9gREMvXYP1EjLza/OPk5jNhTj89En2GGDY2m9pv84c+ZFdGLZw0k6y85iT2oZB/5
	BYhfIWRnbw99PM4SqGhVlBp/DKQfB+BX7lQoElLi//yJKR0ZMMe+PAHJiyro3+DA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhvrxr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:14:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FntbE232228;
	Wed, 4 Nov 2026 16:14:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5h0g9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 16:14:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A4GEeft46989748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 16:14:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4BAE2004D;
	Wed,  4 Nov 2026 16:14:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E0B32004B;
	Wed,  4 Nov 2026 16:14:40 +0000 (GMT)
Received: from [9.68.29.38] (unknown [9.68.29.38])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Nov 2026 16:14:40 +0000 (GMT)
Message-ID: <307b169a-6ac8-4ae3-aded-b40a86608d01@linux.ibm.com>
Date: Wed, 4 Nov 2026 17:14:40 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/iucv: clear hs_dev before dropping its
 reference
To: hexlabsecurity@proton.me, Thorsten Winkler <twinkler@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Hidayath Khan <hidayath@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
References: <20261028-b4-disp-dd3e4ebb-v2-0-3747658d59bd@proton.me>
 <20261028-b4-disp-dd3e4ebb-v2-1-3747658d59bd@proton.me>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20261028-b4-disp-dd3e4ebb-v2-1-3747658d59bd@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zTWu1t3rqYi1_KhLqc9qZx1GyO8A7ZMy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX7bVXr6nJp+oE
 hsCowFVf1SwwVIXl5ClINkIUBRQB/ZZF/hVyx4faRZPTASlNu+yQhYMB9Ye4pYeb81HVXYi2A15
 uvATIkvOQKxqbYDbxY8r4XDvDikXfs8=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aeb59f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EuISxwL7kJT2UulSNDkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NCBTYWx0ZWRfX1M/S3xwzPChJ
 AJWmoOsauEqNIFedEvjqDN/nKKx4PaW/UJ7huVunjivxGFYirnrbP2Rl2iEro14i3Dtreix0SJv
 RfDqTkbDEGlcDXQRmOpXP30h7gBa+f6kTt8O3Az4h4JXlbTJkrjuJy+M6/O8k+Ym4Ed54yfj7LM
 4QF2L/1dBe8WRqO7zNhBTxD63MEm7IbgxdNgSp9+aHGh+3P5VRRnEj/Ybdu9/QJxynnVa8rGkX9
 cINA6//G+wcJj71fS+0QnqoHX/F/ADV0Ad2T33JZ18w5hIPa/cDwmuWrEVp9PcLFh3iwZRPGnZo
 smyKE6LAnym7z7rN2tmeLoNDNSYf91mnK7f8UH+Fvk4rJf2GPaWG1I1b6SdrWfS0YElnXfYf7wF
 eKrVM5vOffBP55cyS7SPtkGY9Hda7ZL95lhfm1hTJUvbKbQ7LWcR8itG980lKFrRTP1LGDV+2ZJ
 D9lqNQ7kRItZQ6JO3IA==
X-Proofpoint-GUID: zTWu1t3rqYi1_KhLqc9qZx1GyO8A7ZMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040064



On 29.10.26 05:46, Bryam Vargas via B4 Relay wrote:
> iucv_sock_close() drops the socket's reference on its HiperSockets
> device and only then clears iucv->hs_dev,

I agree on the analysis that this order is wrong.

 while afiucv_hs_rcv() compares
> that field against the ingress device for every socket in the list,
> under iucv_sk_list.lock and not the socket lock. Between the two it
> compares a pointer the socket no longer holds; KCSAN reports the plain
> read against the plain write. 

Could you add an excerpt of the KCSAN report to the commit message?


The order dates from 800c5eb7b5eb, the
> compare from 80230a18c164. No user-visible effect is known: the receive
> path holds the ingress device, so the stale pointer is compared, never
> dereferenced.
> 

I agree, I cannot see how reading a stale pointer can result in a real
problem. So this is not urgent to fix.



> Clear the pointer first, through a local, then drop the reference, and
> mark the lookup's read and the two stores that race with it: the clear
> in close() and the child's store in afiucv_hs_callback_syn() (the child
> is in iucv_sk_list from iucv_sock_alloc() on). The child now takes its
> device and sk_bound_dev_if from the frame the lookup matched, held
> before it is published, instead of reading the listener's fields:
> close() clears them under lock_sock(), which the bh_lock_sock() in
> afiucv_hs_callback_syn() does not exclude, so the callback can pass its
> IUCV_LISTEN check and then read a field close() has cleared. That a SYN
> can be accepted while the listener closes is left to the socket-locking
> rework; this is its KCSAN-visible part. bind()'s hs_dev store runs
> under the list's write lock and stays plain. sk_bound_dev_if, which
> getsockopt() reads without the lock, is marked where close(), bind()
> and the child store it; annotation only.
> 
[...]
> ---
> Nagamani PV's "net/iucv: fix races in afiucv_netdev_event()" [1] marks
> the same store in close(); Alexandra Winter asked him to hold it for the
> locking series and he agreed [2]. This one goes out now, on a new and
> independent KCSAN report, and its close() hunk subsumes his, which marks
> the store but keeps dev_put() first; once this is applied, the
> afiucv_netdev_event() read is what remains for his patch.


Just thinking out loud:
Would it be a simpler alternative to clear iucv->hs_dev  in
iucv_sock_kill after iucv_sock_unlink? then it also would help for the
afiucv_netdev_event() issue (read still needs to be put under lock).

It's hard to discuss this with an AI, while the locking series is still
missing. I would still prefer to fix that first.





