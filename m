Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC484A0C;
	Thu, 27 Nov 2025 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764224935; cv=none; b=Nuco8p306ceiAq7r/Vdeu3IfzrMcwgCQFo5NSGkvX1OOELReLfBWCiTGvVTV9+5vCkwPmV8aRVGY/4TLNk86DcE8BU7YvSGuGj1nyRdgC1qD1jxO4LrCDTpRCiBbltXgp1PIPI5numBCuFbn2ww1rL+IeYPzYQv3MpnJPeS4ivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764224935; c=relaxed/simple;
	bh=0WqSzzjC7bpjkH6voUH/Ptzv7hYKziCx0Xk5fm4h3Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARzNc3VB8aQY2crvYIIxA1eQdujb3I/wOQC76IbiDxM3/JkL3HnWp4IbHVwbl9t1aIO3/B0SO+9gzJ+dfNwnEleFNrVAemOdm8RiT3XIKFlXRljADw+G5smoOIEPrmcW5+5bY9EMp8kPUoB3O1o0rlZ7ythbDNO/JkLGn1/+LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nZxyhhEO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nZxyhhEO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28muh012898;
	Thu, 27 Nov 2025 06:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b+ioGM
	GoyvGYBdSvjA1zoFbSs9VnZv5DlU/Hl6eBc6M=; b=nZxyhhEONm0yu6VR/R4ZbW
	0UmcpuVxaxW5+NZCIe2HbZQ2i5je6Owp3vnbR/biouvTiiqzhXtlo5nXwPKJxLHQ
	jnrxcpzo/sudrMqUz6zJ8uJqOOZk02XCVc4aPBsBXLv8bH9W3pOUcRUYQDMKkn2O
	7JZRmskNeoDUhqgP3o6cDQYvAt7w5xxsHNjaslMkpPLk9Ce/7fym2AclxloUB07z
	Gn2lgbD13MNz4KZLzeifAciBCbvvMDqD5HR/4qZspQXPUAJlfqfjNrkhL9FlAJBq
	7/zBFk8k3QtI0KNm8G2pTnMoLlNsqAdwnqRAgR8olg4de4zppgjJJBLy2rj931zg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kk6uu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 06:28:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR20U8u016395;
	Thu, 27 Nov 2025 06:28:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0kejjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 06:28:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AR6Si9h28901728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 06:28:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99012004B;
	Thu, 27 Nov 2025 06:28:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DF3720040;
	Thu, 27 Nov 2025 06:28:44 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Nov 2025 06:28:44 +0000 (GMT)
Message-ID: <389e0ed1-a46b-4ad0-aaab-da59cde2067e@linux.ibm.com>
Date: Thu, 27 Nov 2025 07:28:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Linux-next] perf test: Fix test case perf trace BTF
 general tests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
References: <20251117124359.75604-1-tmricht@linux.ibm.com>
 <aRvSv03cqarM5dY9@google.com>
 <d60860b4-e84b-48e1-87dd-4bd8203a69ad@linux.ibm.com>
 <aRwVifZ_-7puFUVC@google.com> <20251118132451.29a35127@gandalf.local.home>
 <aR1JXlhJ8rC8Ujb3@google.com> <20251119125903.417f595e@gandalf.local.home>
 <aR5mTLRWA-SLAFUM@google.com>
 <a7a5f95b-25e0-4816-9d0b-04d955c95821@linux.ibm.com>
 <20251126102401.37af98bb@gandalf.local.home>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251126102401.37af98bb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: entgzrVjY0OWB0lMKPiAF6Sj9NeK7GTm
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=6927efa1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=0pZdLD883FW2vNapWm0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: entgzrVjY0OWB0lMKPiAF6Sj9NeK7GTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX2QUjQpcyWqlT
 duDkoNKNKliqqncmbuCWZc417Clic4oJsA0uIBK6kAyqRol315hv9DbHkEn6QnzwJapb3TnsqgD
 JTnGL4a9T5+Ys/Ytd0r+pxhZDUv0I42mmqnyolz3J51yZZvGUDGvQn8WSg8RtLHqG5QqVt4offh
 4tUWTUbgo7p5WMLFhnWKSWpKOljbL+GHJk1YZvMQKHPH+q2EI4So+ukhs9Q2d4hyLstFX6bPwT3
 w4wU16tsgsbIfL6D3dsZZz+3e8ZMas1BvONVvVL07fWuzvfO/V83KbPyhOCg51qYo1gzBE5kfKU
 X8QbeVZ6bNAa+aedQPxMXFUrJnTSapUAq6Wnzgygcb3otM1A86M71vAlsMZTgeJ4zBHpRFVu7v9
 UjyQH+zGLjoEhUZ16BPw8yRPi04KHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On 11/26/25 16:24, Steven Rostedt wrote:
> On Wed, 26 Nov 2025 08:13:00 +0100
> Thomas Richter <tmricht@linux.ibm.com> wrote:
> 
>>>> I haven't tried it without the patches. Does it usually show what "buf" is?
>>>> Now with the reading of user space, it can show the content too!  
>>>
>>> Yep, it reads the content using BPF.  This is on my 6.16 kernel.
>>>
>>>   $ sudo perf trace -e write -- /bin/echo hello
>>>   hello
>>>        0.000 ( 0.014 ms): echo/61922 write(fd: 1, buf: hello\10, count: 6)                                 = 6
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>   
>>
>> Hello Namhyung, Steven,
>>
>> friendly ping... any progress here?
>>
> 
> I honestly have no clue how to fix this, as I don't even know where to
> look. Is it BPF that is messing up? If so, where's the BPF program that is
> doing this.

Yeah, sounds very familiar... happens to me all the time :-)> 
> I thought BPF is supposed to handle updates and should never cause API
> breakage?
> 
> I'll continue to look at the builtin-trace.c, but it seems that the BPF
> program it's attached to is handing it garbage with:
> 
> 	perf trace -e syscalls:sys_enter_write
> 
> The new fields are at the end. The BPF program should simply ignore those
> values. But again, I don't know where this BPF program lives.
> 
> -- Steve
Ok, this sounds that the issue will linger around for some time.

Can we then adopt the test case check for perf test case 'perf trace BTF general tests'
to accept that strange 4th parameter?
Right now this test fails on a daily basis in linux-next and will most likely be in linux repo
soon, where it will also fail.

This is sort of 'unfortunate' that our daily  continuous integration testing reports several errors
per day... 
If you guys object to that fix I sent out a few days ago (which is absolutely ok), 
I will disable the test in our CI test suite.

Thanks a lot.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
