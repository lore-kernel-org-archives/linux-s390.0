Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629419;
	b=geell1TqkIYJMANIaSVMSpOP7Rb55asJqdib63C7y4cEcZVoH8AK+e5MJT36t4z70X5y
	 JI+8j7ual1BjCoRZL/+LdUMXpnFGpMrM+SMV04kyBcBRHERrwSLci8aXN1DBWD2xP6QOY
	 EX98ZzYqLN3teLgpGe4cI87m2GbqXZxD0fNykZTBj8YJQ3t5xvKKOXrOXYT3Dpl//diCh
	 7JMWt1qG6RiO4Xyerb40aW0sXM1bOhxstm+TORRwTbEgVKPcMTPEnM2SPZaSrDnRzvx1y
	 POd78volpLmIcIaAaoM4zTawJwzh8j3swPzbLq4X1HBRKeq72EdiVdOEGmxv5m/NL4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629419;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wPBQLIAY0/WQRpqDTmMmr5ue3zR9tk6+/FHV656Ch1A=;
	b=Pzlps8RLZVxEqRdvXdR6vIFpY0uhQrCEierg/ALbq7NcKEpC4mKsq6UUD8AN92dy+RRu
	 yZ7fZM9GcuCjR8lw3dOvwk6aCveIoqP3+i/+Wh6V4MxOic18s+4OkkvDC1z3L30DXpOUu
	 vTkfcv/OeLjirU8/dd82Kf9MKRnJQI1HZGSV7Rb7wm3G9RUI/enqTF1oCSaDu4i2D564T
	 fMJK3Yo06qPw1/4X0zbrMne0E5sscXQ6n0CqyOh24V5qkIqsp/nBlxHfEnSpDURS54hkP
	 vBXN5zyFztMkW0WRPr6Z76B0rcz/DCJKJXq1qnWQ0UzxJLDmmvKCqRWEPCRGp+9/+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XyYkTLwG;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DA606E011;
	Mon,  2 Nov 2026 14:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22DA606E011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XyYkTLwG
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEO7L3044590;
	Mon, 2 Nov 2026 14:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wPBQLI
	AY0/WQRpqDTmMmr5ue3zR9tk6+/FHV656Ch1A=; b=XyYkTLwG3O6jx12i87N57E
	MOZot+Ob7I5yOMa8kcAmWolE52VYM8ZSjJPEURaBOeJJhfq77Mvc0NN7Y6C1wzIU
	fD6mLYt3JIhkbswc4LQaOBKDft4q9Q/e5Fe8PNIwJOIEpdFvk2C2luQMXEHSlSXp
	qFpjEJaytV1PkLI1piKGUU2ysulviL8sQkH6RR1u41iVZ4F7cSAIHy9hLT5gob51
	EHXDW/Ca/k1v4jyjagMAVKIbhaaXTEfFWOvQXpa0zIrDH6ZMYrcLbnYj9IkXpn8J
	MqTHyF3zOnVZU9m9VBy6UIfpOKnte1tcJZoGhmiV8NL1rNr6+KZ34R7eUJFPBMCw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhh4xw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:23:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E5xcl1034506;
	Mon, 2 Nov 2026 14:23:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1ve9c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:23:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2ENTqH52953386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 14:23:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F76D20043;
	Mon,  2 Nov 2026 14:23:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41C2520040;
	Mon,  2 Nov 2026 14:23:28 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.14.46])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon,  2 Nov 2026 14:23:28 +0000 (GMT)
Date: Mon, 2 Nov 2026 15:23:25 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: Re: [PATCH v4 3/7] KVM: s390: Fix idte_crste() clobber and table
 type
Message-ID: <20261102152325.1e5a2c31@p-imbrenda>
In-Reply-To: <be03627c-edee-4ada-a40f-85a0f5b3068b@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
	<20261028185422.272146-4-imbrenda@linux.ibm.com>
	<be03627c-edee-4ada-a40f-85a0f5b3068b@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vKh8ZBwAZVk9tNhL-IOEXrDUa1BPF8MO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX1zdgeX/QpndS
 w/JiJTE0ROFF9ly3oYDsBhDK+sBZ8JmvAsVY6wy+EtbpakpGejDjS36wDL+c8lbM/2S86DWnk2V
 LPeHOJMfmPOXayDtekJhVmyVmKHywYg=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae89ce7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Mw0xrJ1rqFrOZ_elNaUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX10rMJLKcQhkI
 K4cj0djOwOC8Ho179TwuLpmGNjgasDVWVT88xq+xkbafu9KEZwca4fhN6otV+kq5lL9RRUOmu/+
 sPR78y5Oix60XYnUfACKl/jezY7pYbKGd0693UbGyG8Uv8duS73FRPqw65VtFbKp1Ml1H2Ct4qT
 WLWLPwSuYhXXl+XW2POC6tmCmAU/anKLM6h9c3dPbRVqhXRqZAvE7Ys/kTirRAdqs1PUbvoNbdi
 vmVcv197B9xLniAwGnvffwIOfFAAmvEkGDAVkAzi2kEDrUQBV+fZqxLsl9fjiMdlwdb0FpgzVF4
 RTlhcUFMI5M2QTB550fQXOMoKQcGcRw4ADcJydmrrrX96k90Q2D5bXeLt4pbTDAMLoMvInbwxWB
 SWXd9grZDiL1e58uEifGF2glAIpaXo+O/8s/wIrLbsTiQPOJX1NNhDq3ybtr0weiqVwD9MDC7RF
 YX7IfvQi6pmj9Jf08Nw==
X-Proofpoint-GUID: vKh8ZBwAZVk9tNhL-IOEXrDUa1BPF8MO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020056

On Mon, 2 Nov 2026 15:12:07 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 10/28/26 7:54 PM, Claudio Imbrenda wrote:
> > Fix idte_crste() to add the missing table-type bits and the missing
> > "memory" clobber.
> > 
> > Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > Cc: stable@vger.kernel.org # 7.0+
> > ---
> >   arch/s390/kvm/gmap/dat.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> > index 687e1fa904d6..fb7e839a355f 100644
> > --- a/arch/s390/kvm/gmap/dat.h
> > +++ b/arch/s390/kvm/gmap/dat.h
> > @@ -640,20 +640,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
> >   	unsigned long table_origin = __pa(crste_table_start(crstep));
> >   	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
> >   
> > +	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;  
> 
> Why don't you just OR crestp->tt ?

table_origin |= crstep->h.tt << 2;

not sure if it's more readable, but I do not have any preference

> 
> > +
> >   	if (__builtin_constant_p(opt) && opt == 0) {
> >   		/* flush without guest asce */
> >   		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
> >   			: "+m" (*crstep)
> >   			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
> >   			  [local] "i" (local)
> > -			: "cc");
> > +			: "cc", "memory");
> >   	} else {
> >   		/* flush with guest asce */
> >   		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
> >   			: "+m" (*crstep)
> >   			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
> >   			  [asce] "a" (asce.val), [local] "i" (local)
> > -			: "cc");
> > +			: "cc", "memory");
> >   	}
> >   }
> >     
> 

