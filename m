Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23C49CF43;
	Thu, 24 Sep 2026 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264082; cv=none; b=ASxlUMl+d9F6jY6g/vOilFQPK4gtytMlL4es89Ih4mkgIjvyHsNNcG8DmNh9Dw2vh59oTs0fRjGu+2Eg0V/+Imu5/QHBg0r4tWd3JTMNRnLDmXo8XVCk1G8zj8Sqc+AeV1wsqPl6KF+7ibJd8vJ7CZTAF1cLoMuUXcfElCFHd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264082; c=relaxed/simple;
	bh=jtDDR78yFCnq7BJCNIIRQDGCLO6ILRCjwCtG1+ipeXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0V7o0VeZ7d4SE5eYkpG/7fbNsphHKptfc19vUgTG5XRDQwAm0mWND6O7pu0CEj/b57XU6+ZZtzViU+JmfUOjQcMCaf1d+4ChvpL3wpAMAw7CSCOb5V8zFCMxgkbiLf8Ie4C0rujFfaZDgC8UhP3zuTQPdsngIjqTUTvN2mVIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZmxrjKpa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZmxrjKpa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC63oZ2182993;
	Thu, 24 Sep 2026 15:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=zQwiC1rr/iZS3pUgS3nvzJG
	5o7U7AxEOja/dQdipRQ4=; b=ZmxrjKpaZZ5cSjzj6+JXoOL/C3I4BTtoZE1Z8Wf
	zvncdRFjA784bst5MdxZfLOu+GOJ2PCF552ZEPoqLXaPfM2R3iQHlY2EVOVT/2NF
	OS7bmBgzzJFjT4+1WQj9DSyhJJZl6usbzUGhjfLvtMCmSWOKTlTk2HO3e6l5a+qw
	NEZA3shyNuhkFWzPFNv98JD4YbbdneZk+soTwTDt6/sDD62/6a29zJdigY/8eLsx
	ILl5WnCnK66+xKzxXAZjsPkit0oPQ0yvMCfG++bZihMUzR2CWBwkCIb4ltDe4rNb
	EW3VL4qDxfuiOXJekqYA1TkXRya/h0sm5GmmRZXekwyZm1w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshy73-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:34:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OENoXu2232394;
	Thu, 24 Sep 2026 15:34:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1xfb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:34:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFYZou49479956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:34:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14682004E;
	Thu, 24 Sep 2026 15:34:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E01E920043;
	Thu, 24 Sep 2026 15:34:34 +0000 (GMT)
Received: from vela (unknown [9.224.91.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 15:34:34 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1x9lT0-00000009JUc-1ZpC;
	Thu, 24 Sep 2026 17:34:34 +0200
Date: Thu, 24 Sep 2026 17:34:34 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: Re: [PATCH v3 1/2] s390/sclp: Introduce dedicated sclp-vt220 event
 buffer type
Message-ID: <arVDCgrUgyuhcMMT@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
 <20260924104732.1978942-2-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924104732.1978942-2-maxbr@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab54310 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=g-W4tdL3nUwao7W2q5kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: GGFec7rR24sXwrPUP6OA5A69Z0AOiDQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX5peO1GNJ4wtZ
 iZMNMzbDbbffyhHxxiZvcsuHObJ601uVBMZL44YlNiwYuFgaDoMAPagfmn1zS6wIu6tnMsqsKig
 mmdL7kYBnNK/8J/Si3Fvo4A6j5AiRUyOy/QQRW6s8exXlAZ63O9EX1+kjFwftiPO5YlwMWxXiyD
 meVsgP7j5YrV2MPIwianAiYGiQNmAC+qYnqXlCPgr+fniqIdAA8WtLBvsHT8rr0SE0zoS7Lvv5r
 lDHeCECEBFynqx5IQ+zR1tvJLE0lFkkNoec7gevUpolnTLVJq1t4BEurwcl13ePegBJo0NdSJf0
 bsS9TvMF2BxOiVakZnjUfFIj141ut02qacinYT9SWUgYQOm5L9vhSP8Nt7JayJnlREZE7jy/0p2
 l3sgTzvwjVvEuESNCaN1rnycM9MA3+gLRlqd63SwX+M/uouJibTXP4ZehZ6QABKAxP9WYQDj9gt
 mRI44ssxr7o06QAL5Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX9cfd4HDhfVcg
 /eijgzvJWvjeFIPA2KkaBrF0a2Exd3g4X62WxEIEBYK8X8YvYZxYfOteQ2acwTkjA8WYq2oKeqk
 n5KI64UalMSNQ20uo6zPlp9WkMYjkGI=
X-Proofpoint-GUID: A5vGivWA1Gpr-CL4Icz6iCSKdCiCMIcu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240062

On Thu, Sep 24, 2026 at 12:47:31PM +0200, Maximilian Immanuel Brandtner wrote:
> Introduce sclp-vt220 event buffer type to replace the
> byte-manipulation behavior in the receiver function with well defined
> primitives.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
