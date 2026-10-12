Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F6E429825;
	Mon, 12 Oct 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817923; cv=none; b=HlAp26ufBg15ACzB4ipLKiFr6wns09KUbjYKINiSbDIjXeF1ObaZD/Bda3mOrDN23quePK03SacW/HNGOEZyO1F5eWwJoVXg73itBXgP9MVddOMX5u7C49/fnC/uF05+fEoKPU+uXMqdstWf4LuqKTts+xC9xbbvGOYWVQ8LKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817923; c=relaxed/simple;
	bh=oRfgy9k4TxaonwxH8hOt7A9XobFYc27xXwvq9gZ9s14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSntJJbbOiKrVsa0zAjoA40fKBEp0BmWuD0/Cn7qOSfa0rBvWrhFGy/bN0dy6ngWwAeTtWU2iFXfSnvoxCXS2QBAEqkPKHwMmBkpYtpgJvHrrXu9s3Y7FYZ3b5wZpRW9jrkVqXdH6/nIDN95C02UI6lY0ko2RKyPdCJ/nwp42Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cSwrE2zM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cSwrE2zM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEG353209755;
	Mon, 12 Oct 2026 15:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Fo766TBEEhER/+HFbU9cJTx+lSdUJE
	jo9NP44SRuhVk=; b=cSwrE2zMVpJq/sqXB3Ef2K86DZObICj65JT6ftjXtwjLBE
	Tw6HeNZdS5zA4R2+d84sVxfK/d55eOvWRtQ58phS+YFUm5oVT7LyqNFpmJ/1zqN+
	dAkQ7tqiTnQ602TRuKs6HIyWwxyXLClkdRTHMCUn6hV+QjmqJXqiULKVrtVpC0Vl
	Fd86+o4cBGqJTWeVms+ZKlwLLdk7uTooDaJ8Nes49rV5ZVJCQGQxWW+VNwp0fPgo
	d7/myHlDFwBEnINWyFwdFd+0VWOpFf28+1ksuz7k6QFKl+iFEEg0m8eg1s3524nq
	H0u1sZtQXnlXUWQ9nvwfAkdxYHD5uUtoczKkMh7g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv097vr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:12:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCJpsI1255384;
	Mon, 12 Oct 2026 15:12:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vnuds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 15:12:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CFBtxY25166512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 15:11:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D4420043;
	Mon, 12 Oct 2026 15:11:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C1920040;
	Mon, 12 Oct 2026 15:11:55 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 15:11:55 +0000 (GMT)
Date: Mon, 12 Oct 2026 17:11:54 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/percpu: Implement this_cpu_try_cmpxchg()
Message-ID: <d4cb1bff-4385-4f6e-bc3b-efcee388150d-agordeev@linux.ibm.com>
References: <20261012114249.2898572-1-hca@linux.ibm.com>
 <20261012114249.2898572-5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012114249.2898572-5-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX0/2iPTJuMqwf
 WqC+clYhJI4A0VArb+yS13EEoa+iXWjvg4wd+epCTkSDwto8LBDKxmh0hSOG4h2y6PLj+bnPLUs
 a3VZzwJFHWVpdOZmSE+AcWB/9SoQ0iYZntQimRMN0ngBHPCUK+48Eh0HTwemHcHBWyJQXKriy8Q
 8ZhUrKBS8ml2DXaSEzGizMP0AYRhnXKAAUSNvum+sdDRA3MG28P6gnHPb3QRtuoAj5czfZWAxbB
 lEUG62PJ3HmUMw7VTaSRpE24xT25hSWfkEDuZXAMuwWuGJerfXYr9RSWT5ygzUDkBNaWzvy6/In
 JXq48aUfX6doKokzLMxZ/99RIEuZkOos0MKyTUl1C8qrrSViza6BTNxJ7BrLQIPeWGBs0PjjaLU
 ygk+lKPhLHL38N3JoIK8/M0ZVefq9WguaDVqFwEQ8WoNC3nf2+zgAnD/xBJb4s3Kn8xEZ5RSake
 XQH144OdngN4rqlqOkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OCBTYWx0ZWRfX3i9oh8TBybl4
 17a8wP13vifkZ1Ob2D736PouWNYXcLOAa03MIphyl7ONquOtsu/ShmjOnLjhj0ZwaOgSozhDH1y
 vnPTPwsm+cZc3PQ2N9XSZ4NKAFoErjQ=
X-Proofpoint-ORIG-GUID: Vlvih-jVa1JJKEBuYmw6STT6Ji13hr7E
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accf8c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=edS78CHe_KV0HRbkxBwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Vlvih-jVa1JJKEBuYmw6STT6Ji13hr7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120058

On Mon, Oct 12, 2026 at 01:42:49PM +0200, Heiko Carstens wrote:
> Provide an s390 specific implementation of this_cpu_try_cmpxchg() for
> the four and eight byte cases, if the compiler supports flag output
> operands.
> 
> This variant uses the condition code set by cs/csg, which avoids a
> compare instruction required by the generic variant and generates
> slightly better code.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
