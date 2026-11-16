Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850464;
	b=tTtg+HXW3bdsWro6ZHJpAaY1/Dlq09HAyb3DqQXceRAvmCeqG7ODAlUkEIZSOQLtUyFz
	 L39tvWndo3rqt1v2vJBh8o6kCIKctjtct8w/sgB3bvUp1YhEYttLlKA4SOrMS6SmWdxpg
	 oNPSI9OYJpANe9IRaP4qnbEas305nSZ9sG3+ZCO2YmHrIpHZBsE4vks4k33acFr6nN320
	 UPjAC5Va5+AJDQxmy1BAgRc12+2pmp0hmXdbrhRTIode3qww3oKb6WoPUVBQng7PPWb2O
	 dxvfHIjPIVOtX7/bV2ZHS/gnidY3luQYF2RDHk/kNFqT8vEyeWRsE7r+jGrmY964WIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850464;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=t8fFzc+67KQpZN7Xb9dT4z/F5KJZqrvBQ4Haj4SJy6M=;
	b=VKG5J68lfzunJsUXJPjO1M/sZj8u/XWLLgblt612J+htn4oYZF5ZgpRCfOHsY7TzYo1f
	 /TjaRGEd0fZ3zv48aqLrNVg9C8K/GEaP9SzqWjG3BskhPKsBVOM7y6wcE70guCaGykEf+
	 4l/IfXS5tKe3s6xSnhPMHS2quLusNdROvhAwg8tZu9YsYS0f0rapCmZ7ogg7nPpj/1uVt
	 N3oiwAuQLTNwqoBl66sMmU8BYh/+iD5gm1SAmuU0epsVJeViRBJ12YMPteI4SkKJVjk4M
	 5h6sE1lXVHNIcGC8sYzW0BjseKH6rQxsoiHhzijcpl7C1qcOxrUetjrOlSRKnUHX1Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A5Vlrj26;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C40606A322;
	Mon, 16 Nov 2026 17:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C40606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A5Vlrj26
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGPw0t3951380;
	Mon, 16 Nov 2026 17:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t8fFzc+67KQpZN7Xb9dT4z/F5KJZqr
	vBQ4Haj4SJy6M=; b=A5Vlrj26ejSk+eQpnWAn86Ta+qsTVbm6qUumrzWGQZ6HS7
	WiG9MqcgDAwX0gz4c7HdLG2lHn5KOXkELB/yPhl3V6w/foYwduqckKLk9vn2KMHo
	+LZXtMjaMzmHqQMZFEoUmBtCuZ5HT7W5+9PC8LllBSCHunmYyPfen27xurL9QxnR
	SJ85RYwbfJSWhLFL3CESdwv8LCkSPitn5RYBvHqjZk81qQmoIhMv5xI3raM3bpQd
	yradEj+VCo6NuiLBf8qlD3nXfCtI+EYZQtnJZdBqneoqKUssYIxQBvzNtW7uxXqP
	Vua6xfor/40DhWhbAZX6WMRJLO/n6bkppssOwL1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf566s7k-443
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:34:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7nxxK2129088;
	Mon, 16 Nov 2026 08:06:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy3fghgx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 08:06:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AG86OCd32571772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:06:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 407802004E;
	Mon, 16 Nov 2026 08:06:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B26B20040;
	Mon, 16 Nov 2026 08:06:23 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.34.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 08:06:23 +0000 (GMT)
Date: Mon, 16 Nov 2026 09:06:21 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@kernel.org>,
        Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
        Kyle Zeng <kylebot@openai.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for 7.4-rc2+ 4/7] s390/mm: always clear
 _SEGMENT_ENTRY_READ in pmdp_invalidate()
Message-ID: <0dcaca2f-7669-4b20-9204-68ed13d77ffb-agordeev@linux.ibm.com>
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
 <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
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
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX+1WCvfZo2A3r
 X9oHPlX7sjjz/znAFRDAQ6eOQ/Nl1RAb/A68sKsw3Ra/CMnZs24cDvNILCogjdChwM2uV6mWwx0
 iFI1dz9Q7swY9p+C2cfOngpjDOLUxQk=
