Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3D43F4B7;
	Fri, 21 Aug 2026 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341323; cv=none; b=f6PvS6O/p3OW4pKmgq8G6qC+q38AzfUBsI5OowxBBVAor3iWHfH47/RlPx0oK/skPTSKpaoTVYvlKRpB+UPbWWl33W602Bgp9jVb/0MbJ25FEVhVQyI3U0HSoGJuw9p0UdMRJyM39TJSNTpZkOO2WDl+9vAxHHdTovnxDqc9U1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341323; c=relaxed/simple;
	bh=LDotAO2qFNLBTJP+ewkhg+DlqWWHL/K/vUWbC85vctE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KgvaPaEG2ZIO3EK+9/zUoCNFaRBkOBB9ix5iCb4ahcIEkYFR91y4lUuqAp3WOlv/+C1L7C7k1+jfhyaugVnZ5nkG1Upv7TEF6pT+5nF0mlHQY4ozoOLoEZfMoV8GWTb0t8MBVgJWw722qrPiTiLDvOl5SKO8Isxml8fPm1LclEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SdlZPD72; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SdlZPD72"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVpWH2387807;
	Fri, 21 Aug 2026 19:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YUeUuT
	QZafZ9YDEHPQegVTAX2bLSddDU8Fn7z2tPMA8=; b=SdlZPD72VCOKaadqy4pTNS
	s5kiK1gq6f1fH52EPivPHfM+RNzc3JeoemOnPZ6c1Yu+jHnrc0q+exFH5Nj6HGLk
	jsi48C9BLc03yOF3JL3L9VFNPSmFKuruYcaBQU0o7lLg1p5lLoFpzpV+xnBfFkwS
	3MgfROzsOhkScIrWclvCqPCuMlbY53C6JDjDdK1DYcBEsv/6DckJS5a/T4B5bjFg
	i8914wWDoTOyvb6f5SFTYxsj0DMUAVd+fTlXjoAo7YCRNifey+PVMnb1nt++jrKF
	ZJieXFG3k7kMbQBx3kpabnA9FzqxUzZWLoKxg/NIXoh+tg8HF+tTLX1AJlLfMziQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4kkhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHs3008701;
	Fri, 21 Aug 2026 19:41:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yxbre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:41:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJfrbA10420676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:41:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C03772004E;
	Fri, 21 Aug 2026 19:41:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5739520040;
	Fri, 21 Aug 2026 19:41:53 +0000 (GMT)
