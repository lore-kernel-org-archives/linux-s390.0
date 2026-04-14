Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98433FE15;
	Tue, 14 Apr 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153245; cv=none; b=bpHpsl67YrdS0IREIAuFCTmDeihLvBWmAJqtjqUthWy14BKicg6PsTeAo2ClXB4vINUdoxNt/czj8+mIYw/SmOcUOG6TF8YP3xsoPurTlXNoijWaKWcaBbAwOA0K7vp8VPEp40P6cU22XfYngEwBoVOypTSv1Hf/Vb650keAU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153245; c=relaxed/simple;
	bh=CXgBMwK55opjJzMUBpU2rkS6yfwbAnuwkkhTLG/qOHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGdQUVYS32GnEqzQOX6OvwZa1UiksClMo3FbqcOl3oS74R7zz4ka1vZYg1HHeVyhYlApQT4Q873ugZM0vHYTiyUyg0Jjltypr2u1k7KdK1Gw/EOSm7yRvP1T+3/ZsizmKs+zmv+DPkbnVmv/DEZaBCj7Rq4ULPzHc/qiVpkgiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IA6HGNZm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IA6HGNZm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLI5U61804412;
	Tue, 14 Apr 2026 07:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gMS0mxag/gfHWiL+ozSGISUzVxNKea
	MQ4J8s26nr7m0=; b=IA6HGNZmmSJTouv/6XbTyyzkaQAZ5U8InO4fZQU/TDPkUY
	w8xa4+RvriuSQAXCRIw991AoOmzpUHAbL9OCFuybBFRL4iCZfxcjGp4k7J2oI6BL
	Unh/DiZUAtm+LMa8b3mkydaEqMEdJlpn9tKBM0E4FUwH2yFKj+QrO5oJrjyJYS/p
	N8bX8WLpmQLyfhmK9QYKIpzqzBhlbmnAmI6isSDOF1YwZpncO26qw5ZS9UiAbXdM
	E95EcZR+jfHB6sB3r7YXgtSb3Ra/RGSZY8q9qpD8QmbLnm2J39D/HhjHPvbefpGN
	J34139gGBl/Za/lCYLu71ouDto3ZuyM8eoU+tsHQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k1k8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 07:53:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E4lXck003594;
	Tue, 14 Apr 2026 07:53:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn8h7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 07:53:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63E7rojm31719952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 07:53:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DECF20043;
	Tue, 14 Apr 2026 07:53:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C89B20040;
	Tue, 14 Apr 2026 07:53:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.13.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Apr 2026 07:53:49 +0000 (GMT)
Date: Tue, 14 Apr 2026 09:53:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: make lazy MMU mode context-aware
Message-ID: <584f0f88-aef9-4a70-b0bb-abc797f741ed-agordeev@linux.ibm.com>
References: <cover.1774420056.git.agordeev@linux.ibm.com>
 <de89fd353a8dcd5e3bef4d91e9b6682d132ed9a0.1774420057.git.agordeev@linux.ibm.com>
 <44dd86c0-1845-4dd9-b4b4-2cef6d1c6357@kernel.org>
 <e096e88b-f1fe-44a1-bfa6-451eef028203-agordeev@linux.ibm.com>
 <665a19a0-47c2-404c-bd2b-482ab51b8f64@kernel.org>
 <896b3d93-8e60-42e2-b8bb-d3d4e8c99927-agordeev@linux.ibm.com>
 <534ed892-a6ab-454e-831b-e207930c35cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534ed892-a6ab-454e-831b-e207930c35cc@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3TgwcBaknJed_vxPvQ6kc4ZYIWQFnk4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3MiBTYWx0ZWRfX6kRG9BT4W6Uh
 bAoV12tGCeihyF52HnopkEgn7cXX0v/arGQp2vFCQvKS9TfcQuoSI/ouA8LgqtHnn8uTrRUykpZ
 Bk8k1SeG2L4BXK6YtqY9s6757iAsPGt8Ym2xsstyTzUkCk4jAzTQtBqSNDUm53n/SWhWQOpUPIx
 IGL7jQJjj5w79bS39EDC22qfq4XILm4sFrJ1jBPVeChE8B2UOjjvMtS6lmQFbUcB0Fk5CXNv3RF
 G3Uyb3tNufffqvpMj88QDEczRGHtt5any/7+mkXA8Xs1usr6S4rYBV5aKGsw7MxhvxVnEUpB5ax
 Ddaf4xMlSnRAaxyF04KQzsKY6DyJGLOCpuTIr67rYLfGsJXFzigbtnZo3LEdhr6TssFafnyb6Bc
 OU+QyvouyjjwvjCdQxDzhctGlrkFbUMDjhUrewqA+uWMOQzzuasbDAgdmHHjrZh8hximWiebois
 PTL3dHNKNNYtN+ZtEog==
