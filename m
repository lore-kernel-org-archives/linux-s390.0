Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163994;
	b=R9Avsudr9i3RUrCG0CZw+4gSvwk6imq9qku92SxdV42G1sbrPFCQ4/3rx4hai/+33Hwn
	 /qyAwd8rxCHTdcC69ptLeXO/36PvxEqQDSn+S2dgw//2eSPfP3Fbdpv9x7EdIXR62poKz
	 0+ux/c3+HxAtejsZsDW4qYGgM/oB59WC0Q7LMXzDWpT943mNa+Ma2NPPM7Gyu2jnPO/Mu
	 n7SUzP+ETIaV/uqbipC4xB3r80Zq7jL4ODM15F7Ef7LdyRdhg1Vpu7otFFrYh4r9NPOfR
	 DT9bMzIUkrPUEEiyjSCi38aMYuqw1LADaAOdXUY+EEo2PxG0tq1pNlkQPRKlGhZp2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163994;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vDyPOJ67XjYt3wWQDVUZSaQFeg0AX+VGsQspzrlVypg=;
	b=bJjyNTUdLhrxJRkzFSPip7fTUk0mHbCX+neGmI+jHOFSfwoMtMGLRCsQCnCc1pFHWqqo
	 xrcsxxp+keomMmMUYJrS+y+V7UjGIyMoClqXcIwzCeHcWdPVQb0Xl9w08wpOpWo8WFnUi
	 9L9mZiwQGus8r5+D4AfxkotoN6NddfKFPKmBvIqaMJg4hD4R19a1RtQ3k/o8Cc0zy8jkb
	 wBfIrbHG4E9PHwJshVy/CsvtXQSySaDBrYyKohmgFaIQ35SHf+8TqIfGNt8hP3U1zvZbW
	 lEEOd/oeihYO77zToxF3rNQnMbhanSNRvB33Po2a+OXt+w54t3/BR+Q/JPdck8a/tMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I669TyEn;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CE606A325;
	Fri, 20 Nov 2026 08:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 964CE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I669TyEn
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7uRLM2482076;
	Fri, 20 Nov 2026 08:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vDyPOJ
	67XjYt3wWQDVUZSaQFeg0AX+VGsQspzrlVypg=; b=I669TyEnErtCRamkxzxq+P
	gPf6A3FuIajOJ1dDv0d546ZwBSj0jQ3uJ3seyQ6cZO2idIN5EBdg8ItEDEl3bn4i
	s0KtrbtWdDEhP9zDqmWlsXwFR5Iwag/FLpjJSOhVHDJIcJhUPE+hoDpyVXD0g29x
	RCBbaj23lLZi91/xgqm3bJsq4NKkRtllNnhQU6gsufl+am3ttshtPHLOiOv10enE
	Jgt+i1VZhhYXpAI1aEpsobuUrSmP2IQDV+MEBPvOTN2V84P5FEdhtIFBg0thSbqs
	hLLjiHGKComVVQfgsr35UIVkT7lAps6w5P+r1V3uGWRdbUe4i0HCnuSOYwNVSMhg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x6ucf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:39:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o2hf821287;
	Fri, 20 Nov 2026 08:39:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c53tp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:39:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK8d7TK54001998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 08:39:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A98D820040;
	Fri, 20 Nov 2026 08:39:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA0020043;
	Fri, 20 Nov 2026 08:39:00 +0000 (GMT)
Received: from [9.124.219.128] (unknown [9.124.219.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 08:39:00 +0000 (GMT)
Message-ID: <38f8999a-f3e1-486f-870b-25710462308e@linux.ibm.com>
Date: Fri, 20 Nov 2026 14:08:59 +0530
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
Subject: Re: [PATCH 4/7] virt: steal_governor: serialize sampling against CPU
 hotplug
To: Yury Norov <ynorov@nvidia.com>
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
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
        Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
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
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-5-ynorov@nvidia.com>
 <1556d3b0-1c89-4d3d-b9e5-5921c5c9158b@linux.ibm.com> <av8oy9v9eLTL0dw8@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <av8oy9v9eLTL0dw8@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HnFjsIqIwCBqsOr4Q9IJZy_rWJ3MVT8X
X-Proofpoint-GUID: EU1aD9gF691CJx3Y3rvSU-lxEX-zsZmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX4efz25aqZi5n
 KJ2Z0MmKbBJ3Gp78pWeQdHzc7odjIdnz30YHPdG/v1Y/C8O5fspytaA4ZDRYsmc1DNqFypj+VSE
 Bd+xDjl7ClMVNju47EvIVyGD8tM867K1K95qt4hx5tHFjO+uNN3gigcSqflB8OaEdXbYD8jRYL/
 dQjp0D/uTBPbbSxQuZIyrf3ospzDBOtMiMKqhen/yaCfkBE7eWKgG+kXzFcusiTAXxHxMQxFGJ+
 2JUhrIvGGxoQgoK8yILvlrr9SeicEHhEKrCpGQwtCN5iQ+0ShHeWmzAsOZZU+0pYrAd0x6uRYmg
 XRDOc+IW6ZPdWLJae6SkKBncdnhAMNijjd4AiwQ2FY98TLigqLDNK9WKUubV/a6G27kY15PhFgD
 C1syVM8JnXI5A5IDm7swrRbjd4wQGpf9gD1de8hf7yZp0ReToc5tj8n4BIfdm9rOXBcSutLa5Ic
 pvSZ8xvFN6/zDRKy4Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX2XbEVjvM4F4a
 rodQfY0nMEh9JSgaLa4gr1pr3PrJJEKE0mjmria5NXpB/pMxuoq22alKfBijC2mEJjCq2y7iTbt
 gOT+mwwzWVLKD9Smyai7dhNsxhuKYwc=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b000731 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8
 a=VIC0OLWXFpzVDZgiAzwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200033



On 11/19/26 10:20 PM, Yury Norov wrote:
> On Thu, Nov 19, 2026 at 11:52:19AM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 11/14/26 12:12 AM, Yury Norov wrote:
>>> Steal governor is not safe against a concurrent CPU hotplug operation
>>> because it can change active and preferred cpumasks during the governor
>>> sampling.
>>>
>>> To address the race, the governor would take the cpus_write_lock(). But
>>> that may be impractical for the loadable module.
>>>
>>> Instead, implement the following locking policy:
>>>
>>>    - if the code takes cpus_write_lock(), it's enough to write-access
>>>      the preferred cpumask;
>>>    - if the code takes cpus_read_lock(), it must also take
>>>      cpu_preferred_mutex in order to modify the preferred mask.
>>>
>>> The core scheduler and hotplug paths already modify the preferred cpumask
>>> under the cpus_write_lock(), so no change in core logic is required.
>>>
>>> This provides a common update protocol for multiple policy drivers
>>> without requiring writers to take the broader CPU hotplug write lock.
>>>
>>
>> This is also necessary if there are multiple writers outside of core hotplug No?
>> So should it go with the write interface series?
> 
> The race is real, and it's already there, so this is the fix for an
> existing functionality.
>   

At current, if there is hotplug, core takes cpus_write_lock to modify
active/preferred which makes governor to wait.

If the governor is modifying the preferred mask it is taking the read lock
which makes the hotplug core to wait before modifying active/preferred masks.

And there are no other infra modifying the preferred mask.
Could you please explain where is race currently?

>>> Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor policy loop")
>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>