Received: from [9.111.132.173] (unknown [9.111.132.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:41:53 +0000 (GMT)
Message-ID: <bf5c2515-d908-4b08-8ae8-45c1502df3de@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Remus <jremus@linux.ibm.com>
Subject: Re: [RFC PATCH v1 25/25] unwind_user/eh_frame: Add prctl() interface
 for (un)registering .eh_frame_hdr sections
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
 <20260818144954.2320378-26-jremus@linux.ibm.com>
 <20260818151727.1D4C51F000E9@smtp.kernel.org>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260818151727.1D4C51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88aa06 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=AirpqK9rLEaivpbpGasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: djzNX1Og1TZMDnrqsraDecR3x9v8ocSa
X-Proofpoint-GUID: djzNX1Og1TZMDnrqsraDecR3x9v8ocSa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1OCxrAELi9V1
 VAjNr0NddWpIV9MRaD/Z86vlkSAuN6Q5qYUmEPB7g/p4P1IdHzmoFcBZsVS6nl5DiNAzBMaPtZq
 /9Kzj0wgtSXpQc7Bc+XCVEXyvu5MMvg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1TvpOxKhrX3f
 t7V4io5WjZDJml+T3brcBrnaNw43l1SMPZmvRSFxmHB1CRNXcbqN8np1FIixWLBh4OylMmgXImJ
 iVFTze1mqoo/bB0qXSf4Gl31SW2VsLYP8uN6PlxBHqsf0742c+lFWageLyFLpbeQ2QAGrXAoKT/
 tlAm28ExFPTAKjXrurMsi6MqaL/f574IorX89z+Z5eH1yVpS5kawHs5pK35Jg+g68MF7pp3SB4e
 Z5vPsN7yBGYUpT6O+gTT4N3tJj7Z/xGuAPxZl+z/iYKS5iYCNk3Qk3H4KzonnthkJjREeWQ4tC3
 Ro83p43zJ5LL75y0qi17NjCBnBQ4mhYSL0S5v/b1M4cipMsEkOglMJwyWcOcIsPG9d70ZF3+AVV
 8IbuoSYF/3vw4THtFfdKqWzZoyB5NNhEl0iS+zD/bP9te1LHS69DxJ7kzXRsEd2k9r7kHJmjrHC
 003THFgtvrC5s8KWk7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

On 8/18/2026 5:17 PM, sashiko-bot@kernel.org wrote:
> This patch adds two new prctl options to allow dynamic linkers to register
> and unregister .eh_frame_hdr sections with the kernel. It introduces the
> eh_frame_setup structure to pass section bounds from userspace and adds the
> corresponding handlers.

>> diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c

>> +int eh_frame_register(struct eh_frame_setup __user *user_data, __kernel_size_t size)
>> +{
>> +	struct eh_frame_setup data;
>> +	unsigned long eh_frame_hdr_end, text_end;
>> +
>> +	if (!user_data && !size)
>> +		return -EINVAL;
>> +
>> +	if (size != sizeof(data))
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Could this strict size check prevent future UAPI extensions from being handled
> properly by older kernels?
> 
> If a newer userspace binary passes a legitimately extended eh_frame_setup
> struct to an older kernel, it looks like it will be rejected with -EINVAL.
> 
> Would it be better to use copy_struct_from_user() here to safely handle
> zero-padded extensions?

Steven, IIRC you got similar review feedback on your stacktrace syscall
and rejected it.  Why wouldn't we copy sizeof(data) and check that any
additional size - sizeof(data) bytes of user data are zero?

> 
>> +
>> +	if (copy_from_user(&data, user_data, sizeof(data)))
>> +		return -EFAULT;
> 
> [ ... ]
> 
>> +int eh_frame_unregister(struct eh_frame_setup __user *user_data, __kernel_size_t size)
>> +{
>> +	struct eh_frame_setup data;
>> +
>> +	if (!user_data && !size)
>> +		return -EINVAL;
>> +
>> +	if (size != sizeof(data))
>> +		return -EINVAL;
> 
> [Severity: Medium]
> As with eh_frame_register(), does this strict size comparison break forward
> compatibility for future struct extensions?

Likewise.

> 
>> +
>> +	if (copy_from_user(&data, user_data, sizeof(data)))
>> +		return -EFAULT;
>> +
>> +	/* Unregister only uses eh_frame_hdr_start */
>> +	if (data.eh_frame_hdr_size || data.text_start || data.text_size)
>> +		return -EINVAL;
>> +
>> +	return eh_frame_remove_section(data.eh_frame_hdr_start);
> 
> [Severity: Medium]
> Does this code silently truncate the 64-bit parameter on 32-bit platforms,
> potentially causing the wrong section to be unregistered?
> 
> The data.eh_frame_hdr_start parameter is a __u64, but it is passed directly
> into eh_frame_remove_section() which takes an unsigned long. If userspace
> provides an out-of-bounds 64-bit value on a 32-bit system, it appears it
> would be implicitly truncated to a valid 32-bit address rather than being
> rejected.

Steven, do you have any suggestion?

> 
> Looking at the underlying implementation of eh_frame_remove_section() that is
> exposed by this new prctl, is there a race condition in
> __eh_frame_remove_section() that could lead to a double-free?

This should be resolved by the fixes to "[RFC PATCH v1 08/25] unwind_user/
eh_frame: Store .eh_frame_hdr section data in per-mm maple tree".

> 
> kernel/unwind/eh_frame.c:__eh_frame_remove_section() {
>     ...
>     if (!mtree_erase(&mm->eh_frame_mt, sec->text_start)) {
>         dbg_sec("mtree_erase failed: text=%lx\n", sec->text_start);
>         return -EINVAL;
>     }
>     
>     call_srcu(&eh_frame_srcu, &sec->rcu, eh_frame_free_srcu);
>     ...
> }
> 
> [Severity: Critical]
> If a thread unregisters the section and a third thread immediately registers
> a new section at the exact same address, would mtree_erase() erase and return
> the new section instead?
> 
> Because the code evaluates the return value simply as non-NULL, it seems it
> would proceed to call call_srcu() on the old section again, potentially
> causing a double-free and SRCU list corruption.

Likewise fixed in other patch.

> 
> Also, regarding the interaction with the unwinder fast path in eh_frame_find():
> 
> kernel/unwind/eh_frame.c:eh_frame_find() {
>     ...
>     if (ret && (ret != -ENOENT && ret != -EOPNOTSUPP)) {
>         dbg_sec("removing bad .eh_frame[_hdr] section\n");
>         if (eh_frame_remove_section(sec->eh_frame_hdr_start))
>     ...
> }
> 
> [Severity: Critical]
> Can this sequence cause a hard deadlock or NMI-safety violation?
> 
> Stack unwinding is frequently invoked from NMI or IRQ contexts. If
> eh_frame_find() encounters a parsing error, it unconditionally calls
> eh_frame_remove_section(). This attempts to acquire the mtree_lock spinlock
> and invokes call_srcu(), both of which are forbidden in NMI/IRQ contexts.

Deferred unwinding of user space does not run in NMI/IRQ context.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

