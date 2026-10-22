Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692412;
	b=aHXX/EcURS1CLnM78umlp7w7keWWrsooKvzO3VJFpp20QXf27kYycDJeI3eMDmdEp+Pu
	 DtoW0PKy8op1UsuD9O46cYQTt4pBKUWjjx1t17XSS9N5+KGDh201Z5uvmmPaALSvcyv/v
	 VuykxA5M4ffSFt1ERyb/Mm56qOo03V972+MWdC2Uwv7p7IVeECZLumdGbiQBdA3wBPHaA
	 8k0+BaSYQil4YzuRxgHISnncRbUS1Ug6ifj9x7Obhsj22IJd3dxiSkusnBNu1dzS6QrPi
	 YvzLvsbXntiBBqg6jEf4boUcP1/hqS3DmjtufY2ODD2KkUb9R/B9AN+ptX3+pKYSnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692412;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Subject:
	 From:Cc:X-Mailer:References:In-Reply-To:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=15VBZ8uTc8xBQpA0RMeoetGdJtcrTGydQGm3SQqWWXc=;
	b=X0v5EBhjfCEGMWOL5FsM+8IVv+ewt9jbJ1iI6VaxQW/0IbO9RxkxDabNWpps6+rU9CYI
	 3NBnG87OgprN3ttyOaHBsjlqPtDxBQOC9lDLhIsi62ds9tUEHqdkYlYPfU4+0m3kMJWYm
	 nqpgA0tMM3SInwc3XnfHz1OL1n8kIVSuizyU682TB84tsxI5x8s0JykcqKutx1NYSGCH5
	 kfctYJ78kzRlc0kTksL8Xn28FkJOAc6Upq9ifr6IkfGBuDb0CfOqHf6cIppVgYYXB/nZN
	 ftbExoKcQr0iXaXem/hZ76kZUXYGZ0bn5EXAjMov1BL3vgyRsPtgUXrKGA1RfW7Sezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c1ufKJ6h;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5B606A31B;
	Thu, 22 Oct 2026 18:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB5B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c1ufKJ6h
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEhvI3183748;
	Thu, 22 Oct 2026 18:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=15VBZ8
	uTc8xBQpA0RMeoetGdJtcrTGydQGm3SQqWWXc=; b=c1ufKJ6hrx5AKROK+JXfb/
	T4RFvaWQbpGR6vLzXJPcukA5O+2ZN6fF0J+jE8N883rOUTPQrJ5sfTg0HPG1YEj6
	LC+UXKtK1B/P6IZZ+sN+Bsml8MujcweGJ7X93iibC6P0nP/LBk2nO9glsR2eEjE2
	+Y9Fa745PWApdRE7Ty2dNyUrcYzuR17Mz+lONIedNx++m43FZSMdBcRVcN8ruj/K
	hGari+STSLB8c/bChVXt33mzj7Qj1EKN3ij/cpbrxsPDoKv4PAiRFhK7W/bzhN7h
	TJdhV2MTDUclM6ouMIK5QHsqE1zP4iv/Zp/bQYNSY+32sMZr3+dIZa8veAsRElDA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58g7ta-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 18:06:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MI55D2921302;
	Thu, 22 Oct 2026 18:06:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck1rak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 18:06:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MI6hL239125472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 18:06:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BB3920043;
	Thu, 22 Oct 2026 18:06:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D214120040;
	Thu, 22 Oct 2026 18:06:42 +0000 (GMT)
Received: from darkmoore (unknown [9.111.5.109])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 18:06:42 +0000 (GMT)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 20:06:57 +0200
Message-Id: <DMBKFB62ET87.2BDLICLXRFYNS@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v7 12/21] KVM: s390: vsie: Add helper
 unshadow_intercept()
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Eric Farman"
 <farman@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Nico Boehr"
 <nrb@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan"
 <shuah@kernel.org>,
        "Sean Christopherson" <seanjc@google.com>
X-Mailer: aerc 0.22.0
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-12-f39806eaae37@linux.ibm.com>
 <45f3d2f6-75af-41eb-b8b5-a7cf42f345fa@linux.ibm.com>
In-Reply-To: <45f3d2f6-75af-41eb-b8b5-a7cf42f345fa@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX2tdWCLflyklF
 BeduffXllthogpgaA4wRJMfpZWlrfEBKHYdZ7H5s5LGBYaxjKlJ2Bbj65gVSpYnu8xIifdzferS
 UNaAotPhOqXhJQNCGLlreZpmKevnCmw=
