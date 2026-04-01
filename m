Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A443D516;
	Wed,  1 Apr 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051080; cv=none; b=O7ZOgZo/psRBSHA/W20Ipw2SAgOI9XqbjnUI7p64/tZ32CEsHImyH7dapBACy/wY457uLmaDX3XPVj+vlAddWArM9PZQ+oDaFtY7XaMPds+G7ZdjGjfWeWEe+rco59S1juAm+8zOIz2dbj0i+hpktpsxnhBCm1tq4Xl3IvhT9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051080; c=relaxed/simple;
	bh=NCCL9MW1lkWZbQKyeusPcr3O7J3vajT2Fxl39PL4BMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTCKtuIW3LY26WetqMzyNafgo3BsvQ/lhlvy9p9SV+MY7yBbIW7gztdOqUEr14FoudbcJ4IsVPGaQkCPbcTo4nrFRHJtUtBNZ0qoN3NuDE5KC+pjSnOJIKxfa0XuQQ9fvFdsa09c5G7Mlfp5mW6lY3i7zMRG/WZEPQSIFAmW63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7eNp06f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7eNp06f"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631AJoWA221561;
	Wed, 1 Apr 2026 13:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BPwoGN
	dHOKxHNVyfqW/RpDHtPx+6CPuBh5Qgs1w4CU8=; b=l7eNp06fkV15kGjgtwBk1V
	ubYclMkRHRTyv9GRV3UuOYh5fDUHTOEMy0pIuXDLXB9gTTZxcfI4xC+IhcsYXRLZ
	1PGacueFOEXwL+SIFzusEBm/xjTc0JC4EsRqZlGVJv5ZM4Z0ZO9RcMlM50+CYKJp
	L0LNisiPiQZCR2wXBdvR/qKB7vZP/hwc9N//fWZeUbwNH0T1a2vWEtzeI2nf0k7Y
	DxjMI8JxRrxMIwplqQk6hG8viucSD5W3RHw4RSOuqKDAuUsO3YhBc+sc1KE81bvK
	hy4TZ3Gzh4YSyWprZLCAakEzKoPLb3K8J+iRDP3lkUfMFd+j5AdMydj3+CDynEFQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g20d46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:44:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CO9vq013922;
	Wed, 1 Apr 2026 13:44:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttknp5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 13:44:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631DiWDI27918892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 13:44:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24B2A58060;
	Wed,  1 Apr 2026 13:44:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 530875803F;
	Wed,  1 Apr 2026 13:44:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown [9.61.97.105])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 13:44:31 +0000 (GMT)
Message-ID: <a6aa2b4247110761c9e82b24bfa013e440d8d3d4.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/4] KVM: s390: vsie: Accommodate ESA prefix pages
From: Eric Farman <farman@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger	
 <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand
 <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 01 Apr 2026 09:44:30 -0400
In-Reply-To: <b056c68c-3e7f-450b-ab82-ac5c6d9b837d@linux.ibm.com>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
	 <20260401020915.1339228-4-farman@linux.ibm.com>
	 <b056c68c-3e7f-450b-ab82-ac5c6d9b837d@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd2142 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=aQvsRbYz8yKJ_-ZlsdcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: StG3lHwPHDhZT1-BXYHWx384cF9v1AtO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEyMyBTYWx0ZWRfX3ZHeC2SE4XKc
 Zyl0hoyCPMnDMZ02XL+LSKolcpY36XLp7wGGYvKHRhNanHkcFxEcENS7bVz7Rf2hv4PVf47KAZs
 mzqh4uD1dA1jNv+dxcFRAkz6NT6OItHul+EA0yNho4FkG7tVSo/0TZ+0SnXsY8d1s3W/XtGsUwG
 UHE/3AmZn1a07jGRFI3eR5iS7hONIahitGqZ8Hxf3E2jGrZoTKZwj3hk5beDjzXF+SyMbDC1U9l
 Iw8i/iEHwaVdty5f7bx6Bvh+RIMu8yZ9USVT3GPVoDHS2bHsr++UCH/k5RCidT91ScCVZpiM607
 KdDwMEjnCY5dDW2p0GpCO+jphvCP5jU5t7LzimzAL0XW+MNdtXiElWm3U4gWqpvW4gkknKiyGPq
 jyrUCGR8FD4fRLr8JwffL/TTLUSP6wmcDZiPKul3OJUgrZQoMDlvJRPmfSaYAtCBOFvPGxofBg8
 nvDqxmvLwwWLYlfJqZw==
X-Proofpoint-GUID: StG3lHwPHDhZT1-BXYHWx384cF9v1AtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010123

On Wed, 2026-04-01 at 13:45 +0200, Janosch Frank wrote:
> On 4/1/26 04:09, Eric Farman wrote:
> > The prefix page address occupies a different number
> > of bits for z/Architecture versus ESA mode. Adjust the
> > definition to cover both, and permit an ESA mode
> > address within the nested codepath.
> >=20
> > Signed-off-by: Eric Farman <farman@linux.ibm.com>
> > ---
> >   arch/s390/include/asm/kvm_host_types.h | 3 +--
> >   arch/s390/kvm/kvm-s390.h               | 5 ++++-
> >   arch/s390/kvm/vsie.c                   | 7 ++++++-
> >   3 files changed, 11 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include=
/asm/kvm_host_types.h
> > index 1394d3fb648f..3f50942bdfe6 100644
> > --- a/arch/s390/include/asm/kvm_host_types.h
> > +++ b/arch/s390/include/asm/kvm_host_types.h
> > @@ -137,8 +137,7 @@ struct mcck_volatile_info {
> >   struct kvm_s390_sie_block {
> >   	atomic_t cpuflags;		/* 0x0000 */
> >   	__u32 : 1;			/* 0x0004 */
> > -	__u32 prefix : 18;
> > -	__u32 : 1;
> > +	__u32 prefix : 19;
> >   	__u32 ibc : 12;
> >   	__u8	reserved08[4];		/* 0x0008 */
> >   #define PROG_IN_SIE (1<<0)
> > diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> > index bf1d7798c1af..c0ad8effe3d0 100644
> > --- a/arch/s390/kvm/kvm-s390.h
> > +++ b/arch/s390/kvm/kvm-s390.h
> > @@ -122,7 +122,9 @@ static inline int kvm_is_ucontrol(struct kvm *kvm)
> >   #endif
> >   }
> >  =20
> > -#define GUEST_PREFIX_SHIFT 13
> > +#define GUEST_PREFIX_SHIFT 12
> > +#define GUEST_PREFIX_ZARCH 0x7fffe
> > +#define GUEST_PREFIX_ESA   0x7ffff
>=20
> Those should be GUEST_PREFIX_MASK_XXX.

Oops, I even thought it would be better with a MASK in there; just forgot t=
o add it.

>=20
> GUEST_PREFIX_MASK_ZARCH can be used for set prefix and sigp set prefix=
=20
> emulation at a later time. Those functions currently use numeric constant=
s.

Sure. I'll add that to the followup list.

>=20
> The rest looks fine.
