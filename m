Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545845FFCB
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707020; cv=none; b=cZguN8qFNCDWkQTpP+G/Cy6FRVHXGAGkz11A3hEVZ9Jziceei1m+QLIcTmekH2PYcOshLx24V2kM6ikrNHmUHlGig60ycGkEdA620l5gI2Wp13P7GqFPcsEOTRzvOao8GmUVdf3IvNt4/tm5+kCjPxpzCkrjtqLDJ8TDUnctVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707020; c=relaxed/simple;
	bh=65zvy16RIspTBxm7OInvY7QrTiXOTaYJdT2kfiXuB5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyYFnLehM3Uh7n0IzAj+NOeEBaMe1icjjrBVrB2e4Zg9Vu/NtIWrA2fAOfzZSN0bQzjrKE7NnUIAdEftOxky4AhWwyrIpWJ08WtUGs1q0Oo5KJsas4gctWhizrcc63r0OP6lAapMKcUWG/KsRMWPAHQFmqThefaKNuqh3LxBYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ON7/F95N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ON7/F95N"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1xvH984920
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 11:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oVLeIvKbX0rzPKBYjTw/uZTjFpayjv
	Xf7jnJLz+OA8I=; b=ON7/F95N9ndnbsanr/VN4IZ2QzSDb3Y7ieXykrkJLrai74
	AemaJXj/1F+SsR5RR4qmf/rwygljCZI+SaUVdmcetOghFtgz+d0H+DfXnDiRIFFV
	05AAuXEvewTbNfPY8p5kBRvs+GndWLwncC8IMx+Gn0h6ZTi7v5dOtr/QfLzDYUCF
	Hv4eDMRS0JG2Z/wkuzcXBOIaixkT98wMo56kOytVB1rH6nn+cl647zMtF/6wAQ1t
	6N+N5vnpUFmtJMMExE6sajVXBngtPh62Ml4sszc58YSfRn7BenwMYiKvmD3xdQmm
	AQFxv2jACAqgPuOIN7h1govTgkcfioQJpR683AXQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwkbxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 11:30:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EBQN5Z030154
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 11:30:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv9ten-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 11:30:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EBU9H338732088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 11:30:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D4520043;
	Fri, 14 Aug 2026 11:30:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89BA720040;
	Fri, 14 Aug 2026 11:30:09 +0000 (GMT)
Received: from localhost (unknown [9.111.42.87])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Aug 2026 11:30:09 +0000 (GMT)
Date: Fri, 14 Aug 2026 13:30:08 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/time: Use jiffies instead of jiffies_64
Message-ID: <ttjrby8@ub.hpns>
References: <20260813132505.3691502-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813132505.3691502-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7efc46 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=IbkYLJS4NRrwR7yNVBcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: acsZ5bVXn6LHOi78T2wCRD4Ye2cmX9k7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfXxmiBT5DwJ9ZE
 eti7IV1c++Kj89x7fdhN4f8T0Z35VqXCm4i+vSmLyA08b7r9INk8JUsP2opShBISZVx0p3WW5GG
 3lK05Tx84ik06/E1uk8y3Rw+7mkZH3KSeamFsTt0PF+yObeWrhp6RSaluC1Igp/w0SrdVWJoMbf
 /4Kcbk4N0jIm3jcZv9C3a2m6Ba7rozy+xsMM29nEF3WoXLkSjuN3V6WLnX/UpSXCt8OyzIbLUuj
 DwUluMjpncJBoPjKEfy/19EwYU5vfEDsNVXaMqWvy7Ly9KMrB8JRVR/b13MPZ4lyjVayOrOQ4sb
 oBVRrMhQEEdIQBPPASK24NGNQG7SUr0ONMSL7SQuzgAMZbLu5W6/uj97Y/Y/vU0p0ojL0oaVjit
 YO3FEkTymOYZoASBdjkNI/QkmF0nCVp+SmuGumYP03BryeSfVafE+ksxL30mzly4ZTPV+ZNkDlV
 MEIMej5repaz4jWp2Ag==
X-Proofpoint-ORIG-GUID: acsZ5bVXn6LHOi78T2wCRD4Ye2cmX9k7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX12etDv4MQhLy
 NnoAOj3YoWgRMgV0G4RJ7CEcgw642oeYJKgxguvuBOsn4eTusW9OrZaA0pY2PhTJ4/AbTE9zcqd
 FT/7QSoik0aPuuyDKiWLyGsO9A4i9ic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140083

On Thu, Aug 13, 2026 at 03:25:05PM +0200, Heiko Carstens wrote:
> Christoph Schlameuss and Alexander Egorenkov reported a data-race
> reported by KCSAN when jiffies_64 is read:
> 
> ==================================================================
> BUG: KCSAN: data-race in do_account_vtime / tick_do_update_jiffies64
> 
> write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
>  tick_do_update_jiffies64+0x140/0x250
> =============================================================>
> BUG: KCSAN: data-race in do_account_vtime / tick_do_update_ji>
> 
> write to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 6:
>  tick_do_update_jiffies64+0x140/0x250
>  tick_nohz_handler+0x2e6/0x300
>  __run_hrtimer+0x156/0x4d0
>  __hrtimer_run_queues+0xd2/0x150
> ...
>  system_call+0x72/0x90
> 
> read to 0x0000016599ea8600 of 8 bytes by interrupt on cpu 12:
>  do_account_vtime+0x7d6/0x860
>  vtime_flush+0x26/0xe0
>  update_process_times+0x32/0x160
>  tick_nohz_handler+0x12a/0x300
> ...
>  system_call+0x72/0x90
> 
> value changed: 0x00000000ffffaa6c -> 0x00000000ffffaa6d
> ...
> =============================================================>
> 
> Problem is that jiffies_64 instead of jiffies is used. Both are at the
> same address, but only jiffies is of volatile type, which prevents this
> warning.
> 
> Change the vtime code so jiffies instead of jiffies_64 is used
> everywhere. This addresses also the inconsistency that both jiffies and
> jiffies_64 were used in the original patch which introduced this.
> 
> Fixes: f341b8dff982 ("s390/vtime: limit MT scaling value updates")
> Reported-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/vtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thank you!
