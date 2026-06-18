Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAD14A4F0
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761045; cv=none; b=u/fJ/Ne7NoijDTfnjj57yrYXIUuUTA2eA97d4nQ8I0G2hVwIVlr2mlSAfuUSjSiiWZQie4kjdIgl9zy3abkfHSr1UUR0d5wa+zFJCxkY9tz7+R8ZJ1xEWHa/5tfiKiIzrrtiX25xcBdW1HKrj72NAX+TdeBpBJ5YpDdyxf6ePrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761045; c=relaxed/simple;
	bh=rcJR9+jWPRqGx2mUNd9RWF5fv5EI61toce6XxP76qGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9rkVJbnapDsYqIl5Uir1xgOnVVsvCh/lekfmrpOouJ3Pwkc3Hn4TjhvPn83/ejzwRaMztpL/YB/Fw5fCndxFyzbW/++lZZCgE8nGU96UGuoPv+q5xrSDdLVmgpdJORoLPezyiBl9Rxe19nMr1z6y+Fq4uEJmVCLc0ohyY0ouDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S57SXCOr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S57SXCOr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmIm61016438;
	Thu, 18 Jun 2026 05:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O6FF+0
	A0eEPHVO7BGID+ZGx1gI6S8LqbGz0YVf0YjRI=; b=S57SXCOrDZO5FKmjFLtFQI
	84arBeQ3sLCnLt9r3twE5+PrtbMs3W+d8p+EFykrRczfqbDK15Jie2Q+DPVaj7uG
	IvbVKFJXwkqcstTBK9zpUT55Wy5Col1YvkYnf3oRMFMfdoLwr2cmIydFWdrBK8bL
	XjRt6ZUE5ah2hw1nJ034NcpehT4CehxVZplhGa7TeLP2BThL//Kkq8Er/wXhKtMU
	VqqJLQW+1nbgPGyLNJ1lYBxzaZK5uoX5eOECqLx33a9dhG5lXkiCpADZdIj/eKkC
	7LFfNeSGyv9qzhY7yBv8RkEAXk8rBexsdhqhNItKaFbjNKaTerzDPcQIBgjF/1qQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxecxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:37:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5Z1nZ031083;
	Thu, 18 Jun 2026 05:37:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:37:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5bB0f30802248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:37:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B4852004D;
	Thu, 18 Jun 2026 05:37:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B21C2004B;
	Thu, 18 Jun 2026 05:37:11 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:37:11 +0000 (GMT)
Message-ID: <6655e1cb-4259-49fa-ab83-06a0544f4632@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:37:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] target/s390x: Extend qemu CPACF support
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a33840c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=QNs_BIYjvnKcn3kyA4IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX0yo8fqY0JEzd
 gMF0I088+/ZSrvvu3ulfDHh+JXXhvwhT5Td/2KSfdEl3Ic8/DMIxOyZbWwXl2GPlYZBTrRGqDXm
 9t/kWx3eyRErarBwYdqTbN0lYROQytqUCFskgdiVs8BPWhKxcqcPqIUEJf5fsNgpIF2+yetWDq0
 oIpphU4qoJEFiPysrKxHqkzdG0ft7eOIdxzTRaRQDDpRGYgsHt/tUnIMTO5k9w5ZYsJvXBKIbH8
 GGfhMfwYdIWbVoMsFpj7LedC8wNqdNPYVHsqfLse4YTJE5Plz1+TR1zFJK3DRmFmbyb46OPELTu
 5Hn64f4IQb6kBH4f+9agDhXx+u/UQHCTupzHA4o0XfblEcDSsr2banAiMnSsyFbICGff6upj53F
 8/FyBs7HGqBY5Mhl5gJNp2BVprI/YS9rzEEq8Id4nMg+bCbgumfeXKwr27YMgf+GkWexr6y9+yK
 H90EPBbEHOucRgzBl1w==
X-Proofpoint-GUID: 2OrA_MQomVIEl6UUcjjxOWiAK3fiiWjx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX3bvdD6uKF0vc
 3T/Gng80DnrsUKM9yJRkVYux/lVQHPDB/Y+CVEeeXSlRGJBu0dGUiLuIrJB1g2YjDD1E6cIHzg+
 mSqTvdo840rXCxMI3Ph4TxpT/Ca8N9g=
X-Proofpoint-ORIG-GUID: 2OrA_MQomVIEl6UUcjjxOWiAK3fiiWjx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045



