Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD672DF150;
	Wed, 29 Oct 2025 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719789; cv=none; b=Nj4IMqMemJCNyBoW9kePkZ2J9bKUeWUcLDsNvKFkufBhV4bXELlpP3FwpHOz/gJiSmo/RwQlNp9O3zrrp4GNhMfw43GkIrFGMjty7p/aUO8Vl9bWjfGvuyo3iZU4xvsUf4BtxjJzaq1b7Gap4lXqXz4cr9cdAnT1aeGICCBoTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719789; c=relaxed/simple;
	bh=WNnAmhwlx40aNbjPNZczFIlXDgGStQn+ZMQ4hZlelHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGIBHNA05ANFPVCA02RqlI0ls21SE/gZEEuYpNAsN1EwUosEvpR6O7PoKGiI0lGuacRUFkAKJpgUJwu9xqxOl0F0xeq3g35JGzxm8NDwzTYz6CHcDcxAu34OdvJ5EzITn4t0XPEQqYd5jxRthjFEOdDVnkIx58yECoJcp9e6pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mm1NGnvw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mm1NGnvw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJmbUO009639;
	Wed, 29 Oct 2025 06:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=y+kv7cMQAg6KlRyaeg7zt8XhWeI/Fd
	/0GhDkdgTi094=; b=Mm1NGnvwhugMYlqLQnWOIMULw5ECPTaU8bc79c8l/2k5KA
	Vo7xOCmOgNJPUeB7zGvrPGjcmjGZTU1Fo8I3KBfq4W8rMyz1WWFuoIYYAEfjmGAN
	IHWzuTPje3MElIjiNYGM1Govdmqogt17j2/GChMB1whoRlN1o7qZXaGJ4BRZoU00
	23q+cPzwDPy6mpfmrZAIFdvsfo2R3Y71Hf15W/OGwDS3kyqeRxcqg2swIHPQ51Sj
	ZShsbOQvmjmlfe8qaL44uM750AHS1MEbV7aeG1uqG/OwRWaZuZnZ/A1TgPRG/qOS
	+mJunkeOA2V8GqG4Q+w78ANmUGENfI/tz+Pma0PA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34af9uxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 06:36:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5EHLC030747;
	Wed, 29 Oct 2025 06:36:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwj0xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 06:36:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T6a2oG24641842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 06:36:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C979320043;
	Wed, 29 Oct 2025 06:36:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029E520040;
	Wed, 29 Oct 2025 06:36:02 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.0.181])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Oct 2025 06:36:01 +0000 (GMT)
Date: Wed, 29 Oct 2025 07:36:00 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: hca@linux.ibm.com, borntraeger@linux.ibm.com, joao.m.martins@oracle.com,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, osalvador@suse.de,
        akpm@linux-foundation.org, david@redhat.com, aneesh.kumar@kernel.org
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
Message-ID: <41170067-dcb9-4aa1-a5fe-0cbee6af02df-agordeev@linux.ibm.com>
References: <20251028211533.47694-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028211533.47694-1-luizcap@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H1tkOJdO75dq6IDjjyfCWyVkNWCXkJp_
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=6901b5d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=QOFCb5y-8OGGi3Wmhr4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX/AZI6ijaduAs
 +5U6ZBXoqfyS4x93HHiv3PQg5nCh9jiZx//3QAerZYpMXH4xkFcOa/j1EGyKIsEs5Uwe7vZZ+t0
 A9ImGfIN8ktl9XlGoMKoKwg/Ce/lpo9BmNJq+YW98xnHDfPAE8QHV6whujMP85g7UUyi7ORhSUv
 LSmNLpC6DUxRRQkSq4nYt/Ei+5+UgCjS5ZOo1dfrXjcY4gcs+g3Koq+yN3FBQ6fvL4Dui2eReAs
 ZAH+OZ/MCGLx50MBDP34S3v6xRoPuQZvnnUsaq/qXV9DHOZVnD8M8PAugG+QXaM5d7qvSzc9nUO
 hP3ttyQPZWKIiRjZHbvAhEkwItiQVfeA+JmWg49sZ5DXO5tzn3Wc64/mCVY8JV8OvzbdAgZFwF8
 p6D7MrmjQEDytgxguEtgOtLcA8mApA==
X-Proofpoint-ORIG-GUID: H1tkOJdO75dq6IDjjyfCWyVkNWCXkJp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

