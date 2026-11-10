Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331105;
	b=EgLBTikJ7+7pd5xNtDS9ETMuPlVtEcMTJw1yKzaF+2U6CJqxQsJNeuBiQ1JOTNwj21/k
	 8RByFgJYCRwfUP1TUrJ3lZnp4DOT2top4e/IhKNBEPtgv0Myiovf+dOIHJMMElVYIPfqf
	 OY+/3MjRPpUye+KBWwCehPJbItGlWmgou8Cr3Xoj5bYfnioJDQ4VPDIskJp+lKULDR8Qm
	 1VtyhEv7aXR6sbx0/0wB2IGawV3e86yU1x2A0KXqPzKRP8HYjOom8eFp2w8Jwc/1wvDSC
	 g86b8PUuN+0SdN5OUqW1Y6aNN8UkfxkFVm8nhCL7L5KDDHnT3iFQnQ6jHhvw90+REqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331105;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=34QYw2n+GlRTBEJeFEQ+DjmyCUzXKovo4AvPkqRFd88=;
	b=usS5PLMR6m8/KNhMmBcbCUKBxFPz2sDhy1d/YRYooePk3BfZqIpHK4svDtwCz7Hmu+6r
	 HUUGgM/n0YdNt5HyYbvneenAhJWXuVtApsg78EJzF3liB0MGC4lkdien/tsXumzIDjyI7
	 4Jc2RU0vdSq5puMnL019rpfoAxzL/a3SOTL9kQ0dVm8cpHThBuE9cWFZLj3llT/oop9sH
	 3IkCh6JAtDWWr4Cv5fDva8LHNULCIC6XzE584ie2MB1cjnPP1TMjmd3KO1N+bXIxVKlsJ
	 AgUNvgxHyIOan2onYSZ/PmYEYtCIShRZNKNMI7oTfZ422N9GZyGBp1NUA20crcT/0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NfCGhUWd;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7550606A33B;
	Tue, 10 Nov 2026 17:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7550606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NfCGhUWd
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAFEKvv2596191;
	Tue, 10 Nov 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=34QYw2
	n+GlRTBEJeFEQ+DjmyCUzXKovo4AvPkqRFd88=; b=NfCGhUWdZTwtX3fY6/fnNq
	2EDJZIEkB592SOtuDgQsQl3pbC5oa7r5WQlV/k09jqN7dkem6I/QsV/UxbaILOHD
	ZyVemLBMb1LWi/Pa3fikdMQsQAKnYhgB9sEra83YWE9mt+ex17r+n2ndB1MexmfP
	RP98zI/7kDaRYLycYE90slZLQOaVyFUkLVGVWHM550DCQjMq1heDwgOKY9oP5hqy
	OLnHwrG7KwWASAgwOWRudyjRU+pUsuJEOwiUsM7Pqh2qTsycBieAqFYFG4zYApEb
	iq1EBEUpr6m3fHhfIZ6cngKk6w9+uZCBSTsimdDeSCPro9PT4DU3BDwvPIUFgtzQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkp8th-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 17:17:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAF4uCM1880658;
	Tue, 10 Nov 2026 17:17:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv332126v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 17:17:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AAHHCR933554746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 17:17:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 606B320043;
	Tue, 10 Nov 2026 17:17:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789A420040;
	Tue, 10 Nov 2026 17:17:10 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.27.248])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 10 Nov 2026 17:17:10 +0000 (GMT)
Date: Tue, 10 Nov 2026 18:17:08 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
        chrisl@kernel.org, kasong@tencent.com, ljs@kernel.org, ziy@nvidia.com,
        linux-mm@kvack.org, chenhuacai@kernel.org,
        ying.huang@linux.alibaba.com, Baoquan He <baoquan.he@linux.dev>,
        willy@infradead.org, youngjun.park@lge.com, hannes@cmpxchg.org,
        riel@surriel.com, shakeel.butt@linux.dev, alex@ghiti.fr,
        kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, Nico Pache
 <nico.pache@linux.dev>,
        "Liam R. Howlett" <liam@infradead.org>, ryan.roberts@arm.com,
        Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev,
        linux-kernel@vger.kernel.org, nphamcs@gmail.com,
        shikemeng@huaweicloud.com, yosry@kernel.org, qi.zheng@linux.dev,
        luizcap@redhat.com, kernel-team@meta.com,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v9 06/32] s390: mm: add PMD swap-exclusive helpers
Message-ID: <20261110181708.1713b836@thinkpad-T15>
In-Reply-To: <20261105183940.2236717-7-usama.arif@linux.dev>
References: <20261105183940.2236717-1-usama.arif@linux.dev>
	<20261105183940.2236717-7-usama.arif@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af3519d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=4g41d8trx35e7M10UtoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2OCBTYWx0ZWRfX1nyYYnc9Zf8D
 du45S4a7FrRkSUAtDI5KOSQkCeSLN7Dq5lGlGHiyOYcNoRKzMZ12WLAmCqRKYJytxdHGdBK+5/s
 q5W3D8T5Sjy5ZtmsKeK4DHmj0LGOB/LPQRiBmH65Kkw3VTPtyb8rfTnRoZ4wd5x1jwDsVZVD5tN
 IWulXnrZ6qf+EifdiDDzvCfZg0OvUCV8DDxgEAltllo2oibYbsD9AdBdvFWfcQA2cCTLVCljNi6
 PpfApjXSnds1TWNTsxtXmSeBNJnxM82ctqFLudVfIanF/G09qFPdhWwmjrrqWGOO1GgI5KTDhUM
 +KZPFwpBXiH+JEwNNrV0cuVmG8sGX28PJj6Ynpw+BnsStkJDu0MFVa3jfz3ynJERH2nYHOyIdiD
 AHcndrIogjpdztYsOlhCJ7jLdjgLg4uNtb3kBlOnQRcyKgKG6HMAvsGqV8ixdV0H6K65K0cxLAD
 ZzqRV4ri5mzlZQdZzEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2OCBTYWx0ZWRfX+QdIRFNLmalI
 +GtJJhShocEC12dtfgMuBqXcn6yA0+CEeWr9W0mhis45wuudu3V1VWLKMaD04NMEvcJ4rmyedw5
 hENC38dcFaU0mwtbLghTYC/IYDQKu2c=