On 17.06.26 11:48, Harald Freudenberger wrote:
> This patch series extends the s390 qemu CPACF support to be able to
> run a subset of the CPACF instruction cross platform. There have been
> requests on the kernel crypto mailing list about a way to test
> s390 specific crypto implementations. For example a way to test
> s390 CPACF exploitation code like the s390_aes.ko kernel module.
> 
> So here now is a set of patches verified on x86 and s390 which
> over (slow but working) support for a subset of the subfunctions of
> some of the CPACF instructions.
> 
> Test: As this series is more or less complete, a full blown linux
> can be run and the 'usual' in-kernel crpyto modules will be
> automatically loaded which run a bunch of test cases. So there
> is now support for these kernel modules:
> * sha256_s390x (autoloaded, sha256)
> * sha512_s390x (autoloaded, sha512)
> * aes_s390x (autoloaded, clear key aes ecb, cbc, ctr, xts)
> * pkey_pckmo (autoloaded, derive AES protected key from clear key)
> * paes_s390x (not autoloaded, protected key aes ecb, cbc, ctr, xts)
> All these modules run selftests if configured by the kernel (which is
> enabled by default). Failures are reported via syslog. Additionally
> the aes testcases from libica can be run either inside such an qemu
> environment or with a static build executed with the qemu tcg
> application qemu-s390x --cpu max <static-build-libica-test>.
> 
> Changelog:
> v1: Initial version with
>      - Related code restructured
>      - Support KIMD SHA512 and thus SHA256
>      - Support KMC AES-128, AES-192 and AES-256 and thus have basic AES
>        support (ECB mode) enabled.
>      - Support PCC Compute-XTS-Parameter-AES-128 and
>        Compute-XTS-Parameter-AES-256 but only for block sequence number
>        0. This is a requirement for the next step:
>      - Support KM XTS-AES-128 and KM XTS-AES-256. Together with the
>        minimal PCC support this enables AES-XTS CPACF acceleration.
> v2: - Basic PCKMO support to be able to 'derive' an AES protected key
>        from clear key. See header details.
>      - Support protected key AES-ECB.
>      - Support protected key AES-CBC.
>      - Minimal protected key AES-XTS support for CPACF PCC.
>      - Support protected key AES-XTS.
>      - Support AES-CTR.
>      - Support protected key AES-CTR.
> v3: - Reordered patches as suggested by Finn.
>      - One small bug fix in CPACF_aes.c related to address translation.
> v4: - Rename of the parameters based on feedback from Janosch to
>        make clear these are registers or ptrs to registers.
>        Added Tested by from Holger. Fixed typo "face" -> "fake".
> v5: - Add documentation file docs/system/s390x/cpacf.rst which
>        describes the state of the CPACF instructions and which
>        functions are covered when this series is applied.
>        First version sent to public mailing list qemu-s390x.
> v6: - Rebase/rework to build on current qemu head.
>      - Add docs/system/s390x/cpacf.rst to target-s390x.rst
>      - New file crypto/aes-helpers.c with some simple
>        functions to support AES modes CBC, CTR and XTS.
>      - Slight rewrite of the s390x CPACF implementations to
>        use these generic AES mode implementations.
> v7: - Update on docs/system/s390x/cpacf.rst to mention
>        the zArchicteture Principles of Operation document
>        which describes all these CPAC instructions.
> 
> Harald Freudenberger (17):
>    target/s390x: Rework s390 cpacf implementations
>    target/s390x: Move cpacf sha512 code into a new file
>    target/s390x: Support cpacf sha256
>    target/s390x: Support AES ECB for cpacf km instruction
>    target/s390x: Support AES CBC for cpacf kmc instruction
>    target/s390x: Support AES CTR for cpacf kmctr instruction
>    target/s390x: Minimal AES XTS support for cpacf pcc instruction
>    target/s390x: Support AES XTS for cpacf km instruction
>    target/s390x: Support pckmo encrypt AES subfunctions
>    target/s390x: Support protected key AES ECB for cpacf km instruction
>    target/s390x: Support protected key AES CBC for cpacf kmc instruction
>    target/s390x: Support protected key AES CTR for cpacf kmctr
>      instruction
>    target/s390x: Minimal protected key AES XTS support for cpacf pcc
>      instruction
>    target/s390x: Support protected key AES XTS for cpacf km instruction
>    docs/s390: Document CPACF instructions support
>    crypto: Add aes-helpers file to support some AES modes
>    target/s390x: Use generic AES helper functions
> 
>   crypto/aes-helpers.c             | 101 ++++
>   crypto/meson.build               |   1 +
>   docs/system/s390x/cpacf.rst      | 116 ++++
>   docs/system/target-s390x.rst     |   1 +
>   include/crypto/aes.h             |  14 +
>   target/s390x/gen-features.c      |  31 +
>   target/s390x/tcg/cpacf.h         |  63 ++
>   target/s390x/tcg/cpacf_aes.c     | 955 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/cpacf_sha256.c  | 232 ++++++++
>   target/s390x/tcg/cpacf_sha512.c  | 245 ++++++++

Since you implemented all aes related stuff into cpacf_aes.c maybe think 
about putting all sha related stuff into cpacf_sha.c instead of singular 
files. Or go the singular way with the aes stuff as well.

>   target/s390x/tcg/crypto_helper.c | 423 +++++++-------
>   target/s390x/tcg/insn-data.h.inc |   1 +
>   target/s390x/tcg/meson.build     |   3 +
>   target/s390x/tcg/translate.c     |   2 +
>   14 files changed, 1972 insertions(+), 216 deletions(-)
>   create mode 100644 crypto/aes-helpers.c
>   create mode 100644 docs/system/s390x/cpacf.rst
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
> 
> 
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> --
> 2.43.0
> 

