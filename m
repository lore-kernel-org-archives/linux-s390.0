Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7112628C
	for <linux-s390@vger.kernel.org>; Thu, 20 Mar 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481295; cv=none; b=FDGQT7sCh2PNXQxfz5gkXYzHX1PZy+JzucbHwhTUFlZ+FyMxnU8VxR1KsP90Gw0uj6v6MYlx0ta898vJ1tOAbV3ubA6hCqMLmhmg2vPJsOCnvrC2DPqmls3iJsPPGLgOTuXwaD5Lj7WUHL/ASqu0udw8P4moqaP2IrguZgMyvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481295; c=relaxed/simple;
	bh=MjMY7NVk4j1CiyY82A6jdPh6rjexKjldye/USB1Pjto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnEaxDSqymRUdYm2u18vqDksw/IC7x6p1pdQmTdOfc3dG9Tgq2xkFT/rCmQgHg4Hoj9Ba5Ai3twhCo4LsCI6jJHMx6zinP29oCefTKgmyGmELyxtWQL8SrrTSNvohjEcJszX57DPzsFotJTZq8Ddczk4cdXsmhW35CjwDtXKNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UgW804c+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UgW804c+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE6nZt020677;
	Thu, 20 Mar 2025 14:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IAiqq6
	Rc9qwX9CIaGpBfsg4t7stfffl38deBgI6hRsU=; b=UgW804c+7WLT248BQ7luR2
	CbI4zUk1jDqLEofSDR8DfDU0lFDzc6YDZaLYboVip4dxQrpa/1BKUhWPy/DiRpyJ
	+ZJ8z16RRS2PVeW0d5dSGg7345H0XQp9LZinQi+PAWUhdyfWhDha8fkMSN5rfUhj
	wTcvOPR8J/MDR/cztWxD8x5bH5Y5eVc/TFpNdVr0H7PLQWeyrqnxFov6tLvCsdzK
	Euk2FKfv4PN7XNYlWkZKumLpeqtw36zNjqFnPhna0B/lRYF9qhZK6AfMVWKX+ugo
	fve3SJdqWkCfzg5nyYWF1wh+3my5Gnl3gOsVauAte0wuarUgWS6euhSQrOwQhhJA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g23vdqs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:34:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KBG7Ln012350;
	Thu, 20 Mar 2025 14:34:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp8es0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:34:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KEYjwX53215650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:34:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBCC52004B;
	Thu, 20 Mar 2025 14:34:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 751BF20040;
	Thu, 20 Mar 2025 14:34:45 +0000 (GMT)
Received: from [9.179.0.254] (unknown [9.179.0.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 14:34:45 +0000 (GMT)
Message-ID: <8fc15902-2156-41a7-9baf-7daef6315cd6@linux.ibm.com>
Date: Thu, 20 Mar 2025 15:34:44 +0100
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
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250304172116.85374-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M2NlPkZv_3nfV0ieftR6UvLcsUDi_nkE
X-Proofpoint-GUID: M2NlPkZv_3nfV0ieftR6UvLcsUDi_nkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200090

On 04/03/2025 18:21, Harald Freudenberger wrote:
> Add a small memory pool for (pre-)allocating cca info list
> entries. These entries are rather small and the pool is a simple
> way to support the xflag ZCRYPT_XFLAG_NOMEMALLOC to avoid mallocs.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

With the requested change,
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

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
[...]
> @@ -1828,6 +1834,7 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
>  	u16 card, dom;
>  	struct cca_info ci;
>  	int i, rc, oi = -1;
> +	u32 xflg = 0; /* xflags */

I'm confused. Why not just calling it xflags? Anyhow, as mentioned earlier: findcard() has no consumers, so please remove it completely.

>  
>  	/* mkvp must not be zero, minhwtype needs to be >= 0 */
>  	if (mkvp == 0 || minhwtype < 0)
> @@ -1859,8 +1866,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
>  				if (!verify)
>  					break;
>  				/* verify: refresh card info */
> -				if (fetch_cca_info(card, dom, &ci) == 0) {
> -					cca_info_cache_update(card, dom, &ci);
> +				if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
> +					cca_info_cache_update(card, dom, &ci, xflg);
>  					if (ci.hwtype >= minhwtype &&
>  					    ci.cur_aes_mk_state == '2' &&
>  					    ci.cur_aes_mkvp == mkvp)
> @@ -1882,8 +1889,8 @@ static int findcard(u64 mkvp, u16 *pcardnr, u16 *pdomain,
>  			card = AP_QID_CARD(device_status[i].qid);
>  			dom = AP_QID_QUEUE(device_status[i].qid);
>  			/* fresh fetch mkvp from adapter */
> -			if (fetch_cca_info(card, dom, &ci) == 0) {
> -				cca_info_cache_update(card, dom, &ci);
> +			if (fetch_cca_info(card, dom, &ci, xflg) == 0) {
> +				cca_info_cache_update(card, dom, &ci, xflg);
>  				if (ci.hwtype >= minhwtype &&
>  				    ci.cur_aes_mk_state == '2' &&
>  				    ci.cur_aes_mkvp == mkvp)
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

