Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019075678C9
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965495; cv=none; b=XgdeHaE+rd7SI7WYYc5Qgmgmqg72xD/Cs6/ZLb9oZgoEwA5oksYvXcy0wLswKpTmlCAqQHT9/Su7PQiOHdL2/MvV7117SLR0XMvTgY3SQNU6tOryuhslvol54GKhAeYgVJJmpwlflhqdCZ47iNcPpAoY1Vsh7BB+dOUMwCjeE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965495; c=relaxed/simple;
	bh=sLqfsCup5SNDJu+xNN5j5/RFuNf3WHaWod2eO65y+jI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q6uy3q8j9azyQX+VYTtMXODEUE02rnqfEvmx8G5etCrZ0Uc20r5Akg/3F1swKtgVFKAQlnwp9jxmUhRUIp+ZnuYm7MJA5cPLSEz6YsV+s7NnoJMwuVKQGAa6RyidXUUk0E/nidXg5fisGBqkyi8U+L63PokHmFSLhUOQT+tDbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVzrTyKH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVzrTyKH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B22Bl2666620;
	Wed, 9 Sep 2026 14:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c/KSQe
	Vsm9tw7xAdmieJQp1gE0EzPAoRxrXEHQuewUE=; b=dVzrTyKHeMNA+sO4440uKw
	M3kpn/sDXk/60SZ0paHNmrayQoDwxXODdJVR9gfpSEl21WlGN/3UP3bDo79U/QhB
	AObXMU0jDsPc3DckToMeQZOwmzioU0wEDKDUm7iFiay03EKbGRZT7HGU/Ts5XbEE
	encSRirSr+27HG7C+jdOjvO81q8X9vXcqS267+y1o8SkyFUZnhouzOqVRsKR+x5v
	0by6dtknxN8o/NDo7x1kJpxJBJ8K0t4vpq2EdUnziclpHGZ6i41JqmwBvNg6iUwa
	dbKVPz74Oa1DEy2XFS2IrPm5FnI+uPFQ/E3TZsDoIsXbjqWPcJuRcC8mYZ8ecNjw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrx6t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 14:51:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EfEDu017063;
	Wed, 9 Sep 2026 14:51:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqk00x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 14:51:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689EpK9O63635906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 14:51:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD77C5806A;
	Wed,  9 Sep 2026 14:51:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5607358064;
	Wed,  9 Sep 2026 14:51:19 +0000 (GMT)
Received: from [9.61.97.36] (unknown [9.61.97.36])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 14:51:19 +0000 (GMT)
Message-ID: <cf1a40d2-5c8a-4b31-8bf4-aecbae966c79@linux.ibm.com>
Date: Wed, 9 Sep 2026 10:51:18 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v16 00/20] Extend qemu CPACF support
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260824083204.40877-1-freude@linux.ibm.com>
Content-Language: en-US
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260824083204.40877-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa1726b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=U2OuJsLZ6soAiM3D-lAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfX9X669PAtBbDV
 3KUrX8xq0LbVc94RvAULUv0qsLalxMwyCRFbjKi6wj/78zHJDxbINScVi1/rM+2a32qP0d7TD+M
 02Hv/JGxhrjVnBNLN8xqMrao9PVo8ww=
X-Proofpoint-ORIG-GUID: 5ZRUPo76ckUJqMVogkRUUNzGsKBZiDS3
X-Proofpoint-GUID: 5ZRUPo76ckUJqMVogkRUUNzGsKBZiDS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MiBTYWx0ZWRfX3agVrXcwxUqB
 qWRCEMqh79Sv9Lcj8qRMGPsl1QMl3UYotr8qZsCkhg03uh2x9L5dE7GQPuiXglWE58swT5iGVN6
 4knlKKGc4RyfXcl4mMHgMfnUNauL1RxK/AzGo+Xa9W3ijfCJLUxIEngr9c6NDgQkkFNB5rzntF3
 CrOJQYmJc8fOupJepCbsyZA5xBgRAQ7N56uymSvJ38KkeEKCRfHJQjekCQtTxxJGjyg2Oy9KBIb
 0gDguzpvqSGhca4fG05ygqSqe9jC5JOT2/cqt0jLAque315DXH8AxiulxhtmBz9VnVsn98VTsFM
 3IeaHSQNRLeXB7IB0fVLtZEj83bW79YqlNJwPCJgBeNxtbxOAPFd1wIExMXVyqzgUwVbR5MwtWy
 pELQNM77qR+C0qIMnSgofoYU9sl5ZGrevv3eXuVSsgv4accaEkidoOpFMtXrjUXQ30OXMybhJe7
 9Vw73tMmKh+DLZ8pWhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090162



