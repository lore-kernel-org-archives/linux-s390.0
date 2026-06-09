Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC133CEA9
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012403; cv=none; b=d6LyK/krw56WNjAK55c7jh+r03XluclvfTHKQUcQCG33i3K2//lBLDAqK2KrczyZO9UNg0lFyBqDiSOgISSj2eLqFIzMUIpQM4cT2l+z86I/0fNgdZkxUSpAB41UbYA3OYTdKwMd8Rj2s4AVbd9D6l5io5j08uXOeSvJF5KEMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012403; c=relaxed/simple;
	bh=LFRf/veA11kkQzydvI6ScwgMJZ+rLr5Ka2TAGQJYvsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXswyUf96HP/6DHcZshMj4diZ9ZA1w1iUZ02L95IN6mfYcxNbzjFZnC6UTaFYw4v4DyKDqLmGVBakGKVUVSlkia2C2nKzS3bjttEOLgNWZPgvdUtvo034S1pWsxDpnDS8TCWgXJT5UBegw9eQssfxwVCDcpJp06hMFbQ9PkRzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Va7VHbha; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Va7VHbha"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6595EfNN3019572
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 13:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Up/SoW97CZ1j4+xHeeOVPgJ/EKfwYM
	hi5Z8xNRiPKvc=; b=Va7VHbha66QkkhFVAvsTZNOJSn7aokFbdvz7D086RIp9nR
	HHd+X0uKuExGlZOrrSwxrXsMjjdRZQIDH66wFGizJ+mrc2BoE7Gh4A5m/jT0u2rh
	dtTjS+9/VIPjveYbBLw+GhEALwRg8TS/UERw5WCuBUD6PCZaeOFWDeI3jmfByqLI
	FusrfVLs0n/YbvpkXp/DlSO2zPEY1wLza7NhdWpYVh3Q9Uh8Q+v9ltzI7UMK1Zxk
	+llHLKYro4mkvKBpRwcY6G4oOSMO8GU8zLFfS6XG8M8y0RgOpSLJ+3Vndaf4u6kX
	5Fr60PRSk63OLdkff6KwIkgS7QH2xcZDQF78cfXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qmc69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 13:40:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DYb9f015021
	for <linux-s390@vger.kernel.org>; Tue, 9 Jun 2026 13:40:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g20mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 13:40:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659Ddvt727263314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:39:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8959D20043;
	Tue,  9 Jun 2026 13:39:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34EE320040;
	Tue,  9 Jun 2026 13:39:57 +0000 (GMT)
Received: from osiris (unknown [9.111.52.116])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 13:39:57 +0000 (GMT)
Date: Tue, 9 Jun 2026 15:39:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/9] s390/string: Add -ffreestanding compile option to
 string.o
Message-ID: <20260609133955.9217F11-hca@linux.ibm.com>
References: <20260609103343.107325-1-hca@linux.ibm.com>
 <20260609103343.107325-4-hca@linux.ibm.com>
 <76d82e3f-429d-46d8-bfad-e7ac0a974296-jchrist@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d82e3f-429d-46d8-bfad-e7ac0a974296-jchrist@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a2817b1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=yrHcOrTGXU9-79JWuGcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0RhEMarAxIbUiF9iiABCWdMS1j83U9GH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyOSBTYWx0ZWRfX6c9HfnEgDG5z
 DjfFY4sOKbcZwExckLFtZmfwucpDfUOvBtNnq6iDvG9pc1rabri6DsXeZs294+WSV0QxQNam9ge
 xxn3a3Nh2XmIV3UL4iJlUExAVVsq29CAzTVQWII52l7tCL6H8gp0mKES6EEw7pOMBLIUKxETnDz
 vW5ZtdOISCrtg8st9/8vQ4NF8xF5fsA0n14MnRJagcv/3z/9c/Yvc6vN0H9yjPgUrienIZAMsE0
 6dV7ZSUccXviDx2Cx3B8FrLsr8ohtBo+BPQPCbyGiDlD7niO3yutoFVc7YWQ998IOiynjCdEIHO
 jnFaPjrQhFclFPQF8HfrjJVUY/0z1DHG47uZ9dY/0ypOACvVaQVPdTdU3E47wRkaNdHo231jpfT
 5OiSxL9jQD/CpDtxpRsh5XeBfiuMzd/TK6KLrfNdGSQZ+/niAJo5gCy6ZYVYKgNQpsJ8zSzsl0i
 kPmobunlf26whVoRQ5g==
X-Proofpoint-ORIG-GUID: 0RhEMarAxIbUiF9iiABCWdMS1j83U9GH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090129

On Tue, Jun 09, 2026 at 02:23:23PM +0200, Juergen Christ wrote:
> > Use -ffreestanding for string.o to avoid that the compiler generates
> > calls into themselves for standard library functions like memset().
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/boot/Makefile | 5 +++++
> >  arch/s390/lib/Makefile  | 5 +++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> > index a1e719a79d38..e1f82d118bc9 100644
> > --- a/arch/s390/boot/Makefile
> > +++ b/arch/s390/boot/Makefile
> > @@ -25,6 +25,11 @@ KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
> >  
> >  CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
> >  
> > +# string.o implements standard library functions like memset/memcpy etc.
> > +# Use -ffreestanding to ensure that the compiler does not try to "optimize"
> > +# them into calls to themselves.
> > +CFLAGS_string.o = -ffreestanding
> > +
> 
> Other places use simply expanded variables instead of recursively
> expanded variables for CFLAGS or LDFLAGS.  Is this an issue here?

I just copied the above from the generic lib/Makefile, since I didn't
want to make our logic more special.

> Otherwise, -ffreestanding turns on -fno-builtin which then turns off
> -ftree-loop-distribute-patterns which would detect the
> memset/memcpy/memmove loops in GCC.  So that is one way to make sure
> this does not happen.
> 
> Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>

Thanks!
