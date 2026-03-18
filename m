Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E83090E2;
	Wed, 18 Mar 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848212; cv=none; b=OqRb2oaZjmg+1fsLHqrNLw5f5TY1h3q30vlfcM2dQb2uM9FqDJEG9xMpz6/IkLZWghi2lr0nbSJ7atK4EdI1b+g5BOnlbKDVoYDeIWJJKVmkNibRVCLno+CfdttAAy1B20vP96KvyzHCCHjrSCc+ekDDA8ClDHd+zxLYshR0zQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848212; c=relaxed/simple;
	bh=Gq2WftE+uYWeojN2fexm2NcmTQX0ylyQbZFz2kfHEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfcZO6NKNY55VKUwZJYoYt9Bv0y01q51tK75kI7nWPS64A5MJUyHEwbyEf6ndh/KpblGZkdsw3ACAf2BmHYms3AxojG0WJqNd/sbo2n9brZWiTBYFnIY5mExRaqTgoSOELegXxoCAXbNhkttrEjQyFc3NhVjm4mAaOcXqnF9Nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZ4O9h3h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZ4O9h3h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IAi0SI1484495;
	Wed, 18 Mar 2026 15:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1kOnpL
	Sq0iUyDNvFt1QOIwHIcc+YRsOqF1OqZ1s3vCE=; b=dZ4O9h3hhMUW93Zw7+YS6M
	9VkGsc/Lotq8Qbu3R39Qcq3FD4x1NgBIU+QHkKYJ7ATrx+Gv5bTaNkK4R72G25BB
	vHWpMRUZ8NpGHPiBd165eZupfY/GBnjn8iI4EBYBvZrhvtsBSTM+gWRSbEy1gOpn
	1RlkNF4+lVFVpf3L7T61Mhx0ZpRfikJW8VsDIBPqpx1v5JcEXS2oUQXjL0bXYV+W
	nr3JzgcEzo/EkhnLITawbIJSPvnZElcTQUu/CVh0NUfIGI4Vn4AQyBIHlFVIzi1d
	1bimSxo4xWuI7XfvveWse/gDpqPe+GkAabi7TMxuQJkuPrFNLgWtbBMmAq5tXXmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfn08v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:36:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDUWGX015648;
	Wed, 18 Mar 2026 15:36:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nejt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:36:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IFafSs58393042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 15:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 358F02004E;
	Wed, 18 Mar 2026 15:36:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1460F2004B;
	Wed, 18 Mar 2026 15:36:41 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 15:36:41 +0000 (GMT)
Date: Wed, 18 Mar 2026 16:36:37 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 07/10] KVM: s390: Use gpa_t and gva_t in gaccess files
Message-ID: <20260318163637.17ed4314@p-imbrenda>
In-Reply-To: <20260316180310.17765-8-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-8-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Yqy4FEuPOWellUlfHcDs1GNlOPaGznK6
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bac68e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=v0MfZn9Cwve4zM3rKLcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyOSBTYWx0ZWRfXxdBdpYOCfvhH
 UcxTrp2XuCr4kDClxOv+7q7BOhfbuKzt2rdk8ZHqRpAuD0AewHhqx0ltBjfn06uySP0lZMOVoYW
 56OLFjQTDlf5EfQGIZxIGJ/VDhXPzrCmwPuoXlDm0khDOceo5gBd5ulltogGdI9I02tFbzzX6G7
 4X2RZ+FbnXOZZWzZmCbe1GiOOgS1EZCkaFlcTUx8VqD4S3wb0McDKTG+Cippa6i6+D2EXwSvKVX
 5myPfkCFsuxUOnsBdzbePQoIca21m3Q8ODWWt9m//T2JVY/P88ksRozMS3e7jUHyVdZfUwg2Ufn
 upHhP5VSEKCjkCJQo81U3CEakQVidY5nqMkUHIpAugcI5qPXYeKCLkGb9POlTnCuDEpwBQK/I5T
 a4SJt4Rz6gVY2S7asRjosjWPjxLRl+F8EfSfxO2yoKu/Y2R4fOAzTL7PVcQabBh9qzpeMXL1kyP
 BVMo5WeQb65H7ufJIkA==
X-Proofpoint-GUID: Yqy4FEuPOWellUlfHcDs1GNlOPaGznK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180129

