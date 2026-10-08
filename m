Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A5286A5
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482555; cv=none; b=h7DxcZ7TPTQW14p+sgPVcrsWYs0SPPO/gCHddJwRhvbpXTSYDRut3MYF5bacBsBOHQz3ABSOcYpPQgOBAJB+pHwup0H5RQJequx56y19KHLgJ0ZK6DbyphSgEk/c0JK0gdtsjnq/A6UyldY17jFbJF6MC1TEAsT1dDrmnjhwtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482555; c=relaxed/simple;
	bh=2yCdbLHPF5s/jUSokjRtm4xlfOFy+YQ24scJxvuLIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eszrGPcCANyjRvzGe+kKmQ1MFFtYtUGUwMEd29ws2qD8rsFDZu65CifIkL6PJEdfw/j98ENnYxKFRtGX2gEWMxPA6/ke3kW2oVeNyirMKz+iGBmOEFgCcfcKDimM4RMFBFOE44DvoJIit55dWaP2HEj/f3efcVDde/tZ9xMdEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZG7B57c3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZG7B57c3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZWWP2005101
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 18:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D+hCgzYaKzTBSMMLR+a686YcLX/cTx
	lBJ/QOxpnkMuY=; b=ZG7B57c39skRQT3adT1vpNPAYVrMSwlkKvcLI7su90vqVo
	b072cD3UQiNl2fgdIrKZgM62tzf65wXgHu8yIhUOgvNQ0czF9FPPpyQ13QqNxJOZ
	XnPzU2hvEIn4ZtXYUM0rQ4Zuv7F6JUhXFy9c+XjsDOaemaVBg748gZvj+aqIx7GI
	0ZwIJVF163rz6UkwEWWbnIyzaSumj07iyoHNOjXNfB0w/2tI/njpXC9z2twltkvc
	phzZSBedJSEdrOTio3GXMsc40Klzu8skEGR7KEEUHVSubDXtVmzr9tzT+ze1rOfx
	KW6RZ9LQiPMsNKi49FrUhace+pqoe96GX/SErk+g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvn9g8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 18:02:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWgcD2564528
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 18:02:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3tygkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 18:02:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698I2R5N41615708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 18:02:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7B620043;
	Thu,  8 Oct 2026 18:02:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 380382005A;
	Thu,  8 Oct 2026 18:02:27 +0000 (GMT)
Received: from osiris (unknown [9.111.70.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Oct 2026 18:02:27 +0000 (GMT)
Date: Thu, 8 Oct 2026 20:02:25 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] Fix minor LLM findings in zcrypt dd
Message-ID: <20261008180225.13419B26-hca@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006154603.9699-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k5dNwd_8c4g0muccIUdxJUFgnok-bYt4
X-Proofpoint-ORIG-GUID: k5dNwd_8c4g0muccIUdxJUFgnok-bYt4
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7dab8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=9B-mwgaxTEOMiV8FPvwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3MCBTYWx0ZWRfX2vg1FozS2T4J
 BLf6rouW6ybmMCRvwujRy/vPbPEcSaWYarNNuERA5FPOkWQHqQZ0A2KGgBs1u8/fVXvAmA/wPPK
 Eh9EAALAvMf9RShIzmQhCQzWsENPbCE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3MCBTYWx0ZWRfX8QPEsoJ3jt30
 29dEywI2EqVKr9ZFqT10MPoR4tPpXKKjOA11Na4uxRj5gyyNeN9fKHAgSpfH7MjGm8eiH413weY
 y5QBuwR6A06gShbjWdxDYFsTUV82GQLLWZH/lrecV0Cevzjh07k1NHQYLJnVxYV+JPbecIOWiBG
 38Zhmy9BXi9ViGO5hCDaao4feBs8DM4ZNWZMJqN9QJy09bmuVWYdS6Q3RuO/Q4ZeoQYohKDqoeH
 JCw5TZyILZmUoIaVfMEv5lW6RvXFt1w80kr7HNBJ6yVwAt2leV7CDq/pqqCS8UZ6bqSfEXI3oWT
 k43qVEi6Fh/AS4Ab3oZQLm9GQtqe6bYiebILH1m0BFKkpVt9JOb2ZY6Yb+GYK39MctyJ5yjOUQQ
 u2TdseM+1jq3ecPZvZ01X+LBS/Zlr8ed82CKc3yOikNENm24Wol0N7BOa+CPoc0fqHL+byiaaeH
 G24EUD9zzvCxcg1UjvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080070

On Tue, Oct 06, 2026 at 05:46:01PM +0200, Harald Freudenberger wrote:
> Fix some minor LLM findings related to the zcrypt device driver.
> 
> Changelog:
> v1: Two patches:
>     - The first patch fixes a gap related to speculative execution
>       with the domain index.
>     - The second patch fixes a length/pointer check with parsing the
>       FQ reply from a CCA card.
> v2: Fix a complain from Sashiko about silently dropping invalid
>     domains down to domain value 0. So now a explicit check makes
>     sure domain is either AUTOSEL_DOM or in range 0...255.
>     2nd patch unchanged.
> v3: Well this spectre thing points out to be really wired. So here is
>     again a rework claiming it shall protect against speculative
>     execution with respect to the domain value.
>     2nd patch unchanged.
> 
> Harald Freudenberger (2):
>   s390/zcrypt: Guard domain index uses against speculative bypass
>   s390/zcrypt: Fix out-of-bounds ptr advance in
>     cca_query_crypto_facility()
> 
>  drivers/s390/crypto/zcrypt_api.c     | 35 ++++++++++++++++++++--------
>  drivers/s390/crypto/zcrypt_ccamisc.c | 22 +++++++++++++++--
>  2 files changed, 45 insertions(+), 12 deletions(-)

Fixed typed reported by Holger, and applied. Thanks!
