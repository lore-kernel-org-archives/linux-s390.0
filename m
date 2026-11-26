Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684442;
	b=Kckm+msCOhd36/BNmMnpYQz4CtNwfZ86cSr25AGmJHlVYwn07Xf1tQOwwAtDR/uqNTwo
	 IDlQsm5jW3TyDPwPmD3TXdpXaOLPDcNHz8A6cuVVNU4XSqcIo62KtaxnMAPXMK45yF48W
	 hWKKcR+kTDn+7knigjuP/INLuAM4zQyMRUZFBuTv4NLF4ZDoYqFjJrYJ10L6/vSaRNN0r
	 mYMPsV+e6Y4ErPJk9h7MafXIwrLtLQc0iYn+Ez+jCpcQE2h3F4n+fAAPJ/qCWeR3y9Kaf
	 epCC2OefefAFS61o6oee/BIV7u6MhJtsM2qS60k2HVEXcJVGCVxwL8cPJsJmwHAJsWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684442;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vZoNY4J2XfOqVAVfCTxllGnPnfy/9sUb/hOJLoDliJQ=;
	b=zRw4+G93hJcg7AwGQ6KHK9QiYpz22G5kSKbyynzZVqeUuOZBmDoQoCVboEN73dZq06t8
	 ytrvaqrZpkqBPtzez9aCplvxkYrrlg5hHrJoYvjMZyPXwug3VW8yMw1074BP16fHMOXUk
	 0I5ExDxbuU6VQ1CvPKmnmYMUrjWL8VrXUC1jgXxF0HvOXWs8zpNxhtLYSusshn6mjkAHI
	 5O+Co6z+zwShJgr31g5wi2eUfcHyIXKgWss8KQpIA5xnX00BhcBbBdhxbVu9CJ5fCFvut
	 AefBAZMq8Aeq07s/I/J/d7gKItN9kQfgdOof1YkKqnZZjQGUz+IAPbQtjeEcmXevVCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="PM3znO/a";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF45606A31C;
	Thu, 26 Nov 2026 09:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF45606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PM3znO/a
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YfOA3658974;
	Thu, 26 Nov 2026 09:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vZoNY4
	J2XfOqVAVfCTxllGnPnfy/9sUb/hOJLoDliJQ=; b=PM3znO/aLKks8NgMCTvxGA
	/eA9zLTjAiOxhyETIxNtpBbac1QBB1FC9Q/fV9mFod7d/exdU4JMPlRWxyNiL7mF
	J6QXoxaepvXXnEWKfl0+OmBXvbjbydLRdDkbWsayI33ibTopVvEdekP+efS8TL6A
	dgsB5EbI7aiNOzpQslHZc8Vh8CLgw69qbk8fu9wAYCrxEaCL3r7YKLiv3sloBvWh
	oIbSJT+GoFlOOd8fdLlqlIO2M4eFIhqJVgY+X3S8YTO2Quo/3eXJ15r8vR4XygfD
	lVRszGc4b8AJN5EsV855yNe0OuIuamQZkBGcoC/UD6IMxwHuT3xvzNBWdDv8ceog
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvg2m0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 09:13:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JGMr3386680;
	Thu, 26 Nov 2026 09:13:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a417gwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 09:13:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ9Diff47776026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 09:13:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85FAB20040;
	Thu, 26 Nov 2026 09:13:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15E122004B;
	Thu, 26 Nov 2026 09:13:44 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 09:13:44 +0000 (GMT)
Message-ID: <d19de976-aa6c-4168-856d-b65e96eabe88@linux.ibm.com>
Date: Thu, 26 Nov 2026 10:13:43 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: Add a test for nested guests
 in ESA mode
To: Yvan Janssens <yvanj@cyber.gent>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125165604.3074595-1-yvanj@cyber.gent>
 <20261125165604.3074595-3-yvanj@cyber.gent>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261125165604.3074595-3-yvanj@cyber.gent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b07f84d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=iT8M5YjzDwDgK0uH:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=4nKcqwHAdgOrSOTCE1kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNSBTYWx0ZWRfXygJ6SuRK29FT
 cwXrSOT1Tqul/ZTeoU4DkRzGFLUJKXQ4+/DbGKncV+XU7h53NLdW6oORy7x2G6V08AzUNPZlGJi
 3WPUZlXLorXmOCAND6kIWhWzdLcGOu8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNSBTYWx0ZWRfX3TFHXFiIWxy2
 3/m4VpnCDHR+3mSpU/GukPn60nXfuNUPi6dYct71lICZnnSOH1bo5hxyKErKKqfGLDD9j0jnS2U
 0o9yU6/E9BQKgWzfTJ9wCOxLHjgl6Mjhp6Xx6f0dKMBohCD9+ABx69YN+E1zbpKBkIdAs1r5Tgs
 6fAGzkrXjlaBG7xedxEP+hNf4XMs5fiGQsUKSuwLWaZH5Hofi1HjiKnMjMEvyrqJdNs2LdL+nw3
 0HXgs5WMJFotVGzqkH0H76l6Tb+VATOufa/ik+vhemVnAZ9Hfxamb8tcaFppx/RyI5ShCTwr+7O
 Y1iui75t1iQBjgi7B5iMjrIF/dEoeWTWisbbs7dKk+LfI+l4zryt3YcHRLFkd9FjwldGENx18ib
 18QZO1d5iOYh2pfkkrsTx4DXRVxwRpxJunI/gTxYo9wYj3rYWBEsRsijR6tfjj4xqM4dirIX0/m
 WOhNRuZvrlE1XLrENNA==
