Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C3397E75
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852723; cv=none; b=gXrqiDGC5DMi47L/424GwuBx0TNWRYkivWJd1ah793SHZR13wv1jHSQtxzPMBAnIC5nS4EZMYuUTvt5+Yi/mOtxCA0mNGPEXJyWlW+Ot7weqY07oX8ZUtRA/MdwWPdO2FfFwxXeDD9kv3E2DXkNG76iP9ekjbQnH6i98qhveD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852723; c=relaxed/simple;
	bh=36N/6c6mh2LPtKDK11aGmDuvff02ZD6z/uarPjtNhjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvX3c4E5bq8xwWMibRifBj9d2tlNLZtLI+WnuDgbgNexmtjQ2xAv1cLPSqqYrJcLrOP6uQlSA6VWERXdMOhATlgDkXrKaZudU9c+zgr12avkmvEcjHTWZGeXgMwLeyHOdDDt692Guv9fn76qCa4nb6eJVZbkx+GFRzzrDs4fZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ak+tq/l4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ak+tq/l4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VfWw3107144
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 07:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WRYLsEnxQ+oDQ10sGaKnHk8wnYWUjo
	WpPBh+oeJcCNk=; b=Ak+tq/l4V7QIMmrPFC4DRWEUUjonkDsCorCHAgoZWH7ECq
	W4MG6PRIiPCNGYlItDZHKKXLJpn7ZUSgU5O0VbQkwW8OOMqJZ3ugg2zcRwhNhcmj
	P6beLMg0j8UztRmpkHeyHWYBilPeysUaxHus04lhT0ZVrmRc3tIxExIthfkyQFmD
	sXOW+1gF98fbrTZU7HB8JfNstaYRm4wcrRw77yAatJu6yIuhSQEZ/FV7IvFtP7av
	RBcLqZJdNO9O/DIgI3mND93ixrxnGtRZlPCWHxc30yoHJYP6MF7Xm8XsTKHA45ET
	0qSi9hBK+c/rv9UAnZuB1SoKkgLb3h96g+aaSAPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrn2wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 07:32:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6887QE5L023870
	for <linux-s390@vger.kernel.org>; Tue, 8 Sep 2026 07:32:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03ya5km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2026 07:32:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6887VtFH44761592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 07:31:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04D12004D;
	Tue,  8 Sep 2026 07:31:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2C620049;
	Tue,  8 Sep 2026 07:31:55 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.94.215])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 07:31:55 +0000 (GMT)
Date: Tue, 8 Sep 2026 09:32:30 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, japo@linux.ibm.com
Subject: Re: [PATCH] s390/pai: Simplify pai_init() and always return -ENODEV
 on failure
Message-ID: <ap-6DueOPYJhCw3Q@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20260903081557.2023814-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903081557.2023814-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6a9fb9f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=x097g5zEZefxzsnpXnoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NyBTYWx0ZWRfX9XVB/9pIkh0g
 EziKVA1pgyTa1+zop/hPlj70SsB3pp4+zA1KSf/msOGN7Te9y8APapiOWpvQHTreCwE8pRecDuQ
 V8YxP5VsnV9e5RKVVfVkzRCI7hn0TXU=
X-Proofpoint-ORIG-GUID: KKoztnPEww0kLKDs7N_STdUsJ1v7TfpH
X-Proofpoint-GUID: KKoztnPEww0kLKDs7N_STdUsJ1v7TfpH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NyBTYWx0ZWRfX1Wlm0NZw4JSg
 mUrbb6t3t371Rje6xnkhOOrpbo0e0y0vVYXmXL0F54/j4ZJU18mDiCOpJ9n3masrMp5qJtI0/Ac
 nxCVD06oXtrKVG05siOvg+5cWceah3CfvQm5TGynuzO9UgnjUIa4ak16pi31WrOgAU4IKi67YsH
 VF+MNHQ3WL+hcfT2DxDK5Ip+OxfYMWNcV/6g3xpaF/lzYJKLe+/3cOxRxnnO2suJ4ZvnNjGBRU7
 WR/So9LK0+Yt4K5Y44BwnJA1mdt3fXYGRMEvXx9MVgEcSQXdteLmfjHZ98+3tngzXkD6FNH36F1
 IFr9QOajZwx7UrNHfsAfrwywTSaTDmvLRGp956+jA28c/AIzExnsYkdO4LFPiyBNn4wNooYX3zq
 gMXpk0Qpu0MazACvg3A4FtYljSeLLj1zky9WjVzwYsszvQDlsKoR9mcVUIxh0x0hmm2Twx5T5ZV
 MRk8MnvVtUfySwr7pKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080077

On Thu, Sep 03, 2026 at 10:15:57AM +0200, Thomas Richter wrote:
> Code simplification and remove variable state.
> Return -ENODEV in all failures to indicate the PAI PMUs are not
> available.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Looks good to me.

Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
