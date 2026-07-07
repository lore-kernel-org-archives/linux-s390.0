Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484B42B33A
	for <linux-s390@vger.kernel.org>; Tue,  7 Jul 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435108; cv=none; b=ZCTr4PZZykaP8BS0xwKDgYNfuThbx5+p9cm0mw0Vqhva3fFKgu/iM9OGQkcHNxR3QsDA0aA4EnK1f3Bq//YGYkGymEpWP98F14xEbFIL3gW5zrc/4xLtArHePwX5NvFefkR/yX7xi0QmHTep2Zqpx6G3IC+wCsE3SBAnv44uY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435108; c=relaxed/simple;
	bh=5Ce71SmRIA83Sz0k9oQWMYsHEW/f937Rcb3DRKURTG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rahafJ4OfLNLSv0uBJGTa5mWZSPp7vUWFOzDvgwGILNeT3dfikJanaOY/Covbg3y7Eyt3QsnWkCxhWjvYQ8tvtKrZ9y3NrZK9EhOy+gSnH5ZlvUgu9yvUzkOqWG3UNOyewHQCtHjI+OW9VAEW51m6BKxv7ueK6FsM6MsIJbyNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NdbhRFcy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NdbhRFcy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667CJ6ou3936657;
	Tue, 7 Jul 2026 14:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QOc48c
	MVZ8u07W2jPzWOupI0sDsmb+vwI1hW2tIXzhE=; b=NdbhRFcyQl/c+QzoyMXloI
	l+i2O+NJgfNI2GoPr6/ElM3s/2woedQgdMlHFQ+mkNq6WCpz67df9UbAv4HaDjoa
	0n8kC/dKePUnPeAMfqDGWVMaSnJ+K4Dxk2/TgnYcF/Sf0u2ssVJSXGab/IxZOge8
	JRNE80+oxYl8W8nnQKZiwuAJt0hAZf0bkBJmTrLcRX1/snu+97PPQLnHWzNDfzPx
	qYcNIF06C5JFt8oQ03gb57A8KLkPpO454kRZpdFB5q66f0Gfi38iOoUX7qb6jcjt
	Ps2Sb35tNqMt0R4H1bpaE4tdhlj612sKiGD1AOSf+iUSvqb1s+8/AR3T2ksCDLKg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknfhdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:38:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667EYcHX025360;
	Tue, 7 Jul 2026 14:38:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y2wuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:38:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667EcEkN53018984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 14:38:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0387C20049;
	Tue,  7 Jul 2026 14:38:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86EC320040;
	Tue,  7 Jul 2026 14:38:13 +0000 (GMT)
Received: from [9.111.13.17] (unknown [9.111.13.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 14:38:13 +0000 (GMT)
Message-ID: <310af657-1444-445d-bfd8-cd0d174298c9@linux.ibm.com>
Date: Tue, 7 Jul 2026 16:38:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/21] target/s390x: Support AES XTS for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-10-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260706094317.17032-10-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4d0f5a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=48bj3Yrzj-su2sblZwEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x4sIcs8AhYU1_Rf59gdWH9QZdyjvLhLs
X-Proofpoint-ORIG-GUID: x4sIcs8AhYU1_Rf59gdWH9QZdyjvLhLs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0MCBTYWx0ZWRfX7LAL1IsivIY3
 eUd++LUSqCCua1QViL5H72h8Vg1gcvFm6gkf1Iy20LeyIXxYZOGKmlxQFZU+Zkd+/HwoM2utukE
 nXwRPUMyn6bMhBPVTSgYK1l4JoW5D3c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0MCBTYWx0ZWRfX8XtwuCfQcy2F
 mgE4LgxwPPPg9NFX2P/3uJqVJaDppsk/Cm3Cj0vB4YZzuH7FanMMjdiafjK98OxkFKHB3Rlm+X2
 46CwIYSp7oD6oEazEiRreIloFtC1zBwoeYZn9b9nVTAZe7yD/yzhtDU+2qEs5QNjWmFY0l7Qwsx
 zq4RdS0GHRyLlsUrfjacXQNurDOdl+7RNiZgxpsHPbKEphymfmkWptj1iBI0eMuT5tsPT41//+0
 +ZyqAwqpCZ4UWTI/fIXb0e/dYNpIFH9vit6RKJXqEsOBjZNj5CJ7IxiZdnGqoCKERZcEaxxVJS/
 pp7pgBP3kbX0q/qvxL5dVTsyef4MmPvIkRgnEP8vr7k4Bbx5vTOkNaHiozkc2tvFc4tpG1vQWG2
 F6Km5zqcGRY6qOh6/zDKOfzcvwculM8BwQcc0NhMEtGG84/2jTiojqQT6/SsDkdxSILp0agIBmm
 sm+fumgDzf0eXkPAUOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070140

On 7/6/26 11:43, Harald Freudenberger wrote:
> Support the subfunctions XTS-AES-128 and XTS-AES-256
> for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

