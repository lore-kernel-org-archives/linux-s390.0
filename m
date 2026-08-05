Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034183EDAC6
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917438; cv=none; b=XPQySg+CrxGxHjZncgCjzNkUUGJ+yBQcSnoVcCOG8rS+Z6M+9Wzri/39tRqXSR4xEFXSDTQvZYfeiv0kvV0IOJVftarMGU/QNHyZpLWtt8pis+o1neMVwCdFbcDI4V3CVokQK0Bt54RkCx7OXvLNitoRwWMUgnzaakZz8ZJScT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917438; c=relaxed/simple;
	bh=JDSWNr82NAncRYZzpvndfymip2hNUS7+Q3O9Om6/23o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gfsL+CRiWsEmtEU4rlFmJZZSg8I4zSP4NA1yZcgo10ZYBQe/umdQ3KjUnSl6zn7291Yk9Dv4atwC4LGmARRIl+53WHKAHq1WiQKTZ4pY36RruNKtKifqLEFTnrMwmLToZUHSBCwVbyAdJZfNNrUbsmZKG/0Pb6LU+MzXsOCwWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BUApLhOA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BUApLhOA"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mbmF2909669;
	Wed, 5 Aug 2026 08:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=w9ZgLsbC7JzXGxMRSfsnoCJ3ygWJEmo50ac+L1mrrNY=; b=BUApLhOABxoO
	OLxGZ5sM9EG31nUz4ok52OF000TOfyWru9n2JDjF2GQv7PzQ25oQmSzkYEO7bNsV
	mU3+eN2+c9rEz8hVeVxv9wADBV1jZ8UDXz3j3Js52AS+dH4RIfNdsJYI3L1/WL69
	yHLaYGs5Rr0K/5a5oLd4H4smzFFunD8ehl9MjgEccHwA0A/12O5H+2bH/BsFyfN6
	uS70OHYbnFGeqaX3mEoM6XS4opPKG32h1Y6jsN3qvMVOXfetM4VzGMFul7xqzc6u
	hO/QonE4Si0UG2xg6a9DOESF2cV0OJhhJdckmpd7P0sY87+xopDuHxvdvFCo6zQT
	eYx4sIaBPA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hstu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:10:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6757uGGe004408;
	Wed, 5 Aug 2026 08:10:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgdfb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 08:10:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67589dih19661542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 08:09:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 233525805A;
	Wed,  5 Aug 2026 08:10:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 299A05803F;
	Wed,  5 Aug 2026 08:10:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 08:10:16 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Aug 2026 10:10:15 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v13 11/18] target/s390x: Base support for cpacf protected
 keys and pckmo
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <43620560-24a4-4138-af95-666c30bc7441@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-12-freude@linux.ibm.com>
 <43620560-24a4-4138-af95-666c30bc7441@linux.ibm.com>
Message-ID: <995d86447d8f655b10207f2f9a07ddb8@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2MCBTYWx0ZWRfXwQZeP7vSARex
 vJlcuJAr65LPzCySHMSXHD31gmqV6ZyVHvaSfz7/TC0DAeyMUBjJRBn+cm9B+10Ml5BgIUyJ9kN
 ogcOl9aNw1sOA2rxcqgew/KVQJsO7do=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72efec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=0jlDs2E3eZYV-S1jJyUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2MCBTYWx0ZWRfX3ZFBDn5yliDk
 kyRRMtxPf+TyI/v+Lab9cMl20Ccc7B0HSyYmERv3h3gwZKJDifdUA2ESaEPppqRkxBpm+NB2OZv
 9iEMMpM7OqqqO/Owkj7g394Je9aVHj4RZ3vBZHzBX8G5+J8xGo+qC2uWBInDnnVDc7FqsvEre/t
 aFAypeCFRo6u7+Ig4DUg0GeJ1GA+3UuKGDYdXDEWTdS/SJXym0g2ORiHITQ4EPNIbzJ5Thbg7Lr
 YSpmyxZxOb7Te0U5uxn1DVLUD5M/Cl+nfNIX+7byrJwhertD5ApiVuExez7+WRgo3xD1mVQw7aC
 8dChBVTZhHjivHSGA5IaoxaHjYJgUWHT90k+dPNLViWXKeThm8LwXOEznutF2FVYIGp/z7mgbBt
 EiY93c+GHH/Bq5CTKLfJ7Kh5z5044F1Lu459G8gtYUUf2aCAHJvRjhIwkdBo536GD9AOg4ApRCY
 bS5gOZ31AUd+OPFxHRA==
X-Proofpoint-ORIG-GUID: Gu2-HTkh5Ft3y3KC22ZlV2LBbSkfz3IQ
X-Proofpoint-GUID: Gu2-HTkh5Ft3y3KC22ZlV2LBbSkfz3IQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050060

On 2026-08-05 00:00, Ilya Leoshkevich wrote:
> On 8/3/26 18:12, Harald Freudenberger wrote:
>> Add base support for cpacf protected key handling.
>> Add support for the pckmo subfunctions PCKMO-Encrypt-AES-128-Key,
>> PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key which deal
>> with protected keys. These pckmo subfunctions derive a protected key
>> from an AES clear key by encrypting it with an internal AES wrapping
>> key. More details about protected keys can be found in the
>> "z/Architecture Prinziples of Operation" document.
>> 
>> The qemu version provided here is only a fake intended to make
>> protected key available for developing and testing purpose:
>> * The protected key is 'derived' from the clear key by xoring
>>    the fixed pattern 0xAAAA... onto the key value.
>> * The AES Wrapping Key Verification Pattern is a fixed
>>    value of 32 bytes 0xFACEFACE...
>> 
>> Add preprocessor defines for the xor pattern and wkvp used to
>> construct ('encrypt') a protected key from a clear key value with
>> this implementation. Also add some static functions to 'encrypt'
>> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>> 
>> The preprocessor defines shall be used later in testcases to
>> construct and decode protected keys.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         | 29 +++++++++++++++
>>   target/s390x/tcg/cpacf_aes.c     | 64 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 21 +++++++++++
>>   target/s390x/tcg/translate.c     |  9 ++++-
>>   5 files changed, 124 insertions(+), 2 deletions(-)
> 
> Should we add IF_PRIV to insn-data.h.inc? POp says PCKMO is privileged,
> but currently it seems to be defined as reachable from userspace:
> 
>     D(0xb928, PCKMO,   RRE,   MSA3, 0, 0, 0, 0, msa, 0, 
> S390_FEAT_TYPE_PCKMO)
> 
> This may mess up the test, but it should be convertible to a system
> test, which can be written in C, see tests/tcg/s390x/mvc-smc.c.
> 
> [...]

I have no experience in this. It is a privileged instruction and thus
should not be reachable from userspace. So yes, it should have the 
IF_PRIV
flag. For the tests: I explicit skipped the pckmo test because of this.
And the other protected key tests run fine as they all "derive" the 
protected
key from the clear key according to how this fake implementation works. 
So
the protected key tests I added should run fine (as long as you don't 
run
these tests on real hardware).
