Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAB25A655;
	Tue,  6 Oct 2026 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302507; cv=none; b=Wn+988rRwuYVmuEW6f1erO7HMGyaaDtLGCZkjuIn2UfdMMLEXj0i1yGjKZ6LjFSvUUxkloB/WP+2Ru6iTIscIoMtqh92+rQMry+wkWKjnYZsO6uC6n39B+a50AdGJ8A2VCwZA59XfQxlOvelKA9Rhb32gZ4D/u2Dy9Tx1sBL+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302507; c=relaxed/simple;
	bh=Z7SJm5BLDpFT1yMsjuZV0gnbWj6B9rkgFethNha7LX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCYUSbw2KXeR31AYLriDYvn5JU6lpcNa364j3WdiAtl4uGjxUjZ8ATZKxFyxNRLG0JhZtCc0Ll4hovHPre090aOc//o/d7wUQk3T/oYFdBRT+MGltrlhA4Qe0ILLCk/B5dFhVOpOgsVpqIcrPJmvPN3dmV0JVjD9jyRlUDA3yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQtzC2Pv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQtzC2Pv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZLEF4058898;
	Tue, 6 Oct 2026 16:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=SHlhYNKJPS9VrHsEuKrVizy
	o6znmQw1por4XuWFVGL0=; b=UQtzC2PvuBcrxMRqa8c2EEgAuXu1u7FX80+Vhr6
	7//VBDKHIN4Xl53pScviC9u6xe+eHDTp9M6Mi0WnT6nqsR4xZqGq5PISpw8+vRs9
	qgVG3Pid45s0a9KSDaUU+JreHSr57tRDKjBYAWzJQXWMgklfPEEfGYGIPbfx+LjL
	j8dOd+1pv89Oa2yyv+uQCF0sIDgxaf5q86cH4caiUysfL5UXKelnlzhBEPpIo1Ph
	bxESFkUnHwfCH1B79iugp9h7MFIDcE70IHAN24stXDLjFrXB8m9XlFAYBEICrHJ0
	WDQ5wyGX5WE0uvjJK61FYprmK7OtFN9dCTcO/L5xLfu2lZQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74s0sr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 16:01:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHYm33343589;
	Tue, 6 Oct 2026 16:01:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8gae5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 16:01:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696G1FiR29164164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 16:01:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711B22004E;
	Tue,  6 Oct 2026 16:01:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F4192004D;
	Tue,  6 Oct 2026 16:01:15 +0000 (GMT)
Received: from vela (unknown [9.111.1.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 16:01:15 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xE7bO-00000000tiM-3XTP;
	Tue, 06 Oct 2026 18:01:14 +0200
Date: Tue, 6 Oct 2026 18:01:14 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 02/24] KVM: Move architecture capability Kconfigs to
 header defines
Message-ID: <asUbSjNMqf2snLNJ@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-3-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930173441.66762-3-seiden@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Uk2b7HaGQ38dTbtCU9DkrQCab_71a3R-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX7ZTpHKTr9Gd7
 VsRMbnGfdUbPWq5Agr64CDEu7EIwNBASkueQr5RTs5SsCpPfHMxcMfOnBU/M1V5px07uoVZNTlL
 bnJUOdFSLkGe16hHy8fT4SPYzJKF8/8=
X-Proofpoint-GUID: UA3t0xK88c6-8lHonjKH3cXitZpW-HHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX9UoPq4Sebe89
 jp5knOE3JTwJsHTzkRL2RLESHYJfSZhPageyY8KfMaHhXtUC5vK9WspNRSZP8ZKGRDvWK/I76Bt
 ERt86IUqC6HbLp6uR+uCLlW340vTma3kvWvLoE3QyS9BCWFFzNuq9jxI7dwaJk9uz6a4Ry69aJ+
 oTYlU+3Q+inLZ8oKqs9smI2rzkxWt5dGlqSnzURIpIvC+phVZKxfv+PpuWTxPVGbdPcXICGM/QX
 PVYNwdYR4hwprOjvuPGB2I61Kk7hVnX6+mUQM/7hMgD8GInNP1NEsGGQ36GBoOSHGo4119STTv4
 +eDFghZHoK5MlwHsIKfvwbTkkN8hlnmdIivDOPyXd6zErWGBo6840rvwgoQTV2NViUyTMqbdKwJ
 VrBHDUr0dM8ANYbSGtCh/lY6geTUwli5ukavMne795rWyFeJ3Lv2TjLPyAcet+KtyK7iPVmtZYe
 9KzmPCKYwRGflUbZd6g==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac51b50 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hrijWW3zfvV0ByoAMhMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

On Wed, Sep 30, 2026 at 07:34:17PM +0200, Steffen Eiden wrote:
[...]
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -750,7 +750,11 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
>  #ifndef kvm_arch_has_readonly_mem
>  static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
>  {
> -	return IS_ENABLED(CONFIG_HAVE_KVM_READONLY_MEM);
> +#ifdef KVM_READONLY_MEM
> +	return true;
> +#else
> +	return false;
> +#endif
>  }
>  #endif

Minor style nit: maybe remove the preprocessor "noise" from within the function by
defining two versions of them.  Looks a bit cleaner then:

	#ifdef KVM_READONLY_MEM
	static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
	{
		return true;
	}
	#else
	static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
	{
		return false;
	}
	#endif

However, both versions are fine with me.

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>