X-Proofpoint-GUID: tqjVguXDKydwkTCpxf9Ih4XMa-8ERHOm
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb3e89 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=jawjUyVw3NHo_kiyCjgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RlKNbNXmJi-0aDghPxxu7N3gnH-oC2kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX952MX5YQ7qBz
 YkJZ5k+bKAalVpinT4yTjQaZoEVwToYnhZS9xVj7AU0ML+kHVOlPghWMWYkQm0bjbRa3SPuvuNx
 uK2NWUhCP2ObGGBrJBvT0d65RMPLSaCX6rk3NcwbhSFnig+XA76oBQ6xgJxndSM1NdwkoIV4w+R
 RGddGHx7+F2QVMBcPEsWB9Vkik5TH2jjYXLYVL466IZhAIxFOmyDE6yNH5D+ABQChfML/tdXLG1
 Q6498yG0qniB9+BQD5hTu6QhDJTWvRmvSLuvxABlEubVvfRnxnUNvr59GCAVjnKUwj+Je1o/Qwc
 VI0w54BxfbhigH1I4dawMZIYb8tTpvXuTkFMOpBrD46sCF4sLH2MY/Awle2nd5jC0+pcw45ddFZ
 Zpc97ifK2dlDKy7QBO8vghKgwV/y628NvQWnoORtnjwexAXLFHHJnhjGvAASBCZNnlOxKBw6P8B
 uBGj2c3od2C7Xtzqjkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

On Thu, Oct 15, 2026 at 02:13:04PM -0400, Zi Yan wrote:
> pmdp_invalidate() sets _SEGMENT_ENTRY_INVALID, but on s390 that bit
> alone also marks an old (not young) PMD, which is still a valid mapping
> that GUP-fast follows. Without CONFIG_PAGE_TABLE_CHECK, an invalidated
> PMD is therefore not pmd_protnone(), so GUP-fast can grab a reference on
> the folio and, as the PMD value doesn't change until the caller
> finishes, the recheck after taking the reference passes too.

I do not quite get how where pmd_young() (or whatever) participates in
the scenarios you described. If you meant something else, then the
wording is rather confusing.

In my reading it is the notion of pmd_protnone() decisive for GUP, not
old/young.

> Code that invalidates a PMD and then decides, from the folio refcount,
> whether it may drop the mapping relies on GUP-fast backing off from an
> invalidated PMD, like it does from a cleared one. x86, arm64 and powerpc
> already make GUP-fast reject invalidated PMDs.

Why the code change itself looks fine, I would love the commit message
to provide bit more details.

> With CONFIG_PAGE_TABLE_CHECK, pmdp_invalidate() already clears
> _SEGMENT_ENTRY_READ, which makes the entry pmd_protnone(), so GUP-fast
> does not follow it. Do that unconditionally. As noted in commit
> 7b4dde5e40ad6 ("s390/pgtable: Add s390 support for page table check"),
> an invalidated PMD that is pmd_protnone() is fine for the remaining
> pmd_protnone() users, which run under the page table lock or are
> lockless walkers that should not follow it anyway.
> 
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/s390/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2d5c2ab06de98..fe1ba746203ab 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1781,10 +1781,14 @@ static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
>  	pmd_t pmd = *pmdp;
>  
>  	VM_WARN_ON_ONCE(!pmd_present(pmd));
> +	/*
> +	 * _SEGMENT_ENTRY_INVALID alone also marks an old (not young) entry,
> +	 * which lockless walkers like GUP-fast may follow. Clear
> +	 * _SEGMENT_ENTRY_READ too, so the invalidated entry is pmd_protnone()
> +	 * and is not followed, and page table check does not count it.
> +	 */

Could you please remove this comment in favour of more descriptive
commit message?

>  	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_INVALID));
> -#ifdef CONFIG_PAGE_TABLE_CHECK
>  	pmd = clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_READ));
> -#endif
>  	page_table_check_pmd_set(vma->vm_mm, addr, pmdp, pmd);
>  	pmd = pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
>  	return pmd;

Thanks!