X-Proofpoint-ORIG-GUID: V1KHpE5rQgT9y7dED-Nhb3RIhxU-9_hM
X-Proofpoint-GUID: tl9KmaoLWI8Cz60VPl6aqgu1JxS2iSCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260035



Am 25.11.26 um 17:56 schrieb Yvan Janssens:
> Run a nested guest from a state description without the z/Architecture
> flag, with KVM_CAP_S390_VSIE_ESAMODE enabled, and let it execute STORE
> FACILITY LIST EXTENDED twice. vsie intercepts the first one of every SIE
> entry to shadow the facility list guest 2 designates and then has the
> instruction repeated.
> 
> The test checks that the second doubleword of the PSW field, which is not
> part of an ESA/390 PSW, comes back unchanged, that the PSW points behind
> the last instruction, and that the first instruction stored the
> designated list. What the second instruction stored is printed for
> diagnosis.
> 
> The test is skipped without the capability, without interpretive
> execution for the guest (SIEF2) and without facility 7 in the guest's
> model.
> 
> Signed-off-by: Yvan Janssens <yvanj@cyber.gent>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/s390/vsie_esa_test.c        | 180 ++++++++++++++++++
>   2 files changed, 181 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/s390/vsie_esa_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 283c59d7649c..aef64ec2719c 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -227,6 +227,7 @@ TEST_GEN_PROGS_s390 += s390/shared_zeropage_test
>   TEST_GEN_PROGS_s390 += s390/ucontrol_test
>   TEST_GEN_PROGS_s390 += s390/user_operexec
>   TEST_GEN_PROGS_s390 += s390/keyop
> +TEST_GEN_PROGS_s390 += s390/vsie_esa_test
>   TEST_GEN_PROGS_s390 += rseq_test
>   TEST_GEN_PROGS_s390 += s390/irq_routing
>   TEST_GEN_PROGS_s390 += mmu_stress_test
> diff --git a/tools/testing/selftests/kvm/s390/vsie_esa_test.c b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
> new file mode 100644
> index 000000000000..a52603e30f63
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/s390/vsie_esa_test.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test nested guests that run in ESA mode (KVM_CAP_S390_VSIE_ESAMODE).
> + *
> + * Guest 2 runs a guest 3 from a state description without the
> + * z/Architecture flag. Such a state description has the eight-byte ESA/390
> + * PSW in the first doubleword of the PSW field. vsie rewinds the PSW of
> + * guest 3 when it has to repeat an instruction; the test uses STORE FACILITY
> + * LIST EXTENDED, which vsie repeats after it has shadowed the facility list
> + * guest 2 designates.
> + */
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "kvm_util.h"
> +#include "test_util.h"
> +#include "kselftest.h"
> +#include "sie.h"
> +#include "facility.h"
> +#include "ucall_common.h"
> +
> +#define G3_MEM_LEN	0x100000UL
> +/* mso/msl have 1MB granularity */
> +#define G3_MSO		0x10000000UL
> +#define G3_START	(2 * 0x1000UL)
> +/* where guest 3 stores its facility lists, in its first page */
> +#define G3_STFLE_1	0xf00
> +#define G3_STFLE_2	0xf80
> +
> +#define FAC_STFLE	7
> +
> +/* bit 12 of an ESA/390 PSW is one, bit 32 selects 31-bit addressing */
> +#define ESA_PSW_MASK	0x0008000080000000ULL
> +#define ESA_PSW_ADDR	0x000000007fffffffULL

unused but probably ok to keep in.

> +
> +/* facility list for guest 3: only the first doubleword is looked at */
> +#define G3_FAC_0	0x4000100000000001ULL
> +
> +static const u8 g3_code[] = {
> +	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
> +	0xb2, 0xb0, 0x0f, 0x00,			/* stfle G3_STFLE_1 */
> +	0xa7, 0x08, 0x00, 0x00,			/* lhi   %r0,0 */
> +	0xb2, 0xb0, 0x0f, 0x80,			/* stfle G3_STFLE_2 */
> +	0x83, 0x00, 0x00, 0x44,			/* diag  %r0,%r0,0x44 */
> +};
> +
> +static u64 scb_real;
> +
> +static void guest_code(void)
> +{
> +	while (1) {
> +		asm volatile("	sie	0(%[scb])\n"
> +			     :
> +			     : [scb] "a" (scb_real)
> +			     : "memory", "cc");

The guest touches r0, so we probably should add that to the clobber list when applying.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>




