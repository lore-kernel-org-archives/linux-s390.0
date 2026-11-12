Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477443;
	b=5hvPMXeolQ1bhH09M0y1Otw8bZuL3bfwgY6u5rCNg5mwb9IugLNZ5ncxrqh69BBMck40
	 2MRrkKdQV+8qLtSIGisUL+awBrrGhe09d8RpxQin5NiVTspqnIsPSFywWhz3bItEE80eG
	 V/oWI+0GCM+64h1Yq8CiL4khcQ/R/zccG95RGObtIi8bTUlSa8up/NJ//IkfaMwRBswFo
	 vSFJjNKPXG4+IJIXTZP7gjXIKQ4pC1xGtF408p54c0yM8+01PmTSthfzP24UnaAhWCgo/
	 umJiV9ANCjQ51cVkPQJBbkryFPUx4abARt1f/OXg6a2X1HgWpvc/xO4/CE3yYIbrydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477443;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ycds2+vuVeecukpZKkEj1RvHul1iDk9sjhEdWisBqXM=;
	b=jfoFA8iZFcE2sYNnHFylx8CZ7eBsXI6/7kOHWmg0JQ2Ju4LKC1JiWL0OJ7CwhSf0w5FZ
	 4hxWrkIrZ0oF4g6PnHi+D6YOsQLM1R3QQ+zjbnejIpS7wFfNSFA66oo7RzhWbH1M71yUQ
	 gZUYRO3/8v4mgSBl/NBvGEx9l9wxIVW79R1SJSoXUg3jS1Awq0W1kshCNxy/bz9/Ui0xk
	 JnFjkIHvMNq86tH5lWmFwebz8VUKX9nLQL7U6bNC5flHX26mGl5fblE4otZIfwyzW5vE8
	 m5mTjyIAhJv6MoQZWrAim55dNOXEDAAb0gAg9fUV/Do7enHCrH2vDCUfo9GSxrE6I2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=geX9WeuM;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C880606A327;
	Thu, 12 Nov 2026 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C880606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=geX9WeuM
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2i4tn3053535;
	Thu, 12 Nov 2026 09:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ycds2+
	vuVeecukpZKkEj1RvHul1iDk9sjhEdWisBqXM=; b=geX9WeuMWcmyLmfi9qTCWQ
	GXdNlMoig+JM1uUm+ne1IXzh9EtUFRf/EkwBC8i1h/96aijcd43KIO2HYSYtYrMT
	YHg9BigglMVb4JLsTnOMnimikOAIuHfQAMp4n/YF3ohOZupcPLxsrgyAWqZjkejC
	6yMrO2VdwAGXR3WQeD7LpU1bdUYm/6RVO0Fe5JZtw4oPAoezkdG8mv5coJCnLvzy
	HbD8yORVRBoyv5n5LDROUq9ESxpj7uLd44r3Zm/pUY6+ZfFq+z9BJRwQ6hFRU2QX
	ZXQzxassLf8iw6ePaxbrgx6LFGYqn4LxWpleyGSikNHJB9k/3kCa7a5J2SHG68UA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6ev87-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 09:56:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC88jRW3145596;
	Thu, 12 Nov 2026 09:56:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51wxqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 09:56:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC9ucxS52036052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 09:56:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F34412004B;
	Thu, 12 Nov 2026 09:56:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBAA620043;
	Thu, 12 Nov 2026 09:56:36 +0000 (GMT)
Received: from [9.111.4.227] (unknown [9.111.4.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 09:56:36 +0000 (GMT)
Message-ID: <91823f62-57fe-44ad-9dab-ba91ba3d26d3@linux.ibm.com>
Date: Thu, 12 Nov 2026 10:56:36 +0100
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
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi
 <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com> <avTSC2r61uht9oFK@yury>
 <ef8dcbd9-61e9-467a-88da-3d159a5df9df@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <ef8dcbd9-61e9-467a-88da-3d159a5df9df@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Grk7OAPM9lezy57svraLsYt8P7yEZPh5
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af58d5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=swU2ZibCdQ0ba2sdvOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ERKEVtWXCKvlZPEGzNvGFeK9TNk9wyT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXxMV2Wht4hmPe
 ATcJgeQPIjUEr5HuxvL4Ln9qinQG1FbV/i0c0TW2lZk61lABarnA5lr5pAu/QDN1RnE60fd75c9
 WovOlHBxN9TslF6FukMWh495bB8f9za0wgnZ/0fc/okmO8Z4xEsW0guOUwk33uSzk1oeIlN0ZkP
 hq4gENODboK49Q6r0//GH1y1PEYpxq877+NMsw1dBc6WqbkDlMyVGRbT9H31lii0JXbkJmvNj1T
 0bCCYSvh3TDxPvHbJEuNfWmPKGEuUkEVOZJbyUZRA8YenpuCgy1as/rx1KKkup4j+EflgtZfUOg
 xcnx3vFJ3+93M/WG4FP1ZL+7orCl253LfZMQjKTrd7gTJMqizw3UrhxxsptB5dp5X1X5XT2zhKJ
 LAJGv4g3OyucFYWJ1Pryro1Ns456nsIOahVPJkU3at9iNiWZdBFwTdNDjm04JUBupVbJ8Pe3AYw
 mNXCAGT5dpYYuuCEojA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfXwyQ7QVWz6uQR
 b79qlJeBwWTAcP4zO76K/UFjY0jTKe0AE0yylU3KB42XWkE0vbhx9+D3unLYHvztUqEiKItgFXc
 p+gbirrononB6sfJrYWVQSX8i3A5DUk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120038

Hi Shrikanth,

>>> I've been trying to do this with crutches in user-space for a long 
>>> time.  Thanks for implementing this in the kernel, and with a 
>>> convenient user interface.
>>>

>>>> A user can mark a CPU non-preferred and pin a workload to it. Fair 
>>>> tasks
>>>> whose affinity includes preferred CPUs are steered away, while tasks
>>>> whose allowed CPUs contain no preferred CPU can still run there. The 
>>>> CPU
>>>> stays online, task affinity is preserved, and the selection can be
>>>> reversed without rebooting:
>>>>
>>>>     # rmmod steal_governor
>>>>     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>>>>     # taskset -c 3 ./my_workload
>>>>     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
>>>
>>> My use-case (being a compiler optimization engineer) is to pin 
>>> benchmarks to specific cores, and stop the system from using those 
>>> cores even when the cores are idle.  This prevents L1/L2 cache 
>>> pollution and makes performance numbers more stable.
>>
>> Hi Maxim,
>>
>> Thank you for the feedback.
>>
>> I agree, this trick with pinning a workload to an non-preferred CPU
>> looks promising for benchmarking purposes, and probably for more.
>>
> 
> Sorry, i don't follow.
> 
> Did you mean pin to preferred CPUs? Why would anyone want to run their
> workload only on non-preferred CPUs? By definition, they are not meant to
> be used as much as possible. and It is benchmarking.

I think they want to prevent anything else *besides* their workload
from running on these CPUs by marking them non-preferred and then
pinning their workload there.
Sort of like like dynamically configurable isolated CPUs.

IMO this fits 1-1 with what Yury is describing with this patchset.

Thanks,
-Mete
