Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2B3A641D
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340319; cv=none; b=NxdfcKN5MVhHzLrKZfK02+SuoeWy7+4ldZO5DDamMxKVv5O8nHGutS/F9PEXls3HB+QhBhW+/k5oCcFQ7ekNTLGdXPT2sUaAHcfZHjm5yWUrGW07NuVD0Jw/DU7XOsL+A8qi0NSrk+fKOrX8VGOD4YuaU8SBm2LLMYcnko6rjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340319; c=relaxed/simple;
	bh=La4ExA/yGS1A461LDvCcjeMJdYVWxYU8j/jGX6DP5VU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bTQxAnzxDBo4744GAlgjEbCqykO1VUi5cFgHdwajnCIhtDkzvNFfIv7ZELXN37nX9QDgVCkrAUCDc/bZJjKXzWCCOkHU2MFmcZoHd8rWtgCz9oiCyMlxjJxTKJGDACwX/BOXMhSIFEVCajtJ+ZeW7xShtVBh12qMaRtb3xwtZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uc/jPrHV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uc/jPrHV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIIGx318945;
	Mon, 6 Jul 2026 12:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=uA7GvmH83Vnhjmt1HPiPWRXyLHeFtZVCa1P2v7bW7zE=; b=Uc/jPrHVR/lw
	JJFIA9GXdUlOAxOyyTGLJkh3iUl0oWnOzP7TZpz3iuZcPfsy40xJEPzprX8miUtC
	WbWuttUbyMd7q6TdmZCeAeiTexmqwngzXfFIWOrdqiAkSdJi9x8hVaoUiwx1/gnb
	d8f00sxr5o6+34eEhkF1dXjV2kJV3MVrVeyUj2f9eAbfFhyhBXtRAHk/ksj7AwMQ
	pnlQ8oLN0dJZTLLgYNmVf17pNAlv0/IfN5gG/w+zSKv0uKB+Ltv46+gxm5uXLHBg
	3g14pcgbrNDJr8ywhtUTQ4Ig/SeeYrW3ggQ5oBWzfLRfHFWE7nBNTP6Sf+rfdOZI
	dj2gBUjOcA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqh77u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:18:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666C4iiU023125;
	Mon, 6 Jul 2026 12:18:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjwge3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:18:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666CHrfm10945070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 12:17:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 131775803F;
	Mon,  6 Jul 2026 12:18:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158B95804E;
	Mon,  6 Jul 2026 12:18:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 12:18:25 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 14:18:25 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf protected
 keys
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <87v7asjpzc.fsf@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com> <87v7asjpzc.fsf@redhat.com>
Message-ID: <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX/Z0NaF47Vorh
 LebeMpyWfJAC4vT/RmP8QfPuJyh8ORKn/X64qPCsS9P8HRyaJ7yfcltwJj17duvDECs73Vwy1Hx
 n7uk7EOoSKkr9WEvz5y8FV72DRmfYqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfXwyY+FwtrqLlV
 m/YW7CIEGeiV7umWN1HJGRSnhHz745iPXTQ7VbPKgPcszwwCNUWhoyTnC1uVs875X9Kqsk4HMyk
 8r250cBJ+N8nc6KxMCGt4rCg/6SH3oLWT0tE93dAOyqd/pZ6561C65Q1jGSkUm6Dw7N6j9jSpv/
 kGXoEPW9kf/DMS1FaBEACJBSwa2DrlnIyrqYHyGkqjAfnDXewM2BJiKIBFnFH8/hWzGMz0DZDZI
 vGiMv6pi2IBUQg21XotewBeg57zMllLh+tjfLhyLTB3D34EOb9MGOaLnG7FCJXenbBIJz2hgVr6
 G5AhucCCbLJzsCkRD2ORyvnevRkv/gREOFoljmlbD5Nfh2Ghig2N+MrkupHG0vuA46A+hENizV9
 MHWn2gmcN6rBVRnXJZxFevpS6bZ+WGPgpJbJwlW2+RMSOHvDa7q+rhl0cWNP/Y6ODXB6b9A5h0N
 SZ3rbqAmFnE25YEmJxw==
X-Proofpoint-GUID: i4SVJqHdWO1Dya5I3N5bKGFKa_z9yGOp
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b9d15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=RpqUTlpZVrBo7_kUrrwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: i4SVJqHdWO1Dya5I3N5bKGFKa_z9yGOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060125

On 2026-07-06 13:51, Cornelia Huck wrote:
> On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> Add base support for cpacf protected key handling.
>> 
>> The qemu version provided here is only a fake intended to make
>> protected key available for developing and testing purpose:
>> * The protected key is 'derived' from the clear key by xoring
>>   the fixed pattern 0xAAAA... onto the key value.
>> * The AES Wrapping Key Verification Pattern is a fixed
>>   value of 32 bytes 0xFACEFACE...
>> 
>> Add preprocessor defines for the xor pattern and wkvp used to
>> construct ('encrypt') a protected key from a clear key value with
>> this implementation. Also add some static functions to 'encrypt'
>> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>> 
>> The preprocessor defines shall be used later in testcases to
>> construct and decode protected keys.
> 
> Hmm... so does that mean that we only provide the protected key 
> handling
> in the !KVM case for people who want to run via tcg for some 
> development
> purposes? Does the user actually get some kind of notice in that case,
> if for example they run with !KVM due to some configuration hiccup? 
> IOW,
> do users get some clue that they are running with a fake placeholder
> implementation, other than the setup being slow?
> 

Well, there are 2 paths leading to protected use:
1) you have a secure key and want to 'derive' a protected key from that
    to operate faster. This is for example the case now when you have an
    PAES encrypted filesystem.
    In such a case you need a crypto card with the Master Key setting
    fitting to when your secure key was generated.
    -> this is not a practical way for qemu on !KVM as you need a crypto
    card AND the s390 firmware stack.
2) you 'derive' a protected key from a clear key value. On a s390 system
    this is done via the privileged instruction PCKMO. On this qemu with
    !KVM this is the fake I implemented.
    In general it is absolutely not recommended to go this path as the 
source
    of the key is/was/needs to stay in OS memory. So you don't win any
    security by using protected keys this way - in fact you would have
    done better to just use the clear key as it is. Please note also, 
that
    by default this path on a s390 system is disabled - however, for 
testing
    purpose there are ways to use it this way.
    However, this is exactly what this implementation here is for. For 
testing
    purpose you may 'derive' a protected key from clear key or any other 
way
    as the algorithm to derive is clear documented here. And then you can 
play
    around and run tests with protected key implementations.

I see your point: How can a innocent user see that his/her vm is running 
with
this fake installation instead of the real one. The answer is:
If the source of the protected key is a secure key - then there is no 
path
on the faked implementation to get a hand on a protected key.
If the source of the protected key is a clear key - honestly does it 
even
matter which implementation is then running?

Hopefully I could explain the difference.

>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
>>  target/s390x/tcg/cpacf_aes.c | 39 
>> ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)
