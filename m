Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302210;
	b=x4gT5f3Rb+c/QK3ZmcQkh1tSqg/9zVbtKSJI7997IhmOhnojQ+43BrQP7rGnjVRs8VIt
	 MXetltbYV0yK/IvsexPr0E+0pBqtDdFYswlc9duuGUFJP23p4JG1VD6NE6ANu5GfbE2um
	 UmDfVhCCCBBjXlnf5gmCaJrC0LHiR72Slbv49JF9qfOXVnH0jLE6Fv7e2HBwVTjuYHJZW
	 Aetin8XgY2QqV9yGMFkAPvzqZL5P31OpbyEZBOH+7D4EeaDgp5CuU0YLKNeWqn9bakw15
	 BPWbX35UwklQzH8Wl6xrhqZTHhDDQtEOQ4zmcx2j3sE/3+jILYydQhiErHmrUbm0QXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302210;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HcBmS5+Nw/jsTb/Wra7B8fpVNEeGNPFeCKK7weXJ2c0=;
	b=i7MKWEwWSQJXJ7EEFKLwGz+xqwqtEEJzvyyHcTNMWRXvIrbsjdW1+QsadrrhNCLCInZj
	 OcK6aL6Tk3lHzm/EOJt46VJng2qkQQXdx2oshaAAM1fnWTawrt3dmhtiS0Z7ygyeKuYEn
	 aZBHNdWynbnyynFsHUUIXnqqvaZXwyG0ny5wckJx1wI2ev1fuzfoU/HgNrGHu+TW3Wy7E
	 LMY1d+NBtjOPj+t2Ah4q2s0WEmuyVrkJHvYqVa8niukAdJtW99nxx58rOfkPOYC5YB8p6
	 qSJRziW253HWSMzdYxuoK69JNmVqdS9YHmBcLArQJV8EQP4hFRuHB4SHZZ7MwK87wbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Euvb0XBs;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D160A3829;
	Tue, 10 Nov 2026 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125D160A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Euvb0XBs
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8EQfQ1812456;
	Tue, 10 Nov 2026 09:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HcBmS5
	+Nw/jsTb/Wra7B8fpVNEeGNPFeCKK7weXJ2c0=; b=Euvb0XBsl3EzzvP1u1sip/
	x3IUuRd/ucv8cad57wR0FpCnl6ItPfW4TGhQ7cRRO53dxl1uVqTyo5mQwl9+i4Ba
	EsUnWqmLLMz3fJ25pv5PMz0mGIYNtzazLArSzKbBkGEClRO1VFQ3pcV6Op7pvTRJ
	XAXVFG60+9EVDgZ3bvl2daydJvuDCXCHfc7HlmaWlfVT24yFR3/a9td/nRXKzjs8
	05703+ov/L4aF6mcaD01Gg6i7JJD53pLfbaqNGRayraJqFpHru4FRmCRDQsiyImm
	X3AtdP4jzebIk2pq+OHQqzp1q4RlqjAYQisVA94wdNzCJQxHdsn2T5NT8O/U+i3g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6v2hc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:16:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA851do1498149;
	Tue, 10 Nov 2026 09:16:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvx2cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:16:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA9G6ss56164728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 09:16:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8768D20043;
	Tue, 10 Nov 2026 09:16:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C22E20040;
	Tue, 10 Nov 2026 09:15:59 +0000 (GMT)
Received: from [9.39.31.79] (unknown [9.39.31.79])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 09:15:59 +0000 (GMT)
Message-ID: <1d1b22ce-fdf1-47ad-99ec-8c9925ea7275@linux.ibm.com>
Date: Tue, 10 Nov 2026 14:45:58 +0530
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
To: Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>
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
        Mete Durlu <meted@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org, Yury Norov <ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX5pCaNYyeS0GK
 /qoKN2A6JamDgryJ+BemvZnw4QGpf+1XjEjgUG26sziaCDm4OHmG0ASXzl4FJdoOB+vr8TLa+Dy
 dwoirZ0OEIYOZAC4O2tEq+j8pC7vmuA=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af2e0dc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Ikd4Dj_1AAAA:8
 a=S2HyHEYmQh1kXY00aCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V0Qpv5g5dMd40m2X4caVWzhKaZKP2Zbn
X-Proofpoint-GUID: R0Mklm7znZwmumFMQXCwYU792AB9pLQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX0P2aS5Fa+IjE
 mHvDmDdBXSkhujTEso78l7iZZnVhWCSaLmH1Ds1/nVG3OGRd/1ItjrGH9YblNZ2usmsDUKhMbr6
 ETpmBzrql1By6360fUq2AKCeiK1VWwur8GbZ2tgegDqcNKFpF7+LkUKjCmPNocXZ/p8G9YnS8Iq
 8Z/uRmeVSEwiLM/eO+a1OVE6z+UcwoAq2jdrvL7iGuzuhkRu2n+s5lWdfzKhGSntm+4MwU0ZiOp
 Hlae7G3URIEak5gaQvA6CtZGdfWkfL+M4EfZE1I5yOf6d2bovikSW0xX21nN8b8x1qenDf4Etof
 slwHP2ByJHiTcptVrjFg4Fe9EcNld/VgjHkyITUpqZOUCHLLw7nRKMsZbhjTBQsH9XLKFuV6Npo
 8Qtb2ldPGC2sazaM0hR+IYAEDisGI0WyokszlznYVpGj2sp43amYRM3Jw6cyxcTjXSGWKHhPWVU
 GxDfYJOEu23bI9c4IYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100036

Hi,

On 11/10/26 8:45 AM, Maxim Kuvyrkov wrote:
>> On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
>>
>> The preferred CPU mask currently lets the steal governor reduce vCPU
>> demand when physical CPUs are contended. This series adds manual control,
>> opening more use cases.
>>
>> For example, setting CPUs aside for selected fair tasks at runtime while
>> steering other fair tasks toward the remaining CPUs.
> 
> Hi Yury,
> 
> I've been trying to do this with crutches in user-space for a long time.  Thanks for implementing this in the kernel, and with a convenient user interface.
> 
>>
>> A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
>> whose affinity includes preferred CPUs are steered away, while tasks
>> whose allowed CPUs contain no preferred CPU can still run there. The CPU
>> stays online, task affinity is preserved, and the selection can be
>> reversed without rebooting:
>>
>>     # rmmod steal_governor
>>     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>>     # taskset -c 3 ./my_workload
>>     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
> 
> My use-case (being a compiler optimization engineer) is to pin benchmarks to specific cores, and stop the system from using those cores even when the cores are idle.  This prevents L1/L2 cache pollution and makes performance numbers more stable.
> 

Do you change it when running workload based on any signal/event? or you set it before starting it?

If it is set before starting, you might as well offline the CPUs to achieve the same. I assume you are
managing the preferred CPUs manually with write interface. You can do the same for online state.
(Though it takes a longer)

> Thanks!
> 
> --
> Maxim Kuvyrkov
> Garden City Compilers
> 