X-Proofpoint-ORIG-GUID: 3TgwcBaknJed_vxPvQ6kc4ZYIWQFnk4K
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69ddf292 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=uo89_AGBClsq0BM26OMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140072

On Mon, Apr 13, 2026 at 08:32:11PM +0200, David Hildenbrand (Arm) wrote:
> > 1. copy_pte_range() operates on two ranges: source and destination.
> > Though lazy_mmu_mode_enable_for_pte_range() applies to the source one,
> > updates to the destination are still happen while in tha lazy mode.
> > (Although the lazy mode is not actually needed for the destination
> > unattached MM).
> 
> So, here a
> 
>   "No ptes outside of this range in the provided @mm must be updated."
> 
> could be used.
> 
> > 
> > 2. move_ptes() also operates on a source and destination ranges, but
> > unlike copy_pte_range() the destination range is also attached to the
> > currently active task.
> 
> But not here.

I did not quite understand these two comments ;), but I think
I address them further below.

> > 3. Though theoretical, nesting sections with interleaving calls to
> > lazy_mmu_mode_enable() and lazy_mmu_mode_enable_for_pte_range() make
> > it difficult to define (let alone to implement) which range is currently
> > active, if any.
> 
> Right. I assume you would specify the source here as well, or which one
> would it be in your case to speed it up?

It is in all cases the source/old/existing one.

> > All of these goes away if we switch from for_pte_range() to fast_pte_range()
> > semantics:
> 
> I don't quite like the "fast" in there. I think you can keep the old
> name, but clarifying that it is merely a hint, and only ptes that fall
> into the hint might observe a speedup.

Okay, that simplify things.

> Could performance benefit from multiple ranges? (like in mremap, for
> example)?

No.

> In that case, an explicit hint interface could be reconsidered.

So all things considered, how does it look?

/**                                                                             
 * lazy_mmu_mode_enable_for_pte_range() - Enable the lazy MMU mode with a speedup hint.
 * @mm: Address space the ptes represent.                                       
 * @addr: Address of the first pte.                                             
 * @end: End address of the range.                                              
 * @ptep: Page table pointer for the first entry.                               
 *                                                                              
 * Enters a new lazy MMU mode section; if the mode was not already enabled,         
 * enables it and calls arch_enter_lazy_mmu_mode_for_pte_range().               
 *                                                                              
 * PTEs that fall within the specified range might observe update speedups.         
 * The PTE range must belong to the specified memory space and do not cross         
 * a page table boundary.                                                       
 *                                                                              
 * There are no requirements on the order or range completeness of PTE          
 * updates for the specified range.                                             
 *                                                                              
 * Must be paired with a call to lazy_mmu_mode_disable().                       
 *                                                                                  
 * Has no effect if called:                                                     
 * - While paused - see lazy_mmu_mode_pause()                                   
 * - In interrupt context                                                       
 */                                                                             

> -- 
> Cheers,
> 
> David

Thanks!
