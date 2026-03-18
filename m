Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C58244684;
	Wed, 18 Mar 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843937; cv=none; b=Il84SZ1/7LeSiX59Jt1skmJWudMVbBXkWWO0ViynR0xCxhEYO4stM8UIkLndfr3atMcW+veDVwsPySqKpSpZbJ1KEOu4t31Q4MLsFH769qfR/Mi8cNMG+6QYSj7lZe4FwQ/ToUPasW/6JO08aPSWZfQNA1bjlz94ngUnvCWcV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843937; c=relaxed/simple;
	bh=casxzDRigkk/8hJ51GFpu2+iq8mR7f2TfsAKutrC6iU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N80OE0WT34FzhH0yMs/mGOXV2hABZUWcm+FGUclH8ahUtttgaES++7IxqB0Fuk0LNZASGABa/SCzhIGQIi5+dgaAPyUuwQC53vxLVuA7MKXrvUyl93mmtoPvFkMVoL0iNxuG7oPpqK22XZcJj60Cl51zekBOSIY5i7xXQOsXJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEk8qqFq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEk8qqFq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IAxm9J853168;
	Wed, 18 Mar 2026 14:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cFo3zt
	OxP3NhfET6j/VRTD/Yy1NxqqFmTH97oAjJ4x4=; b=mEk8qqFqq2qAlOsiE5H75c
	XgUduX68PGK/wT80dU2brkgQytExCeAkVp1WNKAdf2gh/Zin8CluWZZyZFpk93Xp
	z4VNMJbKJK0TK4ltdNGRAVTkCv0JaReIaZVZtjIWJ8lvP1LY7LS95ZGqihOkVw2k
	nzDX1ahnEpmy5SDYjj5mNl31TsDf0iMh7BZmIxA1WJDZr/2BnRklQTmoMsUhTdSw
	I5FnSatlSckfd5HSQnzwwiKQ0LfbXN8lNLce12dgy8YvIlv2NVvGhQBQxKTg5d4w
	X47IyYlKT0i856P50pkTmjTnUyItjgxRlrqC92fP5nFRkvkfjEiWmhJPlXEYq/sQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauhqev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:25:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDiMru028720;
	Wed, 18 Mar 2026 14:25:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkeayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:25:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IEPUJv52822304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:25:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1144520043;
	Wed, 18 Mar 2026 14:25:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA9620040;
	Wed, 18 Mar 2026 14:25:29 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 14:25:29 +0000 (GMT)
Date: Wed, 18 Mar 2026 15:25:27 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 06/10] KVM: s390: Rework lowcore access functions
Message-ID: <20260318152527.3be04f07@p-imbrenda>
In-Reply-To: <20260316180310.17765-7-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-7-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyMSBTYWx0ZWRfX7DmHfdim58UI
 7gykirzu+Dx+Yr+0psq/E5a4Fk49K08u3+qG0gv0/tgD+Oo42izaZrN+W6A14mVxqhDYucsqxS6
 jhztN0gPtLfbyl7R5MTl9PRGEYKSbP8yynO4hHOSWMvF5Vpyee4+g4YOirSIKe3WOL+ULqa/LrG
 vh/19NM7GiL3Ii6+SFC4iC9lNcRWlvIMz3Bndl6zAASypyS5Z+xEt7iL9IvVw+Pw0K5BYCu+ERp
 saY93S88Jot6YEs0g/V9rU39SxUb/nTYyNUZzQdFZA72IrZjgDoH2C+8Vynz6oA2IeRzPg3KLSk
 +Lx4E6TvveAatwnQSX67RRtsjIS3aNFGEnj+Td6mKsyd1RbkCTpwuC3fdtdhblBJ/YlMOfA55Ry
 0SO7gzIx3W8mW7gB7f8KvJsyBpIgA6AmL6iVE4MISWuUw4zlOs1yibQpnpyivpS+Z36ZjOM24WG
 UFEo4bDun3SmINpGQgw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bab5de cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6vvq3SilYwppQSaCk4sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QgzYHO01IC_dP-UMp5tq0YJDxByq8G33
