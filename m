Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A93F1ABD
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189407; cv=none; b=AwqMdkhWn0f3eWDEY2Zu25dHxoGKteTzLazb44T5uklnL3a1k8TpVK4ZKPr2JqcF2t6X8fQOcvh26EcIOcFJReULCb8XiBQjrPrLxZI09DU1hV26Mv4E5owBDfbDU03xfheY5Rla6Ygyt+ys4L7dLAUSmK8+A0yOth1cDYp8xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189407; c=relaxed/simple;
	bh=wXV9tiqHK9svlzqYMdQrLtMWGCdH9WcGBP64pLMV7pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtwXuKdTuJOQL5MlWQVs19bJnvWbdsZ2ngSOk4ezg7Dpuz/HdmfEZLDfNLBM4zKeAs+F6y/gu0wauH3Ie/WsHKgYehyiu/lmrwXIlF9SuO20f7E0oFOOQSys41NIKuMu+dCND348bUbpYMRGr1JvrhrOGpx6NYN9/O5IEGhlxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XMuNABpb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XMuNABpb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515d4J3138243
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 08:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wXV9tiqHK9svlzqYMdQrLtMWGCdH9W
	cGBP64pLMV7pk=; b=XMuNABpb5C/AvkSxMnGtuvCVmSll9VmN+K1GkgSzwmbQns
	kAnGFqNcnKnwUOstESeBHLBGp9UHQ1+PWaYjJn5kzUrNliVEkll/HYwWN4jdV1i4
	UMjPcZp9I0p2+EZsE/PZZLVqjPayU70Wi+pFzu9YTz8w9kJSDp002/ImfmNwrskN
	L8v4rzQz3at/ymimhumzRIO0SZrPvpKztG4v5n9fB8i0Cw8VtLfSxkm1MSDP8c74
	rNfwUmiHluOWqH2FgS6rlQpgxBrTXVWdBw39Zgy0ImJhGNgOmT9vLE95L8q1jq2X
	y6PCq6d8uxWFH3iy3IL7Hkzm1OYtNv8p5aQX0qlw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jgvay-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 08:36:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956KQkT899486
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 08:36:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g4fck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 08:36:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958aemb47251764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:36:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC7120040;
	Mon,  5 Oct 2026 08:36:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5202C2004D;
	Mon,  5 Oct 2026 08:36:40 +0000 (GMT)
Received: from osiris (unknown [9.111.60.83])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 08:36:40 +0000 (GMT)
Date: Mon, 5 Oct 2026 10:36:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Fix and improve zcrypt reply message
 verification checks
Message-ID: <20261005083638.10967Af0-hca@linux.ibm.com>
References: <20261002105236.52049-1-freude@linux.ibm.com>
 <20261002105236.52049-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002105236.52049-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B-oFdFnr06hNZ15Bnj0ExUiV83l1Nuvr
X-Proofpoint-GUID: B-oFdFnr06hNZ15Bnj0ExUiV83l1Nuvr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfX9p6UJCDUE3QT
 BBE0vg9h0mNLp4l2yT4QsMPTulO0xqTdQZOxo9iT2g0KkX8yOi1dW041RTrLAEDsmkNYHIRe5Ed
 y2SurHgT1pxulRCRr75wqdAnq8Lt2IE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfX/W/QCCN/XQDe
 KpqfqBIlocceL7PVTvoEHLBq+COwZEB1GVZS6p9crANQ8xv+38fe8/OfR8aHgxreZzIsnsztMY2
 w0zxMaRpf9ndrv7vw6apXbtO2i56G/o/E1zOkEON2WMH5Ico4O/POA6zYthGuN0AikCqdRRVKY2
 qWChsVp+lZZ9WoOPCTbgj7BarcufD6yPQj9dUpgLN469m2YThWHdaSifvvXayBKwWsWoUeV4SIA
 99DdVnAE5W0SVx6C1xuIQMmnEVZZqKvwkHTY1bqLuG1nqR5YVuKI79w4iVoHpX45t5DDGfKaVj4
 4NfYIFOjmXTTPOEzG/r0HYGQ/SLiF4l62J0TYMxsCKuqNe8mYwJoBViq6dv4+miptRktemXwQXX
 YOXnM8iy89QtjuyNB+P6Od8Lwd9qmMnz4HggTVHcOw1bheCNskwZgVZkuvKglvW6FB3CUrnvBfd
 UqDCtInIvLd06lRq1oA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3619d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NtcSHcvc72_WwkcvX2YA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050034

On Fri, Oct 02, 2026 at 12:52:36PM +0200, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
...
> Fixes: 3b6245fd303f ("s390/zcrypt: Separate msgtype implementation from card modules.")

Fixed the commit id. The correct one is 5e55a488c87a.
