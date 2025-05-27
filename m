Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD1246797
	for <linux-s390@vger.kernel.org>; Tue, 27 May 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331108; cv=none; b=OSXq8blTqluLH5i8+gkBoDZXE+KqXuG488trsCWmQJzM1TCrAubWYHcmuVUabtRP0uIKKpRD/uQ+P5V/ICUT2MJK6uyckMEnBM9ZUiDVuSdHpV5xmFWVIsbm0gMeW8VXQLpsRI2w6R8u9/KCflz1Xf25Pi+4Fa1/sIbvBv4lOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331108; c=relaxed/simple;
	bh=bb9jsHitSaonBbnn/AkzteC/y0EIkxui/jlrPwUehI4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r94oDCaRl0To6AzCccj8NMMCf48Rjq9Eoga4gKirdY1rmX/lEUQ76ziW8XG3r5+6BbFMNdtn4cbMKruHbPyKVGIigUjsSnkMqJRJCRIZFvhBLEA+PKmWrIqy1VjqHe1rxPTuMFv5qU8SRA3HMR5Gg8rMW4b+G2wcf3gOZHpoQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UBWtmvIy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UBWtmvIy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNO1dt015998;
	Tue, 27 May 2025 07:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=2iVlWZrpsW/Q1vse7AU9Lg9RgERYa5fMreUBelBvjCc=; b=UBWtmvIyzRQR
	vgRWtsgDCf/wc6j/G+SiY59vmBrUpXOrNxIr+jbNvjaDvWTjh3jD/YiMNWPDbNeq
	uUAYHCo1tvV4x5w5KEEkTz2xplvbDPtJp7CNkSP4PwkpLpGeYUE9dIotSZF/u7uH
	EZ52aUBlvCqbitX2XYEnnmGQO252GekUzMHzTfo3XS7iom87vwv2tGO/hgck6CH1
	1WGiLRQxrl7GFeXuEkmbKGhfmBNw8MeFYiwg2PRHPW6+InV1ckuYaX0zx5nE5p55
	SSbqgzPRE43TFMN2Ph+6bpUni8R/uDDQIOoO1pj1wiNlGq7kd7Bmy9gtTnEcV/FW
	vhqf6A6PCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46v0p2gn9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:31:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R70MbI010744;
	Tue, 27 May 2025 07:31:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0hran-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 07:31:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54R7VgTu15598276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 07:31:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 247B35805C;
	Tue, 27 May 2025 07:31:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FB0858054;
	Tue, 27 May 2025 07:31:41 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 07:31:41 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 May 2025 09:31:41 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: Re: [PATCH v5 2/2] s390/crypto: Rework protected key AES for true
 asynch support
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com>
References: <20250514090955.72370-1-freude@linux.ibm.com>
 <20250514090955.72370-3-freude@linux.ibm.com>
 <f958f869-8da3-48d9-a118-f3cf9a9ea75c@redhat.com>
Message-ID: <9939f4a9dcabae4c739b73b3f9e6cdb1@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i08NfntCwl5i0-voOZzDa1vnJXklIiRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1NSBTYWx0ZWRfX7cnufSwjM8bV LfMKNKnfxVcaWcjsr85QSvKGxTigKkYuNoCDY11sNuOiN85OjFe8BUXJI+rTGHsFc9/7tVOvxM/ q9s9PK2m/CHCSmmFZN38jJ4mjrzXEMUlSPLXC0PBLHktgP5zSFypqD8MwYn2zNrSqvc/MXpucVT
 Z93crOmTyDDg/tzKyKBzHdoyWUTwZPLZsPaNPJIPh2EL4a/l30RLk7CRoFCxzhGfisVmHpb7OAM 0V4XCQjET+AX5V0YBWzHtgnkP7gI1khsK8UdvrWuVPtfeyfN3FlxBioMesA+QQ6R+vp3AntS2L2 WhL8gR7wdBNkvpRy5CpICsVjU7ZHGov2Gvxd30c5b0rlDs0XaWUZ2gsSVrr7RzYaUpklXMHCU5K
 LzPkHNLrqsgobJn6BVY5tk9rRLEfI6R9iZThKlxLro0tgB6jGSUXkEimp74BKMbkeeJ9pYJ9
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=68356a60 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FNyBlpCuAAAA:8 a=XJWaxHopa2zISUNvkqwA:9 a=CjuIK1q_8ugA:10
 a=RlW-AWeGUCXs_Nkyno-6:22
