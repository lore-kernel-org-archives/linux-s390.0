Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC5257854;
	Mon,  8 Jun 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923112; cv=none; b=FCSKBGzjHVIaUiyGD5wW8cPwxWfHRfMaptN7kdczGOk7cjTfo2qImJpobtRTPLUUX5q7VeZIzyGnxvivt1OKt+tjE7vuXANnW47rCajjcJGGp0RDarsKhJx2DDFJpSKon0f11Ht/vx0Z/6kBxq6CQSdQbyVttpIgttQHYn4UOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923112; c=relaxed/simple;
	bh=u1CzFjvzheqjTXz9+KZ77QezkTAm2WXMlbTC8/5IuBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhmo+3yE3W61m1QBHUcMc7vgFM1NJ01DdGP41nYP/BysEuXayeTvZIJzPP8kQhSqBeiloGav8hhxOdmmWJCHvhl/ff+Zo0nMOLBW0flIPaMbAr01+p7ls1s1VHK54dEuPANvFFFYKTtDJbKIGTUq7RhiW135NvygHejSPTlB0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AAmJB2+T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AAmJB2+T"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588Ue3a1477263;
	Mon, 8 Jun 2026 12:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PLXfDt7T7YcIUB/eDzckWx5Gh73dcp
	PG9FTLJ5Yt6vs=; b=AAmJB2+T6odUOZeH4r+1Wz413B4CVm0IV2Sdh7lQ1flCBx
	gCSccQYEjtMyWHDVjrCsOrMtMpVo341Avm4QQ0BmFtqVjm9KsyWMaZwbUu7BwZGd
	ctzIWj+mPOmBINa9onmngxGHYAyXMpqYypKREQakOX85vzryWO5R/zYNsVYnD53K
	50qvGq8s2OuleF9IoOcULA6Up3ABzaeA9F3wB7qYItoa51y7yJHcjCE2RfX5KLG1
	IbKvM1jtDtaYBaijwjwAlcnAAcYFmbVQTBbSHFOqoA9eVwJoFE7puJfeWnOucrKg
	dIS7Bgct/GdVIe/wXvSZYA4cUGf3rNbehC4bX4wQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qf9kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:51:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CnmY3019298;
	Mon, 8 Jun 2026 12:51:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fw4we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:51:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658CpiO446792988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 12:51:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3A432004B;
	Mon,  8 Jun 2026 12:51:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58A3C20043;
	Mon,  8 Jun 2026 12:51:44 +0000 (GMT)
Received: from osiris (unknown [9.87.136.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 12:51:44 +0000 (GMT)
Date: Mon, 8 Jun 2026 14:51:42 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v1 2/3] KVM: s390: Add capability to support 2G hugepages
Message-ID: <20260608125142.100035-E-seiden@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
 <20260603154758.234768-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603154758.234768-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a26bae5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4-Kizkfy_kV8THoGgC0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Z9a0eGC7JfXKZw9qN3yIEQPfuY3YznoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfX39sicRsMCSpq
 QJ0rDLQqB+gqVi7wpIrdMAdOE2em0dLcOndmyKM1vCXhUz6oXs8fob6fm6dhfKnnxdCQlGBUYFh
 7gIOqwg1fHdn3Be1/k2q3w8Fy4vpGEtAiHo2rW3cLkKLs0W6mBsZNa4gCwe5PMAPbsdPMKdmY+j
 s0gGIs8JkJ5kx8Rghww+Y6EAvwZTb92sRot7SNEuFFOJc9LYPwZT/uofDta9Vg5DyO+HAGX6fnp
 bjspKONkkeZJj1zXUhK0YmOCB16WFvipKl5e2vWyNgG6mKl+c/zIwK/JxCtE5cnF6orxpHu6d+7
 wTqCuOc4gHFbv2mXU9KLTBuhxT46QIRRoa2qRna7zT/+yPJAKfWwY6SPvajP5q9oTUGwBysgdKc
 0liqmU2IbXHGPzFxzEHd6MLp2T00+gI6wcqdWYpDY5Ld7U9AaOxBkrV+6Up9MtIMbra5CEETprg
 HtW8eI9rF/jWMByZ6iQ==
X-Proofpoint-ORIG-GUID: Z9a0eGC7JfXKZw9qN3yIEQPfuY3YznoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

On Wed, Jun 03, 2026 at 05:47:57PM +0200, Claudio Imbrenda wrote:
> Add KVM_CAP_S390_HPAGE_2G to signal to userspace that 2G hugepages may
> be used to back the guest; restrictions apply similar to 1M hugepages.
> 
> Enable the (for now still ignored) GMAP_FLAG_ALLOW_HPAGE_2G flag for
> the guest gmap, and propagate / disable it as necessary.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

