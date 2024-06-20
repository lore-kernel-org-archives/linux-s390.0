Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67091802E;
	Thu, 20 Jun 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876110; cv=none; b=k3pbjT5wEM/6zvkwhLnwnl9lqlCdXWiRdsGZOi6QqYSvBPcwCybJsLjpcbdqtEm69+9QABWYI1+r08RThRNL3V2LAn+wAFwQgCP/x9wKH8Q404Qns7fg0vYSDao/Rgd4JZdyh48hp83Xex9ixSRuOjRXnWy5p7U1hr9oWk8ltP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876110; c=relaxed/simple;
	bh=B/Xras0wqNujWBrS/FfQokJI4n36WjvL+zxvpGpzB9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IdQi2GVjAZACPUXdxD5gBC+qlCIP3SedWTamzwW2J9ZvbFa6BtYy3JIGqZ47xUv1pJTLGfFSajrsdVh7JDfIK5tMPwoI4APHr4lbVl0wpn299dx+MqLy4hxfc1BhL4jYUMaffT3nWpuBCxYXek6YIjGjXGTGevNB2f8t7PkYouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BJiiteA2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BJiiteA2"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K7QMBp028247;
	Thu, 20 Jun 2024 09:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=8yLhV3Q1jPtG9/ip4DkXHhmDylT
	rROEu81cZ82Q9xuc=; b=BJiiteA2XiDtMQ75ZRjOaiw4f1epm8QxEscalu4qt7T
	nPNAQeaUgqui/5Ew9u1FE/WbHLvjyhjSQsyO4JE+8nzlMNXNZonzs3iX1UxOdQW/
	fsUkQ5VknoEIe/1w1gW6RMISzyeQMynp/gr/O+wOwSA09FJUYw77QOEVF22vaEaC
	KT0RUnK6jB/QAwo1HlMzrIEVxfuJhSfpt13lThGW76AsBUxBSHAmwS6jQWDZX84t
	heLMI7jLBujWzj2FrEn7qhRjI5lS7tgSubgkEOlxr8WNZEQnjllg0u43tAdQoPUC
	ef1LTnODRdppx69V2wxNEgig0Z2eTy1AojP26GLef0A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvf6prg0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:34:26 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45K9YPBS031239;
	Thu, 20 Jun 2024 09:34:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvf6prg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:34:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45K87Grt019567;
	Thu, 20 Jun 2024 09:34:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp1mtfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 09:34:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45K9YIHY50069970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 09:34:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F7592004B;
	Thu, 20 Jun 2024 09:34:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF6620043;
	Thu, 20 Jun 2024 09:34:18 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Jun 2024 09:34:17 +0000 (GMT)
Date: Thu, 20 Jun 2024 11:34:16 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
Message-ID: <20240620093416.8127-A-hca@linux.ibm.com>
References: <20240619214711.work.953-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619214711.work.953-kees@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nq2142b1zTEnF-2JrlN2ZBXbmbq493Iw
X-Proofpoint-GUID: Iy1wvgtfcOU06jkae57Q6f-fdZoagx5t
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=780 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200066

On Wed, Jun 19, 2024 at 02:47:15PM -0700, Kees Cook wrote:
> An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> Improve entropy diffusion") was that the per-architecture entropy size
> filtering reduced how many bits were being added to the mix, rather than
> how many bits were being used during the offsetting. All architectures
> fell back to the existing default of 0x3FF (10 bits), which will consume
> at most 1KiB of stack space. It seems that this is working just fine,
> so let's avoid the confusion and update everything to use the default.
> 
> The prior intent of the per-architecture limits were:
> 
>   arm64: capped at 0x1FF (9 bits), 5 bits effective
>   powerpc: uncapped (10 bits), 6 or 7 bits effective
>   riscv: uncapped (10 bits), 6 bits effective
>   x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
>   s390: capped at 0xFF (8 bits), undocumented effective entropy
> 
> Current discussion has led to just dropping the original per-architecture
> filters. The additional entropy appears to be safe for arm64, x86,
> and s390. Quoting Arnd, "There is no point pretending that 15.75KB is
> somehow safe to use while 15.00KB is not."
> 
> Co-developed-by: Yuntao Liu <liuyuntao12@huawei.com>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Fixes: 9c573cd31343 ("randomize_kstack: Improve entropy diffusion")
> Link: https://lore.kernel.org/r/20240617133721.377540-1-liuyuntao12@huawei.com
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/syscall.c          | 16 +++++++---------
>  arch/s390/include/asm/entry-common.h |  2 +-
>  arch/x86/include/asm/entry-common.h  | 15 ++++++---------
>  3 files changed, 14 insertions(+), 19 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
