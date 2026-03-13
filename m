Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17315376BF2;
	Fri, 13 Mar 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773396628; cv=none; b=LR39c6+DjnEJy48WXnOAci7fHOfmoLXMNjt51+tDlfSP3cyG2NjQtwHrCf3hsjH9j0aPWjNfl1i4zvAxhnyAanWtAeKgnnwoSafhV77PhA66/LqaE2s9hYcwn5dZTezQO9KgHg/O0If0bNAJWb2cNM1wCHgRGp+h6iTsH54BjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773396628; c=relaxed/simple;
	bh=q2nbDrcypeA9nb3qP57JeKDZcGA2Fph1iY9VQwcGwvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmWZoxtaXyleRXw7/5AigsbtfRRsaj58jie1l6fRFthUWpIA8lHfCIlrEOglY/6KIsXB20bQlXgI66vziKYTkj+PHsu71hASaLfZOq0uh55uYDCnpwdHkj65VY50K6JjptTyRvC012mPYwtfKglNOYpJVf4GdayXwOe0QqKJpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AqxpL5EL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AqxpL5EL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5svNb2279407;
	Fri, 13 Mar 2026 10:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Y5ISSpRb1O8saxC4lfm04hKl/Kldja
	lJtB+bE/BKifY=; b=AqxpL5ELsmxQ0aDfl1yO4WEG3u/OhperAHKLT0hHiSbWaS
	HizG4bY6tySbEuuTwtUx57xttlJSCYFhz9aFX6ewI4eEMj8aM54iMSejwk7/5Rnd
	SqPUwVgrvPlPrNrSiiXhC7cvW69tNVGbfuQQqgKP4fMW/ltb+1g0unoNJwYO2+VL
	Js3whRoMfRdUzUJcz0FBtDS/iLJE7Wp6FIbjl2mzc6HeUKAouyDrKBZGQkQOPovy
	DXQ8uthutDNQpik6FTn2sDQVKbjOQBHFLlUfMpAJdBvt6DJxIClL4RUskur+nF5s
	7V9szbifgGioSfQA7loVBQRWa6vFEoJei8A9Tqug==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91q6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 10:09:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5JuFF020823;
	Fri, 13 Mar 2026 10:09:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9p5hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 10:09:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DA9OSL42139930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 10:09:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2410B20040;
	Fri, 13 Mar 2026 10:09:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21A82004D;
	Fri, 13 Mar 2026 10:09:21 +0000 (GMT)
Received: from osiris (unknown [9.111.5.66])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 10:09:21 +0000 (GMT)
Date: Fri, 13 Mar 2026 11:09:20 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
        shuah@kernel.org, kees@kernel.org, luto@amacapital.net,
        wad@chromium.org, kevin.brodsky@arm.com, charlie@rivosinc.com,
        macro@orcam.me.uk, deller@gmx.de, ldv@strace.io,
        anshuman.khandual@arm.com, song@kernel.org, ryan.roberts@arm.com,
        mark.rutland@arm.com, ada.coupriediaz@arm.com, broonie@kernel.org,
        pengcan@kylinos.cn, liqiang01@kylinos.cn, thuth@redhat.com,
        andreas@gaisler.com, schuster.simon@siemens-energy.com,
        jremus@linux.ibm.com, jgross@suse.com, mathieu.desnoyers@efficios.com,
        yeoreum.yun@arm.com, kmal@cock.li, dvyukov@google.com,
        akpm@linux-foundation.org, reddybalavignesh9979@gmail.com,
        richard.weiyang@gmail.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 10/12] s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
Message-ID: <20260313100920.13729Bf7-hca@linux.ibm.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
 <20260313094738.3985794-11-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313094738.3985794-11-ruanjinjie@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: H4ELXjqqSrg0HA1e_zdfByUhlL4BUfwg
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3e25a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=Faxj65_8-bvmV7BNHo8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA3OCBTYWx0ZWRfX2tppFx5LmEx8
 xb+bd+acOJVlwpEccEbR+hI/SKYs14uHyxQMbERTaSgx31HRpHqW5tU3kLWak+fQWKfKPH+AQC9
 QggyfFjyyavLSmSn+j3gUuqcoV65rzSvTXK60cjTshKx42oBtRq4hU9hXXR7G47m57Y9cqb6SJo
 AjFAecRRJdhUBkFU4XKCOap4eI0LozwOewVfIJ8e/xlU7W1iBigGIw4CYlK1Ch6KDWyELSD4Yyq
 Yo8/fc6aj9oVmIl60tij8By1/7pXP4BJDI/mQ4ry4p1IQzKqEvtNBZEnLRiEs49+48CyDBCFP+R
 cjeEptLXGS6KKo2pR0ts2ihWtS9nUsnXkijkB9FJLez7r2VK+esO8wEeE+uu71DY8pvOr+2XNN6
 G37tgjgQa3ZUqf/SvRgYhBU9nRLNrrlT1gSDokptZAjf/CND9ll1tAc+jr5vzMd96nE5ozwzutS
 zfzkP0L1b+CA3dMgd8Q==
X-Proofpoint-ORIG-GUID: o8Yb7OdfJh2No2smJWpH5G6Fb3d4P4-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130078

On Fri, Mar 13, 2026 at 05:47:36PM +0800, Jinjie Ruan wrote:
> Rename TIF_SINGLE_STEP to TIF_SINGLESTEP to align with the naming
> convention used by arm64, x86, and other architectures.
> 
> By aligning the name, TIF_SINGLESTEP can be consolidated into the generic
> TIF bits definitions, reducing architectural divergence and simplifying
> cross-architecture entry/exit logic.
> 
> No functional changes intended.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/s390/include/asm/thread_info.h |  4 ++--
>  arch/s390/kernel/process.c          |  2 +-
>  arch/s390/kernel/ptrace.c           | 20 ++++++++++----------
>  arch/s390/kernel/signal.c           |  6 +++---
>  4 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
