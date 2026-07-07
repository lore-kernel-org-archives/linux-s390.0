Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341742089E;
	Tue,  7 Jul 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409578; cv=none; b=M1aiBcbTznRLcpv0eX8aNi5HxMgoUEzU1H3K4ocN0N8g0tNSJqGtBi0IPRzhTwlbz7xoyGr++7lqg6PRVcK5NEuVHMByBT2l3plN+bBsDY97jz8BelWDGv0hOPOrrXr39HBm2zzEQebGUiVbzv/Cme5pU0c3V0B9kooM9bpKTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409578; c=relaxed/simple;
	bh=CI0H+I/U9gfFfjdZ3xfzQ+ZKu5cuN2i9hutJuckjInM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXMVjWHLy9pPucohpipsILgsglCNX6H/kjBJs4BU1PvrawO7c5zV+HNNJpTba9KREqLBNc+a0N8UXM+JAZY1fl7o7HwvYFJuvImuOAPINdVd6LAs8NJLsG92PpmqT4+3f9ScVbUuRpM5fCw/Lgb0ZK1iO9pcukfbt1XGLPVbg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uh0PcWmK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uh0PcWmK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6674Iffl2386574;
	Tue, 7 Jul 2026 07:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p84rQA
	gW8Gt8yAfhyCACj+FSu7xgyKwod8uMbhyLHDY=; b=Uh0PcWmKp/3I/XYHOpy/uT
	IW370cyJkF9OSTkY7dFc9U3rb5JP2TAzevf71YLw53CYmelCdi0dhY5BDS6P4jq+
	8C+iPA6jPfwUUVFcOaX/0EiAGztpBl0bjj8KFU1U3T6DL0+feEIc0ISyc+pc6Xmd
	HU/IhEHjsbyWmyoUMUOR9sUx4vCYwEe0ED8EO6OxeSM2DVvp9Y57kY36SQT8yjWf
	/9oWRfRjb0irjSf3yAs8HDgrrfeKUrQ/paEETpePinkbiYwdl0Ipw5LBYAReyAx3
	Lhc/R4Mj9tl4VGyon9o3Z/692SY6UGO04xjeg2xohhMW+yNb+NMtap5bsR4fzrxw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3ntw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:32:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6677Jgxv009168;
	Tue, 7 Jul 2026 07:32:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw1q79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 07:32:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6677Wp0X14877068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 07:32:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6270C20040;
	Tue,  7 Jul 2026 07:32:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 410EB20043;
	Tue,  7 Jul 2026 07:32:51 +0000 (GMT)
Received: from [9.224.91.136] (unknown [9.224.91.136])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 07:32:51 +0000 (GMT)
Message-ID: <ed9c694b-642b-4210-870d-a85d1c53b2fc@linux.ibm.com>
Date: Tue, 7 Jul 2026 09:32:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/vdso: Use symbolic constants for the PHDR
 permission flags
To: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
 <20260706151909.103539-3-jremus@linux.ibm.com>
 <d3ffd684-73e8-40e8-ae18-f847a6d0691a@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <d3ffd684-73e8-40e8-ae18-f847a6d0691a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4caba8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfXxCgpoN1JnRXV
 Wega1kBiJJepFUsw+k6ri6/aFs5sItFn5xZV4Boio+lKQzHIIuCJJVMxUuAgYwKQSNJhvnVGxug
 NJNuIieSd+fiQAdx/bC4ib8o75RW9Bc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA2OSBTYWx0ZWRfXwx4udu1lXGXr
 VstzBysJ+0ZNM0cMGEfviAfZiaXjC2urtyx2isxAs4R05IfNIACuet3znzpzLt9bo3tXYwvu8Uu
 0Qyl7YbwzgYRgzokB+Lf82clGWtFs2M3pOKUJFqoL8kodC+eiW0jVdcgqV5dGBmEjz/+v4Hetw8
 IJ1rgeLAfAIPMjUv7xZ3SqPCurME625cWO3e7pJcrDiKOJ8yCZ3/BD08FN15BIufCEwPDJRy97i
 RJ/P2UTea6IZS+u59/0CKsLeVTSfHCmarsq6QCFsIvLbgNwAuX3S3l7C0d6eb4Omp7g4DTTpeT2
 9EushuonKaCYyqp6fEVnrBSjo0WwV4CPeqvE0aGI8SQBdvHVLbotBePAzDxa+8/r+SsJjw7bR7q
 iMyXMnYPySdnFY6UHxXfcdBBRmC79HPDJco9yEKgY72S3UQi2NzXicAYpM3Q6FaATS3kfhXSs3T
 xWLV7ijTJ1cZ2nALXKg==
X-Proofpoint-ORIG-GUID: j3X4mvp_R7O8UumPlpdmbDl7Bk7silKu
X-Proofpoint-GUID: j3X4mvp_R7O8UumPlpdmbDl7Bk7silKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070069

On 7/6/2026 7:06 PM, Ilya Leoshkevich wrote:
> On 7/6/26 17:19, Jens Remus wrote:
>> While at it explicitly specify GNU_EH_FRAME PHDR to be read-only.
>>
>> Inspired by x86 commit 8717b02b8c03 ("x86/entry/vdso: Include
>> GNU_PROPERTY and GNU_STACK PHDRs").
>>
>> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
>> ---
>>   arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
>> index 7bec4de0e8e0..35ea7ede06c0 100644
>> --- a/arch/s390/kernel/vdso/vdso.lds.S
>> +++ b/arch/s390/kernel/vdso/vdso.lds.S
>> @@ -82,12 +82,16 @@ SECTIONS
>>    * We must supply the ELF program headers explicitly to get just one
>>    * PT_LOAD segment, and set the flags explicitly to make segments read-only.
>>    */
>> +#define PF_R    FLAGS(4)
>> +#define PF_RW    FLAGS(6)
> 
> PF_RW seems to be unused
> Intel uses it for gnu_stack, which we don't seem to have.

Good catch, that slipped through.

I wondered whether we should also add a GNU_STACK PHDR in a separate
patch - similar to x86 and for the same reasons, as some of the .o files
linked into vdso.so do have a .note.GNU-stack.

> Anyway:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

