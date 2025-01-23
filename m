Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D273F320B;
	Thu, 23 Jan 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620970; cv=none; b=P4eseZPiY9K/EXv4izU1RKU4jTvSQvPX9xGR+USCDyuuMnxug4mlHAwYlLQcqwM5/g2J4RZr17nDj05LcD8+4FwNTO2sO/LRerExAA8VtqZD47VdvL+qUd2vnCB2xkbswfA/2AWDQ0OE5DF/SyAXbqXlpPY5bB1AuEf2KFxwIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620970; c=relaxed/simple;
	bh=el8JnaocJDJNIilZYYosfyB/Py/zF97+bTAl1MHRrF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlKLeZlWQxHymZyLJWt3zIxsB8qHJuZqp5W29hYUWzptgsiUbCwnYH7J0CD/1tn6hduSxC5BFllL3+FBqluokBuXhxjuQhoSd9ufxt+TqrVGpsu5P07OtMHrgNprHH9HDqIeAxsl/hqVjxW2eV1f8XXOrhXepf4VuEAqjyI3kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gaeFDqI7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gaeFDqI7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N0pflP027435;
	Thu, 23 Jan 2025 08:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IGbsc4XAXu1kKgqrUkSDfxp8jL5aoV
	XaWpN/kwBrMQE=; b=gaeFDqI7wY/rC8UHBu6tocSu5O/OBAIFm+4NEg3PqZykxY
	FEFd/FQReodL+Y0CeEhEXTl1ttL3fEuQlJsfwbFTnMjt6W1p3nw0vJVtjlVGz7fE
	XaGTUzM2nSoU4ZSRP7BYVnjEKtehMARxTYDxhOA1FeH/aIlpJ/rhsyEdEf5GuChk
	N6bwD3VRLZiLhP+l4ZyiXQr+dnyaUPzA8okWzkiLr11Ph2mlmlGrGpWyx1DBlbDV
	L9AO8nqbu2fzzPrCKxwMadbVjHditn90OpsG/BVduxI2G7hy0W0EJWzJIwmmO3+c
	lxXjbUO2bDoWOs64PHqDOliVuuYl6J81ldbk5KWA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xym9ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:29:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N6g88t022387;
	Thu, 23 Jan 2025 08:29:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kcga0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 08:29:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50N8TKRV22479304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 08:29:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFC7D2004F;
	Thu, 23 Jan 2025 08:29:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0EF820043;
	Thu, 23 Jan 2025 08:29:20 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jan 2025 08:29:20 +0000 (GMT)
Date: Thu, 23 Jan 2025 09:29:18 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] s390: Add '-std=gnu11' to decompressor and purgatory
 CFLAGS
Message-ID: <20250123082918.7753-A-hca@linux.ibm.com>
References: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RUBcS27Ia6SlVPsDpbvhLACxwgzBbFx3
X-Proofpoint-ORIG-GUID: RUBcS27Ia6SlVPsDpbvhLACxwgzBbFx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_03,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230064

On Wed, Jan 22, 2025 at 07:54:27PM -0700, Nathan Chancellor wrote:
> GCC changed the default C standard dialect from gnu17 to gnu23,
> which should not have impacted the kernel because it explicitly requests
> the gnu11 standard in the main Makefile. However, there are certain
> places in the s390 code that use their own CFLAGS without a '-std='
> value, which break with this dialect change because of the kernel's own
> definitions of bool, false, and true conflicting with the C23 reserved
> keywords.
> 
>   include/linux/stddef.h:11:9: error: cannot use keyword 'false' as enumeration constant
>      11 |         false   = 0,
>         |         ^~~~~
>   include/linux/stddef.h:11:9: note: 'false' is a keyword with '-std=c23' onwards
>   include/linux/types.h:35:33: error: 'bool' cannot be defined via 'typedef'
>      35 | typedef _Bool                   bool;
>         |                                 ^~~~
>   include/linux/types.h:35:33: note: 'bool' is a keyword with '-std=c23' onwards
> 
> Add '-std=gnu11' to the decompressor and purgatory CFLAGS to eliminate
> these errors and make the C standard version of these areas match the
> rest of the kernel.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Thanks!
Tested-by: Heiko Carstens <hca@linux.ibm.com>

Alexander, can you pick this up, please?

> I only see one other error in various files with a recent GCC 15.0.1
> snapshot, which I can eliminate by dropping the version part of the
> condition for CONFIG_GCC_ASM_FLAG_OUTPUT_BROKEN. Is this a regression of
> the fix for the problem of GCC 14.2.0 or is something else doing on
> here?
> 
>   arch/s390/include/asm/bitops.h: Assembler messages:
>   arch/s390/include/asm/bitops.h:60: Error: operand 1: syntax error; missing ')' after base register
>   arch/s390/include/asm/bitops.h:60: Error: operand 2: syntax error; ')' not allowed here
>   arch/s390/include/asm/bitops.h:60: Error: junk at end of line: `,4'

That is I bug I recently introduced.
The patch below fixes that. Thanks for reporting!

From 2f58027ec1302714bb4d728b08dc5c88498d18b1 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 23 Jan 2025 09:14:15 +0100
Subject: [PATCH] s390/bitops: Use correct constraint for arch_test_bit()
 inline assembly

Use the "Q" instead of "R" constraint to correctly reflect the instruction
format of the tm instruction: the first operand is a memory reference
without index register and short displacement. The "R" constraint indicates
a memory reference with index register instead.

This may lead to compile errors like:

  arch/s390/include/asm/bitops.h: Assembler messages:
  arch/s390/include/asm/bitops.h:60: Error: operand 1: syntax error; missing ')' after base register
  arch/s390/include/asm/bitops.h:60: Error: operand 2: syntax error; ')' not allowed here
  arch/s390/include/asm/bitops.h:60: Error: junk at end of line: `,4'

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/r/20250122-s390-fix-std-for-gcc-15-v1-1-8b00cadee083@kernel.org
Fixes: b2bc1b1a77c0 ("s390/bitops: Provide optimized arch_test_bit()")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 15aa64e3020e..d5125296ade2 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -60,7 +60,7 @@ static __always_inline bool arch_test_bit(unsigned long nr, const volatile unsig
 		asm volatile(
 			"	tm	%[addr],%[mask]\n"
 			: "=@cc" (cc)
-			: [addr] "R" (*addr), [mask] "I" (mask)
+			: [addr] "Q" (*addr), [mask] "I" (mask)
 			);
 		return cc == 3;
 	}
-- 
2.45.2

