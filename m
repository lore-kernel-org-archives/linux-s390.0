Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F234BA24;
	Tue, 14 Jul 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036323; cv=none; b=cWiE0YxVBKCyb+kkid1jQkVu/PwtiGZBIYtyFRZMXpAFKbwvHphBdgwecL7xVAZCOKQmECf2fgUV4Kl2VEUrMKDrFB1PBULWsQL2SFt/zHshu7XhkVBvRd1Kbe1XftEcalAgwvfwjoHD3Yt7kMGfHocvsNMamkjqPE0duwcmLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036323; c=relaxed/simple;
	bh=fJl/0eKW+KSFaQLFY4XvEiHoyZ/Q5bO+HakwNhemsKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWsHof7bpselsekAXyaKxyLn0mCWTnEcDF2ZWdHMN+azMOj5DmRIQKuxLMuGCHSNCO+SPRlWROUgOCeXTyw7BkVFDqsbVX0maM2rN0hcx9FG5lxlKRvGHnGWBAXpqZqUVg43kOAJFNSauhSuSVqFij5cdIcNJ+TxdAupuDsfljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DKaFS7SV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DKaFS7SV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBfcjt1221946;
	Tue, 14 Jul 2026 13:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OCKERLGHK/zEznpeUz0BC6vdIDlCcw
	smCMGGk7KW200=; b=DKaFS7SVLWbYx/yNbO2T9QnCG5JsSq9BFYOp+/bfAiy0FJ
	GGQnCsCYr/daaaWcs/ooJd/s3opPhAsgslVGtjvToNbQPX070rR3ywiJQqhcqI46
	4A59EGzHXFswnpdpQPLaehaMFWbe37NDjntzX6v5pgw0fFP4oW9uZo/hWxpqjkbQ
	Ffe0YpblsnfQ9WV7365WbTo4TMskV1TvYDmJqfze80PegQpzbZJF+r5pgHNyV0qa
	7bcNEwBUJXqdf66YyYgWSMuyyRitpdeneQzcnShCBAkDw2I+FlIgWFWyaTNFm/mu
	+VkEc6v9CfMiZ6cPw0Aor1KtJ0R5L+PDjuUxa+lw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt6eq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:38:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EDYcCx016751;
	Tue, 14 Jul 2026 13:38:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhawym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 13:38:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EDcVhX49086864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:38:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE6052004D;
	Tue, 14 Jul 2026 13:38:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5709220040;
	Tue, 14 Jul 2026 13:38:31 +0000 (GMT)
Received: from osiris (unknown [9.87.141.23])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 13:38:31 +0000 (GMT)
Date: Tue, 14 Jul 2026 15:38:30 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] ptp: ptp_s390: Add missing facility check
Message-ID: <20260714133830.31731Cc0-hca@linux.ibm.com>
References: <20260714130342.1971700-1-svens@linux.ibm.com>
 <20260714130342.1971700-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130342.1971700-3-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DZKdOBkjO-pnUBs70zwFESP3umQtbtUr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNyBTYWx0ZWRfX9DS6GPx1Q/jO
 xMWA2tUep8Qy92Y5p7XPK9XZvWn7eZ8cxmE3vxAS1d/derYKkxXX2+5fvrlQ1KSTYRto0rL/oXI
 wkkbl7gnrE6UfN4J7ziRG1a3XYsENws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNyBTYWx0ZWRfX6NHWNciA2Nem
 1AsKGLYey93JB2L+Gm+1rVQiSSz9ssC7SrhZGyhJj8pAaGDhKl8MYAnTuenYxiKNALEnzV7WG/e
 alwiSIR/8t0DiTJ5EWMrqB6pPPG8x4/+RqhBLAdMBwb6HCDQyKPzHjf/SuAIvP9N2JwdFushipe
 GBpAroTfyst3u5vZYycOzjw2vpkM7A2sUYNq6cDf4d2PPWb4SMRw3bYu3iWWvjDu662uMtfhAde
 l9+RL+jCIQ8zAsyVNrKMrly9wA1ZDuvzCTCZEzrVaP8Fnm3l3iQHWf4ooTQVs4IW80FnDYuWGfM
 tbCBTzBJSETZmz+C+xmEk8GUQg4O1DdJiMXKdaQ9jtHJGQ95F+XJ3MEnGzinSjay8/DM1z5ow7N
 fCpiu6CE78586bia/PXmdDgXlEnxj/0T28+PhwI7rUxx4UhjAWasQY3iQA3z7pI8dTxCgd/j3/V
 dGmRqD9L9ybgYZ/Ieag==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a563bdd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=dp10CQQbREviSCg9LDUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: XE1hjGEQ_9bXaXl9WoNFKxFXfUExrINP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140137

On Tue, Jul 14, 2026 at 03:03:42PM +0200, Sven Schnelle wrote:
> Only register the physical clock when facility 28 is installed
> and PTFF QAF returns that PTFF QPT is available.
> 
> Fixes: 2d7de7a3010d ("s390/time: Add PtP driver")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Cc: stable@kernel.org
> ---
>  drivers/ptp/ptp_s390.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
