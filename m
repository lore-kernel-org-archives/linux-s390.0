Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067733B97B
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821056; cv=none; b=L6+N2YC91HladwlPiJGtL+vkl/kDC9QLV1kV3P1D0FCednDozvTrppcu+csDjCGvPgr5AhAIvTKilOLMrTnnMTanXOcihwwo+aO9hiLm9vNkRtyjhkRUbXuZwNaIA2Q+GaKE1h+1nrt67WHbZVhTI0xT+xdjShtOL3z5j85kJPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821056; c=relaxed/simple;
	bh=IUjwuCNE79xkSUiO0inp/ZRZvtxGAXYIXaF2EF7gRO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNIFwL9s0FI0mJFbhtT/X8lIHlSxzSRapNC7vVNhER6F7f5aVmhXxxmKUqZjob2eEnSyQJ8XzeAjnr9HXVVxhieI/AGbdmSI+xdUArjDBFDcqfk3yf7Xesev+ri/BcIOjfjb7LWf0UcVcNMXiJAGPUgEio0dd55H+yUG+POTieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DthYCfgQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DthYCfgQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC3se3015647
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ClFTWfj4LCf0+3DYwfTNub1VYuHrBv
	kcWd0RZjxuPaI=; b=DthYCfgQrb/TGOVMBF1T36od9/kdfk0kLiIrIDGl6AcbF4
	l5TVhiVka1HLDIAiLuY2mP6lhQAy2iMS8lXdUSKXfo+yw+2+2PkzfOF0cEZiL4MO
	LAB7phxbWtvEBTTj6CdUJlIbdCozoW0/wFWT1oRTaYxTI3T8qrtU8Y024LraPGXL
	VEj5YQd6Z5bAEpDRuCUpRDtmnkh0w3U6+756e3pY+CH1zhe13LizuFZlLOe0Xekn
	hjnMo14mo/wMAzFTJDaG9D5PkxRxLAqLjne35I0GN/fUG33dDFMFq2gptXjXIU04
	ci5oCWhs6KLokcflwQsYCLIPhK3KZglJKO/A1BgA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kfsak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:37:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NFYgYO005340
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:37:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahct4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 15:37:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NFbSsP51577144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:37:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74EA520043;
	Thu, 23 Jul 2026 15:37:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F8220040;
	Thu, 23 Jul 2026 15:37:28 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 15:37:28 +0000 (GMT)
Date: Thu, 23 Jul 2026 17:37:26 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, huschle@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH] s390/spinlock: Add contention tracepoints to lock
 slowpath
Message-ID: <ttimwqe@ub.hpns>
References: <20260723084229.923353-1-ciunas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723084229.923353-1-ciunas@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a62353d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-1lojjmjPfbEsR92X18A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfX5YAascRC4et3
 +26cE7UJHO3sFqEpy50piqqcJD7XyLAosancQncqByYMMTDUlvg3y0NHOIiCwp9INWJe7PNGmkP
 cJPLuXdzFkOT670Q+V4NbgwT7L807qZe5yx8p97ul8BLeplNYfM9/NjdcTCB5oTsVMEyuzNKFG/
 JOPDLLuZ98bO8PMimoZ0ybeeFtv5/0Aw229Ltrs8+kzYJnqWBC2K9gbRguaE0g2+EV/UrPRbMvl
 6/GvqqNxrOw3SoVfmuqf3rEIH4ADKWievaXKbrcgR7DlFEAbcDXsD3ZkqmsCQf7RfXVdY7ECmeR
 kasPEMfxr+OuiF3GdB0BNpYeeHKPh8bwD0yS8D+sdAurvfujxhfIu6KLkxInSC+P47NTB1/Nt5h
 hSXB1vmhBRCMOwqdhkGsDJLV2aS5pB360PN5T4ubsFzgykcamMn5rvuyDUfAnADxLMNNbjiAmk7
 px+csKUi/Sgyw2pyMUw==
X-Proofpoint-ORIG-GUID: balliyNQ0DK8-G0_2IES6Ljo-uIeZQh_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfXytNDuaAb5Zin
 BJJ/fbwGVN8xuE+wVCHf5pzFV/yQPYy8BScJhJDN5vgMs9vcESW1Swk5Z69Xrt1E78IjduJ+94h
 GwoSjPPlxwyyRBB4nL668qsaDZ1zOAU=
X-Proofpoint-GUID: balliyNQ0DK8-G0_2IES6Ljo-uIeZQh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230149

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

Applied, thank you!
