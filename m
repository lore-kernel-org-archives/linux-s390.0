Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80B38552F;
	Mon, 23 Mar 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258918; cv=none; b=WmgGqGZX+z1alC89HqNsN0jOSDapWjTvWFuuyCMmnkOWJLcDFtCds6Idd/TQYfdPSz2+AZHyQY9YHrIaJ/rbR2g9dQvswfJOZZA9j9ACIXKWtk/KmewhkXEE8bOgiRk87pv1YpDfKOKyBrt4+pqyf87Zt1WJMBFOKgeuqWbvTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258918; c=relaxed/simple;
	bh=VOSK6AaCxQSTQFajzAiT0euTggc2yquqJNHeBBOjtiw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=sMUU3hzGVcDpgLeFosgkdWLWP2922KeLB2q4qi+/JjY4QFl5OZqKYx9VLOtHLEtlAV6B97Y17O64511nqMy53Q7Pg2d8OOzTAOMuIiSaT1xpof80ONEmQv+MbR2py7NXmJa3ZFCMyo0C2RUH+RbMnOUpiVgFWcndjv1dsy3Funs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OKPJpDUU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OKPJpDUU"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MFHsvh3826166;
	Mon, 23 Mar 2026 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=boeD76
	3bC4E/gTbIGlfkP9tTn0/24w48tJhxst2DVNc=; b=OKPJpDUUcHAOJKFODEfVWh
	qdTmQ/IT4tRqHkIF6xfiFnVChwwpflT/KViH09ee0gLg8tSZy71plDySJJ6cEGGA
	t6bqcXWh8cb/7SF30QNOrKCyPGq4OUDXIHlyoQfCjxAuOYIWYPIdGQ4dxaYccvoN
	g3pWmPUzeAFf8vMqOeBtKig++3TfNPZA6/DbQ3oM3IXYeP21vLjlFJT0rQ4UcUSm
	4R0UhyM66f5grnOC4K9mC4kjfHr2A/SU1V7BMIvBTFovQscK5Etj0WHQhSoRXvIg
	nAATE06hfNjboRjvfOtQr+0sWdpD4qIW7DDnxdH7NOT8POa+lRXcr3j7hUbwNDNQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxywwx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:41:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N919k2004399;
	Mon, 23 Mar 2026 09:41:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1vj81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 09:41:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62N9fpCj22020386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 09:41:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D08B20040;
	Mon, 23 Mar 2026 09:41:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38EFF20043;
	Mon, 23 Mar 2026 09:41:51 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 09:41:51 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 10:41:45 +0100
Message-Id: <DHA2AH0CSLVL.2RED4W0M6RLNE@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <akrowiak@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [RFC 09/10] KVM: s390: Use gpa_t in pv.c
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-10-frankja@linux.ibm.com>
In-Reply-To: <20260316180310.17765-10-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3MSBTYWx0ZWRfXytLCM7dvAMOV
 2HntCToGY6za6HPbIbu0SE04yxt0uxQeTyu5iT53WiBZlwB7gzQvx6RQ8bA3jBlnRLYpVVDeHTY
 CaBPVxqc2+5mYiRpE273qHc2EhwGMbOfktYqSL0zGo/hF4jMuGUBYvfhMmVHuNu3iSdbtIaMJEP
 9YI2Tq75AaICywii3S6jz2mJNVOmcoBNn7ezYU4jfUbor6I4ltNLaTQhJyRekNCDUw48JQxc7Jx
 +ew/UOSsZmT+y02vRLeABBOTIQhy9mMOZRgzZcUOr5aTsgrWPPcv9X1s5BmlJZO2Rz4ghzArgSQ
 +Gr0fB3hJyt5Vg9LTMYkkNYIb9uoWQaXsfQM6tRvM6r17jUIg5dVJxS6kgCUAMvgHVcMeeRe94Z
 7UX4xJ7TR2U2hmYtLJETabRAC1w52iTN2Pmo8f3o/gdQe3mqR/cwaSXnTXGdofmfOxAaGU7DlNZ
 4lIdss2j0oiGxllFkiA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c10ae3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=L-qVmOLguht6ssTEgqgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7DwJzjc9F1QQ5FXSNlj68YCVvuY10b7p
