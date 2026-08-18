Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A33A5E64;
	Tue, 18 Aug 2026 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066212; cv=none; b=U/70KrP250ZvkfJour2yCmzHRPK9WR6HfP5FkVj6hRlZtcSxXi0UwAKf36ejYBBqKr1qw5k1QRmDDMnyQ8cxag/dQrpg5jRJ4QxVGQMJ046NS2HHxWYV6J/TL6RGGmyP4z7aSaYNIHu9Pt9jrrEchOh61zJawx9/u+fehNtpKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066212; c=relaxed/simple;
	bh=8g0lvH1QOKprzicunU21p8hm8PNe7yyXoNXluQRIgu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnIyzCd75AgF5mNBlFsO5hu1R0LxPkEcCrZlJ6Tw/OKwTFwfUAnM+Va/jf1QtR/NSOI1zL1gAkHCDSS4o8++FWog900gKHleS8m6GFkQrarDEcWM0LFp0MglX5RkoXEXP/Gs1A+/Ay/LVurjI0+3Jf9nHJYSAPKcICVgCUsx0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1RsMlR5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1RsMlR5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3kB4542674;
	Tue, 18 Aug 2026 15:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BBTfdl
	WCh5S0Dlz9uP0L6BD1VyEI2ShB5p8Q7REmr7g=; b=P1RsMlR5uHbNnHekZlffv0
	3It5wkvSaeYUBsx5UL8+ZO/IsKQIZeOtLVRkYsIalVvUf7p/WbLzBDmF8U31Lk3I
	piEdvc8SxDETuyk7PnT6ERbF1tZqwoJ9nV6Dcernpmg8TfTxXmzSYq67Q8v2OdYA
	I0IiSF6hKfa3vqdCDLQkhhhaGrUX7PHDkTsF+cMHDgMQf03L3qSOg6vkLIYlq72h
	NK9icmDh82UeStfi2rCcIFhh00y+azJWBoe7pnKN8p4xuVD2Tqy0GT1/6DKSsL69
	Wer7JqOrGVH19OwTRa9EGwrakUk1NEq6UfZtOoJBYtnXYFQI5Pan3P59f+1+9B7Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8gvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 15:16:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IFBM3J012426;
	Tue, 18 Aug 2026 15:16:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq41d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 15:16:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IFGhZW38863230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 15:16:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA452004F;
	Tue, 18 Aug 2026 15:16:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65F82004B;
	Tue, 18 Aug 2026 15:16:42 +0000 (GMT)
Received: from [9.111.45.90] (unknown [9.111.45.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 15:16:42 +0000 (GMT)
Message-ID: <1d874ee9-4ae9-4775-9ec3-99263cf46811@de.ibm.com>
Date: Tue, 18 Aug 2026 17:16:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
 <2bb8cf48-2dcf-4457-86ad-f1424d9ae28b@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <2bb8cf48-2dcf-4457-86ad-f1424d9ae28b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a847760 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c7WOuCR92LZp97uU81cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfX0PqqnAnPd5jJ
 LXLTTXF8esBpUxjk/WHXrIgLDTAwHL9R9pAP6OvqNbq8VsQvZDsIuFDkUH4fYlt8ZmmXgNW0pLE
 JQvxFltjhxs12gg3lTeta6slSQ332Kc=
X-Proofpoint-GUID: 0bqqpeYg11nTtEKOxNmoW11XuCSHrcjc
X-Proofpoint-ORIG-GUID: 0bqqpeYg11nTtEKOxNmoW11XuCSHrcjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfXyUMHg5qrMaTJ
 jRuy6FZmuV/UNVRSdJyXQ8pvE81MqCJK9E32Ldhc/a/WHFhRLVNzdrHkGPghuCV0S10szM6nWWx
 pZTAnvsCC87opyy2ZEnzR8VbJ/m3CC2VPvBzg0Rk+SXk48ADQFQEsonNsC5ey03ORWqHGYqn+VP
 qqoroEW6upGLGvDSiGYEScbmY/6TidY6ikT90eX1U+sspysYaJNu4H3i0wVef+0JlRXupA1ucMD
 lfLR643ZTDx70Fyw3xbrwHLFX3f3K/dYEYDqUcalKQjKPWkz07pxNyR3mYVlk7IEA29Rdawj74z
 bal9ZKsoh/E2EHS41GuA7GAM7EC+Wybm0c1XENeP62xdpAxf2VxNMReIDkavVMkPuYq4Z3Aw59g
 eLcw4QDfe7BcjJ1H/a8Rc1+7oWxR9htjeYIE3oVZ2I2yxt/q3FoKNr6i1mW/KJuqYRiv7vujXGd
 BxVb7VCu+dQOyOPt/cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180110

Am 18.08.26 um 15:26 schrieb Matthew Rosato:
> On 8/14/26 12:33 PM, Claudio Imbrenda wrote:
>> When the indicator and/or summary bits are set in the guest, the
>> accessed page was only marked dirty in KVM if the access was performed
>> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
>> fast inject path would not mark the page as dirty.
>>
>> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
>> for the inatomic path set_page_dirty{,_lock}() is not needed as the
>> page stays pinned; the unpin path correctly marks it as dirty.
>>
>> Opportunistically reorder the local variables to be in reverse
>> Christmas tree order and refactor to use guard().
>>
>> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
> 
> So I'm not strictly opposed to adding the dirtying on the 'fast path'
> but AFAIU the idea here was to still mark the page as dirty right before
> unpin.
> 
> Is it strictly required to dirty the page every time it's touched even
> if it's long-term pinned, so long as we make sure to mark the page dirty
> before we eventually unpin it?

Isnt that important for migration?

