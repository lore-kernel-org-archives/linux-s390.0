Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197851D7E41;
	Wed,  1 Apr 2026 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775065924; cv=none; b=h8F2n5qiFIhxqn890emlGJ7E1ysiGPPOq5lBWCcnZ3SjH4RjeOU+GxdLj0Wx9EwdSfEDl+ZTqiYpO5Baq7BvgZ2pp+v4nHoMgGTiao57L+WWZJuX2AT2YFHxvqbdH9WlX7csLe2JWSDFXBaVm5TSM5sSrzei86hWDgEOl3gy52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775065924; c=relaxed/simple;
	bh=Z7OtGW0OcP6COrQsj+sMjxEVnUFPSJFpJBVxO3Oqqak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d11xMG6d/kYBh8xLYbeAY0URJzCnad2AZXuy9HFks9A5GZRBSjBsSTCG8pAiAZtpLXJvFhq881J7t8jbEO6lMPVi2gOx3CjrLgKC2wDSoWhtTy6RPv6wWcjQPp8NHEL0EckAD05f7xEXndBG1XEhggoN8pms59yzuAIIVpruIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vb4w8y3T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vb4w8y3T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6318MDhq3435060;
	Wed, 1 Apr 2026 17:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=rjnKA/ygAYM8RRgVpD3jFK1
	aW/rdBPc7dS+ZR7d8DGI=; b=Vb4w8y3TiYIRuKLBjHN4S1+Mt8GU0j8/yZ0l6Ng
	4u71Shnv3WcRkMbGFY+QQL39Zqbop/nuX+Mr7Uj3fDgBaE96Ld2OStqAJcrhQbIa
	SJybnxjarp10406J69rmmXxpw9x+SWD1h3W/aapcP5VttGEfYYGBT6TdAtrlvhyH
	7NqiHlvNkSsHxZKo5YxZflb+aMbmuVazA+mlz+Iawz5TJesbXZkJxqIbc3JnSkvG
	ovPmTwJ9JHXSQ/jKddPNpxprjHtKBzFkJ90HlbToTHkuZbyQ3BVH51+nbPY1SyMj
	5DAsomHMOCyog73wy4RsQ14Zut62uN+TKpsXQr8mtcap4rQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcgsht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:51:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631GFgen008732;
	Wed, 1 Apr 2026 17:51:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11pjtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 17:51:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Hprsk56623390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:51:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E9320043;
	Wed,  1 Apr 2026 17:51:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA10C20040;
	Wed,  1 Apr 2026 17:51:52 +0000 (GMT)
Received: from vela (unknown [9.111.87.118])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 Apr 2026 17:51:52 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1w7zjM-00000002T03-0phi;
	Wed, 01 Apr 2026 19:51:52 +0200
Date: Wed, 1 Apr 2026 19:51:52 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: s390: vsie: Accommodate ESA prefix pages
Message-ID: <ac1bOMm2QsE1z1WM@linux.ibm.com>
References: <20260401151221.2272408-1-farman@linux.ibm.com>
 <20260401151221.2272408-4-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401151221.2272408-4-farman@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cd5b3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YQLdh9iJH_ubtHatsGwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ove0_gdI9NS7iy6D2PHCM30a5yLOPIed
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE2NyBTYWx0ZWRfX9/0DI17A/9s8
 S+7czFn/p9mRwLzwY0G4YFtn/++KrOZRO6L4Q+hiMI3J6ggplZATIli2LvJPzaOISYyldKbCmd1
 NsKWLBwRuqhJl9QveOhk2Jr6ylDMMvQDLxCufHs2Qb7Bt8tjSqvZoF8IlqaCXqZ3n9cgYq6mRt+
 HJTvUX3DNyO3QEG+b3InIRxb8IWOaAPyfygxoIhY0VVlgtKfdFhgkc4W3Z1uOK1iuEo7jFpdZbT
 EF9eu+l7r8H7Iz5AxD45bdEXnBFFiOftza20n9uSNEOJElb3qSq9hRcQ/+T0DU9ylNt0z5lP/nU
 mxjmmrxakDvvR5ACEvyTiNLalQSwhrlkSy0Zd3sXmAGQmHFfjAcrgqlXDZZsufzXUx/ISXsCGwW
 IsH5r0DIBhCkJQapLOmDB2dan0M+SYWgI3AiNfhCdmuckObYAoeo+D817GeTypl9KtZPwIxwwoY
 F0L7Q5OePJ2m9JR9FrA==
X-Proofpoint-ORIG-GUID: ove0_gdI9NS7iy6D2PHCM30a5yLOPIed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010167

On Wed, Apr 01, 2026 at 05:12:20PM +0200, Eric Farman wrote:
> The prefix page address occupies a different number
> of bits for z/Architecture versus ESA mode. Adjust the
> definition to cover both, and permit an ESA mode
> address within the nested codepath.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
