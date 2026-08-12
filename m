Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242E38F64E;
	Wed, 12 Aug 2026 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552177; cv=none; b=I202pviVt/fAfs/cT/lswjBVo1G16WjN/yiSdhppkOf1Kq6tn3wqhXDGrtiWlFW7MLxapO94dUNUKufKTSQBlj18zdLMaHVSaZgASpqdWeMOnj2zKodMGCTo2A3xEcCN+g2PfLP+6kAESKPXcQQvtWQG1ETEPGy5RAhirEx8GQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552177; c=relaxed/simple;
	bh=HEn/wCpNmD5Msd7tbDXAp4aBDnHOYFgccjk9Gyy1Lr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK4FSfcY4UbFyxQsUQjaX87kaVY1xbA4bzmbi5iRWXK0Ckjke/Tsgf0wUtmTZF7FP1dXqP9jedMKUmeNGuzTGyYEf2NKxfnOgkTYkEBHj3qrSUrZeKMtZIqxspTlDoCO0qUi4nfSi/q0hGPS2Dj1iAzY6c07Jo0CLN00mU6m6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a5kAEoxn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a5kAEoxn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1XHh3686565;
	Wed, 12 Aug 2026 16:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AIMiIH
	8TMO2hH5CQvLgkCbs/SjY3cfyb1oqDDDhovgY=; b=a5kAEoxnfnvpNhZQNi9s4g
	jYgLoDtXKHLPxTEgRh+NmrCYbRbKXVgV4nL06MqgoEG726Y7zQf+Y2/dWbEEsP7x
	zJdyPWqMXHObBI7blzL6SFKF8O+yuFzzHbZpvpAF9r394zianD/3oiU2yzK9wu55
	XsAhFlnSVLALNTKMV4oQAtKHcn1gNLaHsE7NRquCV5OUEoOBwFKqCxh1YGZcYQfo
	PZaHot23DceFkBvk7o1QfGAeiHCe8nDSqWEr2D/2w8qE9/xKOhSbDUU3VQ+q4oCe
	UVkzER36zLHYLyRyg/KfBUIvK8OF+NE+q26UWzTW+OcWiDU7t8EMUs2bMqZdutaA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9uj2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:29:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGQN98025525;
	Wed, 12 Aug 2026 16:29:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq73c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:29:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CGT1iv37749190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 16:29:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B557720040;
	Wed, 12 Aug 2026 16:29:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235D42004D;
	Wed, 12 Aug 2026 16:29:00 +0000 (GMT)
Received: from [9.111.47.51] (unknown [9.111.47.51])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 16:29:00 +0000 (GMT)
Message-ID: <cdb8b0bd-a15a-440b-9d7c-b532aeee6eb9@linux.ibm.com>
Date: Wed, 12 Aug 2026 18:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/33] KVM: s390: Introduce arm64 KVM
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfX+hX7mFaW6Bjh
 4xCRr8SSG/wq0Q+UMJl9NmmG8uBaeovdN3p9LFoVBuIj2n05O9Xa5haiIXy/IyfCpitFHw3T2Y5
 AHZ7IdsPsgS/SRxnXcjYp3txXUmEJ2kBYSOEVVQ9yKJ1xqFL49lTLFC56Osq86LzVj9RFZK/4GD
 h+SvwpYjfUvUrtNZTByDtn0B+bRyvebEr+kbYe84J2sBb7Jm6cTDB4gGa5/vBADEf3k2AB7fEJD
 bywDWvZ+dq7pL6AUpb+pMQX+935cldlW5/PuFsjG4mgEhm3BdOCYGsiFirFtrmlIGpmiKvz4Srd
 oasr65sls7qKDzuJCYf8qHWxbklTwcvqSbfinbxamEvUS6q9h7NWruZ+niQVl1SXbvhwoSvgr2K
 xXw2NwHD6yyB/ukaMq/pPEURfUWVW9XND64Zbecj9Eo0RaQAmPb52Xv3LWF1VaLj6Ln+oD5afuX
 k9VvFw8VEkHZxv4NbBQ==
X-Proofpoint-ORIG-GUID: G0OuvPLA1qfUd-P05KzVUpjgwHFA0jaW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzMCBTYWx0ZWRfXwE7JKEt2/Kf3
 F7to+W1AJesjmvSzOL2+mxlBU92YP003Z60rETV97z+B5KwPoj4WcoR2RDdIkxhXnCOEalWKJVy
 90lPMbfvDXEDKnJ3RsZuadmVz91yHwg=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c9f53 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=cBNhPelFHdF66-ObYm0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9BI-5fV4gFD7mk7NSEYkjJYPa_XF6sj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120130

Am 12.08.26 um 17:35 schrieb Steffen Eiden:

> C) KVM/s390 reorganization (patches 12-22):
>     Prepare s390 for a second KVM module. Move existing s390 KVM code into
>     dedicated s390 and gmap subdirectories to make room for a second KVM
>     implementation. Refactor gmap to better integrate with the second KVM
>     implementation. GMAP hides a few features only required when managing s390
>     guests: Storage keys, CMMA, and prefix handling. Those are guarded behind an
>     #if KVM_S390_MANAGES_S390_GUEST. Only features which implementation would
>     break kvm-arm64 code are guarded. I leave the non-breaking stuff (like
>     shadow-gmaps or ucontrol) for the LTO.

I will likely take 12-21 for the next merge window so that we can minimize this
patch set.  sashiko and claude are happy. Mostly mechanical moves. I will review
those first and might do small fixups myself if necessary.
