Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283233D5227
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226398; cv=none; b=Tvr50pKMdlo2MT8B+Snoxe0/ZxW+VAfr2PwxXB4hpNqmnLAesR7Bc2s7FB8oW/lbtHtzQTM3XrhuQ4D1Imx/1HMtyNorst8Ifi1OgF4zO+6g7W4IjEDXGNeL5abi0n0IN+wEQZIadna2mafWQiQgLjFrYXjYfRYr2BFJ6S9FiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226398; c=relaxed/simple;
	bh=L9B4NYSDBc9QFb8fLVMMT+t072/2VjRBnYYi7bwHDnE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=F+/t1lV7cJE4hv/JnGsfrMYvW+qvtrxrYJLp8RbuvQUTtpe15POLTlhaXLjwGWQ0HmQ130qXc4A0YjauvuYgfRCgcOpdDB+5C4oW1yxWg94BraLqDRelh7jDd+FBwVNrXWDSoWwZCnkXqDIMTo3rDYcTCcGmOyGuUsF4feglRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEZXixcE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEZXixcE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBnL1x1806733;
	Tue, 23 Jun 2026 14:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=h1REIXY2wHPEr+Di2hSOsOAZcnZigSGSVtxMFZCpNqo=; b=QEZXixcEWYJX
	6MdMrexx+72sCASb9+kfdjCgIEEFki9oTUq2y0UtdVi4FXyoMst4aRjWnoZqjcOx
	bSDA9BokGtQQ+CDOJcyIxAbSQOyv1lLrOMVsgQS7SG3YnY/AyQi0zwrI4RiMy/6R
	Qapvaozk0Aub301j2D6eMWD9Nw73TwigtLRkF0U9WI0XdhAA9CVPx+3FViTLX2nn
	CgRooKMEuEoC889NRo3g1ji+Ll8aF6WrCY4TksajS8FPsHdvhnPVRKRrbIEvC+XZ
	KVu7XmEI5i2EDBW03KdkHVfS268OL4NkizRgM1uMrDsqU1BxjVlUkstqmELjvbLT
	/XhAOELNow==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gf5as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:53:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEnj4o020757;
	Tue, 23 Jun 2026 14:53:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3tpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:53:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEr5xO32309794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:53:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4982358052;
	Tue, 23 Jun 2026 14:53:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E544F58045;
	Tue, 23 Jun 2026 14:53:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:53:03 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 16:53:03 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 00/17] target/s390x: Extend qemu CPACF support
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <6655e1cb-4259-49fa-ab83-06a0544f4632@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <6655e1cb-4259-49fa-ab83-06a0544f4632@linux.ibm.com>
Message-ID: <c4079273418b98ac92e7e3e3d4cb4c57@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BfxsjGItiQXJ_sMEWGisIRSbTmVLKSj2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX9+cJGlo64AF9
 j8V0eO3O8FZI6JCHKVEcumv6e1lttnAnkwbFYUOP8Tnedof5S96aNDzrirrgmq/8Wdmzj06cJCx
 rs9+FHXOs/DOmALgt4MJ8uNJyIoC5IU=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3a9dd3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KI8pFRJNMFQGB0bCxOwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyMiBTYWx0ZWRfX2LF409z2zst2
 Wry3vM7SfBl2tSPI2Hza5mD3yEYlSeJGReFsGvqQYzxGlqUHPcKmLFKfdYpDuRKhHqEJ/VsPDXE
 rR94zvcfVIdfhwyTihyISkM89I7IzeoNgM/X7xwVda28X80Ea7q/el009WHISDcBVmFCgZVUL+/
 NXNPzG7SRFx0JhhLR2NBllM+gXzHrg+cev2ul7v8zrTp7pC3Kc5wX1Mst/HiIpMK7b1NfaWSRB9
 kaYG4JsgOo67ZIDKPK3tUOwSDCHewRclPshQKX8wEcJL3VQQXPUeCKglwLJFfTk8EcpvKOF5Y96
 luKOlkM2SnLvTZFfppc1QMK+0xBDc9wMKHdRorDaP1bX/Z0JDjTpyOhDCh9F5LQfvxBPDOA55zm
 xD4wccSuCwTImrxGE/rKI2YdBaLL1AbjzXh5pgVBEUw/S2oN+W/19Ue8bPO8uN5PfrrDC2Pvzpc
 eVWD82BJdpaciZdh+3w==
X-Proofpoint-ORIG-GUID: BfxsjGItiQXJ_sMEWGisIRSbTmVLKSj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230122