X-Proofpoint-GUID: i08NfntCwl5i0-voOZzDa1vnJXklIiRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270055

On 2025-05-26 17:25, Thomas Huth wrote:
> On 14/05/2025 11.09, Harald Freudenberger wrote:
>> This is a complete rework of the protected key AES (PAES) 
>> implementation.
>> The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, 
>> xts)
>> in a real asynchronous fashion:
>> - init(), exit() and setkey() are synchronous and don't allocate any
>>    memory.
>> - the encrypt/decrypt functions first try to do the job in a 
>> synchronous
>>    manner. If this fails, for example the protected key got invalid 
>> caused
>>    by a guest suspend/resume or guest migration action, the 
>> encrypt/decrypt
>>    is transferred to an instance of the crypto engine (see below) for
>>    asynchronous processing.
>>    These postponed requests are then handled by the crypto engine by
>>    invoking the do_one_request() callback but may of course again run 
>> into
>>    a still not converted key or the key is getting invalid. If the key 
>> is
>>    still not converted, the first thread does the conversion and 
>> updates
>>    the key status in the transformation context. The conversion is
>>    invoked via pkey API with a new flag PKEY_XFLAG_NOMEMALLOC.
>>    Note that once there is an active requests enqueued to get async
>>    processed via crypto engine, further requests also need to go via
>>    crypto engine to keep the request sequence.
>> 
>> This patch together with the pkey/zcrypt/AP extensions to support
>> the new PKEY_XFLAG_NOMEMMALOC should toughen the paes crypto 
>> algorithms
>> to truly meet the requirements for in-kernel skcipher implementations
>> and the usage patterns for the dm-crypt and dm-integrity layers.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
>> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
>> ---
>>   arch/s390/crypto/paes_s390.c | 1812 
>> ++++++++++++++++++++++++----------
>>   1 file changed, 1270 insertions(+), 542 deletions(-)
> 
>  Hi Harald,
> 
> I'm currently facing these errors when building linux-next:
> 
> ERROR: modpost: "crypto_engine_stop" [arch/s390/crypto/paes_s390.ko] 
> undefined!
> ERROR: modpost: "crypto_engine_exit" [arch/s390/crypto/paes_s390.ko] 
> undefined!
> ERROR: modpost: "crypto_engine_unregister_skcipher"
> [arch/s390/crypto/paes_s390.ko] undefined!
> ERROR: modpost: "crypto_engine_alloc_init_and_set"
> [arch/s390/crypto/paes_s390.ko] undefined!
> ERROR: modpost: "crypto_engine_start" [arch/s390/crypto/paes_s390.ko] 
> undefined!
> ERROR: modpost: "crypto_engine_register_skcipher"
> [arch/s390/crypto/paes_s390.ko] undefined!
> ERROR: modpost: "crypto_finalize_skcipher_request"
> [arch/s390/crypto/paes_s390.ko] undefined!
> ERROR: modpost: "crypto_transfer_skcipher_request_to_engine"
> [arch/s390/crypto/paes_s390.ko] undefined!
> 
> I think the Kconfig is missing a "select CRYPTO_ENGINE" somewhere?
> 
>  Thomas

Well, with the rework the paes_s390 module has a dependency to the
crypto engine which is the kernel module "crypto_engine". There is
a kernel config CONFIG_CRYPTO_ENGINE but this is not defined in our
defconfig and debug_defconfig. However, when I build a defconfig
kernel I automatically get CONFIG_CRYPTO_ENGINE=m in my .config.

However, I'll check if there is a
SELECT CRYPTO_ENGINE
needed in the paes entry in drivers/crypto/Kconfig

Thanks for this hint