X-Proofpoint-GUID: QgzYHO01IC_dP-UMp5tq0YJDxByq8G33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180121

On Mon, 16 Mar 2026 16:23:53 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> These functions effectively always use offset constants and no
> addresses at all. Therefore make it clear that we're accessing offsets
> and sprinkle in compile and runtime warnings for more safety.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.h | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index ee346b607a07..086da7b040b5 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -89,6 +89,13 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>  	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
>  }
>  
> +static inline gpa_t lc_addr_from_offset(struct kvm_vcpu *vcpu, unsigned int off)

int is ok, but technically it could even be a short

> +{
> +	gpa_t addr = kvm_s390_get_prefix(vcpu);
> +
> +	return addr + off;
> +}
> +
>  /*
>   * put_guest_lc, read_guest_lc and write_guest_lc are guest access functions
>   * which shall only be used to access the lowcore of a vcpu.
> @@ -117,13 +124,14 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>   *	 would be to terminate the guest.
>   *	 It is wrong to inject a guest exception.
>   */
> -#define put_guest_lc(vcpu, x, gra)				\
> +#define put_guest_lc(vcpu, x, off)				\
>  ({								\
>  	struct kvm_vcpu *__vcpu = (vcpu);			\
> -	__typeof__(*(gra)) __x = (x);				\
> -	unsigned long __gpa;					\
> +	__typeof__(*(off)) __x = (x);				\
> +	gpa_t __gpa;						\
>  								\
> -	__gpa = (unsigned long)(gra);				\
> +	BUILD_BUG_ON(!__builtin_constant_p(off));		\
> +	__gpa = (unsigned long)(off);				\

why not use the new function lc_addr_from_offset() that you have just
introduced?

>  	__gpa += kvm_s390_get_prefix(__vcpu);			\
>  	kvm_write_guest(__vcpu->kvm, __gpa, &__x, sizeof(__x));	\
>  })
> @@ -131,7 +139,7 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>  /**
>   * write_guest_lc - copy data from kernel space to guest vcpu's lowcore
>   * @vcpu: virtual cpu
> - * @gra: vcpu's source guest real address
> + * @off: offset into the lowcore
>   * @data: source address in kernel space
>   * @len: number of bytes to copy
>   *
> @@ -146,18 +154,20 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>   *	 It is wrong to inject a guest exception.
>   */
>  static inline __must_check
> -int write_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
> +int write_guest_lc(struct kvm_vcpu *vcpu, unsigned int off, void *data,
>  		   unsigned long len)
>  {
> -	unsigned long gpa = gra + kvm_s390_get_prefix(vcpu);
> +	gpa_t gpa = lc_addr_from_offset(vcpu, off);
>  
> +	BUILD_BUG_ON(!__builtin_constant_p(off) || !__builtin_constant_p(len));
> +	BUILD_BUG_ON(off + len >= 2 * PAGE_SIZE);
>  	return kvm_write_guest(vcpu->kvm, gpa, data, len);
>  }
>  
>  /**
>   * read_guest_lc - copy data from guest vcpu's lowcore to kernel space
>   * @vcpu: virtual cpu
> - * @gra: vcpu's source guest real address
> + * @off: offset into the lowcore
>   * @data: destination address in kernel space
>   * @len: number of bytes to copy
>   *
> @@ -172,11 +182,13 @@ int write_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
>   *	 It is wrong to inject a guest exception.
>   */
>  static inline __must_check
> -int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
> +int read_guest_lc(struct kvm_vcpu *vcpu, unsigned int off, void *data,
>  		  unsigned long len)
>  {
> -	unsigned long gpa = gra + kvm_s390_get_prefix(vcpu);
> +	gpa_t gpa = lc_addr_from_offset(vcpu, off);
>  
> +	BUILD_BUG_ON(!__builtin_constant_p(off) || !__builtin_constant_p(len));
> +	BUILD_BUG_ON(off + len >= 2 * PAGE_SIZE);
>  	return kvm_read_guest(vcpu->kvm, gpa, data, len);
>  }
>  

