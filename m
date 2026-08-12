Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0330D3F4;
	Wed, 12 Aug 2026 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539793; cv=none; b=cpPugYdC7wwUgrS2acHWRFXKPyC4STX9x9sfqvtjiUAkLwNONodDRflBzUsH+47T7BXAMSMgY840Fq15zhxewCA3/3iJI8Jc/9EIIKNQUoV5rQrDjpgigCFDC5W7cmdPpBeqTqGiLMRbDEeOPgtTq+QXwQNCgjqAAYcIuX4Aagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539793; c=relaxed/simple;
	bh=kVQQJF2wkFYaV5eeAX+6BFN7k2eeBXDpWVh+AqN07Uc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=okUiwVw6GWaIHAH129Jtv/MHxoN7ktOTF7TN3UIhksJi/evd4XwTysyakQcIuRcARzSGD2T9aLd0QDwOVrVDc1R29IMzCFAJdwXUYtkgaMH+vsH0Hjx7XvHowaa4CN9BMXAj6hzUoDFxm5jnYbUVp+p/0Whpnmqw6eSLBbaJclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qxVNmNpv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qxVNmNpv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB3oRn3258659;
	Wed, 12 Aug 2026 13:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j3cor8
	0/kznboJmsNdSE89Pv+V3GluAff6gZhHXkCTI=; b=qxVNmNpvaN5YCrfHbri/8q
	SyaBjq4e+xX0ALRA2n3skmqCylRR0/lcqUqn9HS3oVgCKIPUNvp3Zr8f1wmHYfBj
	uYNRaBB0lJ7dSMv26RzSwlbLfHAPKKOvJprTfW8WWzjny+icY6nb//7KVPKAXR2o
	EE4FRiJ8fGzx10k1Fl3VZT2E5BztE9qBYJfTRAEBYevqd8XX+apGlofGwvm7gA64
	RDZHiFAqNtl9J0jNflnKuQSykkvdXhRkvFMz8csecg10Wmo6bbKTzfsHFJ7W6mEO
	Nb4Y6ZLCpTPrMLr/yV138LdD+QbjsmByGPs2C6fe/MT0VlzpZHPQ3QJp4LEwWM2Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9jf4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:03:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCuLmB011468;
	Wed, 12 Aug 2026 13:03:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w65pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:03:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CD35jq38338874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:03:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E7D2005A;
	Wed, 12 Aug 2026 13:03:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F23720040;
	Wed, 12 Aug 2026 13:03:05 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:03:05 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Aug 2026 15:02:59 +0200
Message-Id: <DKMZHWOW5AGH.IBGGR6WSXP97@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] KVM: s390: Fix kvm_s390_clear_pv_state()
X-Mailer: aerc 0.22.0
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-8-imbrenda@linux.ibm.com>
In-Reply-To: <20260812104436.109741-8-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xqIliL-TWAHZlQXkX8w4c-YPG_YEbudw
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c6f0e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=TetwIEPGvFocaHMLVJQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfX+Z9f+oX+m/rr
 ENItii17t0kMpz6ompg12e4zjRK+YhrPHrL2ISUzcF+ezuJq1cEx1t9Q/Ed92zKrwigsTCPeA0V
 tBCl0yUZWPjKpsb1Jv9X4m9bduM/d2g59TMIMTJO3U+ui1Papw2rY2GfrUEXuZnL/LZz550Vcda
 g5gTPQcefebssW65GvAXVz16w3DyOq6WOj+UScLSqv9e+BooXDrWAz784I64OPufIIP0RmrMzt5
 7xWEQxJCFzBCVK4+eZlNUdkbEc8cWeHIE4rTSXwvZy73aJ1Q4+DUuCJ6+FR7NdFioPv80FGteUL
 EF6etJ2jjI6yaUiHFBmXrRJllVCdo3VAk9Hal06UmYCslr31uGIqKF/Pn8dg01tv7ahojXrtE6E
 1dzyHga8AwVyGDcKpXlJlb6gtm7P4yNKdUozRa2wsvcUvq9HwRtq6YgNegCelFJ4go0tuanKoJN
 HGt2vVkL5QQnQipxUkg==
X-Proofpoint-ORIG-GUID: xqIliL-TWAHZlQXkX8w4c-YPG_YEbudw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNiBTYWx0ZWRfXxjbxMPUsfnP5
 LT1cinHfAA9XHqFZKJ67e4/ryxLeirEXJTrMSBvb1s4CTkDv6X27nA3GXSFF4U4TTlA+Bb6FihO
 rj+FAul/pW/Zn/zQWB8wSsd3hLL/MHU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120106

On Wed Aug 12, 2026 at 12:44 PM CEST, Claudio Imbrenda wrote:
> kvm_s390_clear_pv_state() needs to also clear the dumping flag, to
> allow the protected VM to be started again (as non-protected, with all
> protected state safely destroyed) after a forced reboot while a
> protected dump was ongoing and not completed.
>
> Fixes: e40df9efd68a ("KVM: s390: pv: clear the state without memset")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Acked-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/pv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index b02e0159d3cd..98a9a57f71b9 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -242,6 +242,10 @@ static void kvm_s390_clear_pv_state(struct kvm *kvm)
>  	kvm->arch.pv.guest_len =3D 0;
>  	kvm->arch.pv.stor_base =3D 0;
>  	kvm->arch.pv.stor_var =3D NULL;
> +	if (kvm->arch.pv.dumping) {
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		kvm->arch.pv.dumping =3D false;
> +	}
>  }
> =20
>  static void kvm_s390_pv_dispose_cpu(struct kvm_vcpu *vcpu, bool free_sto=
r_base)


