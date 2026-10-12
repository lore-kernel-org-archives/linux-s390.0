Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD3A4119E3;
	Mon, 12 Oct 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803104; cv=none; b=g/P9905hKrBQnX6scPPi37Jyq5qi/qAM1XdnWOjag2C0ygzFWsLUxTuz2YVjdGXROvCapfn5urR472obOtQO+mqKo2+GAas7yHDs7HHB8w8NChjQyk40fyyZdrxVEE/p2B2kf2ICTHN85wEi/0k1jkdc2uZZ+m6mPx1HlGxn7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803104; c=relaxed/simple;
	bh=hGFWYuob3Sswjvu3S8vb6lcOgmhVeXvnZhP5o8oIA6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJHfiUkbpO3u45zWPBlIgI+6CQkRRsVhH4scYCS8aly+SK9RmAT1+VARs/UzqZ60H8Nlev5PEhIvKpw44Gc6JGQUHDXBKhZnO/T3kfyXTSkZrKo9BOeTztzz4xEjbxk7Z7LdgKIAULsZDb3b1nOWyrlUXJF/7S5NcHIJcUxvIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cdLYeeGx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cdLYeeGx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iNP43968412;
	Mon, 12 Oct 2026 11:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H6lHDv
	jWoL/8D3SqHUDS2NJGGo0+waNGs/jfJ+0SGRY=; b=cdLYeeGxNhtCn48VzXv3k9
	M20Z7OVt7vLAYPfdmEbAF4GVNp5FzkFg3e7KJcfHS/W1nyGzRwY2H7ojPy9KpbB7
	1iDLwoVkiWv+DHw5HwW4RZXfWXFZwaW476nbw64y9IxOOfyaq/3JtGhO/K7U+yvB
	bcT5XeKjLKPPLyWW7WoGC0SNmDCsxGnQHd1u5VyzX1pYIIlact0IwuQGDeEtqoYK
	wKQkbLgRrQWBhHoDiEDRBdXAWl2JXZLgXrwT6lh/0jwLc5E0Bfa1lfoBWD1WtJuI
	8Ru0SBp/Ith3KrHnjVJFmeRRWP+hAW+NPawclS/O2DgQK9kqlAewfO+kuhbv3Q1A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w05fv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:04:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2OI1013550;
	Mon, 12 Oct 2026 11:04:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cycjd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:04:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CB4ZbS40239442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:04:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F3520043;
	Mon, 12 Oct 2026 11:04:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79CAA20040;
	Mon, 12 Oct 2026 11:04:34 +0000 (GMT)
Received: from [9.111.22.209] (unknown [9.111.22.209])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 11:04:34 +0000 (GMT)
Message-ID: <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
Date: Mon, 12 Oct 2026 13:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
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
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX9ITKfMZlLLDO
 tOky4iH6kEH9SwQwKGOk1Rn/u81ZhR6iWTUeRC2skYyHpYODaOfX2Mk/cCtpymZDQ1jttcBiGKV
 Bbc+XKQyGOcYH3bBMorKVPegX2AGKJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX0IWL2TAtrEKv
 w/z3SfKhjwn6uqPic7tnlWo1iD2WeZlhRtJ+jx7G5zDFhaS+HBweSu8uEdcFkwiA5N22Q4NAyfZ
 W/KuTonOC4ZeLhH/xWhrhVh5xpwCqNWg3RWzWXaXSsAhbwu4vOyzfHbfK0xDoF4D8mYrW0z8/58
 ONmPevUiDXjxlZNGGfcO0KpoA5Ib1yzERizLHQZoIxinIYUBB8FetJiYowjhAEsHp4I2wS9ASCB
 s4YQrQhgwfgEb9wpd+u/aXDDGR4FOvl7vz3dp5Z8D9zy/r1kAn3VUKF8UfU0CJrl5zLak2ADOIt
 gqXCbcEyfo6H2K6PuK5NJEoVmxpg0KemyxhIYLPe4DtQAm2shCYffgxDNkWRtaFycWIoZTjXtgh
 5oZGfY0NZm9TVsHdMoiDmef1GBR0wNQMqu44wviLsM156QEVGQnEE1ZGt+2eNkzvqlNzqXqVs1A
 ukx+FCUgz6RO/KNNlXQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accbec8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ep0Fhx_0OpY0J4HdKAIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cMrg5Cs3QBr5QftxNz9JPcXHt0MF1pKf
X-Proofpoint-GUID: hPAiBG76SLYJ34IwC7DN2JFgllRnaWGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120042

On 09/10/2026 17:32, Vincent Guittot wrote:
> On Thu, 8 Oct 2026 at 17:25, Mete Durlu <meted@linux.ibm.com> wrote:
>>
>> On 08/10/2026 16:58, Shrikanth Hegde wrote:
>>> Hi Meter/Andrea.
>>>
>>> On 10/8/26 5:40 PM, Andrea Righi wrote:
>>>> Hi Mete,
>>>>
>>>> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
>>>>> Summary
>>>>> ===========================================================================
>>>>> On systems with asymmetric CPU capacities, the scheduler prefers
>>>>> fully idle
>>>>> cores over idle SMT siblings of busy cores. This works generally well
>>>>> but
>>>>> virtualized platforms where low capacity cores should be avoided are not
>>>>> considered. Introduce a new config option and arch hook to prioritize
>>>>> SMT utilization.
>>>
>>> That's true only under physical CPU contention right? or is it always?
>>
>> Right, because of that s390 treats all CPUs as equal and starts to
>> assign lower capacities to CPUs with low entitlement once a certain
>> steal time threshold is crossed (aka physical CPU contention).

Hi,
Sorry for causing a misunderstanding. I should have been more patient
and detailed while writing my reply.

> I'm not sure to get what your topology is because "if s390 treats all
> CPUs as equal"  then you should never use select_idle_capacity()
> because  their capacity should be fixed and equal and
> SD_ASYM_CPUCAPACITY_FULL never set.

On s390 the entitlement of the vCPUs are signified by an arch specific
value we call polarization. We can tell which vCPUs are assigned high
and low entitlement. This entitlement value tells us which vCPUs are
prone to experience steal time first. Without any contention all
vCPUs behave and perform *almost* the same(of course, we want
some priority for CPUs with high entitlement).

Prior to experiencing steal time(it's what we use to determine
contention) to get the most out of the system we assign all vCPUs
the same capacities, making the system symmetric like you say.
While there is no contention s390's vCPUs also perform better if
fully idle cores are selected for task placement.

> If your hypervisor lowers the capacity once a certain threshold is
> crossed, we already account for the steal time in the scheduler with
> irq and remove it from the capacity available for tasks but the
> original capacity doesn't change.
s390's linux implementation has a mechanism called hiperdispatch,
that checks topology changes along with system steal time (and soon
the total free capacity of the pyhsical machine) periodically and
makes vCPU capacity adjustments accordingly.

After steal time starts ramping up and cross a certain threshold,
we start assigning lower capacities to vCPUs with low entitlement to
hint the scheduler that they should be avoided.
In this asymmetric configuration, utilizing low capacity but fully idle
cores hurt performance. Instead packing the tasks first to SMT siblings
of high capacity cores would give s390 a lot of benefit.

I hope that clears some of the fog that I unintentionally created.

[..snip..]

