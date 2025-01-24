Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EF219A80;
	Fri, 24 Jan 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711604; cv=none; b=TquMPtaOxeXF1aHeNaGIelS8gadd3OjW22MNpmhf5uNEcBQfS9538BrPea1EVEhZxGFnxpmxfCdZuSeZ45SJ5kJ8OazbDKBlHZNQeS6Zkkq16hS2EKjQCZSfxdEWBG/+V+vE2rGQUXGZBMMTHAOYHSIMxOpzD+etfiwwp6A3J2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711604; c=relaxed/simple;
	bh=SH4kB/1S/NNvyPmg5xLLixlKrfuC5PUFwYAwYYFaG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4nEzJaVdnjboLGWgQ1ExKfWZ28/4w9yZLC7u/okkdVtsom6JJkmzfOZ9rdhr5voVjUAkqxBe56SvrIhJNHhm+upRH80mKongb+PMQhHsTlVFpFpCmcQQK6KMu86E4kIzUv1Z2m+AAG8ukMAtaINkxtyZwSH0KWFaqaQOlgCYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3Gn9Kkw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3Gn9Kkw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7Gevh019218;
	Fri, 24 Jan 2025 09:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=euSSqRsocsBLpT+sD8KiFSTkI0r7D+
	UF7rQijaSe/GE=; b=D3Gn9KkwBtburx1wZdIJ5U5VPTtF5A4c4rzkUJlaIlbcuG
	id5ajLAgzFSdwwvrDVqlQTLyYJjlnMfHkrQznOtaZVlHDMEtzUQUo4kv63SZOjee
	TK+cQvv9iy863vf5XxJAJbTPy495kcyTUwOx6OQHW2btlE+naOSW8+pjNFCfHS/J
	i0I2auV5FYNjdhcKURsadLiSVYy07OKfRJswnA8Hhh2IcPOZJrq7UY3bJhNiDpgN
	wlkSdPHsPcjvr7Px0qNw1YqmukNtJ3J8J/mZa3qCWeT9OTP4crjnIFZ4fJm+hgw1
	7cqjvPuLFuxB0QorQ5p4eLfN+/cNbNyR99AQtdQQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x92y4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:39:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O80S1Q029587;
	Fri, 24 Jan 2025 09:39:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmntt1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:39:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50O9deth58130882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 09:39:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82EF220154;
	Fri, 24 Jan 2025 09:39:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1077B20153;
	Fri, 24 Jan 2025 09:39:40 +0000 (GMT)
Received: from osiris (unknown [9.171.14.46])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jan 2025 09:39:39 +0000 (GMT)
Date: Fri, 24 Jan 2025 10:39:38 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
Message-ID: <20250124093938.19507-B-hca@linux.ibm.com>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
 <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
 <20250124092917.19507-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124092917.19507-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oubK88tcqYsjSNeyzN7iYN_w5akgJ703
X-Proofpoint-ORIG-GUID: oubK88tcqYsjSNeyzN7iYN_w5akgJ703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=291 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240068

On Fri, Jan 24, 2025 at 10:29:17AM +0100, Heiko Carstens wrote:
> On Fri, Jan 24, 2025 at 08:58:07AM +0100, Kevin Brodsky wrote:
> In addition, looking at [1] where page table accounting was introduced: it
> is really meant to reflect the memory consumption used by page tables. This
> might work for nearly all architectures which have the same page table size
> for every level; but on s390 the lowest level comes with 4kb page tables
> while all other levels come with 16kb page tables.
> 
> Therefore at least on s390 you really can't tell how much memory is
> consumed by page tables by only looking at nr_page_table_pages. It _might_
> make sense to introduce a factor of four for page table accounting for
> higher levels, so those numbers make at least some sense; but not sure
> about that.

Ah, this is actually not true at all, since we have

static inline void __lruvec_stat_add_folio(struct folio *folio,
                                           enum node_stat_item idx)
{
	__lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
}

which will do exactly what we want. So this part is not a problem.
