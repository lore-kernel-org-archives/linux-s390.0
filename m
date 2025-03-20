Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26A18BBA8
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486725; cv=none; b=Odary/5UnxAbMnZnSiDIjYSr22dI7sh+XnLGxFgje7moIQkX4xTKU/p78MLNK6Z/nn4iLXeXeZUu144rK7sZrzDu0GHa/3UH14FMtoD2DlMDZmzeH6oX4UWbgFXyxHFXzIp4alow0oluORHiWc2HfWVGIuVOAVCVUH8/FfjXhUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486725; c=relaxed/simple;
	bh=mrVKFq8D4MXejLOncRpqJ5Iyc1HYRXn1R6lyOGEVCUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzSjuvPBAIf5ZHHStWEEtfZz626Pr0evRZlcDZ1VnIjdtky5kIPJN9R/IRkWmup2HR81WDXibVqzJbVSUNniy1nbOBfWXSFxkdn1R/yQ4m/CFLZQrMrHv4j6WZEqv87PbArSVkmjzpyqNKlVdMOwVsfRTr/WwPYtfa7iJXHof5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ps93e799; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ps93e799"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE3AwC025263;
	Thu, 20 Mar 2025 16:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KVtkrW
	zPW1LkiOXBK75umvkzN8sbmbH3SXZDyvi1ai4=; b=ps93e79988HyZkMtoz3qRY
	wDqOd0IujjGVF0suT68dofghGBu1abZZcrcGWzY+9mbd7FZSlm9HPLy+6H1lY1oT
	h6qQ7E1o8CJaLwLDD9VRFTAK0azhirShs/leskrajGwnNS0VRmJ1KwHrLPZL/CUT
	mpkyrNl/3TeOq2FKJpDGPjtI8YwZWF0r7/68r6czAxQGe6LAkaeLRVdSGMy30rTs
	JxSlRFnNSf01vEBVskCNvQQfOFBx1rIQzD36/vpG2Wg3UrsrBmF4ihWgBN8kbwf4
	Mcvnj/X9tR3eQXl15rEQfBazi6KNm6cYRycF4/fQKB/uOUpiyHiX/DoQwPfPhYQA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gmep8q2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:05:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCxsXp020369;
	Thu, 20 Mar 2025 16:05:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncmgrhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 16:05:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KG5DVS34406816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 16:05:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D227D20043;
	Thu, 20 Mar 2025 16:05:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55D1B20063;
	Thu, 20 Mar 2025 16:05:13 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 16:05:13 +0000 (GMT)
Message-ID: <6a730037-5d3f-489e-b886-ad7e18067a96@linux.ibm.com>
Date: Thu, 20 Mar 2025 17:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] s390/zcrypt: Add small mempool for cca info list
 entries
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-14-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aqngQbRoa5J8mFObGxYdl2ZQ-DvkfTzZ
X-Proofpoint-ORIG-GUID: aqngQbRoa5J8mFObGxYdl2ZQ-DvkfTzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200097

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Add a small memory pool for (pre-)allocating cca info list
> entries. These entries are rather small and the pool is a simple
> way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sorry, I forgot one aspect, see comment below.

> ---
>  drivers/s390/crypto/zcrypt_ccamisc.c | 67 ++++++++++++++++++++--------
>  drivers/s390/crypto/zcrypt_ccamisc.h |  3 +-
>  drivers/s390/crypto/zcrypt_cex4.c    |  4 +-
>  3 files changed, 53 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index ff7ba2622484..e4ec922aae0d 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> @@ -41,6 +41,10 @@ struct cca_info_list_entry {
>  static LIST_HEAD(cca_info_list);
>  static DEFINE_SPINLOCK(cca_info_list_lock);
>  
> +/* memory pool for cca_info_list entries */
> +#define INFO_ENTRY_MEMPOOL_MIN_ITEMS 8
> +static mempool_t *info_mempool;
> +

The minimal elements in all smaller mempools should also be configurable via a module parameter, if this is required to process a larger number of NOMEMALLOC requests in parallel. There should be one parameter per module, which configures the minimal number of all mempools of this module. I also would prefer the same parameter name across all modules (e.g. "mempool_threshold").

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

