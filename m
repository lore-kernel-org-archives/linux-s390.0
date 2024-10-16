Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921918B481;
	Wed, 16 Oct 2024 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056045; cv=none; b=DZ/LiCyZtk/Wcb8Ub4HL9US6DvU761Ad6EZmM+YURZqwwILemM6aPYkYMyf7JqyA/yMa1RcYlwMDGvtj2aW1q31shokqJw4QBzZSV9c9dBFn7X4Pno9V9g1j0/WDrCaHRl2fPZSOtYnNkJ6VZedylMP4M4gH/K5OwbNzKxqZKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056045; c=relaxed/simple;
	bh=kY9s7ieYNFRf5vd6rWLrxX3RydNTXVEAmhHE6BU8hOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ChuGa9mzkYEo4nBysalsNKeCKgcP9q4gZoWRSSPIQ97djRqMQxhYbobwB21HjDWzQ9X4705OyYqtTkJy5RQusYW0tGCeGf5AU7SR7uGEF5ZF9Es2LNSpJZzaSksNxebSvAZk10l2hRaHUC+HE0GXgnHZXntDutvODr/FhvUE3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KNRC5j4E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KNRC5j4E"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G5FDnr012151;
	Wed, 16 Oct 2024 05:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=93dRBASK2NX/nahhuRQA/0Vp278JrC
	oL/iXOrYitZYw=; b=KNRC5j4Eux0ksx2ivs1VBB6Qq4jGgynlVzU50891JkkKfr
	5e/KfQyhmFSJIxIM0JnPK7UAwGYnDnVw6jAiDSqiWzBRnQXbM08Z3Mg6QSMfm8hx
	DjWWyopaFqI6AozMJ65yAbaoqJLivwLeZA1uAEKrO+WyMpVSFh+IT7FcqtdVDiHS
	hOLobSnKfR4VT61S2zRWjsFcEZNRIf9lmfOiZZtqKvUoh/CueXSs4t1/8XrVtgku
	XOyuZIw7wReaelRvbRkd7bR4Er+IPxeN3SLh+KWTJCcwQqgDE4/PVxjZdaPJEJmF
	Q5bVWHiebCSrsbtGH9enXIqx3q9N+FKQXJ8jme6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a762r0gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:20:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49G5KT0R021873;
	Wed, 16 Oct 2024 05:20:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a762r0gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:20:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G407VL004988;
	Wed, 16 Oct 2024 05:20:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj76ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 05:20:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G5KRdx55116116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 05:20:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8063420043;
	Wed, 16 Oct 2024 05:20:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 607D120040;
	Wed, 16 Oct 2024 05:20:24 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 05:20:24 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-s390@vger.kernel.org,
        Yangbo Lu
 <yangbo.lu@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ptp: Add clock name to uevent
In-Reply-To: <Zw81Nlx9OF-PveY0@hoboy.vegasvil.org> (Richard Cochran's message
	of "Tue, 15 Oct 2024 20:38:30 -0700")
References: <20241015084728.1833876-1-svens@linux.ibm.com>
	<20241015084728.1833876-3-svens@linux.ibm.com>
	<c9c1c660-9278-426c-9290-b9b0cb76dcaf@lunn.ch>
	<Zw81Nlx9OF-PveY0@hoboy.vegasvil.org>
Date: Wed, 16 Oct 2024 07:20:24 +0200
Message-ID: <yt9dr08gfwtj.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IKpiQpf83eHtSz42-ABl1IBGWSOMLfov
X-Proofpoint-ORIG-GUID: Zhwun_uNYFZouXgHlJPaKdU871Evb0Rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=409 clxscore=1011 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160031

Richard Cochran <richardcochran@gmail.com> writes:

> On Tue, Oct 15, 2024 at 02:43:28PM +0200, Andrew Lunn wrote:
>>  * @name:      A short "friendly name" to identify the clock and to
>>  *             help distinguish PHY based devices from MAC based ones.
>>  *             The string is not meant to be a unique id.
>> 
>> If the name is not unique, you probably should not be using it for
>> udev naming.
>
> +1
>
> Maybe the name is unique for s390, but it will not be in general.

As already written to Greg, i will drop this Patch. The name is unique,
i was just not aware that the clock_name attribute is present in sysfs.
