Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECB3009F6;
	Mon, 11 May 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512987; cv=none; b=JDuam+LltvfJ/mBVL58erZLLg2sMLSwt1v8vywq7yPLMglg7knUllDPz8jIJqyqx6F03shSUUwKryYXpKttYLjUk36PShUq515KRnVTZ0B+xWVUVEuwbJ5h8Hpiua/Yg93KAdNgSowx73qxhjux0rEzTS/QkOLlCXlFiB7kIcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512987; c=relaxed/simple;
	bh=tQTlRvkHXdTrQkxxae0MOn3QlXKepYIUITh2tgLTOl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFz2xF9ZKZBVYAQXksNZZd5a5BwB5ww+K3HvqGCG08g/H0lG0foGILuJ3Q8cRySWDumMfC4Ceh95gAOevLo7yojfniYs1H28Q1Cqpo68KtAAk9fngB4k9l1Tf3YP20MupG+S6A6lkL6/HiB12GBK08mS4fFUVcb/nNG5RW5ZYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N1ZlExLh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N1ZlExLh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B8nx1A2604219;
	Mon, 11 May 2026 15:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lREhxjgfMCEfNMe2J8pIiNemYsfo+j
	KGynVtsmFuIjI=; b=N1ZlExLhP6RfsP0FuGGNyrVj+Ngv0DTytRFIAdSBTU6+ni
	5F7RsrIyjiHgUOeXYuBcfG1yXi1OUwyAzTIsepgz2FcKosBahIKFBuKVupfwQFLo
	2FaQQ5cifxsz34jConKBFi8/s1PxaNVJqYPvKsRCwbIWRAqoKDYAyIw6Zyv/JhDA
	BuONcXMHHuTL/Lide0JcY+uBsPTzFYuvOA3JF1qkDkEwbNSvQAyElMYoc8EPa9As
	QK7ij+5KTjpUNxFNkdhhS5EHmJ3MNx05rOnWfTsAzZnk1+AdTL6JJDiHlbJ0ce/1
	p6LFfazX/+DguvonVOfPhIgF3LG8MkhJTSziscvA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju8atp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 15:22:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BF9cWC022908;
	Mon, 11 May 2026 15:22:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg5p2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 15:22:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BFMTEm52167146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 15:22:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763F720043;
	Mon, 11 May 2026 15:22:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3333420040;
	Mon, 11 May 2026 15:22:28 +0000 (GMT)
Received: from osiris (unknown [9.111.59.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 15:22:28 +0000 (GMT)
Date: Mon, 11 May 2026 17:22:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <20260511152226.9589G9f-hca@linux.ibm.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
 <20260511142157.9589E90-hca@linux.ibm.com>
 <9e313bd2-cc90-4b9f-9d6c-7dac8d9ec9db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e313bd2-cc90-4b9f-9d6c-7dac8d9ec9db@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a01f43a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=NFYRbTnByepKOcQhdncA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gN9Yk6mt80cK9LfSmo9v_xzOKx4r8LXy
X-Proofpoint-ORIG-GUID: 66JSwiufrwIzx4YfPj_zFY-ra2fLxLyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NiBTYWx0ZWRfX1ynHyOJtHkaC
 8U0ZYrKHh74sQaxFxjytwkSlxsL8uN27y45bSqkIh59anl/e0Gifw9Am4AgpCtA7z2l4Gbyc5AM
 ESRpd/TuUpB6Ms4Zds9qcl920m4oMTfbXeR6iivPPRGgCuw2cz6xTAX95FbfUzUYecpPB/T8bfl
 gH2WeXPtPpft2I0WUjuURstdDZVYwoV9A8oiYK6hek9Jb0fRoddektOTZ4BNKyPazoOEtScS2LO
 k3PL0TRI25618sxcgwLBlogm2hHSc9x0irp9Q/cAGdaf0pkdrw6c39KeVFE7B4XuFRamKgFhwnu
 2ZaLfHt45w1pp4tqTRfDQVFJjkC56Bfqz+3jRdJdgo0g0ZGV/ogyi/3ZV+/Sk2zM0Gu7ELaXIF0
 oSnNuyBxHHXLbmAU4Lmwgjm9bFPV0DG/MZo+FIGRVv1Cn9sWD7bHUcAEjQmxE+LU39frHFM7Tq0
 WEQFSkvKXu1GztKpy3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110166

On Mon, May 11, 2026 at 04:24:16PM +0200, David Hildenbrand (Arm) wrote:
> On 5/11/26 16:21, Heiko Carstens wrote:
> > On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> >> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> >> free_bootmem_page() nowadays always translates to free_reserved_page().
> >>
> >> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> >> We can stop including bootmem_info.h.
> >>
> >> Likely, vmemmap freeing code could be factored out into the core in the
> >> future.
> >>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  arch/s390/mm/vmem.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
...
> > What about the implicit call of kmemleak_free_part_phys() which gets
> > removed with this?
> 
> Thanks for taking a look!
> 
> See patch #4:
> 
> https://lore.kernel.org/r/20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org

Heh, right, you can't expect from me that I would read more than one
patch of a series :)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
