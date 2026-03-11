Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313B3B3C07;
	Wed, 11 Mar 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239793; cv=none; b=n6Dkzariozjz3l7Hfttir7RALWx9CJbCqqqrOfNe3kfCzsDPN86T5bdHIiHNhPDfdMVWVeagIT46NpnYKLRCFsUBvNiuzN2m+O7QNExO3y8U/FcdEGeEGVG4bLf/RtyB0TYxfhKTvcHb7BdbwhjQajIGad9871Akeyprlx0M6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239793; c=relaxed/simple;
	bh=V328O5rSJNCCl8RQuMxH9t/9o0wbmZS1Zxog0pFiq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xdakrve0JQA72emPrwy1QrBUfmgz4P6vZ4jRG/amAKqAXEreSWnt3J7/AYR3mQK7l4YqKOe2MOqOG6Bk+oIG/f02v//vnQvpoV7ymb0zzyrnLo4VGhpqXbFRiFOJd1W7yi8wSVrhl0+FILqg9P+Nzit6/kw2lM+gFSkDdNEiW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JqPW3E3D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JqPW3E3D"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BEYtC01601192;
	Wed, 11 Mar 2026 14:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qGOQ++kji+lF53f3m0uaom+NlANcIC
	6dIDrtHr6PV1o=; b=JqPW3E3DQk3uIBAyEPSZnkwF5/EYYLyFLvQOdo+1XLDdEJ
	LAFvbMFX/xv3TuWSVJHV0Y/RUQdmBpbFzwGqe49LKpNNO7pjDH8lam7O9DJq7+T2
	bYjhNg6m3o36pVRBXLYfNWrJbXYT7KOfLH5BnehFlZ6YNK/zusx7F33G2X4Z0mrZ
	+5EyCbsXheXlV6/cmWCnmCyuL8HXCEoJin+IuT5qSIiJ55MRIR7A62ngAeXSHOVF
	hWULa6TGLXFkV/YBja/Q+CZQCaxvojlbzU6ig+g6lRmG4n7NZwFA2pof9E5evi4g
	6j2B2JonFu8VVPPTPwbBO9pWg+x3kPaHiutNDZAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrfvfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 14:36:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBtBK3022994;
	Wed, 11 Mar 2026 14:36:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng6rma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 14:36:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62BEaQu529426160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 14:36:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2045F2004F;
	Wed, 11 Mar 2026 14:36:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E792004E;
	Wed, 11 Mar 2026 14:36:25 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 14:36:25 +0000 (GMT)
Date: Wed, 11 Mar 2026 15:36:24 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: add missing secure storage access fixups for
 donated memory
Message-ID: <20260311143624.9469B65-hca@linux.ibm.com>
References: <20260310150408.160722-1-frankja@linux.ibm.com>
 <20260311070053.9469A4e-hca@linux.ibm.com>
 <799ed972-6527-4cc3-8c37-30c07d30adaa@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <799ed972-6527-4cc3-8c37-30c07d30adaa@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyMyBTYWx0ZWRfX0XLkJWVn5Wj8
 z/VIIl9JDuqaZJd/OBioHi2LvBKcqEUJPkOhSlRJSsVsRkb1Sr02xzmqcPweqTmh+BET7hRRyON
 d6qfNiYnqRHzEHPZGUIwJ2JDolbwExmRt+1XoJ8lLreNfmKo07r21n47pX0KaO8r8k62zBlFZCr
 WF7ZYlIglQvtpAUFHTYsc/d1knDWrUZvTqLwqE9aKD9l1x4I4LnBJwhY8ugWyqFriE/acrq6Raf
 68spFn/DNaUPULy1fL0VWtwiyFNmZO1qa5YyeEESROQ4uDia+cy9R7ru75u4wCspAlzRzXcLntp
 iyE5tWD6Fz6EiO6rHReUIg1hTTvOofTQ1mmirycQ+fWrDbOvtlNiLUStp5NHMzK+1KJIzAVW7Wt
 9ZGxXdNWcOnGQf2uDfesHd1OAQutz9s7TLwapgs2oIWaK4ZHxliD6ShFhNZdFHRTXoscCIBFIZ6
 qo8bMZ6/HGr3kN2+Pyg==
X-Proofpoint-GUID: LTS7m8Lw7aT2pFHLoiII-O5WpxcsqZms
X-Proofpoint-ORIG-GUID: LTS7m8Lw7aT2pFHLoiII-O5WpxcsqZms
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b17def cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=eyfWA11qyyJwkSt3zLwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110123

On Wed, Mar 11, 2026 at 03:17:22PM +0100, Janosch Frank wrote:
> > > -		rc = arch_make_folio_accessible(folio);
> > > +		rc = uv_convert_from_secure(folio_to_phys(folio));
> > > +		if (!rc)
> > > +			clear_bit(PG_arch_1, &folio->flags.f);
> > >   		folio_put(folio);
> > 
> > Isn't the clear_bit() racy? That is: another CPU could make the page secure
> > again, set (the still set) PG_arch_1, and then clear_bit() removes the bit,
> > and we end up with a secure page where PG_arch_1 is not set?
> > Which in turn would arch_make_folio_accessible() al
> > 
> > Or is that not possible?
> > 
> > Just wondering, since __make_folio_secure() requires the folio to be locked
> > when setting PG_arch_1, while clearing happens unlocked. But chances are high
> > that I don't understand the code.
> > 
> 
> __make_folio_secure() checks the refcount and if the comments hold true, it
> should protect us from a flag being set as long as we have the extra
> reference which we should have gotten via folio_try_get().
> 
> It does not protect us from a double clear.

Ok, then it should work. Thanks for explaining!