On Mon, 16 Mar 2026 16:23:54 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> A lot of addresses are being passed around as u64 or unsigned long
> instead of gpa_t and gva_t. Some of the variables are already called
> gva or gpa anyway.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/gaccess.c | 20 ++++++++++----------
>  arch/s390/kvm/gaccess.h |  3 +--
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 7275854ee68e..b2e83f6e16ab 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -441,7 +441,7 @@ static int get_vcpu_asce(struct kvm_vcpu *vcpu, union asce *asce,
>  	return 0;
>  }
>  
> -static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
> +static int deref_table(struct kvm *kvm, gpa_t gpa, unsigned long *val)
>  {
>  	return kvm_read_guest(kvm, gpa, val, sizeof(*val));
>  }
> @@ -467,8 +467,8 @@ static int deref_table(struct kvm *kvm, unsigned long gpa, unsigned long *val)
>   *	      the returned value is the program interruption code as defined
>   *	      by the architecture
>   */
> -static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, unsigned long gva,
> -					 unsigned long *gpa, const union asce asce,
> +static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, gva_t gva,
> +					 gpa_t *gpa, const union asce asce,
>  					 enum gacc_mode mode, enum prot_type *prot)
>  {
>  	union vaddress vaddr = {.addr = gva};
> @@ -477,8 +477,8 @@ static unsigned long guest_translate_gva(struct kvm_vcpu *vcpu, unsigned long gv
>  	int dat_protection = 0;
>  	int iep_protection = 0;
>  	union ctlreg0 ctlreg0;
> -	unsigned long ptr;
>  	int edat1, edat2, iep;
> +	gpa_t ptr;
>  
>  	ctlreg0.val = vcpu->arch.sie_block->gcr[0];
>  	edat1 = ctlreg0.edat && test_kvm_facility(vcpu->kvm, 8);
> @@ -772,7 +772,7 @@ static int vcpu_check_access_key_gpa(struct kvm_vcpu *vcpu, u8 access_key,
>   *		  be used to inject an exception into the guest.
>   */
>  static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
> -			       unsigned long *gpas, unsigned long len,
> +			       gpa_t *gpas, unsigned long len,
>  			       const union asce asce, enum gacc_mode mode,
>  			       u8 access_key)
>  {
> @@ -781,7 +781,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  	unsigned int fragment_len;
>  	int lap_enabled, rc = 0;
>  	enum prot_type prot;
> -	unsigned long gpa;
> +	gpa_t gpa;
>  
>  	lap_enabled = low_address_protection_enabled(vcpu, asce);
>  	while (min(PAGE_SIZE - offset, len) > 0) {
> @@ -932,11 +932,11 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>  {
>  	psw_t *psw = &vcpu->arch.sie_block->gpsw;
>  	unsigned long nr_pages, idx;
> -	unsigned long gpa_array[2];
>  	unsigned int fragment_len;
> -	unsigned long *gpas;
>  	enum prot_type prot;
> +	gpa_t gpa_array[2];
>  	int need_ipte_lock;
> +	gpa_t *gpas;
>  	union asce asce;
>  	bool try_storage_prot_override;
>  	bool try_fetch_prot_override;
> @@ -1182,7 +1182,7 @@ int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len, union kvm_s3
>   * has to take care of this.
>   */
>  int guest_translate_address_with_key(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
> -				     unsigned long *gpa, enum gacc_mode mode,
> +				     gpa_t *gpa, enum gacc_mode mode,
>  				     u8 access_key)
>  {
>  	union asce asce;
> @@ -1282,9 +1282,9 @@ static int walk_guest_tables(struct gmap *sg, unsigned long saddr, struct pgtwal
>  	struct guest_fault *entries;
>  	union dat_table_entry table;
>  	union vaddress vaddr;
> -	unsigned long ptr;
>  	struct kvm *kvm;
>  	union asce asce;
> +	gpa_t ptr;
>  	int rc;
>  
>  	if (!parent)
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 086da7b040b5..f23dc0729649 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -199,8 +199,7 @@ enum gacc_mode {
>  };
>  
>  int guest_translate_address_with_key(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
> -				     unsigned long *gpa, enum gacc_mode mode,
> -				     u8 access_key);
> +				     gpa_t *gpa, enum gacc_mode mode, u8 access_key);
>  
>  int check_gva_range(struct kvm_vcpu *vcpu, unsigned long gva, u8 ar,
>  		    unsigned long length, enum gacc_mode mode, u8 access_key);

