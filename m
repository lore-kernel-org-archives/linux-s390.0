Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE722882A1;
	Thu,  5 Feb 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277626; cv=none; b=bk7VBEa6M6TE+HuL5+haNF9Fw3QiBElBFVnx0f1XY/HQWHYfUwIHc4N5BiVm8o2Zg25wgvT/gKbG43+A34ZBEGx8xkIGqKujEI2Rc6nGfD/byZlhxxIsv6dGtjGPzz/1y0Qc5RuIkfLpwbJK+JefAobgmdRJKFeH6+/ULkcZlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277626; c=relaxed/simple;
	bh=CdHthMfTV3blGIt3vEXH9N5dF080yF7yl9/oZV9NiOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNuOEp5DwCCb1UBve5zAnjzfXs0guXUNwYoWZ2UDBslGu0TxLJCc6uuZA/dRDp7Hh19+8VqkCCmduTvcNfWJ43Sj/2HD5gw6lh0RshlCnTDtl9T7ufGk/s1LZW/q2c3jHpBOhYRCNDZjV7B6kredFwjee2vsA2btt4IhWbTs7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qR5P64up; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qR5P64up"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614FOe27024273;
	Thu, 5 Feb 2026 07:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ya4jqmUPXJD+F4jInYa5I5CLnE1k1S
	1QgWIVq2esQW4=; b=qR5P64upz7VXcUlIbVWi16G1l2sdxdrkV3bqmeeMdoOFZZ
	B4Xy1Xrt5Ed7lZ4gROjwhJ4C053ipCU/drUHbAch6g1RoJ40MfOTyPj/a66F2Onv
	Byo4fT+FpcKbdAuIBG7ZlAbEvZbKNMjUmlYG09Po6q7p7frgU3eekIF8dEZLIVdc
	3OYgT6O/WLQrMmJEHC6vu0GQhwh0BPp5Aw5YSSI+KSqjLBcKKLHzMXM5kijPzU3M
	DlfBq9kS85Yuv8oFZUP+CVBjZjdMlwvcV8GbGCX+y2obP5d/1JS1eg7D9pLmk34U
	9KZ77E/o1dIwTTf1AVdIS6sWXNimwBmTATqysNDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6nrw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 07:46:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6155F6n4029421;
	Thu, 5 Feb 2026 07:46:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2sgxr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 07:46:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6157kjFD16646594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Feb 2026 07:46:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1ECE2004E;
	Thu,  5 Feb 2026 07:46:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 864B820043;
	Thu,  5 Feb 2026 07:46:45 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Feb 2026 07:46:45 +0000 (GMT)
Date: Thu, 5 Feb 2026 08:46:43 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: remove kvm_types.h from Kbuild
Message-ID: <20260205074643.7870A22-hca@linux.ibm.com>
References: <20260203184204.1329414-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203184204.1329414-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F0CIZpINk2qDP_L5XkpmeGCSXahZnAWe
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69844aea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=8U5ieTTLXTJNdKsuqekA:9 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: F0CIZpINk2qDP_L5XkpmeGCSXahZnAWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA1MSBTYWx0ZWRfX2S+MiMqM5Tdb
 J0Nx1+y49i0Y1tLwtbZxbmVStKLgb+hZbo4TYKodrP8PuBD28EI/cw+EU+m5Ih2QuSC4ZS9zBhD
 WSpR2pJjqO87+WuIDtiG0NcXmcaFWmG4SQUe6TKhYUDUw2uotd09kZB45w0k7GoGyqgmhsrYXNg
 2bA0pNKxCJzMTi7r9gdoYHvV2m5TV8GqJFQyy7BwX2DBRYrFzbsfpN0UqBpzCr1I5Ls8PHi4Poi
 yAGqR6xLFW4F8qyPdBLfDEFcD0bH2joSVPSPQgV7Gq3025MOSjleVmMpXDSYDQ17C5GIx6bsAnu
 tab6tHEPV2FBYr2hEFdPSOh/NxVOK4Acm+JL+oxDXKc2H4qsXysP5SQaWzq53vZxB9cbJl1SFNr
 bq8eH1/QpH6yu8TgWpAd49whraqLzmKGtuY5xyDvIr4FdZZpbxcdRTBO9doujxgYjxurL7OL8zP
 fW6aaZY7A7oJeWQpAVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050051

On Tue, Feb 03, 2026 at 10:42:04AM -0800, Randy Dunlap wrote:
> kvm_types.h is mandatory in include/asm-generic/Kbuild so having it
> in another Kbuild file causes a warning. Remove it from the arch/
> Kbuild file to fix the warning.
> 
> ../scripts/Makefile.asm-headers:39: redundant generic-y found in ../arch/s390/include/asm/Kbuild: kvm_types.h
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  arch/s390/include/asm/Kbuild |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20260202.orig/arch/s390/include/asm/Kbuild
> +++ linux-next-20260202/arch/s390/include/asm/Kbuild
> @@ -5,6 +5,5 @@ generated-y += syscall_table.h
>  generated-y += unistd_nr.h
>  
>  generic-y += asm-offsets.h
> -generic-y += kvm_types.h
>  generic-y += mcs_spinlock.h
>  generic-y += mmzone.h

This should go via perf/core from the tip tree, since Peter's not-yet upstream
commit 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the mediated
APIs") adds the mandatory-y statement to include/asm-generic/Kbuild.

Peter?
