Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810143CE6F
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667871; cv=none; b=HGqHg7H0gTqLHj946Is5bPoXT//XuctYl/UbAGUYRXlLyPncgzje40kbSNleyZ01cIaH1R4r8bkM1JLQFkXQTgD10Zo3GlpRUAmMidIPLkbGYgE02B2MLuwx/oKXDiKSecY+X+tyA8Ug7szMGpE0+zAbQWUlXRDPbJXYlHlpqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667871; c=relaxed/simple;
	bh=HvJ6+E0R1nDPEZUvQS6Z4FYua3BguiHbjK4hT13q7zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0L3lk6FSD1s3Vm5Lw9mbdlVAJg+iq2cOi44Ea/PbFljmbK59+2LQmtF78zwzRQKLNRUg+Gp/7P5i2FVDelbzFuKjnR+jZUrHiYGPB+uF6lebgfxwPjiko8tcZWQtn7Av4YJsoJW8X8Mem20H0A5PJsMG/nPq2M9CHilCaZjMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lJowDFiY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lJowDFiY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PB1XZ92979219
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 14:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kcOR63
	iojJMEYAI0vEXREOXZfQ1LOaoPGLZUiQRKFQI=; b=lJowDFiYDRgiGsL3JyVrZf
	5sh5vISVQ11iCsh/AYxsSg1yvzrgeu2EkiRSUCOKDcOGhPsZJV2mFcrGBY6LZCZT
	nFRc8/8o/UaxLfBPa41gc3xyJIdQBinNWN5p3od95Z96qBuOTgg+c7iZGYabIAoF
	ZIjOlBm679yRD8VjDv2DbLuC2ve4TrBfLj+cKDb71Udksb6oCpWXZIpx11Oodfj6
	cvPhyIkgw5LlhfPSCt393UNX/QE0WAhgH5wNRSTmZABr4it1ww2aIhCSiBHF3Sct
	tHguN84CR1rax1YsM3aUUedMxwkgxrjD6DdDKXZuV7PQvV7amm3SFSSCS9w+lV+A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqrp01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 14:24:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PEBQ3J011832
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 14:24:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy4dpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 14:24:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PEON3f41550190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 14:24:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D55EF20043;
	Tue, 25 Aug 2026 14:24:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE2F20040;
	Tue, 25 Aug 2026 14:24:23 +0000 (GMT)
Received: from [9.111.133.205] (unknown [9.111.133.205])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 14:24:23 +0000 (GMT)
Message-ID: <6c4a796d-6555-4ebf-96f0-061fc1a97657@linux.ibm.com>
Date: Tue, 25 Aug 2026 16:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260807101918.31482-1-freude@linux.ibm.com>
 <20260807101918.31482-2-freude@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260807101918.31482-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YEOYL-h_Vpaf7BRJsIgJPbJzbuxTrXU8
X-Proofpoint-ORIG-GUID: YEOYL-h_Vpaf7BRJsIgJPbJzbuxTrXU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExOSBTYWx0ZWRfX1CsvQ5LxneCr
 g9soxqJQH4Tv3RqCzasDnUgxNDGAHC5lHweQ/hK3UBAImzYFllF1kdq53xa6Ol2QOJJsAZ5mKis
 mNzNsxFsIRVW90n3tuYZzTUaKJhOnS82Zy0orXgcBV3yj7EQUKcdA3YNvM/s8yOnhb1F7LaD5qt
 wXhv4F3B8AtKlsh395zJkn30kBha0hUoYDY66WPpRVXkf6lLeBZVBefalLXY7at8A1DbTp3+c+I
 0q2YlINaN8Uy5fbMgRUiqWQRMTUctsJTPj2q5uJkTstD6TITBSoqDmZWno46OnY1vDBsbDcunLM
 htMrun4iSXr/QESf8H3pOPKnDBgf3epRg+EZADNsfIVyS3dd79MiVRM3O2xulCv4nbuTWZzbthG
 zwPdGIjbKt4cQ4nwIN4drbZpnv49CoqikcJZ9JWWAZDscmB5vn1qsrwUHUqj7s2zgR+vEnkdIqT
 i66hKKoEqSk0mM+R4vg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8da59c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=zpjXwKxMKkLYiEg-dpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExOSBTYWx0ZWRfX+l6Z5E6lymLY
 TnhCwawPsfGF55u/816bCdVveaY2PENMMZ/nB4UZmcozvQHUta0UHjWkk+MDoY2P/7X0FZnVMhj
 LYSnFfZ61MAj/4HHy+DVkIYBDoxS0ck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250119



On 07.08.26 12:19, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
> 
> Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
> zcrypt_msgtype50_receive() to validate reply lengths more carefully
> before copying data back into the request buffer. Use size_t for
> length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
>   drivers/s390/crypto/zcrypt_msgtype6.c  | 149 ++++++++++++++++---------
>   2 files changed, 124 insertions(+), 64 deletions(-)
[ snip ]

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
