Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFE358399;
	Wed, 12 Aug 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532543; cv=none; b=TJo1RaNOtWBsaoW4jVYod5zdY7Pl612dvjJeh7lfkzFJpppBagAb6KKRb15ymhJ5HG97Z0eMyFIS12YboIAT/3Vh5wLRv+vkGDn/hgggpQAlEhRrLUBRIXAAdoZJJsyOAmK55sS1ra61ofzQWLPhu10RfwEE7ME/Yf9t6abZtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532543; c=relaxed/simple;
	bh=+AZpj5Qujy+xmDgwL2FvwBAqPk93Nzs4o0gy2sEWJGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=SThXfTQOJ0dOVVl4ic4FJ0QwKLV0hLxMy/HarS2XTKcp6urgrGetWgqja64iqZtYDXoQvFjWOKkFY0y69D8K0FIbwAMOdKQxRZ2Th5nGL1wd1Ti/mm0U4bSZyz7Pi+K8pfJQ5VghhwDVJaYzp2rzs5lZkH5s564c1F0KdMw52/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qnil6d8s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qnil6d8s"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1fQj3130673;
	Wed, 12 Aug 2026 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cs4mwc
	4OWK5IOPJBuKynkQ8qWRMnQCVp8B4FTVyddUk=; b=Qnil6d8s9H2l0Z077oStWo
	iR+EEJH3ikcKnCMyWv4X6VvRCP7dwUMrGkbNIEinUxo4Qn5yx3ZWbwThCuuSRrwr
	vqrZyC+8/p0P1/jgsF9/mt82VDq3pKwodPFOinhpMCkMzaOTWKwaDORpfnbmCPj3
	iVySKhmgDRrhYsf9kQ+kkhE4muEsadHfulUXf++OXNwoqI6t4dlkxNFPbGsNj5Dd
	WMCQw2MZAHGkpU1vA6NNQgIF2I8Vv1d7s0WYOpaWJS+Sffk+CyPXjIEFEAqs5UbS
	blaSpCT0YEjaT8W5Xv2N/ASyxottaJPfjCAthR0QlYNToGFdxwmF97jzUUjXDsxw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9j0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:02:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAub7D009713;
	Wed, 12 Aug 2026 11:02:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5kmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 11:02:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CB2Fim35520936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:02:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4EF12004B;
	Wed, 12 Aug 2026 11:02:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F7E420043;
	Wed, 12 Aug 2026 11:02:15 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 11:02:15 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 13:02:10 +0200
Message-Id: <DKMWXEB37T6I.2HERTSD305V4U@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] KVM: s390: Use srcu in
 kvm_arch_vcpu_unlocked_ioctl()
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-3-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GRJ5QzJvm9Xt8Eaw3Giju-1f6XfZKIL5
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c52bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=5U4SOpAO3jNZNSaX8vEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfXzOGRNeMrFKYv
 +68mQSr/ZSE7Sd89/Kpz8zpzJ4Xf8n4xujeYOZTOY59a5iA01nnoBmHL6afKfZ+4/gVjSc7MY3j
 El3Vgs3E0Hi249ejJ3I8Xtq61RQ/+A6QTo0Zz/OKq1MPFLwHA9/kIX4xT6yot/MZQrsF5d7UY2r
 psdjZkftqzCZ0/429OmvYJQnX1egyGHQzbLbJ68TrIp5RMkl0snzHC7fOyuUU/0o/2I0vbxUHVb
 Kv+YKSPVIqqGMjgsqjFlnWiQVqogGkW8CT203wlQbjSlQLdc1zm9YdUM5hutiXHWNHRFUx08C5z
 3F9DLFdMbyPobHiQ8pWPY3ZqH4DkA1/1kGuzDQi3aOu9lzxJZf/AvwkrNFc9GBetySKQdHWA0VN
 K70JnV9LWVwo6TmqiXF7p7aa7k5tleI6V8U+A/vZPTQNkEqwjAB8P6idaIS6JaWCdNbcws58a1k
 6nD68xAh0sqHX2BcXwg==
X-Proofpoint-ORIG-GUID: GRJ5QzJvm9Xt8Eaw3Giju-1f6XfZKIL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX1KKQPxO1+2rA
 6PsNjN/RONSLhg0OHXitLIEX2XlsC6wNHN8FrIK/5cYcbceadXHr+WnN+6J+vIV9ArccdYJ8VdS
 S7lKadFbvMvWfDEDeHEqxbj0NTAYiRs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> kvm_arch_vcpu_unlocked_ioctl() is called without further locks held, but
> kvm_s390_inject_vcpu(), which is called from there, needs either the
> kvm->srcu or the slots lock.
>
> Fix by taking the kvm->srcu in kvm_arch_vcpu_unlocked_ioctl().
>
> Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw"=
)
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85..b35340642c3e 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -5450,7 +5450,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp=
, unsigned int ioctl,
> =20
>  		if (copy_from_user(&s390irq, argp, sizeof(s390irq)))
>  			return -EFAULT;
> -		rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		scoped_guard(srcu, &vcpu->kvm->srcu)
> +			rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);
>  		break;
>  	}
>  	case KVM_S390_INTERRUPT: {
> @@ -5463,7 +5464,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp=
, unsigned int ioctl,
>  			return -EFAULT;
>  		if (s390int_to_s390irq(&s390int, &s390irq))
>  			return -EINVAL;
> -		rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);
> +		scoped_guard(srcu, &vcpu->kvm->srcu)
> +			rc =3D kvm_s390_inject_vcpu(vcpu, &s390irq);
>  		break;
>  	}
>  	default:


