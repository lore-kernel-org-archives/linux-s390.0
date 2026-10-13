Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1C64078C0;
	Tue, 13 Oct 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902649; cv=none; b=Rt9bh9wdK5p7WNx7bLRdmKne0FCrC1pN0xBDDPiQw9p1LiOkY8ficeD4ezHGQ8zrryzuNk0X8Pc21PF/1ZE63yuk5nHDXnBKDe+ZLX/IFCAS8XekJtyBIVrlx3jvQsEUo0R36odrGnfw4v5Bg417MYqO843nLwfgWVAheYgV/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902649; c=relaxed/simple;
	bh=Amh8o+ETNNEm6WYXIFVGpviCVtj9ZnAIuTaXyZIXBmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFT0qBQ9cTyoAvjob1RkTG4yTLywe5W4UYy6MmLjJj5PsFn/9LVYSmW/AUIHm/nbyecXiJa52jsXpfj6mvcHeli5N+qO9eodwN0mWaOzRVQZ8pv835YDxXbydYd+hOigrU5efqNqwXLUAiiqpmFlCN6DUE5en5lVSh5CCYmRnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cI9n1+4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cI9n1+4l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDdDmD2016202;
	Tue, 13 Oct 2026 14:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NJ50x9XZV4rMl1mnyhjlA62Bq/86Qe
	yubCAiT/O6+5w=; b=cI9n1+4lUgLsYJq5ZtyQNZ3D48gLMo0BpD3uKUqDXrCtl9
	e2HoqYb3D1ARcFRCZmKssxKp8duTig/pmgJd8g2s4d9Ph6ckFfLGZ0o+rn1yAciy
	AAXWhh1RFA5YAEIrebyFGiQ6m7C5BjuDq1F4rlka9dgga6dNYagPKoD/znTcIiuw
	LE3lcF0k+36nxUmTNqN3Z2DY5N7RnQ5Ip+eAWKzKD9s95qZ+ZAkXIc5dzvl5i5kd
	/zJIAdUIV6f0NdcL2i8HGCnuCZdeHlX9k6p5UmK0O7JldBc6BqmD1nj72LBP6+li
	gHJlDo9Ibjd2922ozVEAmNUBXASYsuqIlHE/ykKw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugerw8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:43:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCU3xV2709266;
	Tue, 13 Oct 2026 14:43:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h2apj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:43:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DEhsS245089106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 14:43:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB4F2004B;
	Tue, 13 Oct 2026 14:43:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05D3620040;
	Tue, 13 Oct 2026 14:43:54 +0000 (GMT)
Received: from osiris (unknown [9.111.34.214])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 14:43:53 +0000 (GMT)
Date: Tue, 13 Oct 2026 16:43:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v8 10/15] s390/mm: Cleanup pXXp_flush_lazy() routines
Message-ID: <20261013144352.128264A4e-hca@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <964adeedfd20d4dbcc9a6341f57ec7aaac6c6adc.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <964adeedfd20d4dbcc9a6341f57ec7aaac6c6adc.1791365932.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace43af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=mmsD3Eh6YA-KHFnkoBgA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: oWaGvRRXTzXYQwvMlJ1EMK_XRD2gIlgd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1OCBTYWx0ZWRfX+nEyqHNkh3qz
 DhaVa3dj0ROQ6LabrhDVO5Vj99k2pMmy5SA3qr64Df3VgF/CCOKdIGjLZwGPbaDTvUPMjjhp6No
 lBqwFVJxB5w8x/M6AJ6J1GGay0MlXLCTEgJARo+vHtsPGRDbs3wYXDuSaYOM/EoeCBYkEyDsrso
 WnJQzSDnfOltaZNf7fz6jm+wydCfySmPKIYnzS2zmqz2w7A3MjOlfOD65HxBuKCA7VkVoObHTXu
 qS7vtD6cDHTNUZ+DFz5rDqtwGxjl1gzFsRM8ITuMHA5YJXGV+5u2edH9Ds5Y3M+TCCPcJb5VsRd
 630mvLRM3Ue9GPD7ddXjoP1Hf5ltEdNYXLML/dZYckl8PiuJ63zUr2PUDQa5ynTz4jRGH9wmuHZ
 S68i3VBLZudoL3r0vs/LMiCuy2m0RAqYuNU6sIe049QCX02iibJFrKtpK/KFN0MqzwZ7/V7F/Le
 geE9ThbgH9xRgeLSkGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1OCBTYWx0ZWRfX+ebmIRF7WKZt
 Bp7b2U5kHDjmI8Pos8BLqth/8SogBIzeXk2haGwf+x0eQI20V8EaD77MijWUfnk4sYCKULYsbEG
 7qzRI0T+esyLIHZKnYyB5Y+Ig8zRbv0=
X-Proofpoint-ORIG-GUID: CQ313svkBdd2nH7F9syrZVINxu4jyakU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130058

On Wed, Oct 07, 2026 at 01:41:53PM +0200, Alexander Gordeev wrote:
> Avoid unnecessary pgtable entry read in ptep_flush_lazy() and
> pmdp_flush_lazy() routines. Use the already obtained value of
> a pgtable entry instead of dereferencing it again.
> 
> It might appear that the optimized out second dereferencing happens
> under mm_context_t::flush_count lock and therefore a race condition
> is possible. However, both routines write invalid entry bits to the
> pgtable entries and therefore no reader is allowed to interpret the
> rest of the value afterwards.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
