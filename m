Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C522DEA61
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915616; cv=none; b=D+ae7wxAEl20fqxpPPiTnhE97Dux95uQwJ7Rb5CB6ssKNswhtqWB8xTxTPacu1WPbu3fGE8ggQHKLC0CcuTNpkql+GYhdR4OmtTxxZMWP0R3nXRdhIwE0KpKTeX/f3yqrku4piPVmoC34tYsh5xrCpBXzBJGwKhJGeHUfm6Y3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915616; c=relaxed/simple;
	bh=kXP4QDAXi9xatyAf2QtI4QAUq3M880pjUMWj3spueZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4I/hOW4u8zAdb6DNwocMYo9fl/o7wwIi6u7oRwVvekkip49I1E12Ost8rggzVhUrtCK0yVieSbU03xYHeg+2SmW/qwvKQOkePcoIXhdo2Nz+Is6K1GzW9eiaYZR+ZPZls/qclA/XPOfNbcsJdRj0kF2UZJ3KiA9PAooskbMlfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Azm16Fy/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Azm16Fy/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1RD9385313;
	Wed, 9 Sep 2026 01:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=orIACF
	qqDEtn9K77zatF+wtELNLV251wD5bHNekjrck=; b=Azm16Fy/aElcBgSp7JBKUX
	kyagklIf74CPUU7Z7ixwkJEw+Wm2ZmuBLCecowNRwfTUd5nwDPW4YIJDgsYgi9pP
	iq7C/fVx4+uZKwBxb9I2qF0lYEgVDcR7Z/jJO2usOfECsz+NhfKmw1JLIVr/OZ85
	oCm2A3+Qm10iWQrFc53tWrHg/ByG8TkoahiYa4qik+0W4LhipRl/DU77k/xiFFeM
	/RvdOShzQz5BKnoSuWFyNQjVRUb1abvkP4iK8ItbiA7BstytOhLighdLHBvNY+8P
	JomoRoKoe5X0ZFdufglTs9kXh3Jcs9T3+zLhU9Fxi+DScSqrqwuOK8qjxDLOnt5Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk2qvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 01:00:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6890uK2n004159;
	Wed, 9 Sep 2026 01:00:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqffw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 01:00:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689106cM15729214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 01:00:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E19580C5;
	Wed,  9 Sep 2026 01:00:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B21580BD;
	Wed,  9 Sep 2026 01:00:04 +0000 (GMT)
Received: from [9.61.27.191] (unknown [9.61.27.191])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 01:00:04 +0000 (GMT)
Message-ID: <c6879b65-92e1-4730-9ab2-4f27dc405c4d@linux.ibm.com>
Date: Tue, 8 Sep 2026 21:00:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 20/20] tests/tcg/s390x: Add tests for CPACF
 instructions
To: Harald Freudenberger <freude@linux.ibm.com>, iii@linux.ibm.com,
        Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org
References: <20260824083204.40877-1-freude@linux.ibm.com>
 <20260824083204.40877-21-freude@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260824083204.40877-21-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r2k0FKLf9fkk676C6m9kWAkhqROeWWc2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAwNSBTYWx0ZWRfX++V0RW9sDyep
 wZIFJ1ACS/dmeBrcd/5k0E8OZ/0fYPf93WURYXag817kfRQO7ozl4rEdNErlyEbWO7KAev+83S7
 wnMoUI1KiIfsifknHzfegtM/mfnwe2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAwNSBTYWx0ZWRfX9AU8lXDgh3F2
 9Bo5rq3gdvbNkhO15x/e/oXJYnQpic9nkGsBEnBVYX/YE1SPF2tjecOm8OSmz7MW7ROo9FSorM3
 UZjMK7rKFWYbbd5qzB5AN17Gv+xfQEqDuQug9Bq9+UDmZtJEcxLngaQKG1g1Lp9MgSZgR6h+qdL
 JYfjIdRSh90wcvryhGlbXfLxL7tqYeCuq8664GSLQN0Nsf0CBF3O4BHf0Oe66SkWKPgxvEH1yuX
 Uu8iHldhgHWD84fyEYRMl4577AXkIxpJehOI3I30kW9JhBwWqpwd0jhJ7Qy4AYXHFXv7QHYh1Gv
 MmA4CP7aQfiQ6DkWhHQdYcPEvYYHcVM9NgNlOuFjnnwsqqVp/Cwe2mqccny0iu3cq1SIWvULMbl
 LGC4LNRmLZmwv5lrEM5VfUn3cFrMKg9+cEzoxIYajWiqIDIY/HNx5csOuqtsQuqyL3MVCPIwZPh
 aH6lzloQWsXguQVFVyA==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa0af99 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3HeB2vlOXt6ItbSgpAMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r2k0FKLf9fkk676C6m9kWAkhqROeWWc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090005



On 8/24/26 4:32 AM, Harald Freudenberger wrote:
> Add simple tests for the CPACF instructions implemented:
> - kdsa - minimal as only query is implemented
> - kimd - query, sha256, sha512
> - klmd - query, sha256, sha512
> - km - query, aes 128, 192, 256 with clear and prot key
> - kmac - minimal as only query is implemented
> - kmc - query, aes 128, 192, 256 with clear and prot key
> - kmctr - query, aes 128, 192, 256 with clear and prot key
> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
> - pckmo - run query and check for SIGILL
> - prno - query, trng
> No test for kma, kmf, kmo as these instructions are currently
> not implemented at all.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  10 +
>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>   tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>   tests/tcg/s390x/cpacf-pckmo.c   |  45 +++
>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>   tests/tcg/s390x/cpacf.h         | 570 ++++++++++++++++++++++++++++++
>   12 files changed, 2790 insertions(+)
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
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 97c0f02190..be8504497a 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -51,6 +51,16 @@ TESTS+=ts
>   TESTS+=ex-smc
>   TESTS+=divide-to-integer
>   TESTS+=stckf
> +TESTS+=cpacf-kdsa
> +TESTS+=cpacf-kimd
> +TESTS+=cpacf-klmd
> +TESTS+=cpacf-km
> +TESTS+=cpacf-kmac
> +TESTS+=cpacf-kmc
> +TESTS+=cpacf-kmctr
> +TESTS+=cpacf-pcc
> +TESTS+=cpacf-pckmo
> +TESTS+=cpacf-prno
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread

Hi Harald,

This hunk no longer applies, since commit 4851d25f0e ("tests/tcg/s390x: 
user tests") converted the Makefile to meson.

It's a mechanical change, so I'm going to replace it with the following 
when picking up the series, rather than asking you to respin a new version.

Thanks,
Eric

diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index dc6271c7c7..9721c365ba 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -73,6 +73,16 @@ tests += {
    'stckf.c': {},
    'ts.c': {},
    'ex-smc.c': {'cflags': ['-Wl,--no-warn-rwx-segments']},
+  'cpacf-kdsa.c': {},
+  'cpacf-kimd.c': {},
+  'cpacf-klmd.c': {},
+  'cpacf-km.c': {},
+  'cpacf-kmac.c': {},
+  'cpacf-kmc.c': {},
+  'cpacf-kmctr.c': {},
+  'cpacf-pcc.c': {},
+  'cpacf-pckmo.c': {},
+  'cpacf-prno.c': {},
  }

  foreach src: tests_s390x_pgm