X-Proofpoint-GUID: g0Z80MKV0HmxX5JpVgZtrcd0251712S4
X-Proofpoint-ORIG-GUID: 9n4xJHSD1MWMJMtw2E88eEaPS8wLb68w
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ada50b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=d1qtHUbcx_84X537ZBEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX+6CEHYRUPO+t
 7aKy9ekDlnaY6qREc6zUA8oqZOC9v3BpTvWuWs0VkmEWK0rR0JdTk2s2gSUpT4CXFlHHEGbEP4B
 O9j+8TwHNeoVZtav9S/p6hqOT1+qhLGlRy2lascirSISpqe5Z45710USrDWREyxkrtkAJM8gk1f
 B3yC1jOZgxTC+XnhgpIFz9N0Iu07vhcHZJvLdI67z1pvfT4Ifr37/1kZnOB1td+TBAGLTgBWGw7
 MPEeAyMhtktdX3d2H7f187BDSd/0qKy3sPpehwGUHOEeL5lyBZRQI1nxKQQ2H0a8dyE792CjhQp
 7Yi0tBJwKJV1gyD5RrlY8uNBLx1TIFM64ZrfsU/KHWEcfchkhKjzZFvlhzgusRWgydViDzuKeMv
 1rYs2Q+NgtMgfmD7rx7VTcAM+8LwMxJX3dyDs17IvhgF73SKjSAJklD5LYH/lm9tCd83OoM+AtX
 +RI3nfIrU+483TdgIzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220070

On Wed Sep 23, 2026 at 4:04 PM CEST, Janosch Frank wrote:
> On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
>> Extract helper method from existing code to reuse in new code.
>>=20
>> unshadow_intercept() acts like unshadow_scb() but only copies intercept
>> information. Used where the rest of the scb is not yet shadowed.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>>   arch/s390/kvm/s390/vsie.c | 28 ++++++++++++++++++++--------
>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
>> index 95baac9a1ccb..c42e2df4c0ab 100644
>> --- a/arch/s390/kvm/s390/vsie.c
>> +++ b/arch/s390/kvm/s390/vsie.c
>> @@ -565,18 +565,27 @@ static void prepare_ibc(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page)
>>   	}
>>   }
>>  =20
>> -/* unshadow the scb, copying parameters back to the real scb */
>> -static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page)
>> +/*
>> + * Only write the interception fields back; avoid clobbering the timer =
and
>> + * guest-state fields in scb_o.
>> + */
>> +static inline void unshadow_intercept(struct kvm_s390_sie_block *scb_o,
>> +				      struct kvm_s390_sie_block *scb_s)
>>   {
>> -	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
>> -	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
>> -
>> -	/* interception */
>>   	scb_o->icptcode =3D scb_s->icptcode;
>>   	scb_o->icptstatus =3D scb_s->icptstatus;
>>   	scb_o->ipa =3D scb_s->ipa;
>>   	scb_o->ipb =3D scb_s->ipb;
>>   	scb_o->gbea =3D scb_s->gbea;
> I have the feeling that we make things difficult for ourselves by not=20
> writing SIE entry validities into the scb_o directly. And I think you=20
> somewhat recognized that problem since you chose to write the validity=20
> to scb_o and not scb_s in _shadow_sca_cpu() but I have yet to fully read=
=20
> that patch.
>
> For 99% of the validities we've never even entered SIE so we copy data=20
> twice for absolutely no reason other than symmetry. out_unshadow in=20
> kvm_s390_handle_vsie() isn't really necessary, if pin_blocks() fails we=
=20
> can jump to unpin_scb() if we write the validity to scb_o.
>
> Maybe we could move (un)shadow_scb() into vsie_run() and be done with it.
>
> I have some more reading to do.

The problem I am addressing here is that we can encounter validity problems=
 on
the primary/entering or secondary cpus that we do not actively run yet.
Since this would typically happen when we are shadowing the sca (directed t=
o by
the first scb of that configuration) we need to write the validity somewher=
e
before potentially even having properly shadowed any scb.

I don't think I am a huge fan of the idea of pulling (un)shadow_scb() into
vsie_run(), as that would mean to also pull in (un)pin_blocks() or risk lot=
s of
potential TOUTOC problems. We have to shadow before checking to avoid them.

Getting rid of the symmetry and writing to scb_o and failing from pin_block=
s()
to out_put would be fine IMO. The counter argument here clearly is that thi=
s is
complication for the hopefully rather cold error path.

Cheers,
Christoph
