Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2F2D0C92
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790952803; cv=none; b=IqPDQ/D9MuvB60/XpK+UcuusTBbYCtED09WmuAYAb/uiK6xWwBNV+4+QYGzsBBqF8b7lUvalGh1na7sUQA9bf8ibfrm9FydCqcYyGeRUCLHOk4eW+8TmtscOr/yhxDPxVshOqcPP4d7rs99cGrgKKE2PFxyg8zYbjnSxS8M1pO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790952803; c=relaxed/simple;
	bh=gFlVFofppIxGY2EmMpQEQ7yBdjGOwjicRsdLI/9yuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2zpZja3aBeuXppCiCzyMrCph1OfEbvaqEWyBQf8BI+jEEzt7khkJBPIBQFoE7FdSMrKjuuXyQ3h3hDye5NrVLTCETB6k8TgYxdTDSUZtMWycje+ijhC5HXPQVoce5q1c9X799nq96+BdWP/oJ9L0A9zdKVkPEMTCmNQf+E+k08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b8R3a48P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b8R3a48P"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DZg383590316
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 14:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wjGS2nC4UQgyaY+Euv4gEGLoNDjBnZ
	GRNmAJmjTxWzI=; b=b8R3a48P1sg/G58ZmDWXTMFEkCpnf/iJN1LHy1b/dkI/Xt
	JxaPC39AyNjNmF6/Leqm92znYt+z0fbwlVBd381ls8B3RqNUepcYtUgYV94AwasD
	u9pd6vzPfSjpGAG0vNcC+zXn67LHyf4W/Z4Z5zySaxQzOQz87W9e5dIVwl+QtHbF
	ZfGZ+Sf3U6ZPO6Wz52QvGwZqU1de91j27jD95SXYOhQOg3aReydMiRxqZCqOkpUO
	uw2NYh9l7GvLU/pbSuYMTgTYty4ECEa/KwpDDeC9KZg0QDvOoLU7T6kv2m6hMwy0
	x7XYeu/qx3RtTkyoVx1u1oItkv2OSV8cv3meQYMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fereek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 14:53:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692DHrE12540504
	for <linux-s390@vger.kernel.org>; Fri, 2 Oct 2026 14:53:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dk4kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 02 Oct 2026 14:53:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692ErGBn29098414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 14:53:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EFA20049;
	Fri,  2 Oct 2026 14:53:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D54220040;
	Fri,  2 Oct 2026 14:53:16 +0000 (GMT)
Received: from osiris (unknown [9.111.12.77])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Oct 2026 14:53:16 +0000 (GMT)
Date: Fri, 2 Oct 2026 16:53:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 0/1] Fix and improve zcrypt reply message checks
Message-ID: <20261002145315.21787Dcc-hca@linux.ibm.com>
References: <20261002105236.52049-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002105236.52049-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfc561 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=hHeMrJxawUSDLfyRwbMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1OCBTYWx0ZWRfX5ONvn6jQ+h/o
 CSzx0ptP7jshC0jMCVwi2RRI+aDtNB6aL16LNe3rDoZhqza452R2Ad2p+GkLp1r5ve2/Cq4u9em
 7ZkBzbSJx7kOxYvZPv72eCOT/3cG1jA=
X-Proofpoint-ORIG-GUID: csejHx6phhUP7gWIAefHiMYIVeg2s_Cz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1OCBTYWx0ZWRfXzxxCC83EsqS3
 pEk+z5sHWzopcZPP8rCAAe1C9CHRHXmXlTslHtU9CC0jn5dobB/glRP0A2i6763ag9dRp5qtmfG
 VOomGy5gQTlSjeWd4o70Fufe2aVKN2xZ1Ib9ONa1gA5LKSHz8IoXvcq0+SRV27nxdoImkoIo5Se
 Jceg5SSB568QnliiGzFzXUNCRiOtFhwe6CzAEAcCgEqwQA0uTOUXW3d56tAVWohVaQ1BxQikb8U
 IA+lWBjO1YivRSf3UPXvqNLI/qej3zCP682CiqwEMPvETO90i4vmWo4SD2/jLipCYfQLUJe+a9u
 gVorO3yZXE7WoAdbyaCaE5Ig9+EVXXpz53nfv0uXcp7iCe4Zy6vvE7o4o0zs16GR0hisWq6m1kn
 VbYBh1BgVc/Gcs1Z+9IBVbskzWzobSybB0vST0KVDYS95aQ7OzddBR5Yz+o4yYbORTRpRRuPCTO
 v5cge78zPkxpUzcz8gQ==
X-Proofpoint-GUID: csejHx6phhUP7gWIAefHiMYIVeg2s_Cz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020058

On Fri, Oct 02, 2026 at 12:52:35PM +0200, Harald Freudenberger wrote:
> Fix and improve zcrypt reply messages checks of type 6 - CCA and EP11
> - and type 50 - ICA.
...
> Harald Freudenberger (1):
>   s390/zcrypt: Fix and improve zcrypt reply message verification checks
> 
>  drivers/s390/crypto/zcrypt_msgtype50.c |  95 ++++++++----
>  drivers/s390/crypto/zcrypt_msgtype6.c  | 202 ++++++++++++++++++-------
>  2 files changed, 218 insertions(+), 79 deletions(-)

Applied, thanks!
