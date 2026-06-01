Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B537BE81;
	Mon,  1 Jun 2026 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298100; cv=none; b=Y45Q8hL+bzJhHxkS6jPtSc9vh9FG4aCFGD4mrZzQb801nL1p1vNTnx3WeQkJgndo16BmLsW0GJJ5jetXsELQc7jQpocD/8CFG+banOfxfZ2LpEXTKZ1iUVu2EWGu3iqnGv2EdNKKLaE/BbP2Xf8yiWkKzn+LBemgCTcTvOutnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298100; c=relaxed/simple;
	bh=OetURhH10sb3y50HgGnmJsGDCBNcO7MqNsTDRrTlafY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYHZEVw8Hiy0+1xO0Vw/ZHuz9OVuqvjyNUaW4315owckMrAo6IvLGlPB0uBJ2LplkerLwp4VbYAo30ZF1ocBT/wLhqUFWQJ8zgln05iLW2fOdbqOnJWLVMAjo+oTUuXNk24U4gKXR8UvGwQuwR7x+lO0pTqWBTbFWE0hKfy7BNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RhtvvuS2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RhtvvuS2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65134KhN1175050;
	Mon, 1 Jun 2026 07:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Yt21wTELBTN09Z5N8++7i78HI0X9/v
	tw9x/nZdIOhtA=; b=RhtvvuS24PYLACIok3b1FkFtulBuzw5kObyWnx7BR2Ssht
	elSGAjAOIIDLYLvg+XowkIgTjujxIUsAM604/31BmK6OxmIC/gdi5XxkwpFP5s4T
	Vl6K6Gl3e9SMRMwBumUebVD9lqpAX8Hm9jc2vK8qBy9Q6tbf0Y0FJ5XYwyjwIEd9
	Ts7SXkEZISRdtRcoqfkLNBWcYs9z+Byv+6cX9rWoK5bpFzWhsfSyk5QjYhZewXv4
	C9y9Bp6GNhTRDnN/Oc1AjARGOpvDAkKSp1b/TlJsxwmzmmMkxxhhfiRjQpmDj+4V
	cZIrJvZUBWQRNg9RkVVx4BPH3JGEbJLKttg+hmRw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhsy2uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:14:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6517947h012154;
	Mon, 1 Jun 2026 07:14:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q54nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 07:14:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6517Er8451839480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 07:14:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191E62004B;
	Mon,  1 Jun 2026 07:14:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F2720040;
	Mon,  1 Jun 2026 07:14:52 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.158.69])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 07:14:52 +0000 (GMT)
Date: Mon, 1 Jun 2026 09:14:51 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 2/7] s390/percpu: Add missing do { } while (0)
 constructs
Message-ID: <e00e60ac-b92d-46dd-90b5-cb145f5c137d-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qB39eU_D6VRonyYKH7aBEP9JUMNx628R
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1d3171 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=nAd_kLR8W2ubM5NhDlcA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3MCBTYWx0ZWRfXyXmeQ/QU3JGG
 Fe+Xd+D2QzJEw7vKAYIHUAQ0cd0lg6l43sEbeJ+I84a05NJwW5PCA+jSKTYiQnUHicnzSx82/3w
 JSs7PEdpRAAH3CU5lUXsyAPS6zRPD6BMKd6fq816U/Z4b8D1LM0dbuGs/dtsXvQbzeZ8VWfZ264
 mV3lREe67EtvsTg/a0O5G04vOhrA+1wC6cRUVmasCKYMFFsQUfcUMC6M5vT8v6otx+sX5T27hSj
 R2lqcgRqGNU7z6lD6quAldkdggxBJPiKQQZPIRywJuLscAHXxFIUn21I1/aPiatz+oQseix7oIS
 cv9nrdJD2PnBC62dJix0HxI93Kn+zra5bmsvOJId+kSEyOeOT73k8nsz6OyoHbguFOeL4WCkz4y
 skHOeKV6RKGgcwGu6rhqnpvElJVtY7SRkCkxUiRh7gMc+6ZATwVILrudJYx9R5DZDI13otnUOR4
 p1I4H2flpeYEtOd15Dg==
X-Proofpoint-ORIG-GUID: qB39eU_D6VRonyYKH7aBEP9JUMNx628R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010070

On Tue, May 26, 2026 at 07:56:57AM +0200, Heiko Carstens wrote:
> Add missing do { } while (0) constructs in order to avoid potential
> build failures.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca%40linux.ibm.com
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
