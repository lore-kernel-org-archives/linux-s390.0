Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C59339719
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880843; cv=none; b=cuIY54JgdpsB1dVQREWoYdi/7Sa3bw1VuWQg8fmeOqw1GUPeRuAn4CxD3cWhq0+f3PLb3OjtmnfF58p1toIAi7YA8HgDDlAe+ciDnvEgeSTUBsTReILfneRFVF02ZvhCtIX0bbFD2kgxh2BQHig+2IX9zoLHTfZ5JriiHqgq+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880843; c=relaxed/simple;
	bh=tglBtHZVxt4e04z7hVG8x4n87tH6IYF8hhryNIiqmJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGGaMLZVMeHdVpx4g6QVhd3QYdDZ7qmIXG0v4fOja+ZOO/IZ2zKJ+MJqhCMkJAjWl9go6ZgpuNf2b4nxJ1FwuBsFIoBKc1pkOU5tpFw2Qc+MjgWx7JS5JyPQb44Fy2uLV+T1dGaUElv4bpu4fp15YmGNKM1B/xuNohB6KL8ZXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J2kHpg1N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J2kHpg1N"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JmeRw1804009;
	Tue, 4 Aug 2026 22:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aixmSG
	91L9wVuU1wIGl4gkDxrRpz5iTYH4Ygigffm4o=; b=J2kHpg1NSMJbW9coZj1LyV
	/hWlQMp2E7od2ZVxAgpDBAMrMYrvLz33G4AyUJi99oR0HKILYcMCmA+34Oqfv5D4
	YCxHzXE3C2rghlwdkWz0JS5KqnGrXlNo2g7fMAaf3DwU7GhxhXIPz9P3mZA33kJ0
	ZRf5XFvrwg2qZSLjcE1Po9Ms2bK+p/EBuXIDvwMt25KKq+dKBfT9VXfczwlEXx/g
	6I8Z7mBUdWCDZZzFkQXBwr2sJsZ5XGKEwcnTfHi5aWt6LatSo8Ej0NO8QvKUBFQ5
	Yju+T7yVPOWFZJA27O/MkpXEGNK6RnHPCxidcsMHRSZesSt2QtzeTk9pU1IX00Tg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h505sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:00:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674LuQdH015663;
	Tue, 4 Aug 2026 22:00:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhbtvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 22:00:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674M0S2140305050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 22:00:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2976F2004B;
	Tue,  4 Aug 2026 22:00:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8911220043;
	Tue,  4 Aug 2026 22:00:27 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.144.71])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 22:00:27 +0000 (GMT)
Message-ID: <43620560-24a4-4138-af95-666c30bc7441@linux.ibm.com>
Date: Wed, 5 Aug 2026 00:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/18] target/s390x: Base support for cpacf protected
 keys and pckmo
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-12-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260803161235.228704-12-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX2qsLDpgT7uBm
 F8mQOg9/+h29Jfc/c91ZIQcnr6ABq3zgBxpUlQSdpzfL4hf8p44lUetC7twGZ7G393P44pnWE36
 jLnmfiNXPLOOqk2NW6uX+vVZTxH/H8M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NiBTYWx0ZWRfX4Q6KeTYSsjqN
 j8FfmW+vTBKJz0Zm8AzCsMMTd4rBNdbZbe+LXy+2ssvwPhmIKeuEP6OxwcTbzeTcD8NZkX1VmHi
 41cWPyFfvEOLeOgnZTzgt6ZdEufyh12L+L2S95thUQP4UUHDHQksQp+kDZTTXiPA8/hRH95uL76
 nztT/+i0/9E8hokb0qoHon1ESmUP3Uv2MavnB/D+04tfkFN2qndnjAJ82L01ibfYpKgMw86c1YO
 WogBZPO+jG+/50wvYhdlJV6lE2AHd3Nt5bDkNpvVFRDzrC5R6meynPP9ibmXAmvNGhlNu6bOBEN
 u40LoyWdCHIStEYeDkGVHmEAUGN/V1Wh063vhH/z6t0Nuc4jH73Y44nHSl3VjvlqZjrKZ7Ek1Ez
 V78g/mr+zX4Y6KIxokEfyFpNdwWZ9zEttAqdlG9zAhloUXZOMSEB/NFn6VgZlsgfGg+npHm/8hV
 OUJuI4LAg7db9IeIWRg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a726101 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5G4Ra-IeXjtJARzsYCcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FDR60Dqcav0-YVVsWEDOnPuD8g-fJs6a
X-Proofpoint-GUID: FDR60Dqcav0-YVVsWEDOnPuD8g-fJs6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040176



On 8/3/26 18:12, Harald Freudenberger wrote:
> Add base support for cpacf protected key handling.
> Add support for the pckmo subfunctions PCKMO-Encrypt-AES-128-Key,
> PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key which deal
> with protected keys. These pckmo subfunctions derive a protected key
> from an AES clear key by encrypting it with an internal AES wrapping
> key. More details about protected keys can be found in the
> "z/Architecture Prinziples of Operation" document.
> 
> The qemu version provided here is only a fake intended to make
> protected key available for developing and testing purpose:
> * The protected key is 'derived' from the clear key by xoring
>    the fixed pattern 0xAAAA... onto the key value.
> * The AES Wrapping Key Verification Pattern is a fixed
>    value of 32 bytes 0xFACEFACE...
> 
> Add preprocessor defines for the xor pattern and wkvp used to
> construct ('encrypt') a protected key from a clear key value with
> this implementation. Also add some static functions to 'encrypt'
> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
> 
> The preprocessor defines shall be used later in testcases to
> construct and decode protected keys.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         | 29 +++++++++++++++
>   target/s390x/tcg/cpacf_aes.c     | 64 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 21 +++++++++++
>   target/s390x/tcg/translate.c     |  9 ++++-
>   5 files changed, 124 insertions(+), 2 deletions(-)

Should we add IF_PRIV to insn-data.h.inc? POp says PCKMO is privileged,
but currently it seems to be defined as reachable from userspace:

     D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, 
S390_FEAT_TYPE_PCKMO)

This may mess up the test, but it should be convertible to a system
test, which can be written in C, see tests/tcg/s390x/mvc-smc.c.

[...]
