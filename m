Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998BE545;
	Tue, 24 Jun 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770902; cv=none; b=O4to3OZrimpn0rd4aK3RXp6jYhK17V0vCf6sb44X/CgeekcpgSIMl/JVXJVE1D9BiK5RxcKX0Ogpo1e5ozXQkmvGIYRiUqNqo68biccx0v2Fn2rbLHZCzfCFbC4+JoHcKxv31WgRO+lc4L+9FQ716erdBAf6wm0ZLuU2c4h/55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770902; c=relaxed/simple;
	bh=Bzhixx4T91nBv3P8Bqk+Fpebq0IazQmzzfQrPRrnGmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8Lv6xAceMSIA9W3ZkmFmKy0LhkiM3r3mkHGq9qy7FqWeMPiFLQ1l/CCe+B0XbXazAod9ZVXu/MPD/jRjqTBANmu9I1sDj1fAsf/pTSFjsf1pJqCULZwksUA4ZHVW9SYkvIn2ovjMBokUBbpkmH50w/SvHSrl1P954GCmdzeJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ttkp/TMt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ttkp/TMt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O9SR9j010062;
	Tue, 24 Jun 2025 13:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=U1b7kGuG6w3J+nQm326bu7WrlCXb8Y
	4yIFWrd2HzQ7c=; b=ttkp/TMt1njJEUuanIdX00YM1lq+GbRNVJHnk5bhxhCgJn
	0Wyq361KKhWSTiscw3ZXfe4+Nr10lQm7y+c869NoctO0G+9VvYLeYCbrNPoFeHbf
	aNSb7VndV9CL3DrqtrBPlDhx42xYbsdx+HnLWTNjF9p+QJP50Rr6oXPbOTK80bOd
	IvBaddFFPzeaUgOCjQGaEgSIJV6muKZd5jtxD3A63uw7rMTr+VU7OeBX8EFwCjnW
	E7qrz2bYS12d4DGLLE96+CSrY7gm/b9/FfRE4QmsypRmDJVGt6rZf3Eb2DXt7+5i
	N+CMCSRqLczUz7g0WwxbqnU1PIYdLPdSyWT2TcuA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe8vhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:14:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBSTUE003983;
	Tue, 24 Jun 2025 13:14:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kkvkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:14:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODEaIp29491908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:14:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875C92004B;
	Tue, 24 Jun 2025 13:14:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F8220043;
	Tue, 24 Jun 2025 13:14:36 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Jun 2025 13:14:36 +0000 (GMT)
Date: Tue, 24 Jun 2025 15:14:34 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, dev.jain@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH V2] mm/ptdump: Take the memory hotplug lock inside
 ptdump_walk_pgd()
Message-ID: <aFqkus8o8HESv36F@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250620052427.2092093-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620052427.2092093-1-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tpoh_-DuFORup-7aDX-wiD9nGJ-goSq1
X-Proofpoint-GUID: tpoh_-DuFORup-7aDX-wiD9nGJ-goSq1
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685aa4c1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=pFyQfRViAAAA:8 a=_O3DOGVWAAAA:8 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=37rDS-QxAAAA:8 a=z9UPMGBGUIMZAgjR794A:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=oJz5jJLG1JtSoe7EL652:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwMyBTYWx0ZWRfX6E327hRc6aDk hKF/HFnXUNObf2UTDgM1VZzqktUiCJR5R6i+xbrKoaKj+++8rPalrEUY+v+LmjosOxe6TX3gkYA EYegRUD7j4nJu9/nkRifsCaGmWBmIPfzAi6jkCyyTxDqDYxn9uTbLQ8DirEjsjvOfRMQRdezSjh
 5aoZQ4oyUr6J4SNX/l9wta6Z3ejCjKiRfvn22Ukc4SjtVshDIJVxULk5fxdIy6ZWSNDeOf0cpjK lR4vvvOFppK+6Uh7lotCdIW61NWb8NLa30CqMZyJF0EvzFLNCMrHpsjhIsdmmR0cSbPM3eF51ep TUObotLYybaen9FK/VQEa4zEkC4NsR3QonM+iZrys/2J1Xv2G7F9xZ87LKpho/rZdAh+4Yf3Lhl
 z1HiVaQYxOSf+WzkbpUmgTMez7u0QpXbt/Y2/ERbb3RAGRr3AhOTO1yRpTACAxqK4cvI9J0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=495
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240103

On Fri, Jun 20, 2025 at 10:54:27AM +0530, Anshuman Khandual wrote:
> Memory hot remove unmaps and tears down various kernel page table regions
> as required. The ptdump code can race with concurrent modifications of the
> kernel page tables. When leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> But when intermediate levels of kernel page table are freed, the dump code
> will continue to use memory that has been freed and potentially reallocated
> for another purpose. In such cases, the ptdump code may dereference bogus
> addresses, leading to a number of potential problems.
> 
> To avoid the above mentioned race condition, platforms such as arm64, riscv
> and s390 take memory hotplug lock, while dumping kernel page table via the
> sysfs interface /sys/kernel/debug/kernel_page_tables.
> 
> Similar race condition exists while checking for pages that might have been
> marked W+X via /sys/kernel/debug/kernel_page_tables/check_wx_pages which in
> turn calls ptdump_check_wx(). Instead of solving this race condition again,
> let's just move the memory hotplug lock inside generic ptdump_check_wx()
> which will benefit both the scenarios.
> 
> Drop get_online_mems() and put_online_mems() combination from all existing
> platform ptdump code paths.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.16-rc2 and has been tested on arm64. Besides it
> builds on riscv, s390, x86 and powerpc as well. But should the following
> fixes tag from V1 also needs to be around as well ?
> 
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> 
> Changes in V2:
> 
> - Moved [get|put]_online_mems() inside generic ptdump_walk_pgd()
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20250609041214.285664-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/mm/ptdump_debugfs.c | 3 ---
>  arch/riscv/mm/ptdump.c         | 3 ---
>  arch/s390/mm/dump_pagetables.c | 2 --
>  mm/ptdump.c                    | 2 ++
>  4 files changed, 2 insertions(+), 8 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
