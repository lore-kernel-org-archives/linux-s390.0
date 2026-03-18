Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F93093C7;
	Wed, 18 Mar 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848773; cv=none; b=Gf9NGZGkgT7kMFHq9LcuVXqsoeDOKUzCqAbCRyUJxIq34dVzas3NZ+aS6G0lJ0sw3a1JdD3K9b2TiWVBqTZybDQUf8hUvhT2o2UwxiORpw4g5hkATa99Rbr1vvF4tfEkbE74zs6aMeqCBMTRaBOy9h5xA6z9qedBVp22+MGwilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848773; c=relaxed/simple;
	bh=7bOx1bBUg+NyXZ2YU6D7UU0XAuwW5EBkCOa7T83mQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+V5k2mK9Isg0Ju+RLi2X0HdmxRW1nrZY2iOVxFQsfPdSjpPmDFDeJ5kO2ix9pRMBGXhINcGztsVQi3rk65T2tO4ENTKH31SyPYVsbTxcE7iJyDpTPuiCshp4f4L0/0dtR4OB6mEYcqcwLqQscYcc3vLOyfaPcDqP4pAUum/iNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sP4wYD4U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sP4wYD4U"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IBB8wh475030;
	Wed, 18 Mar 2026 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HOao+j
	3CiRvrjsFErOfOqfj5uiV02Qfu3KWVNoZB9vM=; b=sP4wYD4U0b/XssOUUzceJ+
	ZuA0t0ffqb34PzY+U/VxdL+e7b0CW65+rkUwDH9Gi5B10KSZQdw2WEzWDynwh/Rb
	piADabg8pGWOxVGUOiTkqmX5pRechfLgk3JeVvsdQaGABo1AEe5Ec3t7+gUl6rKp
	9nmOrtCbAeN/xVw5yaHvo6zauTugXfePS1DeGaN5FszeHXkC9Abq3XsuyPlDPDRb
	J+1Bdy154hQ9JntuRumXtmW4thYxrjSS+LRUiBg+pM8F8aJ/a+Fm4tasSETUFPGc
	aTE3AoDDXsMzcft7Rn3oV41KAA5SuN1a7Ko9OEiF0amVUBbHButun/d+Abg4MPPg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauj31r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:46:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IF5Ywn028455;
	Wed, 18 Mar 2026 15:46:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ed6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:46:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IFk3t931720080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 15:46:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF22120043;
	Wed, 18 Mar 2026 15:46:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFFC420040;
	Wed, 18 Mar 2026 15:46:03 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 15:46:03 +0000 (GMT)
Date: Wed, 18 Mar 2026 16:46:02 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 09/10] KVM: s390: Use gpa_t in pv.c
Message-ID: <20260318164602.2b7fce6d@p-imbrenda>
In-Reply-To: <20260316180310.17765-10-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-10-frankja@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNCBTYWx0ZWRfX4ZK/LnPA+mCl
 hr1jBPp/jopsnrDnmd5mFsy7WO3roZ106I2o9t93wSTfF7kt0hom7+HEfHeBoXJPNKUjibjoRt/
 f0cgBFXiBBlRUmXcwmQYhhlAdUJoFuFkNn75O5G/PdVZ0Q3eKu0C55chr5lLOoWjhmoC1Y/zZHd
 WrK7tu4Cik77dB0Ffd4HrCuaeIu4XSMwyh8PTJDnpF7indGipTaNL32kxoplrrtp88CD3ew9Zct
 IIFlmrroIMXTVt9diV9bXwvk7zj/fi7CNVUXh8gkmqz7hfT3BzJc1Z3CzvTMxmR10wxt3WxFVCb
 TqazYxB4aqY+TN2r7JgLxA9h1n0hvgPK//w1JP3dSKXaAaC5/afFTzLuUT0eWssA0rhu1orvG53
 Iz8a9cpq8WUbMhlNXGAyvHVqO1lXKSJAYQ11UXBwIT3SJXB0EhONodJbTGrN0PimBw6oAXJfhG3
 gCpG27LuleB5WsOZedw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bac8c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ngE5aYM4yAv9Qu9d214A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: k7nt2sXpCmgACwkaNF0e2dBrmF1TBYOv
X-Proofpoint-GUID: k7nt2sXpCmgACwkaNF0e2dBrmF1TBYOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180134

On Mon, 16 Mar 2026 16:23:56 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> Lot's of locations where we could've used gpa_t but used u64/unsigned
> long.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.h |  8 ++++----
>  arch/s390/kvm/pv.c       | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index bf1d7798c1af..1ffaec723a30 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -308,17 +308,17 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>  			      u16 *rrc);
> -int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
> +int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
>  		       unsigned long tweak, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
>  int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
> +				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
>  			      u16 *rc, u16 *rrc);
>  int kvm_s390_pv_destroy_page(struct kvm *kvm, unsigned long gaddr);
> -int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr);
> -int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb);
> +int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr);
> +int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb);
>  
>  static inline u64 kvm_s390_pv_get_handle(struct kvm *kvm)
>  {
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index c2dafd812a3b..a86469507309 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -125,7 +125,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
>   * Context: needs to be called with kvm->srcu held.
>   * Return: 0 on success, < 0 in case of error.
>   */
> -int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb)
> +int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb)
>  {
>  	struct pv_make_secure priv = { .uvcb = uvcb };
>  	struct guest_fault f = {
> @@ -157,7 +157,7 @@ int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb)
>  	return rc;
>  }
>  
> -int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr)
> +int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr)
>  {
>  	struct uv_cb_cts uvcb = {
>  		.header.cmd = UVC_CMD_CONV_TO_SEC_STOR,
> @@ -765,7 +765,7 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>  	return cc ? -EINVAL : 0;
>  }
>  
> -static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
> +static int unpack_one(struct kvm *kvm, gpa_t addr, u64 tweak,
>  		      u64 offset, u16 *rc, u16 *rrc)
>  {
>  	struct uv_cb_unp uvcb = {
> @@ -793,7 +793,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
>  	return ret;
>  }
>  
> -int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
> +int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
>  		       unsigned long tweak, u16 *rc, u16 *rrc)
>  {
>  	u64 offset = 0;
> @@ -802,7 +802,7 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>  	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
>  		return -EINVAL;
>  
> -	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %llx size %lx",
>  		     addr, size);
>  
>  	guard(srcu)(&kvm->srcu);
> @@ -891,7 +891,7 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16 *rrc)
>   *  -EFAULT if copying the result to buff_user failed
>   */
>  int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
> +				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
>  {
>  	struct uv_cb_dump_stor_state uvcb = {
>  		.header.cmd = UVC_CMD_DUMP_CONF_STOR_STATE,

