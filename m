Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E23CE480;
	Fri, 24 Apr 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034067; cv=none; b=oIyebT4y91MIOVeS3Hbs26iVUubKuJMYpRO1kHG6ssyN+ci/L3EN9qN+vhTutKVSBNazRP+dDqv4wSaU8WwmahrTbTMFHv8VGRyY1hkcEYKcRAKRv5E3LRFe3Xi47z3ON1v3clFwhh3M0dgXdr/W0iT72NOoBIXWjRURZRoRjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034067; c=relaxed/simple;
	bh=Sj5lJItL2b+wKcEsOMeIgUm/8f7JWQUeiVfwt+PhYfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd/OZilY0jrve+wtaQj+Kce4O7LYEqyKmskhumP9fHfheuIe6SdCBnFRp/lscRu8v1CnTppNj42+hYqOq2gfPrWlrV8btaO+cPtHjCk9gdrII6R1KYTNE98QARtBwHh1DFHiLwh64sBxO/MrY89T2oJwx4IPaYSPPK2EF2+E3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X8SHAEDV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X8SHAEDV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OB2UlK3514991;
	Fri, 24 Apr 2026 12:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LzKyf8UTh3N7ovmWga6KGVubFA6cr6
	oHAnNLtfRwXWc=; b=X8SHAEDV5+MSYfp09SldUFWXZLGKj8VitKtlPczbqqmuqQ
	QjVxAlnrvsmB5b51xXJ6ZlyVhSvbCueqQIxajMGuynUJpwUGZcdWTKM2Ort1AzkF
	7PXcDwll7A5RYo26YrisyZjcsDg8ACZABhlMpgaPI88pDXcDnmz28PT88N8gMgb2
	npY+6W+vs5xFrdqlJiw244SCfM62mk3G35d1TjrMZ/+S2T6095XgZ/BtD8cKWi3/
	8nVbNEHinIhmQ+4zxIZg3+r1pUh7FLRG6zExCFF80nq1mHAPhIp0TLo56LPTiYid
	YPxP/5RILEmCjBi5ZFGfp8/O114sf624gwf9ri+w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2dtu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 12:34:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OCKQhY012723;
	Fri, 24 Apr 2026 12:34:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkytsdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 12:34:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OCYBv935848628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 12:34:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4F220043;
	Fri, 24 Apr 2026 12:34:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E258220040;
	Fri, 24 Apr 2026 12:34:10 +0000 (GMT)
Received: from osiris (unknown [9.111.75.211])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 12:34:10 +0000 (GMT)
Date: Fri, 24 Apr 2026 14:34:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] s390/mm: Complete ptep_get() conversion
Message-ID: <20260424123409.17231A9d-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <7ad766612a3095c8c8d9a253ef0f484ef98196a5.1776264097.git.agordeev@linux.ibm.com>
 <20260423105118.10371C15-hca@linux.ibm.com>
 <0ce9c2f7-e9cc-4018-92fe-a2a966889181-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce9c2f7-e9cc-4018-92fe-a2a966889181-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExOCBTYWx0ZWRfX8n9GO3boTqjz
 h7I7OC1XFOKCejg+DJa2O7ZKof1ZfqBT2mQRaIOFQZTYUjqZQsyGf2AfxVOYReFOG70ObyIX7fg
 Qturfmw+udcbd4+K6AfTqtrEGc4IWCgCzd/uZesVtqy5MncYHuTiBXyLm9WTEPGeEOJ0DtNUPNW
 5pJCige5IqBFHQgje2tWp2+eFRrvjbGgu7ar8yV11C7xsftv0J1qphuzelbM2CQGnlOcuv+1X4k
 kEMPL20vtj40eR1L+Ju8fj9+9N8sONLa+1AA7cC2nBA07U/PVdnRgV6GbaHkFP4SjvQp7ACaRoz
 FyaL632Y3HIkgv9/gax5X08Ly1H6nLqFa5qLqOU47bvdRsR5jZXYbDrTQ3KUYVxd3lrGZc5/Vvq
 IJgUYaHeRFyawC8t4174yvFYfop1XyCrF8xB1IG8jDd2UxtJqT7HqXpcheZRKnpTTvUtEw1JJul
 2FZ5aZWtNFwXbY3rO/w==
X-Proofpoint-ORIG-GUID: icoZdh8nf5dPK83kxeoN0tD05t27Jypc
X-Proofpoint-GUID: icoZdh8nf5dPK83kxeoN0tD05t27Jypc
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69eb6348 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=GKgLhbmL3SFRbt7ApYcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240118

On Fri, Apr 24, 2026 at 01:54:18PM +0200, Alexander Gordeev wrote:
> On Thu, Apr 23, 2026 at 12:51:18PM +0200, Heiko Carstens wrote:
> > Was this a manual conversion, or did you use some tooling?
> 
> Manual :) But I will try to recheck with a tool.
> 
> > I'm wondering since I can spot not converted locations, e.g. one in
> > __kernel_map_pages().
> 
> Whether this fixup is fine?
> 
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 3a54860cb05f..e6f788696dd1 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -455,7 +455,8 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>  		nr = min(numpages - i, nr);
>  		if (enable) {
>  			for (j = 0; j < nr; j++) {
> -				pte = clear_pte_bit(*ptep, __pgprot(_PAGE_INVALID));
> +				pte = ptep_get(ptep);
> +				pte = clear_pte_bit(pte, __pgprot(_PAGE_INVALID));

Sure.