X-Proofpoint-GUID: 7DwJzjc9F1QQ5FXSNlj68YCVvuY10b7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230071

It would be nicer to also rename the variables here from the mix of "gaddr"=
 and
"addr" to "gpa". Or at least conistently to "gaddr" as they are in most cas=
es
then assigned to the ".gaddr" fields in the uv structs.

On Mon Mar 16, 2026 at 5:23 PM CET, Janosch Frank wrote:
> Lot's of locations where we could've used gpa_t but used u64/unsigned
> long.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.h |  8 ++++----
>  arch/s390/kvm/pv.c       | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index bf1d7798c1af..1ffaec723a30 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -308,17 +308,17 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc,=
 u16 *rrc);
>  int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u1=
6 *rc,
>  			      u16 *rrc);
> -int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned lon=
g size,
> +int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
>  		       unsigned long tweak, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_set_cpu_state(struct kvm_vcpu *vcpu, u8 state);
>  int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void *buff, u16 *rc, u16=
 *rrc);
>  int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
> +				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc);
>  int kvm_s390_pv_dump_complete(struct kvm *kvm, void __user *buff_user,
>  			      u16 *rc, u16 *rrc);
>  int kvm_s390_pv_destroy_page(struct kvm *kvm, unsigned long gaddr);
> -int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr);
> -int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *=
uvcb);
> +int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr);
> +int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb);
> =20
>  static inline u64 kvm_s390_pv_get_handle(struct kvm *kvm)
>  {
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index c2dafd812a3b..a86469507309 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -125,7 +125,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fau=
lt *f)
>   * Context: needs to be called with kvm->srcu held.
>   * Return: 0 on success, < 0 in case of error.
>   */
> -int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *=
uvcb)
> +int kvm_s390_pv_make_secure(struct kvm *kvm, gpa_t gaddr, void *uvcb)
>  {
>  	struct pv_make_secure priv =3D { .uvcb =3D uvcb };
>  	struct guest_fault f =3D {
> @@ -157,7 +157,7 @@ int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned=
 long gaddr, void *uvcb)
>  	return rc;
>  }
> =20
> -int kvm_s390_pv_convert_to_secure(struct kvm *kvm, unsigned long gaddr)
> +int kvm_s390_pv_convert_to_secure(struct kvm *kvm, gpa_t gaddr)
>  {
>  	struct uv_cb_cts uvcb =3D {
>  		.header.cmd =3D UVC_CMD_CONV_TO_SEC_STOR,
> @@ -765,7 +765,7 @@ int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *=
hdr, u64 length, u16 *rc,
>  	return cc ? -EINVAL : 0;
>  }
> =20
> -static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
> +static int unpack_one(struct kvm *kvm, gpa_t addr, u64 tweak,
>  		      u64 offset, u16 *rc, u16 *rrc)
>  {
>  	struct uv_cb_unp uvcb =3D {
> @@ -793,7 +793,7 @@ static int unpack_one(struct kvm *kvm, unsigned long =
addr, u64 tweak,
>  	return ret;
>  }
> =20
> -int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned lon=
g size,
> +int kvm_s390_pv_unpack(struct kvm *kvm, gpa_t addr, unsigned long size,
>  		       unsigned long tweak, u16 *rc, u16 *rrc)
>  {
>  	u64 offset =3D 0;
> @@ -802,7 +802,7 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long=
 addr, unsigned long size,
>  	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
>  		return -EINVAL;
> =20
> -	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %llx size %lx",
>  		     addr, size);
> =20
>  	guard(srcu)(&kvm->srcu);
> @@ -891,7 +891,7 @@ int kvm_s390_pv_dump_cpu(struct kvm_vcpu *vcpu, void =
*buff, u16 *rc, u16 *rrc)
>   *  -EFAULT if copying the result to buff_user failed
>   */
>  int kvm_s390_pv_dump_stor_state(struct kvm *kvm, void __user *buff_user,
> -				u64 *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
> +				gpa_t *gaddr, u64 buff_user_len, u16 *rc, u16 *rrc)
>  {
>  	struct uv_cb_dump_stor_state uvcb =3D {
>  		.header.cmd =3D UVC_CMD_DUMP_CONF_STOR_STATE,