On 8/24/26 4:31 AM, Harald Freudenberger wrote:
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
> Test: There are some very basic tests included with this patch series
> suitable for some CI run. Better test coverage can be done by running
> a full blown Linux and use for example the in-kernel crypto modules.
> The 'usual' in-kernel crpyto modules will be automatically loaded
> which run a bunch of test cases. So there is now support for these
> kernel modules:
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

Applied for 11.2. Thank you!

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
>        which describes all these CPACF instructions.
> v8: - Add a fix which deals with incorrect address handling
>        in the sha512 implementation related to fetch and push
>        data from/to memory.
>      - Slight rework around the capcf function implementation and
>        exception generation.
>      - Added some more details to the new cpacf.rst file.
>      - Fixed some typos and added some suggestions from Finn.
>      - Fixed cc handling on return of PCKMO (must not update cc).
>      Missing: simple test cases to verify that the implemented and not
>      implemented cpacf functions and subfunctions work as expected. But
>      see the statement about tests at the header.
> v9: - Add simple tests for all the implemented CPACF instructions but
>        pckmo (which is a privileged instruction).
>      - Reworked the Fix for wrong address to call the wrap function
>        inline; rephrased commit header.
>      - Improve the header file cpacf.h to hold defines for all the
>        cpacf instruction functions and use them in the code.
>      - one new commit comprising the base protected key support with
>        exposing the xor pattern and wkvp and en/decrypt key functions
>        via cpacf.h. So the testcases can use this header file.
>      - one new commit which reworks the fetch memory and store memory
>        from and to guest (suggested by Ilya Leoshkevich).
> v10: - Fixed v9 patch 3 (cpacf_sha512.c was missing)
>       Please note that patch #10 "target/s390x: Base support for cpacf
>       protected keys" produces a build warning ("unused function"). As
>       by default the qemu build has warnings=errors enabled, this one
>       patch does not build on it's own. If this is not acceptable, the
>       hunk introducing the two functions may be moved to the next
>       commit; another solution would be to merge with patch #11.
> v11: Fixed nearly all checkpatch findings - only the warnings about
>       Maintainers may need update is still there.
> v12: - Very first patch is integrated in master and thus removed from
>         this series.
>       - New header file include/crypto/aes-headers.h as suggested by
>         Daniel. Moved the patch which introduces the aes helpers before
>         the actual AES cpacf implementations and reworked all the code
>         to use these helpers.
>       - Merged together "Base support for cpacf protected keys" and
>         "Support pckmo encrypt AES subfunctions" to fix the broken
>         build caused by unused functions.
>       - Merged the changes from patch "Improve fetch and store mem from
>         and to guest" directly into the code where it is introduced.
> v13: - reworked the helper functions to copy memory from and to
>         guest. These are now inline functions located in
>         target/s390x/tcg/crypto_helper.h and have been renamed and
>         extended for u32 and u64 as well. Also the both sha
>         implementations have been reworked to use these helper
>         functions. See patch #4 for details.
>       - fixed the wrong list of parameters docu in patch #5
>       - added some Reviewed-by tags.
>       - reworked the testcases to run (more or less) on real s390
>         hardware. However this does not and can not work with protected
>         keys.
>       - rebased to current master head.
> v14: - fixed one wrong constant in target/s390x/tcg/cpacf.h
>       - added 1 patch (patch #1) which fixes the missing privileged
>         flag with the PCKMO instruction.
>       - added a simple testcase for the PCKMO instruction (see
>         tests/s390x/tcg/cpacf-pckmo.c for details).
> v15: - rebased to current master
>       - new patch reworking the addressing mode check in the both
>         sha256 and sha512 implementations. Also added early bail out.
>       - In a similar way rework the checking for addressing mode in
>         cpacf_aes.c (comes in with each algo implementation).
>       - bail out early on length zero for the cpacf aes algs.
>       - As suggested by Ilya splitted the cpacf.h into two header
>         files cpacf-arch.h and cpacf.h.
> v16: - Fixed some places with wrong indentation.
>       - Fix regression introduced with v15: sha256 and sha512 must bail
>         out for KIMD only, but not for KLMD.
>       - AI screening: PCKMO still clobbered CC. So fixed this.
>       - AI screening: KDSA lacked the r2 even/nonzero check - fixed.
>       - Updated cpacf docu to clearly state for KMA, KMF, KMO and KDSA
>         which exception happens on which condition.
> 
> Harald Freudenberger (20):
>    target/s390x: Fix missing privileged flag at PCKMO instruction
>    target/s390x: Rework s390 cpacf implementations
>    target/s390x: Move cpacf sha512 code into a new file
>    target/s390x: Support cpacf sha256
>    target/s390x: Add helper functions for copy memory to and from guest
>    target/s390x: Adjust addressing mode checks for sha512 and sha256
>    crypto: Add aes-helpers file to support some AES modes
>    target/s390x: Support AES ECB for cpacf km instruction
>    target/s390x: Support AES CBC for cpacf kmc instruction
>    target/s390x: Support AES CTR for cpacf kmctr instruction
>    target/s390x: Minimal AES XTS support for cpacf pcc instruction
>    target/s390x: Support AES XTS for cpacf km instruction
>    target/s390x: Base support for cpacf protected keys and pckmo
>    target/s390x: Support protected key AES ECB for cpacf km instruction
>    target/s390x: Support protected key AES CBC for cpacf kmc instruction
>    target/s390x: Support protected key AES CTR for cpacf kmctr
>      instruction
>    target/s390x: Minimal protected key AES XTS support for cpacf pcc
>      instruction
>    target/s390x: Support protected key AES XTS for cpacf km instruction
>    docs/s390: Document CPACF instructions support
>    tests/tcg/s390x: Add tests for CPACF instructions
> 
>   crypto/aes-helpers.c             | 106 ++++
>   crypto/meson.build               |   1 +
>   docs/system/s390x/cpacf.rst      | 143 +++++
>   docs/system/target-s390x.rst     |   1 +
>   include/crypto/aes-helpers.h     | 109 ++++
>   target/s390x/gen-features.c      |  31 +
>   target/s390x/tcg/cpacf-arch.h    | 251 ++++++++
>   target/s390x/tcg/cpacf.h         |  63 ++
>   target/s390x/tcg/cpacf_aes.c     | 986 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/cpacf_sha256.c  | 197 ++++++
>   target/s390x/tcg/cpacf_sha512.c  | 211 +++++++
>   target/s390x/tcg/crypto_helper.c | 445 +++++++-------
>   target/s390x/tcg/crypto_helper.h | 100 ++++
>   target/s390x/tcg/insn-data.h.inc |   3 +-
>   target/s390x/tcg/meson.build     |   3 +
>   target/s390x/tcg/translate.c     |  16 +-
>   tests/tcg/s390x/Makefile.target  |  10 +
>   tests/tcg/s390x/cpacf-kdsa.c     |  58 ++
>   tests/tcg/s390x/cpacf-kimd.c     | 166 ++++++
>   tests/tcg/s390x/cpacf-klmd.c     | 206 +++++++
>   tests/tcg/s390x/cpacf-km.c       | 590 ++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c     |  58 ++
>   tests/tcg/s390x/cpacf-kmc.c      | 351 +++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c    | 360 +++++++++++
>   tests/tcg/s390x/cpacf-pcc.c      | 245 ++++++++
>   tests/tcg/s390x/cpacf-pckmo.c    |  45 ++
>   tests/tcg/s390x/cpacf-prno.c     | 131 ++++
>   tests/tcg/s390x/cpacf.h          | 570 ++++++++++++++++++
>   28 files changed, 5230 insertions(+), 226 deletions(-)
>   create mode 100644 crypto/aes-helpers.c
>   create mode 100644 docs/system/s390x/cpacf.rst
>   create mode 100644 include/crypto/aes-helpers.h
>   create mode 100644 target/s390x/tcg/cpacf-arch.h
>   create mode 100644 target/s390x/tcg/cpacf.h
>   create mode 100644 target/s390x/tcg/cpacf_aes.c
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c
>   create mode 100644 target/s390x/tcg/cpacf_sha512.c
>   create mode 100644 target/s390x/tcg/crypto_helper.h
>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>   create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>   create mode 100644 tests/tcg/s390x/cpacf.h
> 
> 
> base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
> --
> 2.43.0
> 
> 


