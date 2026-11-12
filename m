Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483561;
	b=e3CnrN8mYpixeme2dZp4Yjzydwlbi7i1SyJsaVUMJQcfgYtfqs3RYw8TlO9AEd0DuxFq
	 OBPXXDS8vZDZhSaOAjQ1Pz9cSmLfMkVLeV6v/j9U1UlgmLYM2TbdDZSabZoDpxquFBJ/w
	 7Ju1tMz4ul5CRakV7IPIg3p+H4l8BkpgstvHSz1DRUTzjUlS/PuuO2yCNFrJrDwM+2/ob
	 Guww4TI8aEYWjT++PvRSGipTVm5MEi8uR5Uh1BK3cnmYu0Ka/5cATGr6nY/sdBi9jk8Ar
	 VFpFQ+3Q/B0OPVAu/xHYvlOjb9SKnbsxw80vjKhI3bVS+nU9XQa+IJCK9+XmU+njocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483561;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=42zQysBLnTTqfwsqH+lywDD4NS+BQaoplRGt/Qda2T4=;
	b=CEHsib2p85uJumdN0nlC/EeSiGXRm/G4E45QyfwTbbyTozzPPt9zFD+HUwcGoQ9O2piL
	 wI3OOUA3CohmcjVK/DGnd9JULqg012qhv70nMmdn+axBBb3MRVJDXeNAZeK0IraNCLAcV
	 DYIMHHDIL2arRQLayUAm85nPpt2CAn4ro5pIK8OJac2ABc/rzoSIAq9IInf3rs+sEOSzN
	 egh/Ypgoeo3UZ8TLew53v4q7fC3fQXGY7HaCEdD2Em2/qV4C5xMNIi5209Rg8QciP5SMd
	 3Fn8EzGSNTWyju2RDcWx2Vdgm2S2BRAC12MDIRgZ5nFW8Si3kpB+R9s+nBT36nrSk6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1uNLRWQ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677EC606A327;
	Thu, 12 Nov 2026 11:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1uNLRWQ
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2icBu1215174;
	Thu, 12 Nov 2026 11:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=42zQys
	BLnTTqfwsqH+lywDD4NS+BQaoplRGt/Qda2T4=; b=s1uNLRWQTQcxNyUGv2BnrA
	4JOcDC+z1Vl2OSwMI2dejP6nBsV8jGFigkrbYHkUNqUGJP2AXEqHSJw0HR92e/WS
	dbOdRja0N/aZrtMZbOcXuQ+BZ+LurWfCtcNjkH074v+gohRlUffvqqxAsCtQjsyd
	0kzEE+qpUBSBnyf3PYQpziObPC11d5RjZFgAMQXIIWLpmLSIUdxNI5dIwBGDXfX+
	GWSHt0w66HEZFGM8w9uFCmOT7MTBaEuwjcpS2oxJbsZhesGN0jDrmOUnESD4OkE6
	ZXSdISf9ymyyx0sXz1z2tRXXqzJfKcylqCze4BcLCfjwpaoiiyIM+Isq2qdewvFQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntf8bb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:39:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8LvdK097884;
	Thu, 12 Nov 2026 11:39:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0w3bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:39:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBdDYA46596456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:39:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C0620043;
	Thu, 12 Nov 2026 11:39:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F04920040;
	Thu, 12 Nov 2026 11:39:11 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:39:11 +0000 (GMT)
Message-ID: <2c1357d5-efff-4d0f-9750-f38cbba85c81@de.ibm.com>
Date: Thu, 12 Nov 2026 12:39:10 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] KVM: s390: Move some skey functions to headers
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-3-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX00wpcB6QDRRF
 YLXHLXh3SJfYli0sWcvkPdnj+XSJB0bnB/JmBuC0we1Bb76Org2u/R3uSATycYnCo7X5EDRD4/b
 i9Dl/l3DWN2Si1oHhG01X9ksum2oCy0SifqlM9O/9bgp2ZJo08K4aHZ5j9Tb0qGAQ9f8puJkLkd
 FNkF73a8p8GW4DjR3K1fmm2VGWBOpJ+pdLV5JGJFsdJzK3i3SldPwclt+fB86CE7Z4AGQ42j7Yb
 ogg9ypAJUJVEdSXLJAgkiWbjWYNVx5NGQINKlkVTyOCKUFeoCQbNayIGgZpo3Yb17AfiAXl8SYU
 AHKX9a2OKkBzYEXQu/a5Au52XM44kOm1y4XY6fozLLYqZeRVKXpVUmKN8kPajnPnBeFlMWIUImi
 k95eTpoimMWH6yLAIMMJlnIt+MatKgQ+do33gvxIWDrU+NdIlOJynQgr6U3ZrEK/9qOokfCmAD8
 HxHI3NqsywdmwmCkVUg==
X-Proofpoint-ORIG-GUID: Q9p-TpSdpepPEOZAo7yYUggrj_rF2mMz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX7nUHbYadXAqL
 lyBvD6jrYgm1QovbqdAgmJm4+nd2jORBQ22tizywpT0glvgGVWjsuKZjXSCCb7oibnGT/xC3fh+
 UFOxTL1ZxccmBdeyVKuuygVt8E36x4U=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5a566 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=zK0GgRsxSZFP1HZI7jUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q9p-TpSdpepPEOZAo7yYUggrj_rF2mMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

Am 05.11.26 um 16:37 schrieb Claudio Imbrenda:
> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> ---
>   arch/s390/kvm/gmap/dat.c | 26 --------------------------
>   arch/s390/kvm/gmap/dat.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
> index ff80d02c9f56..b9507daaf327 100644
> --- a/arch/s390/kvm/gmap/dat.c
> +++ b/arch/s390/kvm/gmap/dat.c
> @@ -159,32 +159,6 @@ bool __must_check dat_crstep_xchg_atomic(union crste *crstep, union crste old, u
>   	return cspg_crste(crstep, old, new);
>   }
>   
> -static void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
> -{
> -	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
> -
> -	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
> -}
> -
> -static void dat_move_storage_key(union pte old, union pte new)
> -{
> -	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
> -}
> -
> -static union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
> -{
> -	union skey skey;
> -
> -	skey.skey = page_get_storage_key(pte_origin(pte));
> -
> -	pgste.acc = skey.acc;
> -	pgste.fp = skey.fp;
> -	pgste.gr |= skey.r;
> -	pgste.gc |= skey.c;
> -
> -	return pgste;
> -}
> -
>   union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, gfn_t gfn,
>   			    union asce asce, bool uses_skeys)
>   {
> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index e6215c0b571f..9cdd1f122d7a 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -1008,4 +1008,30 @@ static inline bool crste_is_ucas(union crste crste)
>   	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
>   }
>   
> +static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
> +{
> +	union skey nkey = { .acc = pgste.acc, .fp = pgste.fp };
> +
> +	page_set_storage_key(pte_origin(pte), nkey.skey, 0);
> +}
> +
> +static inline void dat_move_storage_key(union pte old, union pte new)
> +{
> +	page_set_storage_key(pte_origin(new), page_get_storage_key(pte_origin(old)), 1);
> +}
> +
> +static inline union pgste dat_save_storage_key_into_pgste(union pte pte, union pgste pgste)
> +{
> +	union skey skey;
> +
> +	skey.skey = page_get_storage_key(pte_origin(pte));
> +
> +	pgste.acc = skey.acc;
> +	pgste.fp = skey.fp;
> +	pgste.gr |= skey.r;
> +	pgste.gc |= skey.c;
> +
> +	return pgste;
> +}
> +
>   #endif /* ARCH_KVM_GMAP_DAT_H */

