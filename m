Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE739D6D5
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701156; cv=none; b=Pl3e5QMjjmnAyy6k6SNVUT0Zad3us/Fyq7AkvdnpDckVv6RE8wW2+kXS3r+xcDb5VYizP407gNlvpRY2Aq0kAMULscvxPcePbVkyk5LigWqGH+sFm3Xxq6ZlupNtTYYXvHlbzBQizl314lLfSBoXT3fMPp+LQ2BQqQ+yScMQ5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701156; c=relaxed/simple;
	bh=j/qAel1Z8zVqv+1qHtLL+3wpc5evTdam0zcNa5MVrIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xn980CeJ4Cwass4hjBD5NmYI8+YScIOLiMRUB8ZyNhXMb7ic6vjfIaViNnApVJrOxkQ1eGZmb/TOoyOfjgK/bdG+jmo8CxYyG5aQDCFuNQctlvE58inFCKCqbUGdI8YHduo1Mrejt8gDlURKSd9XKAnhbUKZd3vSHAmCpXssn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PDhgvqhq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PDhgvqhq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81wPN586663
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 09:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uCyuWvrxOgKQCjcw8wEUVIm1z3XmO1
	uNVN02mqmDFBg=; b=PDhgvqhqN6QkZK8PW10WSnns8TL7lscinqas1kiKVUFIEb
	ZT8SXCNvhaHFAKuqguKwCtGjk/xkrRe0bUsiAMCPQnxfj6l+dwGRpA4a56JRv30z
	lkJ91pFTFcwQmK5oKZkeIld+XYpKV3p76uVwehownK3yrD9F9OMWVLu6N1QOyFGh
	yQZ9MGKSpjBIrXwCaNWzd3eW7AnLkY/ewSQpbk0izt/1eVA39Kj+MYlRQXGNY9Dz
	jNiLAPIsU/UEQhZjpufDvDPnrgFZgYBsJT/tuxdZnTWWrHBo9v3dIPDnZTunSRBu
	YOtw/xXgx69egB9rK0Xhk4uztRSDx0WPEJui0NkQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma494r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 09:52:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E9fH5U032309
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 09:52:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqeyes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 14 Aug 2026 09:52:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E9qPWW35914236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 09:52:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E44020040;
	Fri, 14 Aug 2026 09:52:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 386512004B;
	Fri, 14 Aug 2026 09:52:25 +0000 (GMT)
Received: from localhost (unknown [9.87.136.10])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 09:52:25 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>,
        Christoph Schlameuss
 <schlameuss@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/time: Use jiffies instead of jiffies_64
In-Reply-To: <20260813132505.3691502-1-hca@linux.ibm.com>
References: <20260813132505.3691502-1-hca@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:52:24 +0200
Message-ID: <87se4hav1j.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3MiBTYWx0ZWRfXxCp3zzLHk4NI
 5bd8JR2N6Cy2hQ+TgNucaKiV6rv0kmukZsbwnIE75Wwv6W/IXyo8RN0QKlZQ1rac2TDmqNdcqc1
 fe8evW+KIWyiWIUcesJXD+01yhUkChv6Aeaf2xsUgtGwUE2KNTPFk6eIQSfonOFi1l8OYX0oAJw
 lu/IavG8vw5N2BfsOuP2LgxHOM3bgyRvTHDX8QqeCgaJfBcEstm/0hX3RHLHD1rqZDQcF4tr0Xd
 QddUnOLLXot6rebyheKN4Q9CI4FxkAG62wiP8PCQpmS+6bCRUwNRP/8hUzRaNkzQM+BwsqHggBB
 PnZQ+U/hKjpgvDWpYVjE4N1jJS/PBfoqW3/vtO41BFq+nNwnhoOHLivOSjU09s4HXFcfavnWgCW
 hIuKZE+e1ir70Z8MljLUFD4kpN/0196AdQLL0h0FjA2rZER33fKBXZi81MoffZi6BpWnO5MmAaj
 2apAur1kvz+Y7xIdeJw==
X-Proofpoint-ORIG-GUID: YsuoUsRqmsh7Zt2zqqWokf8_Rnya-udV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3MiBTYWx0ZWRfX2p91kBZ0FVAh
 Vz7HWpd5LqePfJaca5sv0yuqVPuKVh/eL1zGUCn5QMjMfu7X2UJEA4msK4ld/pvZDLg5ZP0OM9r
 cvmggFhhn8L5+ywuK/Ex7o4lYJOi+w0=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ee55e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=IbkYLJS4NRrwR7yNVBcA:9
X-Proofpoint-GUID: YsuoUsRqmsh7Zt2zqqWokf8_Rnya-udV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140072

Heiko Carstens <hca@linux.ibm.com> writes:

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

Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com> 
