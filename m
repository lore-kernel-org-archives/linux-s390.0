Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE83876CC;
	Mon,  8 Jun 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944531; cv=none; b=hqYxKquBXNLHcIvI8ml4n8NyQT4VxB3ReP92v0bZauQg0gDgp9S56aHI/BmTfNcoRoKzaHQAllswwpvHwiB7LCCFY0ybmtSS27MXzGNYPYWAXPLrEz7gD4h76hJ+C2UfG0mcdRwLEWsnknBprSzjVRhap3MPNUTxe98P6nG/pA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944531; c=relaxed/simple;
	bh=FfbqWiZKv7bo0W0py1C1BGJ1gdf2SNxf2cYNj8Qi9w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUUvcPqCAluu025QpMkwBRLMhxJmS+Pr39H5iLiZ96UdaVvlgGJoWdAb6cZrudGX5LH0txTDkqiHOrQjVvrnxSgyLKYw4W7fh5BrcBQm/ISAXe4jhV1YocIqCWiF9eJpSD4GBNwfI4sd/+3hDNb+19W+3tYu/O10/XBY21XGrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D9Uj8WUr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D9Uj8WUr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IgKeD3404977;
	Mon, 8 Jun 2026 18:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Dy+cDqEE2w+4qT83WFr8m2/hIWWugy
	0tca+IswaOpzA=; b=D9Uj8WUrObR3dFmPPOI90OPYacaqv3FKOwezGRf9LGRxFB
	jEqpJhkm10X9bJmHF3/GD2ZGlCF5Rtsi0oHCoqFUlx9xFt3WOj3jugadk/3gaXSm
	H7Cecy3TYIf2i+VuA/S4kc1G/f+GoZQIzXB7uGGdizzkBfCgCWxAoBkahWyWZE3v
	u5TouI6QIFbl5T6oLJkX8ITWVAW+xpyq3ugM0b5lw0Jn6NyugzyCYTXEn5tKUA6x
	WXsqBu9+1xw9lRqG3Vk0yiaeYTlOJgsJPQdKgbTVIXMpXu8DvGW7vmbKtkwLSseF
	WlhpxiF1NBuR0T7zFWdAxKEfDK/8Tr30jA2YMlPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye0rrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:48:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658IYdvD002194;
	Mon, 8 Jun 2026 18:48:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy6dsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:48:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658ImTPO40042968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:48:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF53620040;
	Mon,  8 Jun 2026 18:48:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9652E2004B;
	Mon,  8 Jun 2026 18:48:27 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.135.117])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 18:48:27 +0000 (GMT)
Date: Mon, 8 Jun 2026 20:48:26 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: gor@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] s390: Enable Rust support and add required arch
 glue
Message-ID: <aicOenHnHeFE2qlD@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
 <20260608142122.34400J00-hca@linux.ibm.com>
 <8f3c0ffc-adc3-493f-8347-9e7579f3cf99-agordeev@linux.ibm.com>
 <DJ3SBEPW21J5.2GMLCYBAKF7PW@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ3SBEPW21J5.2GMLCYBAKF7PW@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NCBTYWx0ZWRfX9D8FHjoejwAn
 bYJflev9632SNPV+nqQM/GjXvj4gznYPXa/Sz4Pzdi8oJy/pkCcVe68twvkmfsVuhikI+8UkMl1
 2I58DCsC8i7fR5GI+7D7/u65coBQaK9onTQRyClUn/3aUevL4OXczMorWWlzAjTFNwu3EXwJggw
 gOqPiVoH+YxfJKmjz0Hbtt6b/H05faNhdUEYAKE/tRMGHmxNkl5IkQcq6UKBxAF4G/+QKGoJZ1y
 WUFOfCkJJbY/1DSTQK+7ccl2dJTXluEfOJM3YvhUdWvljXP5KxObPitIZy3jANCOapIyaKShOVV
 JSEd3fSG2vWqFvZnJZ5mYtw5oOUnNMXN5LmT/xl9wGY8Vq/ieYn1G3KlZkMF15pwrSOPceCNGT3
 +wKjui7/wvM2xOO5JkDvFc9YHl/AvpKpOBQI6YQTJyg6sUlItB9jWp2FJpNKL25o26NiOpTypa7
 vv5E2XyXkyY1e7OAk2A==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a270e82 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=ZLKbNFpwge-4QHkGJ2AA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: edkmjYh7ytmX-_VRyQpiq9uXZQB1Gk7i
X-Proofpoint-ORIG-GUID: ol3St85M4Ncuehu1wqpTlU9ekkFHSi5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080174

On Mon, Jun 08, 2026 at 04:48:45PM +0100, Gary Guo wrote:
> On Mon Jun 8, 2026 at 3:36 PM BST, Alexander Gordeev wrote:
> > On Mon, Jun 08, 2026 at 04:21:22PM +0200, Heiko Carstens wrote:
> >> I guess Alexander will pick this up and route this via s390.
> >
> > Yes, I applied and scheduled it for -rc7.
> >
> > Two new files fall under the Rust maintainers scope:
> >
> >  rust/helpers/helpers.c | 1 +
> >  rust/helpers/string.c  | 8 ++++++++
> >
> > Please, let me know if someone is against it.
> > Otherwise, an ack would be ideal ;)
>
> Thes string.c is missing __rust_helper and it is also missing a trailing
> newline.
>
> Sashiko's report is accurate here:
> https://sashiko.dev/#/patchset/20260601174625.2910233-1-japo%40linux.ibm.com?part=4
>
> Best,
> Gary
>
> >
> > Thanks!
>
>
Hi Gary,

thanks for pointing this out.

I've added the missing __rust_helper. Regarding the trailing newline,
the file already ends with one locally:

  $ tail -c2 rust/helpers/string.c | hexdump -C
  00000000  7d 0a                                             |}.|

The other helpers are also mixed in this regard, so I kept it consistent.
If you prefer, I can send a v7 adjusting this as well.

Best regards,
Jan
