Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170633;
	b=DItnBXaRzxhNKm8pjtaQbNWcHdeT83ZjeQOBQOZhMZaRJloDeiyWdM6khoq+Qib6I7Br
	 caiF2zuge23EoyBJLqQQTV4l2yRhthas5usqUZfeKOx4qP1hJWWi1EZAy1kTibTTLgIHx
	 OXwHezqn3uEvbFZgqEpFeKYZv+Xx+QOzDgGXhSf8ikLHQ6CLgHQXHJLvl8aiPOzEHtTIT
	 dOqhzx3O+6vGdv3aRozlgMTCKKCyW0Z+8READhXbH7tFqfOsZ6pWlR4Ow5wkBaCtdzpAw
	 doUBufBuF694AKxglFfUSo5YV5YWcKlWF1qm5j0amk/Xf43IEe85r8SirE7QJ73YghA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170633;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hgal94A/jGJk/1J2gpAEmD8pKo91/DhLHIikk+sDg3Y=;
	b=HfzxpcLmUfS1oclY4BrW/g9QQyocMQ7udLqvB/o/kF8+K17yjMCyLZ+bdkxzqm7B8m4R
	 zXBAa5QziW68+FXCpraSng/JFoqqwjS3y9ewYOpvO9vqRXOUTyaptV6lNobfAffpLQshn
	 UX3e0m49QcOJgYs1TkarH9SVRsg12kdeyfJKwQKE/V9ESnimHE0k7hsh/MspTbdouqckB
	 lYuR+yJdxgK573Uh6criB9uxm7LFgNPgZtPFZgz57fThH1NecUe2m3grBQBvPwhP3E1SG
	 NY+FCUzzGqPQks6Jvh+e5pP3eP1T9IpIbObmWNXp21IlMb2txRXXr++jWSW0nxl1XPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NA66jB4L;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574E606A326;
	Fri, 20 Nov 2026 10:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D574E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NA66jB4L
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7ufeG2500613;
	Fri, 20 Nov 2026 10:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hgal94A/jGJk/1J2gpAEmD8pKo91/D
	hLHIikk+sDg3Y=; b=NA66jB4LCvOox9madDfTKyaW3NAQlqXxlYheeuKX3phi8m
	KfVTGF2QH5fkDbpyOiFCXJ1uoDzwv8B900IgvWRl7dGDZfMt4mb83FuiyitR3fA5
	A8SjmcZEXGPEB/JyCB3TXWvF5qv2U+YbftNZOUGLnbDtcJffm43ZcOeuaxYG5o6T
	Qk7IIbSQObAdMLYDK/AAFeXmus9kq2FVdQDmLdNLlV2x4Zq/LKghtYt/NFzK2Moz
	pdpWbPisYldVnQu+XJplNt/D53Anu5sPdIoXU5ONK0WAFELnU248Eu1kPTrpZ91g
	diQ0p+irsPKsNdNLWrj/OYdJDh5ubyVzjU6DTU+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tftrs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 10:30:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o1tl3920710;
	Fri, 20 Nov 2026 10:30:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xfgef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 10:30:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKAULRj45154706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 10:30:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25312004D;
	Fri, 20 Nov 2026 10:30:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F172004B;
	Fri, 20 Nov 2026 10:30:21 +0000 (GMT)
Received: from localhost (unknown [9.111.50.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 10:30:21 +0000 (GMT)
Date: Fri, 20 Nov 2026 11:30:21 +0100
From: Andreas Grapentin <gra@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 2/2] KVM: s390: make kvm_s390_vm_stop_migration() void
Message-ID: <awAd4tS_GQs-6-3m@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
 <20261120075345.116521-3-ggala@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120075345.116521-3-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6b002142 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=dtAwjpDLL64rN-4WsoEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: LOeXe_EHAJ1bvzLbArk9lF2K0fqbEpJm
X-Proofpoint-GUID: LOeXe_EHAJ1bvzLbArk9lF2K0fqbEpJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX5FZejVlXBZ/7
 lR/jCZ7j0zxG1+MT9YY+qxVtCz0WdcNyh7BMSHVFI7CK09nRLpnGn6GK65QyW28Iq5UXMiP4PFA
 52ihMVfix+bWc61JTdTWgleZ7Kv8hTo/+sZosiG8UukY7FrGfXJSjGB4ybG9T0LFHH2Z9b30ODr
 llkTiWX7r0fJFHnu15S1jxXpvqpbqzmJdZ+i+YCFr6ztGqg9e5xDR37OuCCH4ziPFO5pebJFmXr
 et1EGZmJzHQyj7hQRMHUf221NKdIKLCr9Qr7QYP388KDTZmW1J8h5bF1gY1NtdBQQmvZ8BISOJr
 oPP0IIPOLRgSKIhFa1FBtDbUahDZFT7t2nR8XgGT0IJap925c2T0Zek8ZWXOPir6as0XVLY/PfE
 bfUfK8BWXDmzwohqQzU6UR3kCxpqJSDJEAOhZGvGkMPmepX7hdBXgOQxNYJDHJUfNjB7YB0EDo2
 v4LF6BhX+OpFQlGiTMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfXz8OXCfeL8H57
 bjVill9ldgKM+NQjD94l4ElNITB2FTnsAxM27u3r6bi3pRAmjDQjXV9VzbGIgH0JndmGTfkII/k
 kgY2hj/pWWeB6ShpazFRzyoxwb6iOiE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200041

On Nov 20 26, Gautam Gala wrote:
> kvm_s390_vm_stop_migration() returns 0 on all paths; it cannot fail.
> Its caller in s390_kvm_mmu_prepare_memory_region() wraps it in
> WARN(), producing a condition that is always false. The arm64 stub
> returns -EINVAL but is unreachable because
> kvm_s390_is_migration_mode() returns false there.
> 
> Change the return type to void and drop the dead WARN(). The
> KVM_S390_VM_MIGRATION_STOP attribute handler sets its result to 0
> explicitly; userspace behavior is unchanged since stopping
> migration never failed.
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/arm64/arm.h    |  3 +--
>  arch/s390/kvm/gmap/kvm_mmu.c |  3 +--
>  arch/s390/kvm/s390/s390.c    | 10 +++++-----
>  arch/s390/kvm/s390/s390.h    |  2 +-
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
> index 760230685ca1..e60801e4a467 100644
> --- a/arch/s390/kvm/arm64/arm.h
> +++ b/arch/s390/kvm/arm64/arm.h
> @@ -50,9 +50,8 @@ static __always_inline void kvm_s390_update_cmma_dirty(struct kvm *kvm, const st
>  }
>  
>  /* should never be called */
> -static __always_inline int kvm_s390_vm_stop_migration(struct kvm *kvm)
> +static __always_inline void kvm_s390_vm_stop_migration(struct kvm *kvm)
>  {
> -	return -EINVAL;

should we maybe add something like BUILD_BUG_ON(1) here, so it doesn't
fail silently when the underlying assumption (will never be called
because kvm_s390_is_migration_mode() always return false) stops holding
for some reason?

BUILD_BUG_ON(1) won't fire if the compiler can prove the path is
never taken.

Beyond that, this change makes sense to me on the arm64 side.

Reviewed-by: Andreas Grapentin <gra@linux.ibm.com>
