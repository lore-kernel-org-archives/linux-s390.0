Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0255478D
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800907; cv=none; b=MzQg3bBaEWkmvTWV07pTptJFjsaj2Vn5bVP+8DjEQE3p42V6zl5PcvF85jY1Q2Inq2nTscUs+sH7IGnmgVmR9Ie7Zd4mufDXwBq+SjNgaX7ss+JpaUKK8v0Mj5QAhYz3qYWjJJ37t2+2tDS3Fyy1/AMRjA+btKKwzJVT6B+S0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800907; c=relaxed/simple;
	bh=bH98dI2bWANa5DabhXY03GfaPkIDKoPY67KN28Ie+n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCZ4YftIXzuPgtTBcqUSkeVhJ+T7Ok3X9jY0G6jBwp8IYwOvaNty0ls1BaYHqWwJkgnFm/6OTQxIzZ2TViaUg07itPsSV3A7MAICMSZ+3+XNXmvDnozxCDhP868kv4ytQuuFrD4EP9QqTbARK4SxlRIfl41Cw3+L3KEfZNbWwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gBN9gpf+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gBN9gpf+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BwJj2477863
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=apOkWpyVNVdJxe/C+P3F18N4EJFC0Q
	xQMjjA8PERjew=; b=gBN9gpf+IlwRxwFoEsHUQIpTwQHsNE1YgWWkddyTU5jSv3
	kjtnBDrhRh+7YVym4pfcO63bhF+qXtq+cN4dYMxfTavQC+9gBHF0YOyL8Mpq5NHt
	JljXoyxXRKsG4jdpYKo+ZeM+oykNlttPqLVMhAY98ReHFFK3pwNKEHRd6/t1FtkS
	KHtNVCm2j819WXsrB58FNDtERtQAIw8SABNX/gWLpHUXIQ0XmgaIu5u8e7gzREFx
	G4URthRm+3EzjXwHXQnLvH1/bbJif933Z8j45JTAVjHKhJPzgoHZ43ovweCsunfr
	lFPJ2A1OSjxRLL93VvIOiFyTEkPDpzBU6i7Lex3g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78ge9mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:01:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9ntQa014754
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:01:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk3kqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:01:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NA1eu352166940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 10:01:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 780B6202C4;
	Thu, 23 Jul 2026 10:01:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F0E3202BB;
	Thu, 23 Jul 2026 10:01:40 +0000 (GMT)
Received: from osiris (unknown [9.111.90.204])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 10:01:40 +0000 (GMT)
Date: Thu, 23 Jul 2026 12:01:25 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, huschle@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH] s390/spinlock: Add contention tracepoints to lock
 slowpath
Message-ID: <20260723100125.27454A90-hca@linux.ibm.com>
References: <20260723084229.923353-1-ciunas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723084229.923353-1-ciunas@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX87rxK+qNYuMU
 ZqUQ3KAz78lOAS3leRTxIh+CTdjif449VoXDWACMQL8/9IhzovSBs3eazXfMXGKVXv24y+XlgOX
 iNmid6j5ltf6AhwtV27rIF1A5rhH0/TQ8Obaa1lhoZXMdSmx7IP3Cmi+F8jHqCYastG6XV5UaX8
 c20TPcbVFWyvEjxKvSSoYTA5PGf1yjmfQgsm7WNwEqv723QULUV7nZ3shcTTDmGspmuDfWiZ07F
 ZPolRNUmlUg6IpHp/h5zNwvwYiIOKao9SZA20ZbGSI5PZ8IMY9gwOAJ8RJRA8MXYY4yTdW3IXlm
 bw1SSQRCZqeBZAw90tv+pUJsTim40BgX6kAeCSxV/5W/RhRmogR1vPrzQwxSFP10/rK2uqCGkBT
 a61S01b/Q+2SmeZJHW+YMvOtVPNxFIDI0FVLeGfX77xlohDR82j7REYo0W+Ko+kod8DaMenU4pW
 OiGBFKVG+V4lhEFNQ/A==
X-Proofpoint-GUID: ao99hwpH4kGScnb3QjbQtK3Wn8fuJwSm
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a61e689 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-1lojjmjPfbEsR92X18A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX9GtRiHGRbUCu
 moEqfolNwLyJ0omZoGCpYzGLdEl0AJYNd5/P1Su8K775dfpGOQMYMM4iMUJpj4wv0oaqm2IRzSW
 T8PA8PX/SFGJtUNSahhyiIv7ZVYGsgE=
X-Proofpoint-ORIG-GUID: ao99hwpH4kGScnb3QjbQtK3Wn8fuJwSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230096

On Thu, Jul 23, 2026 at 10:42:29AM +0200, Ciunas Bennett wrote:
> Instrument arch_spin_lock_wait() with trace_contention_begin() and
> trace_contention_end().
> 
> These tracepoints are used by lock contention analysis tools such as
> perf lock contention to identify contended locks and measure wait times.
> Both the generic implementation and powerpc emit the same events from
> their spinlock slow path.
> 
> Place the tracepoints in arch_spin_lock_wait(), which is only entered
> when lock acquisition falls back to the contention path.
> 
> Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
> ---
>  arch/s390/lib/spinlock.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
