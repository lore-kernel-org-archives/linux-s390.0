Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834877;
	b=5VrTlZk5gASCnZjYVLgbl6ljYynKEiWYXR0TG3fRqeE+9Ly+JMJczs/BK1yiJQbHf+69
	 GX0ywCP97Y5zJKjSpaxBrYOUYEsufu2DCXG8BRJfFRjyJFK1If/dfGEWYdNoDaZBTVwUH
	 zcyO+UPvvgEur08+Fj7RgrW0trggYDg3A0iv/QPlz5LPUGc6NycthOKIQAcPDdpNMmtrI
	 tWP+Wv+NsoyOKdGncSN4FZSEPFsQYfSAD4v9D5SBq9M9FoSncnDIZ8BKNYZVmS4n5/dUz
	 VD14BLrPIvUdvuzl1CkMncuyQWPJh4ke66zVe/paRfvsa7Wq+dG3ACWjbv1H5UAy+5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834877;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gwIQSjAgmrohgv46z/uvziUsW9H4Stxc5qYNQgZcgNk=;
	b=lqcWlL54zr0Arc3c/Z0MzNcKtoyxpH27awZdTEI/ZgxJkGKne8/0/z5KFbwfHQurFo1k
	 ffJMax1ao3pz62GmAHESYmPeFATB8bTta1eEx6fyq97HzULtT3zGYVr4kOUanvMoId8QE
	 2XhwniV58dChHPIV9Wlryn80NmhdWEYI+08TEcxa2kfD4D/4Sm231R6CZAK4SPv1rF880
	 r1Zx6m3W0vmQy9UeAOeHUCQOt3Hv3wcC6YnynXIN61psjMGnK+zdNL+PEFfvwNormgIBm
	 fA7vVKcc18mUfI3YP6KfU2g+Ihv4wD0Vmxms8QcsDBaki7Xc66G28cwewgiLmBCryjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fGLJmdhL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B03606A323;
	Mon, 16 Nov 2026 13:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B03606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fGLJmdhL
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGCQfFg3275085;
	Mon, 16 Nov 2026 13:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gwIQSjAgmrohgv46z/uvziUsW9H4St
	xc5qYNQgZcgNk=; b=fGLJmdhLILhwAIv4j8i51rvXGG8/eNzt9gb93j6mBTEBbK
	dr9zZwCv97T24dtHfM94xREcX3+aKPtP9wSwXF/RYEST0kL9alvROR9BqBppnl2Y
	Py6UWAzCCe5zgTmACEfSlOuFom0WVAq0fL2J+2zoDhUx4iXRrz7Dzi8PimlS+Svh
	gHVNxQgX+q3r/BIU3cHCylHp/XuPky7P0WrxmMnbd+jUbUb1JZOe3bVzAsNbNdb5
	Dyyl5/rvqQilCiW9rcTmmI51JcDDV9ZnKPJ9qoFDrlAyABySxPGxSLQd6x+ldlq1
	HxQWGbI+qVQp/wefAgW7nIJgXo3XryHybMDuJgBQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc4wug8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:14:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54Wj3095317;
	Mon, 16 Nov 2026 13:14:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df81mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:14:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGDEEMA49152358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 13:14:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E00912004D;
	Mon, 16 Nov 2026 13:14:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB6E20040;
	Mon, 16 Nov 2026 13:14:14 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 13:14:14 +0000 (GMT)
Date: Mon, 16 Nov 2026 14:14:13 +0100
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
Subject: Re: [PATCH 3/5] s390/vmlogrdr: Replace get_zeroed_page() with
 kzalloc()
Message-ID: <20261116131413.125125Dde-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-3-3db507722530@kernel.org>
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
In-Reply-To: <20261108-s390-char-ready-v1-3-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX/fdih8WgGQhG
 jOfi1MqUMuov2gWwbK6kHEo1VECgIxQr/XcfWHx7F+iYkp/ZcD6+qo+/K+f4hduQxMveDwFO/Od
 pd4SN3RQsxuQAWykn98iUX6Y0VKF3O0=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afb01b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=ZkP2uM1e78bCdjAPzXEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MSBTYWx0ZWRfX5VTGSNFez0bq
 CqFE6XiJsS626wCkBj54n+CH4i1Wn/jwkptv34rleICn9aU6pJ6z6KG4JDAXe1i9en4tcoH0kZi
 N9t20LnzVMlWFtgBkqEjzgdNPU0JZC25wlp215SB6r3C+zWAOBoO0xOSbIiP9bxsWXOE5yVh9dL
 Cz9ks/z3qGUOL3uQn/lHIDzgLJq+cUjqhgxPIfhkMkM5YWHI9j9V+JWRNXXvDp6Mep24zZ1aWLT
 1waDNoRaLEHXv3mFaaMJKxM71UezXWpymL9Q+KCW5DHtHXQ32IJcnLcHvWQm7gW3J/lovL85fo9
 IXr1Q57zK45cIH5TNvKrv48C8b76aucMxBptmsynfz7Ad9AE/1YAuzyFFFAnuE6bXDTvShySVt2
 yr+9+7nkvXT2wZK5zTh/h8w2g2SUQK5pMJx1GWMVb1/++UM5eXEuWLntJud/8p6SXBqoRwRv5u5
 BLQAhSldzw00Kx3DMGw==
X-Proofpoint-GUID: -Drmaw-J5hcCDtW7D2vEHl2U39VrLlau
X-Proofpoint-ORIG-GUID: -Drmaw-J5hcCDtW7D2vEHl2U39VrLlau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160051

On Sun, Nov 08, 2026 at 10:49:00AM +0200, Mike Rapoport (Microsoft) wrote:
> vmlogrdr_init() allocates the buffers used to receive z/VM system
> service records via IUCV.
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
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/vmlogrdr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
