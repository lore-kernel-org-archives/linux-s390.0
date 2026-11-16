Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834681;
	b=HcXeB+GSTdGtgttxY26sihu7ipSISCdlq6yZxJzdAJmf671/0TRR8nIcdeO308I+DIps
	 UdlOrsvbViKs1zbjJbkD2Z/MTJ7M2gVPL5r3J1ZxGad9ITLjji/SAggtCRY31rhsY+gvi
	 OQxyvuwIY9qZI6Kh/xa8fjByjns4jc3bUcmni2/s0MseqnoCcUOZ9RaQm5Vk9AGl5kBaI
	 hwAOjGDQMT7vMFvmsLsA2q5aF5kMY2NwHP8MVOO8O3p/e8lLX0JWjKZq0PhhKaNrrxhJB
	 YVkNL+z5lpUsnwdMzDvmdeZgGkNcsjW9QYItro9OMLOPEr68NPV5uPg32bUnXiIARMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834681;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RZGav5VBwE05/edcFKd6DvQjJV7onBew1olClaU4Khk=;
	b=y20F81vPHuATKJ6Q+NEH5zeYQVTMON9RW9WEGKPhC3NjCvqdBJd4FW710sBLu5Dvd1gJ
	 PeZAOcOuIGYqPYOXFEClEQTPSLVuAHmN4IBxWVeYOH4gtxE1t3TY3pszQHv2H6ojOWysk
	 pm65W1Sc2ETnA52zhIXHT4qQInalXHgydw6veJE4FFX2yePgK01BDOnjsRZTkMGaglGIN
	 fNCQAMo6yIUD0yS7LhZ0q3MEf2soILhdmeAL6FEMgF9MouGABwIo/vZGvYritE3gR69Uk
	 3Hykatazf+xyzzmTlN9rwzX5XMKXLiADP3Oa6AU/Wgq/aqbUwmKNLd3XlBZ3mI/piLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="iH/vRTNF";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B2606A31C;
	Mon, 16 Nov 2026 13:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iH/vRTNF
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCSFe13278619;
	Mon, 16 Nov 2026 13:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RZGav5VBwE05/edcFKd6DvQjJV7onB
	ew1olClaU4Khk=; b=iH/vRTNFvfIt+8VTNU0NODeXzxr5PfToQQc2RxXxNMmxwN
	tz3/spAte0eKSp35mm/PFh3NjoN/vy6vTelBsn0uo9bHwP5SzBzfppUrbYfu0zxm
	BAl8CeToJf+TKRLSwDqkwA+sb9JkqXvhOr7WOuJUjhOLWxCmAyAJowFmxuSZ2ouP
	T8g6fVy9tfIhOn+tF3sMC5kTR843pGqLvYdL9OJVwXL4UTKzXycmp8bYcAA0hCa5
	vDSOSZrylbofpU7Py22fmKpq2PMc8eVqarKR9Q31jkoE6jbb00gBtS0aw3HZfsO/
	QE4zz8nk9j8vS1HPwOdry8Ti4Bn6bNG4VistaWVA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc4wu3m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:11:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54Ef3095320;
	Mon, 16 Nov 2026 13:10:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df8131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:10:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGDAii140173868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 13:10:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E23FF2004F;
	Mon, 16 Nov 2026 13:10:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6522004E;
	Mon, 16 Nov 2026 13:10:44 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 13:10:44 +0000 (GMT)
Date: Mon, 16 Nov 2026 14:10:42 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] s390/zcore: Replace __get_free_page() with kmalloc()
Message-ID: <20261116131042.125125Be9-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-1-3db507722530@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-s390-char-ready-v1-1-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX4Vt5A3LJOpJy
 0XdUr3DO1Af4d9Tkz1UwnONNH/UsC2i83UkCe0GtdgMGWqCK1Qy5uH0lOt8asBNnhd932KsjZaP
 SCBWc6zQzLW0p/36Gsi4pLTKSieGDOk=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afb00e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=Y6TpkvVB5ZIwULgkomUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX5WKg2xhkqX3a
 +mn5URnuTpnAuQTeVueZz/+Cvr2qdxs1AiGUW59818IwBq3kPvGnm0XlZxjie2nXXYNu6VOFC/5
 dYJEp079OAUzZ1l8jBMqWyh+nERMTiUr6MP9R/bzTUHqQCmrImh3yeXe5xCwqbS1TdTOQ01t6jn
 leguscywOUOj2ZT5f9I26t+/uRiG0GnH6CuHpnLn/wwLd4qTRaiB1puhK7aNxHx1oQxhO/7gEOg
 EEXVUIfT3kYQ4slLn93t9jhT6b1vN2jqZiE8QXr6EdBDKOt6tWL58BgpX467ZBO69tnRAF2/gcj
 nCxBwIpeljd3rWbsFNVRaf5IG4K2nw/Us7enBWeIP7ZMm3ZLB4kEfbsb0CPgSaoWy1HVGRVlA5S
 4wxh8F1hXszvfKfVEiRPDRn5Iw1ZAfoRhHna8YlJbxBHywqJKEZWREVsjGSah2Z3sqYBzdZi5R6
 iCgIN/TJDNSRvxN3W4w==
X-Proofpoint-GUID: 4EnDG3myrhPma2aarqXVW-FwqNCfXQvB
X-Proofpoint-ORIG-GUID: 4EnDG3myrhPma2aarqXVW-FwqNCfXQvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160051

On Sun, Nov 08, 2026 at 10:48:58AM +0200, Mike Rapoport (Microsoft) wrote:
> zcore_reipl_init() allocates buffers that keep a copy of the IPL block
> and of the OS info structure of the crashed system.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/zcore.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
