Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118102;
	b=T++rk+MVAEcFClw+jGOct1kMwSuVzRWHc7UMcBC4NyMOuHPGQmY6gN+wPOFSm4/NA2ot
	 GFbL5wnjxZ0dJAasNmzyUezCWwLh3dStrAtg2PePLTTsp7urrk3QpaF9tKBPkI9zwoPuS
	 9raU+5fATvQix+fm3Md3S0h/34au3KFuk8L+w8N1npUZUAeRsf/70LIDXR8riqDVTUC9l
	 Qk9PaGJ0rjkLS/Z/mWU/fBfjJwzOTGXVDdaPisadap7MNOwv0nwp3d1dYUV3duyIUuozt
	 ylpxJkgaKwLITC4HL33CswpP+fE8teHt7CZreGSU88fikaFd4VxSegMSX47qjuDVqrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118102;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qUumBf+yvrMPq1LrevvQ5muT+FYrWL10mpJk4Q9mBhs=;
	b=OKG56EuIkfF6zkz82Vaix2mJnmfbe8KFEREty115LnSY7RnVeuLKc34sDeFmnoI5GAkQ
	 VNko9N2J+iqNTUQIkEu5FhYTTXShlTm8T7LBWH2//Mf+VKjOi8/FoqUOAJvXy6Z1By8Ug
	 KUX+iYvyuGBQXDYzq0wC8RmN+c+ejOYNRswcWOy9E6kunBHgQI5Juq93O2YnAgsxM87aW
	 BZJW54wKZR6uzJnYuhqV0iYiN9Z6gW8YxqQlM7VTLzMesGI88eZj8ThJWvl3Is0g2w3NY
	 wWJNtB+/TaAdj8vYpxIdDkDowXqcixQ6M0CNsM5wqzUISKVjrXG3QGb8cVLfK+5nbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oH5kjYX9;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECF606A337;
	Thu, 19 Nov 2026 19:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FECF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oH5kjYX9
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJJQFod3857977;
	Thu, 19 Nov 2026 19:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qUumBf+yvrMPq1LrevvQ5muT+FYrWL
	10mpJk4Q9mBhs=; b=oH5kjYX9JwBL3BFCiA2GQ6Q0kF7PljV4Ig5NqfH9+actUW
	nVGJwCz2iYbXEvdWmTjDSUuRVVFhrOOgPovyBsJlLF2wVYjkVEMkSM6fvI+PA7Lp
	w1ga34y1+4Rm+L1fHDHTXecWG+FAXzDq+ZhR1KUIvlP6d1xE49TriutdUf/+tRqq
	EuAvStznYVOanupDLm7bcAkk3ULo+avEDQFlwY+8zcBueCyPidDdslJkjPL1ptSC
	8jkIEV+Cf20veeO7n6aAvZTHBqMr9PREmZjNay6trYLcbCKUay/92tIqj5eZ7Tv0
	epJnjgdOOWTM1LzoEaM8b/uw7uCocYMurpVIWGeg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w3bfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 19:54:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJJ4vhQ1345955;
	Thu, 19 Nov 2026 19:54:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6xfy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 19:54:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJJsow518022692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 19:54:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ACEE20043;
	Thu, 19 Nov 2026 19:54:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2EB20040;
	Thu, 19 Nov 2026 19:54:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.80.212])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Nov 2026 19:54:50 +0000 (GMT)
Date: Thu, 19 Nov 2026 20:54:48 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/14] s390/sclp: replace page allocator calls with
 k[mz]alloc()
