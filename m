Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A3284690;
	Mon,  8 Jun 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923057; cv=none; b=IS/jCcD6zPJDAavyeX49RqEAdWIGUGe9WozBn6Xt127Pev1WVFXxRKfeGrr8omxN7ZCv5tEIzeu5z9d0ppToHby06Q7c75o2tCsROz6zp0eKdpno6vwBsI/4hdeteToptJTSUHeu1JYWVIg/lrdgTTsaZEuj0HicQPGG4vVX5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923057; c=relaxed/simple;
	bh=PsIRRJ314r3nWXDyPu4M8va7+RWvCQe4yEsdnUd0Q7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB+hoAWOWFlgkVc+VO18MrSxMNDDXaEb7ARtTJBPstcQV7QEx3NdSDRiKXBA79WUZEk6PF5QysbB7tr5N9yvdcD6ZMhNKfXZFs5Jrh6W2OtWd8cZoci5aiRwi67RJTmn2+Xl9VEt9/VZGJpX9V/Z59FZV7lIfUazCTXOdKnDXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dCwyBbB0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dCwyBbB0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A64BP1792941;
	Mon, 8 Jun 2026 12:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pRB2baztrc+xU5nuWjei8PVhfZMuKQ
	P3SBFwaiOZvjI=; b=dCwyBbB0PgmqIeF70gkVG0EaXYrvyAPhP8lA6a9VEltGHv
	1mVJQQxMAexUigQEk9JGBtI+Grdr+akUWmTYAeAjCc8lwgr83yiFi0YtNoN+Zu9f
	mG9ieVovDvTPr0y3a1mN6SDvd8XXtYZ52waiDBbnAphlPJvgcLhihIdiO6ASHoTA
	90mmWaks031PaanTQI/p4f5VzfJTvwFDGrsaMhZQv3fW6qy4X/rd8cJI7KF3spHD
	WBCq+MUXXJ7dww/aFQT/59w0jclTdNBvwCxCm/FHI/ox83N7Xn7mFQbljdu5Yyao
	7hj6NLhDODEiJB+ohBqwpFIV27Hj2JXAAp270hCQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb9579r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:50:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CngHU019243;
	Mon, 8 Jun 2026 12:50:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fw4tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 12:50:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658Cons211141416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 12:50:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974D120043;
	Mon,  8 Jun 2026 12:50:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2F520040;
	Mon,  8 Jun 2026 12:50:49 +0000 (GMT)
Received: from osiris (unknown [9.87.136.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 12:50:48 +0000 (GMT)
Date: Mon, 8 Jun 2026 14:50:47 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v1 1/3] KVM: s390: Add module parameter to fence 2G
 hugepages
Message-ID: <20260608125047.100035-D-seiden@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
 <20260603154758.234768-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603154758.234768-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26baad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=qgyBxlh6lKsN7wi8v48A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: C4Qbj3WNAxmt-TFjTCoI7KryeiDteasy
X-Proofpoint-GUID: C4Qbj3WNAxmt-TFjTCoI7KryeiDteasy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfX8XkLSIJSPsHC
 aQe8OttxCfAsFQuP2nCK8ZdJuE4ALEm7gangZAwkvNG07CGBxLWtL51xG8HmLkWR9v95EHnin1F
 Dz+PlSEt84PTEe/Hh9pSjPXU1ARnnsBdeCsYZOaWgY5e4j7LfNrvZZPcx7/EwZuFxFRejcKNmRm
 DoYGBCtvOxtSQifLn317v9Q1yN8chkdJOJRIcfOP0YtdsDMLvUc2JdwZVJ/jmXoE1JsMWBz2GT3
 gl04tH5fWxZuee0a65FzId13j3wxYJr+89NAmIyqNofxlxNh6jd/8NHrj4QiT1TmGAX0fPn2eeH
 zNHwZvCFyL14BPCo0dgtbN3y9dzo6YpZQmdQq4ExUxxcyAWgaOSsfUrYPtnMJvMtwka+LhxJWiY
 RTAn+pyLXV6lftWAwkQBzjtSpRL3UBQ1zf8LcY7cliLl9puU4r7AiiXRFKTFB8TVGsrVKI6YeU1
 B/pKUi/AMcmaqeBdPwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

On Wed, Jun 03, 2026 at 05:47:56PM +0200, Claudio Imbrenda wrote:
> Add the hpage_2g module parameter to KVM to allow enabling or disabling
> 2G hugepages in KVM.
> 
> If hpage_2g is enabled but hpage is not enabled, print a message and
> disable hpage_2g.
> 
> Opportunistically fix the comment for the hpage module parameter.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

