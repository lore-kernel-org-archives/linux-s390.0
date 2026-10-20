Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487664;
	b=dzkvJklk9EW0FwgKXEtq6cV0LEeqBT21ftvf6iGqsb+u/3CHP7urdd72uwwSmyuR2Bss
	 807+HHRahL6pjFVJe5Ghn9d+UuS5TKUDJobXJqC/G4fQ+3R0KTDydm8avmehMnwq0LEJe
	 Zy6jwwVQ0ig7gyYp7GbVxL5WElmWHKv/gEjTE/uFXuPu3pm1258PL1s2PqZMCKSR8RPu7
	 lha/x9rvTzC3ve/uTqs9TOAoqY4B/SIc9jbYIHxZKXQgBanTK4BNRG5Jn715VuxGK3m7T
	 rLVuP7ljtFzEhC+LnuUrfLc3U2fE7lsCKoyDPNmyiOol6Vdr8F1ugnZAONfKFwkpLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wsw+cMVNcuXb/+EKvkTcobn9fmysfOHYp5okORl6mzA=;
	b=sLa3TZMG1sYg2gV+tj2XZ1BeTEStoirfwT8AmMb62XnZ45J0QF1uVnq7e/mKQueh18H1
	 xeh9iknOYjUt/smDhbgsjrOU5LgdmeE0gZGh1QnNjDH+PY81Lmr9TRFyAhBlppjYYgE8k
	 CwGOtPpIFlGL2ez94tZ8OlD453HJsx0wfCJJyRCrhbpyMkdJUv2HYMTu4S3Oj4Iy75JRL
	 1s6OR/RVwjujSps8QMQJ2bFXtlmAyctcy0ISbyQSxqEVhd/fj0Y7w/h7VIup67iNByEyQ
	 ISHgLmoVJ/xHYq974ElWhI+ZGu79q8x2F6DghtG8PW9JihNNNdD6Go0SXtXJCDsS1wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXiiGIau;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5335606A31E;
	Tue, 20 Oct 2026 09:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5335606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qXiiGIau
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K1EE773640920;
	Tue, 20 Oct 2026 09:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wsw+cM
	VNcuXb/+EKvkTcobn9fmysfOHYp5okORl6mzA=; b=qXiiGIauaSLjfpHvr0WBkW
	3YxgA4S1njXVZ7USUMCbbStzZ/zN5NrR09+zRfBvA3TIxh3jmx3FFOxwZiGWFaM9
	ulHuUl/MgXxIhhel1IXfimPpFiTMrCsz45kEqfQkZJbY75LlgD8Xn5cgCBBCg1dX
	xb5QqNuCaoI89qnr2Gw1zteV425E65z+RVqQemV0BicjTJ+lRHgwW2CjYzKdqRdK
	trkjgFNzguz06qZWbSN3Rq5FiXb6pxssPtLqFvH1c1M1zMYYQXynKJrmPEadshkm
	PlGXmOaRc6vq8Mx5s64XTfRDqg2w9mu2BaTX25OckoKNMHoo3OmJroEmft9U87Jg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b9ywm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 09:13:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69K6roq3749071;
	Tue, 20 Oct 2026 09:13:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvhhce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 09:13:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69K9DJOl34210244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 09:13:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18BB020043;
	Tue, 20 Oct 2026 09:13:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5AC2004B;
	Tue, 20 Oct 2026 09:13:18 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 09:13:18 +0000 (GMT)
Message-ID: <e560fc10-f0f4-4cfe-b86d-4df4e2ba3120@linux.ibm.com>
Date: Tue, 20 Oct 2026 11:13:18 +0200
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
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi
 <arighi@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
 <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
 <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
 <ce85388c-3ea0-4363-8c89-fe2bf71b284a@linux.ibm.com>
 <CAKfTPtC70sx58uiaMEXv=vOk+o-Q_1PcHewiVjGCWMd_kvn=tA@mail.gmail.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAKfTPtC70sx58uiaMEXv=vOk+o-Q_1PcHewiVjGCWMd_kvn=tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bXIR07yBw0I1S-fqNglbU_RljOgyci3y
X-Proofpoint-ORIG-GUID: e4D7YGIDG8rOS7o_L2PMplWT1iy1UGDf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzNCBTYWx0ZWRfXxw/W0T2hZrFZ
 xLXrVUrjKyOK0z1gN9K/Ka0BHShWcBmhg5ctYRHuobFDU6kv+vsadasWY6uPbXRIt0soYeEvaJ+
 dxlhCAXj6EjSSiCIz4jl4id0J+RLmAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzNCBTYWx0ZWRfXwBAlxeG7b8sW
 F/z8EcAVeAfSJ7ZDZoMRgtXOyFvNdQNk3u4VC64vMBAW7zaxy0pX1HAOajNsaSNE0BRj7xwWJDv
 v+LhyzugXg+SOMkB5LQWEuVRqNLG9WH2mwqE/MI3YdPh85G2JMAx9Vg8w+RW5bx7Vemz73uQZq4
 F3tVLQKcLJqnFZhy7Gm9XoiYwpCoAALE8lDv16gI7cETrSx9n/RwCOoxr41fpp8pWXPea19tc5a
 ac3YvfJfguYySRnTvkbHDQ3As/ICEhQMud+sXkByk2q751OxclfDIYjM9QvTGz+FJy27mbXkX6J
 6tp1yccyD+Os0KQVdWrVUumITFRE9VPZk0530DdT7wDQJUa6KdPZKJEeDZ4Zu9+T76GrJKIyYMD
 S80DL+FR+prrg0Zbokcz8AVzUZUVaXRg/1vmDQSrRwwFtB/gHwRdoaPfakxr16Dsm4pUAcpuSWO
 /gjq9G9YdyEt7bt7zbw==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ad730b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8Vysr41LJf8a2GMkEQ8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200034

Hi again,

>>> What you describe really fit into the prefered core that Shrikanth
>>> Hegde has developped
>>
>> I agree, but Shrikanth's solution can not bring some of the
>> behavior changes required. cpu_preferred_mask can help
>> direct task placement away from low capacity cores but idle
>> core first approach still places tasks to fully idle low
>> capacity cores. This patches proposal tries to move tasks
>> first to the idle SMT siblings.
> 
> We have compute capacity to decide which CPU is better than others.
> The capacity of SMT CPU has also been somewhat random, but we should
> find a way to fix this instead of adding a threshold to decide whether
> to pack or spread tasks onto idle cores. With correct per CPU
> capacity, we can easily decide if an idle low core is better or not
> than the sibling of an already busy high core.
> 
After thinking about this a bit more, I have decided to work
on a different approach rather than trying to integrate
into Shrikanth's vCPU backoff or trying to expand this series.

I'll come back with another series after I become more familiar
with how the SMT capacities are calculated and incorporated in
the decision making process. My gut says the real challenge is
going to be finding a way to benefit all architectures that
configure asymmetric capacities but I'll give it a shot.

Thanks for the valuable comments and guidance.
-Mete
