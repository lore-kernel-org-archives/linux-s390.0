Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C92FE056;
	Mon, 23 Mar 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258141; cv=none; b=D5eymG0Rw2UWEhS0+/9hfrtzYNYN0mIH7q4iM+nzb5Tk2j7J6qU8ZKXLmNdiVrVY4T23daZ+EmHTFXpDpfvOs9i0vdraCk74Mk3oIJm9Fsbn77StTg7ET3EC3B6IEiygUCiPXATxcNtb+oonoZdnvVg11DnKKV50RX+0DcB/n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258141; c=relaxed/simple;
	bh=WsExo9RWlEnKSEd+6EdpMniLISMPtM5lDzRLG5FKNrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=aHPVopw+G+tKTrZvTzbbOhYjHbE7rqHLDNypwjVLCAuxwfJrD7pGZ7uprzjsXPyT3rMncvqculs1JVHZdNwBkr5CwLIIVxhCDe8O1rFpkGiPF3uKkVBpKhyrxgqpR2LVNRrfGvqjvMJY7LGwlIr4BUvzcQytZjz5HeBVZN8w5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wfw1XNbk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wfw1XNbk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7SsAE2755971;
	Mon, 23 Mar 2026 09:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e7+IvJ
	TaUSXvxNIhRcTd8CQo0k1WlJqVXsm3oMcW7H0=; b=Wfw1XNbkUGMoZv9CFMVpN2
	gSJ3lWzqorWpRNOqLAilNTkfrevHQfaH7xCrMPQyxlgbJDlWGeMCELMGK5YVy0wU
	+6zsnsgnk/GQh7uCojYPs2OlFOzbUTuxpP4N0SPneKaBaqy/HquL0wfOHwy+oWtf
	fRfXM483rUlgCtQUGXbgYqgEkTkwpeQb9g8eGLhir6QfB/dWgOcHUy44r/z843eC
	noJNzYkBA+6QfNEHS3xG0RIoYutKjdRhxNhUoYd9JQmavjJWeO5bw41M5cAKs63Q
	QIeqfXpLssWK6k+d3+Igj+0G/x99jj4B5zq6jC6nqtDuwphUvn1K7tSpBvZfhHug
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumdxdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:28:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6O1WV005969;
	Mon, 23 Mar 2026 09:28:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ycvwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:28:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9SsBB31326610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:28:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2509C2004E;
	Mon, 23 Mar 2026 09:28:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1315020043;
	Mon, 23 Mar 2026 09:28:54 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:28:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:28:48 +0100
Message-Id: <DHA20K345A5W.28SZ0WJD3FKBR@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 08/10] KVM: s390: Use gpa_t in priv.c
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-9-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-9-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iA7YqlmzFcHQAvHnuF2rHwSKOsgbN9ux
X-Proofpoint-ORIG-GUID: iA7YqlmzFcHQAvHnuF2rHwSKOsgbN9ux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfX7lxCvlf3PvqV
 9DwDbujjABiFiZLRiJBnCV2e7EGlzRjPP1Yk8M5yOQhsDqXsYDKf/wnLMY8ETLRmkoIecPWC8hM
 pEXrkETyeoiUrvysCQGKDOuZ/VgWSi7MymevNV+99Rfn8y4A+p7wYB4ZQiKrGUgdbBRGN/rsLhB
 Ml6kl0D4r5L7wa+O89b7YSFa/fpjPX1LjnC/t9jFC6CdlywYynr3zHiWyrkHi5emA9zmsuZJxCB
 yipLVwkJ5iLsdq66no2PhQJjs0m0XCVH80Tk7edw7YVOGcC1F+MPhYbxXFq6NGLoPxOsnbbvOGC
 MptAi/EMpeeqOOk+ZatXJuQmrI6MDiYUwDCKU+oRrFk1oAmxWj3Bxbcwv21Wbyh+YfcMgnirpSt
 Cj7/yrtZp/Hwy/7wzKS+86vRwi5WVUR0+E6K89iHfTvTzEOz8OVe00pkBrZZgpJSNtSBS/TWeBa
 mDiW0E/qi9gEmZ4W+vA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c107da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=w_8I12GqRuPPQ2R_Ye8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230071

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> More unsigned long to gpa_t conversions.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.h |  8 ++++++++
>  arch/s390/kvm/priv.c    | 27 ++++++++++++---------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index f23dc0729649..970d9020dc14 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -89,6 +89,14 @@ static inline unsigned long kvm_s390_logical_to_effect=
ive(struct kvm_vcpu *vcpu,
>  	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
>  }
> =20
> +static inline gpa_t kvm_s390_real_to_abs_effective(struct kvm_vcpu *vcpu=
,
> +						   unsigned long gra)

nit: This would also nicely fit into a single line.

> +{
> +	gra =3D kvm_s390_logical_to_effective(vcpu, gra);
> +
> +	return kvm_s390_real_to_abs(vcpu, gra);
> +}
> +
>  static inline gpa_t lc_addr_from_offset(struct kvm_vcpu *vcpu, unsigned =
int off)
>  {
>  	gpa_t addr =3D kvm_s390_get_prefix(vcpu);

...
