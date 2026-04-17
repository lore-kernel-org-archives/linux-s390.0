Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA332253EB;
	Fri, 17 Apr 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431280; cv=none; b=hhLPyGZzsiSJrX6pkcn8R43OsPUFJXbGKhoauSq091HBmeSYD72AWeY5LqWbU/KBgWIFbA5p71BeEDuohfiT1V1e3wDAPUZpRfjaRtQLZq3qINMwUJ4nJuGzRPOGbVPv8m+MLGZqXD+dfFFTPERWcbugx5B3eOHkR8pR2MmA00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431280; c=relaxed/simple;
	bh=fVOZO/14X/t9U4xSlG/dsjYvr34l8aTIpaXcqD+qFz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHU2dRQSubfGrTGbBVSOKlDdBb6tx51TzuPfyrJy+gApuvugvXejVNTO4Mb6sU7/3g6B4manDLDnUrw48cwJedMWzt5AGXiEXT3nhJgZ3I6zeiE4FuRxhV0G9YmUm17LFvGy5ZeacySxokDv8Z3eMojP8rjCoW+qShr3Vns3HEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHc2WeAf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHc2WeAf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GN1tO21844923;
	Fri, 17 Apr 2026 13:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=41rwOJTRQtGJKyUgQI6HyEkkQcNFJ6
	jqFaCPOLxYD4E=; b=sHc2WeAfKWi4B4Gkh4o/oXI7c1vOcBPZqBYxukxYCzyLZ7
	mKiHp/ns9tiQsz6nMNQs+H4ZSwlxhtyCj1wOLzPBuZlPJhTSnd0hGatbfJIY9Cae
	aaGasdthFA5REFIVDTLMgUj7TaQvuuXgSt83tyyiqUVv3itXL7wUXRp8nghnkyr/
	e4HbNQd7xrepsCtk1325wTkunSFi6neZ8gzoY9vPelR0qn7CMcmkFhgc6glFW2SN
	IRbZ/+YUcOOr+u8ibTGxF1sPzMHguHBmIgiY2D2fyNsZD+CDgJXyfZsshTJtd7rR
	Tft9+56vYq+otiJ71NIap4ORKbd6LybiMqxiibAQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89n2n7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 13:07:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HBUVn5015149;
	Fri, 17 Apr 2026 13:07:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msyfyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 13:07:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HD7eAR49152364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 13:07:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE7CC20043;
	Fri, 17 Apr 2026 13:07:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A1F220040;
	Fri, 17 Apr 2026 13:07:39 +0000 (GMT)
Received: from localhost (unknown [9.111.87.179])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Apr 2026 13:07:39 +0000 (GMT)
Date: Fri, 17 Apr 2026 15:07:37 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
        Kees Cook <kees@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/debug: reject zero-length input before trimming a
 newline
Message-ID: <ttdn34p@ub.hpns>
References: <20260417073530.96002-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417073530.96002-1-pengpeng@iscas.ac.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyOSBTYWx0ZWRfX5mtgCy4QIwIo
 1924MV5s5+bc8BMm3OdwSucDgdearaFLQwehL7xfdir0/gzrinvBNljhjDJoR/MEQ0VXRb9o22r
 V9WVWg9bwsD8fdHan+5O35sCFQCaRoGyR5sXGVh8QE8AHCI+93tjzIrt9ocX0GiR/Mj+ysE/wmT
 CcHZvtrMwLb5PKDlCDiGGlWUIF9Xh+JoLnXYYAz6/w46Ww+946W+GgqB1DCq8DS7isJKAcF30nf
 9ZbYMg7KsVPQqsBrOyrsmNlGOHJxEaKxeQJ3fewT3mCJq+LAsjN4wipu7A1gMUmCywQZ0YK/+gQ
 axqavqbxQY7L5i4nx7i9jrna5x5eSq0IhV7VuKAaBa86GLkV+payYdVHdf4oMWHRmn1ezvO1U65
 YCYl6+KjMmzMf2IUTGQP9iDNLtSSFXLfEvMy1ntXhHx9u7qbN+2CT+yu0CC8r7ZhoTZkkAhwAi6
 R5stHDQXBPhLZJJVSWA==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69e230a0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=uf26iSff4PeA7en13qcA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: UZPyOKGuOiZV9zc3NjyDFBOGm0nd1eiS
X-Proofpoint-ORIG-GUID: UZPyOKGuOiZV9zc3NjyDFBOGm0nd1eiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170129

On Fri, Apr 17, 2026 at 03:35:30PM +0800, Pengpeng Hou wrote:
> debug_get_user_string() duplicates the userspace buffer with
> memdup_user_nul() and then unconditionally looks at buffer[user_len - 1]
> to strip a trailing newline.
> 
> A zero-length write reaches this helper unchanged, so the newline trim
> reads before the start of the allocated buffer.
> 
> Reject empty writes before accessing the last input byte.
> 
> Fixes: 66a464dbc8e0 ("[PATCH] s390: debug feature changes")
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  arch/s390/kernel/debug.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>

Added
Cc: stable@vger.kernel.org

And applied, thank you!

I've also addressed Sashiko's complaint [1] about debug_input_flush_fn()
as a separate patch.

[1] https://sashiko.dev/#/patchset/20260417073530.96002-1-pengpeng%40iscas.ac.cn
