Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054CE395AF7;
	Mon,  6 Jul 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358805; cv=none; b=tmoGx5pcCoIotFiwNeFtk0PuhbtYLiaTb2ZbfWr9fxOjKQQjwwEuTdBkLpCJcylw5xMo1GAyosnXorLfTg4HsFHADOyZE+CN8aYGmNdDwQhG43fMyhreZOrMagOhLeg0dpoXAXjVfgMRIpSDD7NXRrZ/PXaWVkGLk3IJ31rv18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358805; c=relaxed/simple;
	bh=atej6mqAOqlzvq7HgKuOq4YqDdjBt2fRdVEROCAjEfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRNNlAmicvTEFD9KgUwxXvx6qcAudtYf5Z9G1FMVkm4nfWnXyEoG2CfvLk/MYC54XWr3BT944reS/elGuNVi0dZwvGhUOlCb2hi2IL9XuEffBsoed5O9CuTMG/BuDnUAbfrFU2RkSe8Zzka0wv2uSlO2R2lVGgjTW1Zt8gQgZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JptnX58x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JptnX58x"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIGf5962039;
	Mon, 6 Jul 2026 17:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C+64AN
	42UT/5Z4j/Ek6bSzP0U/kQvcPRBiTAYVh19M4=; b=JptnX58xxH7RQdOKcV9KMW
	XwRTUveIJog2yjvzeWSjYeElqvcpTT1iTLMYgDbsq7f0J61oYoCOVLE5QHDjWu+j
	Irstlswq4V/GMuHn3Qx0sZUr22PX5dT+GRt4seYbMgElRAvRPU9E4WWsKQhMnKhX
	9Y1X7WNHE1J0JA7LcZU1R6N47/ltph6L2tRU983d/ScDKLzSy3miaonbXOl4VO8T
	ygH2uZqmI+5KDYWAqnyMmhKK15/4LDL0FAGL3jePKNZBxPaxJQGgIQCd4Jtfze0L
	0Smr8O76xWiZWruHqAZPbzCL6YZ0h7Kc/vHFqBQokkOhqRL/qIeHdpZeqwR21DKQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqjhm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 17:26:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666HJhxS009149;
	Mon, 6 Jul 2026 17:26:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h6exa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 17:26:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666HQb4h46006598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 17:26:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C422320043;
	Mon,  6 Jul 2026 17:26:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6537920040;
	Mon,  6 Jul 2026 17:26:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.23.52])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 17:26:37 +0000 (GMT)
Message-ID: <0e48a230-3b0a-4526-824a-1b72443252d2@linux.ibm.com>
Date: Mon, 6 Jul 2026 19:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/vdso: Pass --eh-frame-hdr to the linker
To: Jens Remus <jremus@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
 <20260706151909.103539-2-jremus@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260706151909.103539-2-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3NCBTYWx0ZWRfXxsPQUhJoKb93
 Ybr8tK3baRd9P1Y9/KNPbh/BySKiY5ZT32oR6HZmhsv6+a0uAtIpi94WG5TIAaDsdfl8I0SdgqY
 t0710gvYEEI/3OfqSBJeDyZcL1tQnGA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3NCBTYWx0ZWRfX1YbtUNPqs41K
 TG58e2158vfq7i9934OgJ8ZNRkc/3c0T/o05tnG8fbQB7brW1ryqilhp3JNnx9kvZ4LRTswnyAO
 P6iw/Rc0MdHEqJ57T7KoGms/HpBuKgXIpTnPZOvkTg1ILf0pmnZkLiRurSZqzlo++4qWAtHUawu
 ZKVEjM25z8fI5e6WvyXU+beUVm2NNrQTIq07HTcuzx9PXJIhI3nrNAX64QB3Z+qH54i+gkOvZJo
 j17EwbClJgda0d8m1uFPBJCfFHzxcsxNsr70jDfp63r9xKUfJoHYPw+lqjGLnXI0ewohBro0zLj
 q7upOzdPRWTaCtwRax1b4XUqBYJ6my1hXOtEJcr49Oo9heBo/BZ+lcX3lC9EiHSmLExC3pYfaOq
 42yiZbxh/Ndt2Kx8dMOMGccPj57rpuy70M4qaCHAI/VfnRNOVBEnBy4oFwFS4ainonC+e4OTzCV
 eIyKplnCQ5JbHc3D7Ig==
X-Proofpoint-GUID: BT4dHB7Gzf8nD45956sDGtcPE5D0rHHK
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4be553 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7scW1GgyRHmQmRYzcv4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BT4dHB7Gzf8nD45956sDGtcPE5D0rHHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060174



On 7/6/26 17:19, Jens Remus wrote:
> Commit 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link
> vDSO") accidentally broke the GNU_PTR_EH_FRAME program table entry in
> the vDSO, causing it to be empty:
> 
>    $ readelf --program-headers arch/s390/kernel/vdso/vdso.so
>    ...
>    Program Headers:
>      Type           Offset             VirtAddr           PhysAddr
>                     FileSiz            MemSiz              Flags  Align
>    ...
>      GNU_EH_FRAME   0x0000000000000000 0x0000000000000000 0x0000000000000000
>                     0x0000000000000000 0x0000000000000000         0x8
>    ...
> 
> Originally, the compiler would implicitly add --eh-frame-hdr when
> invoking the linker, but when this Makefile was converted from invoking
> the linker via the compiler, to invoking it directly, the option was
> missed.
> 
> This is the s390 variant of x86 commit cd01544a268a ("x86/vdso: Pass
> --eh-frame-hdr to the linker").
> 
> Fixes: 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>   arch/s390/kernel/vdso/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

