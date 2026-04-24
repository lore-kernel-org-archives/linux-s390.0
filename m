Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568135B62F;
	Fri, 24 Apr 2026 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031675; cv=none; b=qYJkMuhO1oftUKEBBJDFt4RkFeBgXcahZA4UKCzcC2SF8zoRfWTu4mqhfUCVJ0P7FyaUnuExZbU1ldGaQLBlAuE5yT5koLLho4DfqmJFg+/T9M63A904/GeXID5lKVLIYX1KOTXN0naQ0oRJzt7xXLFPBf5ZEXF3IaKQcbSTfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031675; c=relaxed/simple;
	bh=aSSzA8LG0A9kwpNbdsIc2MW64H99I4o5Db1o3aeRVTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBajIdMW9mZ77JE5Zh/nEdbbQcGh67jRNwLlS3LclDT5iScX9OJBPkD8EemSowtQNdry1RAmw0rzsX7Jgn7CHIUE5iG0WO3yGt8wAtpXtdeO0BpxoNqKk/dDwn9D8CvGN5vrDWdmRfoZMOzY4MaMRY+gw+36A5e4n6ttkq/1DW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i6H58vB8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i6H58vB8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O9sItb3229011;
	Fri, 24 Apr 2026 11:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+wAdlqQB/ZcosrMkMEnAlX1EnYA8Ql
	tq05LW3i1TVMI=; b=i6H58vB86JvZ63VK4wgXeAOMV68a1wClDNsat1FP440E5s
	uTZkhPT9c+IOp8oP7ijZG4W9c/OENGf0k2bVIVyGbdsmerb86UdOuGc7T5THi/qW
	gzuZyWx52kr1GahEUY57znw58696lGWndDxnhAfPHHTQIE8ZM4v8I60+wsv4N7i9
	O06IDen1PXW8iQM5W7m2C5zGTfQDdcN8lMXhjveniG6dt1zF0be7ctfslTHkvFTp
	xklAsOOP5GRrZU6BExqguzU8cOsXaP5f7orsNK6YvRSsDwNa/pnkyUzzzf4ZfasB
	zEApF4MmoulRvPIqvhw3QHQ2Bn8+WIgrUOn8lFAQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu2dm3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 11:54:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63OBoGIY014370;
	Fri, 24 Apr 2026 11:54:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkytmxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 11:54:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63OBsJq647382898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 11:54:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 819DE20049;
	Fri, 24 Apr 2026 11:54:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52AD520040;
	Fri, 24 Apr 2026 11:54:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Apr 2026 11:54:19 +0000 (GMT)
Date: Fri, 24 Apr 2026 13:54:18 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] s390/mm: Complete ptep_get() conversion
Message-ID: <0ce9c2f7-e9cc-4018-92fe-a2a966889181-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <7ad766612a3095c8c8d9a253ef0f484ef98196a5.1776264097.git.agordeev@linux.ibm.com>
 <20260423105118.10371C15-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423105118.10371C15-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _tBjGR7m1MDL9l7NnWkpQNGHIoum42SJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMyBTYWx0ZWRfX6ZIBUbdeUSbk
 iC7bi1WAG6BiKq3V4pqZWM2UVoSJSrI6Zga/HgzDb6o5DuDExGC4v6b2DvPUlDPhceYB3yzJeSd
 W9hIimXmraCtp5Xd9B2x3C41Ag8T9o0g5uxk0UnBHsagVebB0vjbKnNZIy83Er4UnDHS1dHQaPi
 0StRNyIzh1aXvQ1swzbVBkM0pVN+8DgBAVgrKXa0rJN8qWlHkxBLxWz08tuGOhO5XZ97yVjASK+
 bIH9Egf2utbL2UHK7ShiYxwT6hSOSFUKsvQQXh5SfrYiYrV96aE1yvZW7CZ667E/rGxkFA0Iahg
 Zj4+IwVqJtbyU+FE4jOQaY45PjeI3AWZ7tzeQFBESVtNitX30EfHe/DdRJ8lGq2lHpgPPQo48kN
 ALc1cMIhOejsjIYOBXgX0AQewO27u/LRgzE7y1gA7PuBsJrY6CFVqXJQ19CNBCVdJhBqZYpmgno
 DLOfZN1AUc8JkjMjWkA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69eb59f0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7-lpDXNR-v68OR7j9qkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _tBjGR7m1MDL9l7NnWkpQNGHIoum42SJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240113

On Thu, Apr 23, 2026 at 12:51:18PM +0200, Heiko Carstens wrote:
> Was this a manual conversion, or did you use some tooling?

Manual :) But I will try to recheck with a tool.

> I'm wondering since I can spot not converted locations, e.g. one in
> __kernel_map_pages().

Whether this fixup is fine?

diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 3a54860cb05f..e6f788696dd1 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -455,7 +455,8 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 		nr = min(numpages - i, nr);
 		if (enable) {
 			for (j = 0; j < nr; j++) {
-				pte = clear_pte_bit(*ptep, __pgprot(_PAGE_INVALID));
+				pte = ptep_get(ptep);
+				pte = clear_pte_bit(pte, __pgprot(_PAGE_INVALID));
 				set_pte(ptep, pte);
 				address += PAGE_SIZE;
 				ptep++;

> Besides that:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
