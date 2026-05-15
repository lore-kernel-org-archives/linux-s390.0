Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2944C6F09;
	Fri, 15 May 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864059; cv=none; b=qCgUN+efilbb7JSP0ybPZ3sNqyDvfsgRE0geaSSWn4WO8+SNiEpyoXLWLLEsN9qmpwyewjeD9ttRrKnjJT5eSzN+ykh6d31B+a522ZT19UEF/uc42Dpr6P1gtmZJrmszcsQadfMCA3kfXIpxIRPXA5zf+/NS+2OKEUwnptBi3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864059; c=relaxed/simple;
	bh=Oq8sA+f5fwEz3Gbhe4/UQdT03Rgd/EdfMErxJReByvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQfEUrnwxZBVkIkuNV7Tt6KfYTx+DoWK33K4NtVLibMO+LNr1v53hYYl09cSjkhnocV6tHx+4nfe/gJ9aBsJfLZXhqJzM/+ItY/Xl8bq400w8edKYnLZZRjZ/ZUFFAOr+hTkho7PARfbVUtFpaVDuBM7WQ6Kv4w4a8Qj4G7T9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EZQk/eXo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EZQk/eXo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBSGSR576688;
	Fri, 15 May 2026 16:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3St4iq7uw2n4Oi89NYsuWxbE42N21e
	/j3GToZVButWw=; b=EZQk/eXo+BEb0EOqsQAgtBgWWQtdp4Ob9NcF72Kd4QRScJ
	nO5p7KGmUJ/W1mVxCLJ5fRN4N4TpHHLc58V38m3OpQP0qCqhXpmMt01hovITftJC
	jNUocNqv25eHPpJoA302c/eXT0tMlf5SXivdfDRIF1ZzAg4KWPALeUTQowygK5WS
	12fjcwW9/exzMsI3fYFF9fj+061fcp9UCucH8aN1tZjb5xASBquJztlWAv8a/WAx
	/GICNsPvsD/GsKd2Vd5+AU039rrvfzYAvBOn/YAhJTMs54ZIHaxDjy5SHANJEd6x
	a5KUlztwf1tp/BWPkZHYNph4okCOksSV/PjJmEeQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m92m3hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 16:54:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FGd96F026489;
	Fri, 15 May 2026 16:54:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcmea1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 16:54:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FGrxtg13107564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 16:54:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98A120043;
	Fri, 15 May 2026 16:53:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECAE22004D;
	Fri, 15 May 2026 16:53:58 +0000 (GMT)
Received: from osiris (unknown [9.87.152.91])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 May 2026 16:53:58 +0000 (GMT)
Date: Fri, 15 May 2026 18:53:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-s390@vger.kernel.org,
        Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
        Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Subject: Re: [PATCH] [RFC] ubsan: turn off UBSAN_ALIGNMENT on s390
Message-ID: <20260515165357.10935D74-hca@linux.ibm.com>
References: <20260515092057.810542-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515092057.810542-1-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MCBTYWx0ZWRfX0Sdgqd2mbOFw
 KkwpotWDkb5iMlunsj0AnCKrYChzb8Nxz9zKCYOeVw8wVOHFb7mGA5rcu7GnkjmJnGUqKeiNOT6
 nxhwTmcZWQ141Iwj3D/OEGSjVkmvfZwzlpzjIqqikeGpqT5brZ/sJ+megDwJVgLmSkZYy9RxDuK
 xOKcM8sPehgUsrWal/xaadErluJkpX0z+b1lq0P/iXZqGXF2CQFVrjhdyD0lQ22lz4q+EmRycMn
 d2XVL9awFqwzsZ72v+/8jl+nZDMgjZQ5RGuXlcfdcu2y0xvstUWHQPTDsJcRCErYc3RAXla+ugI
 m9PrJkp/7QIze9f1LXyVtsutKs+MnF/WG5PnDssxavt1cpXADFQ2oWfOc0u4zSHzCSBwc36/73h
 I3/RoJTjfNsBKlw0acbJgIr3W1RgdXkXhrVWNkq8nVz7PLOcT5HJPGrrXmZ3KOT8ySBqficZ6mP
 CkT9ClEpKnO3wm7hRmQ==
X-Proofpoint-ORIG-GUID: dFUWlXN3yEx0zRZhdfr_E6pX1tSmd4PZ
X-Authority-Analysis: v=2.4 cv=aNnAb79m c=1 sm=1 tr=0 ts=6a074fac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yuVE4MsfjvIhWQyEmLAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: AG3tYxTwIk-uHnozpkweqL_TBK0aOZF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150170

On Fri, May 15, 2026 at 11:19:54AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Testing randconfig builds on s390 with gcc-15, I came across a number of
> seemingly unrelated build failures that ended up all being caused
> by the -fsanitize=alignment option:
> 
> s390-linux-ld: kernel/sched/build_policy.o: in function `thread_group_cputime':
> include/linux/seqlock.h:1286:(.text+0x1f738): undefined reference to `__scoped_seqlock_bug'

Does this only happen with __scoped_seqlock_bug()?
I just enabled UBSAN_ALIGNMENT, and with gcc-16 I can see this too.

> What I observe here is a huge increase in generated calls to
> __ubsan_handle_type_mismatch_v1() that ends up thowing off a number of
> compiler optimizations that the kernel relies on.
> 
> I have not been able to figure out why this happens on s390 but not arm64,
> arm or x86, if other toolchain versions are affected by the same thing,
> and if this is a problem in gcc or in the kernel itself, e.g. some
> variable being identified as unaligned when it should be aligned.
> 
> This clearly needs more investigation to figure out properly what is
> going on, but turning it off is currently required for randconfig testing.
...
> ---
>  lib/Kconfig.ubsan | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 1ecaae7064d2..3fc03a6b5af4 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -152,6 +152,7 @@ config UBSAN_ENUM
>  
>  config UBSAN_ALIGNMENT
>  	bool "Perform checking for misaligned pointer usage"
> +	depends on !S390 || BROKEN

Wouldn't it be more appropriate to extend the ifdef at __scoped_seqlock_bug()
which emits an empty function for exactly this reason for some gcc versions
and kernel configs?

That is: add CONFIG_UBSAN_ALIGNMENT to the list (copy-pasted - white space
damage below)?

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5a40252b8334..18affa4d21a6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1259,7 +1259,7 @@ static __always_inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
 
 extern void __scoped_seqlock_invalid_target(void);
 
-#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN)
+#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000) || defined(CONFIG_KASAN) || defined(CONFIG_UBSAN_ALIGNMENT)
 /*
  * For some reason some GCC-8 architectures (nios2, alpha) have trouble
  * determining that the ss_done state is impossible in __scoped_seqlock_next()
