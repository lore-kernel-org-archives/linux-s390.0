Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0F1E5B6D
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486958; cv=none; b=ttQvmRbpBgLITGAEeFM7A9SOYuGeQCM3AYwgbsb7W/3SqqvV5jlGYdeFaobVXozQMTXzoIg4KrerGhSea9VROr680uyZibVy3JouVx6n6o826ebimRV3ger00XpoyY6f/rBkVxznOOOp2IOmEXwOXlOv0Hq1PKTmj+DpD6chVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486958; c=relaxed/simple;
	bh=xJZGE3pT+WmG87/ZFjfsdRS0eYCxW6nwAj4WAH+PkuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2vKPE5G/rIn+x6r1632UVf3fhpbQ+0sZHxEdj3ij3FGxQ3d9ONWV7K50b+FX2rubIuFYx8FTUa4JeDvjebJunHQ47l6B6uIsum1BOwkel8unopUK95EphKV5M6CR7EM6vuInRVrzQiVeXWoc0WG2sW+S1Q70xaZHDO7sMu7+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f5OUCpTI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f5OUCpTI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K9IMpu030278;
	Thu, 20 Mar 2025 16:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N2qdi4
	TWavW6wqY0urro/7XBY0d9gind+SHXMjVOdc8=; b=f5OUCpTI0KaNdO4Vg2qVnG
	CFb9KQP6w/sHFF/Mf+caRNcQVLHUKuZpv0ZKyMNJKcVQ7uxr5DXg4uCYZEbZYjO3
	2lMVkOJCFSkknRC0MObCzZNC46Z/wRlYlEWOeC5Y2rucH8vWWb0gpoaGkEr6Q11V
	38PcxuQFmcVOYTLhyRNyfz1iv19A6tu4DeL/RNbBy24eGXaKypvwNWA+pRjjn/Q9
	mcMAZgKhIPGOt0HDEI5LaMIFM654+9xBI1YGtEu0jjrTI5d4KNBHt26jwr9fu0Pw
	Kl4sGkGzeUFjgtRLYy/Q/NvYvETYffAZNgANvV7K9VfHLzptT9eCvqCOSux8aObQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qd65t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:09:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE3kMH031987;
	Thu, 20 Mar 2025 16:09:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvts3af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:09:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KG98Nk43123180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:09:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F8E22004D;
	Thu, 20 Mar 2025 16:09:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E04472004B;
	Thu, 20 Mar 2025 16:09:07 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 16:09:07 +0000 (GMT)
Message-ID: <2de0a41b-cb91-4418-8972-7f8f9c53da3c@linux.ibm.com>
Date: Thu, 20 Mar 2025 17:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] s390/zcrypt: Add small mempool for ep11 card
 info list entries
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-17-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-17-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qsWc-gV5q-NcfLERPTqDGJixB4qxtqFI
X-Proofpoint-ORIG-GUID: qsWc-gV5q-NcfLERPTqDGJixB4qxtqFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200100

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Add a small memory pool for (pre-)allocating ep11 card info list
> entries. These entries are rather small and the pool is a simple
> way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the change below,
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_ep11misc.c | 48 ++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index af59d66bff33..a9a6fdc32464 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -64,6 +64,10 @@ struct card_list_entry {
>  static LIST_HEAD(card_list);
>  static DEFINE_SPINLOCK(card_list_lock);
>  
> +/* memory pool for card_list_entry entries */
> +#define INFO_ENTRY_MEMPOOL_MIN_ITEMS 4
> +static mempool_t *info_mempool;
> +

The minimal elements in all smaller mempools should also be configurable via a module parameter, if this is required to process a larger number of NOMEMALLOC requests in parallel. There should be one parameter per module, which configures the minimal number of all mempools of this module. I also would prefer the same parameter name across all modules (e.g. "mempool_threshold"). There is no need to state the card type in the module parameter again.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

