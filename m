Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915C413797;
	Thu,  6 Aug 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005533; cv=none; b=Mgdu9gFuD9eiyFH+oQCOuyxkPKREZJUA8uLfCWacrb5ZZmLuxEPMdHg0uqMunjuCDFYVEmwdD4f2ljN7OM1D51DzW3Tjve8MZ96MpQPcxNkSD1Y9WzXQy1VRMtJ8NRY0AevJ2WiUF7qjjTnkbTwIl6kFYSRje7rwxuShs2dmiqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005533; c=relaxed/simple;
	bh=Zi5tPX8McKmkUPQ2guqiccHwBSqx5bYVi2SrW1eztzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax+whm7LAgzSiIEtnTMWLc990GS3QB2OSmEuUtYe+mKvL1ovf2DXzmNmRbO/KvW1BtFUMI6FKZtUIKvq6M7/kCVCHZgyFlTBMW2BufV3DaoONoMrgMpNa3gKPaVO3JXvS1F65/Fv36Dr7aGtXPaW39WKJ06zu8X4OZqVfwZHDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJk5FxS1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJk5FxS1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlneH993299;
	Thu, 6 Aug 2026 08:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7TdmHi
	13/JX9qHR3swM4b376hu/I2VsrAqmc23uvSjs=; b=TJk5FxS1IrFDW0KhYNTHbj
	npjqfXrRRk2MC4rSFtlOBUhjtrfe5e+qBblrlubOgwxKC9jbdlqx1gncnRHA2S7K
	oDUSaF2thqju2wUffoyjGUnNoP6GTwIlxGKHwFsvztToqlmUDMfLwPU6d/z+y0GF
	+4MI5hGLW0f4s85TOeonaG2hMHSv6l1x7LITYHPHOb0BRRaWfJ7QLNkax27q3zYy
	db0nJ8heziFII1Zmi6H53axWoWeNZ8lJQzzY6RC1KXqYG1P+spIzYb8dcoaerqpY
	NwKb4huCuBAmcqcA7DkF2DBUcbiHitiLPe5aUooCC9ITdGIsWZKEggAO4rBe8oFQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ges8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:38:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6768BFao004526;
	Thu, 6 Aug 2026 08:38:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwag4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 08:38:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6768cYDf42861006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 08:38:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05A972004E;
	Thu,  6 Aug 2026 08:38:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E692004D;
	Thu,  6 Aug 2026 08:38:33 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.11.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  6 Aug 2026 08:38:33 +0000 (GMT)
Date: Thu, 6 Aug 2026 10:38:29 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, nrb@linux.ibm.com
Subject: Re: [kvm-unit-tests 2/2] s390x: skey: Fence TCG protection checks
Message-ID: <20260806103829.4265e613@p-imbrenda>
In-Reply-To: <20260804142133.1745878-3-frankja@linux.ibm.com>
References: <20260804142133.1745878-1-frankja@linux.ibm.com>
	<20260804142133.1745878-3-frankja@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA2MyBTYWx0ZWRfX1QkS9J2aQ8ot
 hXRsnI0vif2LUM146t4IhY8KqawgDcJfDgj13AlhcYS/Xq9YJ88Z5btu9hauD049aIm+l6SnxQ+
 4ibe6itIcgV/NRj52jniFRjlSVfwA32lEhUpXfS2WqSShIy2ZyfYE4rL7o+xDwa5N08pyv7cNgO
 9pbBEIItPEVy2AAz7KpIbTItff7bcskPSZ1BtQ3YJNqThyjZ5GT7Mg2kWQ35tRIOUvlGFNZdHJJ
 s6F/AJA3m+xx/u8mkw6JEh7r1YfzBbj18TaqWcgYM+cRQoHRNo9x4JKNftYnUocqxvTh+eyzDMh
 gyw8FDmUe/HBzVMJyf0LMwBZSMygFBg5lEHz+xVvV5IjDxIbyFCKPf01OJ5QA873VxTvueik4Dq
 MB1XmvPbm9uArwcFtJpA0Dlq+gNFk3dFO8ghXP32+wXchFo4VdbMokjABkBrfBYHuJKaLphvIN6
 dngY3RInLCxDcn304VA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74480f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CllH9XaH7VEC85Y1ppIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: W7dbGzFksX2j7EGznZtwiuarPEtGYZro
X-Proofpoint-ORIG-GUID: W7dbGzFksX2j7EGznZtwiuarPEtGYZro
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA2MyBTYWx0ZWRfX3GNzh8wbXQqv
 cvEpLz+0ka7PyrFp5kz4m61TXsCd7ZHGliHNw/J6lDV3KopxqvZeyIXylGbHLJa+T1EW5f/Ti1R
 mgjQYsFEs3WZqmQJj9OY/SPUVRvVfz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060063

On Tue,  4 Aug 2026 14:16:29 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> TCG does not implement the skey memory protection, skip those tests
> under TCG instead of filtering them in the CI logs.
> 
> This way the test will PASS when run by humans and there's no
> confusion why it fails anymore.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  s390x/skey.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/s390x/skey.c b/s390x/skey.c
> index bb769730..1fc95857 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -14,6 +14,7 @@
>  #include <vmalloc.h>
>  #include <css.h>
>  #include <mmu.h>
> +#include <hardware.h>
>  #include <asm/page.h>
>  #include <asm/facility.h>
>  #include <asm/mem.h>
> @@ -736,6 +737,13 @@ int main(void)
>  	test_set();
>  	test_set_mb();
>  	test_chg();
> +
> +	if  (detect_host() == HOST_IS_TCG) {
> +		report_skip("No actual access protection in TCG for skeys.");
> +		report_prefix_pop();
> +		return report_summary();
> +	}
> +
>  	test_test_protection();
>  	test_store_cpu_address();
>  	test_diag_308();

