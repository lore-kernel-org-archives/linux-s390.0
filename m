Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56A32C932;
	Fri,  7 Nov 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529687; cv=none; b=PZtYdeh3Zn0OfCuZeaybfmtpiw1R1D5g6TrAeDjGX3BZtcUwwByx7Eeyqc6I9CG7MIEpyxfbcabWFuIGFa4Mwozkyt4KaxNWRWIxf43faRROWxxlbRRd78SAUo+p4EAikBToqsa4kILQUNke/+UxR/4YpkgRiB52aTYD8mjv6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529687; c=relaxed/simple;
	bh=PVOMoLsv/C8FHk8RKmDDwOhTloxRr5gc06LUKvLyMCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw+n0AUeLooG1pb4Xjq5M5Z1RcP6w4vgDBAmFvUWitx0aBTaebx5YjDPuxaJVSnV2GYXgGyqMEQeqo6JTnltpwxP1uOEsiyitlEJcam9G/C5XW2qat+sosCfXmgxlZ8dvRt/AIaZ7HjwuVubJfrDGI415LKtHdKDmK5R/ksaJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DmR+SrlZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DmR+SrlZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Esa9i030417;
	Fri, 7 Nov 2025 15:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YmobMJ
	csCJcwwI8/kU9x3dKjZAgMtB9UEjqodE7qgtQ=; b=DmR+SrlZ3fFDk5y5DrqJaT
	3VNAlrbHI3fbIVIIfQuSOUZmaDcmiW5rtMKGQHOzzJ04wFm8YLMkYv1NcL+KQaJE
	lPEDYOcTmjFNF/p0YFfCNvmROk0oQEsMOZDvOooongidOY5M2cHVPPAmuLKcSrtv
	CWF/ZGW/Bi3qlJlf31e6dk8MlfcHFFKuE3yvkdga3zL8u9agbXVY4g9lWbeWVWoN
	lE17cVSDpz2AhE67XGImcDDsLZeFYoFPDxLCzVQiUV0gbyjYPaIgiRb4oywkLLH3
	Bwa2yq0OkfHrCI7XuSZhjvG17bg0R4Ty5vqMtj3CS7S8CVGYSLpXVikWDmd82m6A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9jxmr7v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:34:39 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A7FX6mu020594;
	Fri, 7 Nov 2025 15:34:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9jxmr7v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:34:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7CTAXt021482;
	Fri, 7 Nov 2025 15:34:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrk37jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 15:34:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A7FYYFb52167018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 15:34:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0097720043;
	Fri,  7 Nov 2025 15:34:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0222A20040;
	Fri,  7 Nov 2025 15:34:33 +0000 (GMT)
Received: from [9.111.68.113] (unknown [9.111.68.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 15:34:32 +0000 (GMT)
Message-ID: <72ec25d5-e077-4a84-9eca-ce886e2aaffb@linux.ibm.com>
Date: Fri, 7 Nov 2025 16:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/fpu: Fix kmsan in fpu_vstl function
To: Alexander Potapenko <glider@google.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
 <20251106160845.1334274-6-aleksei.nikiforov@linux.ibm.com>
 <CAG_fn=WufanV2DAVusDvGviWqc6woNja-H6WAL5LNgAzeo_uKg@mail.gmail.com>
 <20251107104926.17578C07-hca@linux.ibm.com>
 <CAG_fn=W5TxaPswQzRYO=bJzv6oGNt=_9WVf2nSstsPGd5a5mNw@mail.gmail.com>
Content-Language: en-US
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
In-Reply-To: <CAG_fn=W5TxaPswQzRYO=bJzv6oGNt=_9WVf2nSstsPGd5a5mNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BZvVE7t2 c=1 sm=1 tr=0 ts=690e118f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ZY0oy1BPkzOObeRiG5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyMiBTYWx0ZWRfX1RZyKuD66vMJ
 eIa01JZb2JMXI/qy3VPM6vE5n8WCXkhlk7uNzUQ3CKuEowwO9zxk+mUQHNTenHEnZ+p6IGqc6XI
 lUSONTvT7bnW9zpujYYljr33v16OeLUdaS47nBkbkEawXqKMz+XDgEPAAfytDy3dTbxtxnDgrJW
 ovTJPyF1HIZj5T6PXTLwZtfN48J6n6gnrTiOCV8S5zcl4D6OLSQG40jW+WsojAHelO+5LE97xNY
 VW4Z6HZst5bBxX/cmR2T36OPbKrYqdy5hBbRAhKslspln/Fq07HojJBxxsdOJzYTmiXz3Rfoeo1
 /p7hLGZymH4A9y/e010XxdUHZrGjT/Book/aNbVF+ojiUDTZ1VdTdQ78J87+EjqUY4wXEmmM/cm
 wq98K0wWihWsN9KYPgB0EC/bfr9+Hg==
X-Proofpoint-GUID: 9qF3Hk4uKD18vkj_pkFjCP3ioH97AV6j
X-Proofpoint-ORIG-GUID: b4Vc7OTegufQwkjfSDN4buqtpdpRwd5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511070122

On 11/7/25 14:32, Alexander Potapenko wrote:
> On Fri, Nov 7, 2025 at 11:49 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>>
>> On Fri, Nov 07, 2025 at 11:26:50AM +0100, Alexander Potapenko wrote:
>>> On Thu, Nov 6, 2025 at 5:09 PM Aleksei Nikiforov
>>> <aleksei.nikiforov@linux.ibm.com> wrote:
>>>> @@ -409,6 +410,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
>>>>                  : [vxr] "=R" (*(u8 *)vxr)
>>>>                  : [index] "d" (index), [v1] "I" (v1)
>>>>                  : "memory", "1");
>>>> +       instrument_write_after(vxr, size);
>>>>   }
>>>
>>> Wouldn't it be easier to just call kmsan_unpoison_memory() here directly?
>>
>> I guess that's your call. Looks like we have already a couple of
>> kmsan_unpoison_memory() behind inline assemblies.
>>
>> So I guess we should either continue using kmsan_unpoison_memory()
>> directly, or convert all of them to such a new helper. Both works of
>> course. What do you prefer?
> 
> Upon reflection, I think adding instrument_write_after() is not the best idea.
> For tools like KASAN and KCSAN, every write has the same semantics,
> and the instrumentation just notifies the tool that the write
> occurred.
> For KMSAN, however, writes may affect metadata differently, requiring
> us to either poison or unpoison the destination.
> In certain special cases, like instrument_get_user() or
> instrument_copy_from_user() the semantics are always fixed, but this
> is not true for arbitrary writes.
> 
> We could make the new annotation's name more verbose, but it will just
> become a synonym of kmsan_unpoison_memory().
> So I suggest sticking with kmsan_unpoison_memory() for now.
> 
> 

I'll rework changes with that suggestion. Thank you.
