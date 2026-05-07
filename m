Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F333381B14;
	Thu,  7 May 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143271; cv=none; b=RcXtZ+f0FswJGlMBv+Wui7C/3FaaFBm6x8aMDXBaiPfYx2WMmTXP+d+J8Hwj+IqrtYN5IOU+ImEqNEJghMQwD4sbmE7GDrAEM2LxqlonBcW6+vOxa36ptVG0F6yaJI6585ErzeDo4zWEb+jhHTvn75ynRIH6A+1oinarPGEoGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143271; c=relaxed/simple;
	bh=GAerK1Sn4wTmldG5s/xKDzPVY8/DOM8oufmMMEyq56I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=Leg94Ec5XLLXAIcogw8Ies8Mhb2C10FPTZqWUoZTZqYpWdZDCFc0LAm7m+vI84T1uxYiSEWb2aVVAnnrtYULihdi+AVJMS9mvhmCVrV/ByhVyWB//sdWld1YvZNjqUhTS8+EcUGcGzllo/nmmOVojMRsRNAS94W7lEHfqXnswyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCLmZQO0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCLmZQO0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64712OE4068020;
	Thu, 7 May 2026 08:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BMzUfP
	bRhl1L5me+172xqOeg6RAOPqWKMUH/EFcLCv0=; b=eCLmZQO0L9dX7iMV2DjqJz
	hnFjF5irgRDaSwOD5IzBUrp9oI7VmHHmwCU/divSP/sIItUCUubwSBwIrYRIcjkM
	sD3qS+RLlVzIa+7Q+7CsA3AIVuET7atesGuXrqat+r2PHTO4CF0P9ISZKssdCMwF
	GOjzSK97VmIIU+yJZh8axJyawArzDQH1pc/gik/+4W0e6vZY1Q015TVm5jZFpyjJ
	acmMTHpgtd8XxHxuzuD5f/pgJ1gxWgmSz+kKhrj9j8VKIZgE3e1tHBLHME6yVsnU
	ad9fXG8ju5UR5JF9v8t8+VeXfqbq687SOaTANKOypo/vc263pJofe7zxES/1wQ2Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1n2kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 08:41:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6478dSS9032476;
	Thu, 7 May 2026 08:41:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgj1jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 08:40:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6478eugK15466786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 08:40:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0777A2004B;
	Thu,  7 May 2026 08:40:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E71E720040;
	Thu,  7 May 2026 08:40:55 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 08:40:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 10:40:50 +0200
Message-Id: <DICB6CAPDAAJ.3QMED51RIB4HD@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <borntraeger@de.ibm.com>, <frankja@linux.ibm.com>, <david@kernel.org>,
        <seiden@linux.ibm.com>, <nrb@linux.ibm.com>,
        <schlameuss@linux.ibm.com>, <gra@linux.ibm.com>
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] KVM: s390: vsie: Fix memory leak when
 unshadowing
X-Mailer: aerc 0.21.0
References: <20260506141159.154240-1-imbrenda@linux.ibm.com>
 <20260506141159.154240-2-imbrenda@linux.ibm.com>
In-Reply-To: <20260506141159.154240-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fGvn8_zx_A-Wx4rnw92nJgHcUUp8tf-W
X-Proofpoint-GUID: fGvn8_zx_A-Wx4rnw92nJgHcUUp8tf-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4NCBTYWx0ZWRfX+Yyvzw/fWsnV
 2BHkVU4vVzfkBJ1m8Em2nTcZnz1OR73pN+CzPBVcX4jPCWuJ9YXMWY71rWbIt1c2WvV6UcG7lES
 j+CzyDj31FNYo108uB7AWV5wDZWe/GvLZ2BXJdvrFJ3k9+OK72YtfbA5jCxiocgQkzP0sFkDfK0
 WQnqlqkT5eLq9fsAGwFCBIQboCgIhSAMteNTatOrbPUG0mmfmAvCJNlkGus/7J+GoLO1Xhw3nqQ
 rzjQENQry6TIaH6MAHiPo1z/F4moetmxVe2SJz+bZZ2Euc8LE3Oc/Aizc/rBmkTs3zA4OzW5JTa
 oRgj8Tfi+3e38rnUgExMlzW/RASmVhcdiIFc78PCfWReXo3X9sdarmh9tK5MffJSMJ6VyNTfL9m
 e48iPfQvJg2ZTw6hLeCZPJEvlMgR0ca+1l1LInGN8bTsD2lsihLcsQuBPEIGXyPQ18J5Th7YTBl
 SnD/8Qo9gxH62wq9GmQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc501c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=9Rc5r0Z5LtCysjqJbOMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070084

On Wed May 6, 2026 at 4:11 PM CEST, Claudio Imbrenda wrote:
> When performing a partial unshadowing, the rmap was being leaked.
>
> Add the missing kfree().
>
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

> ---
>  arch/s390/kvm/gmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 3c26e35af0ef..fd1927761980 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1143,8 +1143,10 @@ void _gmap_handle_vsie_unshadow_event(struct gmap =
*parent, gfn_t gfn)
>  		}
>  		scoped_guard(spinlock, &sg->host_to_rmap_lock)
>  			head =3D radix_tree_delete(&sg->host_to_rmap, gfn);
> -		gmap_for_each_rmap_safe(rmap, rnext, head)
> +		gmap_for_each_rmap_safe(rmap, rnext, head) {
>  			gmap_unshadow_level(sg, rmap->r_gfn, rmap->level);
> +			kfree(rmap);
> +		}
>  	}
>  }
> =20

