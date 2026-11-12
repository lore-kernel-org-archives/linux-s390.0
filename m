Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460384;
	b=1lwLeSBToDY4hApQWWCHjRopkjanqU+LiFYQDZLC2fKuMxDd77woldKI/7PD9JN1wVgk
	 bsYGt5/IQxZ538JvjHBuoeI/bHn/zgZ7fpFV2ngdfLUcqjtzG8zRxNfyvdHRKDGKilHYE
	 nsguWkmJjfgH2UWn6+FefknQlO+Nf8Wqj9zB19OJwoF4+3gdY3X9hx/WLIO7zEBD+a5xO
	 +UUI4/JN6hU52mTc3B7AilJkbcMbmCA5m+A7zK9FEKdT521A7myVkgSNDHTfDUeHPivIn
	 ZxSlHCwhJ8U1tupqrsKjdM7bBzMSRigqF8Ihiu3tMrE9SRB8RjjbXXuUHMGRwBzIBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Hf0AXvsUNvjXjOJMG3JDj4EuaQqMCaznHS3229Oa2a4=;
	b=HtEv6IrXReZIVJpf2pvMOF7lw+BiDn7ND34N9l/siAoIvm4WKvk+AZjRUpaA+TEfNoof
	 HKu8Md3XaCuj4WoYRfo3GDjEQZZTb566wt2CSZKpw+LEjmS6U2v9gCqp6Ua8MLCtbHbU4
	 4f4pi5ABNy++7E1keNomiEngh2FeTAWi6u+ZyCEEGY9pMGzmCBPvF7WDEqsNL27u4bGfT
	 DLyiwtgUfqmU42jwKIrHJKpDm7bJSzomPDO17toAoac88tFzA1h80ot97bVeBA81Ttjm5
	 hUPna7rb9eUnN1MI9Htzvy2451Dxm0aay1WMHwkhzXrBL8nOEtzBSswa/QdXY0msd5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="phrgYDB/";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C6606A324;
	Thu, 12 Nov 2026 05:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=phrgYDB/
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2j2js2796920;
	Thu, 12 Nov 2026 05:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hf0AXv
	sUNvjXjOJMG3JDj4EuaQqMCaznHS3229Oa2a4=; b=phrgYDB/P661J+qWMoI7Lc
	YLcoxQLPj+c4Id3YKDBrUzd9xoojQvEQSDutEJppDScv3cKRtUeVon0L0mWpw7RP
	+FFEJakNqOFeJ3brm6PT9SOfg2Zdg2usjGWW/JQFnys7leLFv5YCkg7mB1vpLgjR
	xgmLvLDQ8M8yLB7GY/NqtUDvjLrwdjHPJGMTyT1oilQ52QOAxI35ecbinU0K7Ocn
	qUA0LRwphlWWXbXuuidH9fUIUI4tmCU+A1/P7tZuV5r1d6+FO6h83WIFwbBOGG3u
	j5LQYRB2FERJAhV/NlvhwRJZo3eo4s5pcJYSWSMWIr37ZenbwOj4iwe4IEN9idcA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkwgcv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:12:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZoCX106626;
	Thu, 12 Nov 2026 05:12:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nsy3k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:12:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC5CSkZ47120742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 05:12:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC862005A;
	Thu, 12 Nov 2026 05:12:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 611332004E;
	Thu, 12 Nov 2026 05:12:18 +0000 (GMT)
Received: from [9.39.17.134] (unknown [9.39.17.134])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 05:12:18 +0000 (GMT)
Message-ID: <ef8dcbd9-61e9-467a-88da-3d159a5df9df@linux.ibm.com>
Date: Thu, 12 Nov 2026 10:42:17 +0530
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
To: Yury Norov <ynorov@nvidia.com>, Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>
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
        linux-s390@vger.kernel.org
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com> <avTSC2r61uht9oFK@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <avTSC2r61uht9oFK@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af54ac1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8
 a=z54utOFOnMwhspSCAOEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX3HJBwkFMsPvJ
 KkBYz83eIQRrbY6olD6lX9j+0ShfGj+XJt9LC462ChLKoGT0RzsWvLO8b+x/v7T2G4VXdyxFph4
 oxQ/4WwjA4u4AfX2ds4RN5TZlHZDWbyQLgbZf3toZPVPtwzaCCona9UL77gXDsFXgzasD8olizX
 hE+IakX4XD+OQpCtc7qIosTQrAkClbrBSW2nsQ01gbgVs9exHtx3UGohOB9UxTXEB4P3G8ejqzM
 fo4Wr6VlNY52a4YiuYMO3WrS0/KAt3L/Qsj2IxfWxd8cwMW9mqE4XRpCua32+tbDcq/5MZAogd4
 AhVnIjozx/lfN03XuVaJyz2ofbeHnz41DcIdfo8xX9KkeFp0AJOuXohxr8Pkvk6d4Nf88Kuu86N
 9QPrpqd2dL+yLWZYtymQoONG//uExILycR7L7YGZVk8vkyw+AjgEIUXXA+rmz0KHEkjPJwUBjZ3
 43uiCUi5mSnWD2oZtew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX4ySYHq3mrpLD
 YyFPk/DpwQxMq+nCCul4/3HNMD8JXVdQHv7ViYPl15osg7LlQhcjefX5QF90wKBNFi0BtBqtiUy
 CF0K+GmNhIfjYAIszT9BvAZI4CKeChs=
X-Proofpoint-ORIG-GUID: OeJyO-NNYMTgqCIJOKHW8OLywsnJAI7o
X-Proofpoint-GUID: RZFZPk8z2WiLfkrE2NbB4E5FQNS6XzlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120018

Hi Yury,

On 11/12/26 2:07 AM, Yury Norov wrote:
> On Tue, Nov 10, 2026 at 04:15:31PM +1300, Maxim Kuvyrkov wrote:
>>> On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
>>>
>>> The preferred CPU mask currently lets the steal governor reduce vCPU
>>> demand when physical CPUs are contended. This series adds manual control,
>>> opening more use cases.
>>>
>>> For example, setting CPUs aside for selected fair tasks at runtime while
>>> steering other fair tasks toward the remaining CPUs.
>>
>> Hi Yury,
>>
>> I've been trying to do this with crutches in user-space for a long time.  Thanks for implementing this in the kernel, and with a convenient user interface.
>>
>>>
>>> A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
>>> whose affinity includes preferred CPUs are steered away, while tasks
>>> whose allowed CPUs contain no preferred CPU can still run there. The CPU
>>> stays online, task affinity is preserved, and the selection can be
>>> reversed without rebooting:
>>>
>>>     # rmmod steal_governor
>>>     # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>>>     # taskset -c 3 ./my_workload
>>>     # echo 1 > /sys/devices/system/cpu/cpu3/preferred
>>
>> My use-case (being a compiler optimization engineer) is to pin benchmarks to specific cores, and stop the system from using those cores even when the cores are idle.  This prevents L1/L2 cache pollution and makes performance numbers more stable.
> 
> Hi Maxim,
> 
> Thank you for the feedback.
> 
> I agree, this trick with pinning a workload to an non-preferred CPU
> looks promising for benchmarking purposes, and probably for more.
> 

Sorry, i don't follow.

Did you mean pin to preferred CPUs? Why would anyone want to run their
workload only on non-preferred CPUs? By definition, they are not meant to
be used as much as possible. and It is benchmarking.

> I'm going to split this series to the cleanup and follow-up parts.
> In the follow-up, I'll focus on this writable interface. I'll keep
> you in CC there.
> 
> Thanks,
> Yury

