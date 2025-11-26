Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE45221FDE;
	Wed, 26 Nov 2025 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141196; cv=none; b=BaBvkiQ1pQ0gSwhGMr6B9bncXjOJUVZK3YgNxpkFrGSdiHciIdH5qMmQU1ohrK6Sg+8knM6gVRjUZvsPtXsIBLa4ORcrqBO+LLhIZSEYBEaAqpZDqZhb7ExFD2M21hdSa0lSwnWnC7wmQJrJ8eKeWnIMwCuvbxo5Hf1/rwxHRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141196; c=relaxed/simple;
	bh=CghIzvifIzj7wUX1Yf6flOI5O5lNYwEinemt3bj/1hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnU2JrWaMXiSarTyBfShOQ0kLbo/ZcQzzWwhzaiAkjLM0lTEAvHRt3Bo6+ECa+awCZTBYVVxqJI/Qsq6oFzvjzSa7J5ic2MgKqy4F5pXL1U7fwOd6z2TMNuF+17HmtLerL6iHhUs8s0m77argPfsqPnXWjAK9CFUZzXoSVxUV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DiZ2WRQz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DiZ2WRQz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ2BmbU002195;
	Wed, 26 Nov 2025 07:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sskhNi
	sivOqO9ITn3IG8cBqmWiCRM6z2JSLpTW1Ycgw=; b=DiZ2WRQzWB+5JmFRqOq5PJ
	3hi+yaFL4FwozxyFYQm9/8V618TXtWXpP4e1rZX2k8hCQ93Ae0wptVaanq7pSkBL
	f32QkNJ7C0tM04tghTX3qOuj/5D8oPpHJmMsGr350LlWYJ6E/N4YeIkDOCGKRD0a
	hCt2VZZ1Ttc3ZnF0Gw/bd5/1uDL286xPsmPnTwVryewS3GeN/YsignqKWtVz76GQ
	oq1qN98t1Sve2SM8XoRfWRQ1NE83eFDA1xCTr0EMkbMIW+Scz+j6CLvA59jhkTf2
	jyp7YLY4AbJvW8MXWW18Ema9hb/aUNFRfZIwrfS3xHq49Z//V+4f1RgDiAYqU8bg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq1mxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 07:13:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ6viZY025108;
	Wed, 26 Nov 2025 07:13:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71gcnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 07:13:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQ7D05I53018894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:13:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB5EE20040;
	Wed, 26 Nov 2025 07:13:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 721A620043;
	Wed, 26 Nov 2025 07:13:00 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Nov 2025 07:13:00 +0000 (GMT)
Message-ID: <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
Date: Wed, 26 Nov 2025 08:13:00 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com> <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com> <20251119125903.417f595e@gandalf.local.home>
 <aR5mTLRWA-SLAFUM@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aR5mTLRWA-SLAFUM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX+qPQ7dj4yQCE
 YUVLZ23vpuAWL70J08OW7VWJMddEmMumHXB9oXA4CyNUGyknKWVhEDKL/3lj+ZVUG1PNRqFrnZL
 ulhHjTa/CuEDECNZD8sXoUFJPqMRyWBl5K5d80mPxFLB9pb2TX6x7lpu2Gli+7cCfoK+BQK9Bio
 v13LmXyBSX+ZrfgeXqJNFPxVks4unS1EVMnCChN/eEx2PB5oHMAA5NyONf6J00jobGVUSvTLZ6L
 tnnze+lmlIQVsF9u6YZHBItQLzTQA31RFMWIAap611IJ8CGgScGRxhR+N1kjvM8WON6DhGuUWRz
 YI214TdrJZM8GPKttVD8h2j7Ifdwj3PDUUyy5ZJROASnlacbv9dyJ/RxcIjrd4/ALZ7GhGOK3XM
 NSfXREKX7EF95QAKWfw/362ey49iJQ==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6926a882 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JOla_U2dEw1KniFPV6wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u_4kOoe7VtMzghgZ_ad_P7naaLXVPYvV
X-Proofpoint-ORIG-GUID: u_4kOoe7VtMzghgZ_ad_P7naaLXVPYvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

On 11/20/25 01:52, Namhyung Kim wrote:
> On Wed, Nov 19, 2025 at 12:59:03PM -0500, Steven Rostedt wrote:
>> On Tue, 18 Nov 2025 20:36:46 -0800
>> Namhyung Kim <namhyung@kernel.org> wrote:
>>
>>>> Really? It still uses libtraceevent right? I made sure that this didn't
>>>> break trace-cmd and thought that perf would work too.  
>>>
>>> It doesn't completely break perf trace but added new parameter for the
>>> write syscall at the end.  IIUC perf trace iterates the format fields
>>> after __syscall_nr and take them all as syscall parameters.
>>
>> Is this a regression? Or can perf be fixed?
>>
>> I just ran it and I have this:
>>
>>    542.337 ( 0.131 ms): sshd-session/1189 write(fd: 7<socket:[9749]>, buf: , count: 268)                        = 268
>>
>> I haven't tried it without the patches. Does it usually show what "buf" is?
>> Now with the reading of user space, it can show the content too!
> 
> Yep, it reads the content using BPF.  This is on my 6.16 kernel.
> 
>   $ sudo perf trace -e write -- /bin/echo hello
>   hello
>        0.000 ( 0.014 ms): echo/61922 write(fd: 1, buf: hello\10, count: 6)                                 = 6
> 
> Thanks,
> Namhyung
> 
> 

Hello Namhyung, Steven,

friendly ping... any progress here?

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