Message-ID: <e7aece4e-7dc5-455b-a631-721ab99e2546-agordeev@linux.ibm.com>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
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
In-Reply-To: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vArSZlzO0-sG1YYaAhCwBZXx_D79nzTA
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6aff540f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=TmjFby08mKWOAxAHkrkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vArSZlzO0-sG1YYaAhCwBZXx_D79nzTA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA3NyBTYWx0ZWRfX+ubZyRpjqjTH
 Xytrqff2ozuSNCaIc95w3XNzQ9CC2eY0BHIygLD0QeHf+LwN9clBqt7Sllqxsljpx1mEpsrg3a6
 Z1sG4870orpJ7cJc4abB74Byat9rmCg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA3NyBTYWx0ZWRfX0MpdOWjivhif
 wZns8I+PVrQ5LC9X77eNl+V4C33psnPXCO52ttyXNbzw1OQ1fpY3OILtyBvGpm5PvA7G/3XvlZ+
 QIQZ9aS4Ne+dR+GCD0a/TmQLlhnNlF2Q2AFnhRQFqlLPLaVsH5dH01rfKfEoEhZ63JjIrndzJpH
 ulYGtNY9qanc2Brq08wYa86teWuMNrAAlEzLdP/AqaJNU4OPDl3Kf2zXm7il4R4asuNhjJGoyuE
 eII89dvWMkSr1DEAqeScFsKwYn9+T9wJyPy40ovOKeLkorLHrvFFHhJV7BjOv2bj7iq/Wndbq+K
 tWziYtDz4fGigKdpH2EPszOlUdG8JAiK23zBvFNa/GQWynr+U33iZtEooNTbh9D/yA0N7aOUk6L
 hmueakbV8n68hC3fJeFx/mCPk97Uy6H6dikQTJSQWwsD3/NQbRei2nGBM4zJJulIZ2qhujuV9wz
 3DGGUtt7XJgCq6BA2ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190077

On Tue, Nov 17, 2026 at 03:06:52PM +0200, Mike Rapoport (Microsoft) wrote:
> This the next episode of conversion of page allocator calls to kmalloc
> family :)
> 
> This series covers SCLP buffer allocations.
> 
> = tl;dr cover letter copied from the previous posts:
> 
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> kmalloc() guarantees alignment, physical contiguity and working
> virt_to_phys() and beside nicer API that returns void * on alloc and
> doesn't require to know the allocation size on free, kmalloc() provides
> better debugging capabilities than page allocator.
> 
> Another thing is that touching these allocation sites gives the reviewers
> opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> another size is appropriate.
> 
> For larger allocations that don't need physically contiguous memory
> kvmalloc() can be a better option that __get_free_pages() because under
> memory pressure it's is easier to allocate several order-0 pages than a
> physically contiguous chunk with the same number of pages.
> 
> And last, but not least, removing needless calls to page allocator should
> help with memdesc (aka project folio) conversion. There will be way less
> places to audit to see if the user was actually using struct page.
> 
> The patches are deliberately kept small, so that every conversion can be
> reviewed, and if needed reverted, on its own.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/s390-sclp
> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/
...
>  drivers/s390/char/sclp.c         |  9 +++++----
>  drivers/s390/char/sclp_ap.c      |  4 ++--
>  drivers/s390/char/sclp_cmd.c     | 13 +++++++------
>  drivers/s390/char/sclp_con.c     |  5 +++--
>  drivers/s390/char/sclp_config.c  |  4 ++--
>  drivers/s390/char/sclp_cpi_sys.c |  4 ++--
>  drivers/s390/char/sclp_ctl.c     |  5 +++--
>  drivers/s390/char/sclp_ftp.c     | 14 ++++++--------
>  drivers/s390/char/sclp_mem.c     | 12 ++++++------
>  drivers/s390/char/sclp_pci.c     |  8 ++++----
>  drivers/s390/char/sclp_sd.c      | 20 ++++++++++----------
>  drivers/s390/char/sclp_sdias.c   |  5 +++--
>  drivers/s390/char/sclp_tty.c     |  5 +++--
>  drivers/s390/char/sclp_vt220.c   |  4 ++--
>  14 files changed, 58 insertions(+), 54 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20260907-s390-sclp-ready-05ebba1ea5e9

Applied, thanks!

> --
> Sincerely yours,
> Mike.
