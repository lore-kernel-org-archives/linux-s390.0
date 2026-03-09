Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4413BE171;
	Mon,  9 Mar 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061174; cv=none; b=PMM2A0qaLQ5hhkXsi+TumB7LV/tn8MW5YI7RNqMQb2CkDeu/cfkN03grrT+HpscnJcaxObBcgY4sT2kw5qIKTwTbH1tp5iALRtjYfYB0c3DBkwjjEJM3RVXVwuZtzDiR8VjGkoS3B9IABGcAycF/Juu3BNt0psvf3R3Fp7yI09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061174; c=relaxed/simple;
	bh=yoflgyv/G8R1T0EK9HWeKdsBuuk16B9FvBn0XECFjoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBcyM1BZSpE2PBFi/4NsSp2Wgi5ADmlzJoElVwzJPex4Fnn9MHSygqE+xHp5WmnCFXVmtVMJ7y1w3k43jejOgDapSURgimfP9KkCg4fGu9kVCWnf6oY8NGfbdHuAEYkaL+2KWTF+9Kzd+rpDFAW9ysxfjJY3dMCh135AUpikAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlLnXJzg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlLnXJzg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628MP53w1849314;
	Mon, 9 Mar 2026 12:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KJ5S/s
	OQcAav7Fz9nWdAO9HVCFBmuK4TuBRyYj1q9uw=; b=HlLnXJzg+pB+jGpC3gh5qm
	l0IldNAs2AukGwrdYmDUkRQaEiCPLamDnROWm+vcexsPSmOLTIORaUW8j23FcCbI
	yvuV5mMhzfZB22/PmJelv6se15TrIB6gIBwiaUkaslxZ1RW+o2O6VsBGFHxvew1e
	T/vLQlNFHlJNKIKhdzbixVyfmhFjjzLr3IAmuo9mo+fMheZD6SfloEx82nVZNrrG
	bnuikm3YFhmah1r2asvjqGR+zkgQ+axWQm515HdBXWd1AjpW5NibwySSs6TI3RVf
	rMWRY3blRQqJWNCRRjVik/uGd1yTPsHrunTg+16ufgWiHhSHisGpSZYCa7lmvGRg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm6ked-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:59:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629AbxqH025033;
	Mon, 9 Mar 2026 12:59:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjvt80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 12:59:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629CxORm56164726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 12:59:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A2C20043;
	Mon,  9 Mar 2026 12:59:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC1E420040;
	Mon,  9 Mar 2026 12:59:23 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 12:59:23 +0000 (GMT)
Message-ID: <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
Date: Mon, 9 Mar 2026 13:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Ian Rogers <irogers@google.com>, Jan Polensky <japo@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
 <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EHYMymj79TsYvU_Gw3-4UH4zPfq-VV0A
X-Proofpoint-ORIG-GUID: qv7b5GJHVNxjmvdJT4d29r1RIWqJF-hB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNSBTYWx0ZWRfX5K+vPNT/avU+
 V6dxX0FPffniNQTYKhCeXBipSKln/WyHSANHxa9LaYPAf7HmsRAQk+dkQTE7PuqKUWuedA3XJ0F
 8gKXH3CuLDYc8Xrn2UoKKaNBFHR3PSp93WgM17gPHOdbGi+UGwvSTs35agf9+uF5AZrjYRGrhgx
 LZXiPiCbd7D+MMhDE2xjxzeikYQgmbExH37qVt8tY5Y96MN9p42Szrp/7eQonPIHXQCpjimo8wj
 zgEJOidx1MSvkk5aQF/Q+kT/QxsvM57x7YP1dhD87L2V6pIXhKv5j8kdjQoTEkNYNQEpj3nrxrn
 EAly03SOrpScZ1LzErkau2USjQe2UBGdq5JRs9eMqqV6pGubmwzm5PWl3AxO2lDPxMdtZMgw19I
 hFszZuqm6POHlznbVDi0h2xXwEhl5y+ZipY/bm7khax5V+3q6QvXtBarq1zHbGlLW8Hv41ZO4vV
 /oJfgxbJ1aM+kTsTqfA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69aec431 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090115

On 3/6/26 17:53, Ian Rogers wrote:
> On Fri, Mar 6, 2026 at 7:52 AM Jan Polensky <japo@linux.ibm.com> wrote:
>>
>> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
>>> Perf tests
>>> 120: 'perf data convert --to-ctf' command test
>>> 121: 'perf data convert --to-json' command test
>>> fail on s390. It is caused by selecting the default event cycles
>>> which does not exist on s390 z/VM. Use software event cpu-clock
>>> and specify it explicitly on the command line.
>>>
>>> Output before:
>>> ❯ perf test 120 121
>>> 120: 'perf data convert --to-ctf' command test       : FAILED!
>>> 121: 'perf data convert --to-json' command test      : FAILED!
>>>
>>> Output after:
>>> ❯ perf test 120 121
>>> 120: 'perf data convert --to-ctf' command test       : Ok
>>> 121: 'perf data convert --to-json' command test      : Ok
>>>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> [snip]
>> Thanks for providing this, Thomas!
>> Tested-by: Jan Polensky <japo@linux.ibm.com>
>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> 
> Should we not fallback for the cycles as a default event?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-record.c#n1374
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c#n3792
> 
> Thanks,
> Ian
> 


The fallback should be cpu-clock in case hardware event cycles (or CPU_CYCLES on s390) does not exist.

Thanks Thomas
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