X-Proofpoint-ORIG-GUID: chnieGMiAe7hH-KPCsz8GCzo2Y3VSnMa
X-Proofpoint-GUID: Q4vxBTk2HZYJiPc3lOJwR1sDo2ByQqUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100068

On Thu,  5 Nov 2026 10:38:50 -0800
Usama Arif <usama.arif@linux.dev> wrote:

> Prepare for keeping a PMD-mapped anonymous THP mapped by a PMD across the
> swap round-trip, which makes PG_anon_exclusive have to survive in a swap
> PMD and not just in a swap PTE.
> 
> s390 is the one architecture where a swap PMD is not a swap PTE in
> disguise: it is an RSTE with its own layout, converted to a fake PTE swap
> entry for the common code. Give it its own exclusive bit rather than
> borrowing the PTE-format macro, and document it in the RSTE swap layout,
> where bit 52 was listed as unused.
> 
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  arch/s390/include/asm/pgtable.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2d5c2ab06de98..2c6b5205ee3bc 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -333,6 +333,7 @@ void setup_protection_map(void);
>  /* Common bits in region and segment table entries, for swap entries */
>  #define _RST_ENTRY_COMM		0x0010	/* Common-Region/Segment, marks swap entry */
>  #define _RST_ENTRY_INVALID	0x0020	/* invalid region/segment table entry */
> +#define _RST_ENTRY_SWP_EXCLUSIVE 0x0800	/* SW exclusive swap bit, see mk_swap_rste() */
>  
>  #define _CRST_ENTRIES	2048	/* number of region/segment table entries */
>  #define _PAGE_ENTRIES	256	/* number of page table entries	*/
> @@ -893,6 +894,21 @@ static inline pmd_t pmd_clear_soft_dirty(pmd_t pmd)
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
> +static inline bool pmd_swp_exclusive(pmd_t pmd)
> +{
> +	return pmd_val(pmd) & _RST_ENTRY_SWP_EXCLUSIVE;
> +}
> +
> +static inline pmd_t pmd_swp_mkexclusive(pmd_t pmd)
> +{
> +	return set_pmd_bit(pmd, __pgprot(_RST_ENTRY_SWP_EXCLUSIVE));
> +}
> +
> +static inline pmd_t pmd_swp_clear_exclusive(pmd_t pmd)
> +{
> +	return clear_pmd_bit(pmd, __pgprot(_RST_ENTRY_SWP_EXCLUSIVE));
> +}
> +
>  #define pmd_swp_soft_dirty(pmd)		pmd_soft_dirty(pmd)
>  #define pmd_swp_mksoft_dirty(pmd)	pmd_mksoft_dirty(pmd)
>  #define pmd_swp_clear_soft_dirty(pmd)	pmd_clear_soft_dirty(pmd)
> @@ -1900,15 +1916,15 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
>   * Bits 59 and 63 are used to indicate the swap entry. Bit 58 marks the rste
>   * as invalid.
>   * A swap entry is indicated by bit pattern (rste & 0x011) == 0x010
> - * |			  offset			|Xtype |11TT|S0|
> + * |			  offset			|Etype |11TT|S0|
>   * |0000000000111111111122222222223333333333444444444455|555555|5566|66|
>   * |0123456789012345678901234567890123456789012345678901|234567|8901|23|
>   *
>   * Bits 0-51 store the offset.
> + * Bit 52 (E) is used to remember PG_anon_exclusive (_RST_ENTRY_SWP_EXCLUSIVE).
>   * Bits 53-57 store the type.
>   * Bit 62 (S) is used for softdirty tracking.
>   * Bits 60-61 (TT) indicate the table type: 0x01 for REGION3 and 0x00 for SEGMENT.
> - * Bit 52 (X) is unused.
>   */
>  
>  #define __SWP_OFFSET_MASK_RSTE	((1UL << 52) - 1)

Nice, you found the last free bit in s390 RST swap entry, and made good
use of it. Bit 52 would also be free in regular RST entries, but as far
as I remember from PTE SWP_EXCLUSIVE, this will only ever be checked or
set for swap entries, right? Otherwise we should also document and
reserve for regular RST entries, but it should be safe for now in any
case.

Also did some basic tests with your series on s390. Couldn't see an
increase in throughput yet, but my swap device was way too slow an a
bottleneck itself. Verified that thp_swpout_pmd counter was increased,
system runs stable, found no problems so far.

I think this series could give s390 some considerable benefit, besides
swap throughput, by saving the 256 IPTEs (PTE invalidations) for each
1MB THP that doesn't need to get split before unmap and swap out. This
could have a positive system-wide impact, not just for one guest.

Great job, thanks for the effort!

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
