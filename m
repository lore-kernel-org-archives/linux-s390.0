Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA481DB125;
	Mon, 12 May 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059758; cv=none; b=A3evGNdB8Guro8Q7lFb4S+FGwT2jHweB9bC+qBqZZc19wxCaQnfHZKbkyx3JhKHb/GBzut+xcma81rPVYWIJM/0w/DKZ+Co2My8HG4AbeKIAyxO/npioyc3jCgR5VvjqLnnt+ytpMwkqeHF/VRjLxfO6skKyvXcMkTSXu2ejHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059758; c=relaxed/simple;
	bh=TXV3g3oc8Y63/uFVcAuPYNPRD80wHASgBqsix2GqaGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeGiidVqduQ6PQQpu84CCGLskkU4bbLv5yJxOXVlSlT+qMhgbUPFHqUBdy3NSnw/Y1uUTUqt/A2r4hiaETJ2umhAF8ouc0xHVb+XWfYYRoCaYL8uce+QT83MLl4uL9TdkAXHKVziRHq5k+Q50/B6E0KKERhO1u4ybYc2L6eKTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cFo/WhMX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cFo/WhMX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C9Et21015544;
	Mon, 12 May 2025 14:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bYTcl/cxzHc+BRnCsqjMP85sfGh2bQ
	zuASBHWbuH1bs=; b=cFo/WhMXSgECykOjZZjwnuq/nCvcslJ62lAaNglkN4unfA
	v2g0sQphgjMdi4h6sOlpYuGO0Haq36U3M8rU0oBXzXo9IgPtDf9B5LqgEz4cbKyJ
	4F3qx/vfQB7qFQWH46Pc0Ty7T5FhsVDgUPDi5UPGO6vwQ0VhTC7m25IQP+hP2aCj
	w0/FBCZb4F8dD01qm4a0PVev4vGnInLHy8EJGjVNzVXxT/k3n7HsZvTiDhwOMIZY
	92wFRMxFl5KLAGIc2wqs3F1OeM3MlIIJ89aya3hF+NAJAl/JMSM4vFqBEPjseK06
	f1N7gyrVTYI39X1XIPsvspz5cdVMMJUWVypYU59w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ke6j1chk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:22:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54CEJB10007431;
	Mon, 12 May 2025 14:22:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ke6j1chf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:22:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCfoDo016955;
	Mon, 12 May 2025 14:22:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgyxfd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 14:22:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54CEMPOJ19792146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 14:22:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC7220090;
	Mon, 12 May 2025 14:22:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B20622008F;
	Mon, 12 May 2025 14:22:24 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 May 2025 14:22:24 +0000 (GMT)
Date: Mon, 12 May 2025 16:22:23 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <aCIEH5WvkhQreVrV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1746713482.git.agordeev@linux.ibm.com>
 <aabaf2968c3ca442f9b696860e026da05081e0f6.1746713482.git.agordeev@linux.ibm.com>
 <aB3ThByuJtxMpAXi@harry>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB3ThByuJtxMpAXi@harry>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z5zmlcPwAaxOT6dGMJKaE4i4QQ5NgCNF
X-Proofpoint-ORIG-GUID: iycNLknPJ7DkqTOcqNurG9cEEwXlcdpL
X-Authority-Analysis: v=2.4 cv=auyyCTZV c=1 sm=1 tr=0 ts=68220424 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=eJIhiymoiUTLQAr0ViEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE0NyBTYWx0ZWRfX0osQ5VCGYDmC VT6/dx+dPlH6iVSL7LJppXlgJAK4JKkNpmBUem/CxOpDQwDPpoevEp4EwH8SMdH5KvAWtZouMuT lSSQear8dwM1EhOgr3tUK7jyo3sPFSG2jB2V8+1zjNHCGpwlfOg2V13D8hwl/Hs7Vio5uFmPAVj
 MCrAFtLcTz+HrLhFTojH7+zoDpzJZu7GQny69Bvt6sGbF9aEpbBKCl2zfbwwQlRqyKkTygaC/xt mU32E1o813SeKsq+yRpd8oo3ih3YcT6Qe+FVvScY4RlKHLxuT2YmFZJvC21CxQ9kVsuLNhFCp10 jAQcrdRlZiqTUYAQyp5XqWkul1GdfV4LKGsjJviXth22jT3TJMcTknNRxyrt4N1cguYoNmRCeuO
 76v++8k7K2qXpf6fV5gnL1CvCV9sCwX726Sv1VCbIO6UeGj3StppL+7l0dGBy7oJhSqEwgDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=563
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120147

On Fri, May 09, 2025 at 07:05:56PM +0900, Harry Yoo wrote:
> > +	while (nr_total) {
> > +		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> > +		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, data.pages);
> > +		if (nr_populated != nr_pages) {
> > +			free_pages_bulk(data.pages, nr_populated);
> > +			free_page((unsigned long)data.pages);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		data.start = start;
> > +		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
> > +					  kasan_populate_vmalloc_pte, &data);
> > +		free_pages_bulk(data.pages, nr_pages);
> 
> A minor suggestion:
> 
> I think this free_pages_bulk() can be moved outside the loop
> (but with PAGE_SIZE / sizeof(data.pages[0]) instead of nr_pages),

Because we know the number of populated pages I think we could
use it instead of maximal (PAGE_SIZE / sizeof(data.pages[0])).

> because alloc_pages_bulk() simply skips allocating pages for any
> non-NULL entries.
> 
> If some pages in the array were not used, it doesn't have to be freed;
> on the next iteration of the loop alloc_pages_bulk() can skip
> allocating pages for the non-NULL entries.

Thanks for the suggestion! I will send an updated version.
