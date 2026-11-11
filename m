Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401036;
	b=1YdXARM7Paydfh8Yf3j6zWt/kKywUz6B3C5xWb3XnODXjC9xQO+SXXR1bObNZuIrQ93I
	 kKjbCcnqXMTouhZWNhzr2utvaACPOeebPbzk0IeLSFvRh3h4as5ZkRLaI8HEwSsl2OUeG
	 tPMzK1yQByaNwsKxxs9tS78xNhaCh03VP1MgV2DgE8hjd1kMAOKBJx5quQTA0xlZXYr9i
	 0/fg+ftUVxim0aPKPGSjH6ORMunwcm8ySexexjmIR/l6HawpfCplU2X21hyD7Ww0V7ihg
	 0dj0EB40hhE9Qjr/D4aMJnA8Z9qu9DuOTYO2TW3YF5CfdJpThtCJTNw6/jWa3pkR7KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401036;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qYmz3GqjaSkvnipcM4i+09arVtFA8YFo71Bfz4OiDvc=;
	b=5i2rEgaiSqgjtt03gWHQVw2Q8MWIInG/aJ6ap6rbAh9iR5noa19BygVOhUUzG2tQasa8
	 zVtcyHCt7s376TbfmFMwjfFMJopvNfpQ8LcM58MSzlmAfguCsywmS+QA0ou7qKFB9+koB
	 QyUfVIjXfq9Lq4B+NJP8QAWmQSYWKMtHIdi5tZidN+UvztW5YFVguZwuWncvCJZGU+fD4
	 NzC92a+GlP/SlA+s09MXmzBIekrudjuJrI54UftIYi2ZOC2HqL1aanP3T3WVKYp4F/IIO
	 N/PjSFsIehDt/nFD7k36IvstxEAgr/+ebDJmJBG0YwAs/Xo6p8MOkLEkRnYOszCPOAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gekFgyps;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED5606A31C;
	Wed, 11 Nov 2026 12:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBED5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gekFgyps
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5isfI3261993;
	Wed, 11 Nov 2026 12:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qYmz3GqjaSkvnipcM4i+09arVtFA8Y
	Fo71Bfz4OiDvc=; b=gekFgyps+6BXMV2e0xzxTGfWuXeeX+C/k7LecAnE+KOyv1
	R8rp2Pia5MuDdRIjbbwQ2IUdbuCcfPmFfU1WaGYxjwCuQUi9BFcrk6uhgUbBcwQT
	afmwRcLda6sekLhCjy6+/b6ekIMw2g6OlGthF/vJtnfIzyTfyAIuynTLUJzvpLI5
	L7f2Jekcv4lkD8/obmk2pSrgNDE5Kf4ad2MGdwKA/yj2cEEK9Rib6BNHEaZ+IpXE
	u4CW81iVBH6xFxrVhf1n0gZpTQ+NUUAtOIaRYWGH8KRD25wdzPzi4pJipTvXiLJc
	K6zXPJmlFjKIbJWGZgY5q3oMsFs3gDTLwNH6RgXA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg9h43-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 12:43:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYtVV3286275;
	Wed, 11 Nov 2026 12:43:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3324f04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 12:43:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABChUs928508500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 12:43:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3752004B;
	Wed, 11 Nov 2026 12:43:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F41E620043;
	Wed, 11 Nov 2026 12:43:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Nov 2026 12:43:29 +0000 (GMT)
Date: Wed, 11 Nov 2026 13:43:28 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [PATCH] [RFC] instrumented.h: mark instrument_write non-const
Message-ID: <9e0db1c6-a637-4fb1-b6ad-db22fd3ddbc9-agordeev@linux.ibm.com>
References: <20261111092231.2027735-1-arnd@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111092231.2027735-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af462f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=h2GPdUkYvjar_X7b29IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX0upqQ5ce/Pm+
 wTrum7/HgBFv8XhZO3BP3hLfar++ZFblLByUZG8stu7JQmxBSr8RAaMRh+1ifcAwH/1gjI0z/F+
 6g8bdmY4uCwkrxpHgulA002qcNWKnD/PgEv0b8NWqGRYlp+YVwsyeKk6VFJ25PqEMQ9UhKIXymM
 CK74sVW4BPyMIVgTOjsdkaY/7/i6kcwfR6uxwgS5CCNEmkKVPNyFOsPHySE2uZHOInES1veLb63
 F4DybHIQPr1rTL9ksbRHAY7NOvZBMYqBKE4QiSxp2kZkMGfQddxvOHglGmXWSFjqOmMUwWe3Tv4
 2H3Ka9+xY9U9WqTkJyHCwdhcjkTojnh46V33YlHL4mbUEbtGvJ4ez7hc29kfgTMUXuDWXB4kYQj
 9KXUJacbJ+gUb4TLf2laayvHLO2i2Fg3anUxlHigxd93V3dRTDYLbkdiY/9hf46gNnicg/louNy
 g9gecn/t13QG+cmfkcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX852uAGi5PYiZ
 nsPkzATZy9mjHgTD4CjcAlWKU+nL19wJFYMIf81nhtsi7v18sJRwh1HwAnjLRLdR1x/vvoLQnpk
 8L1ITUuw8OvS3WicjbnkiBAysNXEnVs=
