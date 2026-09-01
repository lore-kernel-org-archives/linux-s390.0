Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA852BD59C;
	Tue,  1 Sep 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261674; cv=none; b=hLgxl3PuGlfx0xZde0VJNjtILf1rZ3m75RmlJzfF8VRIubRY86xy3AlVM7zPdniAZ9IZNOICZNGlr+UYyhQ3mj8TRwD1u9b2aaZD0VKzdCXqYVD8FwH710oSVjqHrciDh9QREqWFGxrHCse2D3YcEX8G6kpxgqTGEtl0YK3BMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261674; c=relaxed/simple;
	bh=uAUyyAzRhUhrUrMIoJf2UuPglQKOxsIS0BDpxR+TQks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIilbTGv0PIyVNQp2QGZkRLYE7hXqKIQLj9jwVaAbc+A1XKlA4oSsJD/c+EDQKQzNBa7g+wnasPcqbf3a8iK6ZL1gPOBcERqROAEAiVj/Ciz5R5vdDsyhBYfMDA+4s2jhaEWNBOcbV9H6ejp9bHUJ7AIksDxV0p0YjgWKgpkwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KFGL53ul; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KFGL53ul"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AVkMU4009871;
	Tue, 1 Sep 2026 11:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=m8iJ3scAfVedHAVl/5OHsR9GsqHv7f
	waxSchZ6+xvwk=; b=KFGL53ul0jjXifsGrfQ/o7QH+tiJd68IB0gUe/p1sWK8Jf
	4WPBOKbId3OUr2OqIJKJV4CO/A+92DgIpEoEGNlB4+/OB7hSn4OycQ4Ia9YxAdLW
	kPfFt3cqwmw9R/7z36Ilt8evLfmaqyjH/Uj+j0ZPViDUCCP1adfgaIFJud48Aq6l
	/D7SPmK0nY9tex9vG09NmQJ4d42J9ceh24C0J1NehzcaNY7pwcryvVDgScPQU4Dm
	P8Ki+TqwmxeMfKDD4Sj5lfKzi1mKPXB5ajRRCw2welpRPrL8nHUZ2H3nuaEJClg5
	+6yXhXNhYHl1sBKmdxBbP6+BGA1qpPCRaqT3sakg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudq92j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:21:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681BBIuB003703;
	Tue, 1 Sep 2026 11:21:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hb9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 11:21:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681BL3qg42533134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 11:21:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C991F2004E;
	Tue,  1 Sep 2026 11:21:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB182004D;
	Tue,  1 Sep 2026 11:21:03 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 11:21:03 +0000 (GMT)
Date: Tue, 1 Sep 2026 13:21:02 +0200
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
Message-ID: <20260901112102.14482D13-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <73a0a916-b39f-4ebe-bffe-448928b13bef-agordeev@linux.ibm.com>
 <20260826130257.21444B1a-hca@linux.ibm.com>
 <87a3147f-e993-4629-b0dd-a54aefbf20b1-agordeev@linux.ibm.com>
 <20260827081156.3869103Abc-hca@linux.ibm.com>
 <b0d59b27-8d15-499a-aced-e5b247ed40c1-agordeev@linux.ibm.com>
 <75462b8e-b190-4870-8fd6-22d1e4d89139-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75462b8e-b190-4870-8fd6-22d1e4d89139-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8K80PWE4BSGNUh7vQEJ7XHJuKPzIopSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5OCBTYWx0ZWRfX/RVZH3fDICCj
 YynxObUK9vNEVHf1kEVw77bP+bjk1OPuuwG/O29XxMhIQf3dGXinc9fkc0gzBQGajvv1Ob3sjAS
 9GPGqhUiG9ENdtMV2zR5q/0PK76uQBp2HhkYfmPLc9oTeqCDo0X8vX728bdRW57ZHYiRpw2l9Uw
 nz6fjK5AmQ+q5Z92RYB5ARR7f8OiqLhnYflXIkTV+vauVN/zUK54hSk3RRXIbqALCmrZQAL8FbI
 JCwrrGywv2nFcKW2GkItqAehIVz/mmxnxCcSvCzzrW4iGedUey0x2pq+Ufr+abZGAIhQnq29kxh
 6PRJ7S5POzqw/JWvwNyzNG5K4TC00WkUKeexPQDxeT98XRGJ+Sh8rSEaCxV2PTFDyYFy/X5Rwzb
 U2KLwF8nwJ4uY6GSDX+/ADgn/S5cQ07Ni8fbWs7/sAZzYMx5/iVIV8v8aHa2dWeECPK7w2cmqY/
 IgYY8OqGAsE8hgW+oKQ==
X-Proofpoint-ORIG-GUID: QszmyM0FmfdQgEtsEdyezOdFzxTVE8Fa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5OCBTYWx0ZWRfX7N6H8yy3IiB3
 3YVTKkNiTFkfuvGy1w+TeO9feRDt+aIgK49vL4ApYUtR3Lu3Kyf7J+DRCcx3q86vgxeDd4jkY7R
 2xVQdbS1v7oC+xdaoAFDNii1RWXtlxQ=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a96b524 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ZNJKDMMrlkbq0tKfwxIA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010098

On Tue, Sep 01, 2026 at 01:16:58PM +0200, Alexander Gordeev wrote:
> On Thu, Aug 27, 2026 at 01:40:01PM +0200, Alexander Gordeev wrote:
> > On Thu, Aug 27, 2026 at 10:11:56AM +0200, Heiko Carstens wrote:
> > > Imho the "final" version should either be implemented that it can go
> > > without disabling bottom halves, or, if that is not worth the effort,
> > > even disable interrupts, just to avoid other surprises.
> > 
> > Yes, that would be the last resort.
> 
> So leaving local_bh_enable|disable() while adding VM_BUG_ON(in_hardirq())
> could actually work.
> 
> Also, I do not see how the code could be rearranged to avoid BH disable.

Ok, then let's move forward with the current implementation.
Thanks for looking into this!
