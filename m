Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5823C584B;
	Thu, 27 Aug 2026 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818332; cv=none; b=jwQ+8Kk88XPU6dRNIXxK61ZRG59Q6WaUecvb+YbLGtK2qxkUOKG71GwnTRXaRdo174ZuFJyu+zOeH/3MbUCuNzugmw37eZQjkxRkJ1S0/jepdslndz3kgywz7jE0db+2H6Dsm0yq6+hYiaGberXQqknkFaYHcEp7aymBf1ZKOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818332; c=relaxed/simple;
	bh=SCkXs2+3TkkNbo4ZdlFtyM63RsmZSKjMwWRxz/7tFC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGGoM3aJqWGsWY3uFENy+W/rlOTx43WRUqKnn8K9x/Q6b2wD5GnT6jVqfxUVXxwEWt2JP2FHnOFW4MN12/MMM6HfX3FwB5uRw7GRnUGhTwgkxaZNUPxb57xZTw2j8IonaNizqsIus2cz/iuUvUFY2n/OhLRKEptYbLtifudBSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=auqNg6O3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="auqNg6O3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6VW9L2209844;
	Thu, 27 Aug 2026 08:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=azSgAeer7HRO/y/U3A+QKwgdoguOnt
	nnwySyUoZBNDs=; b=auqNg6O3BoLY8+feEtcc2xFRkm19PMjBOKm4OtVE0ZWujg
	ySY2mojk/B+hzG6VRnvQR5FqMMcyiRUPZl//l9PFCmWGbqBIvQb68TfYOPy3hHo0
	uI4E2JUgdep4YM9uWwi2S4faYRFrGeG6Xct2SK5t4CIOxBJ9Vovb5prBt6arNOjn
	txhTKBurWez3SZQSbMe6h6dbsT5zIYUi3l7jnyW86B6mMXCdUWRNzHusd4mkBgD7
	Eyq5HvX6xRc2i132SvwUPPedMuj22HbfQ8a+2P8V1yMTxZj5QPVxJ1jqKUSMOxZE
	l5iHg/NFyCX4EEtowXniH9NMedHIPcmZALktczOQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g544a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 08:12:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R8BHVM003782;
	Thu, 27 Aug 2026 08:12:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragprt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 08:12:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R8BwMf50201076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 08:11:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DAA02004D;
	Thu, 27 Aug 2026 08:11:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0884820043;
	Thu, 27 Aug 2026 08:11:58 +0000 (GMT)
Received: from osiris (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 08:11:57 +0000 (GMT)
Date: Thu, 27 Aug 2026 10:11:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260827081156.3869103Abc-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
 <20260826130257.21444B1a-hca@linux.ibm.com>
 <87a3147f-e993-4629-b0dd-a54aefbf20b1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a3147f-e993-4629-b0dd-a54aefbf20b1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: RMz3UEJ-r8qieNoHL4ycj93WaDCZbMla
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2NSBTYWx0ZWRfXxDOK4nNPsJ0x
 N8pNfaJzpB9X32TcR8mWrpXp/Px3HuuZuYx1BsQm6Zy8KPzmK6dtck4yDmQygbewzt1gzBQnROc
 0IQgPcFHarz21BoDZ01g3zdkD7F6sPk=
X-Proofpoint-GUID: jmFqgWxCJxbuJbgYxAqSnoMOcsSUPEsa
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ff153 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tYSU0nxKdXOZT8UyD_gA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2NSBTYWx0ZWRfXzOMYH3+JQgpk
 SERRZa/ETk+hqzm3M4JrFS+PKizommTCwb8ejt4dfPqJ9knc/mfyRBhYVQtGnYz+Q83ta4aeJ68
 XefgdioHOI8gqY8HC3xA//2gLsQ18py6CAWYAwMQ7KBsmfDuS2qNt6NhZmDgARLfqN7YlGXgPS8
 IXo9YUgXe8QjEpsxJAxaKye32U0Ljn6NeQK3lHmH4kaYhkq03wZUDw/QuGqLxn3UAuoJwEdX7sO
 UUkO3aHlHKZvm//sNZauHXP96H6yIwQqKoyZiV8zPGTm31RiCLxtzXdO9OpUCtlgA+hIsJMqevQ
 Dexqa8W5PlrVQjJOZizISywylE3D7PhTIHL4QdkMxbhPehw5DVwANokoAV0IJ7gvbcATviLqv/3
 xFwhu8doL4RX7BoGC+nF2BWNwi7URtJvcolHpHf/IFSapfpCzBAHhsqijbOvXmFB949LWPM3FTl
 O25+Hqzwf/gsZunLkqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270065

On Wed, Aug 26, 2026 at 04:34:25PM +0200, Alexander Gordeev wrote:
> On Wed, Aug 26, 2026 at 03:02:57PM +0200, Heiko Carstens wrote:
> > Would be nice if we could avoid the not so obvious local_bh_disable()
> > and local_bh_enable() pairs.
> 
> Calling ptep_get() from BH context was certainly unexpected, but the way
> local_bh_enable|disable() pairs are used is actually straightforward.
> This is a slow path anyway, so I would think the simplicity prevails in
> this case.
> 
> But again, I will try to avoid that.

I do agree that ptep_get() being called from BH context is not what I
would have expected too. But then again, nothing prevents people from
doing that from irq context too, no matter if that is sane or not.

Imho the "final" version should either be implemented that it can go
without disabling bottom halves, or, if that is not worth the effort,
even disable interrupts, just to avoid other surprises.
Plus a comment why it is needed, please.