On Tue, Oct 28, 2025 at 05:15:33PM -0400, Luiz Capitulino wrote:
> A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
> on s390. The crash and the proposed fix were worked on an s390 KVM guest
> running on an older hypervisor, as I don't have access to an LPAR. However,
> the same issue should occur on bare-metal.
> 
> Reproducer (it may take a few runs to trigger):
> 
>  # sysctl vm.hugetlb_optimize_vmemmap=1
>  # echo 1 > /proc/sys/vm/nr_hugepages
>  # echo 0 > /proc/sys/vm/nr_hugepages
> 
> Crash log:
> 
> [   52.340369] list_del corruption. prev->next should be 000000d382110008, but was 000000d7116d3880. (prev=000000d7116d3910)
> [   52.340420] ------------[ cut here ]------------
> [   52.340424] kernel BUG at lib/list_debug.c:62!
> [   52.340566] monitor event: 0040 ilc:2 [#1]SMP
> [   52.340573] Modules linked in: ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng des_s390 libdes sha3_512_s390 sha3_256_s390 virtio_net virtio_blk net_failover sha_common failover dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390
> [   52.340606] CPU: 1 UID: 0 PID: 1672 Comm: root-rep2 Kdump: loaded Not tainted 6.18.0-rc3 #1 NONE
> [   52.340610] Hardware name: IBM 3931 LA1 400 (KVM/Linux)
> [   52.340611] Krnl PSW : 0704c00180000000 0000015710cda7fe (__list_del_entry_valid_or_report+0xfe/0x128)
> [   52.340619]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [   52.340622] Krnl GPRS: c0000000ffffefff 0000000100000027 000000000000006d 0000000000000000
> [   52.340623]            000000d7116d35d8 000000d7116d35d0 0000000000000002 000000d7116d39b0
> [   52.340625]            000000d7116d3880 000000d7116d3910 000000d7116d3910 000000d382110008
> [   52.340626]            000003ffac1ccd08 000000d7116d39b0 0000015710cda7fa 000000d7116d37d0
> [   52.340632] Krnl Code: 0000015710cda7ee: c020003e496f	larl	%r2,00000157114a3acc
>            0000015710cda7f4: c0e5ffd5280e	brasl	%r14,000001571077f810
>           #0000015710cda7fa: af000000		mc	0,0
>           >0000015710cda7fe: b9040029		lgr	%r2,%r9
>            0000015710cda802: c0e5ffe5e193	brasl	%r14,0000015710996b28
>            0000015710cda808: e34090080004	lg	%r4,8(%r9)
>            0000015710cda80e: b9040059		lgr	%r5,%r9
>            0000015710cda812: b9040038		lgr	%r3,%r8
> [   52.340643] Call Trace:
> [   52.340645]  [<0000015710cda7fe>] __list_del_entry_valid_or_report+0xfe/0x128
> [   52.340649] ([<0000015710cda7fa>] __list_del_entry_valid_or_report+0xfa/0x128)
> [   52.340652]  [<0000015710a30b2e>] hugetlb_vmemmap_restore_folios+0x96/0x138
> [   52.340655]  [<0000015710a268ac>] update_and_free_pages_bulk+0x64/0x150
> [   52.340659]  [<0000015710a26f8a>] set_max_huge_pages+0x4ca/0x6f0
> [   52.340662]  [<0000015710a273ba>] hugetlb_sysctl_handler_common+0xea/0x120
> [   52.340665]  [<0000015710a27484>] hugetlb_sysctl_handler+0x44/0x50
> [   52.340667]  [<0000015710b53ffa>] proc_sys_call_handler+0x17a/0x280
> [   52.340672]  [<0000015710a90968>] vfs_write+0x2c8/0x3a0
> [   52.340676]  [<0000015710a90bd2>] ksys_write+0x72/0x100
> [   52.340679]  [<00000157111483a8>] __do_syscall+0x150/0x318
> [   52.340682]  [<0000015711153a5e>] system_call+0x6e/0x90
> [   52.340684] Last Breaking-Event-Address:
> [   52.340684]  [<000001571077f85c>] _printk+0x4c/0x58
> [   52.340690] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> This issue was introduced by commit f13b83fdd996 ("hugetlb: batch TLB
> flushes when freeing vmemmap"). Before that change, the HVO
> implementation called flush_tlb_kernel_range() each time a vmemmap
> PMD split and remapping was performed. The mentioned commit changed this
> to issue a few flush_tlb_all() calls after performing all remappings.
> 
> However, on s390, flush_tlb_kernel_range() expands to
> __tlb_flush_kernel() while flush_tlb_all() is not implemented. As a
> result, we went from flushing the TLB for every remapping to no flushing
> at all.
> 
> This commit fixes this by implementing flush_tlb_all() on s390 as an
> alias to __tlb_flush_global(). This should cause a flush on all TLB
> entries on all CPUs as expected by the flush_tlb_all() semantics.
> 
> Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  arch/s390/include/asm/tlbflush.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/tlbflush.h b/arch/s390/include/asm/tlbflush.h
> index 75491baa21974..0d53993534840 100644
> --- a/arch/s390/include/asm/tlbflush.h
> +++ b/arch/s390/include/asm/tlbflush.h
> @@ -103,9 +103,13 @@ static inline void __tlb_flush_mm_lazy(struct mm_struct * mm)
>   * flush_tlb_range functions need to do the flush.
>   */
>  #define flush_tlb()				do { } while (0)
> -#define flush_tlb_all()				do { } while (0)
>  #define flush_tlb_page(vma, addr)		do { } while (0)
>  
> +static inline void flush_tlb_all(void)
> +{
> +	__tlb_flush_global();
> +}
> +
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
>  	__tlb_flush_mm_lazy(mm);

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
