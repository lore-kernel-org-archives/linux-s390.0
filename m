Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1C51EDED;
	Thu, 15 Oct 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061831; cv=none; b=LAG67xj1Y9gJkHGG0JXACKJbdCIxqRyhQIxoAZ8VpQFIiAx51f081VnmMQ1zQpLDuLE2a7ajXWFzJ62bnadfig4QI8lar1CkmO0oUPk/wXNGteEJzFpUYAmI/i9LXniuFD3p79fbEdFdHFbpecpAu4t7CL9VCG7ahMm/oeI1Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061831; c=relaxed/simple;
	bh=0REL/m2y6i647azVBbE6Hi6dOXqodNeRc9FI3vDDqwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRWChcdRCvdPan6wQ2IESr9Su/kbqbns2cTI9Xls1d1cMWBN+xunWKWIz7SU63p1nyWVN7bsfLzxu/ITNTJFwjSKFtROdUBRHmG3EZagK9BRfN71xH5M8fe0viLfaRqEtnp4jkVBbtoCgZWFybOrAwZdhWvfhSKLM0yVQUwy5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkbyaOS/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkbyaOS/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kTNi3000992;
	Thu, 15 Oct 2026 10:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ucUN5G
	ZcjIlprFag9xgUmIk1e0Wn9pgsi38X6K0yHso=; b=DkbyaOS/6ejhVntQdg5DjF
	3cWGoHcnlgeOQpWGWcOQRGR5PlFLaI++rEneBcuqnNe8jd2/sd4F5NYMFi2jAAgj
	2QePkkYW2oO3RNe/umLJT9NNw5eVkxWSjF9ne0FGEP4YVGswDQGRr/rG0rapCmXR
	Ju8PgXHQUcn0omHPLOkUyrzY1S047VkDWKAF76MDKuIN+BbxiQ8vnFBqDiqH9XqN
	tnOxCjrrskKJKhhWzW09Kkot3VZMOoqkwPuyKEkRhSRQZBbNPunABvF0nw5LcqkJ
	8z66uzVQ4lPZUWXpxjm+4KwaoVmYhIotMZapQjJeois4lXyxVeFjGR1Aij4lEnYw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhsg33-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:56:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9nx3J1891223;
	Thu, 15 Oct 2026 10:56:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ys3kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:56:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FAus6m49938712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 10:56:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BED02004B;
	Thu, 15 Oct 2026 10:56:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD7CB20043;
	Thu, 15 Oct 2026 10:56:53 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 15 Oct 2026 10:56:53 +0000 (GMT)
Date: Thu, 15 Oct 2026 12:56:51 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org
Subject: Re: [PATCH v2 0/2] KVM: s390: fix ESSA addressing exception
 injection in migration mode
Message-ID: <20261015125651.558f2d85@p-imbrenda>
In-Reply-To: <20261015104822.77062-1-ggala@linux.ibm.com>
References: <20261015104822.77062-1-ggala@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX4ZyS7OqVAWSF
 1ZXGb878dkh5Ee062NngWGCkeo9CJ8OyWe39ibOdAmQzp+CW58y4XsjYGCb1QnJW/Fp3s7cGNNw
 mGq+xJqC+dTYVONj29Aoi9DBUWK/khI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXw//mw/py3z63
 g+EJ7d6sZG5eYVVMsknrRfikJsv2U5sMG+uNFe3KW26E1aNpFli+XCLftaifAF9rT0hTK46CHHj
 FA6zVGBgpXp1IQIZcL3u7U07JlFKb2r75b1eCuskRJOrY7BJcLEVssnj/OLs2KQ5mXwwbWD+1Qi
 tNzVpKp3S0kMePGrii2M8ZyTi5qXsRdOOM6tL8EAqdjWCsiBzVqTYwAociwW0RkH1HUr5FXhDyG
 ilv4vGdMZYdZBLVo5brIzTyyFkjZoR9Nm0ylV/trZP1niMW8i9YGNOGGzQFF7IIRyn4omSTx812
 15432BxoHM0M5OEChQ88eL3Z5GPHsttjS3MFNSBH7/9kGeQBhMCZbYYMwRCJfIa4W6GSvo3JhC+
 9J3wm/VCwXzl2x68iomvsDYtg6eyZ/i4YitQQGi6cSCV7ivDcGniLNMHP+/YzAqsnbSJZ23A5Dc
 mFim9oUYSBREc3bzllg==
X-Proofpoint-GUID: aNoMplhT1Du88ynDkgR4FIHOSyQP-0N_
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad0b17b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=ce-6K0IsK1CbvpNoDM0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: g9BzTdoVznsDwq7RDixPsVqEac5E2Q6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150042

On Thu, 15 Oct 2026 12:48:20 +0200
Gautam Gala <ggala@linux.ibm.com> wrote:

> ESSA emulation in migration mode silently dropped addressing exceptions
> when the guest page-table walk failed, so the guest never received the
> expected PGM_ADDRESSING interrupt during live migration.
> 
> Patch 1 fixes dat_perform_essa() to return PGM_ADDRESSING on a walk 
> failure, and __do_essa() to inject the program interrupt when it sees 
> that return value.
> 
> Patch 2 adds a regression test integrated into the existing cmma_test
> selftest.

Whole series:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> Changes since v1:
>  - dat_perform_essa() now returns +PGM_ADDRESSING instead of
>    -PGM_ADDRESSING; kvm_s390_inject_program_int() takes an unsigned u16
>    so passing -5 would have wrapped to 0xFFFB and injected a bogus PIC.
>    __do_essa() comparison and inject call updated accordingly. The
>    kernel-doc return-value entry is corrected to %PGM_ADDRESSING.
>  - Selftest: pgm_handler_c() now reads the actual PIC from lowcore
>    (__LC_PGM_INT_CODE) instead of hard-coding PGM_ADDRESSING, so the
>    test would have caught the sign error above had it been in v1.
>  - Selftest: virt_map(vm, 0, 0, 1) added so the DAT-on guest can
>    access the lowcore to read the PIC.
>  - Selftest: PGM_ADDRESSING, __LC_PGM_INT_CODE and __LC_PGM_NEW_PSW
>    constants moved to the shared s390/processor.h header.
>  - Selftest: SIGALRM/alarm() timeout wrapper removed.
> 
> Gautam Gala (2):
>   KVM: s390: fix ESSA addressing exception injection in migration mode
>   KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING
>     regression test
> 
>  arch/s390/kvm/gmap/dat.c                      |  5 +-
>  arch/s390/kvm/s390/priv.c                     |  2 +
>  .../selftests/kvm/include/s390/processor.h    |  7 ++
>  tools/testing/selftests/kvm/s390/cmma_test.c  | 69 +++++++++++++++++++
>  4 files changed, 82 insertions(+), 1 deletion(-)
> 

