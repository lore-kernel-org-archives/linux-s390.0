Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AE843E9F9;
	Wed, 29 Jul 2026 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315431; cv=none; b=ZpbwmqqsnrgvRMR4M1pZHbMOQ2LVdfYBHRsfsneifCAABH734RiesEPwpQaE/dgxVGuVK8Tpwj+Qe+apxKUNHA/Za+Lh/2VJwIE9romiC1Pc8nVXPyLScouy4oxeTP/+kRrwE8l98r/vnk/hHnJtp082QAhiEu/eVLWpgC+0dsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315431; c=relaxed/simple;
	bh=ptDf5THOHnQ1gkk9zQAoG1xYEFM5CN0bQrZlHvSVZjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaY/uIehI7zmIooGeWMnqUOnlYmu5Uob4xeenZqSdUBI3ZquNMXGbT3Hdz/YGvmE1kJBqi9VlBgH+GK057BOhCHN2LkGHG/VHHHGEzTzHuE6DhW1y9nAV7SZfh/KgCPNfQWa9M1a+mtDAAJ7gCJgU+YOrv/OfbophEsuPkc47O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iGuy6lJf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iGuy6lJf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lnAk3507888;
	Wed, 29 Jul 2026 08:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0UfgQ5AWIbpDnI2W0rfe1jhelPa7d6
	NOD8rzf7H2i9A=; b=iGuy6lJf+8ASrigczWCaJA+PdLxv8QTZNYsp9aCz1GsiRR
	S37v7pMQiuYuy96YJ2E4D9URxQh32L5VKxUD49rv77bx0dO0uPswk7QJG3zkGE/I
	yjNOS/gl19gEyPqlbt8TEjoKzdioiCBQR3/lVrcIaevruufH7jLoCYZc/cpqmqcW
	AFBOWIvPdQXIyghyk34qJ8H7lE7CEdaaHKJoA5y0dRry547U3zmIZrzPoczc9dyS
	Sd819ljbt0m6LBCiA7TNcZxb/WJxIJG7QVn38GPPwv0tGncpuFP4G5fSqO/WKbxz
	SlCc6TXmgRz9EdfgVTrKMmBggVn9/5tRMTXUkOjQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ns135-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:57:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T8uIhb028853;
	Wed, 29 Jul 2026 08:57:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgdrm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:57:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T8uvu246596438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 08:56:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1544F2004D;
	Wed, 29 Jul 2026 08:56:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A149020040;
	Wed, 29 Jul 2026 08:56:56 +0000 (GMT)
Received: from osiris (unknown [9.111.35.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 08:56:56 +0000 (GMT)
Date: Wed, 29 Jul 2026 10:56:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Introduce arch_do_panic
Message-ID: <20260729085655.17504C1f-hca@linux.ibm.com>
References: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3MSBTYWx0ZWRfX5agoRB9FLJm1
 G8DXVwCTFHOba4MAF6ltzHGkRCTWKfAY+X5oC2ox46Xkj6gQ7/mXBOduSQHCEWJeVMttW8tzhJe
 Y6aqFTgo7IZzlZNqqIRKqzxFT8c/sEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3MSBTYWx0ZWRfX533Lz86FGQ3h
 mfYawr+Lty2G5nDAPabsTcLd7/Gkshf8m3V9iUW7ctUyerkKf2wBtReQxoHrTnrgchVSsdLGRi/
 5qPbENLfavZFKgIvoUsN3OPmY9FufWRuN1/arkKdAqY4L6cTjhsqRltqUdh7ZEZDoqH+fhU7U74
 6OKHRqf2vzzc8PxgND4uaJah780RGoYlFwcuP77MUKtTq9khOriIn776dT01kNQ+OAWnlw0Pxpa
 r7Q4xtOQoevWVJeD3lBVlQWruO4mL/uIHts66W118iBPzEtlfKoke4Aij/AyM/2Rn0BNh2kfJAc
 G5I7oZN7NP4iH6uin87N5qMcjknxkADNUNby+vf/BMEtMBl5VO5rDLWeHqqHwzsFZHs89jRQJ4+
 T+ewYk4KBrEtTmqBMFlNG1tpyqEZHz0G71xCvVMayq86xLkRkioYv8j0l6TK//oqODtl6w6q4Kq
 wW1TnABRLL2WwmX5/1Q==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69c05d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=cfSSHWZ1uO1NlKpTrO4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tGs2XFaAc5gfbU0gUwnL13djRWFEBs7o
X-Proofpoint-ORIG-GUID: tGs2XFaAc5gfbU0gUwnL13djRWFEBs7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290071

On Mon, Jul 27, 2026 at 12:36:19PM +0200, Mete Durlu wrote:
> Changes in v2 - Address Sashiko findings;
> - Patch 2: Remove unused leftover code
> - Patch 2: Mention panic_timeout and shutdown_actions relationship for
>   s390 in commit message
> - Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
>   implementation of sparc
> 
> Replace architecture-specific ifdef sections in vpanic() with a clean
> arch_do_panic() hook. Currently s390 and sparc embed their panic
> handlers directly in vpanic() using preprocessor conditionals, making
> the common code path harder to maintain.
> 
> Introduce arch_do_panic() as an architecture extension point called at
> the end of vpanic(). Architectures can use this hook to implement their
> specific panic handling without polluting the generic panic code.
> 
> Move s390 panic handling from the panic_notifier chain to
> arch_do_panic(). This corrects the execution order so that the
> panic_timeout is properly evaluated before architecture-specific
> actions. The previous notifier-based approach executed too early in the
> panic sequence. 
> 
> Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
> the preprocessor conditionals from vpanic() and place the Stop-A
> enablement code in architecture-specific files where it belongs.
> 
> The cleanup reduces vpanic() complexity and establishes a pattern for other
> architectures needing custom panic behavior.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
> Mete Durlu (3):
>       panic: Introduce arch_do_panic
>       s390: Implement arch_do_panic
>       sparc: Implement arch_do_panic
> 
>  arch/s390/include/asm/setup.h  |  3 +++
>  arch/s390/kernel/ipl.c         | 15 +--------------
>  arch/sparc/include/asm/bug.h   |  3 +++
>  arch/sparc/include/asm/setup.h |  1 -
>  arch/sparc/kernel/setup.c      |  8 ++++++++
>  kernel/panic.c                 | 18 ++++++------------
>  6 files changed, 21 insertions(+), 27 deletions(-)

Putting the define in a different header file per architecture doesn't
seem to be a good idea. There is no guarantee that this will work. So
either you find a common header file, where it is known that is (and
will be) included in panic.c, or you go with a weak function.