X-Proofpoint-GUID: ceIP_O8HdMhCYCYezPPo4tpjndDBOFMa
X-Proofpoint-ORIG-GUID: FUoKXVp3UpAvUAi1zykgiJVGwuylwcXF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110048

On Wed, Nov 11, 2026 at 10:21:31AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I got another instance of a -Wmaybe-uninitialized in ntfs, as this is
> the only place that enables the warning:
> 
> In file included from include/asm-generic/rwonce.h:26,
>                  from fs/ntfs3/file.c:10:
> In function 'instrument_copy_from_user_before',
>     inlined from '_inline_copy_from_user' at include/linux/uaccess.h:184:2,
>     inlined from 'copy_from_user' at include/linux/uaccess.h:222:9,
>     inlined from 'ntfs_ioctl_fitrim' at fs/ntfs3/file.c:78:6,
>     inlined from 'ntfs_ioctl' at fs/ntfs3/file.c:246:10:
> include/linux/kasan-checks.h:38:27: error: 'range' may be used uninitialized [-Werror=maybe-uninitialized]
>    38 | #define kasan_check_write __kasan_check_write
> include/linux/instrumented.h:146:9: note: in expansion of macro 'kasan_check_write'
>   146 |         kasan_check_write(to, n);
>       |         ^~~~~~~~~~~~~~~~~
> include/linux/kasan-checks.h: In function 'ntfs_ioctl':
> include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
>    20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
>       |      ^~~~~~~~~~~~~~~~~~~
> fs/ntfs3/file.c:66:29: note: 'range' declared here
>    66 |         struct fstrim_range range;
>       |                             ^~~~~
> 
> The problem here is that copy_from_user() is called on an uninitialized
> object, but the instrumentation passes the pointer into a function that
> takes a const object. gcc deduces that any access to that object is
> undefined behavior and warns about it.
> 
> The only workaround I could come up with is to remove the 'const' keyword
> from these annotations, which of course is not great either, as the
> functions do not actually access the data at all.
> 
> This also found incorrect 'const' annotations in
> arch/s390/include/asm/fpu-insn.h, which writes to those pointers.
> 
> Any ideas?
> 
> Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/fpu-insn.h |  8 ++++----
>  include/linux/instrumented.h     | 10 +++++-----
>  include/linux/kasan-checks.h     |  6 +++---
>  mm/kasan/shadow.c                |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
> index aaf1faeb3dc5..7cd6e9f30485 100644
> --- a/arch/s390/include/asm/fpu-insn.h
> +++ b/arch/s390/include/asm/fpu-insn.h
> @@ -359,7 +359,7 @@ static __always_inline void fpu_vsrlb(u8 v1, u8 v2, u8 v3)
>  
>  #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
>  
> -static __always_inline void fpu_vst(u8 v1, const void *vxr)
> +static __always_inline void fpu_vst(u8 v1, void *vxr)
>  {
>  	instrument_write(vxr, sizeof(__vector128));
>  	asm volatile("VST	%[v1],%O[vxr],,%R[vxr]"
> @@ -370,7 +370,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
>  
>  #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
>  
> -static __always_inline void fpu_vst(u8 v1, const void *vxr)
> +static __always_inline void fpu_vst(u8 v1, void *vxr)
>  {
>  	instrument_write(vxr, sizeof(__vector128));
>  	asm volatile(
> @@ -385,7 +385,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
>  
>  #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
>  
> -static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
> +static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
>  {
>  	unsigned int size;
>  
> @@ -400,7 +400,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>  
>  #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
>  
> -static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
> +static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
>  {
>  	unsigned int size;
>  

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
