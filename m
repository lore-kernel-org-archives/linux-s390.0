Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974B37B40E;
	Mon, 12 Oct 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814611; cv=none; b=QZ1WsnmlY12yMwN43me4zqU29uVHG9/9r5lySDznacOSouP1f2L5tbwW7QBpFT/eC5BtUS6m1r+ZTPhUFjVEZejwc39OHC2Fcs/2gnSudb1URtMT2JlR/lwh8W/o6ut2LjaTrH8kE9b3aB7O+pUyd9pkTihV4qwv8mTClMHF7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814611; c=relaxed/simple;
	bh=zUapPwQ2aKvZomxvp1cPcukKwSEq6FU5BGbY1W2S4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAHwq4ssLNhj5yZlSzRbmTMTrKWQUKQj7EWP6lnYBzjRRyw+xMin590uH/2pK4Bwh13PywjflgYfUXiiJTcRIyfDroLa/rh30a/aBd5zqhRifaaiKKMuGGmi3/6T+NA38FoiTBTl9tgieAJ4seuk6+1YqB+gKoJWWe/eTda0x24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYx5llzJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fYx5llzJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE8Rq2640423;
	Mon, 12 Oct 2026 14:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fHxkFbND7s0PwNKQHtSlf9ChYeWos7
	FxmdOLHyQZpbc=; b=fYx5llzJqTfzAzeOZXPcPAtaqIttivVn8cxMPNwFhNcb/b
	fHXcNIzRjd2+io4HzWD9/JRWuhFJW/l1nR6BDTSDH0Wu4n/OgcuVQVngg6E4vbph
	HGB5YrEnmAXqfJK2lk4jT0v8jJ2HwUXu3qARtnpsNG9XTJRDjtiVLAF1fr+zmNyB
	CQQyWCD6xrumkjqEEDz/vWg8hVlz/bU/aWuMfl6DXX50dD2UY9lB9KnBBzmJKRda
	KbvXPx7XClxqbQ8Le7qMXoiy60iaz3y242exTJa9GKigiBv0/ZCOjYlEW0Iphkw1
	XJZAFZxhxEAQqFbxh4r5TfNCwCqk0fYRK6je3cew==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh9a81-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:16:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC52et013510;
	Mon, 12 Oct 2026 14:16:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wfwb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:16:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEGjbG43647352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:16:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1132820040;
	Mon, 12 Oct 2026 14:16:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6EF2005A;
	Mon, 12 Oct 2026 14:16:44 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 14:16:44 +0000 (GMT)
Date: Mon, 12 Oct 2026 16:16:43 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/percpu: Drop unused output register from
 arch_this_cpu_add()
Message-ID: <20261012141643.19350G0b-hca@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-3-hca@linux.ibm.com>
 <4907dbfd-3c5c-483b-be25-b0df83af2d20-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4907dbfd-3c5c-483b-be25-b0df83af2d20-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX3l647wqa2ejN
 3StxpWiCKBaucG+BgR0XsGDdFy8MfzORXiPrv/5fLN9wIDp0fOsSm0HVwSBNGHvDcLNhVweZ/Eg
 hjL0UssjxD5Hna03v0ZSjqzZONxksX8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX62O8dxaLVue1
 4/4UQ/YBfA+t+Q+iLErIRaMR4nTDpLEpAy2wVEztFZVrwjNbF0xaghW02YS8GfAZ3lbIYcVys91
 j3z77fJGWGxxyuwTwc97gTgIbDrtQcUyaMXcOn6nkVi1aJr4U6pltpLD48fBKJlGHfHFdQ1DmSR
 b0Lx52l6OdsbD56X6hetx7/sURqXik4ewNUA21e8Gsr3eNVO1zqbBs9O2/Nddm0AQY52Fn+Hq0U
 TIusMStQJggSXKorkhYUeHVXOtSlhFtToj3/w8wmxKIkAUccvxbWEs5PvayVmNFC6/Jll7iJJOc
 rsE+oRTwa60h4W+TA9T6mBuPJ7Ym1i0pNDqa42jbX/IC09bst895lh3WXAXpy3cHyk5ZvCbCgI2
 hP0DnX8qe6zUlrPguF+E6ocr6KiySM6bpr3TQ5cnuUV82oWxg+qlKBzkmMB6K+un0fUSZIQtrhX
 p67B7eK8Gn4/10TK7RQ==
X-Proofpoint-GUID: PG5kwf3nh9OHtsl6I_W3Yr0--kh8mfM7
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6accebd1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8vtpdM4DfG_b6hf76xgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PG5kwf3nh9OHtsl6I_W3Yr0--kh8mfM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

On Mon, Oct 12, 2026 at 03:24:20PM +0200, Alexander Gordeev wrote:
> On Mon, Oct 12, 2026 at 01:42:47PM +0200, Heiko Carstens wrote:
> > The laa/laag instructions return the old memory content, but
> > arch_this_cpu_add() does not need it. Instead of allocating a dedicated
> > output register old__ just to discard the returned value, change the
> > val__ constraint from "d" to "+&d" so it is used as input/output
> > register.
> > 
> > This reduces register pressure.
> 
> Do you know whether the compiler is may be smart enough to select the
> same register for old and val himself?

In theory, if the constraints would allow that, yes. But for the preemptible
percpu inline asm all output operands need to be early clobbered. Therefore
gcc is forced to not do that.

> My concern is if we force the compiler to do so we might lose optimiztions
> where the val could be reused after the op.

The overall size change of the kernel image is six bytes :).
I guess we shouldn't spend too much time with this.