On 2026-06-18 07:37, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> This patch series extends the s390 qemu CPACF support to be able to
>> run a subset of the CPACF instruction cross platform. There have been
>> requests on the kernel crypto mailing list about a way to test
>> s390 specific crypto implementations. For example a way to test
>> s390 CPACF exploitation code like the s390_aes.ko kernel module.
>> 
>> So here now is a set of patches verified on x86 and s390 which
>> over (slow but working) support for a subset of the subfunctions of
>> some of the CPACF instructions.
>> 
>> Test: As this series is more or less complete, a full blown linux
>> can be run and the 'usual' in-kernel crpyto modules will be
>> automatically loaded which run a bunch of test cases. So there
>> is now support for these kernel modules:
>> * sha256_s390x (autoloaded, sha256)
>> * sha512_s390x (autoloaded, sha512)
>> * aes_s390x (autoloaded, clear key aes ecb, cbc, ctr, xts)
>> * pkey_pckmo (autoloaded, derive AES protected key from clear key)
>> * paes_s390x (not autoloaded, protected key aes ecb, cbc, ctr, xts)
>> All these modules run selftests if configured by the kernel (which is
>> enabled by default). Failures are reported via syslog. Additionally
>> the aes testcases from libica can be run either inside such an qemu
>> environment or with a static build executed with the qemu tcg
>> application qemu-s390x --cpu max <static-build-libica-test>.
>> 
>> Changelog:
>> v1: Initial version with
>>      - Related code restructured
>>      - Support KIMD SHA512 and thus SHA256
>>      - Support KMC AES-128, AES-192 and AES-256 and thus have basic 
>> AES
>>        support (ECB mode) enabled.
>>      - Support PCC Compute-XTS-Parameter-AES-128 and
>>        Compute-XTS-Parameter-AES-256 but only for block sequence 
>> number
>>        0. This is a requirement for the next step:
>>      - Support KM XTS-AES-128 and KM XTS-AES-256. Together with the
>>        minimal PCC support this enables AES-XTS CPACF acceleration.
>> v2: - Basic PCKMO support to be able to 'derive' an AES protected key
>>        from clear key. See header details.
>>      - Support protected key AES-ECB.
>>      - Support protected key AES-CBC.
>>      - Minimal protected key AES-XTS support for CPACF PCC.
>>      - Support protected key AES-XTS.
>>      - Support AES-CTR.
>>      - Support protected key AES-CTR.
>> v3: - Reordered patches as suggested by Finn.
>>      - One small bug fix in CPACF_aes.c related to address 
>> translation.
>> v4: - Rename of the parameters based on feedback from Janosch to
>>        make clear these are registers or ptrs to registers.
>>        Added Tested by from Holger. Fixed typo "face" -> "fake".
>> v5: - Add documentation file docs/system/s390x/cpacf.rst which
>>        describes the state of the CPACF instructions and which
>>        functions are covered when this series is applied.
>>        First version sent to public mailing list qemu-s390x.
>> v6: - Rebase/rework to build on current qemu head.
>>      - Add docs/system/s390x/cpacf.rst to target-s390x.rst
>>      - New file crypto/aes-helpers.c with some simple
>>        functions to support AES modes CBC, CTR and XTS.
>>      - Slight rewrite of the s390x CPACF implementations to
>>        use these generic AES mode implementations.
>> v7: - Update on docs/system/s390x/cpacf.rst to mention
>>        the zArchicteture Principles of Operation document
>>        which describes all these CPAC instructions.
>> 
>> Harald Freudenberger (17):
>>    target/s390x: Rework s390 cpacf implementations
>>    target/s390x: Move cpacf sha512 code into a new file
>>    target/s390x: Support cpacf sha256
>>    target/s390x: Support AES ECB for cpacf km instruction
>>    target/s390x: Support AES CBC for cpacf kmc instruction
>>    target/s390x: Support AES CTR for cpacf kmctr instruction
>>    target/s390x: Minimal AES XTS support for cpacf pcc instruction
>>    target/s390x: Support AES XTS for cpacf km instruction
>>    target/s390x: Support pckmo encrypt AES subfunctions
>>    target/s390x: Support protected key AES ECB for cpacf km 
>> instruction
>>    target/s390x: Support protected key AES CBC for cpacf kmc 
>> instruction
>>    target/s390x: Support protected key AES CTR for cpacf kmctr
>>      instruction
>>    target/s390x: Minimal protected key AES XTS support for cpacf pcc
>>      instruction
>>    target/s390x: Support protected key AES XTS for cpacf km 
>> instruction
>>    docs/s390: Document CPACF instructions support
>>    crypto: Add aes-helpers file to support some AES modes
>>    target/s390x: Use generic AES helper functions
>> 
>>   crypto/aes-helpers.c             | 101 ++++
>>   crypto/meson.build               |   1 +
>>   docs/system/s390x/cpacf.rst      | 116 ++++
>>   docs/system/target-s390x.rst     |   1 +
>>   include/crypto/aes.h             |  14 +
>>   target/s390x/gen-features.c      |  31 +
>>   target/s390x/tcg/cpacf.h         |  63 ++
>>   target/s390x/tcg/cpacf_aes.c     | 955 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/cpacf_sha256.c  | 232 ++++++++
>>   target/s390x/tcg/cpacf_sha512.c  | 245 ++++++++
> 
> Since you implemented all aes related stuff into cpacf_aes.c maybe
> think about putting all sha related stuff into cpacf_sha.c instead of
> singular files. Or go the singular way with the aes stuff as well.
> 

Well, you are right. But ... the sha512 implementation is from Jason 
Donenfeld
and has a extra Copyright. I tried to keep this implementation as close 
as possible
to the original version. So no mixing of any weired copyrights.
And I think the AES implementations belong together, similar for example 
when ECC
implementations come up (:-O) or some hmacs or so.

>>   target/s390x/tcg/crypto_helper.c | 423 +++++++-------
>>   target/s390x/tcg/insn-data.h.inc |   1 +
>>   target/s390x/tcg/meson.build     |   3 +
>>   target/s390x/tcg/translate.c     |   2 +
>>   14 files changed, 1972 insertions(+), 216 deletions(-)
>>   create mode 100644 crypto/aes-helpers.c
>>   create mode 100644 docs/system/s390x/cpacf.rst
>>   create mode 100644 target/s390x/tcg/cpacf.h
>>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>>   create mode 100644 target/s390x/tcg/cpacf_sha256.c
>>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
>> 
>> 
>> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
>> --
>> 2.43.0
>> 
