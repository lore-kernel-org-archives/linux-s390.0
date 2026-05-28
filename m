Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FF3F6C55
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979760; cv=none; b=WGDJQ0VmiTtmfBMRGk8tWRRQyETmOLdm8cRHnUkJ7zT/jctIh7RwUtEGl+flqO+m2sugRXNx6ZWirGK7nW9IOYKBZnQJovfHPeTm6xa2/oe7N3MJl4DDH8lXkrRimSZZ3iWYohCyHTzv9bcXonv/jGnrAQRsgyRv3LXqx+k3fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979760; c=relaxed/simple;
	bh=TPOHVAcISAJ6rVDl4VKS+zjAnz2tpw8dmAALLVUExlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGA/IfQkNso8I/vucEZ0IB2jK/2Rvi9nlXuRLpKYO9+mhRkPVGdU0UimMM5y4+GuIvNQYaXjxvs/1imrRwqqrRvLW80zuB+MVA6IxYzIQYb77CYxrmcb5AIJ8Sl8sage+CaVN/oetBLl7xIOzewQBOV86zOZIx3EwWSixw8ABis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QygChVkB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QygChVkB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SChL363426455;
	Thu, 28 May 2026 14:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sOtkq9OrxCckqv56LtiU1CUtbcSfo0
	idpV0RvNi4Fjg=; b=QygChVkBTItLhPOnC2PnHbHsRosuZNDhOXHg7mghKUMyOq
	LxaVRS4DVeknYzLWkY28z7zpuJbRAHzIwz0HJJyFeD4m8XktMYMizPmmdJ56Ao3o
	snLVBoTvm00Lh44XuKX+Q5HItSA6YlMnO2t0ebYM9IBDss2u2mmRdv2MWL14D2pt
	c3e/AKRwClHw/rKF2pIA4Z9fCBxEBv7vnNLrecyyc/vD2ULwJkyTSs3T1FO8dLCF
	Op9SEEiQT9bJNiUITOw89Tf0weMi+DPB1QuelFl8wxdGtynCGClj92uZaBpLUHgN
	r0E8fOJMXUtKqT6SZYpzlgv631bkeegckQ8uQo2A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884kkjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:48:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SEdA1r005467;
	Thu, 28 May 2026 14:48:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8k96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:48:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SEmiPP48169302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:48:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D9B820043;
	Thu, 28 May 2026 14:48:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B7FF20040;
	Thu, 28 May 2026 14:48:43 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.54.90])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 14:48:43 +0000 (GMT)
Date: Thu, 28 May 2026 16:48:41 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/6] s390/drivers: replace __get_free_pages() call with
 kmalloc()
Message-ID: <894c759b-fe6c-4dfe-8b60-3b74916498c6-agordeev@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a1855d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=_0kljoH3NqQINkRqSNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BGORt5uo9OajWRykRkKtDSf8YpUJfl2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0OCBTYWx0ZWRfX8EOWP/s32i+O
 jJFi6pP43BK532dKme8PoNmQioVG4EnXO/KY5adXBQYYYC+o7N0CLtqrq733XymTeXmXolLRcFT
 Mzau1pbHeI5PX7ivVaz8qpnXHbw7fAQlueAnXRrLqyJoZi3rZk1+P87C5KjyIUvlRPrd6IVVzly
 hQQXJgBqIB48SrTXHKKSkaiGizVjj3jIvNHwJjOoF+TSvddhYX+VQ6ct4cLBhfaVNNGjuQ7duIL
 OCYV3f1DdNj+kSjiOafeRcxu4MFySiwoOKzINnOTrhSDf/FRY0y4f2IDKqxo0P+9TpoFYnunyyq
 dPaEEY4TJJYJ71os0RvC1DrmG8gvYWYnzIVYNi0eVjPVu5ETsi99Cym6c0LGGwX+j5sETa0Mmjz
 2+e2ugE081Pp0HVmd1O2vGWpcsRNe0YohniVllXLyqTT5QAf0WGjmdAog0poV7/ikd46nWfiJck
 fmSl07jdxTPYR/s17MQ==
X-Proofpoint-GUID: BGORt5uo9OajWRykRkKtDSf8YpUJfl2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280148

On Thu, May 28, 2026 at 10:09:48AM +0300, Mike Rapoport (Microsoft) wrote:

Hi Mike,

> This is a (tiny) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> Nowadays the right way to say "I need a buffer" is kmalloc() rather than
> ancient and ugly __get_free_pages().
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-drivers
> 
> ---
> Mike Rapoport (Microsoft) (6):
>       s390/con3270: replace __get_free_page() with kmalloc()
>       s390/dasd: replace get_zeroed_page() with kzalloc()
>       s390/hvc_iucv: replace get_zeroed_page() with kzalloc()
>       s390/qeth: replace get_zeroed_page() with kzalloc()
>       s390/trng: replace __get_free_page() with kmalloc()
>       s390/zcrypt: replace get_zeroed_page() with kzalloc()
> 
>  drivers/char/hw_random/s390-trng.c |  5 +++--
>  drivers/s390/block/dasd_eckd.c     | 12 ++++++------
>  drivers/s390/block/dasd_eer.c      |  4 ++--
>  drivers/s390/char/con3270.c        |  8 ++++----
>  drivers/s390/crypto/zcrypt_api.c   |  6 +++---
>  drivers/s390/net/qeth_core_main.c  |  4 ++--
>  drivers/tty/hvc/hvc_iucv.c         |  6 +++---
>  7 files changed, 23 insertions(+), 22 deletions(-)

Did you use a particular tool/script to identify these locations?
The immediat question would by why these sources only and not the
others that also use the old functions?

Thanks!
