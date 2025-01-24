Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4B218EAB;
	Fri, 24 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710982; cv=none; b=ndVtJJdoQEM8dxebT+NKP16FF8Paqw+uivYPimZwaNxQjpGTaeHIfqfA2jDYLwhK3IprZ5Cqw+3crbAl1fDrz+jqViLZyzB3FVyHUH42mkUPu6w0ofdADIHjqBt1Lw1hts1HsylMluxBtYZxJRoJVU02RaJEtKwVg9zSkNlbg7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710982; c=relaxed/simple;
	bh=kaEHkgniiCLgXb7WBHlJ2LLMjYlV9fBMiBO8M3ezQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfXfFZqUXQHFdMGliDEXQz1tw1F/kFvVYYhZU7BnTWef1f2VKoxaZ0fWw5nBHInzmt6Cp9NIUUZXzI7Qa97z4AFA200gj9jaYlgJ2PNDsbEQct/NQajg51kymNCPGabEque/AkRLpBMuZJ3bGoqvGv0YksCsHe93CJWobjZVFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZcCFMLt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZcCFMLt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7WhWb021178;
	Fri, 24 Jan 2025 09:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5lUZ/YPnTLEpWEqDqsP/w2/812AOGy
	F0gvyp2+x/jx8=; b=KZcCFMLt85U0c5DyM4W70CAtJNR2l+4gRhVsnVDEStzjVj
	I4/3iYG4UdqtJuQCQFkEbGsi12gZ4C+GbTAQVZOB2CMJDX59Qnw7RfsxiBHa4pgi
	QB584yDDqvVFZUNCkqG7wNeNTfjVjq8sJvQSQpoAhCeFAsvZsCBv+oK3Dn8YR7/r
	aOc6rHl1eQkGKKgasPrcvp67P7JqClTR09h8HPIPuz+nA0z+kNJJlE2UCmNvFhWv
	4UPjkrYNviyvk7oqniiQVWuDWJtCJ6ObYDq06NPf5ADKOJ//lcDWScic5BhqbjrK
	FhfPOxF5UQgbZrsoHQ5LnnrOr0MEzAj2otw/W2Rw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jngftk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:29:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7GBeq024225;
	Fri, 24 Jan 2025 09:29:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yjvmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:29:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50O9TJIA36045110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 09:29:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8E3C2004E;
	Fri, 24 Jan 2025 09:29:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4737120040;
	Fri, 24 Jan 2025 09:29:19 +0000 (GMT)
Received: from osiris (unknown [9.171.14.46])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jan 2025 09:29:19 +0000 (GMT)
Date: Fri, 24 Jan 2025 10:29:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
Message-ID: <20250124092917.19507-A-hca@linux.ibm.com>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
 <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V-uGDg8XTKOr1m0ae1awbbrdB70WJwjm
X-Proofpoint-ORIG-GUID: V-uGDg8XTKOr1m0ae1awbbrdB70WJwjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=239 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240068

On Fri, Jan 24, 2025 at 08:58:07AM +0100, Kevin Brodsky wrote:
> On 23/01/2025 17:03, Alexander Gordeev wrote:
> > Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
> > level page table") misses the call to pagetable_p4d_ctor() against
> > a newly allocated P4D table in crst_table_upgrade();
> >
> > Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
> > the call to pagetable_pgd_ctor() against a newly allocated PGD and
> > the call to pagetable_dtor() against a newly allocated P4D that is
> > about to be freed on crst_table_upgrade() PGD upgrade fail path.
> >
> > The missed constructors and destructor break (at least) the page
> > table accounting when a process memory space is upgraded.
> >
> > Reported-by: Heiko Carstens <hca@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
> > Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> > Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
> > Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> > The patch is against:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
> >   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable
> 
> Thank you for putting together this patch! I was completely unaware of
> this "upgrade" path on s390.

This whole thing is even worse than it looks after this patch. With page
table upgrade taken into account we still have the oddity that e.g. a
previous pgd becomes a pud or p4d, which means that ctor and dtor functions
might be called for different levels for the same page table. As of now
this is ok, since they do all the same.

As a quick fix this patch is ok, and most likely it will be ok for a long
time, but it doesn't give me good feeling :)

In addition, looking at [1] where page table accounting was introduced: it
is really meant to reflect the memory consumption used by page tables. This
might work for nearly all architectures which have the same page table size
for every level; but on s390 the lowest level comes with 4kb page tables
while all other levels come with 16kb page tables.

Therefore at least on s390 you really can't tell how much memory is
consumed by page tables by only looking at nr_page_table_pages. It _might_
make sense to introduce a factor of four for page table accounting for
higher levels, so those numbers make at least some sense; but not sure
about that.

[1] https://lore.kernel.org/all/20201130212541.2781790-3-shakeelb@google.com/T/#mb6c6f2a84ded27cd9b3d54140dde1d5a75c74735
