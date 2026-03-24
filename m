Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0B3F7876;
	Tue, 24 Mar 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365655; cv=none; b=evCfWLrfX0iqQW6sX0vZFAC2pB4ZV2tfRbQm0Jd7BKgaeJACyBgVMah9YO8C7VBJFgjOWFCTfXk4YhabtiAK2PHRAF4GTcm+fqjr8YXfGAvKICTX+AJV14/5AOVe/f3HT5Fx/wtAuoIs7EBT+sXHsFRW32daJsDjRy+xJMkbbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365655; c=relaxed/simple;
	bh=ZhkOgLkUusfu1ZskkPpy2V4LihHDdxWCkIvH0+VDkzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUsjbJYvi1omHiBMP7xP9ybxy7xvV2nJivKijN3ygzJRhF8/krYwGLNc2wF2mbMh5pX0uZmvIRjjV629hHFn8mDx6fMaDjQfUA3wC4C0LwOLhTvivZc+GxuYatPsfRNHmpFgOlO2ORCPmiXLsuUPtfIhbLTmf0Z23kjqsWTy4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UkCXnowf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UkCXnowf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O8l17f538370;
	Tue, 24 Mar 2026 15:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/RNRv7
	mT2RzDLoY8lMCUuVC40SvOz7526j0uyw5/mbQ=; b=UkCXnowfHLc3wIiNdprmzQ
	L+YZwAVfdho0KWLuoVdmEOOeAlcGTaP+3OEZhplp90qKa4xWRpIlXo3NsYWya8wj
	d8ELg/1DDDEYYNF7hXAd6RcrgzCWz1LIS6bXcqG4stvdz2PT4zu/4+r2mDF0hnie
	x8y6PHyNF5e54FUix/X4jc+i44hFJ+YF2z2/YZdMlii5dyGeIt6ZZ5PT0bh5tYbH
	phc8JlcdvSUk0TWvLdSQP2AkukT0yN021ynpC0pYo2WQ9XY0KL2vkc2f+WYdSzvJ
	kTsiYpBFmSjrIFs9OhD3v81qiq9rxIqJZIBcrRCSUMyIlvSmGDPYbDz0yp2AnmNA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxv6r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:20:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OD5fJV012185;
	Tue, 24 Mar 2026 15:20:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk29cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:20:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFKkNV45941082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:20:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6CE02004E;
	Tue, 24 Mar 2026 15:20:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649932004D;
	Tue, 24 Mar 2026 15:20:46 +0000 (GMT)
Received: from [9.111.77.246] (unknown [9.111.77.246])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:20:46 +0000 (GMT)
Message-ID: <b9d39789-be93-4133-bad9-09db4f90c169@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] KVM: s390: vsie: Fix guest page tables protection
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        gra@linux.ibm.com, schlameuss@linux.ibm.com, hca@linux.ibm.com,
        david@kernel.org
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-8-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260320161542.202913-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2abd3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=OUtIGFiODa46FlTH9UIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX/ouiAQENjTlO
 MALMG5Rrar5T3SIIMp928JfDCn50IezfJHLZQuO8h3k+i/OFWMSsrA4Rnt75O/7kV4vTs/9dvNq
 ttvkKxaVHWAJHO7oQRI/tI7SLGAlzzAmUSHqwopxdxwe6rs4bxGOrf3izJ/qsfEnyE/vVfd4Wbf
 sUe7QqFN8l79nHLssiRQN80OhMuzhK8UGsnB9Ce1+CEjaORrQH36qgP1BEVVtZKgmwDCdR45kn/
 +XiUNJLiEcWUwKY2e2bFMSk3GIZYpOLkPlZS6bOdgB+UGqOoUIV3ZIzXq5EBa9O9UGDHwfjKjQM
 54ZHgfDSBkiPiGmSqa810iFSXUB75oH3GPoe83ec2MTLoUs0oz2Ot7c/FWtwuj1A+wrwl5LC9zS
 /wiBXMv+0bEipVCZr4wmAt4HfvFGKTkb1tWH01+meMeddXVV59pnbJwcFs+oTtp3qFtOfD0BuIP
 /6YYTf6zD9EY5Hb1QUw==
X-Proofpoint-GUID: 0nbGgXVek369JXZ7VnEhvtZ6h4dNL1P7
X-Proofpoint-ORIG-GUID: 0nbGgXVek369JXZ7VnEhvtZ6h4dNL1P7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

On 3/20/26 17:15, Claudio Imbrenda wrote:
> When shadowing, the guest page tables are write-protected, in order to
> trap changes and properly unshadow the shadow mapping for the nested
> guest. Already shadowed levels are skipped, so that only the needed
> levels are write protected.
> 
> Currently the levels that get write protected are exactly one level too
> deep: the last level (nested guest memory) gets protected in the wrong
> way, and will be protected again correctly a few lines afterwards; most
> importantly, the highest non-shadowed level does *not* get write
> protected.
> 
> Moreover, if the nested guest is running in a real address space, there
> are no DAT tables to shadow.
> 
> Write protect the correct levels, so that all the levels that need to
> be protected are protected, and avoid double protecting the last level;
> skip attempting to shadow the DAT tables when the nested guest is
> running in a real address space.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> ---
>   arch/s390/kvm/gaccess.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 1054f9bd107f..17563f889c6b 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1517,13 +1517,15 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
>   	 * Skip levels that are already protected. For each level, protect
>   	 * only the page containing the entry, not the whole table.
>   	 */
> -	for (i = gl ; i >= w->level; i--) {
> -		rc = gmap_protect_rmap(mc, sg, entries[i - 1].gfn, gpa_to_gfn(saddr),
> -				       entries[i - 1].pfn, i, entries[i - 1].writable);

Yeah, tt for page tables is -1 and adding -1 ends up being LEVEL_MEM...

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> -		if (rc)
> -			return rc;
> -		if (!sg->parent)
> -			return -EAGAIN;
> +	if (w->level > LEVEL_MEM) {
> +		for (i = gl ; i >= w->level; i--) {

You could have fixed the rogue white space after "gl"

> +			rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
> +					       entries[i].pfn, i + 1, entries[i].writable);
> +			if (rc)
> +				return rc;
> +			if (!sg->parent)
> +				return -EAGAIN;
> +		}
>   	}
>   
>   	rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,

