Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372481F1906;
	Wed,  8 Jan 2025 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341409; cv=none; b=KLgNK14jeCuJevEf/smd+qAUezSVjn5S1K1qs0drizPFltn6lvQaD5z4Mk7baTrSXNzje/Q2ZFRQDp3ZiBgIbq4etinY8lWyr6gSMNtvsPJQl51+7yjdXaDAaIIvoDkRkrYy/C15t6Rfp2vnaczN8kM7hwAlRYxrYWs9cjo7nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341409; c=relaxed/simple;
	bh=WxvWUFjmqHUWgsTV1l7anvVvuraKssbyexALlbeQTBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYp/I0Gufvb6n9sfAUs/+CH+fd4Gz+4d18Dg8RVscI7cDoXEf6jNpu+THY9gLcKoZC/6lR5kaLVoTgBlV+jEdUiF8XFV7Qw2SCnC8CToWqADF2bpON2UoX8Kzk+SXRAfV1O7ipKo5tD5wDl3MjMyW4p+Dll3/0r3fq4CAPC39bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JJ4yAn/x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JJ4yAn/x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5083qap1015935;
	Wed, 8 Jan 2025 13:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JeSQhydEbs5uuiQ3e3wD+ox1kLggsR
	4ZEna9+RgR2rw=; b=JJ4yAn/xazBWJarur4447f4wfDgjNUY/2PLsAdCbDh4WPk
	zil12zd7gAAD/6L/QTdSEtQGtam4a+pkmOLVgh0KKCrHRQ5yIADiz4hN2aYZVOfL
	PQs/xEXLRAwez6B4kNjDlWRml5Cx2sw8p4UBdCAxe86NDZm/iO/qtz+v/NAFWHNo
	TElizQcpeAbFfuxRwxwr+jxsaNu5zRN8bS8QSdBX0omHcBW90Jh7FHMf1t7VoX5q
	9GDzoRfPhwMi6XmyUeU+dyXMrT9yGrRoDq4K/dyN3njG+ltinIj56Ca43s7z5mZF
	q3BBSFQbUYtrNbtgRLyYoaUfjzRTgueAGfMYHSyA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441huc2b7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 13:03:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5089UH11015798;
	Wed, 8 Jan 2025 13:03:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkypyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 13:03:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508D2uUe35914126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 13:02:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5345020049;
	Wed,  8 Jan 2025 13:02:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C71520040;
	Wed,  8 Jan 2025 13:02:56 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 13:02:55 +0000 (GMT)
Date: Wed, 8 Jan 2025 14:02:54 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, binutils@sourceware.org, devel@daynix.com
Subject: Re: [PATCH v3 5/6] s390/crash: Use note name macros
Message-ID: <20250108130254.7704-K-hca@linux.ibm.com>
References: <20250107-elf-v3-0-99cb505b1ab2@daynix.com>
 <20250107-elf-v3-5-99cb505b1ab2@daynix.com>
 <Z31Tp0nMhb/ntUW0@e133380.arm.com>
 <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965b73e7-d0a3-4fae-b0ec-70b5497cb6c4@daynix.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vdH5d42t98bHPmlR73Iz70nttiUQ4qpu
X-Proofpoint-GUID: vdH5d42t98bHPmlR73Iz70nttiUQ4qpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=799
 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080108

On Wed, Jan 08, 2025 at 01:53:51PM +0900, Akihiko Odaki wrote:
> On 2025/01/08 1:17, Dave Martin wrote:
> > > +#define NT_INIT(buf, type, desc) \
> > > +	(nt_init_name((buf), NT_ ## type, &(desc), sizeof(desc), NN_ ## type))
> > 
> > Nit: this macro name clashes with the naming scheme in elf.h.
> > 
> > I think that there is a (weak) convention that macros with upper-case
> > names don't expand to a C function call; thus, a macro with an upper-
> > case name can be invoked in places where a C function call would not be
> > allowed.  (This convention is not followed everywhere, though -- it's
> > up to the maintainer what they prefer here.)
> 
> I wanted to clarify it is a macro as it concatenates tokens with ##, but I
> also find there are many macros that are named lower-case and performs token
> concatenation.
> 
> S390 maintainers, please tell usr your opinion.

Just make the new macros lower case to avoid the naming scheme
clashes, please. Otherwise it doesn't matter too much.

> > > +#define NT_SIZE(type, desc) (nt_size_name(sizeof(desc), NN_ ## type))
> > 
> > Nit: name prefix clash (again); possibly redundant parentheses.

Same here.

> > > -	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
> > > -	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
> > > -	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
> > > -	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
> > > -	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
> > > -	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
> > > -	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
> > > +	size =	NT_SIZE(PRSTATUS, struct elf_prstatus);
> > > +	size +=  NT_SIZE(PRFPREG, elf_fpregset_t);
> > > +	size +=  NT_SIZE(S390_TIMER, sa->timer);
> > > +	size +=  NT_SIZE(S390_TODCMP, sa->todcmp);
> > > +	size +=  NT_SIZE(S390_TODPREG, sa->todpreg);
> > > +	size +=  NT_SIZE(S390_CTRS, sa->ctrs);
> > > +	size +=  NT_SIZE(S390_PREFIX, sa->prefix);
> > 
> > It might be worth fixing the funny spacing on these lines, since all
> > the affected lines are being replaced.

Yes, please!

Besides that this looks good:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
